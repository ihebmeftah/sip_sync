import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../view_models/article_composition_view_model.dart';
import '../view_models/ingredients_view_model.dart';
import 'unit_labels.dart';

/// Owner/employee sheet to view optional recipe lines; owner can mutate.
Future<void> showArticleCompositionDialog(
  BuildContext context, {
  required String buildingId,
  required MenuArticleView article,
}) {
  return showDialog<void>(
    context: context,
    builder: (context) =>
        _CompositionDialog(buildingId: buildingId, article: article),
  );
}

class _CompositionDialog extends ConsumerStatefulWidget {
  const _CompositionDialog({required this.buildingId, required this.article});

  final String buildingId;
  final MenuArticleView article;

  @override
  ConsumerState<_CompositionDialog> createState() => _CompositionDialogState();
}

class _CompositionDialogState extends ConsumerState<_CompositionDialog> {
  final _qty = TextEditingController(text: '1');
  UuidValue? _ingredientId;
  var _adding = false;
  String? _errorKey;

  @override
  void dispose() {
    _qty.dispose();
    super.dispose();
  }

  double? _parseQty(String raw) =>
      double.tryParse(raw.trim().replaceAll(',', '.'));

  String _formatQty(double value) {
    if (value == value.roundToDouble()) {
      return '${value.round()}';
    }
    return value.toStringAsFixed(2);
  }

  Future<void> _add() async {
    final ingredientId = _ingredientId;
    final quantity = _parseQty(_qty.text);
    if (ingredientId == null || quantity == null || quantity <= 0) {
      setState(() => _errorKey = 'errorInvalidInput');
      return;
    }
    setState(() {
      _adding = true;
      _errorKey = null;
    });
    try {
      await ref
          .read(
            articleCompositionViewModelProvider(
              buildingId: widget.buildingId,
              articleId: widget.article.id.uuid,
            ).notifier,
          )
          .addLine(ingredientId: ingredientId, quantity: quantity);
      if (!mounted) {
        return;
      }
      setState(() {
        _adding = false;
        _ingredientId = null;
        _qty.text = '1';
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _adding = false;
        _errorKey = mapError(error).l10nKey;
      });
    }
  }

  Future<void> _editQuantity(ArticleCompositionView line) async {
    final l10n = AppLocalizations.of(context)!;
    final controller = TextEditingController(text: _formatQty(line.quantity));
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.editCompositionQuantity),
        content: AppTextField(
          controller: controller,
          label: l10n.compositionQuantity,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.save),
          ),
        ],
      ),
    );
    if (ok != true || !mounted) {
      controller.dispose();
      return;
    }
    final quantity = _parseQty(controller.text);
    controller.dispose();
    if (quantity == null || quantity <= 0) {
      return;
    }
    try {
      await ref
          .read(
            articleCompositionViewModelProvider(
              buildingId: widget.buildingId,
              articleId: widget.article.id.uuid,
            ).notifier,
          )
          .updateQuantity(id: line.id, quantity: quantity);
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() => _errorKey = mapError(error).l10nKey);
    }
  }

  Future<void> _delete(ArticleCompositionView line) async {
    final l10n = AppLocalizations.of(context)!;
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.removeCompositionLine),
        content: Text(l10n.removeCompositionLineConfirm(line.ingredientName)),
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
    if (ok != true || !mounted) {
      return;
    }
    try {
      await ref
          .read(
            articleCompositionViewModelProvider(
              buildingId: widget.buildingId,
              articleId: widget.article.id.uuid,
            ).notifier,
          )
          .removeLine(line.id);
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() => _errorKey = mapError(error).l10nKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final isOwner = ref.watch(appSessionStoreProvider).isOwner;
    final async = ref.watch(
      articleCompositionViewModelProvider(
        buildingId: widget.buildingId,
        articleId: widget.article.id.uuid,
      ),
    );
    final ingredients =
        ref
            .watch(ingredientsViewModelProvider(widget.buildingId))
            .asData
            ?.value ??
        const <IngredientView>[];
    final usedIds = {
      for (final line
          in async.asData?.value ?? const <ArticleCompositionView>[])
        line.ingredientId,
    };
    final available = ingredients
        .where((i) => !usedIds.contains(i.id))
        .toList();

    return AlertDialog(
      title: Text(l10n.articleCompositionTitle(widget.article.name)),
      content: SizedBox(
        width: 420,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(l10n.articleCompositionHint, style: text.bodyMedium),
            const SizedBox(height: AppSpacing.lg),
            async.when(
              loading: () => const LinearProgressIndicator(),
              error: (error, _) => AppErrorBanner(
                message: lookupError(l10n, mapError(error).l10nKey),
              ),
              data: (lines) {
                if (lines.isEmpty) {
                  return AppSurfaceCard(child: Text(l10n.compositionEmpty));
                }
                return ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 240),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (final line in lines)
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(line.ingredientName),
                          subtitle: Text(
                            '${_formatQty(line.quantity)} ${unitTypeAbbrev(l10n, line.unit)}',
                          ),
                          trailing: isOwner
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      tooltip: l10n.editCompositionQuantity,
                                      onPressed: () => _editQuantity(line),
                                      icon: const Icon(Icons.edit_outlined),
                                    ),
                                    IconButton(
                                      tooltip: l10n.removeCompositionLine,
                                      onPressed: () => _delete(line),
                                      icon: Icon(
                                        Icons.delete_outline,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.error,
                                      ),
                                    ),
                                  ],
                                )
                              : null,
                        ),
                    ],
                  ),
                );
              },
            ),
            if (isOwner) ...[
              const SizedBox(height: AppSpacing.lg),
              if (ingredients.isEmpty)
                AppErrorBanner(message: l10n.compositionNeedIngredients)
              else if (available.isEmpty)
                Text(l10n.compositionAllIngredientsUsed, style: text.bodySmall)
              else ...[
                AppDropdownField<UuidValue>(
                  label: l10n.compositionIngredient,
                  value:
                      _ingredientId != null &&
                          available.any((i) => i.id == _ingredientId)
                      ? _ingredientId!
                      : available.first.id,
                  items: [
                    for (final ingredient in available)
                      DropdownMenuItem(
                        value: ingredient.id,
                        child: Text(
                          '${ingredient.name} (${unitTypeAbbrev(l10n, ingredient.unit)})',
                        ),
                      ),
                  ],
                  onChanged: (value) => setState(() => _ingredientId = value),
                ),
                AppTextField(
                  controller: _qty,
                  label: l10n.compositionQuantity,
                  prefixIcon: Icons.scale_outlined,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: FilledButton.icon(
                    onPressed: _adding
                        ? null
                        : () {
                            _ingredientId ??= available.first.id;
                            _add();
                          },
                    icon: _adding
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.add),
                    label: Text(l10n.addCompositionLine),
                  ),
                ),
              ],
            ],
            if (_errorKey != null)
              AppErrorBanner(message: lookupError(l10n, _errorKey!)),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.close),
        ),
      ],
    );
  }
}
