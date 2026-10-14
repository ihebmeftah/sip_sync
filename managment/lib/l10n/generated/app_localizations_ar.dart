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
  String get loginAsOwner => 'المالك';

  @override
  String get loginAsEmployee => 'موظف';

  @override
  String get register => 'إنشاء حساب';

  @override
  String get signOut => 'تسجيل الخروج';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get notificationsReady => 'لا جديد الآن.';

  @override
  String get notificationThisMonth => 'هذا الشهر';

  @override
  String get notificationUnreadOnly => 'غير المقروء';

  @override
  String get notificationMarkAllRead => 'تعليم الكل كمقروء';

  @override
  String get notificationMarkRead => 'تعليم كمقروء';

  @override
  String get notificationViewAll => 'عرض الكل';

  @override
  String get notificationReservationAccepted => 'تم قبول حجز';

  @override
  String get notificationReservationCancelled => 'تم إلغاء حجز';

  @override
  String notificationReservationRequested(String venue) {
    return 'طلب زبون حجزاً في $venue';
  }

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get loginIdentifier => 'البريد أو اسم المستخدم';

  @override
  String get loginIdentifierHint =>
      'المالك يستخدم البريد. الموظفون يستخدمون اسم المستخدم.';

  @override
  String get password => 'كلمة المرور';

  @override
  String get username => 'اسم المستخدم';

  @override
  String get usernameLocked => 'اسم المستخدم يُعيَّن تلقائياً ولا يمكن تغييره.';

  @override
  String get employeeUsernameHint => 'يُنشأ اسم المستخدم من الاسم بعد الحفظ.';

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
  String get errorCannotReachServer =>
      'تعذّر الوصول إلى الخادم. على جهاز حقيقي شغّل التطبيق بـ --dart-define=SERVER_URL=http://IP_جهازك:8080 (نفس شبكة الواي فاي).';

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
  String get errorAccountDisabled => 'حساب الموظف معطّل.';

  @override
  String get errorInvalidResetCode => 'رمز إعادة التعيين غير صالح.';

  @override
  String get errorResetCodeExpired =>
      'انتهت صلاحية رمز إعادة التعيين. اطلب رمزاً جديداً.';

  @override
  String get forgotPassword => 'نسيت كلمة المرور؟';

  @override
  String get forgotPasswordTitle => 'إعادة تعيين كلمة المرور';

  @override
  String get forgotPasswordHint => 'أدخل بريد المالك. سنرسل رمز إعادة التعيين.';

  @override
  String get forgotPasswordCodeHint => 'أدخل الرمز واختر كلمة مرور جديدة.';

  @override
  String get forgotPasswordEmployeeHint =>
      'اطلب من مديرك إعادة تعيين كلمة مرور الموظف.';

  @override
  String forgotPasswordDevCode(String code) {
    return 'رمز التطوير: $code';
  }

  @override
  String get sendResetCode => 'إرسال رمز إعادة التعيين';

  @override
  String get resetCode => 'رمز إعادة التعيين';

  @override
  String get resetPassword => 'إعادة تعيين كلمة المرور';

  @override
  String get passwordResetDone =>
      'تم تحديث كلمة المرور. سجّل الدخول بكلمة المرور الجديدة.';

  @override
  String get backToSignIn => 'العودة لتسجيل الدخول';

  @override
  String get changePassword => 'تغيير كلمة المرور';

  @override
  String get changePasswordHint => 'سيتم تسجيل الخروج من الأجهزة الأخرى.';

  @override
  String get currentPassword => 'كلمة المرور الحالية';

  @override
  String get newPassword => 'كلمة المرور الجديدة';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get updatePassword => 'تحديث كلمة المرور';

  @override
  String get passwordChanged => 'تم تحديث كلمة المرور.';

  @override
  String get validationPasswordMatch => 'كلمتا المرور غير متطابقتين.';

  @override
  String get validationResetCode => 'أدخل رمز إعادة التعيين.';

  @override
  String get navEmployees => 'الموظفون';

  @override
  String get editEmployee => 'تعديل الموظف';

  @override
  String get saveEmployee => 'حفظ الموظف';

  @override
  String get employeesOwnerOnly => 'المالك فقط يدير الفريق.';

  @override
  String get accountEnabled => 'الحساب مفعّل';

  @override
  String get accountDisabled => 'الحساب معطّل';

  @override
  String get accountEnabledHint => 'يمكن لهذا الشخص الدخول إلى التشغيل.';

  @override
  String get accountDisabledHint => 'لا يمكن لهذا الشخص الدخول إلى التشغيل.';

  @override
  String get dashboardEmployeesCue =>
      'أضف الفريق وعدّل بياناته وفعّل أو عطّل الدخول.';

  @override
  String get opsRailTagline => 'قيادة الصالة';

  @override
  String get navDashboard => 'لوحة التحكم';

  @override
  String get navScanTable => 'مسح';

  @override
  String get navProfile => 'الملف الشخصي';

  @override
  String get navProducts => 'المنتجات';

  @override
  String get navCategories => 'الفئات';

  @override
  String get navArticles => 'الأصناف';

  @override
  String get navIngredients => 'المكوّنات';

  @override
  String get navPos => 'نقطة البيع';

  @override
  String get navOrders => 'الطلبات';

  @override
  String get navTables => 'الطاولات';

  @override
  String get navConfiguration => 'الإعدادات';

  @override
  String get configurationTitle => 'إعدادات المكان';

  @override
  String get configurationHint => 'هذه المفاتيح تخص هذا المكان فقط.';

  @override
  String get configurationSaved => 'تم حفظ الإعدادات.';

  @override
  String get saveConfiguration => 'حفظ الإعدادات';

  @override
  String get buildingCustomerOrdering => 'طلبات الزبائن';

  @override
  String get buildingCustomerOrderingHint =>
      'عند التفعيل يمكن للزبائن الطلب من التطبيق. يجب أن تشمل الباقة طلبات الزبائن.';

  @override
  String get buildingReservations => 'الحجوزات';

  @override
  String get buildingReservationsHint =>
      'عند التفعيل يمكن إنشاء الحجوزات. يجب أن تشمل الباقة الحجوزات.';

  @override
  String get buildingAllowOutOfStockOrders => 'السماح بالطلب عند نفاد مكوّن';

  @override
  String get buildingAllowOutOfStockOrdersHint =>
      'عند التفعيل يمكن تمرير الطلب حتى لو لم يكف مخزون مكوّن لطبق واحد إضافي. عند الإيقاف يُرفض الطلب ويُعطّل الإضافة في تطبيق الزبون.';

  @override
  String orderIngredientOutOfStock(String names) {
    return 'نفد المخزون: $names';
  }

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
      'طلبات اليوم والحجوزات والمخزون الذي يحتاج إعادة تعبئة.';

  @override
  String get dashboardToday => 'اليوم';

  @override
  String get dashboardCurrentDay => 'اليوم الحالي';

  @override
  String get dashboardRangeStart => 'البداية';

  @override
  String get dashboardRangeEnd => 'النهاية';

  @override
  String get dashboardOrderTotal => 'الطلبات';

  @override
  String get dashboardOrdersByStatus => 'الطلبات حسب الحالة';

  @override
  String get dashboardCustomerOrders => 'تطبيق الزبون';

  @override
  String get dashboardItemsByStatus => 'بنود الطلب حسب الحالة';

  @override
  String get dashboardPendingReservations => 'طلبات الحجز المعلقة';

  @override
  String get dashboardReservationsToday => 'حجوزات اليوم';

  @override
  String get dashboardRestock => 'تحتاج إعادة تخزين';

  @override
  String get dashboardRestockHint => 'أقل من 10٪ من المخزون الكامل';

  @override
  String get dashboardHouse => 'الحجوزات والمخزون';

  @override
  String get dashboardShift => 'لوحة الوردية';

  @override
  String get dashboardPosCue => 'الصندوق والتذاكر — قريباً.';

  @override
  String get dashboardTablesCue =>
      'مخطط القاعة مع معاينات المقاعد وتصفية الحالة.';

  @override
  String get dashboardCatalogCue => 'فئات وأصناف لهذا المكان.';

  @override
  String get dashboardProfileCue => 'اسمك والهاتف.';

  @override
  String get emailLocked => 'البريد مرتبط بتسجيل الدخول ولا يُغيَّر هنا.';

  @override
  String get profileHint =>
      'حدّث الاسم الظاهر في الصالة. هوية تسجيل الدخول تبقى مقفلة.';

  @override
  String get yourAccess => 'صلاحياتك';

  @override
  String get profileAccessHint =>
      'هذه الإجراءات التي يسمح بها ملفك في هذا المكان.';

  @override
  String get accessFlagsNone => 'هذا الملف لا يمنح أي إجراء.';

  @override
  String get navBuildings => 'المباني';

  @override
  String get addBuilding => 'إضافة مبنى';

  @override
  String get editBuilding => 'تعديل المبنى';

  @override
  String get saveBuilding => 'حفظ المبنى';

  @override
  String get buildingName => 'اسم المكان';

  @override
  String get buildingType => 'نوع المكان';

  @override
  String get buildingTypeRestaurant => 'مطعم';

  @override
  String get buildingTypeLounge => 'لاونج';

  @override
  String get buildingTypeBar => 'بار';

  @override
  String get buildingTypeCafe => 'مقهى';

  @override
  String get buildingTypeOther => 'آخر';

  @override
  String get buildingTypeCustom => 'نوع مخصص';

  @override
  String get buildingAddress => 'العنوان';

  @override
  String get latitude => 'خط العرض';

  @override
  String get longitude => 'خط الطول';

  @override
  String get openingTime => 'يفتح';

  @override
  String get closingTime => 'يغلق';

  @override
  String get currencyCode => 'العملة';

  @override
  String get buildingTableMultiOrder => 'طلبات متعددة لكل طاولة';

  @override
  String get buildingTableMultiOrderHint =>
      'عند التفعيل يمكن فتح طلب آخر على طاولة لديها طلب مفتوح. عند الإيقاف يجب دفع أو إلغاء الطلب الحالي أولاً.';

  @override
  String get buildingAllowAppendingItems =>
      'السماح بإضافة أصناف للطلبات المفتوحة';

  @override
  String get buildingAllowAppendingItemsHint =>
      'عند التفعيل يمكن إضافة أصناف لطلب مفتوح. عند الإيقاف يكون زر إضافة الأصناف معطّلاً.';

  @override
  String get buildingStrictMode => 'مسار حالات صارم';

  @override
  String get buildingStrictModeHint =>
      'عند التفعيل يمرّ كل بند بالخطوات المفعّلة بالترتيب. عند الإيقاف يمكن تعليم الدفع مباشرة دون الخطوات السابقة.';

  @override
  String get buildingStrictModeStepsTitle => 'خطوات المسار';

  @override
  String get buildingStrictModeStepsHint =>
      'فعّل أو عطّل الخطوات فقط. الترتيب ثابت ولا يمكن تغييره.';

  @override
  String buildingStrictModeStepRank(int rank) {
    return 'الخطوة $rank';
  }

  @override
  String get buildingStaff => 'فريق هذا المكان';

  @override
  String get buildingStaffEmpty => 'لا يوجد موظفون بعد. أضفهم بعد حفظ المكان.';

  @override
  String get buildingsOwnerHint =>
      'أنشئ مكاناً ثم افتحه لإدارة الصالة. باقي الأدوات تبقى مقفلة حتى تختار واحداً.';

  @override
  String get buildingsStaffHint => 'اختر مكاناً مُعيَّناً لك.';

  @override
  String get buildingsEmptyOwner =>
      'أضف أول مقهى أو مطعم أو لاونج أو بار للمتابعة.';

  @override
  String get employeesEmptyBuilding =>
      'لا يوجد موظفون معيّنون لهذا المكان بعد.';

  @override
  String dashboardBuildingMeta(
    String type,
    String address,
    String opens,
    String closes,
    String currency,
  ) {
    return '$type · $address · $opens–$closes · $currency';
  }

  @override
  String get validationRequired => 'هذا الحقل مطلوب.';

  @override
  String get validationLoginIdentifier =>
      'أدخل بريداً أو اسم مستخدم (3 أحرف على الأقل).';

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
  String get validationSocialLink => 'أدخل معرّفاً أو رابطاً أقصر.';

  @override
  String get validationOtherLink =>
      'يجب أن تكون الروابط الأخرى عناوين http(s).';

  @override
  String get phoneCountryCode => 'الرمز';

  @override
  String phoneCountryHint(String code) {
    return 'الدولة: $code';
  }

  @override
  String get buildingPhone => 'هاتف المكان';

  @override
  String get buildingWhatsapp => 'واتساب';

  @override
  String get buildingInstagram => 'إنستغرام';

  @override
  String get buildingFacebook => 'فيسبوك';

  @override
  String get buildingOtherLinks => 'روابط أخرى';

  @override
  String get buildingOtherLinksHint => 'رابط http(s) في كل سطر.';

  @override
  String get buildingSocialHint => 'معرّف أو رابط كامل.';

  @override
  String get buildingCountry => 'الدولة';

  @override
  String get validationVenueName => 'يجب أن يكون الاسم من 1 إلى 80 حرفاً.';

  @override
  String get validationVenueType =>
      'استخدم 2–40 حرفاً أو رقماً أو مسافة أو شرطة.';

  @override
  String get validationAddress => 'يجب أن يكون العنوان من 3 إلى 200 حرف.';

  @override
  String get validationLatitude => 'خط العرض بين ‎-90 و90.';

  @override
  String get validationLongitude => 'خط الطول بين ‎-180 و180.';

  @override
  String get validationCurrency => 'استخدم رمز عملة من 3 أحرف.';

  @override
  String get pickCurrentPosition => 'استخدم الموقع الحالي';

  @override
  String get errorLocationDenied => 'يلزم إذن الموقع لملء العنوان.';

  @override
  String get errorLocationDisabled => 'فعّل خدمات الموقع ثم أعد المحاولة.';

  @override
  String get errorLocationFailed => 'تعذر قراءة الموقع الحالي.';

  @override
  String get cancel => 'إلغاء';

  @override
  String get addTable => 'إضافة طاولة';

  @override
  String get editTable => 'تعديل الطاولة';

  @override
  String get saveTable => 'حفظ الطاولة';

  @override
  String get tablesHint =>
      'اضغط على طاولة للإجراءات: تعديل، الطلبات المفتوحة، أو إنشاء طلب.';

  @override
  String get tablesEmployeeOrderHint =>
      'اضغط على طاولة لعرض الطلبات المفتوحة أو بدء طلب جديد.';

  @override
  String get tableOpenOrderHeading => 'الطلب الحالي';

  @override
  String get tableOpenOrdersHeading => 'الطلبات الحالية';

  @override
  String get tableNoOpenOrders => 'لا يوجد طلب مفتوح على هذه الطاولة.';

  @override
  String get tablesEmptyOwner => 'أضف أول طاولة لرسم المخطط.';

  @override
  String get tablesEmpty => 'لا توجد طاولات في هذا الطابق بعد.';

  @override
  String get tablesFilterEmpty => 'لا توجد طاولات لهذا التصفية.';

  @override
  String get tableFormHint =>
      'اختر كم طاولة تريد إضافتها. تُعيَّن الأرقام تلقائياً بالترتيب.';

  @override
  String get tableEditHint =>
      'يمكنك تغيير المقاعد والتفعيل فقط. رقم الطاولة ثابت.';

  @override
  String get tableNumber => 'رقم الطاولة';

  @override
  String get tableNumberLocked => 'لا يمكن تغيير رقم الطاولة.';

  @override
  String get tableCountToAdd => 'عدد الطاولات';

  @override
  String tableNumberRange(int from, int to) {
    return 'ستُنشأ الأرقام $from–$to';
  }

  @override
  String get tableMaxSeats => 'أقصى مقاعد';

  @override
  String get tableActive => 'نشطة في القاعة';

  @override
  String get tableActiveHint =>
      'الطاولات غير النشطة تبقى في القائمة خارج المتاح.';

  @override
  String tableSeatsCount(int count) {
    return '$count مقاعد';
  }

  @override
  String get tableFilterAll => 'الكل';

  @override
  String get tableFilterInactive => 'غير نشطة';

  @override
  String get tableStatusAvailable => 'متاحة';

  @override
  String get tableStatusOccupied => 'مشغولة';

  @override
  String get tableStatusReserved => 'محجوزة';

  @override
  String get validationTableNumber => 'أدخل رقماً من 1 إلى 9999.';

  @override
  String get validationTableCount => 'أدخل عدداً من 1 إلى 100.';

  @override
  String get validationTableSeats => 'أدخل مقاعد من 1 إلى 50.';

  @override
  String get errorTableNumberTaken => 'رقم الطاولة مستخدم هنا بالفعل.';

  @override
  String get tableQrExportPdf => 'تصدير QR PDF';

  @override
  String get tableQrExportEmpty => 'أضف طاولات قبل تصدير رموز QR.';

  @override
  String get tableQrExportFailed => 'تعذر إنشاء ملف PDF للـ QR. حاول مجدداً.';

  @override
  String get tableQrScanTitle => 'مسح الطاولة';

  @override
  String get tableQrScanHint => 'وجّه الكاميرا إلى ملصق QR للطاولة لبدء الطلب.';

  @override
  String tableQrScanSuccess(int number) {
    return 'الطاولة $number جاهزة — أضف الأصناف.';
  }

  @override
  String get tableQrInvalid => 'هذا الرمز ليس ملصق طاولة Sip Sync.';

  @override
  String get tableQrWrongBuilding => 'رمز QR هذا يخص مكاناً آخر.';

  @override
  String get tableQrUnknownTable => 'لا توجد طاولة مطابقة في هذا الطابق.';

  @override
  String get optionalFieldHint => 'اختياري';

  @override
  String get noDescription => 'بدون وصف';

  @override
  String get categoriesHint =>
      'نظّم قائمة هذا المكان. يجب أن تكون الأسماء فريدة هنا.';

  @override
  String get categoriesEmptyOwner => 'أضف أول فئة ثم اربط الأصناف.';

  @override
  String get categoriesEmpty => 'لا توجد فئات في هذا المكان بعد.';

  @override
  String get addCategory => 'إضافة فئة';

  @override
  String get editCategory => 'تعديل الفئة';

  @override
  String get saveCategory => 'حفظ الفئة';

  @override
  String get categoryFormHint => 'الاسم فريد في هذا المكان. الوصف اختياري.';

  @override
  String get categoryName => 'اسم الفئة';

  @override
  String get categoryDescription => 'الوصف';

  @override
  String get validationCategoryName => 'أدخل اسماً حتى 80 حرفاً.';

  @override
  String get validationDescription => 'الوصف يجب ألا يتجاوز 500 حرف.';

  @override
  String get errorCategoryNameTaken => 'اسم الفئة مستخدم هنا بالفعل.';

  @override
  String get articlesHint => 'أصناف للبيع مع سعر وفئة. الأسماء فريدة هنا.';

  @override
  String get articlesEmptyOwner => 'أضف أول صنف بعد إنشاء فئة.';

  @override
  String get articlesEmpty => 'لا توجد أصناف في هذا المكان بعد.';

  @override
  String get articlesNeedCategory => 'أنشئ فئة قبل إضافة الأصناف.';

  @override
  String get addArticle => 'إضافة صنف';

  @override
  String get editArticle => 'تعديل الصنف';

  @override
  String get saveArticle => 'حفظ الصنف';

  @override
  String get articleFormHint => 'اختر فئة وسعراً واسماً فريداً في هذا المكان.';

  @override
  String get articleName => 'اسم الصنف';

  @override
  String get articleDescription => 'الوصف';

  @override
  String get articlePrice => 'السعر';

  @override
  String get articleCategory => 'الفئة';

  @override
  String get validationArticleName => 'أدخل اسماً حتى 80 حرفاً.';

  @override
  String get validationArticlePrice => 'أدخل سعراً أكبر من 0.';

  @override
  String get validationArticleCategory => 'اختر فئة.';

  @override
  String get errorArticleNameTaken => 'اسم الصنف مستخدم هنا بالفعل.';

  @override
  String get delete => 'حذف';

  @override
  String get ingredientsHint =>
      'تتبع المخزون حسب الوحدة. تنبيه عند وصول المخزون الحالي إلى العتبة.';

  @override
  String get ingredientsEmptyOwner => 'أضف أول مكوّن لبدء المخزون.';

  @override
  String get ingredientsEmpty => 'لا توجد مكوّنات في هذا المكان بعد.';

  @override
  String get addIngredient => 'إضافة مكوّن';

  @override
  String get deleteIngredient => 'حذف المكوّن';

  @override
  String deleteIngredientConfirm(String name) {
    return 'حذف $name؟ لا يمكن التراجع.';
  }

  @override
  String get ingredientFormHint =>
      'الاسم فريد في هذا المكان. اختر وحدة إعادة التموين.';

  @override
  String get ingredientName => 'اسم المكوّن';

  @override
  String get ingredientUnit => 'الوحدة';

  @override
  String get ingredientCurrentStock => 'المخزون الحالي';

  @override
  String get ingredientThresholdStock => 'عتبة المخزون المنخفض';

  @override
  String get ingredientThresholdHint =>
      'تنبيه عند وصول المخزون إلى هذا المستوى.';

  @override
  String ingredientStockLine(String current, String unit, String threshold) {
    return '$current $unit · العتبة $threshold';
  }

  @override
  String get ingredientRestock => 'إعادة التخزين';

  @override
  String ingredientRestockHint(String name) {
    return 'أضف الكمية الواردة لـ $name.';
  }

  @override
  String get ingredientRestockQuantity => 'الكمية الواردة';

  @override
  String get validationIngredientRestock => 'أدخل كمية أكبر من 0.';

  @override
  String get ingredientLowStockBadge => 'منخفض';

  @override
  String ingredientLowStockBanner(int count) {
    return '$count مكوّنات عند العتبة أو أقل';
  }

  @override
  String ingredientStockPercent(int percent) {
    return '$percent% من السعة';
  }

  @override
  String get validationIngredientName => 'أدخل اسماً حتى 80 حرفاً.';

  @override
  String get validationIngredientStock => 'أدخل 0 أو رقماً موجباً.';

  @override
  String get errorIngredientNameTaken => 'اسم المكوّن مستخدم هنا بالفعل.';

  @override
  String get errorIngredientInUse =>
      'أزل هذا المكوّن من وصفات الأصناف قبل حذفه.';

  @override
  String get errorCompositionIngredientTaken =>
      'هذا المكوّن موجود بالفعل في هذا الصنف.';

  @override
  String get save => 'حفظ';

  @override
  String get close => 'إغلاق';

  @override
  String articleCompositionTitle(String name) {
    return 'التركيبة · $name';
  }

  @override
  String get articleCompositionHint =>
      'اختياري. أضف المكوّنات المستخدمة لحصة واحدة من هذا الصنف.';

  @override
  String get compositionEmpty => 'لا توجد بنود تركيبة بعد — وهذا مقبول.';

  @override
  String get compositionNone => 'بدون تركيبة';

  @override
  String compositionCount(int count) {
    return '$count مكوّنات';
  }

  @override
  String get compositionNeedIngredients =>
      'أضف مكوّنات أولاً ثم ابنِ التركيبة.';

  @override
  String get compositionAllIngredientsUsed =>
      'كل المكوّنات موجودة بالفعل في هذا الصنف.';

  @override
  String get compositionIngredient => 'المكوّن';

  @override
  String get compositionQuantity => 'الكمية لكل صنف';

  @override
  String get addCompositionLine => 'إضافة للتركيبة';

  @override
  String get editCompositionQuantity => 'تعديل الكمية';

  @override
  String get removeCompositionLine => 'إزالة من التركيبة';

  @override
  String removeCompositionLineConfirm(String name) {
    return 'إزالة $name من هذه التركيبة؟';
  }

  @override
  String get unitGram => 'غرام (غ)';

  @override
  String get unitKilogram => 'كيلوغرام (كغ)';

  @override
  String get unitMilliliter => 'مليلتر (مل)';

  @override
  String get unitCentiliter => 'سنتيلتر (سل)';

  @override
  String get unitLiter => 'لتر (ل)';

  @override
  String get unitPiece => 'قطعة (وحدة)';

  @override
  String get unitBottle => 'زجاجة';

  @override
  String get unitCan => 'علبة معدنية';

  @override
  String get unitPack => 'عبوة';

  @override
  String get unitBox => 'صندوق';

  @override
  String get unitBunch => 'ربطة';

  @override
  String get unitTeaspoon => 'ملعقة صغيرة';

  @override
  String get unitTablespoon => 'ملعقة كبيرة';

  @override
  String get unitCup => 'كوب';

  @override
  String get unitAbbrevGram => 'غ';

  @override
  String get unitAbbrevKilogram => 'كغ';

  @override
  String get unitAbbrevMilliliter => 'مل';

  @override
  String get unitAbbrevCentiliter => 'سل';

  @override
  String get unitAbbrevLiter => 'ل';

  @override
  String get unitAbbrevPiece => 'قطعة';

  @override
  String get unitAbbrevBottle => 'زجاجة';

  @override
  String get unitAbbrevCan => 'علبة';

  @override
  String get unitAbbrevPack => 'عبوة';

  @override
  String get unitAbbrevBox => 'صندوق';

  @override
  String get unitAbbrevBunch => 'ربطة';

  @override
  String get unitAbbrevTeaspoon => 'م.ص';

  @override
  String get unitAbbrevTablespoon => 'م.ك';

  @override
  String get unitAbbrevCup => 'كوب';

  @override
  String get ordersHint => 'أنشئ الطلبات وتقدّم حالة المطبخ وسجّل الدفع.';

  @override
  String get orderBoardHint =>
      'اسحب الصنف، أو اضغط مطولاً واسحب الطاولة إلى العمود التالي.';

  @override
  String get orderBoardCancel => 'ملغى';

  @override
  String get orderBoardCancelHint => 'اختر أصنافاً أو الطلب كاملاً، ثم أكّد.';

  @override
  String get orderBoardCancelConfirm => 'تأكيد';

  @override
  String get orderBoardEmpty => 'لا تذاكر مفتوحة على الصالة.';

  @override
  String get orderBoardColumnEmpty => 'لا شيء هنا';

  @override
  String get orderBoardNewOrder => 'طلب جديد';

  @override
  String get orderBoardItemAdded => 'مضاف';

  @override
  String get orderBoardNoTable => 'بدون طاولة';

  @override
  String get orderViewItems => 'أصناف الطلب';

  @override
  String get orderViewList => 'قائمة الطلبات';

  @override
  String get ordersEmpty => 'لا توجد طلبات بعد. اضغط طلب جديد للبدء.';

  @override
  String get ordersFilterAll => 'الكل';

  @override
  String get ordersFilterEmpty => 'لا توجد طلبات بهذه الحالة.';

  @override
  String get newOrder => 'طلب جديد';

  @override
  String get cancelOrderDraft => 'إلغاء التحديد';

  @override
  String get orderResetArticles => 'إعادة ضبط الأصناف';

  @override
  String get orderChangeTable => 'تغيير الطاولة';

  @override
  String get orderCancelCreate => 'إلغاء الطلب';

  @override
  String get createOrder => 'إنشاء الطلب';

  @override
  String get newOrderHint => 'اختر طاولة ثم أضف الأصناف. تُسجَّل كمنشئ الطلب.';

  @override
  String get orderSelectTablePrompt => 'اختر طاولة لهذا الطلب.';

  @override
  String get orderSelectTableFloorHint =>
      'اضغط طاولة على خريطة الصالة لمتابعة إضافة الأصناف.';

  @override
  String get orderTableInactive => 'هذه الطاولة غير نشطة. اختر طاولة نشطة.';

  @override
  String get orderTableOccupied => 'هذه الطاولة لديها طلب مفتوح بالفعل.';

  @override
  String get orderAppendArticles => 'إضافة أصناف';

  @override
  String get orderAppendArticlesDisabled =>
      'هذا المكان لا يسمح بإضافة أصناف للطلبات المفتوحة.';

  @override
  String get orderNoActiveTables => 'لا توجد طاولات نشطة. أنشئ طاولات أولاً.';

  @override
  String get orderSearchArticles => 'ابحث عن الأصناف بالاسم';

  @override
  String get orderAllCategories => 'الكل';

  @override
  String get orderNoArticlesMatch => 'لا توجد أصناف مطابقة لهذا التصفية.';

  @override
  String get orderConfirm => 'تأكيد الطلب';

  @override
  String get orderAddUnit => 'إضافة وحدة';

  @override
  String get orderRemoveUnit => 'إزالة وحدة';

  @override
  String get orderTableOptional => 'الطاولة (اختياري)';

  @override
  String get orderNoTable => 'بدون طاولة';

  @override
  String orderTableNumber(int number) {
    return 'طاولة $number';
  }

  @override
  String get orderNeedArticles => 'أضف أصنافاً في المنتجات قبل إنشاء طلب.';

  @override
  String get validationOrderItems => 'أضف صنفاً واحداً على الأقل.';

  @override
  String get orderItemsLabel => 'أصناف';

  @override
  String get orderItemsHeading => 'الأصناف';

  @override
  String orderDetailTitle(String table) {
    return 'طلب · $table';
  }

  @override
  String orderRefTitle(int ref) {
    return 'طلب · #$ref';
  }

  @override
  String orderRefLabel(int ref) {
    return '#$ref';
  }

  @override
  String orderLaunchedBy(String actor) {
    return 'أنشأه $actor';
  }

  @override
  String orderLastPaidBy(String actor) {
    return 'آخر دفع بواسطة $actor';
  }

  @override
  String get cancelOrder => 'إلغاء الطلب';

  @override
  String get cancelOrderConfirm => 'إلغاء هذا الطلب والبنود المفتوحة؟';

  @override
  String get cancelReasonTitle => 'سبب الإلغاء';

  @override
  String get cancelReasonConfirm => 'إلغاء';

  @override
  String get cancelReasonOutOfStock => 'نفد مكوّن';

  @override
  String get cancelReasonClosingSoon => 'وقت الإغلاق يقترب';

  @override
  String get cancelReasonWorkBreakdown => 'عطل في العمل، حاول لاحقاً';

  @override
  String get cancelReasonCustomerRequest => 'أُلغي بناءً على طلب الزبون';

  @override
  String get cancelOrderItem => 'إلغاء الصنف';

  @override
  String get orderItemInfo => 'تفاصيل الصنف';

  @override
  String get orderInfo => 'تواريخ الطلب';

  @override
  String get orderFieldCreatedAt => 'أُنشئ';

  @override
  String get orderFieldUpdatedAt => 'حُدّث';

  @override
  String get orderFieldPreparedAt => 'أُعدّ';

  @override
  String get orderFieldServedAt => 'قُدّم';

  @override
  String get orderFieldPaidAt => 'دُفع';

  @override
  String orderFieldPaidAtLabel(String when) {
    return 'دُفع $when';
  }

  @override
  String get orderFieldPreparedBy => 'أعدّه';

  @override
  String get orderFieldServedBy => 'قدّمه';

  @override
  String get orderFieldPaidTo => 'قبض';

  @override
  String get orderFieldLaunchedBy => 'أنشأه';

  @override
  String get orderFieldCancelledBy => 'ألغاه';

  @override
  String get orderFieldCancelledAt => 'أُلغي';

  @override
  String orderCancelledBy(String actor) {
    return 'ألغاه $actor';
  }

  @override
  String orderActorLabel(String role, String name) {
    return '$role - $name';
  }

  @override
  String get actorRoleOwner => 'المالك';

  @override
  String get actorRoleEmployee => 'موظف';

  @override
  String get actorRoleCustomer => 'عميل';

  @override
  String get actorRoleSuperAdmin => 'مسؤول';

  @override
  String orderFieldCancelledAtLabel(String when) {
    return 'أُلغي $when';
  }

  @override
  String orderFieldCreatedAtLabel(String when) {
    return 'أُنشئ $when';
  }

  @override
  String orderFieldUpdatedAtLabel(String when) {
    return 'حُدّث $when';
  }

  @override
  String get orderStatusProgress => 'قيد التنفيذ';

  @override
  String get orderStatusPayed => 'مدفوع';

  @override
  String get orderStatusCancelled => 'ملغى';

  @override
  String get orderItemStatusProgress => 'قيد التنفيذ';

  @override
  String get orderItemStatusPicked => 'مأخوذ';

  @override
  String get orderItemStatusReady => 'مُحضَّر';

  @override
  String get orderItemStatusServed => 'مقدَّم';

  @override
  String get orderItemStatusPayed => 'مدفوع';

  @override
  String get orderItemStatusCancelled => 'ملغى';

  @override
  String get orderItemPayNow => 'ادفع الآن';

  @override
  String get errorOrderInvalidStatus => 'تغيير الحالة غير مسموح.';

  @override
  String get errorOrderInsufficientStock =>
      'مخزون المكونات غير كافٍ لهذا الطلب.';

  @override
  String get errorOrderTableOccupied => 'هذه الطاولة لديها طلب مفتوح بالفعل.';

  @override
  String get errorOrderAppendNotAllowed =>
      'إضافة أصناف للطلبات المفتوحة غير مسموحة لهذا المكان.';

  @override
  String get errorOrderPermissionDenied =>
      'ملف الصلاحيات لا يسمح بهذا الإجراء.';

  @override
  String get errorOrderCancelLocked =>
      'لم يعد بالإمكان إلغاء هذا الصنف أو هذا الطلب.';

  @override
  String get errorAccessNameTaken => 'اسم الصلاحية مستخدم هنا بالفعل.';

  @override
  String get errorAccessInUse => 'أعد تعيين الموظفين قبل حذف ملف الصلاحيات.';

  @override
  String get navAccessProfiles => 'الصلاحيات';

  @override
  String get accessProfilesHint => 'مجموعات صلاحيات مسماة تُعيَّن للموظفين.';

  @override
  String get accessProfilesEmpty =>
      'لا توجد صلاحيات بعد. أنشئ واحدة قبل إضافة موظفين.';

  @override
  String get addAccessProfile => 'إضافة صلاحية';

  @override
  String get editAccessProfile => 'تعديل الصلاحية';

  @override
  String get saveAccessProfile => 'حفظ الصلاحية';

  @override
  String get deleteAccessProfile => 'حذف الصلاحية';

  @override
  String deleteAccessProfileConfirm(String name) {
    return 'حذف «$name»؟ يجب إعادة تعيين الموظفين أولاً.';
  }

  @override
  String get accessProfileName => 'اسم الصلاحية';

  @override
  String get accessProfile => 'ملف الصلاحيات';

  @override
  String get accessProfileNone => 'غير معيَّن';

  @override
  String get employeeNeedsAccessProfile => 'أنشئ ملف صلاحيات قبل إضافة موظف.';

  @override
  String get validationAccessName => 'أدخل اسماً حتى 80 حرفاً.';

  @override
  String get validationAccessRequired => 'اختر ملف صلاحيات.';

  @override
  String get accessOrderCreation => 'إنشاء الطلبات';

  @override
  String get accessOrderCreationHint => 'إنشاء طلبات وإضافة أصناف.';

  @override
  String get accessOrderPayment => 'تحصيل الدفع';

  @override
  String get accessOrderPaymentHint => 'تعليم الأصناف والطلبات كمدفوعة.';

  @override
  String get accessCancelOrder => 'إلغاء الطلبات';

  @override
  String get accessCancelOrderHint => 'إلغاء طلب أو سطر.';

  @override
  String get accessPreparation => 'التحضير';

  @override
  String get accessPreparationHint => 'تعليم الأصناف كمأخوذة أو جاهزة.';

  @override
  String get accessServing => 'التقديم';

  @override
  String get accessServingHint => 'تعليم الأصناف كمقدَّمة.';

  @override
  String get accessConsultAllOrders => 'عرض كل الطلبات';

  @override
  String get accessConsultAllOrdersHint =>
      'معطّل: فقط الطلبات التي أطلقها أو الأسطر التي أضافها.';

  @override
  String get accessFlagCreate => 'إنشاء';

  @override
  String get accessFlagPay => 'دفع';

  @override
  String get accessFlagCancel => 'إلغاء';

  @override
  String get accessFlagPrep => 'تحضير';

  @override
  String get accessFlagServe => 'تقديم';

  @override
  String get accessFlagConsultAll => 'كل الطلبات';

  @override
  String get accessNoFlags => 'بدون صلاحيات';

  @override
  String packBannerTitle(String name) {
    return 'الباقة: $name';
  }

  @override
  String get packBannerHint => 'لتغيير الباقة، تواصل مع فريق الدعم.';

  @override
  String get errorPackLimit => 'بلغت هذه الباقة حدها.';

  @override
  String get errorPackFeature => 'هذه الباقة لا تشمل ذلك.';

  @override
  String get errorPackLimitEmployees => 'بلغت هذه الباقة حد الموظفين.';

  @override
  String get errorPackLimitTables => 'بلغت هذه الباقة حد الطاولات.';

  @override
  String get errorPackLimitCategories => 'بلغت هذه الباقة حد الفئات.';

  @override
  String get errorPackLimitArticles => 'بلغت هذه الباقة حد الأصناف.';

  @override
  String get errorPackLimitIngredients => 'بلغت هذه الباقة حد المكونات.';

  @override
  String get errorPackFeatureOrdering => 'هذه الباقة لا تشمل طلبات الزبائن.';

  @override
  String get errorPackFeatureInventory => 'هذه الباقة لا تشمل المخزون.';

  @override
  String get errorPackFeatureAppend =>
      'هذه الباقة لا تشمل إضافة أصناف إلى طلب مفتوح.';

  @override
  String get errorPackFeatureMultiOrder =>
      'هذه الباقة لا تشمل أكثر من طلب على الطاولة.';

  @override
  String get errorPackFeatureStrict =>
      'هذه الباقة لا تشمل خطوات الطلب الصارمة.';

  @override
  String get errorPackFeatureAccess =>
      'هذه الباقة لا تشمل ملفات صلاحيات مخصصة.';

  @override
  String get errorPackFeatureQr => 'هذه الباقة لا تشمل رموز QR للطاولات.';

  @override
  String get navReservations => 'الحجوزات';

  @override
  String reservationPendingCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count طلبات معلّقة',
      one: 'طلب معلّق واحد',
    );
    return '$_temp0';
  }

  @override
  String get reservationsTitle => 'الحجوزات';

  @override
  String get reservationNew => 'حجز جديد';

  @override
  String get reservationPreviousDay => 'اليوم السابق';

  @override
  String get reservationNextDay => 'اليوم التالي';

  @override
  String get reservationEmpty => 'لا حجوزات في هذا اليوم.';

  @override
  String get reservationGuestName => 'اسم الضيف';

  @override
  String get reservationGuestPhone => 'الهاتف';

  @override
  String get reservationPaidAmount => 'المبلغ المدفوع';

  @override
  String get reservationPaidInvalid => 'أدخل مبلغاً من 0 إلى 1000000.';

  @override
  String get reservationFee => 'رسوم الحجز';

  @override
  String get reservationFeeHint => 'تملأ المبلغ في حجز الموظفين، بعملة المكان.';

  @override
  String get reservationDate => 'التاريخ';

  @override
  String get reservationStart => 'البداية';

  @override
  String get reservationEnd => 'النهاية';

  @override
  String get reservationTables => 'الطاولات';

  @override
  String get reservationFindCustomer => 'البحث عن زبون';

  @override
  String get reservationGuestInstead => 'كتابة ضيف بدل حساب';

  @override
  String get reservationCancel => 'إلغاء الحجز';

  @override
  String get reservationCancelConfirm => 'إلغاء هذا الحجز؟';

  @override
  String get reservationConfirm => 'تأكيد';

  @override
  String get reservationAssignTable => 'تعيين طاولة';

  @override
  String get reservationNoTable => 'لا طاولة بعد';

  @override
  String get reservationCreateHint => 'هذا الحجز مؤكد. عيّن طاولة من القائمة.';

  @override
  String get reservationStatusRequested => 'طلب';

  @override
  String get reservationStatusConfirmed => 'مؤكد';

  @override
  String get reservationStatusArrived => 'وصل';

  @override
  String get reservationStatusCancelled => 'ملغى';

  @override
  String get reservationStatusNoShow => 'لم يحضر';

  @override
  String get reservationSoon => 'يبدأ قريباً';

  @override
  String get reservationHolding => 'بانتظار الوصول';

  @override
  String get reservationHeldOrder =>
      'هذه الطاولة محجوزة. امسحها لتأكيد الوصول قبل أخذ الطلب.';

  @override
  String get reservationScanNeedsAccess =>
      'وحده من لديه صلاحية الحجوزات يمكنه تأكيد هذه الطاولة.';

  @override
  String get reservationWindow => 'اختر بداية لم تنتهِ بعد.';

  @override
  String get reservationSearchHint => 'الاسم أو الهاتف أو البريد';

  @override
  String get reservationCustomerAccount => 'حساب الزبون';

  @override
  String get reservationSearchEmpty => 'لا يوجد زبائن مطابقون.';

  @override
  String get reservationSelectTables => 'اختر طاولة واحدة على الأقل.';

  @override
  String get accessReservations => 'الحجوزات';

  @override
  String get accessReservationsHint =>
      'إنشاء الحجوزات وتأكيدها وإلغاؤها وتعيين طاولاتها.';

  @override
  String get errorPackFeatureReservations => 'هذه الباقة لا تشمل الحجوزات.';

  @override
  String get errorPackLimitReservations =>
      'بلغت هذه الباقة حد الحجوزات لهذا اليوم.';

  @override
  String get errorOrderReservationHeld => 'أكّد الحجز قبل أخذ الطلب.';

  @override
  String get errorCustomerOrderingDisabled => 'هذا المكان أوقف طلبات الزبائن.';

  @override
  String get errorReservationsDisabled => 'هذا المكان أوقف الحجوزات.';

  @override
  String get errorReservationOverlap => 'طاولة محجوزة بالفعل في هذا الوقت.';

  @override
  String get errorReservationNotFound => 'لا يوجد زبون أو حجز مطابق.';

  @override
  String get packCapReservations => 'الحجوزات';

  @override
  String get packCapReservationsPerDay => 'حجوزات / يوم';

  @override
  String get errorPackPaidActive => 'هذا المكان على باقة مدفوعة.';

  @override
  String get previousPage => 'السابق';

  @override
  String get nextPage => 'التالي';

  @override
  String pageOf(int current, int total) {
    return '$current / $total';
  }

  @override
  String get loadingMore => 'جارٍ تحميل المزيد…';

  @override
  String get packUpgrade => 'ترقية';

  @override
  String get packCatalogTitle => 'الباقات';

  @override
  String get packCatalogIntro =>
      'قارن الباقات العامة. تغيير باقة هذا المكان يتم عبر فريق الدعم.';

  @override
  String packCatalogIntroCurrent(String name) {
    return 'هذا المكان على $name. تغيير الباقة يتم عبر فريق الدعم.';
  }

  @override
  String get packCatalogEmpty => 'لا توجد باقات عامة.';

  @override
  String get packCurrent => 'الحالية';

  @override
  String packPriceMonth(String price) {
    return '$price د.ت / شهر';
  }

  @override
  String packPriceYear(String price) {
    return '$price د.ت / سنة';
  }

  @override
  String packFeeLine(String percent) {
    return 'رسوم تطبيق الزبون $percent%';
  }

  @override
  String get packUnlimited => 'بلا حد';

  @override
  String get packLimits => 'الحدود';

  @override
  String get packCapabilities => 'الإمكانات';

  @override
  String packLimitValue(String label, String value) {
    return '$label: $value';
  }

  @override
  String get packCapEmployees => 'الموظفون';

  @override
  String get packCapTables => 'الطاولات';

  @override
  String get packCapCategories => 'التصنيفات';

  @override
  String get packCapArticles => 'الأصناف';

  @override
  String get packCapIngredients => 'المكونات';

  @override
  String get packCapDiscovery => 'خريطة الزبائن';

  @override
  String get packCapQr => 'رمز الطاولة';

  @override
  String get packCapOrdering => 'طلب الزبون';

  @override
  String get packCapInventory => 'المخزون والوصفات';

  @override
  String get packCapAppend => 'إضافة أصناف إلى طلب';

  @override
  String get packCapMultiOrder => 'عدة طلبات على الطاولة';

  @override
  String get packCapStrict => 'خطوات المطبخ الصارمة';

  @override
  String get packCapAccess => 'ملفات صلاحيات مخصصة';
}
