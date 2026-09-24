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
import '../../auth/dtos/actor_type.dart' as _i6ch5qy5;

/// Resolved actor shown on order / item attribution lines.
abstract class OrderActorView
    implements _is.SerializableModel, _is.ProtocolSerialization {
  OrderActorView._({
    required this.id,
    required this.type,
    required this.firstName,
    required this.lastName,
  });

  factory OrderActorView({
    required _is.UuidValue id,
    required _i6ch5qy5.ActorType type,
    required String firstName,
    required String lastName,
  }) = _OrderActorViewImpl;

  factory OrderActorView.fromJson(Map<String, dynamic> jsonSerialization) {
    return OrderActorView(
      id: _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      type: _i6ch5qy5.ActorType.fromJson((jsonSerialization['type'] as String)),
      firstName: jsonSerialization['firstName'] as String,
      lastName: jsonSerialization['lastName'] as String,
    );
  }

  _i6ch5qy5.ActorType type;

  _is.UuidValue id;

  String firstName;

  String lastName;

  /// Returns a shallow copy of this [OrderActorView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  OrderActorView copyWith({
    _is.UuidValue? id,
    _i6ch5qy5.ActorType? type,
    String? firstName,
    String? lastName,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OrderActorView',
      'id': id.toJson(),
      'type': type.toJson(),
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OrderActorView',
      'id': id.toJson(),
      'type': type.toJson(),
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _OrderActorViewImpl extends OrderActorView {
  _OrderActorViewImpl({
    required _is.UuidValue id,
    required _i6ch5qy5.ActorType type,
    required String firstName,
    required String lastName,
  }) : super._(
         id: id,
         type: type,
         firstName: firstName,
         lastName: lastName,
       );

  /// Returns a shallow copy of this [OrderActorView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  OrderActorView copyWith({
    _is.UuidValue? id,
    _i6ch5qy5.ActorType? type,
    String? firstName,
    String? lastName,
  }) {
    return OrderActorView(
      id: id ?? this.id,
      type: type ?? this.type,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }
}
