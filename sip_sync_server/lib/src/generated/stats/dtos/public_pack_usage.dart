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

/// One public pack and how many venues and owners are on it.
abstract class PublicPackUsage
    implements _is.SerializableModel, _is.ProtocolSerialization {
  PublicPackUsage._({
    required this.id,
    required this.code,
    required this.name,
    required this.monthlyMillimes,
    required this.customerOrderFeeBps,
    required this.isEnabled,
    required this.venueCount,
    required this.ownerCount,
  });

  factory PublicPackUsage({
    required _is.UuidValue id,
    required String code,
    required String name,
    required int monthlyMillimes,
    required int customerOrderFeeBps,
    required bool isEnabled,
    required int venueCount,
    required int ownerCount,
  }) = _PublicPackUsageImpl;

  factory PublicPackUsage.fromJson(Map<String, dynamic> jsonSerialization) {
    return PublicPackUsage(
      id: _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      code: jsonSerialization['code'] as String,
      name: jsonSerialization['name'] as String,
      monthlyMillimes: jsonSerialization['monthlyMillimes'] as int,
      customerOrderFeeBps: jsonSerialization['customerOrderFeeBps'] as int,
      isEnabled: _is.BoolJsonExtension.fromJson(jsonSerialization['isEnabled']),
      venueCount: jsonSerialization['venueCount'] as int,
      ownerCount: jsonSerialization['ownerCount'] as int,
    );
  }

  _is.UuidValue id;

  String code;

  String name;

  int monthlyMillimes;

  int customerOrderFeeBps;

  bool isEnabled;

  /// Buildings whose current pack is this one.
  int venueCount;

  /// Distinct owners of those buildings.
  int ownerCount;

  /// Returns a shallow copy of this [PublicPackUsage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PublicPackUsage copyWith({
    _is.UuidValue? id,
    String? code,
    String? name,
    int? monthlyMillimes,
    int? customerOrderFeeBps,
    bool? isEnabled,
    int? venueCount,
    int? ownerCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PublicPackUsage',
      'id': id.toJson(),
      'code': code,
      'name': name,
      'monthlyMillimes': monthlyMillimes,
      'customerOrderFeeBps': customerOrderFeeBps,
      'isEnabled': isEnabled,
      'venueCount': venueCount,
      'ownerCount': ownerCount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PublicPackUsage',
      'id': id.toJson(),
      'code': code,
      'name': name,
      'monthlyMillimes': monthlyMillimes,
      'customerOrderFeeBps': customerOrderFeeBps,
      'isEnabled': isEnabled,
      'venueCount': venueCount,
      'ownerCount': ownerCount,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _PublicPackUsageImpl extends PublicPackUsage {
  _PublicPackUsageImpl({
    required _is.UuidValue id,
    required String code,
    required String name,
    required int monthlyMillimes,
    required int customerOrderFeeBps,
    required bool isEnabled,
    required int venueCount,
    required int ownerCount,
  }) : super._(
         id: id,
         code: code,
         name: name,
         monthlyMillimes: monthlyMillimes,
         customerOrderFeeBps: customerOrderFeeBps,
         isEnabled: isEnabled,
         venueCount: venueCount,
         ownerCount: ownerCount,
       );

  /// Returns a shallow copy of this [PublicPackUsage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PublicPackUsage copyWith({
    _is.UuidValue? id,
    String? code,
    String? name,
    int? monthlyMillimes,
    int? customerOrderFeeBps,
    bool? isEnabled,
    int? venueCount,
    int? ownerCount,
  }) {
    return PublicPackUsage(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      monthlyMillimes: monthlyMillimes ?? this.monthlyMillimes,
      customerOrderFeeBps: customerOrderFeeBps ?? this.customerOrderFeeBps,
      isEnabled: isEnabled ?? this.isEnabled,
      venueCount: venueCount ?? this.venueCount,
      ownerCount: ownerCount ?? this.ownerCount,
    );
  }
}
