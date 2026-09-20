import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../view_models/ingredients_view_model.dart';
import '../widgets/ingredient_dialog.dart';
import '../widgets/ingredient_restock_dialog.dart';
import '../widgets/unit_labels.dart';

/// Per-building ingredient list with stock bar, restock, and low-stock alerts.
class IngredientsListView extends ConsumerWidget {
  const IngredientsListView({super.key, required this.buildingId});

  final String buildingId;

  String _formatQty(double value) {
    if (value == value.roundToDouble()) {
      return '${value.round()}';
    }
    return value.toStringAsFixed(2);
  }

  /// Bar fill from server [IngredientView.stockProgress] (current / initial).
  double _stockProgress(IngredientView ingredient) => ingredient.stockProgress;

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    IngredientView ingredient,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteIngredient),
        content: Text(l10n.deleteIngredientConfirm(ingredient.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
    if (ok != true || !context.mounted) {
      return;
    }
    try {
      await ref
          .read(ingredientsViewModelProvider(buildingId).notifier)
          .deleteIngredient(ingredient.id);
    } catch (error) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(lookupError(l10n, mapError(error).l10nKey))),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final isOwner = ref.watch(appSessionStoreProvider).isOwner;
    final async = ref.watch(ingredientsViewModelProvider(buildingId));

    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppBreakpoints.pageMax),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.xl,
              AppSpacing.xl,
              AppSpacing.xl,
              96,
            ),
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l10n.navIngredients, style: text.headlineSmall),
                        const SizedBox(height: AppSpacing.xs),
                        Text(l10n.ingredientsHint, style: text.bodyMedium),
                      ],
                    ),
                  ),
                  if (isOwner)
                    FilledButton.icon(
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(0, 44),
                      ),
                      onPressed: () =>
                          showIngredientDialog(context, buildingId: buildingId),
                      icon: const Icon(Icons.add),
                      label: Text(l10n.addIngredient),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              async.when(
                loading: () => const LinearProgressIndicator(),
                error: (error, _) => Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppErrorBanner(
                      message: lookupError(l10n, mapError(error).l10nKey),
                    ),
                    TextButton(
                      onPressed: () => ref
                          .read(
                            ingredientsViewModelProvider(buildingId).notifier,
                          )
                          .refresh(),
                      child: Text(l10n.retry),
                    ),
                  ],
                ),
                data: (ingredients) {
                  if (ingredients.isEmpty) {
                    return AppSurfaceCard(
                      child: Text(
                        isOwner
                            ? l10n.ingredientsEmptyOwner
                            : l10n.ingredientsEmpty,
                      ),
                    );
                  }
                  final lowCount = ingredients
                      .where((i) => i.belowThreshold)
                      .length;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (lowCount > 0) ...[
                        AppSurfaceCard(
                          child: Row(
                            children: [
                              Icon(
                                Icons.warning_amber_rounded,
                                color: scheme.error,
                              ),
                              const SizedBox(width: AppSpacing.md),
                              Expanded(
                                child: Text(
                                  l10n.ingredientLowStockBanner(lowCount),
                                  style: text.bodyMedium?.copyWith(
                                    color: scheme.error,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                      ],
                      for (final ingredient in ingredients) ...[
                        AppSurfaceCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: ingredient.belowThreshold
                                        ? scheme.errorContainer
                                        : scheme.secondaryContainer,
                                    foregroundColor: ingredient.belowThreshold
                                        ? scheme.onErrorContainer
                                        : scheme.onSecondaryContainer,
                                    child: Icon(
                                      ingredient.belowThreshold
                                          ? Icons.warning_amber_outlined
                                          : Icons.science_outlined,
                                    ),
                                  ),
                                  const SizedBox(width: AppSpacing.md),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                ingredient.name,
                                                style: text.titleSmall,
                                              ),
                                            ),
                                            if (ingredient.belowThreshold)
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 2,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: scheme.errorContainer,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        999,
                                                      ),
                                                ),
                                                child: Text(
                                                  l10n.ingredientLowStockBadge,
                                                  style: text.labelSmall
                                                      ?.copyWith(
                                                        color: scheme
                                                            .onErrorContainer,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                ),
                                              ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          l10n.ingredientStockLine(
                                            _formatQty(ingredient.currentStock),
                                            unitTypeAbbrev(
                                              l10n,
                                              ingredient.unit,
                                            ),
                                            _formatQty(
                                              ingredient.thresholdStock,
                                            ),
                                          ),
                                          style: text.bodySmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: AppSpacing.md),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(999),
                                child: LinearProgressIndicator(
                                  value: _stockProgress(ingredient),
                                  minHeight: 8,
                                  backgroundColor:
                                      scheme.surfaceContainerHighest,
                                  color: ingredient.belowThreshold
                                      ? scheme.error
                                      : scheme.primary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                l10n.ingredientStockPercent(
                                  (_stockProgress(ingredient) * 100).round(),
                                ),
                                style: text.labelSmall?.copyWith(
                                  color: scheme.onSurfaceVariant,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              Row(
                                children: [
                                  FilledButton.tonalIcon(
                                    style: FilledButton.styleFrom(
                                      visualDensity: VisualDensity.compact,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      minimumSize: const Size(0, 32),
                                    ),
                                    onPressed: () =>
                                        showIngredientRestockDialog(
                                          context,
                                          buildingId: buildingId,
                                          ingredient: ingredient,
                                        ),
                                    icon: const Icon(Icons.add, size: 16),
                                    label: Text(l10n.ingredientRestock),
                                  ),
                                  const Spacer(),
                                  if (isOwner)
                                    IconButton(
                                      tooltip: l10n.deleteIngredient,
                                      visualDensity: VisualDensity.compact,
                                      onPressed: () => _confirmDelete(
                                        context,
                                        ref,
                                        ingredient,
                                      ),
                                      icon: Icon(
                                        Icons.delete_outline,
                                        color: scheme.error,
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                      ],
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
