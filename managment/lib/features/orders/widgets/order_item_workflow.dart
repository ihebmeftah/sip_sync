import 'package:sip_sync_client/sip_sync_client.dart';

/// Default kitchen → payment ranks (matches server [defaultStrictModeSteps]).
List<StrictModeStep> defaultStrictModeSteps() => [
  StrictModeStep(rank: 1, status: OrderItemStatus.picked, enabled: true),
  StrictModeStep(rank: 2, status: OrderItemStatus.ready, enabled: true),
  StrictModeStep(rank: 3, status: OrderItemStatus.served, enabled: true),
  StrictModeStep(rank: 4, status: OrderItemStatus.payed, enabled: true),
];

int orderItemStatusRank(OrderItemStatus status) => switch (status) {
  OrderItemStatus.progress => 0,
  OrderItemStatus.picked => 1,
  OrderItemStatus.ready => 2,
  OrderItemStatus.served => 3,
  OrderItemStatus.payed => 4,
  OrderItemStatus.cancelled => -1,
};

/// Merges saved enable flags onto the fixed pipeline (no reorder).
List<StrictModeStep> normalizeStrictModeSteps(List<StrictModeStep>? incoming) {
  final byStatus = {
    for (final step in incoming ?? const <StrictModeStep>[]) step.status: step,
  };
  return [
    for (final def in defaultStrictModeSteps())
      StrictModeStep(
        rank: def.rank,
        status: def.status,
        enabled: byStatus[def.status]?.enabled ?? def.enabled,
      ),
  ];
}

OrderItemStatus? nextEnabledStrictStatus(
  OrderItemStatus from,
  List<StrictModeStep> steps,
) {
  final enabled = steps.where((s) => s.enabled).toList(growable: false)
    ..sort((a, b) => a.rank.compareTo(b.rank));
  final fromRank = orderItemStatusRank(from);
  for (final step in enabled) {
    if (orderItemStatusRank(step.status) > fromRank) {
      return step.status;
    }
  }
  return null;
}

/// Next status for the advance button (respects building strict mode).
OrderItemStatus? nextOrderItemStatusForBuilding(
  OrderItemStatus status, {
  required bool strictMode,
  required List<StrictModeStep> steps,
}) {
  if (status == OrderItemStatus.payed || status == OrderItemStatus.cancelled) {
    return null;
  }
  if (strictMode) {
    return nextEnabledStrictStatus(status, steps);
  }
  return switch (status) {
    OrderItemStatus.progress => OrderItemStatus.picked,
    OrderItemStatus.picked => OrderItemStatus.ready,
    OrderItemStatus.ready => OrderItemStatus.served,
    OrderItemStatus.served => OrderItemStatus.payed,
    OrderItemStatus.payed || OrderItemStatus.cancelled => null,
  };
}

/// When strict mode is off, staff may jump straight to payed.
bool canJumpToPayed(OrderItemStatus status, {required bool strictMode}) {
  if (strictMode) return false;
  return status != OrderItemStatus.payed && status != OrderItemStatus.cancelled;
}
