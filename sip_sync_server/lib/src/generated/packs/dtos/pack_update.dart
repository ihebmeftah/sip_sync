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
import '../../packs/dtos/pack_capabilities.dart' as _i51kk1ns;

/// Replace the editable fields. Code and isSystem stay.
abstract class PackUpdate
    implements _is.SerializableModel, _is.ProtocolSerialization {
  PackUpdate._({
    required this.id,
    required this.name,
    required this.monthlyMillimes,
    this.annualMillimes,
    required this.customerOrderFeeBps,
    required this.isPublic,
    required this.isEnabled,
    required this.sortOrder,
    required this.capabilities,
  });

  factory PackUpdate({
    required _is.UuidValue id,
    required String name,
    required int monthlyMillimes,
    int? annualMillimes,
    required int customerOrderFeeBps,
    required bool isPublic,
    required bool isEnabled,
    required int sortOrder,
    required _i51kk1ns.PackCapabilities capabilities,
  }) = _PackUpdateImpl;

  factory PackUpdate.fromJson(Map<String, dynamic> jsonSerialization) {
    return PackUpdate(
      id: _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      name: jsonSerialization['name'] as String,
      monthlyMillimes: jsonSerialization['monthlyMillimes'] as int,
      annualMillimes: jsonSerialization['annualMillimes'] as int?,
      customerOrderFeeBps: jsonSerialization['customerOrderFeeBps'] as int,
      isPublic: _is.BoolJsonExtension.fromJson(jsonSerialization['isPublic']),
      isEnabled: _is.BoolJsonExtension.fromJson(jsonSerialization['isEnabled']),
      sortOrder: jsonSerialization['sortOrder'] as int,
      capabilities: _iaib1p48.Protocol()
          .deserialize<_i51kk1ns.PackCapabilities>(
            jsonSerialization['capabilities'],
          ),
    );
  }

  _is.UuidValue id;

  String name;

  int monthlyMillimes;

  int? annualMillimes;

  int customerOrderFeeBps;

  bool isPublic;

  bool isEnabled;

  int sortOrder;

  _i51kk1ns.PackCapabilities capabilities;

  /// Returns a shallow copy of this [PackUpdate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PackUpdate copyWith({
    _is.UuidValue? id,
    String? name,
    int? monthlyMillimes,
    int? annualMillimes,
    int? customerOrderFeeBps,
    bool? isPublic,
    bool? isEnabled,
    int? sortOrder,
    _i51kk1ns.PackCapabilities? capabilities,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PackUpdate',
      'id': id.toJson(),
      'name': name,
      'monthlyMillimes': monthlyMillimes,
      if (annualMillimes != null) 'annualMillimes': annualMillimes,
      'customerOrderFeeBps': customerOrderFeeBps,
      'isPublic': isPublic,
      'isEnabled': isEnabled,
      'sortOrder': sortOrder,
      'capabilities': capabilities.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PackUpdate',
      'id': id.toJson(),
      'name': name,
      'monthlyMillimes': monthlyMillimes,
      if (annualMillimes != null) 'annualMillimes': annualMillimes,
      'customerOrderFeeBps': customerOrderFeeBps,
      'isPublic': isPublic,
      'isEnabled': isEnabled,
      'sortOrder': sortOrder,
      'capabilities': capabilities.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PackUpdateImpl extends PackUpdate {
  _PackUpdateImpl({
    required _is.UuidValue id,
    required String name,
    required int monthlyMillimes,
    int? annualMillimes,
    required int customerOrderFeeBps,
    required bool isPublic,
    required bool isEnabled,
    required int sortOrder,
    required _i51kk1ns.PackCapabilities capabilities,
  }) : super._(
         id: id,
         name: name,
         monthlyMillimes: monthlyMillimes,
         annualMillimes: annualMillimes,
         customerOrderFeeBps: customerOrderFeeBps,
         isPublic: isPublic,
         isEnabled: isEnabled,
         sortOrder: sortOrder,
         capabilities: capabilities,
       );

  /// Returns a shallow copy of this [PackUpdate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PackUpdate copyWith({
    _is.UuidValue? id,
    String? name,
    int? monthlyMillimes,
    Object? annualMillimes = _Undefined,
    int? customerOrderFeeBps,
    bool? isPublic,
    bool? isEnabled,
    int? sortOrder,
    _i51kk1ns.PackCapabilities? capabilities,
  }) {
    return PackUpdate(
      id: id ?? this.id,
      name: name ?? this.name,
      monthlyMillimes: monthlyMillimes ?? this.monthlyMillimes,
      annualMillimes: annualMillimes is int?
          ? annualMillimes
          : this.annualMillimes,
      customerOrderFeeBps: customerOrderFeeBps ?? this.customerOrderFeeBps,
      isPublic: isPublic ?? this.isPublic,
      isEnabled: isEnabled ?? this.isEnabled,
      sortOrder: sortOrder ?? this.sortOrder,
      capabilities: capabilities ?? this.capabilities.copyWith(),
    );
  }
}
