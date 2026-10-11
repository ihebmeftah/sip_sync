import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/access/floor_access.dart';
import '../../../core/di/app_providers.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../core/widgets/app_loader.dart';
import '../../../core/widgets/form_presentation.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../orders/view_models/order_draft_view_model.dart';
import '../../orders/view_models/orders_view_model.dart';
import '../../orders/widgets/order_item_info_sheet.dart';
import '../../orders/widgets/order_status_labels.dart';
import 'venue_table_dialog.dart';

/// Opens table actions: edit (owner), open order(s), create / append.
///
/// Mobile → bottom sheet; wide → dialog.
Future<void> showTableActionsSheet(
  BuildContext context, {
  required String buildingId,
  required VenueTableView table,
}) {
  if (useFormDialog(context)) {
    return showDialog<void>(
      context: context,
      builder: (context) => Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420, maxHeight: 560),
          child: _TableActionsBody(buildingId: buildingId, table: table),
        ),
      ),
    );
  }
  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (context) => SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: _TableActionsBody(buildingId: buildingId, table: table),
      ),
    ),
  );
}

class _TableActionsBody extends ConsumerStatefulWidget {
  const _TableActionsBody({required this.buildingId, required this.table});

  final String buildingId;
  final VenueTableView table;

  @override
  ConsumerState<_TableActionsBody> createState() => _TableActionsBodyState();
}

class _TableActionsBodyState extends ConsumerState<_TableActionsBody> {
  var _loadingOrders = true;
  String? _ordersErrorKey;
  List<OrderView> _openOrders = const [];

  @override
  void initState() {
    super.initState();
    Future<void>.microtask(_loadOpenOrders);
  }

  Future<void> _loadOpenOrders() async {
    setState(() {
      _loadingOrders = true;
      _ordersErrorKey = null;
    });
    try {
      final orders = await ref
          .read(ordersViewModelProvider(widget.buildingId).notifier)
          .openOrdersForTable(widget.table.id);
      if (!mounted) return;
      setState(() {
        _openOrders = orders;
        _loadingOrders = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _ordersErrorKey = mapError(error).l10nKey;
        _loadingOrders = false;
      });
    }
  }

  void _close() => Navigator.of(context).pop();

  Future<void> _editTable() async {
    _close();
    await openVenueTableForm(
      context,
      buildingId: widget.buildingId,
      existing: widget.table,
    );
  }

  void _openOrder(OrderView order) {
    _close();
    OrderDetailRoute(
      buildingId: widget.buildingId,
      orderId: order.id.uuid,
    ).go(context);
  }

  void _createOrder() {
    final l10n = AppLocalizations.of(context)!;
    if (!widget.table.isActive) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.orderTableInactive)));
      return;
    }
    final multiOrder =
        ref.read(buildingSelectionProvider)?.tableMultiOrder ?? false;
    if (!multiOrder && widget.table.status == TableFloorStatus.occupied) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.orderTableOccupied)));
      return;
    }
    _close();
    ref
        .read(orderDraftViewModelProvider(widget.buildingId).notifier)
        .startOnTable(id: widget.table.id, number: widget.table.number);
    OrderCreateArticlesRoute(buildingId: widget.buildingId).go(context);
  }

  void _appendToOrder(OrderView order) {
    final l10n = AppLocalizations.of(context)!;
    final allowAppend =
        ref.read(buildingSelectionProvider)?.allowAppendingItemsToOrder ?? true;
    if (!allowAppend) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.orderAppendArticlesDisabled)));
      return;
    }
    _close();
    ref
        .read(orderDraftViewModelProvider(widget.buildingId).notifier)
        .beginAppend(
          orderId: order.id,
          tableId: widget.table.id,
          tableNumber: widget.table.number,
        );
    OrderCreateArticlesRoute(buildingId: widget.buildingId).go(context);
  }

  String _reservedLabel(AppLocalizations l10n) {
    final guest = widget.table.reservationGuest;
    final phase = switch (widget.table.reservationPhase) {
      ReservationPhase.holding => l10n.reservationHolding,
      ReservationPhase.soon => l10n.reservationSoon,
      ReservationPhase.none => l10n.tableStatusReserved,
    };
    if (guest == null || guest.isEmpty) {
      return phase;
    }
    return '$phase · $guest';
  }

  String _statusLabel(AppLocalizations l10n) {
    return switch (widget.table.status) {
      TableFloorStatus.available => l10n.tableStatusAvailable,
      TableFloorStatus.occupied => l10n.tableStatusOccupied,
      TableFloorStatus.reserved => _reservedLabel(l10n),
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final store = ref.watch(appSessionStoreProvider);
    final isOwner = store.isOwner;
    final access = FloorAccess.fromSession(store);
    final building = ref.watch(buildingSelectionProvider);
    final multiOrder = building?.tableMultiOrder ?? false;
    final allowAppend = building?.allowAppendingItemsToOrder ?? true;
    final currency = building?.currencyCode ?? '';
    final canCreate =
        (isOwner || access.canCreateOrders) &&
        widget.table.isActive &&
        (multiOrder || widget.table.status != TableFloorStatus.occupied);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.sm,
        AppSpacing.xl,
        AppSpacing.xl,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.orderTableNumber(widget.table.number),
              style: text.titleLarge,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              '${l10n.tableSeatsCount(widget.table.maxSeats)} · ${_statusLabel(l10n)}'
              '${widget.table.isActive ? '' : ' · ${l10n.tableFilterInactive}'}',
              style: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: AppSpacing.lg),
            if (isOwner)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.edit_outlined, color: scheme.primary),
                title: Text(l10n.editTable),
                trailing: const Icon(Icons.chevron_right),
                onTap: _editTable,
              ),
            Text(
              multiOrder
                  ? l10n.tableOpenOrdersHeading
                  : l10n.tableOpenOrderHeading,
              style: text.titleSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: AppSpacing.sm),
            if (_loadingOrders)
              const AppScreenLoader()
            else if (_ordersErrorKey != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppErrorBanner(message: lookupError(l10n, _ordersErrorKey!)),
                  TextButton(
                    onPressed: _loadOpenOrders,
                    child: Text(l10n.retry),
                  ),
                ],
              )
            else if (_openOrders.isEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: Text(
                  l10n.tableNoOpenOrders,
                  style: text.bodyMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              )
            else
              for (final order in _openOrders)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: scheme.primaryContainer,
                    foregroundColor: scheme.onPrimaryContainer,
                    child: Text(
                      l10n.orderRefLabel(order.ref),
                      style: text.labelSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  title: Text(l10n.orderRefTitle(order.ref)),
                  subtitle: Text(
                    '${orderStatusLabel(l10n, order.status)} · '
                    '${order.items.length} ${l10n.orderItemsLabel} · '
                    '${formatOrderMoney(order.totalAmount, currency)}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if ((isOwner || access.canCreateOrders) && allowAppend)
                        IconButton(
                          tooltip: l10n.orderAppendArticles,
                          onPressed: () => _appendToOrder(order),
                          icon: const Icon(Icons.add_circle_outline),
                        ),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                  onTap: () => _openOrder(order),
                ),
            const SizedBox(height: AppSpacing.md),
            if (isOwner || access.canCreateOrders)
              FilledButton.icon(
                onPressed: canCreate ? _createOrder : null,
                icon: const Icon(Icons.receipt_long_outlined),
                label: Text(l10n.createOrder),
              ),
            if (!canCreate &&
                (isOwner || access.canCreateOrders) &&
                widget.table.isActive &&
                !multiOrder &&
                widget.table.status == TableFloorStatus.occupied)
              Padding(
                padding: const EdgeInsets.only(top: AppSpacing.sm),
                child: Text(
                  l10n.orderTableOccupied,
                  style: text.bodySmall?.copyWith(color: scheme.error),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
