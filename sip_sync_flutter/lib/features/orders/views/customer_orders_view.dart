import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/errors/error_mapper.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../core/widgets/app_loader.dart';
import '../../../core/widgets/page_band.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../venue/menu_price.dart';
import '../../venue/view_models/customer_order_view_model.dart';
import '../../venue/widgets/venue_chrome.dart';
import '../../../core/paging/list_paging.dart';
import '../order_cancellation_label.dart';
import '../order_history_range.dart';
import '../view_models/customer_orders_view_model.dart';

/// History of orders this customer passed, with a way back to the open one.
class OrderHistoryView extends ConsumerWidget {
  const OrderHistoryView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final open = ref.watch(openCustomerOrderProvider).asData?.value;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PageBand(
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: AppSpacing.sm,
                  ),
                  child: Row(
                    children: [
                      const VenueBackButton(),
                      if (open != null)
                        TextButton(
                          onPressed: () =>
                              VenueRoute(id: open.buildingId.uuid).go(context),
                          child: Text(l10n.currentOrder),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            const Expanded(child: CustomerOrdersView()),
          ],
        ),
      ),
    );
  }
}

/// Orders this customer passed. [buildingId] adds a control for this visit only.
class CustomerOrdersView extends ConsumerStatefulWidget {
  const CustomerOrdersView({super.key, this.buildingId});

  /// Venue of the current visit. Null on the standalone history screen.
  final String? buildingId;

  @override
  ConsumerState<CustomerOrdersView> createState() => _CustomerOrdersViewState();
}

class _CustomerOrdersViewState extends ConsumerState<CustomerOrdersView> {
  var _onlyThisVenue = false;

  void _pullThisVenue(CustomerOrderBoard? board) {
    final buildingId = widget.buildingId;
    if (!_onlyThisVenue || buildingId == null || board == null) {
      return;
    }
    if (board.loadingMore || board.moreErrorKey != null || !board.hasMore) {
      return;
    }
    final matches = board.orders.where(
      (order) => order.buildingId.uuid == buildingId,
    );
    if (matches.isEmpty) {
      ref.read(customerOrdersProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final filter = ref.watch(orderHistoryFilterControllerProvider);
    final orders = ref.watch(customerOrdersProvider);
    final buildingId = widget.buildingId;
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: AppBreakpoints.pageMax),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.md,
            AppSpacing.lg,
            AppSpacing.md,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(l10n.orderHistory, style: text.headlineSmall),
              const SizedBox(height: AppSpacing.md),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (final option in OrderHistoryFilter.values) ...[
                      ChoiceChip(
                        label: Text(_filterLabel(l10n, option)),
                        selected: option == filter,
                        onSelected: (_) => ref
                            .read(orderHistoryFilterControllerProvider.notifier)
                            .select(option),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                    ],
                    if (buildingId != null)
                      FilterChip(
                        label: Text(l10n.ordersThisVenue),
                        selected: _onlyThisVenue,
                        onSelected: (selected) {
                          setState(() => _onlyThisVenue = selected);
                          _pullThisVenue(orders.asData?.value);
                        },
                      ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Expanded(
                child: orders.when(
                  loading: () => const AppScreenLoader(),
                  error: (error, _) => Column(
                    children: [
                      AppErrorBanner(
                        message: lookupError(l10n, mapError(error).l10nKey),
                      ),
                      AppTonalButton(
                        label: l10n.retry,
                        onPressed: () => ref.invalidate(customerOrdersProvider),
                      ),
                    ],
                  ),
                  data: (board) {
                    final rows = _onlyThisVenue && buildingId != null
                        ? [
                            for (final row in board.orders)
                              if (row.buildingId.uuid == buildingId) row,
                          ]
                        : board.orders;
                    if (_onlyThisVenue) {
                      WidgetsBinding.instance.addPostFrameCallback(
                        (_) => _pullThisVenue(board),
                      );
                    }
                    if (rows.isEmpty) {
                      if (_onlyThisVenue &&
                          board.hasMore &&
                          board.moreErrorKey == null) {
                        return const AppScreenLoader();
                      }
                      return Text(
                        _onlyThisVenue
                            ? l10n.emptyVenueOrders
                            : l10n.emptyOrders,
                        style: text.bodyLarge?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      );
                    }
                    return NotificationListener<ScrollNotification>(
                      onNotification: (notification) {
                        if (nearListEnd(notification)) {
                          ref.read(customerOrdersProvider.notifier).loadMore();
                        }
                        return false;
                      },
                      child: ListView.separated(
                        itemCount: rows.length + 1,
                        separatorBuilder: (_, _) =>
                            const SizedBox(height: AppSpacing.md),
                        itemBuilder: (context, index) {
                          if (index >= rows.length) {
                            if (board.moreErrorKey != null) {
                              return AppTonalButton(
                                label: l10n.retry,
                                onPressed: () => ref
                                    .read(customerOrdersProvider.notifier)
                                    .loadMore(),
                              );
                            }
                            if (!board.loadingMore) {
                              return const SizedBox(height: AppSpacing.md);
                            }
                            return const AppScreenLoader(compact: true);
                          }
                          return _OrderCard(row: rows[index]);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Orders for the venue the customer is visiting, with a this-venue filter.
class VenueOrdersPane extends StatelessWidget {
  const VenueOrdersPane({super.key, required this.buildingId});

  final String buildingId;

  @override
  Widget build(BuildContext context) {
    return CustomerOrdersView(buildingId: buildingId);
  }
}

class _OrderCard extends StatelessWidget {
  const _OrderCard({required this.row});

  final CustomerOrderSummary row;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final locale = Localizations.localeOf(context).toString();
    final when = DateFormat.yMMMd(
      locale,
    ).add_Hm().format(row.createdAt.toLocal());
    return Material(
      color: scheme.surfaceContainerLowest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.lg),
        side: BorderSide(color: scheme.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => CustomerOrderRoute(
          id: row.buildingId.uuid,
          orderId: row.id.uuid,
        ).push(context),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      row.venueName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: text.titleMedium,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    formatMenuPrice(row.totalAmount, row.currencyCode),
                    style: text.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                '${l10n.orderRef(row.ref)} · ${l10n.tableNumber(row.tableNumber)}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: text.bodyMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                '${l10n.orderItemCount(row.itemCount)} · $when',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: text.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
              ),
              const SizedBox(height: AppSpacing.sm),
              _StatusChip(status: row.status),
              if (row.cancellationReason != null) ...[
                const SizedBox(height: AppSpacing.xs),
                Text(
                  orderCancellationReasonLabel(l10n, row.cancellationReason!),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: text.bodySmall?.copyWith(color: AppColors.rose),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final (label, color) = switch (status) {
      OrderStatus.progress => (l10n.orderStatusProgress, AppColors.moss),
      OrderStatus.payed => (l10n.orderStatusPayed, AppColors.apricot),
      OrderStatus.cancelled => (l10n.orderStatusCancelled, AppColors.rose),
    };
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        child: Text(
          label,
          style: text.labelLarge?.copyWith(
            color: color,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

String _filterLabel(AppLocalizations l10n, OrderHistoryFilter filter) {
  return switch (filter) {
    OrderHistoryFilter.today => l10n.filterToday,
    OrderHistoryFilter.week => l10n.filterLastWeek,
    OrderHistoryFilter.month => l10n.filterLastMonth,
  };
}
