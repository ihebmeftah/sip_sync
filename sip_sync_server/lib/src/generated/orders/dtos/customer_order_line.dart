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
import '../../orders/dtos/order_item_status.dart' as _iw3cmuga;

/// One unit on a customer receipt. The same article can appear more than once.
abstract class CustomerOrderLine
    implements _is.SerializableModel, _is.ProtocolSerialization {
  CustomerOrderLine._({
    required this.id,
    required this.articleId,
    required this.name,
    required this.unitPrice,
    required this.status,
  });

  factory CustomerOrderLine({
    required _is.UuidValue id,
    required _is.UuidValue articleId,
    required String name,
    required double unitPrice,
    required _iw3cmuga.OrderItemStatus status,
  }) = _CustomerOrderLineImpl;

  factory CustomerOrderLine.fromJson(Map<String, dynamic> jsonSerialization) {
    return CustomerOrderLine(
      id: _is.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      articleId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['articleId'],
      ),
      name: jsonSerialization['name'] as String,
      unitPrice: (jsonSerialization['unitPrice'] as num).toDouble(),
      status: _iw3cmuga.OrderItemStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
    );
  }

  _is.UuidValue id;

  _is.UuidValue articleId;

  String name;

  double unitPrice;

  _iw3cmuga.OrderItemStatus status;

  /// Returns a shallow copy of this [CustomerOrderLine]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CustomerOrderLine copyWith({
    _is.UuidValue? id,
    _is.UuidValue? articleId,
    String? name,
    double? unitPrice,
    _iw3cmuga.OrderItemStatus? status,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CustomerOrderLine',
      'id': id.toJson(),
      'articleId': articleId.toJson(),
      'name': name,
      'unitPrice': unitPrice,
      'status': status.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CustomerOrderLine',
      'id': id.toJson(),
      'articleId': articleId.toJson(),
      'name': name,
      'unitPrice': unitPrice,
      'status': status.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _CustomerOrderLineImpl extends CustomerOrderLine {
  _CustomerOrderLineImpl({
    required _is.UuidValue id,
    required _is.UuidValue articleId,
    required String name,
    required double unitPrice,
    required _iw3cmuga.OrderItemStatus status,
  }) : super._(
         id: id,
         articleId: articleId,
         name: name,
         unitPrice: unitPrice,
         status: status,
       );

  /// Returns a shallow copy of this [CustomerOrderLine]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CustomerOrderLine copyWith({
    _is.UuidValue? id,
    _is.UuidValue? articleId,
    String? name,
    double? unitPrice,
    _iw3cmuga.OrderItemStatus? status,
  }) {
    return CustomerOrderLine(
      id: id ?? this.id,
      articleId: articleId ?? this.articleId,
      name: name ?? this.name,
      unitPrice: unitPrice ?? this.unitPrice,
      status: status ?? this.status,
    );
  }
}
