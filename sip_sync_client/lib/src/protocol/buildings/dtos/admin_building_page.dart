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
import 'package:sip_sync_client/src/protocol/protocol.dart' as _iozg9o5r;
import '../../buildings/dtos/admin_building_view.dart' as _i991oo14;

/// One page of venues for the backoffice.
abstract class AdminBuildingPage
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AdminBuildingPage._({
    required this.items,
    required this.total,
    required this.limit,
    required this.offset,
  });

  factory AdminBuildingPage({
    required List<_i991oo14.AdminBuildingView> items,
    required int total,
    required int limit,
    required int offset,
  }) = _AdminBuildingPageImpl;

  factory AdminBuildingPage.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminBuildingPage(
      items: _iozg9o5r.Protocol()
          .deserialize<List<_i991oo14.AdminBuildingView>>(
            jsonSerialization['items'],
          ),
      total: jsonSerialization['total'] as int,
      limit: jsonSerialization['limit'] as int,
      offset: jsonSerialization['offset'] as int,
    );
  }

  List<_i991oo14.AdminBuildingView> items;

  int total;

  int limit;

  int offset;

  /// Returns a shallow copy of this [AdminBuildingPage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AdminBuildingPage copyWith({
    List<_i991oo14.AdminBuildingView>? items,
    int? total,
    int? limit,
    int? offset,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminBuildingPage',
      'items': items.toJson(valueToJson: (v) => v.toJson()),
      'total': total,
      'limit': limit,
      'offset': offset,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminBuildingPage',
      'items': items.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'total': total,
      'limit': limit,
      'offset': offset,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _AdminBuildingPageImpl extends AdminBuildingPage {
  _AdminBuildingPageImpl({
    required List<_i991oo14.AdminBuildingView> items,
    required int total,
    required int limit,
    required int offset,
  }) : super._(
         items: items,
         total: total,
         limit: limit,
         offset: offset,
       );

  /// Returns a shallow copy of this [AdminBuildingPage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AdminBuildingPage copyWith({
    List<_i991oo14.AdminBuildingView>? items,
    int? total,
    int? limit,
    int? offset,
  }) {
    return AdminBuildingPage(
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
      total: total ?? this.total,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }
}
