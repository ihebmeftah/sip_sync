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
  String get navStats => 'الإحصاءات';

  @override
  String get navUsers => 'المستخدمون';

  @override
  String get navCustomers => 'العملاء';

  @override
  String get navBuildings => 'المباني';

  @override
  String get navPacks => 'الباقات';

  @override
  String get navSection => 'المنصة';

  @override
  String get statsTitle => 'الإحصاءات';

  @override
  String get customersTitle => 'العملاء';

  @override
  String get customersSubtitle => 'المالكون والعملاء على المنصة.';

  @override
  String get tabOwners => 'المالكون';

  @override
  String get tabCustomers => 'العملاء';

  @override
  String get createdAt => 'تاريخ الإنشاء';

  @override
  String accountCreated(String when) {
    return 'أُنشئ في $when';
  }

  @override
  String get packsTitle => 'الباقات';

  @override
  String get screenWorking => 'هذه الشاشة تعمل.';

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

  @override
  String get packsSubtitle =>
      'الباقات العامة تظهر في التطبيقات ليتمكن المالك من الترقية. الباقات الخاصة تُمنح لمالكين محددين.';

  @override
  String get createPack => 'إنشاء باقة';

  @override
  String get editPack => 'تحديث الباقة';

  @override
  String get packCode => 'الرمز';

  @override
  String get packName => 'الاسم';

  @override
  String get packMonthly => 'السعر الشهري (د.ت)';

  @override
  String get packAnnual => 'السعر السنوي (د.ت)';

  @override
  String get packAnnualHint => 'اترك السعر السنوي فارغًا لعرض الشهري فقط.';

  @override
  String get packFee => 'رسوم تطبيق الزبون (%)';

  @override
  String get packFeeHint =>
      'تُحسب على طلبات تطبيق الزبون. تذاكر الموظفين تبقى 0٪.';

  @override
  String get packPublic => 'عامة';

  @override
  String get packPrivate => 'خاصة';

  @override
  String get packPublicHint =>
      'يرى المالكون هذه الباقة في التطبيقات ويمكنهم الترقية إليها.';

  @override
  String get packPrivateHint => 'هذه الباقة لا تظهر في التطبيقات.';

  @override
  String get packEnabled => 'مفعّلة';

  @override
  String get packEnabledHint =>
      'الباقة المعطّلة تبقى خارج القائمة العامة. الأماكن التي تستخدمها تُبقيها.';

  @override
  String get packSortOrder => 'الترتيب';

  @override
  String get packLimits => 'الحدود';

  @override
  String get packUnlimitedHint => 'اترك الحد فارغًا بلا سقف.';

  @override
  String get packCapabilities => 'الإمكانات';

  @override
  String get capMaxEmployees => 'الموظفون';

  @override
  String get capMaxEmployeesHint =>
      'عدد حسابات الموظفين التي يمكن لهذا المكان أن يملكها.';

  @override
  String get capMaxTables => 'الطاولات';

  @override
  String get capMaxTablesHint => 'عدد الطاولات التي يمكن لهذا المكان إضافتها.';

  @override
  String get capMaxCategories => 'التصنيفات';

  @override
  String get capMaxCategoriesHint =>
      'عدد تصنيفات القائمة التي يمكن لهذا المكان إضافتها.';

  @override
  String get capMaxArticles => 'الأصناف';

  @override
  String get capMaxArticlesHint =>
      'عدد الأصناف المعروضة للبيع التي يمكن لهذا المكان إضافتها.';

  @override
  String get capMaxIngredients => 'المكونات';

  @override
  String get capMaxIngredientsHint =>
      'عدد مكونات المخزون التي يمكن لهذا المكان إضافتها.';

  @override
  String get capCustomerDiscovery => 'خريطة الزبائن';

  @override
  String get capCustomerDiscoveryHint => 'يظهر المكان على خريطة الزبائن.';

  @override
  String get capTableQr => 'رمز الطاولة';

  @override
  String get capTableQrHint => 'يمكن للفريق طباعة رموز الطاولات ومسحها.';

  @override
  String get capCustomerOrdering => 'طلب الزبون';

  @override
  String get capCustomerOrderingHint =>
      'يمكن للزبون تمرير طلب من القائمة بعد مسح رمز الطاولة.';

  @override
  String get capInventory => 'المخزون والوصفات';

  @override
  String get capInventoryHint =>
      'الوصفات ومستوى المخزون وإعادة التزويد والخصم عند الطلب.';

  @override
  String get capAllowAppending => 'إضافة أصناف إلى طلب';

  @override
  String get capAllowAppendingHint =>
      'يمكن للمكان السماح بإضافة أصناف إلى طلب مفتوح.';

  @override
  String get capTableMultiOrder => 'عدة طلبات على الطاولة';

  @override
  String get capTableMultiOrderHint =>
      'يمكن للمكان السماح بأكثر من طلب مفتوح على الطاولة نفسها.';

  @override
  String get capStrictMode => 'خطوات المطبخ الصارمة';

  @override
  String get capStrictModeHint =>
      'يمكن للمكان فرض الخطوات بالترتيب: مأخوذ، جاهز، مُقدَّم، ثم مدفوع.';

  @override
  String get capCustomAccess => 'ملفات صلاحيات مخصصة';

  @override
  String get capCustomAccessHint =>
      'يمكن للمالك إضافة ملفات صلاحيات غير النادل والمدير والباريستا.';

  @override
  String packPriceMonth(String price) {
    return '$price د.ت / شهر';
  }

  @override
  String packPriceYear(String price) {
    return '$price د.ت / سنة';
  }

  @override
  String get packSystem => 'نظام';

  @override
  String get deletePack => 'حذف الباقة';

  @override
  String deletePackConfirm(String name) {
    return 'حذف $name؟';
  }

  @override
  String get errorPackCodeTaken => 'هذا الرمز مستخدم بالفعل.';

  @override
  String get errorCannotDeleteSystemPack => 'لا يمكن حذف الباقة المجانية.';

  @override
  String get errorPackInUse => 'ما زال مكان يستخدم هذه الباقة.';

  @override
  String get errorPackLimit => 'بلغت هذه الباقة حدها.';

  @override
  String get errorPackFeature => 'هذه الباقة لا تشمل ذلك.';

  @override
  String get buildingDetailTitle => 'المكان';

  @override
  String get buildingDetailSubtitle =>
      'التواصل والباقة والعائد والعدادات لهذا المكان.';

  @override
  String get buildingTabDetails => 'التفاصيل';

  @override
  String get buildingTabPack => 'الباقة';

  @override
  String get buildingTabGain => 'العائد';

  @override
  String get buildingTabStats => 'الإحصاءات';

  @override
  String get assignPack => 'تعيين باقة';

  @override
  String get quickCreatePack => 'إنشاء باقة خاصة';

  @override
  String get quickCreatePackHint =>
      'الباقة الجديدة تكون خاصة ولا تظهر في القائمة العامة.';

  @override
  String packFeeLabel(String fee) {
    return '$fee% على طلبات تطبيق الزبون';
  }

  @override
  String get packNoLimit => 'بدون حد';

  @override
  String get gainHint =>
      'سعر الباقة الشهري، إضافة إلى عمولة طلبات الزبائن. تذاكر الموظفين غير محسوبة.';

  @override
  String get gainMonthly => 'الاشتراك الشهري';

  @override
  String get gainFeeRate => 'عمولة تطبيق الزبون';

  @override
  String get gainCustomerOrders => 'طلبات الزبائن';

  @override
  String get gainCustomerSales => 'مبيعات تطبيق الزبون';

  @override
  String get gainFeeEarned => 'العمولة المحصّلة';

  @override
  String get statCategories => 'التصنيفات';

  @override
  String get statArticles => 'المواد';

  @override
  String get statTables => 'الطاولات';

  @override
  String get statOrders => 'الطلبات';

  @override
  String get statsSubtitle =>
      'الأشخاص والأماكن والطلبات، ومن على كل باقة عامة.';

  @override
  String get statOwners => 'المالكون';

  @override
  String get statCustomers => 'الزبائن';

  @override
  String get statVenues => 'الأماكن';

  @override
  String get statEmployees => 'الموظفون';

  @override
  String get statSubscription => 'الاشتراكات الشهرية';

  @override
  String get publicPacksTitle => 'الباقات العامة';

  @override
  String get publicPacksSubtitle =>
      'الأماكن والمالكون الموجودون حالياً على كل باقة عامة.';

  @override
  String get validationRequired => 'هذا الحقل مطلوب.';

  @override
  String get validationEmail => 'أدخل بريداً إلكترونياً صالحاً.';

  @override
  String get validationPassword =>
      '8 أحرف على الأقل، بدون مسافة في البداية أو النهاية.';

  @override
  String get validationPhone => 'أدخل رقماً مع رمز البلد، مثل ‎+216…';

  @override
  String get validationPackCode => 'ابدأ بحرف، ثم أحرف أو أرقام أو _.';

  @override
  String get validationPackMoney => 'أدخل سعراً بالدينار، حتى 3 أرقام عشرية.';

  @override
  String get validationPackFee => 'أدخل نسبة بين 0 و 100.';

  @override
  String get validationPackSort => 'أدخل عدداً صحيحاً.';

  @override
  String get validationPackLimit => 'أدخل رقماً، أو اتركه فارغاً بلا حد.';
}
