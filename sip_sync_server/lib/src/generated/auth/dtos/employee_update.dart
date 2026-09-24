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

abstract class EmployeeUpdate
    implements _is.SerializableModel, _is.ProtocolSerialization {
  EmployeeUpdate._({
    required this.id,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.accessId,
  });

  factory EmployeeUpdate({
    required _is.UuidValue id,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required _is.UuidValue accessId,
  }) = _EmployeeUpdateImpl;

  factory EmployeeUpdate.fromJson(Map<String, dynamic> jsonSerialization) {
    return EmployeeUpdate(
      id: _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      phoneNumber: jsonSerialization['phoneNumber'] as String,
      firstName: jsonSerialization['firstName'] as String,
      lastName: jsonSerialization['lastName'] as String,
      accessId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['accessId'],
      ),
    );
  }

  _is.UuidValue id;

  String phoneNumber;

  String firstName;

  String lastName;

  _is.UuidValue accessId;

  /// Returns a shallow copy of this [EmployeeUpdate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  EmployeeUpdate copyWith({
    _is.UuidValue? id,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    _is.UuidValue? accessId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EmployeeUpdate',
      'id': id.toJson(),
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
      'accessId': accessId.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EmployeeUpdate',
      'id': id.toJson(),
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
      'accessId': accessId.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _EmployeeUpdateImpl extends EmployeeUpdate {
  _EmployeeUpdateImpl({
    required _is.UuidValue id,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required _is.UuidValue accessId,
  }) : super._(
         id: id,
         phoneNumber: phoneNumber,
         firstName: firstName,
         lastName: lastName,
         accessId: accessId,
       );

  /// Returns a shallow copy of this [EmployeeUpdate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  EmployeeUpdate copyWith({
    _is.UuidValue? id,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    _is.UuidValue? accessId,
  }) {
    return EmployeeUpdate(
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      accessId: accessId ?? this.accessId,
    );
  }
}
