import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

part 'order_cart_view_model.g.dart';

/// One dish held until the customer passes the order.
class CartLine {
  const CartLine({
    required this.articleId,
    required this.name,
    required this.unitPrice,
    required this.quantity,
  });

  final String articleId;
  final String name;
  final double unitPrice;
  final int quantity;

  double get lineTotal => unitPrice * quantity;

  CartLine copyWith({int? quantity}) {
    return CartLine(
      articleId: articleId,
      name: name,
      unitPrice: unitPrice,
      quantity: quantity ?? this.quantity,
    );
  }
}

/// How many units are in [lines].
int cartUnits(List<CartLine> lines) {
  return lines.fold(0, (sum, line) => sum + line.quantity);
}

/// Preview total from menu prices. The receipt uses the server total.
double cartTotal(List<CartLine> lines) {
  return lines.fold(0, (sum, line) => sum + line.lineTotal);
}

/// Dishes selected for one venue. Survives the scan screen.
@Riverpod(keepAlive: true)
class OrderCart extends _$OrderCart {
  @override
  List<CartLine> build(String buildingId) => const [];

  /// Adds one unit of [article], up to 99 of that dish and 200 units total.
  void add(CustomerArticlePreview article) {
    final id = article.id.uuid;
    final current = [...state];
    final index = current.indexWhere((line) => line.articleId == id);
    if (cartUnits(current) >= 200) {
      return;
    }
    if (index < 0) {
      state = [
        ...current,
        CartLine(
          articleId: id,
          name: article.name,
          unitPrice: article.price,
          quantity: 1,
        ),
      ];
      return;
    }
    if (current[index].quantity >= 99) {
      return;
    }
    current[index] = current[index].copyWith(
      quantity: current[index].quantity + 1,
    );
    state = current;
  }

  /// Removes one unit. The line disappears at zero.
  void remove(String articleId) {
    final current = [...state];
    final index = current.indexWhere((line) => line.articleId == articleId);
    if (index < 0) {
      return;
    }
    final next = current[index].quantity - 1;
    if (next <= 0) {
      current.removeAt(index);
    } else {
      current[index] = current[index].copyWith(quantity: next);
    }
    state = current;
  }

  /// Drops the selection after the order is accepted.
  void clear() => state = const [];
}
