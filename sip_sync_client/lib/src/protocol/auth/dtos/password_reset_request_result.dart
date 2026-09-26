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

/// Result of requesting a password reset. [debugCode] is set only in development/test.
abstract class PasswordResetRequestResult
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  PasswordResetRequestResult._({this.debugCode});

  factory PasswordResetRequestResult({String? debugCode}) =
      _PasswordResetRequestResultImpl;

  factory PasswordResetRequestResult.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return PasswordResetRequestResult(
      debugCode: jsonSerialization['debugCode'] as String?,
    );
  }

  String? debugCode;

  /// Returns a shallow copy of this [PasswordResetRequestResult]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  PasswordResetRequestResult copyWith({String? debugCode});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PasswordResetRequestResult',
      if (debugCode != null) 'debugCode': debugCode,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PasswordResetRequestResult',
      if (debugCode != null) 'debugCode': debugCode,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PasswordResetRequestResultImpl extends PasswordResetRequestResult {
  _PasswordResetRequestResultImpl({String? debugCode})
    : super._(debugCode: debugCode);

  /// Returns a shallow copy of this [PasswordResetRequestResult]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  PasswordResetRequestResult copyWith({Object? debugCode = _Undefined}) {
    return PasswordResetRequestResult(
      debugCode: debugCode is String? ? debugCode : this.debugCode,
    );
  }
}
