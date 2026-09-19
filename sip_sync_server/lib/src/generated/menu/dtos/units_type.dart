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
import 'package:serverpod/serverpod.dart' as _is;

/// Stock quantity units for ingredients in café / restaurant / bar inventory.
/// Pick the unit that matches how the venue counts and reorders that ingredient.
enum UnitsType implements _is.SerializableModel {
  /// Mass in grams (g). Use for coffee beans, spices, flour portions, grated cheese.
  gram,

  /// Mass in kilograms (kg). Use for bulk dry goods such as flour sacks or sugar bags.
  kilogram,

  /// Volume in milliliters (ml). Use for syrups, oils, milk, and precise liquid stock.
  milliliter,

  /// Volume in centiliters (cl). Common for bar pours and spirit bottle tracking in metric venues.
  centiliter,

  /// Volume in liters (L). Use for milk crates, juice, oil drums, and other bulk liquids.
  liter,

  /// Discrete countable items (each). Use for eggs, lemons, buns, or single garnish pieces.
  piece,

  /// Whole bottles counted as one. Use for wine, spirits, syrup bottles kept intact on the shelf.
  bottle,

  /// Canned goods counted as cans. Use for tomato cans, coconut milk, soft drinks.
  can,

  /// Sealed packs or bags. Use for cheese packs, frozen veg packs, vacuum-sealed portions.
  pack,

  /// Boxes of goods. Use for tea bags, pastry boxes, disposable cup cartons.
  box,

  /// Bundles of fresh produce. Use for herbs, asparagus, spring onions sold by the bunch.
  bunch,

  /// Teaspoon volume (tsp ≈ 5 ml). Use for recipe-scale spice or extract amounts held in stock.
  teaspoon,

  /// Tablespoon volume (tbsp ≈ 15 ml). Use for recipe-scale sauces or seasoning stocked by spoon.
  tablespoon,

  /// Cup volume (≈ 240 ml culinary cup). Use when stock or prep is tracked by cups, not bottles.
  cup;

  static UnitsType fromJson(String name) {
    switch (name) {
      case 'gram':
        return UnitsType.gram;
      case 'kilogram':
        return UnitsType.kilogram;
      case 'milliliter':
        return UnitsType.milliliter;
      case 'centiliter':
        return UnitsType.centiliter;
      case 'liter':
        return UnitsType.liter;
      case 'piece':
        return UnitsType.piece;
      case 'bottle':
        return UnitsType.bottle;
      case 'can':
        return UnitsType.can;
      case 'pack':
        return UnitsType.pack;
      case 'box':
        return UnitsType.box;
      case 'bunch':
        return UnitsType.bunch;
      case 'teaspoon':
        return UnitsType.teaspoon;
      case 'tablespoon':
        return UnitsType.tablespoon;
      case 'cup':
        return UnitsType.cup;
      default:
        throw ArgumentError('Value "$name" cannot be converted to "UnitsType"');
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
