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

  @override
  String get close => 'إغلاق';

  @override
  String get back => 'رجوع';

  @override
  String get menu => 'القائمة';

  @override
  String availableTables(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count طاولة متاحة',
      many: '$count طاولة متاحة',
      few: '$count طاولات متاحة',
      two: 'طاولتان متاحتان',
      one: 'طاولة واحدة متاحة',
      zero: 'لا توجد طاولات متاحة',
    );
    return '$_temp0';
  }

  @override
  String get previewCategories => 'أبرز الفئات';

  @override
  String get previewArticles => 'أبرز الأطباق';

  @override
  String articleCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count طبق',
      many: '$count طبقاً',
      few: '$count أطباق',
      two: 'طبقان',
      one: 'طبق واحد',
      zero: 'لا أطباق',
    );
    return '$_temp0';
  }

  @override
  String get emptyMenuPreview => 'لا شيء في القائمة بعد.';

  @override
  String get emptyMenu => 'لم تنشر هذه الدار قائمة بعد.';

  @override
  String get emptyMenuSection => 'لا شيء في هذا القسم بعد.';

  @override
  String get seeAll => 'عرض الكل';

  @override
  String tableNumber(int number) {
    return 'طاولة $number';
  }

  @override
  String get discoveryTab => 'استكشاف';

  @override
  String get ordersTab => 'الطلبات';

  @override
  String get filterToday => 'اليوم';

  @override
  String get filterLastWeek => 'الأسبوع الماضي';

  @override
  String get filterLastMonth => 'الشهر الماضي';

  @override
  String get emptyOrders => 'لا طلبات في هذه الفترة.';

  @override
  String orderItemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count طبق',
      many: '$count طبقاً',
      few: '$count أطباق',
      two: 'طبقان',
      one: 'طبق واحد',
      zero: 'لا أطباق',
    );
    return '$_temp0';
  }

  @override
  String get orderStatusProgress => 'قيد التنفيذ';

  @override
  String get orderStatusPayed => 'مدفوع';

  @override
  String get orderStatusCancelled => 'ملغى';

  @override
  String get openOrderNote => 'طلب قيد التنفيذ';

  @override
  String get itemStatusPicked => 'في المطبخ';

  @override
  String get itemStatusReady => 'جاهز';

  @override
  String get itemStatusServed => 'تم التقديم';

  @override
  String get scanTable => 'مسح الطاولة';

  @override
  String get changeTable => 'تغيير الطاولة';

  @override
  String get scanTableHint => 'وجّه الكاميرا إلى رمز QR على طاولتك.';

  @override
  String get tableScanInvalid => 'هذا الرمز ليس رمز طاولة في Sip Sync.';

  @override
  String get tableScanUnknown => 'هذا الرمز لا يطابق طاولة نشطة.';

  @override
  String get tableScanCamera =>
      'الكاميرا غير متاحة. اسمح بالوصول ثم أعد المحاولة.';

  @override
  String get yourTable => 'طاولتك';

  @override
  String seatedAt(int number) {
    return 'أنت على الطاولة $number';
  }

  @override
  String tableChanged(int number) {
    return 'تم تغيير الطاولة. أنت الآن على الطاولة $number.';
  }

  @override
  String get addArticle => 'إضافة';

  @override
  String get removeArticle => 'إزالة';

  @override
  String get passOrder => 'إرسال الطلب';

  @override
  String get yourOrder => 'طلبك';

  @override
  String get orderEmpty => 'أضف طبقاً قبل إرسال الطلب.';

  @override
  String get scanTableToOrder => 'امسح رمز QR على طاولتك لإرسال الطلب.';

  @override
  String cartSummary(int count, String total) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count طبق',
      many: '$count طبقاً',
      few: '$count أطباق',
      two: 'طبقان',
      one: 'طبق واحد',
    );
    return '$_temp0 · $total';
  }

  @override
  String get total => 'المجموع';

  @override
  String get orderSent => 'أُرسل إلى المطبخ';

  @override
  String orderRef(int ref) {
    return 'طلب #$ref';
  }

  @override
  String lineQuantity(int count, String name) {
    return '$count × $name';
  }

  @override
  String get errorTableOccupied => 'هذه الطاولة لديها طلب مفتوح.';

  @override
  String get errorInsufficientStock => 'أحد أصناف هذا الطلب لم يعد متاحاً.';

  @override
  String get errorAppendNotAllowed =>
      'هذا المكان لا يسمح بإضافة أطباق إلى طلب مفتوح.';

  @override
  String get currentOrder => 'الطلب الحالي';

  @override
  String get orderHistory => 'سجل الطلبات';

  @override
  String get addToOrder => 'إضافة إلى الطلب';

  @override
  String get scanDisabled => 'المسح غير متاح أثناء وجود طلب قيد التنفيذ.';

  @override
  String seatCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count مقعد',
      many: '$count مقعداً',
      few: '$count مقاعد',
      two: 'مقعدان',
      one: 'مقعد واحد',
      zero: 'لا مقاعد',
    );
    return '$_temp0';
  }

  @override
  String get venueTypeCafe => 'مقهى';

  @override
  String get venueTypeRestaurant => 'مطعم';

  @override
  String get venueTypeLounge => 'لاونج';

  @override
  String get venueTypeBar => 'بار';

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
  String get reserveTable => 'احجز طاولة';

  @override
  String get signInToReserve => 'سجّل الدخول للحجز';

  @override
  String get reservationBook => 'احجز';

  @override
  String get reservationMine => 'حجوزاتي';

  @override
  String get reservationEmpty => 'ليس لديك حجوزات قادمة.';

  @override
  String get reservationDate => 'التاريخ';

  @override
  String get reservationStart => 'البداية';

  @override
  String get reservationEnd => 'النهاية';

  @override
  String get reservationCancel => 'إلغاء الحجز';

  @override
  String get reservationSoon => 'يبدأ قريباً';

  @override
  String get reservationHolding => 'بانتظار تأكيد المكان للوصول';

  @override
  String get reservationHeldOrder =>
      'هذه الطاولة محجوزة إلى أن يؤكد المكان وصول الضيوف.';

  @override
  String get reservationWindow =>
      'يدوم الحجز بين 30 دقيقة و8 ساعات، ويجب أن يبدأ لاحقاً.';

  @override
  String get reservationSelectTables => 'اختر طاولة واحدة على الأقل.';

  @override
  String get errorPackFeatureReservations => 'هذه الباقة لا تشمل الحجوزات.';

  @override
  String get errorPackLimitReservations =>
      'بلغت هذه الباقة حد الحجوزات لهذا اليوم.';

  @override
  String get errorOrderReservationHeld =>
      'هذه الطاولة محجوزة إلى أن يؤكد المكان الوصول.';

  @override
  String get errorReservationOverlap => 'طاولة محجوزة بالفعل في هذا الوقت.';

  @override
  String get errorReservationNotFound => 'لا يوجد حجز مطابق.';

  @override
  String get errorPackPaidActive => 'هذا المكان على باقة مدفوعة.';

  @override
  String get orderingUnavailable =>
      'باقة هذا المكان لا تشمل الطلب من التطبيق. يمكنك تصفح القائمة.';

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
}
