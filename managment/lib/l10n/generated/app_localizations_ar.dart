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
  String get validationPhone => 'أدخل رقم هاتف صالحاً.';

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
      'مخطط القاعة حسب المقاعد. الحالة تأتي لاحقاً من الطلبات والحجوزات.';

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
}
