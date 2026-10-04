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
import '../../employee_access/dtos/employee_access_view.dart' as _ihjvf6nj;

/// One page of access profiles for a venue.
abstract class EmployeeAccessPage
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  EmployeeAccessPage._({
    required this.items,
    required this.total,
    required this.limit,
    required this.offset,
  });

  factory EmployeeAccessPage({
    required List<_ihjvf6nj.EmployeeAccessView> items,
    required int total,
    required int limit,
    required int offset,
  }) = _EmployeeAccessPageImpl;

  factory EmployeeAccessPage.fromJson(Map<String, dynamic> jsonSerialization) {
    return EmployeeAccessPage(
      items: _iozg9o5r.Protocol()
          .deserialize<List<_ihjvf6nj.EmployeeAccessView>>(
            jsonSerialization['items'],
          ),
      total: jsonSerialization['total'] as int,
      limit: jsonSerialization['limit'] as int,
      offset: jsonSerialization['offset'] as int,
    );
  }

  List<_ihjvf6nj.EmployeeAccessView> items;

  int total;

  int limit;

  int offset;

  /// Returns a shallow copy of this [EmployeeAccessPage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  EmployeeAccessPage copyWith({
    List<_ihjvf6nj.EmployeeAccessView>? items,
    int? total,
    int? limit,
    int? offset,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EmployeeAccessPage',
      'items': items.toJson(valueToJson: (v) => v.toJson()),
      'total': total,
      'limit': limit,
      'offset': offset,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EmployeeAccessPage',
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

class _EmployeeAccessPageImpl extends EmployeeAccessPage {
  _EmployeeAccessPageImpl({
    required List<_ihjvf6nj.EmployeeAccessView> items,
    required int total,
    required int limit,
    required int offset,
  }) : super._(
         items: items,
         total: total,
         limit: limit,
         offset: offset,
       );

  /// Returns a shallow copy of this [EmployeeAccessPage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  EmployeeAccessPage copyWith({
    List<_ihjvf6nj.EmployeeAccessView>? items,
    int? total,
    int? limit,
    int? offset,
  }) {
    return EmployeeAccessPage(
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
      total: total ?? this.total,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }
}
