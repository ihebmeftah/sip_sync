import 'package:serverpod/serverpod.dart';

import '../auth/auth_support.dart';
import '../buildings/strict_mode.dart';
import '../core/phone_numbers.dart';
import '../employee_access/default_employee_access.dart';
import '../generated/protocol.dart';
import '../packs/pack_catalog.dart';
import '../packs/pack_history.dart';

part 'real_venue_catalog.dart';

/// Demo owners for local development.
///
/// Thirty real venues: Sousse, Tunis, and Hammamet; Stockholm; Marburg,
/// Frankfurt, and Gießen. Each owner has one building on the free pack, ten
/// menu categories, and five to ten articles in each category. The free plan
/// caps new categories at four and new articles at twenty, so these rows are
/// inserted directly and the owner app will refuse further creates.
///
/// Runs on boot when [tunisiaEmail] is missing. If that account exists but
/// its venue is not [DevSeed.markerVenue], the previous demo set is still in
/// the database — wipe it and start again. Password for every owner is
/// [password].
class DevSeed {
  static const password = 'password1';

  /// First Tunisia owner. Presence of this email means a demo set exists.
  static const tunisiaEmail = 'owner.tn.01@sipsync.dev';

  /// Venue owned by [tunisiaEmail] in this catalog.
  static const markerVenue = 'Restaurant Café Seles';

  /// Throws [StateError] when the catalog is not 30 complete menus.
  static void validateCatalog() => _requireCatalog();

  /// Seeds the demo set when [tunisiaEmail] is not registered.
  static Future<void> ensureDemoData(Session session) async {
    validateCatalog();
    final existing = await Owner.db.findFirstRow(
      session,
      where: (t) => t.email.equals(tunisiaEmail),
    );
    if (existing != null) {
      final building = await Building.db.findFirstRow(
        session,
        where: (t) => t.ownerId.equals(existing.id!),
      );
      if (building?.name == markerVenue) {
        session.log('DevSeed: demo venues already present — skip.');
      } else {
        session.log(
          'DevSeed: $tunisiaEmail exists but is not $markerVenue. '
          'Wipe the development database to load the 30 real venues.',
        );
      }
      return;
    }

    session.log('DevSeed: creating ${_venues.length} real venues…');
    final passwordHash = AuthSupport().passwords.hash(password);
    final perCountry = <String, int>{};
    for (var i = 0; i < _venues.length; i++) {
      final venue = _venues[i];
      final n = perCountry[venue.country] ?? 0;
      perCountry[venue.country] = n + 1;
      final menu = _menuFor(venue, i);
      await _seedVenue(
        session,
        email:
            'owner.${venue.country.toLowerCase()}.${(n + 1).toString().padLeft(2, '0')}@sipsync.dev',
        ownerPhone: _ownerPhone(venue.country, n),
        firstName: _firstName(venue.country, n),
        lastName: _lastName(venue.country, n),
        passwordHash: passwordHash,
        venue: venue,
        menu: menu,
        tableCount: switch (venue.type) {
          'restaurant' => 6,
          'bar' => 5,
          _ => 4,
        },
      );
    }

    session.log(
      'DevSeed: ready — owner.tn.01–14, owner.se.01–06, owner.de.01–10 '
      '(password: $password), all on the free pack.',
    );
  }

  /// Inserts one owner and one venue on the free pack, with menu and stock.
  static Future<void> _seedVenue(
    Session session, {
    required String email,
    required String ownerPhone,
    required String firstName,
    required String lastName,
    required String passwordHash,
    required _Venue venue,
    required _Menu menu,
    required int tableCount,
  }) async {
    final savedOwner = await Owner.db.insertRow(
      session,
      Owner(
        email: email,
        phoneNumber: ownerPhone,
        firstName: firstName,
        lastName: lastName,
        passwordHash: passwordHash,
      ),
    );

    final free = await PackCatalog.requireFree(session);
    final open = venue.type == 'cafe' ? 480 : 660;
    final building = await Building.db.insertRow(
      session,
      Building(
        ownerId: savedOwner.id!,
        packId: free.id!,
        name: venue.name,
        type: venue.type,
        address: venue.address,
        latitude: venue.latitude,
        longitude: venue.longitude,
        openingMinutes: open,
        closingMinutes: venue.type == 'bar' ? 1410 : 1380,
        currencyCode: venue.currency,
        phoneNumber: venue.phone,
        countryCode: venue.country,
        countryName:
            PhoneNumbers.countryNameFromCode(venue.country) ?? venue.country,
        whatsapp: venue.phone,
        instagram: null,
        facebook: null,
        otherLinks: const [],
        tableMultiOrder: false,
        allowAppendingItemsToOrder: true,
        strictMode: false,
        strictModeSteps: effectiveStrictModeSteps(
          strictMode: false,
          steps: defaultStrictModeSteps(),
        ),
      ),
    );

    await BuildingPackHistory.openInitial(
      session,
      buildingId: building.id!,
      packId: free.id!,
    );
    await DefaultEmployeeAccess.seedForBuilding(session, building.id!);

    await VenueTable.db.insert(session, [
      for (var n = 1; n <= tableCount; n++)
        VenueTable(
          buildingId: building.id!,
          number: n,
          maxSeats: n <= 2 ? 2 : 4,
          isActive: true,
        ),
    ]);

    final savedIngredients = await Ingredient.db.insert(session, [
      for (final ing in menu.ingredients)
        Ingredient(
          buildingId: building.id!,
          name: ing.name,
          unit: ing.unit,
          initialStock: ing.stock,
          currentStock: ing.stock,
          thresholdStock: ing.threshold,
        ),
    ]);
    final ingredientByName = {
      for (final row in savedIngredients) row.name: row,
    };

    for (final category in menu.categories) {
      final cat = await MenuCategory.db.insertRow(
        session,
        MenuCategory(
          buildingId: building.id!,
          name: category.name,
          description: category.description,
        ),
      );
      final savedArticles = await MenuArticle.db.insert(session, [
        for (final article in category.articles)
          MenuArticle(
            buildingId: building.id!,
            categoryId: cat.id!,
            name: article.name,
            description: article.description,
            price: article.price,
          ),
      ]);
      final compositions = <ArticleComposition>[
        for (var i = 0; i < savedArticles.length; i++)
          for (final line in category.articles[i].recipe)
            ArticleComposition(
              articleId: savedArticles[i].id!,
              ingredientId: ingredientByName[line.$1]!.id!,
              quantity: line.$2,
            ),
      ];
      if (compositions.isNotEmpty) {
        await ArticleComposition.db.insert(session, compositions);
      }
    }
  }
}
