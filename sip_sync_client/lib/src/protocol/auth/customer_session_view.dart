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

abstract class CustomerSessionView
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CustomerSessionView._({
    required this.id,
    required this.email,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
  });

  factory CustomerSessionView({
    required _isc.UuidValue id,
    required String email,
    required String phoneNumber,
    required String firstName,
    required String lastName,
  }) = _CustomerSessionViewImpl;

  factory CustomerSessionView.fromJson(Map<String, dynamic> jsonSerialization) {
    return CustomerSessionView(
      id: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      email: jsonSerialization['email'] as String,
      phoneNumber: jsonSerialization['phoneNumber'] as String,
      firstName: jsonSerialization['firstName'] as String,
      lastName: jsonSerialization['lastName'] as String,
    );
  }

  _isc.UuidValue id;

  String email;

  String phoneNumber;

  String firstName;

  String lastName;

  /// Returns a shallow copy of this [CustomerSessionView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CustomerSessionView copyWith({
    _isc.UuidValue? id,
    String? email,
    String? phoneNumber,
    String? firstName,
    String? lastName,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CustomerSessionView',
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
      '__className__': 'CustomerSessionView',
      'id': id.toJson(),
      'email': email,
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

class _CustomerSessionViewImpl extends CustomerSessionView {
  _CustomerSessionViewImpl({
    required _isc.UuidValue id,
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

  /// Returns a shallow copy of this [CustomerSessionView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CustomerSessionView copyWith({
    _isc.UuidValue? id,
    String? email,
    String? phoneNumber,
    String? firstName,
    String? lastName,
  }) {
    return CustomerSessionView(
      id: id ?? this.id,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }
}
