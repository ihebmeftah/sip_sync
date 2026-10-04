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
import '../../auth/dtos/platform_person_view.dart' as _izufjikm;

/// One page of owners or customers.
abstract class PlatformPersonPage
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  PlatformPersonPage._({
    required this.items,
    required this.total,
    required this.limit,
    required this.offset,
  });

  factory PlatformPersonPage({
    required List<_izufjikm.PlatformPersonView> items,
    required int total,
    required int limit,
    required int offset,
  }) = _PlatformPersonPageImpl;

  factory PlatformPersonPage.fromJson(Map<String, dynamic> jsonSerialization) {
    return PlatformPersonPage(
      items: _iozg9o5r.Protocol()
          .deserialize<List<_izufjikm.PlatformPersonView>>(
            jsonSerialization['items'],
          ),
      total: jsonSerialization['total'] as int,
      limit: jsonSerialization['limit'] as int,
      offset: jsonSerialization['offset'] as int,
    );
  }

  List<_izufjikm.PlatformPersonView> items;

  int total;

  int limit;

  int offset;

  /// Returns a shallow copy of this [PlatformPersonPage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  PlatformPersonPage copyWith({
    List<_izufjikm.PlatformPersonView>? items,
    int? total,
    int? limit,
    int? offset,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PlatformPersonPage',
      'items': items.toJson(valueToJson: (v) => v.toJson()),
      'total': total,
      'limit': limit,
      'offset': offset,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PlatformPersonPage',
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

class _PlatformPersonPageImpl extends PlatformPersonPage {
  _PlatformPersonPageImpl({
    required List<_izufjikm.PlatformPersonView> items,
    required int total,
    required int limit,
    required int offset,
  }) : super._(
         items: items,
         total: total,
         limit: limit,
         offset: offset,
       );

  /// Returns a shallow copy of this [PlatformPersonPage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  PlatformPersonPage copyWith({
    List<_izufjikm.PlatformPersonView>? items,
    int? total,
    int? limit,
    int? offset,
  }) {
    return PlatformPersonPage(
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
      total: total ?? this.total,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }
}
