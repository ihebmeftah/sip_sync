// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Sip Sync Ops';

  @override
  String get tagline => 'Floor, kitchen, and till — one login for the house.';

  @override
  String get atmosphereTitle => 'Run the house from one screen';

  @override
  String get atmosphereBody =>
      'Owners and staff share a login. What you can do is decided on the server.';

  @override
  String get authLead => 'Staff sign in';

  @override
  String get registerLead => 'Open an owner account';

  @override
  String get showPassword => 'Show password';

  @override
  String get hidePassword => 'Hide password';

  @override
  String get signIn => 'Sign in';

  @override
  String get loginAsOwner => 'Owner';

  @override
  String get loginAsEmployee => 'Employee';

  @override
  String get register => 'Create account';

  @override
  String get signOut => 'Sign out';

  @override
  String get email => 'Email';

  @override
  String get loginIdentifier => 'Email or username';

  @override
  String get loginIdentifierHint =>
      'Owners use email. Staff use their username.';

  @override
  String get password => 'Password';

  @override
  String get username => 'Username';

  @override
  String get usernameLocked =>
      'Username is assigned by the system and cannot be changed.';

  @override
  String get employeeUsernameHint =>
      'A username is generated from the name after you save.';

  @override
  String get phone => 'Phone number';

  @override
  String get firstName => 'First name';

  @override
  String get lastName => 'Last name';

  @override
  String get noAccount => 'New here? Register';

  @override
  String get hasAccount => 'Already with us? Sign in';

  @override
  String welcome(String name) {
    return 'Welcome, $name';
  }

  @override
  String get rolesLabel => 'Your roles';

  @override
  String get homeHint =>
      'The same email works if you later run a café or join a team.';

  @override
  String get addEmployee => 'Add employee';

  @override
  String get employees => 'Team';

  @override
  String get staff => 'Backoffice users';

  @override
  String get addStaff => 'Add backoffice user';

  @override
  String get adminFlag => 'admin';

  @override
  String get defaultAdminFlag => 'default';

  @override
  String get loading => 'Loading';

  @override
  String get retry => 'Retry';

  @override
  String get empty => 'Nothing here yet';

  @override
  String get language => 'Language';

  @override
  String get errorGeneric => 'Something went wrong. Try again.';

  @override
  String get errorCannotReachServer =>
      'Cannot reach the server. On a physical device, run with --dart-define=SERVER_URL=http://YOUR_COMPUTER_LAN_IP:8080 (same Wi‑Fi as the phone).';

  @override
  String get errorInvalidInput => 'Check the form and try again.';

  @override
  String get errorEmailTaken =>
      'This email is already used with a different password.';

  @override
  String get errorUsernameTaken => 'That username is taken.';

  @override
  String get errorPhoneTaken => 'That phone number is taken.';

  @override
  String get errorInvalidCredentials => 'Email or password is incorrect.';

  @override
  String get errorAppAccessDenied => 'This account cannot use this app yet.';

  @override
  String get errorNotAuthorized => 'You do not have permission.';

  @override
  String get errorNotFound => 'Not found.';

  @override
  String get errorCannotDeleteDefaultAdmin =>
      'The default admin cannot be deleted.';

  @override
  String get errorPasswordTooWeak =>
      'Use at least 8 characters, no leading or trailing spaces.';

  @override
  String get errorProfileIncomplete =>
      'Finish registration with username and phone.';

  @override
  String get errorAccountDisabled => 'This staff account is disabled.';

  @override
  String get navEmployees => 'Employees';

  @override
  String get editEmployee => 'Edit employee';

  @override
  String get saveEmployee => 'Save employee';

  @override
  String get employeesOwnerOnly => 'Only owners can manage staff.';

  @override
  String get accountEnabled => 'Account enabled';

  @override
  String get accountDisabled => 'Account disabled';

  @override
  String get accountEnabledHint => 'This person can sign in to operations.';

  @override
  String get accountDisabledHint => 'This person cannot sign in to operations.';

  @override
  String get dashboardEmployeesCue =>
      'Add staff, edit details, and enable or disable access.';

  @override
  String get opsRailTagline => 'Floor command';

  @override
  String get navDashboard => 'Dashboard';

  @override
  String get navProfile => 'Profile';

  @override
  String get navProducts => 'Products';

  @override
  String get navCategories => 'Categories';

  @override
  String get navArticles => 'Articles';

  @override
  String get navIngredients => 'Ingredients';

  @override
  String get navPos => 'POS';

  @override
  String get navOrders => 'Orders';

  @override
  String get navTables => 'Tables';

  @override
  String helloScreen(String screen) {
    return 'Hello, $screen';
  }

  @override
  String get placeholderBody =>
      'This screen is not connected to the server yet.';

  @override
  String get saveProfile => 'Save profile';

  @override
  String get profileSaved => 'Profile updated.';

  @override
  String get myProfile => 'Your profile';

  @override
  String get teamProfiles => 'Added staff';

  @override
  String get viewProfile => 'View';

  @override
  String get employeeProfile => 'Staff profile';

  @override
  String get themeLight => 'Light theme';

  @override
  String get themeDark => 'Dark theme';

  @override
  String get dashboardEyebrow => 'Tonight’s house';

  @override
  String get dashboardSubtitle =>
      'POS, floor, and catalog sit one tap away. Live counts arrive with the next server slice.';

  @override
  String get dashboardShift => 'Shift board';

  @override
  String get dashboardPosCue => 'Till and tickets — coming next.';

  @override
  String get dashboardTablesCue =>
      'Floor map with seat previews and status filters.';

  @override
  String get dashboardCatalogCue => 'Categories and articles for this venue.';

  @override
  String get dashboardProfileCue => 'Your name and phone.';

  @override
  String get emailLocked =>
      'Email is tied to sign-in and cannot be changed here.';

  @override
  String get profileHint =>
      'Update the name the floor sees. Sign-in identity stays locked.';

  @override
  String get navBuildings => 'Buildings';

  @override
  String get addBuilding => 'Add building';

  @override
  String get editBuilding => 'Edit building';

  @override
  String get saveBuilding => 'Save building';

  @override
  String get buildingName => 'Venue name';

  @override
  String get buildingType => 'Venue type';

  @override
  String get buildingTypeRestaurant => 'Restaurant';

  @override
  String get buildingTypeLounge => 'Lounge';

  @override
  String get buildingTypeBar => 'Bar';

  @override
  String get buildingTypeCafe => 'Café';

  @override
  String get buildingTypeOther => 'Other';

  @override
  String get buildingTypeCustom => 'Custom type';

  @override
  String get buildingAddress => 'Address';

  @override
  String get latitude => 'Latitude';

  @override
  String get longitude => 'Longitude';

  @override
  String get openingTime => 'Opens';

  @override
  String get closingTime => 'Closes';

  @override
  String get currencyCode => 'Currency';

  @override
  String get buildingTableMultiOrder => 'Multiple orders per table';

  @override
  String get buildingTableMultiOrderHint =>
      'When on, staff can open another order on a table that already has one. When off, an occupied table must be paid or cancelled first.';

  @override
  String get buildingAllowAppendingItems =>
      'Allow adding articles to open orders';

  @override
  String get buildingAllowAppendingItemsHint =>
      'When on, staff can append articles to an existing open order. When off, the Add articles button is disabled.';

  @override
  String get buildingStrictMode => 'Strict item workflow';

  @override
  String get buildingStrictModeHint =>
      'When on, each order line must follow enabled steps in order. When off, staff can mark payed without the earlier steps.';

  @override
  String get buildingStrictModeStepsTitle => 'Workflow steps';

  @override
  String get buildingStrictModeStepsHint =>
      'Toggle which steps are required. Order is fixed; only enable or disable.';

  @override
  String buildingStrictModeStepRank(int rank) {
    return 'Step $rank';
  }

  @override
  String get buildingStaff => 'Staff at this venue';

  @override
  String get buildingStaffEmpty =>
      'No employees yet. Add staff after you save this venue.';

  @override
  String get buildingsOwnerHint =>
      'Create a venue, then open it to run the floor. Other tools stay locked until you pick one.';

  @override
  String get buildingsStaffHint => 'Pick a venue you are assigned to.';

  @override
  String get buildingsEmptyOwner =>
      'Add your first café, restaurant, lounge, or bar to continue.';

  @override
  String get employeesEmptyBuilding => 'No staff assigned to this venue yet.';

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
  String get validationRequired => 'This field is required.';

  @override
  String get validationLoginIdentifier =>
      'Enter an email or a username (at least 3 characters).';

  @override
  String get validationEmail => 'Enter a valid email.';

  @override
  String get validationPassword =>
      'Use at least 8 characters, no leading or trailing spaces.';

  @override
  String get validationPhone => 'Enter a valid phone number.';

  @override
  String get validationVenueName => 'Name must be 1–80 characters.';

  @override
  String get validationVenueType =>
      'Use 2–40 letters, numbers, spaces, or hyphens.';

  @override
  String get validationAddress => 'Address must be 3–200 characters.';

  @override
  String get validationLatitude => 'Latitude must be between -90 and 90.';

  @override
  String get validationLongitude => 'Longitude must be between -180 and 180.';

  @override
  String get validationCurrency => 'Use a 3-letter currency code.';

  @override
  String get pickCurrentPosition => 'Pick current position';

  @override
  String get errorLocationDenied =>
      'Location permission is required to fill the address.';

  @override
  String get errorLocationDisabled =>
      'Turn on location services and try again.';

  @override
  String get errorLocationFailed => 'Could not read the current position.';

  @override
  String get cancel => 'Cancel';

  @override
  String get addTable => 'Add table';

  @override
  String get editTable => 'Edit table';

  @override
  String get saveTable => 'Save table';

  @override
  String get tablesHint =>
      'Floor plan by seats. Status comes from orders and reservations later.';

  @override
  String get tablesEmployeeOrderHint => 'Tap a table to start a new order.';

  @override
  String get tablesEmptyOwner => 'Add your first table to sketch the floor.';

  @override
  String get tablesEmpty => 'No tables on this floor yet.';

  @override
  String get tablesFilterEmpty => 'No tables match this filter.';

  @override
  String get tableFormHint =>
      'Choose how many tables to add. Numbers are assigned in order automatically.';

  @override
  String get tableEditHint =>
      'You can change seats and whether the table is active. The number stays fixed.';

  @override
  String get tableNumber => 'Table number';

  @override
  String get tableNumberLocked => 'Table number cannot be changed.';

  @override
  String get tableCountToAdd => 'How many tables';

  @override
  String tableNumberRange(int from, int to) {
    return 'Will create numbers $from–$to';
  }

  @override
  String get tableMaxSeats => 'Max seats';

  @override
  String get tableActive => 'Active on floor';

  @override
  String get tableActiveHint =>
      'Inactive tables stay in the list but drop out of Available.';

  @override
  String tableSeatsCount(int count) {
    return '$count seats';
  }

  @override
  String get tableFilterAll => 'All';

  @override
  String get tableFilterInactive => 'Inactive';

  @override
  String get tableStatusAvailable => 'Available';

  @override
  String get tableStatusOccupied => 'Occupied';

  @override
  String get tableStatusReserved => 'Reserved';

  @override
  String get validationTableNumber => 'Enter a number from 1 to 9999.';

  @override
  String get validationTableCount => 'Enter a count from 1 to 100.';

  @override
  String get validationTableSeats => 'Enter seats from 1 to 50.';

  @override
  String get errorTableNumberTaken => 'That table number is already used here.';

  @override
  String get optionalFieldHint => 'Optional';

  @override
  String get noDescription => 'No description';

  @override
  String get categoriesHint =>
      'Group the menu for this venue. Names must be unique here.';

  @override
  String get categoriesEmptyOwner =>
      'Add your first category, then attach articles.';

  @override
  String get categoriesEmpty => 'No categories in this venue yet.';

  @override
  String get addCategory => 'Add category';

  @override
  String get editCategory => 'Edit category';

  @override
  String get saveCategory => 'Save category';

  @override
  String get categoryFormHint =>
      'Name is unique in this building. Description is optional.';

  @override
  String get categoryName => 'Category name';

  @override
  String get categoryDescription => 'Description';

  @override
  String get validationCategoryName => 'Enter a name up to 80 characters.';

  @override
  String get validationDescription =>
      'Description must be at most 500 characters.';

  @override
  String get errorCategoryNameTaken =>
      'That category name is already used here.';

  @override
  String get articlesHint =>
      'Sellable items with a price and category. Names must be unique here.';

  @override
  String get articlesEmptyOwner =>
      'Add your first article once a category exists.';

  @override
  String get articlesEmpty => 'No articles in this venue yet.';

  @override
  String get articlesNeedCategory =>
      'Create a category before adding articles.';

  @override
  String get addArticle => 'Add article';

  @override
  String get editArticle => 'Edit article';

  @override
  String get saveArticle => 'Save article';

  @override
  String get articleFormHint =>
      'Pick a category, set the price, and keep the name unique in this building.';

  @override
  String get articleName => 'Article name';

  @override
  String get articleDescription => 'Description';

  @override
  String get articlePrice => 'Price';

  @override
  String get articleCategory => 'Category';

  @override
  String get validationArticleName => 'Enter a name up to 80 characters.';

  @override
  String get validationArticlePrice => 'Enter a price greater than 0.';

  @override
  String get validationArticleCategory => 'Choose a category.';

  @override
  String get errorArticleNameTaken => 'That article name is already used here.';

  @override
  String get delete => 'Delete';

  @override
  String get ingredientsHint =>
      'Track stock by unit. Low stock highlights when current is at or below the threshold.';

  @override
  String get ingredientsEmptyOwner =>
      'Add your first ingredient to start inventory.';

  @override
  String get ingredientsEmpty => 'No ingredients in this venue yet.';

  @override
  String get addIngredient => 'Add ingredient';

  @override
  String get deleteIngredient => 'Delete ingredient';

  @override
  String deleteIngredientConfirm(String name) {
    return 'Delete $name? This cannot be undone.';
  }

  @override
  String get ingredientFormHint =>
      'Name is unique in this building. Choose the unit you reorder by.';

  @override
  String get ingredientName => 'Ingredient name';

  @override
  String get ingredientUnit => 'Unit';

  @override
  String get ingredientCurrentStock => 'Current stock';

  @override
  String get ingredientThresholdStock => 'Low-stock threshold';

  @override
  String get ingredientThresholdHint =>
      'Warn when current stock reaches this level.';

  @override
  String ingredientStockLine(String current, String unit, String threshold) {
    return '$current $unit · threshold $threshold';
  }

  @override
  String get ingredientRestock => 'Restock';

  @override
  String ingredientRestockHint(String name) {
    return 'Add incoming quantity for $name.';
  }

  @override
  String get ingredientRestockQuantity => 'Incoming quantity';

  @override
  String get validationIngredientRestock => 'Enter a quantity greater than 0.';

  @override
  String get ingredientLowStockBadge => 'Low';

  @override
  String ingredientLowStockBanner(int count) {
    return '$count ingredients at or below threshold';
  }

  @override
  String ingredientStockPercent(int percent) {
    return '$percent% of capacity';
  }

  @override
  String get validationIngredientName => 'Enter a name up to 80 characters.';

  @override
  String get validationIngredientStock => 'Enter 0 or a positive number.';

  @override
  String get errorIngredientNameTaken =>
      'That ingredient name is already used here.';

  @override
  String get errorIngredientInUse =>
      'Remove this ingredient from article recipes before deleting it.';

  @override
  String get errorCompositionIngredientTaken =>
      'That ingredient is already on this article.';

  @override
  String get save => 'Save';

  @override
  String get close => 'Close';

  @override
  String articleCompositionTitle(String name) {
    return 'Recipe · $name';
  }

  @override
  String get articleCompositionHint =>
      'Optional. Add ingredients used for one serving of this article.';

  @override
  String get compositionEmpty => 'No recipe lines yet — that is fine.';

  @override
  String get compositionNone => 'No recipe';

  @override
  String compositionCount(int count) {
    return '$count ingredients';
  }

  @override
  String get compositionNeedIngredients =>
      'Add ingredients first, then build the recipe.';

  @override
  String get compositionAllIngredientsUsed =>
      'Every ingredient is already on this article.';

  @override
  String get compositionIngredient => 'Ingredient';

  @override
  String get compositionQuantity => 'Quantity per article';

  @override
  String get addCompositionLine => 'Add to recipe';

  @override
  String get editCompositionQuantity => 'Edit quantity';

  @override
  String get removeCompositionLine => 'Remove from recipe';

  @override
  String removeCompositionLineConfirm(String name) {
    return 'Remove $name from this recipe?';
  }

  @override
  String get unitGram => 'Gram (g)';

  @override
  String get unitKilogram => 'Kilogram (kg)';

  @override
  String get unitMilliliter => 'Milliliter (ml)';

  @override
  String get unitCentiliter => 'Centiliter (cl)';

  @override
  String get unitLiter => 'Liter (L)';

  @override
  String get unitPiece => 'Piece (each)';

  @override
  String get unitBottle => 'Bottle';

  @override
  String get unitCan => 'Can';

  @override
  String get unitPack => 'Pack';

  @override
  String get unitBox => 'Box';

  @override
  String get unitBunch => 'Bunch';

  @override
  String get unitTeaspoon => 'Teaspoon (tsp)';

  @override
  String get unitTablespoon => 'Tablespoon (tbsp)';

  @override
  String get unitCup => 'Cup';

  @override
  String get unitAbbrevGram => 'g';

  @override
  String get unitAbbrevKilogram => 'kg';

  @override
  String get unitAbbrevMilliliter => 'ml';

  @override
  String get unitAbbrevCentiliter => 'cl';

  @override
  String get unitAbbrevLiter => 'L';

  @override
  String get unitAbbrevPiece => 'pcs';

  @override
  String get unitAbbrevBottle => 'btl';

  @override
  String get unitAbbrevCan => 'can';

  @override
  String get unitAbbrevPack => 'pack';

  @override
  String get unitAbbrevBox => 'box';

  @override
  String get unitAbbrevBunch => 'bunch';

  @override
  String get unitAbbrevTeaspoon => 'tsp';

  @override
  String get unitAbbrevTablespoon => 'tbsp';

  @override
  String get unitAbbrevCup => 'cup';

  @override
  String get ordersHint =>
      'Create floor orders, advance kitchen status, and record payment.';

  @override
  String get ordersEmpty => 'No orders yet. Tap New order to start.';

  @override
  String get ordersFilterAll => 'All';

  @override
  String get ordersFilterEmpty => 'No orders match this status.';

  @override
  String get newOrder => 'New order';

  @override
  String get cancelOrderDraft => 'Cancel selection';

  @override
  String get orderResetArticles => 'Reset articles';

  @override
  String get orderChangeTable => 'Change table';

  @override
  String get orderCancelCreate => 'Cancel order';

  @override
  String get createOrder => 'Create order';

  @override
  String get newOrderHint =>
      'Select a table, then add articles. You are recorded as the launcher.';

  @override
  String get orderSelectTablePrompt => 'Select a table for this order.';

  @override
  String get orderSelectTableFloorHint =>
      'Tap a table on the floor map to continue adding articles.';

  @override
  String get orderTableInactive =>
      'That table is inactive. Choose an active table.';

  @override
  String get orderTableOccupied => 'This table already has an open order.';

  @override
  String get orderAppendArticles => 'Add articles';

  @override
  String get orderAppendArticlesDisabled =>
      'This venue does not allow adding articles to open orders.';

  @override
  String get orderNoActiveTables => 'No active tables. Create tables first.';

  @override
  String get orderSearchArticles => 'Search articles by name';

  @override
  String get orderAllCategories => 'All';

  @override
  String get orderNoArticlesMatch => 'No articles match this filter.';

  @override
  String get orderConfirm => 'Confirm order';

  @override
  String get orderAddUnit => 'Add unit';

  @override
  String get orderRemoveUnit => 'Remove unit';

  @override
  String get orderTableOptional => 'Table (optional)';

  @override
  String get orderNoTable => 'No table';

  @override
  String orderTableNumber(int number) {
    return 'Table $number';
  }

  @override
  String get orderNeedArticles =>
      'Add articles in Products before creating an order.';

  @override
  String get validationOrderItems => 'Add at least one article.';

  @override
  String get orderItemsLabel => 'items';

  @override
  String get orderItemsHeading => 'Items';

  @override
  String orderDetailTitle(String table) {
    return 'Order · $table';
  }

  @override
  String orderLaunchedBy(String actor) {
    return 'Launched by $actor';
  }

  @override
  String orderLastPaidBy(String actor) {
    return 'Last payment by $actor';
  }

  @override
  String get cancelOrder => 'Cancel order';

  @override
  String get cancelOrderConfirm => 'Cancel this order and open lines?';

  @override
  String get cancelOrderItem => 'Cancel item';

  @override
  String get orderItemInfo => 'Item details';

  @override
  String get orderInfo => 'Order dates';

  @override
  String get orderFieldCreatedAt => 'Created';

  @override
  String get orderFieldUpdatedAt => 'Updated';

  @override
  String get orderFieldPreparedAt => 'Prepared';

  @override
  String get orderFieldServedAt => 'Served';

  @override
  String get orderFieldPaidAt => 'Paid';

  @override
  String orderFieldPaidAtLabel(String when) {
    return 'Paid $when';
  }

  @override
  String get orderFieldPassedBy => 'Passed by';

  @override
  String get orderFieldPreparedBy => 'Prepared by';

  @override
  String get orderFieldServedBy => 'Served by';

  @override
  String get orderFieldPaidTo => 'Paid to';

  @override
  String get orderFieldCancelledBy => 'Cancelled by';

  @override
  String get orderFieldCancelledAt => 'Cancelled';

  @override
  String orderCancelledBy(String actor) {
    return 'Cancelled by $actor';
  }

  @override
  String orderFieldCancelledAtLabel(String when) {
    return 'Cancelled $when';
  }

  @override
  String orderFieldCreatedAtLabel(String when) {
    return 'Created $when';
  }

  @override
  String orderFieldUpdatedAtLabel(String when) {
    return 'Updated $when';
  }

  @override
  String get orderStatusProgress => 'In progress';

  @override
  String get orderStatusPayed => 'Payed';

  @override
  String get orderStatusCancelled => 'Cancelled';

  @override
  String get orderItemStatusProgress => 'Progress';

  @override
  String get orderItemStatusPicked => 'Picked';

  @override
  String get orderItemStatusReady => 'Ready';

  @override
  String get orderItemStatusServed => 'Served';

  @override
  String get orderItemStatusPayed => 'Payed';

  @override
  String get orderItemStatusCancelled => 'Cancelled';

  @override
  String get orderItemPayNow => 'Pay now';

  @override
  String get errorOrderInvalidStatus => 'That status change is not allowed.';

  @override
  String get errorOrderInsufficientStock =>
      'Not enough ingredient stock for this order.';

  @override
  String get errorOrderTableOccupied => 'This table already has an open order.';

  @override
  String get errorOrderAppendNotAllowed =>
      'Adding articles to open orders is not allowed for this venue.';
}
