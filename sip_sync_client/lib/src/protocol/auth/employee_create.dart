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

/// Owner creates staff. Username is generated on the server; no email.
abstract class EmployeeCreate
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  EmployeeCreate._({
    required this.password,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    this.buildingId,
  });

  factory EmployeeCreate({
    required String password,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    _isc.UuidValue? buildingId,
  }) = _EmployeeCreateImpl;

  factory EmployeeCreate.fromJson(Map<String, dynamic> jsonSerialization) {
    return EmployeeCreate(
      password: jsonSerialization['password'] as String,
      phoneNumber: jsonSerialization['phoneNumber'] as String,
      firstName: jsonSerialization['firstName'] as String,
      lastName: jsonSerialization['lastName'] as String,
      buildingId: jsonSerialization['buildingId'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(
              jsonSerialization['buildingId'],
            ),
    );
  }

  String password;

  String phoneNumber;

  String firstName;

  String lastName;

  _isc.UuidValue? buildingId;

  /// Returns a shallow copy of this [EmployeeCreate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  EmployeeCreate copyWith({
    String? password,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    _isc.UuidValue? buildingId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EmployeeCreate',
      'password': password,
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
      if (buildingId != null) 'buildingId': buildingId?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EmployeeCreate',
      'password': password,
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
      if (buildingId != null) 'buildingId': buildingId?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EmployeeCreateImpl extends EmployeeCreate {
  _EmployeeCreateImpl({
    required String password,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    _isc.UuidValue? buildingId,
  }) : super._(
         password: password,
         phoneNumber: phoneNumber,
         firstName: firstName,
         lastName: lastName,
         buildingId: buildingId,
       );

  /// Returns a shallow copy of this [EmployeeCreate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  EmployeeCreate copyWith({
    String? password,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    Object? buildingId = _Undefined,
  }) {
    return EmployeeCreate(
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      buildingId: buildingId is _isc.UuidValue? ? buildingId : this.buildingId,
    );
  }
}
