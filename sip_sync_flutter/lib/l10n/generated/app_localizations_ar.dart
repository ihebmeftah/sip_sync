// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'Sip Sync';

  @override
  String get tagline => 'طاولات ونكهات ومقعد يعرف اسمك.';

  @override
  String get atmosphereTitle => 'مقعد يعرف اسمك';

  @override
  String get atmosphereBody => 'ادخل واطلب واستلم — المكان يعرف طاولتك مسبقاً.';

  @override
  String get authLead => 'مرحباً بعودتك';

  @override
  String get registerLead => 'أنشئ مقعدك';

  @override
  String get showPassword => 'إظهار كلمة المرور';

  @override
  String get hidePassword => 'إخفاء كلمة المرور';

  @override
  String get signIn => 'تسجيل الدخول';

  @override
  String get register => 'إنشاء حساب';

  @override
  String get signOut => 'تسجيل الخروج';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get username => 'اسم المستخدم';

  @override
  String get phone => 'رقم الهاتف';

  @override
  String get firstName => 'الاسم';

  @override
  String get lastName => 'اللقب';

  @override
  String get noAccount => 'جديد هنا؟ سجّل';

  @override
  String get hasAccount => 'لديك حساب؟ ادخل';

  @override
  String welcome(String name) {
    return 'مرحباً، $name';
  }

  @override
  String get rolesLabel => 'أدوارك';

  @override
  String get homeHint => 'نفس البريد يعمل إن أصبحت مالكاً أو موظفاً لاحقاً.';

  @override
  String get loading => 'جارٍ التحميل';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get empty => 'لا شيء بعد';

  @override
  String get language => 'اللغة';

  @override
  String get errorGeneric => 'حدث خطأ. حاول مجدداً.';

  @override
  String get errorInvalidInput => 'تحقق من النموذج وحاول مجدداً.';

  @override
  String get errorEmailTaken => 'هذا البريد مستخدم بكلمة مرور مختلفة.';

  @override
  String get errorUsernameTaken => 'اسم المستخدم محجوز.';

  @override
  String get errorPhoneTaken => 'رقم الهاتف محجوز.';

  @override
  String get errorInvalidCredentials => 'البريد أو كلمة المرور غير صحيحة.';

  @override
  String get errorAppAccessDenied =>
      'هذا الحساب لا يمكنه استخدام هذا التطبيق بعد.';

  @override
  String get errorNotAuthorized => 'ليست لديك صلاحية.';

  @override
  String get errorNotFound => 'غير موجود.';

  @override
  String get errorCannotDeleteDefaultAdmin =>
      'لا يمكن حذف حساب المسؤول الافتراضي.';

  @override
  String get errorPasswordTooWeak =>
      'ثماني أحرف على الأقل دون مسافات في الأطراف.';

  @override
  String get errorProfileIncomplete => 'أكمل التسجيل باسم المستخدم والهاتف.';

  @override
  String get onboardingSkip => 'تخطّي';

  @override
  String get onboardingNext => 'التالي';

  @override
  String get onboardingStart => 'ابدأ';

  @override
  String get onboardingFindTitle => 'اعثر على مكان قريب';

  @override
  String get onboardingFindBody =>
      'مقاهٍ ومطاعم وصالات حولك، مع المسافة إلى كل واحد.';

  @override
  String get onboardingPlaceTitle => 'حدّد مكانك';

  @override
  String get onboardingPlaceBody =>
      'اكتب عنواناً أو استخدم موقعك الحالي. نستخدمه فقط لترتيب الأماكن.';

  @override
  String get onboardingWalkTitle => 'شاهد المسافة سيراً';

  @override
  String get onboardingWalkBody =>
      'المسافة بالكيلومتر ووقت سير تقريبي، أو افتح الخريطة.';

  @override
  String get discoverLead => 'أماكن بالقرب منك';

  @override
  String get placeHint => 'العنوان أو الحي';

  @override
  String get useMyLocation => 'استخدم موقعي';

  @override
  String get currentPosition => 'موقعي الحالي';

  @override
  String get listMode => 'قائمة';

  @override
  String get mapMode => 'خريطة';

  @override
  String get nearbyFilter => 'بالقرب · 15 كم';

  @override
  String get allVenues => 'كل الأماكن';

  @override
  String get nearbyEmpty => 'لا شيء ضمن 15 كم. اعرض كل الأماكن.';

  @override
  String get showAllVenues => 'عرض الكل';

  @override
  String get setPlacePrompt => 'أضف عنوانك أو موقعك لترى المسافة ووقت السير.';

  @override
  String walkAway(int minutes) {
    return 'حوالي $minutes د سيراً';
  }

  @override
  String distanceKm(String distance) {
    return '$distance كم';
  }

  @override
  String hoursRange(String open, String close) {
    return '$open–$close';
  }

  @override
  String get errorPlaceLookup => 'تعذّر العثور على هذا العنوان.';

  @override
  String get errorLocationDenied =>
      'إذن الموقع مغلق. اكتب عنواناً بدلاً من ذلك.';

  @override
  String get errorLocationDisabled => 'خدمات الموقع متوقفة.';

  @override
  String get errorLocationFailed => 'تعذّر قراءة موقعك.';

  @override
  String get osmAttribution => '© مساهمو OpenStreetMap';

  @override
  String get noVenues => 'لا أماكن بعد.';

  @override
  String get validationRequired => 'هذا الحقل مطلوب.';

  @override
  String get validationEmail => 'أدخل بريداً صالحاً.';

  @override
  String get validationPassword =>
      'استخدم 8 أحرف على الأقل دون مسافات في البداية أو النهاية.';

  @override
  String get validationPhone => 'أدخل رقم هاتف مع رمز الدولة، مثل +216…';

  @override
  String get validationPhoneCountry =>
      'رمز الدولة غير مدعوم. اختر رمزاً مدعوماً.';

  @override
  String get phoneCountryCode => 'الرمز';

  @override
  String phoneCountryHint(String code) {
    return 'الدولة: $code';
  }
}
