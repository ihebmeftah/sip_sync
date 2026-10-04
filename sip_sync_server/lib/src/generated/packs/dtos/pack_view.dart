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

/// Admin catalog row. Grants are not stored; a new venue starts on the free pack.
abstract class PackView
    implements _is.SerializableModel, _is.ProtocolSerialization {
  PackView._({
    required this.id,
    required this.code,
    required this.name,
    required this.monthlyMillimes,
    this.annualMillimes,
    required this.customerOrderFeeBps,
    required this.isPublic,
    required this.isEnabled,
    required this.isSystem,
    required this.sortOrder,
    required this.capabilities,
    required this.createdAt,
  });

  factory PackView({
    required _is.UuidValue id,
    required String code,
    required String name,
    required int monthlyMillimes,
    int? annualMillimes,
    required int customerOrderFeeBps,
    required bool isPublic,
    required bool isEnabled,
    required bool isSystem,
    required int sortOrder,
    required _i51kk1ns.PackCapabilities capabilities,
    required DateTime createdAt,
  }) = _PackViewImpl;

  factory PackView.fromJson(Map<String, dynamic> jsonSerialization) {
    return PackView(
      id: _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      code: jsonSerialization['code'] as String,
      name: jsonSerialization['name'] as String,
      monthlyMillimes: jsonSerialization['monthlyMillimes'] as int,
      annualMillimes: jsonSerialization['annualMillimes'] as int?,
      customerOrderFeeBps: jsonSerialization['customerOrderFeeBps'] as int,
      isPublic: _is.BoolJsonExtension.fromJson(jsonSerialization['isPublic']),
      isEnabled: _is.BoolJsonExtension.fromJson(jsonSerialization['isEnabled']),
      isSystem: _is.BoolJsonExtension.fromJson(jsonSerialization['isSystem']),
      sortOrder: jsonSerialization['sortOrder'] as int,
      capabilities: _iaib1p48.Protocol()
          .deserialize<_i51kk1ns.PackCapabilities>(
            jsonSerialization['capabilities'],
          ),
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  _is.UuidValue id;

  String code;

  String name;

  int monthlyMillimes;

  int? annualMillimes;

  int customerOrderFeeBps;

  bool isPublic;

  bool isEnabled;

  bool isSystem;

  int sortOrder;

  _i51kk1ns.PackCapabilities capabilities;

  DateTime createdAt;

  /// Returns a shallow copy of this [PackView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PackView copyWith({
    _is.UuidValue? id,
    String? code,
    String? name,
    int? monthlyMillimes,
    int? annualMillimes,
    int? customerOrderFeeBps,
    bool? isPublic,
    bool? isEnabled,
    bool? isSystem,
    int? sortOrder,
    _i51kk1ns.PackCapabilities? capabilities,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PackView',
      'id': id.toJson(),
      'code': code,
      'name': name,
      'monthlyMillimes': monthlyMillimes,
      if (annualMillimes != null) 'annualMillimes': annualMillimes,
      'customerOrderFeeBps': customerOrderFeeBps,
      'isPublic': isPublic,
      'isEnabled': isEnabled,
      'isSystem': isSystem,
      'sortOrder': sortOrder,
      'capabilities': capabilities.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PackView',
      'id': id.toJson(),
      'code': code,
      'name': name,
      'monthlyMillimes': monthlyMillimes,
      if (annualMillimes != null) 'annualMillimes': annualMillimes,
      'customerOrderFeeBps': customerOrderFeeBps,
      'isPublic': isPublic,
      'isEnabled': isEnabled,
      'isSystem': isSystem,
      'sortOrder': sortOrder,
      'capabilities': capabilities.toJsonForProtocol(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PackViewImpl extends PackView {
  _PackViewImpl({
    required _is.UuidValue id,
    required String code,
    required String name,
    required int monthlyMillimes,
    int? annualMillimes,
    required int customerOrderFeeBps,
    required bool isPublic,
    required bool isEnabled,
    required bool isSystem,
    required int sortOrder,
    required _i51kk1ns.PackCapabilities capabilities,
    required DateTime createdAt,
  }) : super._(
         id: id,
         code: code,
         name: name,
         monthlyMillimes: monthlyMillimes,
         annualMillimes: annualMillimes,
         customerOrderFeeBps: customerOrderFeeBps,
         isPublic: isPublic,
         isEnabled: isEnabled,
         isSystem: isSystem,
         sortOrder: sortOrder,
         capabilities: capabilities,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [PackView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PackView copyWith({
    _is.UuidValue? id,
    String? code,
    String? name,
    int? monthlyMillimes,
    Object? annualMillimes = _Undefined,
    int? customerOrderFeeBps,
    bool? isPublic,
    bool? isEnabled,
    bool? isSystem,
    int? sortOrder,
    _i51kk1ns.PackCapabilities? capabilities,
    DateTime? createdAt,
  }) {
    return PackView(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      monthlyMillimes: monthlyMillimes ?? this.monthlyMillimes,
      annualMillimes: annualMillimes is int?
          ? annualMillimes
          : this.annualMillimes,
      customerOrderFeeBps: customerOrderFeeBps ?? this.customerOrderFeeBps,
      isPublic: isPublic ?? this.isPublic,
      isEnabled: isEnabled ?? this.isEnabled,
      isSystem: isSystem ?? this.isSystem,
      sortOrder: sortOrder ?? this.sortOrder,
      capabilities: capabilities ?? this.capabilities.copyWith(),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
