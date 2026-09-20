import '../generated/protocol.dart';

/// Default kitchen → payment pipeline ranks (fixed; UI only toggles [enabled]).
List<StrictModeStep> defaultStrictModeSteps() => [
  StrictModeStep(rank: 1, status: OrderItemStatus.picked, enabled: true),
  StrictModeStep(rank: 2, status: OrderItemStatus.ready, enabled: true),
  StrictModeStep(rank: 3, status: OrderItemStatus.served, enabled: true),
  StrictModeStep(rank: 4, status: OrderItemStatus.payed, enabled: true),
];

/// Canonical order for comparing statuses along the pipeline.
int orderItemStatusRank(OrderItemStatus status) => switch (status) {
  OrderItemStatus.progress => 0,
  OrderItemStatus.picked => 1,
  OrderItemStatus.ready => 2,
  OrderItemStatus.served => 3,
  OrderItemStatus.payed => 4,
  OrderItemStatus.cancelled => -1,
};

/// Next enabled step after [from], or null if none remain.
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

/// Normalizes client steps: fixed statuses/ranks; preserves enable flags by status.
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
