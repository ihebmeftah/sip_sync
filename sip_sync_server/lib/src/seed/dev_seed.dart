import 'package:serverpod/serverpod.dart';

import '../auth/auth_support.dart';
import '../buildings/strict_mode.dart';
import '../employee_access/default_employee_access.dart';
import '../generated/protocol.dart';
import '../packs/pack_catalog.dart';
import '../packs/pack_history.dart';

/// Demo owners for local development.
///
/// Fifty venues in Tunisia and fifty in Germany. Each owner has one building,
/// a short menu, stock, and a rotating pack. Paid packs get a monthly or
/// yearly [Building.packExpiresAt]. Runs on boot when [tunisiaEmail] `01` is
/// missing. Wipe the development database to seed again.
class DevSeed {
  static const password = 'password1';
  static const perCountry = 50;

  /// First Tunisia owner. Presence of this email means the demo set exists.
  static const tunisiaEmail = 'owner.tn.01@sipsync.dev';

  /// Seeds the demo set when [tunisiaEmail] is not registered.
  static Future<void> ensureDemoData(Session session) async {
    final existing = await Owner.db.findFirstRow(
      session,
      where: (t) => t.email.equals(tunisiaEmail),
    );
    if (existing != null) {
      session.log('DevSeed: demo owners already present — skip.');
      return;
    }

    session.log(
      'DevSeed: creating $perCountry Tunisia and $perCountry Germany venues…',
    );
    final now = DateTime.now().toUtc();
    final tunisia = _spread(
      _tunisiaCities,
      perCountry,
      'Avenue Habib Bourguiba',
    );
    final germany = _spread(_germanyCities, perCountry, 'Hauptstraße');

    for (var i = 0; i < perCountry; i++) {
      await _seedOne(
        session,
        index: i,
        country: 'TN',
        currency: 'TND',
        ownerPhone: '+21621${(100000 + i).toString()}',
        venuePhone: '+21671${(100000 + i).toString()}',
        email: 'owner.tn.${(i + 1).toString().padLeft(2, '0')}@sipsync.dev',
        firstName: _tunisiaFirst[i % _tunisiaFirst.length],
        lastName: _tunisiaLast[i % _tunisiaLast.length],
        place: tunisia[i],
        now: now,
      );
      await _seedOne(
        session,
        index: i,
        country: 'DE',
        currency: 'EUR',
        ownerPhone: '+49151${(2000000 + i).toString()}',
        venuePhone: '+496421${(30000 + i).toString()}',
        email: 'owner.de.${(i + 1).toString().padLeft(2, '0')}@sipsync.dev',
        firstName: _germanyFirst[i % _germanyFirst.length],
        lastName: _germanyLast[i % _germanyLast.length],
        place: germany[i],
        now: now,
      );
    }

    session.log(
      'DevSeed: ready — owner.tn.01 … owner.de.$perCountry '
      '(password: $password)',
    );
  }

  static Future<void> _seedOne(
    Session session, {
    required int index,
    required String country,
    required String currency,
    required String ownerPhone,
    required String venuePhone,
    required String email,
    required String firstName,
    required String lastName,
    required _Place place,
    required DateTime now,
  }) async {
    final kind = _kinds[index % _kinds.length];
    final packCode = _packCodes[index % _packCodes.length];
    final yearly = index.isOdd;
    final menu = _menus[index % _menus.length](index);
    await _seedVenue(
      session,
      email: email,
      phone: ownerPhone,
      firstName: firstName,
      lastName: lastName,
      buildingName: '${_kindLabel(kind)} ${place.city} ${index + 1}',
      buildingType: kind,
      address: place.address,
      venuePhone: venuePhone,
      latitude: place.latitude,
      longitude: place.longitude,
      currencyCode: currency,
      countryCode: country,
      categories: menu.categories,
      ingredients: menu.ingredients,
      tableCount: 4 + (index % 4),
      packCode: packCode,
      billingPeriod: packCode == PackCatalog.freeCode
          ? null
          : (yearly ? PackBillingPeriod.yearly : PackBillingPeriod.monthly),
      expiresAt: packCode == PackCatalog.freeCode
          ? null
          : now.add(
              Duration(days: yearly ? 220 + (index % 120) : 16 + (index % 24)),
            ),
    );
  }

  /// Inserts one owner and one venue, then assigns [packCode] when it is paid.
  static Future<void> _seedVenue(
    Session session, {
    required String email,
    required String phone,
    required String firstName,
    required String lastName,
    required String buildingName,
    required String buildingType,
    required String address,
    required String venuePhone,
    required double latitude,
    required double longitude,
    required String currencyCode,
    required String countryCode,
    required List<_Category> categories,
    required List<_Ingredient> ingredients,
    required int tableCount,
    required String packCode,
    required PackBillingPeriod? billingPeriod,
    required DateTime? expiresAt,
  }) async {
    final savedOwner = await Owner.db.insertRow(
      session,
      Owner(
        email: email,
        phoneNumber: phone,
        firstName: firstName,
        lastName: lastName,
        passwordHash: AuthSupport().passwords.hash(password),
      ),
    );

    final free = await PackCatalog.requireFree(session);
    final building = await Building.db.insertRow(
      session,
      Building(
        ownerId: savedOwner.id!,
        packId: free.id!,
        name: buildingName,
        type: buildingType,
        address: address,
        latitude: latitude,
        longitude: longitude,
        openingMinutes: 480,
        closingMinutes: 1380,
        currencyCode: currencyCode,
        phoneNumber: venuePhone,
        countryCode: countryCode,
        whatsapp: venuePhone,
        instagram: null,
        facebook: null,
        otherLinks: const [],
        tableMultiOrder: false,
        allowAppendingItemsToOrder: true,
        strictMode: false,
        strictModeSteps: defaultStrictModeSteps(),
      ),
    );

    await BuildingPackHistory.openInitial(
      session,
      buildingId: building.id!,
      packId: free.id!,
    );

    if (packCode != PackCatalog.freeCode) {
      final pack = await Pack.db.findFirstRow(
        session,
        where: (t) => t.code.equals(packCode),
      );
      if (pack == null ||
          pack.id == null ||
          billingPeriod == null ||
          expiresAt == null) {
        throw StateError('DevSeed: pack $packCode is missing a term.');
      }
      await BuildingPackHistory.change(
        session,
        building: building,
        pack: pack,
        billingPeriod: billingPeriod,
        expiresAt: expiresAt.toUtc(),
        reason: BuildingPackEndReason.replaced,
      );
    }

    await DefaultEmployeeAccess.seedForBuilding(session, building.id!);

    for (var n = 1; n <= tableCount; n++) {
      await VenueTable.db.insertRow(
        session,
        VenueTable(
          buildingId: building.id!,
          number: n,
          maxSeats: n <= 2 ? 2 : 4,
          isActive: true,
        ),
      );
    }

    final ingredientByName = <String, Ingredient>{};
    for (final ing in ingredients) {
      final row = await Ingredient.db.insertRow(
        session,
        Ingredient(
          buildingId: building.id!,
          name: ing.name,
          unit: ing.unit,
          initialStock: ing.stock,
          currentStock: ing.stock,
          thresholdStock: ing.threshold,
        ),
      );
      ingredientByName[ing.name] = row;
    }

    for (final category in categories) {
      final cat = await MenuCategory.db.insertRow(
        session,
        MenuCategory(
          buildingId: building.id!,
          name: category.name,
          description: category.description,
        ),
      );
      for (final articleDef in category.articles) {
        final article = await MenuArticle.db.insertRow(
          session,
          MenuArticle(
            buildingId: building.id!,
            categoryId: cat.id!,
            name: articleDef.name,
            description: null,
            price: articleDef.price,
          ),
        );
        for (final line in articleDef.recipe) {
          final ingredient = ingredientByName[line.$1];
          if (ingredient == null) {
            throw StateError(
              'DevSeed: missing ingredient "${line.$1}" for ${articleDef.name}',
            );
          }
          await ArticleComposition.db.insertRow(
            session,
            ArticleComposition(
              articleId: article.id!,
              ingredientId: ingredient.id!,
              quantity: line.$2,
            ),
          );
        }
      }
    }
  }
}

typedef _Place = ({
  String city,
  String address,
  double latitude,
  double longitude,
});

typedef _Ingredient = ({
  String name,
  UnitsType unit,
  double stock,
  double threshold,
});

typedef _Article = ({
  String name,
  double price,
  List<(String, double)> recipe,
});

typedef _Category = ({
  String name,
  String description,
  List<_Article> articles,
});

typedef _Menu = ({List<_Category> categories, List<_Ingredient> ingredients});

const _packCodes = ['free', 'counter', 'floor', 'house', 'group'];
const _kinds = ['cafe', 'restaurant', 'lounge', 'bar'];

String _kindLabel(String kind) {
  return switch (kind) {
    'restaurant' => 'Restaurant',
    'lounge' => 'Lounge',
    'bar' => 'Bar',
    _ => 'Café',
  };
}

List<_Place> _spread(
  List<({String city, double lat, double lng})> cities,
  int count,
  String street,
) {
  return [
    for (var i = 0; i < count; i++)
      (
        city: cities[i % cities.length].city,
        address: '${3 + i * 2} $street, ${cities[i % cities.length].city}',
        latitude: cities[i % cities.length].lat + (i ~/ cities.length) * 0.006,
        longitude: cities[i % cities.length].lng + (i % 3) * 0.003,
      ),
  ];
}

const _tunisiaCities = <({String city, double lat, double lng})>[
  (city: 'Tunis', lat: 36.8065, lng: 10.1815),
  (city: 'La Marsa', lat: 36.8782, lng: 10.3247),
  (city: 'Carthage', lat: 36.8528, lng: 10.3236),
  (city: 'Sidi Bou Said', lat: 36.8702, lng: 10.3417),
  (city: 'Ariana', lat: 36.8625, lng: 10.1956),
  (city: 'Sousse', lat: 35.8256, lng: 10.6360),
  (city: 'Sfax', lat: 34.7406, lng: 10.7603),
  (city: 'Hammamet', lat: 36.4000, lng: 10.6167),
  (city: 'Nabeul', lat: 36.4561, lng: 10.7376),
  (city: 'Bizerte', lat: 37.2744, lng: 9.8739),
  (city: 'Monastir', lat: 35.7643, lng: 10.8113),
  (city: 'Mahdia', lat: 35.5047, lng: 11.0622),
  (city: 'Kairouan', lat: 35.6781, lng: 10.0963),
  (city: 'Djerba', lat: 33.8076, lng: 10.8451),
  (city: 'Gabes', lat: 33.8815, lng: 10.0982),
  (city: 'Tozeur', lat: 33.9197, lng: 8.1335),
  (city: 'Gafsa', lat: 34.4250, lng: 8.7842),
  (city: 'Beja', lat: 36.7256, lng: 9.1817),
  (city: 'Jendouba', lat: 36.5011, lng: 8.7802),
  (city: 'Kasserine', lat: 35.1676, lng: 8.8365),
  (city: 'Zaghouan', lat: 36.4029, lng: 10.1429),
  (city: 'Le Kef', lat: 36.1822, lng: 8.7148),
  (city: 'Medenine', lat: 33.3399, lng: 10.4959),
  (city: 'Tataouine', lat: 32.9297, lng: 10.4518),
  (city: 'Siliana', lat: 36.0849, lng: 9.3708),
];

const _germanyCities = <({String city, double lat, double lng})>[
  (city: 'Marburg', lat: 50.8021, lng: 8.7667),
  (city: 'Kirchhain', lat: 50.8270, lng: 8.9283),
  (city: 'Kassel', lat: 51.3127, lng: 9.4797),
  (city: 'Frankfurt', lat: 50.1109, lng: 8.6821),
  (city: 'Giessen', lat: 50.5841, lng: 8.6784),
  (city: 'Wetzlar', lat: 50.5611, lng: 8.5019),
  (city: 'Fulda', lat: 50.5558, lng: 9.6808),
  (city: 'Bad Nauheim', lat: 50.3647, lng: 8.7386),
  (city: 'Hanau', lat: 50.1326, lng: 8.9160),
  (city: 'Offenbach', lat: 50.0956, lng: 8.7761),
  (city: 'Darmstadt', lat: 49.8728, lng: 8.6512),
  (city: 'Wiesbaden', lat: 50.0782, lng: 8.2398),
  (city: 'Mainz', lat: 49.9929, lng: 8.2473),
  (city: 'Limburg', lat: 50.3836, lng: 8.0640),
  (city: 'Alsfeld', lat: 50.7516, lng: 9.2711),
  (city: 'Stadtallendorf', lat: 50.8264, lng: 9.0131),
  (city: 'Wetter', lat: 50.9022, lng: 8.7231),
  (city: 'Cölbe', lat: 50.8508, lng: 8.7847),
  (city: 'Bad Hersfeld', lat: 50.8681, lng: 9.7086),
  (city: 'Friedberg', lat: 50.3370, lng: 8.7556),
  (city: 'Butzbach', lat: 50.4364, lng: 8.6622),
  (city: 'Marburg-Cappel', lat: 50.7750, lng: 8.7780),
  (city: 'Kirchhain-Anzefahr', lat: 50.8400, lng: 8.9100),
  (city: 'Kassel-Wilhelmshohe', lat: 51.3130, lng: 9.4160),
  (city: 'Frankfurt-Sachsenhausen', lat: 50.1000, lng: 8.6880),
];

const _tunisiaFirst = [
  'Amine',
  'Sarra',
  'Yassine',
  'Ines',
  'Omar',
  'Leila',
  'Hatem',
  'Mariem',
  'Sami',
  'Nour',
  'Khaled',
  'Rania',
  'Aziz',
  'Hela',
  'Mehdi',
  'Yosra',
  'Fares',
  'Amira',
  'Walid',
  'Salma',
  'Bilel',
  'Chaima',
  'Anis',
  'Rym',
  'Tarek',
];

const _tunisiaLast = [
  'Benali',
  'Trabelsi',
  'Gharbi',
  'Jaziri',
  'Mansouri',
  'Bouzid',
  'Chaabane',
  'Mejri',
  'Saidi',
  'Hamdi',
  'Khelifi',
  'Ayari',
  'Dridi',
  'Ferchichi',
  'Baccar',
];

const _germanyFirst = [
  'Lukas',
  'Anna',
  'Jonas',
  'Lena',
  'Felix',
  'Marie',
  'Paul',
  'Sofia',
  'Niklas',
  'Emma',
  'Tim',
  'Laura',
  'Max',
  'Julia',
  'Ben',
  'Hannah',
  'Finn',
  'Lea',
  'Jan',
  'Mia',
];

const _germanyLast = [
  'Schneider',
  'Muller',
  'Weber',
  'Fischer',
  'Wagner',
  'Becker',
  'Hoffmann',
  'Schafer',
  'Koch',
  'Bauer',
  'Richter',
  'Klein',
  'Wolf',
  'Neumann',
  'Schwarz',
];

final _menus = <_Menu Function(int)>[
  _cafeMenu,
  _restaurantMenu,
  _teaMenu,
  _barMenu,
];

_Menu _cafeMenu(int index) {
  final bump = (index % 4) * 0.25;
  return (
    categories: [
      (
        name: 'Coffee',
        description: 'Espresso bar',
        articles: [
          (
            name: 'Espresso',
            price: 3.5 + bump,
            recipe: [('Espresso beans', 18.0)],
          ),
          (
            name: 'Latte',
            price: 7.0 + bump,
            recipe: [('Espresso beans', 18.0), ('Milk', 200.0)],
          ),
          (
            name: 'Cappuccino',
            price: 6.5 + bump,
            recipe: [('Espresso beans', 18.0), ('Milk', 120.0)],
          ),
        ],
      ),
      (
        name: 'Pastries',
        description: 'Counter sweets',
        articles: [
          (
            name: 'Croissant',
            price: 4.5 + bump,
            recipe: [('Flour', 50.0), ('Butter', 30.0)],
          ),
          (
            name: 'Pain au chocolat',
            price: 5.0 + bump,
            recipe: [('Flour', 45.0), ('Butter', 25.0), ('Sugar', 10.0)],
          ),
        ],
      ),
    ],
    ingredients: const [
      (
        name: 'Espresso beans',
        unit: UnitsType.gram,
        stock: 4000,
        threshold: 400,
      ),
      (name: 'Milk', unit: UnitsType.milliliter, stock: 12000, threshold: 1000),
      (name: 'Flour', unit: UnitsType.gram, stock: 8000, threshold: 800),
      (name: 'Butter', unit: UnitsType.gram, stock: 3000, threshold: 300),
      (name: 'Sugar', unit: UnitsType.gram, stock: 3000, threshold: 300),
    ],
  );
}

_Menu _restaurantMenu(int index) {
  final bump = (index % 4) * 0.5;
  return (
    categories: [
      (
        name: 'Grill',
        description: 'Plates from the kitchen',
        articles: [
          (
            name: 'Chicken skewers',
            price: 18.0 + bump,
            recipe: [('Chicken', 180.0), ('Olive oil', 10.0)],
          ),
          (
            name: 'Kefta',
            price: 16.0 + bump,
            recipe: [('Beef', 160.0), ('Onion', 30.0)],
          ),
        ],
      ),
      (
        name: 'Salads',
        description: 'Fresh sides',
        articles: [
          (
            name: 'Green salad',
            price: 8.0 + bump,
            recipe: [('Lettuce', 80.0), ('Olive oil', 10.0)],
          ),
          (
            name: 'Mechouia',
            price: 9.0 + bump,
            recipe: [('Tomato', 100.0), ('Onion', 20.0), ('Olive oil', 8.0)],
          ),
        ],
      ),
    ],
    ingredients: const [
      (name: 'Chicken', unit: UnitsType.gram, stock: 6000, threshold: 800),
      (name: 'Beef', unit: UnitsType.gram, stock: 5000, threshold: 700),
      (
        name: 'Olive oil',
        unit: UnitsType.milliliter,
        stock: 2000,
        threshold: 200,
      ),
      (name: 'Onion', unit: UnitsType.gram, stock: 2000, threshold: 200),
      (name: 'Lettuce', unit: UnitsType.gram, stock: 1500, threshold: 200),
      (name: 'Tomato', unit: UnitsType.gram, stock: 2500, threshold: 300),
    ],
  );
}

_Menu _teaMenu(int index) {
  final bump = (index % 4) * 0.25;
  return (
    categories: [
      (
        name: 'Tea',
        description: 'Pots and glasses',
        articles: [
          (
            name: 'Mint tea',
            price: 4.0 + bump,
            recipe: [('Mint', 10.0), ('Sugar', 15.0)],
          ),
          (
            name: 'Pine nut tea',
            price: 7.0 + bump,
            recipe: [('Mint', 8.0), ('Pine nuts', 8.0), ('Sugar', 15.0)],
          ),
        ],
      ),
      (
        name: 'Sweets',
        description: 'Fried and baked',
        articles: [
          (
            name: 'Bambalouni',
            price: 2.5 + bump,
            recipe: [('Flour', 40.0), ('Frying oil', 30.0)],
          ),
          (
            name: 'Kaak',
            price: 3.5 + bump,
            recipe: [('Flour', 35.0), ('Sugar', 10.0)],
          ),
        ],
      ),
    ],
    ingredients: const [
      (name: 'Mint', unit: UnitsType.gram, stock: 600, threshold: 60),
      (name: 'Sugar', unit: UnitsType.gram, stock: 3000, threshold: 300),
      (name: 'Pine nuts', unit: UnitsType.gram, stock: 800, threshold: 80),
      (name: 'Flour', unit: UnitsType.gram, stock: 5000, threshold: 500),
      (
        name: 'Frying oil',
        unit: UnitsType.milliliter,
        stock: 4000,
        threshold: 400,
      ),
    ],
  );
}

_Menu _barMenu(int index) {
  final bump = (index % 4) * 0.5;
  return (
    categories: [
      (
        name: 'Drinks',
        description: 'Soft and mixed',
        articles: [
          (name: 'Orange juice', price: 6.0 + bump, recipe: [('Oranges', 2.0)]),
          (
            name: 'Lemonade',
            price: 5.0 + bump,
            recipe: [('Lemon', 1.0), ('Sugar', 20.0)],
          ),
          (
            name: 'Sparkling water',
            price: 3.0 + bump,
            recipe: [('Water', 1.0)],
          ),
        ],
      ),
      (
        name: 'Snacks',
        description: 'Bar bites',
        articles: [
          (
            name: 'Olives',
            price: 6.0 + bump,
            recipe: [('Olives', 80.0), ('Olive oil', 5.0)],
          ),
          (
            name: 'Fries',
            price: 7.0 + bump,
            recipe: [('Potato', 200.0), ('Frying oil', 40.0)],
          ),
        ],
      ),
    ],
    ingredients: const [
      (name: 'Oranges', unit: UnitsType.piece, stock: 40, threshold: 8),
      (name: 'Lemon', unit: UnitsType.piece, stock: 30, threshold: 6),
      (name: 'Sugar', unit: UnitsType.gram, stock: 2000, threshold: 200),
      (name: 'Water', unit: UnitsType.bottle, stock: 48, threshold: 12),
      (name: 'Olives', unit: UnitsType.gram, stock: 2000, threshold: 200),
      (
        name: 'Olive oil',
        unit: UnitsType.milliliter,
        stock: 1500,
        threshold: 150,
      ),
      (name: 'Potato', unit: UnitsType.gram, stock: 8000, threshold: 800),
      (
        name: 'Frying oil',
        unit: UnitsType.milliliter,
        stock: 4000,
        threshold: 400,
      ),
    ],
  );
}
