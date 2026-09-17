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

abstract class EmployeeSessionView
    implements _is.SerializableModel, _is.ProtocolSerialization {
  EmployeeSessionView._({
    required this.id,
    required this.buildingId,
    required this.ownerId,
    required this.username,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.isEnabled,
  });

  factory EmployeeSessionView({
    required _is.UuidValue id,
    required _is.UuidValue buildingId,
    required _is.UuidValue ownerId,
    required String username,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required bool isEnabled,
  }) = _EmployeeSessionViewImpl;

  factory EmployeeSessionView.fromJson(Map<String, dynamic> jsonSerialization) {
    return EmployeeSessionView(
      id: _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      buildingId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['buildingId'],
      ),
      ownerId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['ownerId'],
      ),
      username: jsonSerialization['username'] as String,
      phoneNumber: jsonSerialization['phoneNumber'] as String,
      firstName: jsonSerialization['firstName'] as String,
      lastName: jsonSerialization['lastName'] as String,
      isEnabled: _is.BoolJsonExtension.fromJson(jsonSerialization['isEnabled']),
    );
  }

  _is.UuidValue id;

  _is.UuidValue buildingId;

  _is.UuidValue ownerId;

  String username;

  String phoneNumber;

  String firstName;

  String lastName;

  bool isEnabled;

  /// Returns a shallow copy of this [EmployeeSessionView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  EmployeeSessionView copyWith({
    _is.UuidValue? id,
    _is.UuidValue? buildingId,
    _is.UuidValue? ownerId,
    String? username,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    bool? isEnabled,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EmployeeSessionView',
      'id': id.toJson(),
      'buildingId': buildingId.toJson(),
      'ownerId': ownerId.toJson(),
      'username': username,
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
      'isEnabled': isEnabled,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EmployeeSessionView',
      'id': id.toJson(),
      'buildingId': buildingId.toJson(),
      'ownerId': ownerId.toJson(),
      'username': username,
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

class _EmployeeSessionViewImpl extends EmployeeSessionView {
  _EmployeeSessionViewImpl({
    required _is.UuidValue id,
    required _is.UuidValue buildingId,
    required _is.UuidValue ownerId,
    required String username,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required bool isEnabled,
  }) : super._(
         id: id,
         buildingId: buildingId,
         ownerId: ownerId,
         username: username,
         phoneNumber: phoneNumber,
         firstName: firstName,
         lastName: lastName,
         isEnabled: isEnabled,
       );

  /// Returns a shallow copy of this [EmployeeSessionView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  EmployeeSessionView copyWith({
    _is.UuidValue? id,
    _is.UuidValue? buildingId,
    _is.UuidValue? ownerId,
    String? username,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    bool? isEnabled,
  }) {
    return EmployeeSessionView(
      id: id ?? this.id,
      buildingId: buildingId ?? this.buildingId,
      ownerId: ownerId ?? this.ownerId,
      username: username ?? this.username,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }
}
