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
import '../../packs/dtos/pack_view.dart' as _i9ywrq0m;

/// One page of the pack catalog.
abstract class PackPage
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  PackPage._({
    required this.items,
    required this.total,
    required this.limit,
    required this.offset,
  });

  factory PackPage({
    required List<_i9ywrq0m.PackView> items,
    required int total,
    required int limit,
    required int offset,
  }) = _PackPageImpl;

  factory PackPage.fromJson(Map<String, dynamic> jsonSerialization) {
    return PackPage(
      items: _iozg9o5r.Protocol().deserialize<List<_i9ywrq0m.PackView>>(
        jsonSerialization['items'],
      ),
      total: jsonSerialization['total'] as int,
      limit: jsonSerialization['limit'] as int,
      offset: jsonSerialization['offset'] as int,
    );
  }

  List<_i9ywrq0m.PackView> items;

  int total;

  int limit;

  int offset;

  /// Returns a shallow copy of this [PackPage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  PackPage copyWith({
    List<_i9ywrq0m.PackView>? items,
    int? total,
    int? limit,
    int? offset,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PackPage',
      'items': items.toJson(valueToJson: (v) => v.toJson()),
      'total': total,
      'limit': limit,
      'offset': offset,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PackPage',
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

class _PackPageImpl extends PackPage {
  _PackPageImpl({
    required List<_i9ywrq0m.PackView> items,
    required int total,
    required int limit,
    required int offset,
  }) : super._(
         items: items,
         total: total,
         limit: limit,
         offset: offset,
       );

  /// Returns a shallow copy of this [PackPage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  PackPage copyWith({
    List<_i9ywrq0m.PackView>? items,
    int? total,
    int? limit,
    int? offset,
  }) {
    return PackPage(
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
      total: total ?? this.total,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }
}
