import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import '../../firebase_options.dart';
import 'firebase_environment.dart';

class FirebaseBootstrap {
  const FirebaseBootstrap._();

  static Future<void> initialize() async {
    if (!FirebaseEnvironment.enabled) return;
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) return;

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    if (!FirebaseEnvironment.enableAppCheck) return;

    await FirebaseAppCheck.instance.activate();
  }
}
