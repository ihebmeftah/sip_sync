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

/// Enabled public pack for the apps. Grants stay off this shape.
abstract class PackPublicView
    implements _is.SerializableModel, _is.ProtocolSerialization {
  PackPublicView._({
    required this.id,
    required this.code,
    required this.name,
    required this.monthlyMillimes,
    this.annualMillimes,
    required this.customerOrderFeeBps,
    required this.sortOrder,
    required this.capabilities,
  });

  factory PackPublicView({
    required _is.UuidValue id,
    required String code,
    required String name,
    required int monthlyMillimes,
    int? annualMillimes,
    required int customerOrderFeeBps,
    required int sortOrder,
    required _i51kk1ns.PackCapabilities capabilities,
  }) = _PackPublicViewImpl;

  factory PackPublicView.fromJson(Map<String, dynamic> jsonSerialization) {
    return PackPublicView(
      id: _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      code: jsonSerialization['code'] as String,
      name: jsonSerialization['name'] as String,
      monthlyMillimes: jsonSerialization['monthlyMillimes'] as int,
      annualMillimes: jsonSerialization['annualMillimes'] as int?,
      customerOrderFeeBps: jsonSerialization['customerOrderFeeBps'] as int,
      sortOrder: jsonSerialization['sortOrder'] as int,
      capabilities: _iaib1p48.Protocol()
          .deserialize<_i51kk1ns.PackCapabilities>(
            jsonSerialization['capabilities'],
          ),
    );
  }

  _is.UuidValue id;

  String code;

  String name;

  int monthlyMillimes;

  int? annualMillimes;

  int customerOrderFeeBps;

  int sortOrder;

  _i51kk1ns.PackCapabilities capabilities;

  /// Returns a shallow copy of this [PackPublicView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PackPublicView copyWith({
    _is.UuidValue? id,
    String? code,
    String? name,
    int? monthlyMillimes,
    int? annualMillimes,
    int? customerOrderFeeBps,
    int? sortOrder,
    _i51kk1ns.PackCapabilities? capabilities,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PackPublicView',
      'id': id.toJson(),
      'code': code,
      'name': name,
      'monthlyMillimes': monthlyMillimes,
      if (annualMillimes != null) 'annualMillimes': annualMillimes,
      'customerOrderFeeBps': customerOrderFeeBps,
      'sortOrder': sortOrder,
      'capabilities': capabilities.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PackPublicView',
      'id': id.toJson(),
      'code': code,
      'name': name,
      'monthlyMillimes': monthlyMillimes,
      if (annualMillimes != null) 'annualMillimes': annualMillimes,
      'customerOrderFeeBps': customerOrderFeeBps,
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

class _PackPublicViewImpl extends PackPublicView {
  _PackPublicViewImpl({
    required _is.UuidValue id,
    required String code,
    required String name,
    required int monthlyMillimes,
    int? annualMillimes,
    required int customerOrderFeeBps,
    required int sortOrder,
    required _i51kk1ns.PackCapabilities capabilities,
  }) : super._(
         id: id,
         code: code,
         name: name,
         monthlyMillimes: monthlyMillimes,
         annualMillimes: annualMillimes,
         customerOrderFeeBps: customerOrderFeeBps,
         sortOrder: sortOrder,
         capabilities: capabilities,
       );

  /// Returns a shallow copy of this [PackPublicView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PackPublicView copyWith({
    _is.UuidValue? id,
    String? code,
    String? name,
    int? monthlyMillimes,
    Object? annualMillimes = _Undefined,
    int? customerOrderFeeBps,
    int? sortOrder,
    _i51kk1ns.PackCapabilities? capabilities,
  }) {
    return PackPublicView(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      monthlyMillimes: monthlyMillimes ?? this.monthlyMillimes,
      annualMillimes: annualMillimes is int?
          ? annualMillimes
          : this.annualMillimes,
      customerOrderFeeBps: customerOrderFeeBps ?? this.customerOrderFeeBps,
      sortOrder: sortOrder ?? this.sortOrder,
      capabilities: capabilities ?? this.capabilities.copyWith(),
    );
  }
}
