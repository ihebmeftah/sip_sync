// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'Sip Sync Console';

  @override
  String get tagline => 'المشغّلون والمستأجرون ومسؤول المنصة.';

  @override
  String get atmosphereTitle => 'ابقِ المنصة نزيهة';

  @override
  String get atmosphereBody =>
      'مسؤولون فائقون ومشغّلون. الصلاحيات لا تعيش في العميل.';

  @override
  String get authLead => 'دخول لوحة التحكم';

  @override
  String get registerLead => 'اطلب وصولاً للوحة';

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
  String get errorAccountDisabled => 'هذا الحساب معطّل.';

  @override
  String get errorCannotDisableDefaultAdmin =>
      'لا يمكن تعطيل حساب المسؤول الافتراضي.';

  @override
  String get errorCannotDisableSelf => 'لا يمكنك تعطيل حسابك.';

  @override
  String get navUsers => 'المستخدمون';

  @override
  String get navBuildings => 'المباني';

  @override
  String get usersTitle => 'المستخدمون';

  @override
  String get usersSubtitle =>
      'حسابات المكتب التي يمكنها الدخول إلى هذه اللوحة.';

  @override
  String get buildingsTitle => 'المباني';

  @override
  String get buildingsSubtitle =>
      'كل الأماكن على المنصة مع المالك وبيانات التواصل.';

  @override
  String get createUser => 'إنشاء مستخدم';

  @override
  String get editUser => 'تحديث المستخدم';

  @override
  String get save => 'حفظ';

  @override
  String get cancel => 'إلغاء';

  @override
  String get close => 'إغلاق';

  @override
  String get enabled => 'مفعّل';

  @override
  String get disabled => 'معطّل';

  @override
  String get status => 'الحالة';

  @override
  String get owner => 'المالك';

  @override
  String get contact => 'التواصل';

  @override
  String get buildingType => 'النوع';

  @override
  String get address => 'العنوان';

  @override
  String get location => 'الموقع';

  @override
  String get currency => 'العملة';

  @override
  String get country => 'البلد';

  @override
  String coordinates(String lat, String lng) {
    return '$lat، $lng';
  }

  @override
  String get passwordOptional => 'كلمة مرور جديدة (اختياري)';

  @override
  String get deleteUser => 'حذف المستخدم';

  @override
  String deleteUserConfirm(String name) {
    return 'حذف $name؟ سيفقد الوصول إلى اللوحة.';
  }

  @override
  String get viewDetails => 'التفاصيل';

  @override
  String get enabledLockedDefault => 'يبقى المسؤول الافتراضي مفعّلاً.';

  @override
  String get enabledLockedSelf => 'لا يمكنك تعطيل الحساب الذي تستخدمه.';
}
