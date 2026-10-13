import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_tokens.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../view_models/order_screen_mode.dart';

/// Segmented control for the item board and the ticket list.
class OrderViewSwitch extends ConsumerWidget {
  const OrderViewSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final mode = ref.watch(orderScreenModeControllerProvider);
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(AppRadii.lg),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xs),
        child: SegmentedButton<OrderScreenMode>(
          style: SegmentedButton.styleFrom(
            visualDensity: VisualDensity.compact,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            side: BorderSide.none,
            backgroundColor: Colors.transparent,
            selectedBackgroundColor: scheme.primary,
            selectedForegroundColor: scheme.onPrimary,
            foregroundColor: scheme.onSurfaceVariant,
          ),
          showSelectedIcon: false,
          segments: [
            ButtonSegment(
              value: OrderScreenMode.items,
              icon: const Icon(Icons.view_week_outlined, size: 18),
              tooltip: l10n.orderViewItems,
            ),
            ButtonSegment(
              value: OrderScreenMode.list,
              icon: const Icon(Icons.view_list_outlined, size: 18),
              tooltip: l10n.orderViewList,
            ),
          ],
          selected: {mode},
          onSelectionChanged: (next) {
            ref
                .read(orderScreenModeControllerProvider.notifier)
                .show(next.first);
          },
        ),
      ),
    );
  }
}
