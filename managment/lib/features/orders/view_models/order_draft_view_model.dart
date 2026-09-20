import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

part 'order_draft_view_model.g.dart';

/// In-progress new-order / append cart before confirm.
class OrderDraftState {
  const OrderDraftState({
    this.pickingTable = false,
    this.venueTableId,
    this.tableNumber,
    this.appendOrderId,
    this.unitCounts = const {},
  });

  /// User started "New order" and must tap a table on the floor map.
  final bool pickingTable;
  final UuidValue? venueTableId;
  final int? tableNumber;

  /// When set, confirm calls [OrdersViewModel.addItems] instead of create.
  final UuidValue? appendOrderId;

  /// How many separate item rows to create per article id.
  final Map<String, int> unitCounts;

  bool get isAppending => appendOrderId != null;

  int get totalArticleCount => unitCounts.values.fold(0, (sum, q) => sum + q);

  OrderDraftState copyWith({
    bool? pickingTable,
    UuidValue? venueTableId,
    int? tableNumber,
    UuidValue? appendOrderId,
    Map<String, int>? unitCounts,
    bool clearTable = false,
    bool clearAppend = false,
  }) {
    return OrderDraftState(
      pickingTable: pickingTable ?? this.pickingTable,
      venueTableId: clearTable ? null : (venueTableId ?? this.venueTableId),
      tableNumber: clearTable ? null : (tableNumber ?? this.tableNumber),
      appendOrderId: clearAppend ? null : (appendOrderId ?? this.appendOrderId),
      unitCounts: unitCounts ?? this.unitCounts,
    );
  }
}

@Riverpod(keepAlive: true)
class OrderDraftViewModel extends _$OrderDraftViewModel {
  @override
  OrderDraftState build(String buildingId) => const OrderDraftState();

  /// Clears any prior cart and enters floor-map table selection.
  void beginCreate() {
    state = const OrderDraftState(pickingTable: true);
  }

  /// Append articles to an existing open order (skips table pick).
  void beginAppend({
    required UuidValue orderId,
    required UuidValue tableId,
    required int tableNumber,
  }) {
    state = OrderDraftState(
      venueTableId: tableId,
      tableNumber: tableNumber,
      appendOrderId: orderId,
    );
  }

  void selectTable({required UuidValue id, required int number}) {
    state = state.copyWith(
      pickingTable: false,
      venueTableId: id,
      tableNumber: number,
      clearAppend: true,
    );
  }

  void cancelPicking() {
    state = const OrderDraftState();
  }

  void clearTable() {
    state = state.copyWith(clearTable: true, pickingTable: true);
  }

  void setUnitCount(UuidValue articleId, int count) {
    final next = Map<String, int>.from(state.unitCounts);
    if (count <= 0) {
      next.remove(articleId.uuid);
    } else {
      next[articleId.uuid] = count;
    }
    state = state.copyWith(unitCounts: next);
  }

  void increment(UuidValue articleId) {
    final current = state.unitCounts[articleId.uuid] ?? 0;
    setUnitCount(articleId, current + 1);
  }

  void decrement(UuidValue articleId) {
    final current = state.unitCounts[articleId.uuid] ?? 0;
    setUnitCount(articleId, current - 1);
  }

  /// One [OrderItemCreateLine] per unit (same article repeats).
  List<OrderItemCreateLine> toCreateLines() {
    return [
      for (final entry in state.unitCounts.entries)
        for (var i = 0; i < entry.value; i++)
          OrderItemCreateLine(articleId: UuidValue.fromString(entry.key)),
    ];
  }

  void clear() {
    state = const OrderDraftState();
  }
}
