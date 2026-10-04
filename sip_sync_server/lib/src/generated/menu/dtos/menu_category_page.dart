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
import 'package:sip_sync_server/src/generated/protocol.dart' as _iaib1p48;
import '../../menu/dtos/menu_category_view.dart' as _iwnrd47q;

/// One page of menu categories for a venue.
abstract class MenuCategoryPage
    implements _is.SerializableModel, _is.ProtocolSerialization {
  MenuCategoryPage._({
    required this.items,
    required this.total,
    required this.limit,
    required this.offset,
  });

  factory MenuCategoryPage({
    required List<_iwnrd47q.MenuCategoryView> items,
    required int total,
    required int limit,
    required int offset,
  }) = _MenuCategoryPageImpl;

  factory MenuCategoryPage.fromJson(Map<String, dynamic> jsonSerialization) {
    return MenuCategoryPage(
      items: _iaib1p48.Protocol().deserialize<List<_iwnrd47q.MenuCategoryView>>(
        jsonSerialization['items'],
      ),
      total: jsonSerialization['total'] as int,
      limit: jsonSerialization['limit'] as int,
      offset: jsonSerialization['offset'] as int,
    );
  }

  List<_iwnrd47q.MenuCategoryView> items;

  int total;

  int limit;

  int offset;

  /// Returns a shallow copy of this [MenuCategoryPage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  MenuCategoryPage copyWith({
    List<_iwnrd47q.MenuCategoryView>? items,
    int? total,
    int? limit,
    int? offset,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MenuCategoryPage',
      'items': items.toJson(valueToJson: (v) => v.toJson()),
      'total': total,
      'limit': limit,
      'offset': offset,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MenuCategoryPage',
      'items': items.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'total': total,
      'limit': limit,
      'offset': offset,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _MenuCategoryPageImpl extends MenuCategoryPage {
  _MenuCategoryPageImpl({
    required List<_iwnrd47q.MenuCategoryView> items,
    required int total,
    required int limit,
    required int offset,
  }) : super._(
         items: items,
         total: total,
         limit: limit,
         offset: offset,
       );

  /// Returns a shallow copy of this [MenuCategoryPage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  MenuCategoryPage copyWith({
    List<_iwnrd47q.MenuCategoryView>? items,
    int? total,
    int? limit,
    int? offset,
  }) {
    return MenuCategoryPage(
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
      total: total ?? this.total,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }
}
