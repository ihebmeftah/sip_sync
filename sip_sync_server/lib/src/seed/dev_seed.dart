import 'package:serverpod/serverpod.dart';

import '../auth/auth_support.dart';
import '../buildings/strict_mode.dart';
import '../employee_access/default_employee_access.dart';
import '../generated/protocol.dart';

/// Idempotent demo data for local development (two owners + menu + stock).
///
/// Runs on server boot when no seed owners exist yet. Safe to call repeatedly.
class DevSeed {
  static const password = 'password1';

  static const owner1Email = 'owner1@sipsync.dev';
  static const owner2Email = 'owner2@sipsync.dev';

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

    await _seedVenue(
      session,
      email: owner1Email,
      phone: '+21620000001',
      firstName: 'Amine',
      lastName: 'Benali',
      buildingName: 'Olive Café',
      buildingType: 'cafe',
      address: '12 Avenue Habib Bourguiba, Tunis',
      latitude: 36.8065,
      longitude: 10.1815,
      currencyCode: 'TND',
      categories: [
        (
          name: 'Coffee',
          description: 'Espresso bar',
          articles: [
            (
              name: 'Espresso',
              price: 3.5,
              recipe: [('Espresso beans', 18.0)],
            ),
            (
              name: 'Latte',
              price: 7.0,
              recipe: [
                ('Espresso beans', 18.0),
                ('Milk', 200.0),
              ],
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
              recipe: [
                ('Flour', 50.0),
                ('Butter', 30.0),
              ],
            ),
          ],
        ),
      ],
      ingredients: const [
        (
          name: 'Espresso beans',
          unit: UnitsType.gram,
          stock: 2000,
          threshold: 200,
        ),
        (
          name: 'Milk',
          unit: UnitsType.milliliter,
          stock: 10000,
          threshold: 1000,
        ),
        (name: 'Flour', unit: UnitsType.gram, stock: 5000, threshold: 500),
        (name: 'Butter', unit: UnitsType.gram, stock: 2000, threshold: 200),
      ],
      tableCount: 6,
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
              recipe: [
                ('Gin', 50.0),
                ('Tonic', 150.0),
                ('Lemon', 1.0),
              ],
            ),
          ],
        ),
        (
          name: 'Snacks',
          description: 'Share plates',
          articles: [
            (
              name: 'Fries',
              price: 6.0,
              recipe: [('Potato', 200.0)],
            ),
          ],
        ),
      ],
      ingredients: const [
        (name: 'Gin', unit: UnitsType.milliliter, stock: 3000, threshold: 300),
        (
          name: 'Tonic',
          unit: UnitsType.milliliter,
          stock: 8000,
          threshold: 800,
        ),
        (name: 'Lemon', unit: UnitsType.piece, stock: 40, threshold: 10),
        (name: 'Potato', unit: UnitsType.gram, stock: 10000, threshold: 1000),
      ],
      tableCount: 8,
    );

    session.log(
      'DevSeed: ready — $owner1Email / $owner2Email (password: $password)',
    );
  }

  static Future<void> _seedVenue(
    Session session, {
    required String email,
    required String phone,
    required String firstName,
    required String lastName,
    required String buildingName,
    required String buildingType,
    required String address,
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
    final auth = AuthSupport();
    final owner = await Owner.db.insertRow(
      session,
      Owner(
        email: email,
        phoneNumber: phone,
        firstName: firstName,
        lastName: lastName,
        passwordHash: auth.passwords.hash(password),
      ),
    );

    final building = await Building.db.insertRow(
      session,
      Building(
        ownerId: owner.id!,
        name: buildingName,
        type: buildingType,
        address: address,
        latitude: latitude,
        longitude: longitude,
        openingMinutes: 480,
        closingMinutes: 1380,
        currencyCode: currencyCode,
        phoneNumber: phone,
        countryCode: 'TN',
        whatsapp: phone,
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
  }
}
