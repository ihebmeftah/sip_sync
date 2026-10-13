import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/access/floor_access.dart';

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
  final next = nextEnabledStrictStatus(status, steps);
  if (strictMode) {
    return next;
  }
  return next;
}

/// When strict mode is off, staff may jump to payed if that step is enabled.
bool canJumpToPayed(
  OrderItemStatus status, {
  required bool strictMode,
  required List<StrictModeStep> steps,
}) {
  if (strictMode) return false;
  if (status == OrderItemStatus.payed || status == OrderItemStatus.cancelled) {
    return false;
  }
  final next = nextEnabledStrictStatus(status, steps);
  if (next == null || next == OrderItemStatus.payed) return false;
  return steps.any(
    (step) => step.enabled && step.status == OrderItemStatus.payed,
  );
}

/// Board columns follow the venue's enabled steps. Payed lines leave the board.
List<OrderItemStatus> workflowBoardColumns(List<StrictModeStep> steps) {
  return [
    OrderItemStatus.progress,
    for (final step in steps)
      if (step.enabled && step.status != OrderItemStatus.payed) step.status,
  ];
}

/// Columns this person can move. Owners and consult-all see the whole chain.
List<OrderItemStatus> visibleWorkflowColumns({
  required List<StrictModeStep> steps,
  required FloorAccess access,
  required bool seesAll,
}) {
  final columns = workflowBoardColumns(steps);
  if (seesAll) return columns;
  return [
    for (final status in columns)
      if (_columnForAccess(status, steps, access)) status,
  ];
}

bool _columnForAccess(
  OrderItemStatus status,
  List<StrictModeStep> steps,
  FloorAccess access,
) {
  return switch (nextEnabledStrictStatus(status, steps)) {
    OrderItemStatus.picked || OrderItemStatus.ready => access.canPrepare,
    OrderItemStatus.served => access.canServe,
    OrderItemStatus.payed => access.canPay,
    _ => false,
  };
}

/// Whether this person may set [next] on this line.
bool canAdvanceWorkflowItem({
  required OrderView order,
  required OrderItemView item,
  required OrderItemStatus? next,
  required FloorAccess access,
  required bool isOwner,
  required bool seesAll,
  required ActorType? actorType,
  required UuidValue? actorId,
}) {
  if (next == null) return false;
  if (isOwner) return true;
  final allowed = switch (next) {
    OrderItemStatus.picked || OrderItemStatus.ready => access.canPrepare,
    OrderItemStatus.served => access.canServe,
    OrderItemStatus.payed => access.canPay,
    _ => false,
  };
  if (!allowed) return false;
  if (next == OrderItemStatus.payed) {
    return actorMayRecordService(
      order: order,
      item: item,
      seesAll: seesAll,
      actorType: actorType,
      actorId: actorId,
    );
  }
  return true;
}

/// Payed on a staff ticket belongs to the person who placed the line.
///
/// A customer-opened line has no staff owner, so any employee with payment
/// access may record it. Served is any employee with serving access.
bool actorMayRecordService({
  required OrderView order,
  required OrderItemView item,
  required bool seesAll,
  required ActorType? actorType,
  required UuidValue? actorId,
}) {
  if (seesAll) return true;
  if (actorType != null &&
      actorId != null &&
      order.launchedBy.type == actorType &&
      order.launchedBy.id == actorId) {
    return true;
  }
  final addedBy = item.addedBy;
  if (actorType != null &&
      actorId != null &&
      addedBy != null &&
      addedBy.type == actorType &&
      addedBy.id == actorId) {
    return true;
  }
  if (order.launchedBy.type == ActorType.owner ||
      order.launchedBy.type == ActorType.employee) {
    return false;
  }
  return addedBy == null ||
      (addedBy.type != ActorType.owner && addedBy.type != ActorType.employee);
}

/// Person stored for [status], when that step has been recorded.
OrderActorView? actorForItemStatus(OrderItemView item, OrderItemStatus status) {
  return switch (status) {
    OrderItemStatus.progress => item.addedBy,
    // Kitchen is one person: show them on picked until ready, then on ready.
    OrderItemStatus.picked => item.preparedAt == null ? item.preparedBy : null,
    OrderItemStatus.ready => item.preparedAt != null ? item.preparedBy : null,
    OrderItemStatus.served => item.servedBy,
    OrderItemStatus.payed => item.paidTo,
    OrderItemStatus.cancelled => item.cancelledBy,
  };
}
