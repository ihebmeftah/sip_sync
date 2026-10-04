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
import '../../buildings/dtos/building_view.dart' as _ik5i9smt;

/// One page of venues the caller can open.
abstract class BuildingPage
    implements _is.SerializableModel, _is.ProtocolSerialization {
  BuildingPage._({
    required this.items,
    required this.total,
    required this.limit,
    required this.offset,
  });

  factory BuildingPage({
    required List<_ik5i9smt.BuildingView> items,
    required int total,
    required int limit,
    required int offset,
  }) = _BuildingPageImpl;

  factory BuildingPage.fromJson(Map<String, dynamic> jsonSerialization) {
    return BuildingPage(
      items: _iaib1p48.Protocol().deserialize<List<_ik5i9smt.BuildingView>>(
        jsonSerialization['items'],
      ),
      total: jsonSerialization['total'] as int,
      limit: jsonSerialization['limit'] as int,
      offset: jsonSerialization['offset'] as int,
    );
  }

  List<_ik5i9smt.BuildingView> items;

  int total;

  int limit;

  int offset;

  /// Returns a shallow copy of this [BuildingPage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  BuildingPage copyWith({
    List<_ik5i9smt.BuildingView>? items,
    int? total,
    int? limit,
    int? offset,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BuildingPage',
      'items': items.toJson(valueToJson: (v) => v.toJson()),
      'total': total,
      'limit': limit,
      'offset': offset,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BuildingPage',
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

class _BuildingPageImpl extends BuildingPage {
  _BuildingPageImpl({
    required List<_ik5i9smt.BuildingView> items,
    required int total,
    required int limit,
    required int offset,
  }) : super._(
         items: items,
         total: total,
         limit: limit,
         offset: offset,
       );

  /// Returns a shallow copy of this [BuildingPage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  BuildingPage copyWith({
    List<_ik5i9smt.BuildingView>? items,
    int? total,
    int? limit,
    int? offset,
  }) {
    return BuildingPage(
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
      total: total ?? this.total,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }
}
