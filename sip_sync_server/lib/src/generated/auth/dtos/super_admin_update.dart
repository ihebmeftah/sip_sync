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

/// Profile edit for a backoffice user. Blank [password] keeps the current hash.
abstract class SuperAdminUpdate
    implements _is.SerializableModel, _is.ProtocolSerialization {
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
    required _is.UuidValue id,
    required String email,
    String? password,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required bool isEnabled,
  }) = _SuperAdminUpdateImpl;

  factory SuperAdminUpdate.fromJson(Map<String, dynamic> jsonSerialization) {
    return SuperAdminUpdate(
      id: _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      email: jsonSerialization['email'] as String,
      password: jsonSerialization['password'] as String?,
      phoneNumber: jsonSerialization['phoneNumber'] as String,
      firstName: jsonSerialization['firstName'] as String,
      lastName: jsonSerialization['lastName'] as String,
      isEnabled: _is.BoolJsonExtension.fromJson(jsonSerialization['isEnabled']),
    );
  }

  _is.UuidValue id;

  String email;

  String? password;

  String phoneNumber;

  String firstName;

  String lastName;

  bool isEnabled;

  /// Returns a shallow copy of this [SuperAdminUpdate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SuperAdminUpdate copyWith({
    _is.UuidValue? id,
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
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SuperAdminUpdateImpl extends SuperAdminUpdate {
  _SuperAdminUpdateImpl({
    required _is.UuidValue id,
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
  @_is.useResult
  @override
  SuperAdminUpdate copyWith({
    _is.UuidValue? id,
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
