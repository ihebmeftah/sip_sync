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

/// Authenticated password change (current + new).
abstract class ChangePasswordRequest
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ChangePasswordRequest._({
    required this.currentPassword,
    required this.newPassword,
  });

  factory ChangePasswordRequest({
    required String currentPassword,
    required String newPassword,
  }) = _ChangePasswordRequestImpl;

  factory ChangePasswordRequest.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ChangePasswordRequest(
      currentPassword: jsonSerialization['currentPassword'] as String,
      newPassword: jsonSerialization['newPassword'] as String,
    );
  }

  String currentPassword;

  String newPassword;

  /// Returns a shallow copy of this [ChangePasswordRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ChangePasswordRequest copyWith({
    String? currentPassword,
    String? newPassword,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChangePasswordRequest',
      'currentPassword': currentPassword,
      'newPassword': newPassword,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ChangePasswordRequest',
      'currentPassword': currentPassword,
      'newPassword': newPassword,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _ChangePasswordRequestImpl extends ChangePasswordRequest {
  _ChangePasswordRequestImpl({
    required String currentPassword,
    required String newPassword,
  }) : super._(
         currentPassword: currentPassword,
         newPassword: newPassword,
       );

  /// Returns a shallow copy of this [ChangePasswordRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ChangePasswordRequest copyWith({
    String? currentPassword,
    String? newPassword,
  }) {
    return ChangePasswordRequest(
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
    );
  }
}
