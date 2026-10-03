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

/// A free table a customer may sit at. Number and seats only.
abstract class CustomerTablePreview
    implements _is.SerializableModel, _is.ProtocolSerialization {
  CustomerTablePreview._({
    required this.id,
    required this.number,
    required this.maxSeats,
  });

  factory CustomerTablePreview({
    required _is.UuidValue id,
    required int number,
    required int maxSeats,
  }) = _CustomerTablePreviewImpl;

  factory CustomerTablePreview.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CustomerTablePreview(
      id: _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      number: jsonSerialization['number'] as int,
      maxSeats: jsonSerialization['maxSeats'] as int,
    );
  }

  _is.UuidValue id;

  int number;

  int maxSeats;

  /// Returns a shallow copy of this [CustomerTablePreview]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CustomerTablePreview copyWith({
    _is.UuidValue? id,
    int? number,
    int? maxSeats,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CustomerTablePreview',
      'id': id.toJson(),
      'number': number,
      'maxSeats': maxSeats,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CustomerTablePreview',
      'id': id.toJson(),
      'number': number,
      'maxSeats': maxSeats,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _CustomerTablePreviewImpl extends CustomerTablePreview {
  _CustomerTablePreviewImpl({
    required _is.UuidValue id,
    required int number,
    required int maxSeats,
  }) : super._(
         id: id,
         number: number,
         maxSeats: maxSeats,
       );

  /// Returns a shallow copy of this [CustomerTablePreview]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CustomerTablePreview copyWith({
    _is.UuidValue? id,
    int? number,
    int? maxSeats,
  }) {
    return CustomerTablePreview(
      id: id ?? this.id,
      number: number ?? this.number,
      maxSeats: maxSeats ?? this.maxSeats,
    );
  }
}
