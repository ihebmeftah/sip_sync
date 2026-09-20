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
import '../../orders/dtos/order_item_status.dart' as _iw3cmuga;

/// One fixed-rank step in a building's order-item workflow.
/// Clients may toggle [enabled] only; [rank] and [status] stay fixed.
abstract class StrictModeStep
    implements _is.SerializableModel, _is.ProtocolSerialization {
  StrictModeStep._({
    required this.rank,
    required this.status,
    required this.enabled,
  });

  factory StrictModeStep({
    required int rank,
    required _iw3cmuga.OrderItemStatus status,
    required bool enabled,
  }) = _StrictModeStepImpl;

  factory StrictModeStep.fromJson(Map<String, dynamic> jsonSerialization) {
    return StrictModeStep(
      rank: jsonSerialization['rank'] as int,
      status: _iw3cmuga.OrderItemStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      enabled: _is.BoolJsonExtension.fromJson(jsonSerialization['enabled']),
    );
  }

  int rank;

  _iw3cmuga.OrderItemStatus status;

  bool enabled;

  /// Returns a shallow copy of this [StrictModeStep]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  StrictModeStep copyWith({
    int? rank,
    _iw3cmuga.OrderItemStatus? status,
    bool? enabled,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StrictModeStep',
      'rank': rank,
      'status': status.toJson(),
      'enabled': enabled,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StrictModeStep',
      'rank': rank,
      'status': status.toJson(),
      'enabled': enabled,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _StrictModeStepImpl extends StrictModeStep {
  _StrictModeStepImpl({
    required int rank,
    required _iw3cmuga.OrderItemStatus status,
    required bool enabled,
  }) : super._(
         rank: rank,
         status: status,
         enabled: enabled,
       );

  /// Returns a shallow copy of this [StrictModeStep]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  StrictModeStep copyWith({
    int? rank,
    _iw3cmuga.OrderItemStatus? status,
    bool? enabled,
  }) {
    return StrictModeStep(
      rank: rank ?? this.rank,
      status: status ?? this.status,
      enabled: enabled ?? this.enabled,
    );
  }
}
