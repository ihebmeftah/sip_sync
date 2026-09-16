// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'Sip Sync Ops';

  @override
  String get tagline => 'الصالة والمطبخ والصندوق — دخول واحد للبيت.';

  @override
  String get atmosphereTitle => 'أدر البيت من شاشة واحدة';

  @override
  String get atmosphereBody =>
      'المالك والموظفون يشتركون في الدخول. الصلاحيات تُحسم في الخادم.';

  @override
  String get authLead => 'دخول الفريق';

  @override
  String get registerLead => 'افتح حساب مالك';

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
  String get addEmployee => 'إضافة موظف';

  @override
  String get employees => 'الفريق';

  @override
  String get staff => 'مستخدمو المكتب';

  @override
  String get addStaff => 'إضافة مستخدم مكتب';

  @override
  String get adminFlag => 'مسؤول';

  @override
  String get defaultAdminFlag => 'افتراضي';

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
  String get opsRailTagline => 'قيادة الصالة';

  @override
  String get navDashboard => 'لوحة التحكم';

  @override
  String get navProfile => 'الملف الشخصي';

  @override
  String get navProducts => 'المنتجات';

  @override
  String get navArticles => 'الأصناف';

  @override
  String get navIngredients => 'المكوّنات';

  @override
  String get navPos => 'نقطة البيع';

  @override
  String get navTables => 'الطاولات';

  @override
  String helloScreen(String screen) {
    return 'مرحباً، $screen';
  }

  @override
  String get placeholderBody => 'هذه الشاشة غير متصلة بالخادم بعد.';

  @override
  String get saveProfile => 'حفظ الملف';

  @override
  String get profileSaved => 'تم تحديث الملف.';

  @override
  String get myProfile => 'ملفك';

  @override
  String get teamProfiles => 'الفريق المضاف';

  @override
  String get viewProfile => 'عرض';

  @override
  String get employeeProfile => 'ملف الموظف';

  @override
  String get themeLight => 'مظهر فاتح';

  @override
  String get themeDark => 'مظهر داكن';

  @override
  String get dashboardEyebrow => 'البيت الليلة';

  @override
  String get dashboardSubtitle =>
      'نقطة البيع والصالة والكتالوج بضغطة. الأرقام الحية تأتي مع الخادم لاحقاً.';

  @override
  String get dashboardShift => 'لوحة الوردية';

  @override
  String get dashboardPosCue => 'الصندوق والتذاكر — قريباً.';

  @override
  String get dashboardTablesCue => 'خريطة الصالة دون خادم بعد.';

  @override
  String get dashboardCatalogCue => 'أصناف ومكوّنات، واجهة فقط.';

  @override
  String get dashboardProfileCue => 'بياناتك والفريق الذي أضفته.';

  @override
  String get emailLocked => 'البريد مرتبط بتسجيل الدخول ولا يُغيَّر هنا.';

  @override
  String get profileHint =>
      'حدّث الاسم الظاهر في الصالة. يمكن للمالك فتح ملفات الفريق أدناه.';
}
