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

/// Writable staff fields. Username and email are not editable.
abstract class EmployeeUpdate
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  EmployeeUpdate._({
    required this.authUserId,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
  });

  factory EmployeeUpdate({
    required _isc.UuidValue authUserId,
    required String phoneNumber,
    required String firstName,
    required String lastName,
  }) = _EmployeeUpdateImpl;

  factory EmployeeUpdate.fromJson(Map<String, dynamic> jsonSerialization) {
    return EmployeeUpdate(
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      phoneNumber: jsonSerialization['phoneNumber'] as String,
      firstName: jsonSerialization['firstName'] as String,
      lastName: jsonSerialization['lastName'] as String,
    );
  }

  _isc.UuidValue authUserId;

  String phoneNumber;

  String firstName;

  String lastName;

  /// Returns a shallow copy of this [EmployeeUpdate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  EmployeeUpdate copyWith({
    _isc.UuidValue? authUserId,
    String? phoneNumber,
    String? firstName,
    String? lastName,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EmployeeUpdate',
      'authUserId': authUserId.toJson(),
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EmployeeUpdate',
      'authUserId': authUserId.toJson(),
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _EmployeeUpdateImpl extends EmployeeUpdate {
  _EmployeeUpdateImpl({
    required _isc.UuidValue authUserId,
    required String phoneNumber,
    required String firstName,
    required String lastName,
  }) : super._(
         authUserId: authUserId,
         phoneNumber: phoneNumber,
         firstName: firstName,
         lastName: lastName,
       );

  /// Returns a shallow copy of this [EmployeeUpdate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  EmployeeUpdate copyWith({
    _isc.UuidValue? authUserId,
    String? phoneNumber,
    String? firstName,
    String? lastName,
  }) {
    return EmployeeUpdate(
      authUserId: authUserId ?? this.authUserId,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }
}
