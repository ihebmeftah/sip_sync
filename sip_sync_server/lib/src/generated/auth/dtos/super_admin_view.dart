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

abstract class SuperAdminView
    implements _is.SerializableModel, _is.ProtocolSerialization {
  SuperAdminView._({
    required this.id,
    required this.email,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.isSystemDefault,
  });

  factory SuperAdminView({
    required _is.UuidValue id,
    required String email,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required bool isSystemDefault,
  }) = _SuperAdminViewImpl;

  factory SuperAdminView.fromJson(Map<String, dynamic> jsonSerialization) {
    return SuperAdminView(
      id: _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      email: jsonSerialization['email'] as String,
      phoneNumber: jsonSerialization['phoneNumber'] as String,
      firstName: jsonSerialization['firstName'] as String,
      lastName: jsonSerialization['lastName'] as String,
      isSystemDefault: _is.BoolJsonExtension.fromJson(
        jsonSerialization['isSystemDefault'],
      ),
    );
  }

  _is.UuidValue id;

  String email;

  String phoneNumber;

  String firstName;

  String lastName;

  bool isSystemDefault;

  /// Returns a shallow copy of this [SuperAdminView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SuperAdminView copyWith({
    _is.UuidValue? id,
    String? email,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    bool? isSystemDefault,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SuperAdminView',
      'id': id.toJson(),
      'email': email,
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
      'isSystemDefault': isSystemDefault,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SuperAdminView',
      'id': id.toJson(),
      'email': email,
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
      'isSystemDefault': isSystemDefault,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _SuperAdminViewImpl extends SuperAdminView {
  _SuperAdminViewImpl({
    required _is.UuidValue id,
    required String email,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required bool isSystemDefault,
  }) : super._(
         id: id,
         email: email,
         phoneNumber: phoneNumber,
         firstName: firstName,
         lastName: lastName,
         isSystemDefault: isSystemDefault,
       );

  /// Returns a shallow copy of this [SuperAdminView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SuperAdminView copyWith({
    _is.UuidValue? id,
    String? email,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    bool? isSystemDefault,
  }) {
    return SuperAdminView(
      id: id ?? this.id,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      isSystemDefault: isSystemDefault ?? this.isSystemDefault,
    );
  }
}
