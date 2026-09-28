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

/// Profile edit for a backoffice user. Blank [password] keeps the current hash.
abstract class SuperAdminUpdate
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  SuperAdminUpdate._({
    required this.id,
    required this.email,
    this.password,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.isEnabled,
  });

  factory SuperAdminUpdate({
    required _isc.UuidValue id,
    required String email,
    String? password,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required bool isEnabled,
  }) = _SuperAdminUpdateImpl;

  factory SuperAdminUpdate.fromJson(Map<String, dynamic> jsonSerialization) {
    return SuperAdminUpdate(
      id: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      email: jsonSerialization['email'] as String,
      password: jsonSerialization['password'] as String?,
      phoneNumber: jsonSerialization['phoneNumber'] as String,
      firstName: jsonSerialization['firstName'] as String,
      lastName: jsonSerialization['lastName'] as String,
      isEnabled: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['isEnabled'],
      ),
    );
  }

  _isc.UuidValue id;

  String email;

  String? password;

  String phoneNumber;

  String firstName;

  String lastName;

  bool isEnabled;

  /// Returns a shallow copy of this [SuperAdminUpdate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  SuperAdminUpdate copyWith({
    _isc.UuidValue? id,
    String? email,
    String? password,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    bool? isEnabled,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SuperAdminUpdate',
      'id': id.toJson(),
      'email': email,
      if (password != null) 'password': password,
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
      'isEnabled': isEnabled,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SuperAdminUpdate',
      'id': id.toJson(),
      'email': email,
      if (password != null) 'password': password,
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
      'isEnabled': isEnabled,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SuperAdminUpdateImpl extends SuperAdminUpdate {
  _SuperAdminUpdateImpl({
    required _isc.UuidValue id,
    required String email,
    String? password,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required bool isEnabled,
  }) : super._(
         id: id,
         email: email,
         password: password,
         phoneNumber: phoneNumber,
         firstName: firstName,
         lastName: lastName,
         isEnabled: isEnabled,
       );

  /// Returns a shallow copy of this [SuperAdminUpdate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  SuperAdminUpdate copyWith({
    _isc.UuidValue? id,
    String? email,
    Object? password = _Undefined,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    bool? isEnabled,
  }) {
    return SuperAdminUpdate(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password is String? ? password : this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }
}
