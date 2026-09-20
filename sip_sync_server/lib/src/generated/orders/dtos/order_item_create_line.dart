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

/// One unit of an article to attach to an order (repeat for multiples).
abstract class OrderItemCreateLine
    implements _is.SerializableModel, _is.ProtocolSerialization {
  OrderItemCreateLine._({required this.articleId});

  factory OrderItemCreateLine({required _is.UuidValue articleId}) =
      _OrderItemCreateLineImpl;

  factory OrderItemCreateLine.fromJson(Map<String, dynamic> jsonSerialization) {
    return OrderItemCreateLine(
      articleId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['articleId'],
      ),
    );
  }

  _is.UuidValue articleId;

  /// Returns a shallow copy of this [OrderItemCreateLine]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  OrderItemCreateLine copyWith({_is.UuidValue? articleId});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OrderItemCreateLine',
      'articleId': articleId.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OrderItemCreateLine',
      'articleId': articleId.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _OrderItemCreateLineImpl extends OrderItemCreateLine {
  _OrderItemCreateLineImpl({required _is.UuidValue articleId})
    : super._(articleId: articleId);

  /// Returns a shallow copy of this [OrderItemCreateLine]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  OrderItemCreateLine copyWith({_is.UuidValue? articleId}) {
    return OrderItemCreateLine(articleId: articleId ?? this.articleId);
  }
}
