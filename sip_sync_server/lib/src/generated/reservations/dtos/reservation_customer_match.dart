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

/// Customer row a staff booking may attach. Email is for picking the account.
abstract class ReservationCustomerMatch
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ReservationCustomerMatch._({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
  });

  factory ReservationCustomerMatch({
    required _is.UuidValue id,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String email,
  }) = _ReservationCustomerMatchImpl;

  factory ReservationCustomerMatch.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ReservationCustomerMatch(
      id: _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      firstName: jsonSerialization['firstName'] as String,
      lastName: jsonSerialization['lastName'] as String,
      phoneNumber: jsonSerialization['phoneNumber'] as String,
      email: jsonSerialization['email'] as String,
    );
  }

  _is.UuidValue id;

  String firstName;

  String lastName;

  String phoneNumber;

  String email;

  /// Returns a shallow copy of this [ReservationCustomerMatch]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ReservationCustomerMatch copyWith({
    _is.UuidValue? id,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? email,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ReservationCustomerMatch',
      'id': id.toJson(),
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'email': email,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ReservationCustomerMatch',
      'id': id.toJson(),
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'email': email,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _ReservationCustomerMatchImpl extends ReservationCustomerMatch {
  _ReservationCustomerMatchImpl({
    required _is.UuidValue id,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String email,
  }) : super._(
         id: id,
         firstName: firstName,
         lastName: lastName,
         phoneNumber: phoneNumber,
         email: email,
       );

  /// Returns a shallow copy of this [ReservationCustomerMatch]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ReservationCustomerMatch copyWith({
    _is.UuidValue? id,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? email,
  }) {
    return ReservationCustomerMatch(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
    );
  }
}
