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

abstract class MenuCategoryCreate
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  MenuCategoryCreate._({
    required this.buildingId,
    required this.name,
    this.description,
  });

  factory MenuCategoryCreate({
    required _isc.UuidValue buildingId,
    required String name,
    String? description,
  }) = _MenuCategoryCreateImpl;

  factory MenuCategoryCreate.fromJson(Map<String, dynamic> jsonSerialization) {
    return MenuCategoryCreate(
      buildingId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['buildingId'],
      ),
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
    );
  }

  _isc.UuidValue buildingId;

  String name;

  String? description;

  /// Returns a shallow copy of this [MenuCategoryCreate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  MenuCategoryCreate copyWith({
    _isc.UuidValue? buildingId,
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
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MenuCategoryCreateImpl extends MenuCategoryCreate {
  _MenuCategoryCreateImpl({
    required _isc.UuidValue buildingId,
    required String name,
    String? description,
  }) : super._(
         buildingId: buildingId,
         name: name,
         description: description,
       );

  /// Returns a shallow copy of this [MenuCategoryCreate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  MenuCategoryCreate copyWith({
    _isc.UuidValue? buildingId,
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
