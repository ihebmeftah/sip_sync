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

abstract class SuperAdminView
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  SuperAdminView._({
    required this.id,
    required this.email,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.isSystemDefault,
    required this.isEnabled,
  });

  factory SuperAdminView({
    required _isc.UuidValue id,
    required String email,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required bool isSystemDefault,
    required bool isEnabled,
  }) = _SuperAdminViewImpl;

  factory SuperAdminView.fromJson(Map<String, dynamic> jsonSerialization) {
    return SuperAdminView(
      id: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      email: jsonSerialization['email'] as String,
      phoneNumber: jsonSerialization['phoneNumber'] as String,
      firstName: jsonSerialization['firstName'] as String,
      lastName: jsonSerialization['lastName'] as String,
      isSystemDefault: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['isSystemDefault'],
      ),
      isEnabled: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['isEnabled'],
      ),
    );
  }

  _isc.UuidValue id;

  String email;

  String phoneNumber;

  String firstName;

  String lastName;

  bool isSystemDefault;

  bool isEnabled;

  /// Returns a shallow copy of this [SuperAdminView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  SuperAdminView copyWith({
    _isc.UuidValue? id,
    String? email,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    bool? isSystemDefault,
    bool? isEnabled,
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
      'isEnabled': isEnabled,
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
      'isEnabled': isEnabled,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _SuperAdminViewImpl extends SuperAdminView {
  _SuperAdminViewImpl({
    required _isc.UuidValue id,
    required String email,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required bool isSystemDefault,
    required bool isEnabled,
  }) : super._(
         id: id,
         email: email,
         phoneNumber: phoneNumber,
         firstName: firstName,
         lastName: lastName,
         isSystemDefault: isSystemDefault,
         isEnabled: isEnabled,
       );

  /// Returns a shallow copy of this [SuperAdminView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  SuperAdminView copyWith({
    _isc.UuidValue? id,
    String? email,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    bool? isSystemDefault,
    bool? isEnabled,
  }) {
    return SuperAdminView(
      id: id ?? this.id,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      isSystemDefault: isSystemDefault ?? this.isSystemDefault,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }
}
