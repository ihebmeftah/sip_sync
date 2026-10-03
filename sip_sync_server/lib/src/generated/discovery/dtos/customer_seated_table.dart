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

/// An active table confirmed from a customer QR scan. No order state.
abstract class CustomerSeatedTable
    implements _is.SerializableModel, _is.ProtocolSerialization {
  CustomerSeatedTable._({
    required this.buildingId,
    required this.tableId,
    required this.number,
    required this.maxSeats,
    required this.venueName,
  });

  factory CustomerSeatedTable({
    required _is.UuidValue buildingId,
    required _is.UuidValue tableId,
    required int number,
    required int maxSeats,
    required String venueName,
  }) = _CustomerSeatedTableImpl;

  factory CustomerSeatedTable.fromJson(Map<String, dynamic> jsonSerialization) {
    return CustomerSeatedTable(
      buildingId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['buildingId'],
      ),
      tableId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['tableId'],
      ),
      number: jsonSerialization['number'] as int,
      maxSeats: jsonSerialization['maxSeats'] as int,
      venueName: jsonSerialization['venueName'] as String,
    );
  }

  _is.UuidValue buildingId;

  _is.UuidValue tableId;

  int number;

  int maxSeats;

  String venueName;

  /// Returns a shallow copy of this [CustomerSeatedTable]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CustomerSeatedTable copyWith({
    _is.UuidValue? buildingId,
    _is.UuidValue? tableId,
    int? number,
    int? maxSeats,
    String? venueName,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CustomerSeatedTable',
      'buildingId': buildingId.toJson(),
      'tableId': tableId.toJson(),
      'number': number,
      'maxSeats': maxSeats,
      'venueName': venueName,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CustomerSeatedTable',
      'buildingId': buildingId.toJson(),
      'tableId': tableId.toJson(),
      'number': number,
      'maxSeats': maxSeats,
      'venueName': venueName,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _CustomerSeatedTableImpl extends CustomerSeatedTable {
  _CustomerSeatedTableImpl({
    required _is.UuidValue buildingId,
    required _is.UuidValue tableId,
    required int number,
    required int maxSeats,
    required String venueName,
  }) : super._(
         buildingId: buildingId,
         tableId: tableId,
         number: number,
         maxSeats: maxSeats,
         venueName: venueName,
       );

  /// Returns a shallow copy of this [CustomerSeatedTable]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CustomerSeatedTable copyWith({
    _is.UuidValue? buildingId,
    _is.UuidValue? tableId,
    int? number,
    int? maxSeats,
    String? venueName,
  }) {
    return CustomerSeatedTable(
      buildingId: buildingId ?? this.buildingId,
      tableId: tableId ?? this.tableId,
      number: number ?? this.number,
      maxSeats: maxSeats ?? this.maxSeats,
      venueName: venueName ?? this.venueName,
    );
  }
}
