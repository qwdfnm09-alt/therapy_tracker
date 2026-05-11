import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;
import '../models/reminder_entry.dart';

class ReminderNotificationsService {
  const ReminderNotificationsService();

  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) return;

    tz_data.initializeTimeZones();
    final timezoneInfo = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timezoneInfo.identifier));

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const darwinSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      defaultPresentAlert: true,
      defaultPresentBadge: true,
      defaultPresentBanner: true,
      defaultPresentList: true,
      defaultPresentSound: true,
    );

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: darwinSettings,
      macOS: darwinSettings,
    );

    await _plugin.initialize(settings: settings);
    _isInitialized = true;
  }

  Future<bool> requestPermissions() async {
    await initialize();

    var granted = true;
    if (Platform.isAndroid) {
      final androidImplementation = _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      final alreadyEnabled =
          await androidImplementation?.areNotificationsEnabled() ?? true;
      final requested = await androidImplementation
          ?.requestNotificationsPermission();
      granted = requested ?? alreadyEnabled;
    }

    if (Platform.isIOS) {
      final iosImplementation = _plugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >();
      granted =
          await iosImplementation?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          ) ??
          true;
    }

    return granted;
  }

  Future<void> scheduleReminder(ReminderEntry entry) async {
    await initialize();
    if (entry.notificationId == null ||
        entry.scheduleType == null ||
        entry.scheduledHour == null ||
        entry.scheduledMinute == null) {
      return;
    }

    final scheduledDate = _nextScheduledDate(entry);
    final notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'reminders_center_channel',
        'Reminders Center',
        channelDescription: 'Scheduled family reminder plans',
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: const DarwinNotificationDetails(),
    );

    await _plugin.zonedSchedule(
      id: entry.notificationId!,
      title: entry.title,
      body: entry.note.trim().isEmpty ? entry.scheduleLabel : entry.note.trim(),
      scheduledDate: scheduledDate,
      notificationDetails: notificationDetails,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: entry.scheduleType == 'weekly'
          ? DateTimeComponents.dayOfWeekAndTime
          : DateTimeComponents.time,
    );
  }

  Future<void> cancelReminder(int notificationId) async {
    await initialize();
    await _plugin.cancel(id: notificationId);
  }

  tz.TZDateTime _nextScheduledDate(ReminderEntry entry) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      entry.scheduledHour!,
      entry.scheduledMinute!,
    );

    if (entry.scheduleType == 'weekly' && entry.scheduledWeekday != null) {
      while (scheduledDate.weekday != entry.scheduledWeekday ||
          !scheduledDate.isAfter(now)) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }
      return scheduledDate;
    }

    if (!scheduledDate.isAfter(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}
