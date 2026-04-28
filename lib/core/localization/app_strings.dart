import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../presentation/providers/app_state.dart';

class AppStrings {
  static const _values = <String, Map<String, String>>{
    'en': {
      'appName': 'PreMarital Match',
      'tagline': 'Marriage compatibility and family counseling',
      'startAssessment': 'Start assessment',
      'continueAssessment': 'Continue assessment',
      'settings': 'Settings',
      'welcomeTitle': 'Build a clearer marriage decision',
      'welcomeBody':
          'Evaluate personality, emotions, lifestyle, expectations, and family boundaries before marriage.',
      'userA': 'User A',
      'userB': 'User B',
      'name': 'Name',
      'age': 'Age',
      'job': 'Job',
      'education': 'Education',
      'next': 'Next',
      'saveContinue': 'Save and continue',
      'personalityTest': 'Personality test',
      'result': 'Compatibility result',
      'compatibility': 'Compatibility',
      'readiness': 'Marriage readiness',
      'strengths': 'Strength areas',
      'risks': 'Risk areas',
      'notes': 'Psychological notes',
      'sessions': 'Suggested counseling sessions',
      'bookConsultation': 'Book family consultation',
      'individualTherapy': 'Book individual therapy',
      'coaching': 'Pre-marriage coaching',
      'booking': 'Counseling booking',
      'preferredDate': 'Preferred date',
      'phone': 'Phone number',
      'message': 'Message',
      'confirmBooking': 'Confirm booking',
      'bookingSaved': 'Booking request saved locally',
      'appearance': 'Appearance',
      'language': 'Language',
      'light': 'Light',
      'dark': 'Dark',
      'system': 'System',
      'english': 'English',
      'arabic': 'Arabic',
      'clearData': 'Clear saved assessment',
      'calculate': 'Calculate compatibility',
      'completeProfiles': 'Complete both profiles first',
      'localOnly': 'Local prototype. Firebase can be connected later.',
    },
    'ar': {
      'appName': 'PreMarital Match',
      'tagline': 'توافق الزواج والاستشارات الأسرية',
      'startAssessment': 'ابدأ التقييم',
      'continueAssessment': 'استكمال التقييم',
      'settings': 'الإعدادات',
      'welcomeTitle': 'اتخذ قرار زواج أوضح',
      'welcomeBody':
          'قيّم الشخصية والمشاعر ونمط الحياة والتوقعات والحدود الأسرية قبل الزواج.',
      'userA': 'الشخص الأول',
      'userB': 'الشخص الثاني',
      'name': 'الاسم',
      'age': 'العمر',
      'job': 'الوظيفة',
      'education': 'التعليم',
      'next': 'التالي',
      'saveContinue': 'حفظ ومتابعة',
      'personalityTest': 'اختبار الشخصية',
      'result': 'نتيجة التوافق',
      'compatibility': 'التوافق',
      'readiness': 'جاهزية الزواج',
      'strengths': 'نقاط القوة',
      'risks': 'مناطق الخطر',
      'notes': 'ملاحظات نفسية',
      'sessions': 'جلسات مقترحة',
      'bookConsultation': 'حجز استشارة أسرية',
      'individualTherapy': 'حجز علاج فردي',
      'coaching': 'جلسات تأهيل قبل الزواج',
      'booking': 'حجز استشارة',
      'preferredDate': 'الموعد المفضل',
      'phone': 'رقم الهاتف',
      'message': 'رسالة',
      'confirmBooking': 'تأكيد الحجز',
      'bookingSaved': 'تم حفظ طلب الحجز محلياً',
      'appearance': 'المظهر',
      'language': 'اللغة',
      'light': 'فاتح',
      'dark': 'داكن',
      'system': 'النظام',
      'english': 'English',
      'arabic': 'العربية',
      'clearData': 'مسح التقييم المحفوظ',
      'calculate': 'حساب التوافق',
      'completeProfiles': 'أكمل بيانات الشخصين أولاً',
      'localOnly': 'نموذج محلي. يمكن ربط Firebase لاحقاً.',
    },
  };

  static String of(BuildContext context, String key) {
    final languageCode = context.watch<AppState>().languageCode;
    return _values[languageCode]?[key] ?? _values['en']?[key] ?? key;
  }
}

extension AppStringsContext on BuildContext {
  String tr(String key) => AppStrings.of(this, key);
}
