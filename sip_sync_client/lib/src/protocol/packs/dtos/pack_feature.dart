/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _isc;

/// Which plan rule rejected a write. Lets the app name the limit or the switch.
enum PackFeature implements _isc.SerializableModel {
  employees,
  tables,
  categories,
  articles,
  ingredients,
  customerOrdering,
  inventory,
  appendingItems,
  tableMultiOrder,
  strictMode,
  customAccessProfiles,
  tableQr,
  reservations,
  cashRegister;

  static PackFeature fromJson(String name) {
    switch (name) {
      case 'employees':
        return PackFeature.employees;
      case 'tables':
        return PackFeature.tables;
      case 'categories':
        return PackFeature.categories;
      case 'articles':
        return PackFeature.articles;
      case 'ingredients':
        return PackFeature.ingredients;
      case 'customerOrdering':
        return PackFeature.customerOrdering;
      case 'inventory':
        return PackFeature.inventory;
      case 'appendingItems':
        return PackFeature.appendingItems;
      case 'tableMultiOrder':
        return PackFeature.tableMultiOrder;
      case 'strictMode':
        return PackFeature.strictMode;
      case 'customAccessProfiles':
        return PackFeature.customAccessProfiles;
      case 'tableQr':
        return PackFeature.tableQr;
      case 'reservations':
        return PackFeature.reservations;
      case 'cashRegister':
        return PackFeature.cashRegister;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "PackFeature"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
