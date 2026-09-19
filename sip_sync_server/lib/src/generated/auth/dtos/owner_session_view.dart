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

abstract class OwnerSessionView
    implements _is.SerializableModel, _is.ProtocolSerialization {
  OwnerSessionView._({
    required this.id,
    required this.email,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
  });

  factory OwnerSessionView({
    required _is.UuidValue id,
    required String email,
    required String phoneNumber,
    required String firstName,
    required String lastName,
  }) = _OwnerSessionViewImpl;

  factory OwnerSessionView.fromJson(Map<String, dynamic> jsonSerialization) {
    return OwnerSessionView(
      id: _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      email: jsonSerialization['email'] as String,
      phoneNumber: jsonSerialization['phoneNumber'] as String,
      firstName: jsonSerialization['firstName'] as String,
      lastName: jsonSerialization['lastName'] as String,
    );
  }

  _is.UuidValue id;

  String email;

  String phoneNumber;

  String firstName;

  String lastName;

  /// Returns a shallow copy of this [OwnerSessionView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  OwnerSessionView copyWith({
    _is.UuidValue? id,
    String? email,
    String? phoneNumber,
    String? firstName,
    String? lastName,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OwnerSessionView',
      'id': id.toJson(),
      'email': email,
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OwnerSessionView',
      'id': id.toJson(),
      'email': email,
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _OwnerSessionViewImpl extends OwnerSessionView {
  _OwnerSessionViewImpl({
    required _is.UuidValue id,
    required String email,
    required String phoneNumber,
    required String firstName,
    required String lastName,
  }) : super._(
         id: id,
         email: email,
         phoneNumber: phoneNumber,
         firstName: firstName,
         lastName: lastName,
       );

  /// Returns a shallow copy of this [OwnerSessionView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  OwnerSessionView copyWith({
    _is.UuidValue? id,
    String? email,
    String? phoneNumber,
    String? firstName,
    String? lastName,
  }) {
    return OwnerSessionView(
      id: id ?? this.id,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }
}
