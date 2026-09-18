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

abstract class MenuCategoryCreate
    implements _is.SerializableModel, _is.ProtocolSerialization {
  MenuCategoryCreate._({
    required this.buildingId,
    required this.name,
    this.description,
  });

  factory MenuCategoryCreate({
    required _is.UuidValue buildingId,
    required String name,
    String? description,
  }) = _MenuCategoryCreateImpl;

  factory MenuCategoryCreate.fromJson(Map<String, dynamic> jsonSerialization) {
    return MenuCategoryCreate(
      buildingId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['buildingId'],
      ),
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
    );
  }

  _is.UuidValue buildingId;

  String name;

  String? description;

  /// Returns a shallow copy of this [MenuCategoryCreate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  MenuCategoryCreate copyWith({
    _is.UuidValue? buildingId,
    String? name,
    String? description,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MenuCategoryCreate',
      'buildingId': buildingId.toJson(),
      'name': name,
      if (description != null) 'description': description,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MenuCategoryCreate',
      'buildingId': buildingId.toJson(),
      'name': name,
      if (description != null) 'description': description,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MenuCategoryCreateImpl extends MenuCategoryCreate {
  _MenuCategoryCreateImpl({
    required _is.UuidValue buildingId,
    required String name,
    String? description,
  }) : super._(
         buildingId: buildingId,
         name: name,
         description: description,
       );

  /// Returns a shallow copy of this [MenuCategoryCreate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  MenuCategoryCreate copyWith({
    _is.UuidValue? buildingId,
    String? name,
    Object? description = _Undefined,
  }) {
    return MenuCategoryCreate(
      buildingId: buildingId ?? this.buildingId,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
    );
  }
}
