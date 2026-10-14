import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../core/paging/list_paging.dart';
import '../../../core/widgets/app_loader.dart';
import '../../../core/widgets/refresh_on_appear.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../order_list_day.dart';
import '../view_models/orders_view_model.dart';
import '../widgets/order_item_info_sheet.dart';
import '../widgets/order_status_labels.dart';
import '../widgets/order_view_switch.dart';

/// Order board for the building (new order FAB lives on [OpsShell]).
class OrdersListView extends ConsumerStatefulWidget {
  const OrdersListView({super.key, required this.buildingId});

  final String buildingId;

  @override
  ConsumerState<OrdersListView> createState() => _OrdersListViewState();
}

class _OrdersListViewState extends ConsumerState<OrdersListView> {
  @override
  void initState() {
    super.initState();
    refreshCachedListOnAppear(
      this,
      providerAlreadyAlive: ref.exists(
        ordersViewModelProvider(widget.buildingId),
      ),
      refresh: () => ref
          .read(ordersViewModelProvider(widget.buildingId).notifier)
          .onScreenAppeared(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final currency = ref.watch(buildingSelectionProvider)?.currencyCode ?? '';
    final ordersVm = ref.watch(ordersViewModelProvider(widget.buildingId));
    final notifier = ref.watch(
      ordersViewModelProvider(widget.buildingId).notifier,
    );
    final statusFilter = notifier.statusFilter;
    final dayFilter = notifier.dayFilter;

    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppBreakpoints.pageMax),
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (nearListEnd(notification)) {
                ref
                    .read(ordersViewModelProvider(widget.buildingId).notifier)
                    .loadMore();
              }
              return false;
            },
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.xl,
                AppSpacing.xl,
                AppSpacing.xl,
                96,
              ),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(l10n.navOrders, style: text.headlineSmall),
                    ),
                    const OrderViewSwitch(),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(l10n.ordersHint, style: text.bodyMedium),
                const SizedBox(height: AppSpacing.lg),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                          end: AppSpacing.sm,
                        ),
                        child: AppFilterChip(
                          selected: statusFilter == null,
                          label: l10n.ordersFilterAll,
                          onSelected: (_) => ref
                              .read(
                                ordersViewModelProvider(
                                  widget.buildingId,
                                ).notifier,
                              )
                              .setStatusFilter(null),
                        ),
                      ),
                      for (final status in OrderStatus.values)
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                            end: AppSpacing.sm,
                          ),
                          child: AppFilterChip(
                            selected: statusFilter == status,
                            label: orderStatusLabel(l10n, status),
                            onSelected: (_) => ref
                                .read(
                                  ordersViewModelProvider(
                                    widget.buildingId,
                                  ).notifier,
                                )
                                .setStatusFilter(status),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (final preset in const [
                        OrderListDaySelection.today(),
                        OrderListDaySelection.last3Days(),
                        OrderListDaySelection.lastWeek(),
                      ])
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                            end: AppSpacing.sm,
                          ),
                          child: AppFilterChip(
                            selected: dayFilter == preset,
                            label: _dayPresetLabel(l10n, preset.preset),
                            onSelected: (_) => notifier.setDayFilter(preset),
                          ),
                        ),
                      AppFilterChip(
                        selected: dayFilter.preset == OrderListDayPreset.day,
                        label: _pickedDayLabel(context, l10n, dayFilter),
                        onSelected: (_) => _pickDay(context, notifier),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                ordersVm.when(
                  loading: () => const AppScreenLoader(),
                  error: (error, _) => Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppErrorBanner(
                        message: lookupError(l10n, mapError(error).l10nKey),
                      ),
                      TextButton(
                        onPressed: () => ref
                            .read(
                              ordersViewModelProvider(
                                widget.buildingId,
                              ).notifier,
                            )
                            .refresh(),
                        child: Text(l10n.retry),
                      ),
                    ],
                  ),
                  data: (board) {
                    final orders = board.orders;
                    if (orders.isEmpty) {
                      return AppSurfaceCard(
                        child: Text(
                          _emptyLabel(l10n, statusFilter: statusFilter),
                        ),
                      );
                    }
                    return Column(
                      children: [
                        for (final order in orders) ...[
                          AppSurfaceCard(
                            child: InkWell(
                              onTap: () => OrderDetailRoute(
                                buildingId: widget.buildingId,
                                orderId: order.id.uuid,
                              ).go(context),
                              borderRadius: BorderRadius.circular(AppRadii.lg),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: AppSpacing.xs,
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Theme.of(
                                        context,
                                      ).colorScheme.primaryContainer,
                                      foregroundColor: Theme.of(
                                        context,
                                      ).colorScheme.onPrimaryContainer,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 4,
                                          ),
                                          child: Text(
                                            l10n.orderRefLabel(order.ref),
                                            style: text.labelLarge?.copyWith(
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: AppSpacing.md),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            order.tableNumber == null
                                                ? l10n.orderNoTable
                                                : l10n.orderTableNumber(
                                                    order.tableNumber!,
                                                  ),
                                            style: text.titleSmall,
                                          ),
                                          const SizedBox(height: 6),
                                          Row(
                                            children: [
                                              OrderStatusChip(
                                                status: order.status,
                                              ),
                                              const SizedBox(
                                                width: AppSpacing.sm,
                                              ),
                                              Text(
                                                '${order.items.length} ${l10n.orderItemsLabel}',
                                                style: text.bodySmall,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      formatOrderMoney(
                                        order.totalAmount,
                                        currency,
                                      ),
                                      style: text.titleSmall?.copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const Icon(Icons.chevron_right),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                        ],
                        if (board.loadingMore)
                          const AppScreenLoader(compact: true),
                        if (board.moreErrorKey != null)
                          TextButton(
                            onPressed: () => ref
                                .read(
                                  ordersViewModelProvider(
                                    widget.buildingId,
                                  ).notifier,
                                )
                                .loadMore(),
                            child: Text(l10n.retry),
                          ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickDay(BuildContext context, OrdersViewModel notifier) async {
    final now = DateTime.now();
    final today = orderListDateOnly(now);
    final initial = notifier.dayFilter.day ?? today;
    final picked = await showDatePicker(
      context: context,
      initialDate: initial.isAfter(today) ? today : initial,
      firstDate: DateTime(today.year - 2),
      lastDate: today,
    );
    if (!mounted || picked == null) return;
    final day = orderListDateOnly(picked);
    final selection = day == today
        ? const OrderListDaySelection.today()
        : OrderListDaySelection.day(day);
    await notifier.setDayFilter(selection);
  }
}

String _emptyLabel(
  AppLocalizations l10n, {
  required OrderStatus? statusFilter,
}) {
  if (statusFilter != null) return l10n.ordersFilterEmpty;
  return l10n.ordersDayFilterEmpty;
}

String _dayPresetLabel(AppLocalizations l10n, OrderListDayPreset preset) {
  return switch (preset) {
    OrderListDayPreset.today => l10n.ordersFilterToday,
    OrderListDayPreset.last3Days => l10n.ordersFilterLast3Days,
    OrderListDayPreset.lastWeek => l10n.ordersFilterLastWeek,
    OrderListDayPreset.day => l10n.ordersFilterPickDay,
  };
}

String _pickedDayLabel(
  BuildContext context,
  AppLocalizations l10n,
  OrderListDaySelection selection,
) {
  final day = selection.day;
  if (selection.preset != OrderListDayPreset.day || day == null) {
    return l10n.ordersFilterPickDay;
  }
  return DateFormat.yMMMd(
    Localizations.localeOf(context).toString(),
  ).format(day);
}
