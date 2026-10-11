part of 'dev_seed.dart';

/// Published venues used by [DevSeed].
///
/// Names and streets come from the venues' own sites or public listings.
/// Coordinates are OpenStreetMap pins for that address. A few medina doors
/// are not mapped, so those pins sit on the nearest mapped landmark on the
/// same street.
enum _Cuisine { tunisian, swedish, german }

class _Venue {
  const _Venue({
    required this.country,
    required this.city,
    required this.name,
    required this.type,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.phone,
    required this.currency,
    required this.cuisine,
  });

  final String country;
  final String city;
  final String name;
  final String type;
  final String address;
  final double latitude;
  final double longitude;
  final String phone;
  final String currency;
  final _Cuisine cuisine;
}

typedef _Ingredient = ({
  String name,
  UnitsType unit,
  double stock,
  double threshold,
});

typedef _Dish = ({String name, String description, double price});

typedef _Article = ({
  String name,
  String description,
  double price,
  List<(String, double)> recipe,
});

typedef _Category = ({
  String name,
  String description,
  List<_Article> articles,
});

typedef _Menu = ({List<_Category> categories, List<_Ingredient> ingredients});

typedef _MenuCategoryTemplate = ({
  String name,
  String description,
  List<(String, double)> recipe,
  List<_Dish> dishes,
});

_Dish _d(String name, String description, double price) =>
    (name: name, description: description, price: price);

const _venues = <_Venue>[
  _Venue(
    country: 'TN',
    city: 'Sousse',
    name: 'Restaurant Café Seles',
    type: 'restaurant',
    address: '42 Rue Abou Nawas, Medina, Sousse',
    latitude: 35.8242,
    longitude: 10.6354,
    phone: '+21673001001',
    currency: 'TND',
    cuisine: _Cuisine.tunisian,
  ),
  _Venue(
    country: 'TN',
    city: 'Sousse',
    name: 'Café El Kasbah',
    type: 'cafe',
    address: 'Rue Souq El Qaid, Medina, Sousse',
    latitude: 35.8247856,
    longitude: 10.6371704,
    phone: '+21673001002',
    currency: 'TND',
    cuisine: _Cuisine.tunisian,
  ),
  _Venue(
    country: 'TN',
    city: 'Sousse',
    name: 'Le Petit Café Maure',
    type: 'cafe',
    address: 'Medina, near the Ribat, Sousse',
    latitude: 35.82695,
    longitude: 10.6387,
    phone: '+21673001003',
    currency: 'TND',
    cuisine: _Cuisine.tunisian,
  ),
  _Venue(
    country: 'TN',
    city: 'Sousse',
    name: 'Dar el Habib',
    type: 'restaurant',
    address: '52 Rue Sidi Bouraoui, Medina, Sousse',
    latitude: 35.8256123,
    longitude: 10.6373372,
    phone: '+21673001004',
    currency: 'TND',
    cuisine: _Cuisine.tunisian,
  ),
  _Venue(
    country: 'TN',
    city: 'Tunis',
    name: 'Le Grand Café du Théâtre',
    type: 'cafe',
    address: 'Avenue Habib Bourguiba, Tunis',
    latitude: 36.79915,
    longitude: 10.181,
    phone: '+21671334186',
    currency: 'TND',
    cuisine: _Cuisine.tunisian,
  ),
  _Venue(
    country: 'TN',
    city: 'Tunis',
    name: 'Café El Mrabet',
    type: 'cafe',
    address: '27 Souk El Trouk, Medina, Tunis',
    latitude: 36.79739,
    longitude: 10.17022,
    phone: '+21671001001',
    currency: 'TND',
    cuisine: _Cuisine.tunisian,
  ),
  _Venue(
    country: 'TN',
    city: 'Tunis',
    name: 'El Ali',
    type: 'restaurant',
    address: 'Rue Jamaa Ez Zitouna, Medina, Tunis',
    latitude: 36.79813,
    longitude: 10.17296,
    phone: '+21671321927',
    currency: 'TND',
    cuisine: _Cuisine.tunisian,
  ),
  _Venue(
    country: 'TN',
    city: 'Tunis',
    name: 'Dar Chikh',
    type: 'restaurant',
    address: '99 Rue de la Kasbah, Medina, Tunis',
    latitude: 36.799333,
    longitude: 10.172136,
    phone: '+21696104318',
    currency: 'TND',
    cuisine: _Cuisine.tunisian,
  ),
  _Venue(
    country: 'TN',
    city: 'Tunis',
    name: 'Café de Paris',
    type: 'cafe',
    address: 'Avenue Habib Bourguiba, Tunis',
    latitude: 36.80005,
    longitude: 10.1793,
    phone: '+21671001002',
    currency: 'TND',
    cuisine: _Cuisine.tunisian,
  ),
  _Venue(
    country: 'TN',
    city: 'Tunis',
    name: 'Dar El Jeld',
    type: 'restaurant',
    address: 'Rue Dar El Jeld, Medina, Tunis',
    latitude: 36.7993579,
    longitude: 10.1685926,
    phone: '+21671001003',
    currency: 'TND',
    cuisine: _Cuisine.tunisian,
  ),
  _Venue(
    country: 'TN',
    city: 'Hammamet',
    name: 'Lella Fatma',
    type: 'restaurant',
    address: 'Avenue Habib Bourguiba, Hammamet',
    latitude: 36.4028938,
    longitude: 10.6114936,
    phone: '+21672283600',
    currency: 'TND',
    cuisine: _Cuisine.tunisian,
  ),
  _Venue(
    country: 'TN',
    city: 'Hammamet',
    name: 'Le Barberousse',
    type: 'restaurant',
    address: 'Ville Arabe, Medina, Hammamet',
    latitude: 36.3942,
    longitude: 10.61255,
    phone: '+21672280037',
    currency: 'TND',
    cuisine: _Cuisine.tunisian,
  ),
  _Venue(
    country: 'TN',
    city: 'Hammamet',
    name: 'Café Sidi Bouhdid',
    type: 'cafe',
    address: 'Rue Sidi Bouhdid, Hammamet',
    latitude: 36.3945445,
    longitude: 10.6121028,
    phone: '+21672001001',
    currency: 'TND',
    cuisine: _Cuisine.tunisian,
  ),
  _Venue(
    country: 'TN',
    city: 'Hammamet',
    name: 'Aloha Resto Café',
    type: 'cafe',
    address: 'Avenue Moncef Bey, Hammamet',
    latitude: 36.4002,
    longitude: 10.6148,
    phone: '+21629614904',
    currency: 'TND',
    cuisine: _Cuisine.tunisian,
  ),
  _Venue(
    country: 'SE',
    city: 'Stockholm',
    name: 'Café Kaffekoppen',
    type: 'cafe',
    address: 'Stortorget 20, 111 29 Stockholm',
    latitude: 59.3248991,
    longitude: 18.0703806,
    phone: '+468203170',
    currency: 'SEK',
    cuisine: _Cuisine.swedish,
  ),
  _Venue(
    country: 'SE',
    city: 'Stockholm',
    name: 'Chokladkoppen',
    type: 'cafe',
    address: 'Stortorget 18, 111 29 Stockholm',
    latitude: 59.3249577,
    longitude: 18.070342,
    phone: '+468203170',
    currency: 'SEK',
    cuisine: _Cuisine.swedish,
  ),
  _Venue(
    country: 'SE',
    city: 'Stockholm',
    name: 'Café Schweizer',
    type: 'cafe',
    address: 'Västerlånggatan 9, 111 29 Stockholm',
    latitude: 59.3261333,
    longitude: 18.0688253,
    phone: '+4684115177',
    currency: 'SEK',
    cuisine: _Cuisine.swedish,
  ),
  _Venue(
    country: 'SE',
    city: 'Stockholm',
    name: 'Magnus Ladulås',
    type: 'restaurant',
    address: 'Österlånggatan 26, 111 31 Stockholm',
    latitude: 59.3239281,
    longitude: 18.0736695,
    phone: '+468211957',
    currency: 'SEK',
    cuisine: _Cuisine.swedish,
  ),
  _Venue(
    country: 'SE',
    city: 'Stockholm',
    name: 'Ardbeg Embassy',
    type: 'bar',
    address: 'Västerlånggatan 68, 111 29 Stockholm',
    latitude: 59.3231575,
    longitude: 18.07202,
    phone: '+46820001001',
    currency: 'SEK',
    cuisine: _Cuisine.swedish,
  ),
  _Venue(
    country: 'SE',
    city: 'Stockholm',
    name: 'Den Gyldene Freden',
    type: 'restaurant',
    address: 'Österlånggatan 51, 111 31 Stockholm',
    latitude: 59.3231266,
    longitude: 18.0737397,
    phone: '+46820001002',
    currency: 'SEK',
    cuisine: _Cuisine.swedish,
  ),
  _Venue(
    country: 'DE',
    city: 'Marburg',
    name: 'Café Vetter',
    type: 'cafe',
    address: 'Reitgasse 4, 35037 Marburg',
    latitude: 50.8086529,
    longitude: 8.7717949,
    phone: '+49642125888',
    currency: 'EUR',
    cuisine: _Cuisine.german,
  ),
  _Venue(
    country: 'DE',
    city: 'Marburg',
    name: 'Café am Markt',
    type: 'cafe',
    address: 'Markt 9, 35037 Marburg',
    latitude: 50.8091321,
    longitude: 8.7708073,
    phone: '+496421200001',
    currency: 'EUR',
    cuisine: _Cuisine.german,
  ),
  _Venue(
    country: 'DE',
    city: 'Marburg',
    name: 'Café Paprica',
    type: 'cafe',
    address: 'Reitgasse 12, 35037 Marburg',
    latitude: 50.8092638,
    longitude: 8.7712641,
    phone: '+4964213400808',
    currency: 'EUR',
    cuisine: _Cuisine.german,
  ),
  _Venue(
    country: 'DE',
    city: 'Frankfurt',
    name: 'Apfelwein Wagner',
    type: 'restaurant',
    address: 'Schweizer Straße 71, 60594 Frankfurt am Main',
    latitude: 50.1005311,
    longitude: 8.6820009,
    phone: '+4969612565',
    currency: 'EUR',
    cuisine: _Cuisine.german,
  ),
  _Venue(
    country: 'DE',
    city: 'Frankfurt',
    name: 'Zum Gemalten Haus',
    type: 'restaurant',
    address: 'Schweizer Straße 67, 60594 Frankfurt am Main',
    latitude: 50.1007072,
    longitude: 8.6818716,
    phone: '+496920001067',
    currency: 'EUR',
    cuisine: _Cuisine.german,
  ),
  _Venue(
    country: 'DE',
    city: 'Frankfurt',
    name: 'Café Hauptwache',
    type: 'cafe',
    address: 'An der Hauptwache 15, 60313 Frankfurt am Main',
    latitude: 50.1134919,
    longitude: 8.6787335,
    phone: '+496920001015',
    currency: 'EUR',
    cuisine: _Cuisine.german,
  ),
  _Venue(
    country: 'DE',
    city: 'Frankfurt',
    name: 'Café Extrablatt Eschenheimer Tor',
    type: 'cafe',
    address: 'Große Eschenheimer Straße 45, 60313 Frankfurt am Main',
    latitude: 50.1166281,
    longitude: 8.6795235,
    phone: '+496921994899',
    currency: 'EUR',
    cuisine: _Cuisine.german,
  ),
  _Venue(
    country: 'DE',
    city: 'Gießen',
    name: 'Bootshaus',
    type: 'restaurant',
    address: 'Bootshausstraße 12, 35390 Gießen',
    latitude: 50.589845,
    longitude: 8.6696116,
    phone: '+4964168692555',
    currency: 'EUR',
    cuisine: _Cuisine.german,
  ),
  _Venue(
    country: 'DE',
    city: 'Gießen',
    name: 'Türmchen',
    type: 'cafe',
    address: 'Marktplatz 7, 35390 Gießen',
    latitude: 50.5869352,
    longitude: 8.6745698,
    phone: '+4964138433',
    currency: 'EUR',
    cuisine: _Cuisine.german,
  ),
  _Venue(
    country: 'DE',
    city: 'Gießen',
    name: 'Studentenfutter',
    type: 'cafe',
    address: 'Kreuzplatz 2, 35390 Gießen',
    latitude: 50.5854523,
    longitude: 8.6748215,
    phone: '+4964158178950',
    currency: 'EUR',
    cuisine: _Cuisine.german,
  ),
];

const _expectedCities = <String, int>{
  'Sousse': 4,
  'Tunis': 6,
  'Hammamet': 4,
  'Stockholm': 6,
  'Marburg': 3,
  'Frankfurt': 4,
  'Gießen': 3,
};

String _ownerPhone(String country, int index) {
  final national = (100000 + index).toString();
  return switch (country) {
    'TN' => '+21621$national',
    'SE' => '+46701$national',
    'DE' => '+491511$national',
    _ => throw StateError('DevSeed: unknown country $country'),
  };
}

String _firstName(String country, int index) {
  final names = switch (country) {
    'TN' => _tunisiaFirst,
    'SE' => _swedenFirst,
    'DE' => _germanyFirst,
    _ => throw StateError('DevSeed: unknown country $country'),
  };
  return names[index % names.length];
}

String _lastName(String country, int index) {
  final names = switch (country) {
    'TN' => _tunisiaLast,
    'SE' => _swedenLast,
    'DE' => _germanyLast,
    _ => throw StateError('DevSeed: unknown country $country'),
  };
  return names[index % names.length];
}

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
];

const _swedenFirst = [
  'Erik',
  'Astrid',
  'Lars',
  'Linnea',
  'Oscar',
  'Maja',
];

const _swedenLast = [
  'Andersson',
  'Lindberg',
  'Bergström',
  'Nilsson',
  'Holm',
  'Ek',
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
];

const _germanyLast = [
  'Schneider',
  'Müller',
  'Weber',
  'Fischer',
  'Wagner',
  'Becker',
  'Hoffmann',
  'Koch',
  'Bauer',
  'Richter',
];

const _pantryTunisian = <_Ingredient>[
  (name: 'Café moulu', unit: UnitsType.gram, stock: 5000, threshold: 500),
  (name: 'Lait', unit: UnitsType.milliliter, stock: 20000, threshold: 2000),
  (name: 'Sucre', unit: UnitsType.gram, stock: 4000, threshold: 400),
  (name: 'Menthe', unit: UnitsType.gram, stock: 800, threshold: 80),
  (name: 'Farine', unit: UnitsType.gram, stock: 8000, threshold: 800),
  (name: 'Beurre', unit: UnitsType.gram, stock: 3000, threshold: 300),
  (name: 'Pain', unit: UnitsType.piece, stock: 40, threshold: 8),
  (name: 'Œufs', unit: UnitsType.piece, stock: 60, threshold: 12),
  (name: 'Tomate', unit: UnitsType.gram, stock: 4000, threshold: 400),
  (
    name: "Huile d'olive",
    unit: UnitsType.milliliter,
    stock: 3000,
    threshold: 300,
  ),
  (name: 'Poulet', unit: UnitsType.gram, stock: 8000, threshold: 800),
  (name: 'Poisson', unit: UnitsType.gram, stock: 6000, threshold: 600),
  (name: 'Citron', unit: UnitsType.piece, stock: 40, threshold: 8),
  (name: 'Pomme de terre', unit: UnitsType.gram, stock: 8000, threshold: 800),
];

const _pantrySwedish = <_Ingredient>[
  (name: 'Kaffebönor', unit: UnitsType.gram, stock: 5000, threshold: 500),
  (name: 'Mjölk', unit: UnitsType.milliliter, stock: 20000, threshold: 2000),
  (name: 'Socker', unit: UnitsType.gram, stock: 4000, threshold: 400),
  (name: 'Mynta', unit: UnitsType.gram, stock: 800, threshold: 80),
  (name: 'Mjöl', unit: UnitsType.gram, stock: 8000, threshold: 800),
  (name: 'Smör', unit: UnitsType.gram, stock: 3000, threshold: 300),
  (name: 'Bröd', unit: UnitsType.piece, stock: 40, threshold: 8),
  (name: 'Ägg', unit: UnitsType.piece, stock: 60, threshold: 12),
  (name: 'Tomat', unit: UnitsType.gram, stock: 4000, threshold: 400),
  (name: 'Olivolja', unit: UnitsType.milliliter, stock: 3000, threshold: 300),
  (name: 'Kyckling', unit: UnitsType.gram, stock: 8000, threshold: 800),
  (name: 'Fisk', unit: UnitsType.gram, stock: 6000, threshold: 600),
  (name: 'Citron', unit: UnitsType.piece, stock: 40, threshold: 8),
  (name: 'Potatis', unit: UnitsType.gram, stock: 8000, threshold: 800),
];

const _pantryGerman = <_Ingredient>[
  (name: 'Kaffeebohnen', unit: UnitsType.gram, stock: 5000, threshold: 500),
  (name: 'Milch', unit: UnitsType.milliliter, stock: 20000, threshold: 2000),
  (name: 'Zucker', unit: UnitsType.gram, stock: 4000, threshold: 400),
  (name: 'Minze', unit: UnitsType.gram, stock: 800, threshold: 80),
  (name: 'Mehl', unit: UnitsType.gram, stock: 8000, threshold: 800),
  (name: 'Butter', unit: UnitsType.gram, stock: 3000, threshold: 300),
  (name: 'Brot', unit: UnitsType.piece, stock: 40, threshold: 8),
  (name: 'Eier', unit: UnitsType.piece, stock: 60, threshold: 12),
  (name: 'Tomate', unit: UnitsType.gram, stock: 4000, threshold: 400),
  (name: 'Olivenöl', unit: UnitsType.milliliter, stock: 3000, threshold: 300),
  (name: 'Hähnchen', unit: UnitsType.gram, stock: 8000, threshold: 800),
  (name: 'Fisch', unit: UnitsType.gram, stock: 6000, threshold: 600),
  (name: 'Zitrone', unit: UnitsType.piece, stock: 40, threshold: 8),
  (name: 'Kartoffeln', unit: UnitsType.gram, stock: 8000, threshold: 800),
];

final _tunisianMenu = <_MenuCategoryTemplate>[
  (
    name: 'Café',
    description: 'Expresso et cafés au lait',
    recipe: [('Café moulu', 18), ('Lait', 80)],
    dishes: [
      _d('Espresso', 'Tasse courte', 2.8),
      _d('Café allongé', 'Expresso allongé', 3.2),
      _d('Cappuccino', 'Expresso, lait, mousse', 4.5),
      _d('Café au lait', 'Café et lait chaud', 3.8),
      _d('Café turc', 'Café serré à la cardamome', 4.0),
      _d('Café noisette', 'Expresso taché de lait', 3.5),
      _d('Café crème', 'Café avec crème', 4.2),
      _d('Direct', 'Expresso serré', 3.0),
      _d('Décaféiné', 'Café sans caféine', 3.5),
      _d('Café américain', 'Grand café filtre', 4.0),
    ],
  ),
  (
    name: 'Thé',
    description: 'Théières et verres',
    recipe: [('Menthe', 8), ('Sucre', 15)],
    dishes: [
      _d('Thé à la menthe', 'Menthe fraîche et sucre', 3.5),
      _d('Thé aux pignons', 'Thé à la menthe et pignons', 6.5),
      _d('Thé à l\'amande', 'Thé parfumé à l\'amande', 6.0),
      _d('Thé vert', 'Thé vert nature', 3.5),
      _d('Thé rouge', 'Infusion rouge', 3.5),
      _d('Infusion verveine', 'Verveine chaude', 4.0),
      _d('Thé aux fleurs d\'oranger', 'Fleurs d\'oranger', 5.0),
      _d('Thé au citron', 'Thé citronné', 4.0),
      _d('Thé karkadé', 'Hibiscus froid ou chaud', 4.0),
      _d('Thé aux dattes', 'Thé sucré aux dattes', 5.5),
    ],
  ),
  (
    name: 'Jus frais',
    description: 'Pressés du jour',
    recipe: [('Citron', 2), ('Sucre', 10)],
    dishes: [
      _d('Jus d\'orange', 'Oranges pressées', 5.0),
      _d('Jus de citron', 'Citron frais', 4.5),
      _d('Jus de fraise', 'Fraises mixées', 6.0),
      _d('Jus d\'avocat', 'Avocat et lait', 7.0),
      _d('Jus de banane', 'Banane mixée', 6.0),
      _d('Jus de mangue', 'Mangue fraîche', 7.0),
      _d('Cocktail de fruits', 'Mélange de saison', 7.5),
      _d('Jus de grenade', 'Grenade pressée', 6.5),
      _d('Jus de pomme', 'Pommes pressées', 5.5),
      _d('Jus de pastèque', 'Pastèque mixée', 5.0),
    ],
  ),
  (
    name: 'Pâtisseries',
    description: 'Sucré du comptoir',
    recipe: [('Farine', 40), ('Beurre', 20), ('Sucre', 10)],
    dishes: [
      _d('Croissant', 'Beurre feuilleté', 2.8),
      _d('Pain au chocolat', 'Feuilleté au chocolat', 3.2),
      _d('Mille-feuille', 'Crème et feuilletage', 4.5),
      _d('Baklawa', 'Feuilles et miel', 5.0),
      _d('Makroud', 'Semoule et dattes', 3.5),
      _d('Kaak warka', 'Anneau aux amandes', 3.0),
      _d('Bambalouni', 'Beignet sucré', 2.5),
      _d('Corne de gazelle', 'Pâtisserie aux amandes', 4.0),
      _d('Éclair', 'Pâte à choux au chocolat', 4.2),
      _d('Tarte au citron', 'Tarte citron meringuée', 4.8),
    ],
  ),
  (
    name: 'Petit déjeuner',
    description: 'Assiettes du matin',
    recipe: [('Œufs', 2), ('Pain', 1)],
    dishes: [
      _d('Petit déjeuner tunisien', 'Œufs, fromage, olives, miel', 12.0),
      _d('Omelette nature', 'Omelette simple', 7.0),
      _d('Ojja merguez', 'Œufs, tomate, merguez', 14.0),
      _d('Shakshuka', 'Œufs pochés à la tomate', 12.0),
      _d('Mlawi thon', 'Galette au thon', 8.0),
      _d('Chapati escalope', 'Chapati et escalope', 9.0),
      _d('Fricassé', 'Beignet frit farci', 6.5),
      _d('Lablabi', 'Soupe de pois chiches', 7.0),
      _d('Bsissa', 'Semoule d\'orge et huile', 5.0),
      _d('Assida zgougou', 'Crème de pignons', 6.0),
    ],
  ),
  (
    name: 'Salades',
    description: 'Entrées fraîches',
    recipe: [('Tomate', 80), ("Huile d'olive", 10)],
    dishes: [
      _d('Salade mechouia', 'Poivrons et tomates grillés', 8.0),
      _d('Salade tunisienne', 'Tomate, oignon, thon', 9.0),
      _d('Salade verte', 'Laitue assaisonnée', 7.0),
      _d('Salade de thon', 'Thon, œuf, olives', 11.0),
      _d('Salade d\'olives', 'Olives marinées', 6.0),
      _d('Salade de poulpe', 'Poulpe et citron', 16.0),
      _d('Fattoush', 'Salade au pain grillé', 10.0),
      _d('Salade de betterave', 'Betterave et huile', 8.0),
      _d('Salade César', 'Poulet, parmesan, croûtons', 13.0),
      _d('Salade de carottes', 'Carottes râpées', 7.5),
    ],
  ),
  (
    name: 'Grillades',
    description: 'Viandes au charbon',
    recipe: [('Poulet', 180)],
    dishes: [
      _d('Brochettes de poulet', 'Poulet grillé', 18.0),
      _d('Kefta grillée', 'Boulettes épicées', 16.0),
      _d('Merguez', 'Saucisses grillées', 14.0),
      _d('Côtelettes d\'agneau', 'Agneau grillé', 28.0),
      _d('Escalope panée', 'Escalope de volaille', 17.0),
      _d('Mixed grill', 'Assortiment grillé', 32.0),
      _d('Poulet rôti', 'Demi-poulet', 22.0),
      _d('Foie grillé', 'Foie à la braise', 15.0),
      _d('Brochettes de dinde', 'Dinde marinée', 17.0),
      _d('Steak grillé', 'Bœuf grillé', 26.0),
    ],
  ),
  (
    name: 'Couscous et tajine',
    description: 'Plats de semoule',
    recipe: [('Poulet', 150), ('Tomate', 80)],
    dishes: [
      _d('Couscous à l\'agneau', 'Semoule et agneau', 26.0),
      _d('Couscous au poulet', 'Semoule et poulet', 22.0),
      _d('Couscous au poisson', 'Semoule et poisson', 24.0),
      _d('Couscous royal', 'Viandes mélangées', 32.0),
      _d('Couscous légumes', 'Semoule et légumes', 18.0),
      _d('Tajine tunisien', 'Ragoût aux œufs', 20.0),
      _d('Tajine de poulet', 'Poulet en sauce', 22.0),
      _d('Kamounia', 'Foie au cumin', 18.0),
      _d('Mloukhia', 'Sauce aux feuilles', 20.0),
      _d('Rechta', 'Pâtes fines en sauce', 19.0),
    ],
  ),
  (
    name: 'Poissons',
    description: 'Grill et friture',
    recipe: [('Poisson', 200), ('Citron', 1)],
    dishes: [
      _d('Poisson grillé', 'Poisson du jour', 28.0),
      _d('Calamars frits', 'Anneaux frits', 22.0),
      _d('Crevettes sautées', 'Crevettes à l\'ail', 26.0),
      _d('Filet de dorade', 'Dorade grillée', 30.0),
      _d('Rouget frit', 'Rouget de roche', 24.0),
      _d('Salade de fruits de mer', 'Mélange de mer', 23.0),
      _d('Soupe de poisson', 'Soupe épicée', 16.0),
      _d('Sardines grillées', 'Sardines au charbon', 14.0),
      _d('Poulpe grillé', 'Poulpe à la braise', 24.0),
      _d('Friture de calmars', 'Petite friture', 20.0),
    ],
  ),
  (
    name: 'Desserts',
    description: 'Fin de repas',
    recipe: [('Farine', 30), ('Sucre', 20)],
    dishes: [
      _d('Baklawa maison', 'Part de baklawa', 6.0),
      _d('Crème caramel', 'Flan au caramel', 5.0),
      _d('Mhalbi', 'Crème de riz', 5.5),
      _d('Glace vanille', 'Boule vanille', 4.5),
      _d('Sorbet citron', 'Sorbet au citron', 5.0),
      _d('Fruit de saison', 'Assiette de fruits', 6.0),
      _d('Gâteau au chocolat', 'Part de gâteau', 7.0),
      _d('Tiramisu', 'Mascarpone et café', 7.5),
      _d('Flan', 'Flan pâtissier', 4.5),
      _d('Assiette de pâtisseries', 'Sélection sucrée', 9.0),
    ],
  ),
];

final _swedishMenu = <_MenuCategoryTemplate>[
  (
    name: 'Kaffe',
    description: 'Kaffe och choklad',
    recipe: [('Kaffebönor', 18), ('Mjölk', 120)],
    dishes: [
      _d('Bryggkaffe', 'Bryggd kaffe', 32),
      _d('Espresso', 'Kort espresso', 34),
      _d('Cappuccino', 'Espresso och mjölkskum', 45),
      _d('Latte', 'Espresso och ångad mjölk', 48),
      _d('Americano', 'Espresso med hett vatten', 38),
      _d('Macchiato', 'Espresso med en skvätt mjölk', 36),
      _d('Havrelatte', 'Latte på havredryck', 49),
      _d('Cortado', 'Espresso och varm mjölk', 42),
      _d('Varm choklad', 'Choklad med mjölk', 45),
      _d('Påtår', 'Påfyllning av bryggkaffe', 15),
    ],
  ),
  (
    name: 'Fika',
    description: 'Bullar och kakor',
    recipe: [('Mjöl', 40), ('Smör', 25), ('Socker', 15)],
    dishes: [
      _d('Kanelbulle', 'Kanelbulle med pärlsocker', 39),
      _d('Kardemummabulle', 'Kardemumma och socker', 42),
      _d('Chokladboll', 'Havre och kakao', 35),
      _d('Prinsesstårta', 'En bit prinsesstårta', 69),
      _d('Morotskaka', 'Morotskaka med frosting', 55),
      _d('Kladdkaka', 'Kladdig chokladkaka', 49),
      _d('Hallongrotta', 'Kaka med hallon', 32),
      _d('Semla', 'Vetebröd med mandelmassa', 45),
      _d('Mazarin', 'Mandelbotten med glasyr', 36),
      _d('Dammsugare', 'Punschrulle', 28),
    ],
  ),
  (
    name: 'Mackor',
    description: 'Smörgåsar och wraps',
    recipe: [('Bröd', 1), ('Smör', 10)],
    dishes: [
      _d('Räksmörgås', 'Räkor, majonnäs, dill', 145),
      _d('Ost och skinka', 'Klassisk macka', 89),
      _d('Avocado toast', 'Avokado på surdegsbröd', 119),
      _d('Köttbullesmörgås', 'Köttbullar och rödbeta', 125),
      _d('Grönsakswrap', 'Rostade grönsaker', 109),
      _d('Laxmacka', 'Kallrökt lax', 135),
      _d('Toast Skagen', 'Räkröra på toast', 155),
      _d('Ostfralla', 'Ost på fralla', 45),
      _d('Kycklingbaguette', 'Kyckling och sallad', 129),
      _d('Falafelrulle', 'Falafel och sås', 99),
    ],
  ),
  (
    name: 'Soppor',
    description: 'Soppa med bröd',
    recipe: [('Tomat', 80), ('Bröd', 1)],
    dishes: [
      _d('Ärtsoppa', 'Gul ärtsoppa', 115),
      _d('Fisksoppa', 'Krämig fisksoppa', 139),
      _d('Tomatsoppa', 'Tomat och basilika', 105),
      _d('Svampsoppa', 'Skogssvamp', 119),
      _d('Linssoppa', 'Linser och grönsaker', 109),
      _d('Nässelsoppa', 'Brännässla och ägg', 125),
      _d('Morotssoppa', 'Morot och ingefära', 99),
      _d('Skaldjurssoppa', 'Räkor och musslor', 145),
      _d('Soppa med bröd', 'Dagens soppa och bröd', 115),
      _d('Dagens soppa', 'Soppa enligt tavlan', 109),
    ],
  ),
  (
    name: 'Husmanskost',
    description: 'Svenska klassiker',
    recipe: [('Kyckling', 160), ('Potatis', 180)],
    dishes: [
      _d('Köttbullar med potatis', 'Köttbullar, gräddsås, lingon', 175),
      _d('Pytt i panna', 'Stekt pytt med ägg', 165),
      _d('Wallenbergare', 'Kalvfärsbiff och ärtor', 195),
      _d('Fläskpannkaka', 'Ugnspannkaka med fläsk', 155),
      _d('Isterband', 'Isterband och dillstuvad potatis', 169),
      _d('Stekt strömming', 'Strömming och potatismos', 175),
      _d('Raggmunk', 'Raggmunk med fläsk', 149),
      _d('Kalops', 'Nötkött och lagerblad', 185),
      _d('Pannbiff', 'Pannbiff och lök', 179),
      _d('Äggakaka', 'Äggakaka med fläsk', 145),
    ],
  ),
  (
    name: 'Fisk',
    description: 'Fisk från menyn',
    recipe: [('Fisk', 180), ('Potatis', 150)],
    dishes: [
      _d('Gravlax', 'Gravad lax och senapssås', 189),
      _d('Stekt lax', 'Laxfilé och dill', 215),
      _d('Panerad torsk', 'Torsk med remoulad', 195),
      _d('Silltallrik', 'Inlagd sill och potatis', 165),
      _d('Fish and chips', 'Panerad fisk och pommes', 175),
      _d('Räkor', 'Handskalade räkor', 189),
      _d('Laxpasta', 'Pasta med lax och dill', 185),
      _d('Fiskgratäng', 'Gratinerad fisk', 179),
      _d('Bakad kolja', 'Kolja från ugnen', 199),
      _d('Skagenröra', 'Räkröra', 155),
    ],
  ),
  (
    name: 'Sallader',
    description: 'Kalla rätter',
    recipe: [('Tomat', 70), ('Olivolja', 10)],
    dishes: [
      _d('Caesarsallad', 'Kyckling och parmesan', 155),
      _d('Räksallad', 'Räkor och avokado', 169),
      _d('Grönsallad', 'Blandad sallad', 115),
      _d('Quinoasallad', 'Quinoa och grönsaker', 145),
      _d('Getostsallad', 'Getost och valnötter', 159),
      _d('Kycklingsallad', 'Grillad kyckling', 155),
      _d('Rödbetssallad', 'Rödbetor och getost', 139),
      _d('Säsongssallad', 'Sallad efter säsong', 135),
      _d('Linssallad', 'Linser och örter', 129),
      _d('Tonfisksallad', 'Tonfisk och ägg', 149),
    ],
  ),
  (
    name: 'Frukost',
    description: 'Morgonmat',
    recipe: [('Ägg', 2), ('Bröd', 1)],
    dishes: [
      _d('Havregrynsgröt', 'Gröt med mjölk', 75),
      _d('Fil och müsli', 'Filmjölk och müsli', 69),
      _d('Äggröra', 'Äggröra och bröd', 95),
      _d('Frukosttallrik', 'Bröd, ost, pålägg', 129),
      _d('Yoghurt med bär', 'Yoghurt och färska bär', 72),
      _d('Pannkakor', 'Pannkakor med sylt', 99),
      _d('Frukostmacka', 'Macka och kaffe', 85),
      _d('Bacon och ägg', 'Stekt ägg och bacon', 119),
      _d('Smoothie bowl', 'Bär och granola', 109),
      _d('Dagens frukost', 'Frukost enligt tavlan', 135),
    ],
  ),
  (
    name: 'Dryck',
    description: 'Kalla drycker',
    recipe: [('Citron', 1), ('Socker', 15)],
    dishes: [
      _d('Apelsinjuice', 'Nypressad apelsin', 42),
      _d('Äppelmust', 'Svensk äppelmust', 38),
      _d('Lingondricka', 'Saft av lingon', 36),
      _d('Mineralvatten', 'Kolsyrat vatten', 28),
      _d('Citronläsk', 'Läsk med citron', 35),
      _d('Fläderdryck', 'Fläderblomssaft', 39),
      _d('Kolsyrat vatten', 'Vatten med citron', 28),
      _d('Mjölk', 'Kall mjölk', 22),
      _d('Islatte', 'Kall latte', 48),
      _d('Saft', 'Bärsaft', 32),
    ],
  ),
  (
    name: 'Desserter',
    description: 'Sött efter maten',
    recipe: [('Mjöl', 30), ('Socker', 20)],
    dishes: [
      _d('Kladdkaka med grädde', 'Varm kladdkaka', 79),
      _d('Vaniljglass', 'Gräddglass vanilj', 55),
      _d('Chokladmousse', 'Mörk chokladmousse', 69),
      _d('Ostkaka', 'Svensk ostkaka', 75),
      _d('Pannkakor med sylt', 'Tunna pannkakor', 85),
      _d('Bärpaj', 'Paj med bär', 79),
      _d('Cheesecake', 'Bakad cheesecake', 82),
      _d('Äppelpaj', 'Paj med vaniljsås', 75),
      _d('Extra glasskula', 'En extra kula', 25),
      _d('Säsongens dessert', 'Dessert enligt tavlan', 89),
    ],
  ),
];

final _germanMenu = <_MenuCategoryTemplate>[
  (
    name: 'Kaffee',
    description: 'Kaffee und Kakao',
    recipe: [('Kaffeebohnen', 18), ('Milch', 120)],
    dishes: [
      _d('Espresso', 'Kurzer Espresso', 2.8),
      _d('Cappuccino', 'Espresso mit Milchschaum', 3.9),
      _d('Milchkaffee', 'Kaffee mit Milch', 3.6),
      _d('Latte Macchiato', 'Milch mit Espresso', 4.2),
      _d('Americano', 'Espresso verlängert', 3.2),
      _d('Filterkaffee', 'Kaffee aus der Kanne', 2.9),
      _d('Espresso Macchiato', 'Espresso mit Milchfleck', 3.1),
      _d('Haferlatte', 'Latte mit Haferdrink', 4.3),
      _d('Flat White', 'Doppelter Espresso mit Milch', 4.1),
      _d('Heiße Schokolade', 'Kakao mit Milch', 3.8),
    ],
  ),
  (
    name: 'Kuchen',
    description: 'Kuchen aus der Theke',
    recipe: [('Mehl', 45), ('Butter', 25), ('Zucker', 15)],
    dishes: [
      _d('Schwarzwälder Kirsch', 'Kirschen und Sahne', 4.8),
      _d('Apfelkuchen', 'Kuchen mit Äpfeln', 3.9),
      _d('Käsekuchen', 'Gebackener Käsekuchen', 4.2),
      _d('Bienenstich', 'Mandeldecke und Pudding', 4.5),
      _d('Streuselkuchen', 'Butterstreusel', 3.6),
      _d('Frankfurter Kranz', 'Buttercreme und Krokant', 4.9),
      _d('Donauwelle', 'Kirschen und Pudding', 3.8),
      _d('Pflaumenkuchen', 'Kuchen mit Pflaumen', 4.1),
      _d('Nusskuchen', 'Rührkuchen mit Nüssen', 3.9),
      _d('Zimtschnecke', 'Hefeschnecke mit Zimt', 3.4),
    ],
  ),
  (
    name: 'Frühstück',
    description: 'Frühstücksteller',
    recipe: [('Eier', 2), ('Brot', 1)],
    dishes: [
      _d('Frühstücksteller', 'Brot, Aufschnitt, Ei', 12.5),
      _d('Rührei', 'Rührei mit Brot', 8.5),
      _d('Bauernfrühstück', 'Bratkartoffeln und Ei', 11.5),
      _d('Avocado Brot', 'Avocado auf Sauerteig', 9.9),
      _d('Müsli', 'Müsli mit Milch', 6.5),
      _d('Joghurt mit Beeren', 'Joghurt und Beeren', 6.9),
      _d('Pancakes', 'Pfannkuchen mit Sirup', 9.5),
      _d('Belegtes Brötchen', 'Brötchen mit Belag', 4.8),
      _d('Omelett', 'Omelett mit Kräutern', 9.2),
      _d('Porridge', 'Haferbrei', 6.4),
    ],
  ),
  (
    name: 'Suppen',
    description: 'Suppe mit Brot',
    recipe: [('Tomate', 90), ('Brot', 1)],
    dishes: [
      _d('Linsensuppe', 'Linsen und Gemüse', 7.5),
      _d('Gulaschsuppe', 'Rinderbrühe und Paprika', 8.9),
      _d('Tomatensuppe', 'Tomaten und Basilikum', 6.9),
      _d('Kürbissuppe', 'Kürbis und Ingwer', 7.9),
      _d('Tagessuppe', 'Suppe nach Tageskarte', 7.2),
      _d('Zwiebelsuppe', 'Überbackene Zwiebelsuppe', 7.8),
      _d('Hühnersuppe', 'Huhn und Nudeln', 7.4),
      _d('Kartoffelsuppe', 'Kartoffeln und Lauch', 6.8),
      _d('Erbsensuppe', 'Erbsen und Speck', 7.2),
      _d('Flädlesuppe', 'Brühe mit Pfannkuchenstreifen', 7.6),
    ],
  ),
  (
    name: 'Klassiker',
    description: 'Warme Hauptgerichte',
    recipe: [('Hähnchen', 180), ('Kartoffeln', 200)],
    dishes: [
      _d('Schnitzel Wiener Art', 'Schnitzel und Kartoffelsalat', 16.9),
      _d('Currywurst mit Pommes', 'Currywurst und Pommes', 11.5),
      _d('Sauerbraten', 'Sauerbraten mit Klößen', 18.5),
      _d('Rinderroulade', 'Roulade und Rotkohl', 19.9),
      _d('Bratwurst', 'Bratwurst mit Senf', 9.8),
      _d('Hähnchenbrust', 'Gebratene Hähnchenbrust', 15.5),
      _d('Frikadellen', 'Zwei Frikadellen', 12.9),
      _d('Schweinebraten', 'Braten mit Soße', 17.5),
      _d('Cordon bleu', 'Gefülltes Schnitzel', 16.5),
      _d('Kassler', 'Kassler und Sauerkraut', 15.9),
    ],
  ),
  (
    name: 'Pasta',
    description: 'Pizza und Nudeln',
    recipe: [('Mehl', 80), ('Tomate', 60)],
    dishes: [
      _d('Pizza Margherita', 'Tomate und Mozzarella', 11.5),
      _d('Pizza Salami', 'Salami und Käse', 13.5),
      _d('Pizza Gemüse', 'Ofengemüse', 13.9),
      _d('Spaghetti Carbonara', 'Ei und Speck', 13.5),
      _d('Spaghetti Bolognese', 'Hackfleischsoße', 13.9),
      _d('Penne Pesto', 'Basilikumpesto', 12.9),
      _d('Lasagne', 'Lasagne al forno', 14.5),
      _d('Tortellini', 'Tortellini in Sahne', 13.2),
      _d('Nudelauflauf', 'Überbackene Nudeln', 12.5),
      _d('Tagliatelle', 'Tagliatelle mit Sahne', 14.2),
    ],
  ),
  (
    name: 'Salate',
    description: 'Salate der Karte',
    recipe: [('Tomate', 70), ('Olivenöl', 10)],
    dishes: [
      _d('Gemischter Salat', 'Blattsalat der Saison', 8.5),
      _d('Caesar Salat', 'Hähnchen und Parmesan', 12.9),
      _d('Ziegenkäse Salat', 'Ziegenkäse und Nüsse', 13.5),
      _d('Thunfisch Salat', 'Thunfisch und Ei', 12.5),
      _d('Hähnchen Salat', 'Gegrilltes Hähnchen', 13.2),
      _d('Rote Bete Salat', 'Rote Bete und Käse', 9.9),
      _d('Quinoa Salat', 'Quinoa und Gemüse', 11.5),
      _d('Markt Salat', 'Salat nach Markt', 10.5),
      _d('Nudelsalat', 'Nudeln und Gemüse', 8.9),
      _d('Gurkensalat', 'Gurke und Dill', 6.5),
    ],
  ),
  (
    name: 'Snacks',
    description: 'Hessische Kleinigkeiten',
    recipe: [('Kartoffeln', 180), ('Brot', 1)],
    dishes: [
      _d('Brezel', 'Laugenbrezel', 3.2),
      _d('Handkäs mit Musik', 'Handkäse, Zwiebel, Brot', 7.5),
      _d('Grüne Soße mit Eiern', 'Frankfurter Grüne Soße', 12.9),
      _d('Flammkuchen', 'Flammkuchen Elsässer Art', 11.5),
      _d('Pommes', 'Pommes frites', 4.5),
      _d('Obatzda', 'Obatzda und Brezel', 8.5),
      _d('Bratkartoffeln', 'Bratkartoffeln mit Speck', 6.9),
      _d('Spundekäs', 'Spundekäs und Brezel', 7.9),
      _d('Brotzeitbrett', 'Brot, Wurst, Käse', 13.5),
      _d('Kartoffelpuffer', 'Puffer mit Apfelmus', 8.2),
    ],
  ),
  (
    name: 'Getränke',
    description: 'Kaltgetränke',
    recipe: [('Zitrone', 1), ('Zucker', 15)],
    dishes: [
      _d('Apfelschorle', 'Apfelsaft und Wasser', 3.4),
      _d('Apfelwein', 'Saurer Apfelwein, 0,25 l', 3.8),
      _d('Spezi', 'Cola-Mix', 3.2),
      _d('Mineralwasser', 'Sprudel', 2.6),
      _d('Zitronenlimonade', 'Zitrone hausgemacht', 3.4),
      _d('Orangensaft', 'Orangensaft', 3.8),
      _d('Fassbrause', 'Fassbrause', 3.5),
      _d('Eistee', 'Eistee Zitrone', 3.6),
      _d('Milchshake', 'Vanille-Milchshake', 4.8),
      _d('Hausgemachte Limo', 'Limo des Tages', 3.9),
    ],
  ),
  (
    name: 'Nachspeisen',
    description: 'Süßes zum Schluss',
    recipe: [('Mehl', 30), ('Zucker', 20)],
    dishes: [
      _d('Apfelstrudel', 'Strudel mit Vanillesoße', 6.5),
      _d('Crème brûlée', 'Karamellisierte Creme', 6.9),
      _d('Schokomousse', 'Mousse au chocolat', 5.8),
      _d('Vanilleeis', 'Zwei Kugeln Vanille', 4.5),
      _d('Rote Grütze', 'Rote Grütze mit Vanillesoße', 6.2),
      _d('Tiramisu', 'Mascarpone und Espresso', 6.8),
      _d('Panna cotta', 'Panna cotta mit Beeren', 6.4),
      _d('Kaiserschmarrn', 'Kaiserschmarrn mit Apfelmus', 9.5),
      _d('Mousse au chocolat', 'Dunkle Schokolade', 6.2),
      _d('Saisonales Dessert', 'Dessert der Woche', 7.5),
    ],
  ),
];

int _articleCount(int venueIndex, int categoryIndex) {
  return 5 + ((venueIndex * 3 + categoryIndex * 5) % 6);
}

double _money(double value, String currency) {
  if (currency == 'SEK') {
    return value.roundToDouble();
  }
  return (value * 100).round() / 100;
}

List<_Ingredient> _pantryFor(_Cuisine cuisine) {
  return switch (cuisine) {
    _Cuisine.tunisian => _pantryTunisian,
    _Cuisine.swedish => _pantrySwedish,
    _Cuisine.german => _pantryGerman,
  };
}

List<_MenuCategoryTemplate> _templatesFor(_Cuisine cuisine) {
  return switch (cuisine) {
    _Cuisine.tunisian => _tunisianMenu,
    _Cuisine.swedish => _swedishMenu,
    _Cuisine.german => _germanMenu,
  };
}

_Menu _menuFor(_Venue venue, int index) {
  final bump = 1 + (index % 5) * 0.03;
  final pantry = _pantryFor(venue.cuisine);
  return (
    categories: [
      for (var c = 0; c < _templatesFor(venue.cuisine).length; c++)
        () {
          final template = _templatesFor(venue.cuisine)[c];
          final dishes = template.dishes.take(_articleCount(index, c)).toList();
          return (
            name: template.name,
            description: template.description,
            articles: [
              for (final dish in dishes)
                (
                  name: dish.name,
                  description: dish.description,
                  price: _money(dish.price * bump, venue.currency),
                  recipe: template.recipe,
                ),
            ],
          );
        }(),
    ],
    ingredients: pantry,
  );
}

final _phonePattern = RegExp(r'^\+[1-9]\d{7,14}$');

void _requireCatalog() {
  if (_venues.length != 30) {
    throw StateError('DevSeed: expected 30 venues, got ${_venues.length}.');
  }
  if (_venues.first.name != DevSeed.markerVenue) {
    throw StateError('DevSeed: first venue must be ${DevSeed.markerVenue}.');
  }
  final names = <String>{};
  final cities = <String, int>{};
  final ownerPhones = <String>{};
  final perCountry = <String, int>{};
  for (var i = 0; i < _venues.length; i++) {
    final venue = _venues[i];
    if (!names.add(venue.name)) {
      throw StateError('DevSeed: duplicate venue ${venue.name}.');
    }
    cities[venue.city] = (cities[venue.city] ?? 0) + 1;
    if (!_phonePattern.hasMatch(venue.phone)) {
      throw StateError('DevSeed: bad phone for ${venue.name}.');
    }
    final n = perCountry[venue.country] ?? 0;
    perCountry[venue.country] = n + 1;
    final ownerPhone = _ownerPhone(venue.country, n);
    if (!_phonePattern.hasMatch(ownerPhone) || !ownerPhones.add(ownerPhone)) {
      throw StateError('DevSeed: bad owner phone for ${venue.name}.');
    }
    final currency = switch (venue.country) {
      'TN' => 'TND',
      'SE' => 'SEK',
      'DE' => 'EUR',
      _ => '',
    };
    if (venue.currency != currency) {
      throw StateError('DevSeed: currency mismatch for ${venue.name}.');
    }
    if (venue.country == 'TN' && venue.cuisine != _Cuisine.tunisian) {
      throw StateError('DevSeed: ${venue.name} needs a Tunisian menu.');
    }
    if (venue.country == 'SE' && venue.cuisine != _Cuisine.swedish) {
      throw StateError('DevSeed: ${venue.name} needs a Swedish menu.');
    }
    if (venue.country == 'DE' && venue.cuisine != _Cuisine.german) {
      throw StateError('DevSeed: ${venue.name} needs a German menu.');
    }
    final menu = _menuFor(venue, i);
    if (menu.categories.length != 10) {
      throw StateError('DevSeed: ${venue.name} needs 10 categories.');
    }
    if (menu.ingredients.length > 15) {
      throw StateError('DevSeed: ${venue.name} has too many ingredients.');
    }
    final known = menu.ingredients.map((item) => item.name).toSet();
    final articleNames = <String>{};
    final categoryNames = <String>{};
    for (final category in menu.categories) {
      if (!categoryNames.add(category.name)) {
        throw StateError(
          'DevSeed: duplicate category ${category.name} at ${venue.name}.',
        );
      }
      final count = category.articles.length;
      if (count < 5 || count > 10) {
        throw StateError(
          'DevSeed: ${venue.name} / ${category.name} has $count articles.',
        );
      }
      for (final article in category.articles) {
        if (!articleNames.add(article.name)) {
          throw StateError(
            'DevSeed: duplicate article ${article.name} at ${venue.name}.',
          );
        }
        for (final line in article.recipe) {
          if (!known.contains(line.$1)) {
            throw StateError(
              'DevSeed: missing ingredient ${line.$1} for ${article.name}.',
            );
          }
        }
      }
    }
  }
  for (final entry in _expectedCities.entries) {
    if (cities[entry.key] != entry.value) {
      throw StateError(
        'DevSeed: ${entry.key} has ${cities[entry.key] ?? 0} venues, '
        'expected ${entry.value}.',
      );
    }
  }
}
