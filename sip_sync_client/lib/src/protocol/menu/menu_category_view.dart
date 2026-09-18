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

abstract class MenuCategoryView
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  MenuCategoryView._({
    required this.id,
    required this.buildingId,
    required this.name,
    this.description,
  });

  factory MenuCategoryView({
    required _isc.UuidValue id,
    required _isc.UuidValue buildingId,
    required String name,
    String? description,
  }) = _MenuCategoryViewImpl;

  factory MenuCategoryView.fromJson(Map<String, dynamic> jsonSerialization) {
    return MenuCategoryView(
      id: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      buildingId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['buildingId'],
      ),
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
    );
  }

  _isc.UuidValue id;

  _isc.UuidValue buildingId;

  String name;

  String? description;

  /// Returns a shallow copy of this [MenuCategoryView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  MenuCategoryView copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? buildingId,
    String? name,
    String? description,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MenuCategoryView',
      'id': id.toJson(),
      'buildingId': buildingId.toJson(),
      'name': name,
      if (description != null) 'description': description,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MenuCategoryView',
      'id': id.toJson(),
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

class _MenuCategoryViewImpl extends MenuCategoryView {
  _MenuCategoryViewImpl({
    required _isc.UuidValue id,
    required _isc.UuidValue buildingId,
    required String name,
    String? description,
  }) : super._(
         id: id,
         buildingId: buildingId,
         name: name,
         description: description,
       );

  /// Returns a shallow copy of this [MenuCategoryView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  MenuCategoryView copyWith({
    _isc.UuidValue? id,
    _isc.UuidValue? buildingId,
    String? name,
    Object? description = _Undefined,
  }) {
    return MenuCategoryView(
      id: id ?? this.id,
      buildingId: buildingId ?? this.buildingId,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
    );
  }
}
