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
import '../widgets/unit_labels.dart';

/// Per-building ingredient list with owner create / delete.
class IngredientsListView extends ConsumerWidget {
  const IngredientsListView({super.key, required this.buildingId});

  final String buildingId;

  String _formatQty(double value) {
    if (value == value.roundToDouble()) {
      return '${value.round()}';
    }
    return value.toStringAsFixed(2);
  }

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
            padding: const EdgeInsets.all(AppSpacing.xl),
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
                  return AppSurfaceCard(
                    child: Column(
                      children: [
                        for (final ingredient in ingredients)
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(
                              backgroundColor:
                                  ingredient.currentStock <=
                                      ingredient.thresholdStock
                                  ? scheme.errorContainer
                                  : scheme.secondaryContainer,
                              foregroundColor:
                                  ingredient.currentStock <=
                                      ingredient.thresholdStock
                                  ? scheme.onErrorContainer
                                  : scheme.onSecondaryContainer,
                              child: Icon(
                                ingredient.currentStock <=
                                        ingredient.thresholdStock
                                    ? Icons.warning_amber_outlined
                                    : Icons.science_outlined,
                              ),
                            ),
                            title: Text(ingredient.name),
                            subtitle: Text(
                              l10n.ingredientStockLine(
                                _formatQty(ingredient.currentStock),
                                unitTypeAbbrev(l10n, ingredient.unit),
                                _formatQty(ingredient.thresholdStock),
                              ),
                            ),
                            trailing: isOwner
                                ? IconButton(
                                    tooltip: l10n.deleteIngredient,
                                    onPressed: () => _confirmDelete(
                                      context,
                                      ref,
                                      ingredient,
                                    ),
                                    icon: Icon(
                                      Icons.delete_outline,
                                      color: scheme.error,
                                    ),
                                  )
                                : null,
                          ),
                      ],
                    ),
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
