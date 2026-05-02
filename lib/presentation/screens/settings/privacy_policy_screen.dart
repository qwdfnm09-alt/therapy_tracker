import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/clinic_contact.dart';
import '../../../core/widgets/app_page.dart';
import '../../../core/widgets/section_card.dart';
import '../../providers/app_state.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = context.watch<AppState>().languageCode == 'ar';
    final sections = isArabic ? _arabicSections() : _englishSections();

    return AppPage(
      title: isArabic ? 'سياسة الخصوصية' : 'Privacy policy',
      child: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: sections.length + 1,
        separatorBuilder: (_, _) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          if (index == 0) {
            return SectionCard(
              title: isArabic ? 'ملخص' : 'Summary',
              icon: Icons.privacy_tip_outlined,
              child: Text(
                isArabic
                    ? 'هذا التطبيق يعمل محليًا على جهازك لحساب التوافق قبل الزواج وحفظ النتائج والحجوزات الأخيرة. لا توجد خدمة حسابات أو خادم تابع للمطور داخل الكود الحالي.'
                    : 'This app works locally on your device to calculate pre-marital compatibility and save recent results and booking requests. There is no account system or developer backend in the current code.',
              ),
            );
          }

          final section = sections[index - 1];
          return SectionCard(
            title: section.title,
            icon: section.icon,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(section.body),
                if (section.bullets.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  for (final bullet in section.bullets) ...[
                    _PolicyBullet(text: bullet),
                    const SizedBox(height: 8),
                  ],
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  List<_PolicySection> _englishSections() {
    return [
      const _PolicySection(
        title: 'Data handled by the app',
        icon: Icons.storage_outlined,
        body: 'The app can store user-provided profile details, questionnaire answers, generated compatibility results, language/theme preferences, and recent counseling booking details on the device.',
        bullets: [
          'Profile details can include name, age, job, and education for both participants.',
          'Booking details can include phone number, preferred date, message text, recommendation context, and send status.',
        ],
      ),
      const _PolicySection(
        title: 'How the data is used',
        icon: Icons.psychology_alt_outlined,
        body: 'Saved data is used only to keep the assessment flow working inside the app, regenerate the latest result, show the latest booking state, and prepare the PDF report.',
      ),
      const _PolicySection(
        title: 'Sharing and external actions',
        icon: Icons.share_outlined,
        body: 'The app does not upload saved profiles or results to a developer server in the current version. If you choose to open WhatsApp, SMS, phone call, printing, or PDF sharing, the related content may leave the app through that external action that you trigger.',
      ),
      _PolicySection(
        title: 'Retention and deletion',
        icon: Icons.delete_outline,
        body: 'Data remains on the device until you clear it from inside the app. You can remove saved assessment and booking data using the clear action in Settings.',
        bullets: [
          'Current in-app contact for privacy questions: $clinicPhoneNumber',
        ],
      ),
    ];
  }

  List<_PolicySection> _arabicSections() {
    return [
      const _PolicySection(
        title: 'البيانات التي يتعامل معها التطبيق',
        icon: Icons.storage_outlined,
        body: 'قد يحفظ التطبيق على الجهاز بيانات الملفات الشخصية التي يدخلها المستخدم، وإجابات الأسئلة، ونتائج التوافق التي يتم توليدها، وتفضيلات اللغة والمظهر، وبيانات آخر طلبات الحجز.',
        bullets: [
          'قد تشمل بيانات الملف الشخصي: الاسم، العمر، الوظيفة، والتعليم للطرفين.',
          'قد تشمل بيانات الحجز: رقم الهاتف، الموعد المفضل، نص الرسالة، سبب التوصية، وحالة الإرسال.',
        ],
      ),
      const _PolicySection(
        title: 'كيفية استخدام البيانات',
        icon: Icons.psychology_alt_outlined,
        body: 'تُستخدم البيانات المحفوظة فقط لإكمال رحلة التقييم داخل التطبيق، وإظهار آخر نتيجة توافق، وإظهار حالة آخر حجز، وتجهيز تقرير PDF.',
      ),
      const _PolicySection(
        title: 'المشاركة والإجراءات الخارجية',
        icon: Icons.share_outlined,
        body: 'في النسخة الحالية لا يرفع التطبيق الملفات الشخصية أو النتائج إلى خادم تابع للمطور. إذا اخترت فتح واتساب أو الرسائل أو الاتصال أو الطباعة أو مشاركة ملف PDF، فقد تخرج البيانات من التطبيق عبر هذا الإجراء الخارجي الذي تبدأه أنت بنفسك.',
      ),
      _PolicySection(
        title: 'الاحتفاظ والحذف',
        icon: Icons.delete_outline,
        body: 'تظل البيانات على الجهاز إلى أن تقوم بمسحها من داخل التطبيق. يمكنك حذف بيانات التقييم والحجوزات المحفوظة من إعدادات التطبيق.',
        bullets: [
          'وسيلة التواصل الحالية لأسئلة الخصوصية داخل التطبيق: $clinicPhoneNumber',
        ],
      ),
    ];
  }
}

class _PolicySection {
  const _PolicySection({
    required this.title,
    required this.icon,
    required this.body,
    this.bullets = const [],
  });

  final String title;
  final IconData icon;
  final String body;
  final List<String> bullets;
}

class _PolicyBullet extends StatelessWidget {
  const _PolicyBullet({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('• '),
        Expanded(child: Text(text)),
      ],
    );
  }
}
