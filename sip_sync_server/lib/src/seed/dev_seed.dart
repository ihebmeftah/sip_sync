import 'package:serverpod/serverpod.dart';

import '../auth/auth_support.dart';
import '../buildings/strict_mode.dart';
import '../employee_access/default_employee_access.dart';
import '../generated/protocol.dart';
import '../packs/pack_catalog.dart';

/// Idempotent demo data for local development.
///
/// Five owners, six venues around Greater Tunis, each with categories,
/// articles, recipes, and stock. Runs on server boot when [owner1Email] is
/// missing. Safe to call repeatedly. Wipe `.serverpod/development/pgdata`
/// to force a re-seed.
class DevSeed {
  static const password = 'password1';

  static const owner1Email = 'owner1@sipsync.dev';
  static const owner2Email = 'owner2@sipsync.dev';
  static const owner3Email = 'owner3@sipsync.dev';
  static const owner4Email = 'owner4@sipsync.dev';
  static const owner5Email = 'owner5@sipsync.dev';

  /// Seeds demo owners/buildings/menu if [owner1Email] is not already registered.
  static Future<void> ensureDemoData(Session session) async {
    final existing = await Owner.db.findFirstRow(
      session,
      where: (t) => t.email.equals(owner1Email),
    );
    if (existing != null) {
      session.log('DevSeed: demo owners already present — skip.');
      return;
    }

    session.log('DevSeed: creating demo owners, buildings, and menus…');

    final amine = await _seedVenue(
      session,
      email: owner1Email,
      phone: '+21620000001',
      firstName: 'Amine',
      lastName: 'Benali',
      buildingName: 'Olive Café',
      buildingType: 'cafe',
      address: '12 Avenue Habib Bourguiba, Tunis',
      venuePhone: '+21671110001',
      latitude: 36.8065,
      longitude: 10.1815,
      currencyCode: 'TND',
      categories: [
        (
          name: 'Coffee',
          description: 'Espresso bar',
          articles: [
            (name: 'Espresso', price: 3.5, recipe: [('Espresso beans', 18.0)]),
            (
              name: 'Latte',
              price: 7.0,
              recipe: [('Espresso beans', 18.0), ('Milk', 200.0)],
            ),
            (
              name: 'Cappuccino',
              price: 6.5,
              recipe: [('Espresso beans', 18.0), ('Milk', 120.0)],
            ),
            (
              name: 'Mint tea',
              price: 4.0,
              recipe: [('Mint', 10.0), ('Sugar', 15.0)],
            ),
          ],
        ),
        (
          name: 'Pastries',
          description: 'Fresh baked',
          articles: [
            (
              name: 'Croissant',
              price: 4.5,
              recipe: [('Flour', 50.0), ('Butter', 30.0)],
            ),
            (
              name: 'Pain au chocolat',
              price: 5.0,
              recipe: [('Flour', 45.0), ('Butter', 25.0), ('Sugar', 10.0)],
            ),
          ],
        ),
        (
          name: 'Breakfast',
          description: 'Morning plates',
          articles: [
            (
              name: 'Omelette',
              price: 9.0,
              recipe: [('Eggs', 2.0), ('Olive oil', 10.0)],
            ),
            (
              name: 'Avocado toast',
              price: 12.0,
              recipe: [('Bread', 1.0), ('Avocado', 0.5), ('Olive oil', 5.0)],
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
        (
          name: 'Milk',
          unit: UnitsType.milliliter,
          stock: 12000,
          threshold: 1000,
        ),
        (name: 'Mint', unit: UnitsType.gram, stock: 500, threshold: 50),
        (name: 'Sugar', unit: UnitsType.gram, stock: 3000, threshold: 300),
        (name: 'Flour', unit: UnitsType.gram, stock: 8000, threshold: 800),
        (name: 'Butter', unit: UnitsType.gram, stock: 3000, threshold: 300),
        (name: 'Eggs', unit: UnitsType.piece, stock: 60, threshold: 12),
        (
          name: 'Olive oil',
          unit: UnitsType.milliliter,
          stock: 2000,
          threshold: 200,
        ),
        (name: 'Bread', unit: UnitsType.piece, stock: 40, threshold: 8),
        (name: 'Avocado', unit: UnitsType.piece, stock: 24, threshold: 6),
      ],
      tableCount: 8,
    );

    await _seedVenue(
      session,
      owner: amine,
      buildingName: 'Olive Café Carthage',
      buildingType: 'cafe',
      address: 'Avenue Habib Bourguiba, Carthage',
      venuePhone: '+21671110002',
      latitude: 36.8528,
      longitude: 10.3236,
      currencyCode: 'TND',
      categories: [
        (
          name: 'Coffee',
          description: 'Espresso and juice',
          articles: [
            (name: 'Espresso', price: 3.5, recipe: [('Espresso beans', 18.0)]),
            (
              name: 'Cappuccino',
              price: 6.5,
              recipe: [('Espresso beans', 18.0), ('Milk', 120.0)],
            ),
            (
              name: 'Orange juice',
              price: 6.0,
              recipe: [('Oranges', 2.0)],
            ),
          ],
        ),
        (
          name: 'Pastries',
          description: 'Counter sweets',
          articles: [
            (
              name: 'Croissant',
              price: 4.5,
              recipe: [('Flour', 50.0), ('Butter', 30.0)],
            ),
            (
              name: 'Makroud',
              price: 3.0,
              recipe: [
                ('Semolina', 40.0),
                ('Dates', 20.0),
                ('Butter', 10.0),
              ],
            ),
          ],
        ),
      ],
      ingredients: const [
        (
          name: 'Espresso beans',
          unit: UnitsType.gram,
          stock: 2500,
          threshold: 250,
        ),
        (
          name: 'Milk',
          unit: UnitsType.milliliter,
          stock: 8000,
          threshold: 800,
        ),
        (name: 'Oranges', unit: UnitsType.piece, stock: 40, threshold: 8),
        (name: 'Flour', unit: UnitsType.gram, stock: 4000, threshold: 400),
        (name: 'Butter', unit: UnitsType.gram, stock: 2000, threshold: 200),
        (name: 'Semolina', unit: UnitsType.gram, stock: 3000, threshold: 300),
        (name: 'Dates', unit: UnitsType.gram, stock: 2000, threshold: 200),
      ],
      tableCount: 5,
    );

    await _seedVenue(
      session,
      email: owner2Email,
      phone: '+21620000002',
      firstName: 'Sara',
      lastName: 'Mansour',
      buildingName: 'Harbor Lounge',
      buildingType: 'lounge',
      address: '3 Corniche, La Marsa',
      venuePhone: '+21671110003',
      latitude: 36.8782,
      longitude: 10.3249,
      currencyCode: 'TND',
      categories: [
        (
          name: 'Cocktails',
          description: 'Bar classics',
          articles: [
            (
              name: 'Gin Tonic',
              price: 14.0,
              recipe: [('Gin', 50.0), ('Tonic', 150.0), ('Lemon', 1.0)],
            ),
            (
              name: 'Mojito',
              price: 16.0,
              recipe: [
                ('Rum', 50.0),
                ('Mint', 8.0),
                ('Soda', 120.0),
                ('Lemon', 0.5),
              ],
            ),
            (
              name: 'Virgin Mojito',
              price: 10.0,
              recipe: [('Mint', 8.0), ('Soda', 150.0), ('Lemon', 0.5)],
            ),
          ],
        ),
        (
          name: 'Snacks',
          description: 'Share plates',
          articles: [
            (name: 'Fries', price: 6.0, recipe: [('Potato', 200.0)]),
            (name: 'Olives', price: 5.0, recipe: [('Olives', 80.0)]),
            (name: 'Cheese plate', price: 18.0, recipe: [('Cheese', 80.0)]),
          ],
        ),
      ],
      ingredients: const [
        (name: 'Gin', unit: UnitsType.milliliter, stock: 3000, threshold: 300),
        (name: 'Rum', unit: UnitsType.milliliter, stock: 3000, threshold: 300),
        (
          name: 'Tonic',
          unit: UnitsType.milliliter,
          stock: 8000,
          threshold: 800,
        ),
        (name: 'Soda', unit: UnitsType.milliliter, stock: 8000, threshold: 800),
        (name: 'Lemon', unit: UnitsType.piece, stock: 40, threshold: 10),
        (name: 'Mint', unit: UnitsType.gram, stock: 400, threshold: 40),
        (name: 'Potato', unit: UnitsType.gram, stock: 10000, threshold: 1000),
        (name: 'Olives', unit: UnitsType.gram, stock: 2000, threshold: 200),
        (name: 'Cheese', unit: UnitsType.gram, stock: 2000, threshold: 200),
      ],
      tableCount: 10,
    );

    await _seedVenue(
      session,
      email: owner3Email,
      phone: '+21620000003',
      firstName: 'Youssef',
      lastName: 'Trabelsi',
      buildingName: 'Dar El Medina',
      buildingType: 'restaurant',
      address: '7 Rue Jamaa Zitouna, Medina, Tunis',
      venuePhone: '+21671110004',
      latitude: 36.7984,
      longitude: 10.1715,
      currencyCode: 'TND',
      categories: [
        (
          name: 'Grills',
          description: 'From the charcoal',
          articles: [
            (name: 'Merguez', price: 18.0, recipe: [('Lamb', 150.0)]),
            (
              name: 'Grilled chicken',
              price: 22.0,
              recipe: [('Chicken', 200.0), ('Olive oil', 10.0)],
            ),
            (
              name: 'Kefta',
              price: 16.0,
              recipe: [('Beef', 150.0), ('Onion', 20.0), ('Parsley', 5.0)],
            ),
          ],
        ),
        (
          name: 'Salads',
          description: 'Cold plates',
          articles: [
            (
              name: 'Tunisian salad',
              price: 8.0,
              recipe: [('Tomato', 80.0), ('Onion', 20.0), ('Olive oil', 10.0)],
            ),
            (
              name: 'Mechouia',
              price: 9.0,
              recipe: [('Pepper', 60.0), ('Tomato', 40.0), ('Olive oil', 10.0)],
            ),
          ],
        ),
        (
          name: 'Desserts',
          description: 'House sweets',
          articles: [
            (
              name: 'Baklava',
              price: 7.0,
              recipe: [
                ('Phyllo', 30.0),
                ('Pistachio', 15.0),
                ('Honey', 10.0),
                ('Butter', 10.0),
              ],
            ),
          ],
        ),
      ],
      ingredients: const [
        (name: 'Lamb', unit: UnitsType.gram, stock: 8000, threshold: 800),
        (name: 'Chicken', unit: UnitsType.gram, stock: 8000, threshold: 800),
        (name: 'Beef', unit: UnitsType.gram, stock: 8000, threshold: 800),
        (name: 'Tomato', unit: UnitsType.gram, stock: 5000, threshold: 500),
        (name: 'Onion', unit: UnitsType.gram, stock: 3000, threshold: 300),
        (name: 'Pepper', unit: UnitsType.gram, stock: 3000, threshold: 300),
        (name: 'Parsley', unit: UnitsType.gram, stock: 400, threshold: 40),
        (
          name: 'Olive oil',
          unit: UnitsType.milliliter,
          stock: 3000,
          threshold: 300,
        ),
        (name: 'Phyllo', unit: UnitsType.gram, stock: 2000, threshold: 200),
        (name: 'Pistachio', unit: UnitsType.gram, stock: 1000, threshold: 100),
        (name: 'Honey', unit: UnitsType.gram, stock: 1500, threshold: 150),
        (name: 'Butter', unit: UnitsType.gram, stock: 2000, threshold: 200),
      ],
      tableCount: 12,
    );

    await _seedVenue(
      session,
      email: owner4Email,
      phone: '+21620000004',
      firstName: 'Lina',
      lastName: 'Cherif',
      buildingName: 'Lac Social',
      buildingType: 'bar',
      address: 'Rue du Lac, Les Berges du Lac, Tunis',
      venuePhone: '+21671110005',
      latitude: 36.8389,
      longitude: 10.2412,
      currencyCode: 'TND',
      categories: [
        (
          name: 'Drinks',
          description: 'Beer and wine',
          articles: [
            (name: 'Celtia', price: 5.0, recipe: [('Celtia', 1.0)]),
            (name: 'House red', price: 8.0, recipe: [('Red wine', 150.0)]),
          ],
        ),
        (
          name: 'Bar bites',
          description: 'To share',
          articles: [
            (
              name: 'Nachos',
              price: 14.0,
              recipe: [('Tortilla chips', 80.0), ('Cheddar', 40.0)],
            ),
            (
              name: 'Chicken wings',
              price: 16.0,
              recipe: [('Chicken', 180.0), ('Hot sauce', 20.0)],
            ),
          ],
        ),
      ],
      ingredients: const [
        (name: 'Celtia', unit: UnitsType.bottle, stock: 48, threshold: 12),
        (
          name: 'Red wine',
          unit: UnitsType.milliliter,
          stock: 4500,
          threshold: 750,
        ),
        (
          name: 'Tortilla chips',
          unit: UnitsType.gram,
          stock: 3000,
          threshold: 300,
        ),
        (name: 'Cheddar', unit: UnitsType.gram, stock: 2000, threshold: 200),
        (name: 'Chicken', unit: UnitsType.gram, stock: 6000, threshold: 600),
        (
          name: 'Hot sauce',
          unit: UnitsType.milliliter,
          stock: 1000,
          threshold: 100,
        ),
      ],
      tableCount: 8,
    );

    await _seedVenue(
      session,
      email: owner5Email,
      phone: '+21620000005',
      firstName: 'Nadia',
      lastName: 'Khelifi',
      buildingName: 'Café des Nattes',
      buildingType: 'cafe',
      address: 'Place Sidi Bou Said, Sidi Bou Said',
      venuePhone: '+21671110006',
      latitude: 36.8702,
      longitude: 10.3417,
      currencyCode: 'TND',
      categories: [
        (
          name: 'Tea',
          description: 'Poured at the table',
          articles: [
            (
              name: 'Mint tea',
              price: 5.0,
              recipe: [('Mint', 12.0), ('Sugar', 20.0)],
            ),
            (
              name: 'Pine nut tea',
              price: 7.0,
              recipe: [('Mint', 8.0), ('Pine nuts', 8.0), ('Sugar', 15.0)],
            ),
            (name: 'Coffee', price: 4.0, recipe: [('Espresso beans', 12.0)]),
          ],
        ),
        (
          name: 'Sweets',
          description: 'Fried and baked',
          articles: [
            (
              name: 'Bambalouni',
              price: 2.5,
              recipe: [('Flour', 40.0), ('Yeast', 2.0), ('Frying oil', 30.0)],
            ),
            (
              name: 'Kaak warka',
              price: 3.5,
              recipe: [('Flour', 35.0), ('Sugar', 10.0)],
            ),
          ],
        ),
      ],
      ingredients: const [
        (name: 'Mint', unit: UnitsType.gram, stock: 600, threshold: 60),
        (name: 'Sugar', unit: UnitsType.gram, stock: 3000, threshold: 300),
        (name: 'Pine nuts', unit: UnitsType.gram, stock: 800, threshold: 80),
        (
          name: 'Espresso beans',
          unit: UnitsType.gram,
          stock: 2000,
          threshold: 200,
        ),
        (name: 'Flour', unit: UnitsType.gram, stock: 5000, threshold: 500),
        (name: 'Yeast', unit: UnitsType.gram, stock: 300, threshold: 30),
        (
          name: 'Frying oil',
          unit: UnitsType.milliliter,
          stock: 4000,
          threshold: 400,
        ),
      ],
      tableCount: 6,
    );

    session.log(
      'DevSeed: ready — $owner1Email … $owner5Email (password: $password)',
    );
  }

  /// Inserts one venue. Creates the owner unless [owner] is already saved,
  /// so one person can hold more than one building.
  static Future<Owner> _seedVenue(
    Session session, {
    Owner? owner,
    String? email,
    String? phone,
    String? firstName,
    String? lastName,
    required String buildingName,
    required String buildingType,
    required String address,
    required String venuePhone,
    required double latitude,
    required double longitude,
    required String currencyCode,
    required List<
      ({
        String name,
        String description,
        List<
          ({
            String name,
            double price,
            List<(String, double)> recipe,
          })
        >
        articles,
      })
    >
    categories,
    required List<
      ({String name, UnitsType unit, double stock, double threshold})
    >
    ingredients,
    required int tableCount,
  }) async {
    final savedOwner =
        owner ??
        await Owner.db.insertRow(
          session,
          Owner(
            email: email!,
            phoneNumber: phone!,
            firstName: firstName!,
            lastName: lastName!,
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
        countryCode: 'TN',
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
        for (final (ingredientName, qty) in articleDef.recipe) {
          final ingredient = ingredientByName[ingredientName];
          if (ingredient == null) {
            throw StateError(
              'DevSeed: missing ingredient "$ingredientName" for ${articleDef.name}',
            );
          }
          await ArticleComposition.db.insertRow(
            session,
            ArticleComposition(
              articleId: article.id!,
              ingredientId: ingredient.id!,
              quantity: qty,
            ),
          );
        }
      }
    }
    return savedOwner;
  }
}
