import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/errors/app_notice.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../menu_price.dart';
import '../view_models/customer_order_view_model.dart';
import '../view_models/order_cart_view_model.dart';
import '../view_models/seated_table_view_model.dart';
import '../widgets/venue_chrome.dart';

/// Selected dishes, the scanned table, and the action that sends the order.
class OrderReviewView extends ConsumerWidget {
  const OrderReviewView({
    super.key,
    required this.buildingId,
    this.venueName,
    this.currencyCode = '',
  });

  final String buildingId;
  final String? venueName;
  final String currencyCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final cart = ref.watch(orderCartProvider(buildingId));
    final passing = ref.watch(orderPassProvider(buildingId)).isLoading;
    final notice = ref.watch(seatedTableProvider);
    final seated = notice != null && notice.table.buildingId.uuid == buildingId
        ? notice.table
        : null;
    final openAsync = ref.watch(openCustomerOrderProvider);
    final open = openAsync.asData?.value;
    final appending =
        open != null &&
        open.buildingId.uuid == buildingId &&
        open.status == OrderStatus.progress;
    final title = (venueName == null || venueName!.trim().isEmpty)
        ? l10n.yourOrder
        : venueName!.trim();

    void scan() {
      TableScanRoute(changing: true, buildingId: buildingId).push(context);
    }

    Future<void> passOrder() async {
      if (cart.isEmpty || passing || openAsync.isLoading) {
        return;
      }
      if (!appending && seated == null) {
        return;
      }
      try {
        final notifier = ref.read(orderPassProvider(buildingId).notifier);
        final order = appending
            ? await notifier.append(open.id)
            : await notifier.submit(seated!.tableId);
        if (!context.mounted) {
          return;
        }
        CustomerOrderRoute(
          id: buildingId,
          orderId: order.id.uuid,
        ).go(context);
      } catch (error) {
        if (!context.mounted) {
          return;
        }
        showMappedError(context, error);
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.lg,
                      AppSpacing.sm,
                      AppSpacing.lg,
                      AppSpacing.lg,
                    ),
                    children: [
                      const Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: VenueBackButton(),
                      ),
                      Text(
                        l10n.yourOrder,
                        style: text.labelLarge?.copyWith(
                          color: scheme.primary,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: text.displaySmall,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      if (appending)
                        _TableBand(number: open.tableNumber)
                      else if (seated == null)
                        _ScanPrompt(onScan: scan)
                      else
                        _TableBand(number: seated.number),
                      const SizedBox(height: AppSpacing.lg),
                      if (cart.isEmpty)
                        Text(
                          l10n.orderEmpty,
                          style: text.bodyLarge?.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                        )
                      else
                        for (final line in cart)
                          for (var unit = 0; unit < line.quantity; unit++) ...[
                            _ReviewLine(
                              name: line.name,
                              price: formatMenuPrice(
                                line.unitPrice,
                                currencyCode,
                              ),
                              onRemove: () => ref
                                  .read(orderCartProvider(buildingId).notifier)
                                  .remove(line.articleId),
                            ),
                            const SizedBox(height: AppSpacing.sm),
                          ],
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    AppSpacing.sm,
                    AppSpacing.lg,
                    AppSpacing.lg,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (cart.isNotEmpty) ...[
                        Row(
                          children: [
                            Expanded(
                              child: Text(l10n.total, style: text.titleMedium),
                            ),
                            Text(
                              formatMenuPrice(cartTotal(cart), currencyCode),
                              style: text.titleLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.md),
                      ],
                      if (!appending && seated == null)
                        AppFilledButton(
                          label: l10n.scanTable,
                          icon: AppIcons.qrScan,
                          onPressed: cart.isEmpty || openAsync.isLoading
                              ? null
                              : scan,
                        )
                      else
                        AppFilledButton(
                          label: appending ? l10n.addToOrder : l10n.passOrder,
                          icon: AppIcons.check,
                          busy: passing || openAsync.isLoading,
                          onPressed: cart.isEmpty ? null : () => passOrder(),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ScanPrompt extends StatelessWidget {
  const _ScanPrompt({required this.onScan});

  final VoidCallback onScan;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.sand,
        borderRadius: BorderRadius.circular(AppRadii.lg),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.scanTableToOrder, style: text.titleMedium),
            const SizedBox(height: AppSpacing.md),
            AppTonalButton(
              label: l10n.scanTable,
              icon: AppIcons.qrScan,
              onPressed: onScan,
            ),
          ],
        ),
      ),
    );
  }
}

class _TableBand extends StatelessWidget {
  const _TableBand({required this.number});

  final int number;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.mist,
        borderRadius: BorderRadius.circular(AppRadii.lg),
        border: Border.all(color: AppColors.moss.withValues(alpha: 0.28)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Row(
          children: [
            const Icon(AppIcons.table, color: AppColors.moss),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.yourTable,
                    style: text.labelLarge?.copyWith(
                      color: AppColors.moss,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    l10n.seatedAt(number),
                    style: text.titleMedium?.copyWith(color: AppColors.moss),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReviewLine extends StatelessWidget {
  const _ReviewLine({
    required this.name,
    required this.price,
    required this.onRemove,
  });

  final String name;
  final String price;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    return Row(
      children: [
        IconButton(
          tooltip: l10n.removeArticle,
          onPressed: onRemove,
          icon: const Icon(AppIcons.remove),
        ),
        Expanded(
          child: Text(
            name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: text.titleMedium,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(price, style: text.titleMedium),
      ],
    );
  }
}
