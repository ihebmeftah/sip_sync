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
import '../../packs/dtos/building_pack_end_reason.dart' as _ie6yrju5;
import '../../packs/dtos/pack_billing_period.dart' as _iohcjejn;

/// One row of a venue's pack history for the backoffice.
abstract class BuildingPackAssignmentView
    implements _is.SerializableModel, _is.ProtocolSerialization {
  BuildingPackAssignmentView._({
    required this.id,
    required this.packId,
    required this.packCode,
    required this.packName,
    this.billingPeriod,
    required this.startedAt,
    this.expiresAt,
    this.endedAt,
    this.endReason,
  });

  factory BuildingPackAssignmentView({
    required _is.UuidValue id,
    required _is.UuidValue packId,
    required String packCode,
    required String packName,
    _iohcjejn.PackBillingPeriod? billingPeriod,
    required DateTime startedAt,
    DateTime? expiresAt,
    DateTime? endedAt,
    _ie6yrju5.BuildingPackEndReason? endReason,
  }) = _BuildingPackAssignmentViewImpl;

  factory BuildingPackAssignmentView.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return BuildingPackAssignmentView(
      id: _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      packId: _is.UuidValueJsonExtension.fromJson(jsonSerialization['packId']),
      packCode: jsonSerialization['packCode'] as String,
      packName: jsonSerialization['packName'] as String,
      billingPeriod: jsonSerialization['billingPeriod'] == null
          ? null
          : _iohcjejn.PackBillingPeriod.fromJson(
              (jsonSerialization['billingPeriod'] as String),
            ),
      startedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['startedAt'],
      ),
      expiresAt: jsonSerialization['expiresAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['expiresAt']),
      endedAt: jsonSerialization['endedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['endedAt']),
      endReason: jsonSerialization['endReason'] == null
          ? null
          : _ie6yrju5.BuildingPackEndReason.fromJson(
              (jsonSerialization['endReason'] as String),
            ),
    );
  }

  _is.UuidValue id;

  _is.UuidValue packId;

  String packCode;

  String packName;

  _iohcjejn.PackBillingPeriod? billingPeriod;

  DateTime startedAt;

  DateTime? expiresAt;

  DateTime? endedAt;

  _ie6yrju5.BuildingPackEndReason? endReason;

  /// Returns a shallow copy of this [BuildingPackAssignmentView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  BuildingPackAssignmentView copyWith({
    _is.UuidValue? id,
    _is.UuidValue? packId,
    String? packCode,
    String? packName,
    _iohcjejn.PackBillingPeriod? billingPeriod,
    DateTime? startedAt,
    DateTime? expiresAt,
    DateTime? endedAt,
    _ie6yrju5.BuildingPackEndReason? endReason,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BuildingPackAssignmentView',
      'id': id.toJson(),
      'packId': packId.toJson(),
      'packCode': packCode,
      'packName': packName,
      if (billingPeriod != null) 'billingPeriod': billingPeriod?.toJson(),
      'startedAt': startedAt.toJson(),
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
      if (endedAt != null) 'endedAt': endedAt?.toJson(),
      if (endReason != null) 'endReason': endReason?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BuildingPackAssignmentView',
      'id': id.toJson(),
      'packId': packId.toJson(),
      'packCode': packCode,
      'packName': packName,
      if (billingPeriod != null) 'billingPeriod': billingPeriod?.toJson(),
      'startedAt': startedAt.toJson(),
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
      if (endedAt != null) 'endedAt': endedAt?.toJson(),
      if (endReason != null) 'endReason': endReason?.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BuildingPackAssignmentViewImpl extends BuildingPackAssignmentView {
  _BuildingPackAssignmentViewImpl({
    required _is.UuidValue id,
    required _is.UuidValue packId,
    required String packCode,
    required String packName,
    _iohcjejn.PackBillingPeriod? billingPeriod,
    required DateTime startedAt,
    DateTime? expiresAt,
    DateTime? endedAt,
    _ie6yrju5.BuildingPackEndReason? endReason,
  }) : super._(
         id: id,
         packId: packId,
         packCode: packCode,
         packName: packName,
         billingPeriod: billingPeriod,
         startedAt: startedAt,
         expiresAt: expiresAt,
         endedAt: endedAt,
         endReason: endReason,
       );

  /// Returns a shallow copy of this [BuildingPackAssignmentView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  BuildingPackAssignmentView copyWith({
    _is.UuidValue? id,
    _is.UuidValue? packId,
    String? packCode,
    String? packName,
    Object? billingPeriod = _Undefined,
    DateTime? startedAt,
    Object? expiresAt = _Undefined,
    Object? endedAt = _Undefined,
    Object? endReason = _Undefined,
  }) {
    return BuildingPackAssignmentView(
      id: id ?? this.id,
      packId: packId ?? this.packId,
      packCode: packCode ?? this.packCode,
      packName: packName ?? this.packName,
      billingPeriod: billingPeriod is _iohcjejn.PackBillingPeriod?
          ? billingPeriod
          : this.billingPeriod,
      startedAt: startedAt ?? this.startedAt,
      expiresAt: expiresAt is DateTime? ? expiresAt : this.expiresAt,
      endedAt: endedAt is DateTime? ? endedAt : this.endedAt,
      endReason: endReason is _ie6yrju5.BuildingPackEndReason?
          ? endReason
          : this.endReason,
    );
  }
}
