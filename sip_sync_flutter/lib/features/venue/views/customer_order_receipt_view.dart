import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/errors/error_mapper.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../core/widgets/app_loader.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../orders/order_cancellation_label.dart';
import '../menu_price.dart';
import '../view_models/customer_order_view_model.dart';

/// The order the venue received: ticket, table, and prices.
class CustomerOrderReceiptView extends ConsumerWidget {
  const CustomerOrderReceiptView({
    super.key,
    required this.buildingId,
    required this.orderId,
  });

  final String buildingId;
  final String orderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final order = ref.watch(customerOrderDetailProvider(orderId));
    return Scaffold(
      body: SafeArea(
        child: order.when(
          loading: () => const AppScreenLoader(),
          error: (error, _) => Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              children: [
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: IconButton(
                    tooltip: l10n.back,
                    onPressed: () => VenueRoute(id: buildingId).go(context),
                    icon: Transform.flip(
                      flipX: Directionality.of(context) == TextDirection.rtl,
                      child: const Icon(AppIcons.back),
                    ),
                  ),
                ),
                const Spacer(),
                AppErrorBanner(
                  message: lookupError(l10n, mapError(error).l10nKey),
                ),
                AppTonalButton(
                  label: l10n.retry,
                  onPressed: () =>
                      ref.invalidate(customerOrderDetailProvider(orderId)),
                ),
                const Spacer(),
              ],
            ),
          ),
          data: (page) {
            final text = Theme.of(context).textTheme;
            final scheme = Theme.of(context).colorScheme;
            return Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    AppSpacing.sm,
                    AppSpacing.lg,
                    AppSpacing.xl,
                  ),
                  children: [
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: IconButton(
                        tooltip: l10n.back,
                        onPressed: () => VenueRoute(id: buildingId).go(context),
                        icon: Transform.flip(
                          flipX:
                              Directionality.of(context) == TextDirection.rtl,
                          child: const Icon(AppIcons.back),
                        ),
                      ),
                    ),
                    Text(
                      l10n.orderSent,
                      style: text.labelLarge?.copyWith(
                        color: AppColors.moss,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(l10n.orderRef(page.ref), style: text.displaySmall),
                    if (page.cancellationReason != null) ...[
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        orderCancellationReasonLabel(
                          l10n,
                          page.cancellationReason!,
                        ),
                        style: text.bodyLarge?.copyWith(color: AppColors.rose),
                      ),
                    ],
                    const SizedBox(height: AppSpacing.lg),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.mist,
                        borderRadius: BorderRadius.circular(AppRadii.lg),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        child: Row(
                          children: [
                            const Icon(AppIcons.table, color: AppColors.moss),
                            const SizedBox(width: AppSpacing.md),
                            Text(
                              l10n.tableNumber(page.tableNumber),
                              style: text.titleMedium?.copyWith(
                                color: AppColors.moss,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    for (final line in page.lines) ...[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  line.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: text.titleMedium,
                                ),
                                const SizedBox(height: AppSpacing.xs),
                                _ItemStatus(status: line.status),
                                if (line.cancellationReason != null) ...[
                                  const SizedBox(height: AppSpacing.xs),
                                  Text(
                                    orderCancellationReasonLabel(
                                      l10n,
                                      line.cancellationReason!,
                                    ),
                                    style: text.bodySmall?.copyWith(
                                      color: AppColors.rose,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Text(
                            formatMenuPrice(line.unitPrice, page.currencyCode),
                            style: text.titleMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.md),
                    ],
                    const Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: Text(l10n.total, style: text.titleLarge),
                        ),
                        Text(
                          formatMenuPrice(page.totalAmount, page.currencyCode),
                          style: text.titleLarge?.copyWith(
                            color: scheme.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ItemStatus extends StatelessWidget {
  const _ItemStatus({required this.status});

  final OrderItemStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final (label, color) = switch (status) {
      OrderItemStatus.progress => (l10n.orderStatusProgress, AppColors.moss),
      OrderItemStatus.picked => (l10n.itemStatusPicked, AppColors.apricotDeep),
      OrderItemStatus.ready => (l10n.itemStatusReady, AppColors.apricot),
      OrderItemStatus.served => (l10n.itemStatusServed, AppColors.moss),
      OrderItemStatus.payed => (l10n.orderStatusPayed, AppColors.apricot),
      OrderItemStatus.cancelled => (
        l10n.orderStatusCancelled,
        AppColors.rose,
      ),
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
