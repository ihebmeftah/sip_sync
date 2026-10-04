import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/errors/app_notice.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../view_models/article_composition_view_model.dart';
import '../view_models/articles_view_model.dart';
import '../view_models/ingredients_view_model.dart';
import '../widgets/unit_labels.dart';

/// Full-screen article composition (mobile); wide layouts still use the dialog.
///
/// Named `…FormView` so it does not collide with the client DTO
/// [ArticleCompositionView].
class ArticleCompositionFormView extends ConsumerStatefulWidget {
  const ArticleCompositionFormView({
    super.key,
    required this.buildingId,
    required this.articleId,
  });

  final String buildingId;
  final String articleId;

  @override
  ConsumerState<ArticleCompositionFormView> createState() =>
      _ArticleCompositionFormViewState();
}

class _ArticleCompositionFormViewState
    extends ConsumerState<ArticleCompositionFormView> {
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

  MenuArticleView? _articleOf(List<MenuArticleView> articles) {
    for (final article in articles) {
      if (article.id.uuid == widget.articleId) {
        return article;
      }
    }
    return null;
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
              articleId: widget.articleId,
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
        _errorKey = captureError(context, error);
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
              articleId: widget.articleId,
            ).notifier,
          )
          .updateQuantity(id: line.id, quantity: quantity);
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() => _errorKey = captureError(context, error));
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
              articleId: widget.articleId,
            ).notifier,
          )
          .removeLine(line.id);
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() => _errorKey = captureError(context, error));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final isOwner = ref.watch(appSessionStoreProvider).isOwner;
    final articles =
        ref.watch(articlesViewModelProvider(widget.buildingId)).asData?.value ??
        const <MenuArticleView>[];
    final article = _articleOf(articles);
    final async = ref.watch(
      articleCompositionViewModelProvider(
        buildingId: widget.buildingId,
        articleId: widget.articleId,
      ),
    );
    final ingredients =
        ref.watch(ingredientCatalogProvider(widget.buildingId)).asData?.value ??
        const <IngredientView>[];
    final usedIds = {
      for (final line
          in async.asData?.value ?? const <ArticleCompositionView>[])
        line.ingredientId,
    };
    final available = ingredients
        .where((i) => !usedIds.contains(i.id))
        .toList();
    final titleName = article?.name ?? l10n.navArticles;

    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SizedBox.expand(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: AppBreakpoints.formMax),
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.xl),
              children: [
                Text(
                  l10n.articleCompositionTitle(titleName),
                  style: text.headlineSmall,
                ),
                const SizedBox(height: AppSpacing.sm),
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
                    return AppSurfaceCard(
                      child: Column(
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
                  AppSurfaceCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (ingredients.isEmpty)
                          AppErrorBanner(
                            message: l10n.compositionNeedIngredients,
                          )
                        else if (available.isEmpty)
                          Text(
                            l10n.compositionAllIngredientsUsed,
                            style: text.bodySmall,
                          )
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
                            onChanged: (value) =>
                                setState(() => _ingredientId = value),
                          ),
                          AppTextField(
                            controller: _qty,
                            label: l10n.compositionQuantity,
                            prefixIcon: Icons.scale_outlined,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                          ),
                          AppFilledButton(
                            label: l10n.addCompositionLine,
                            busy: _adding,
                            onPressed: () {
                              _ingredientId ??= available.first.id;
                              _add();
                            },
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
                if (_errorKey != null) ...[
                  const SizedBox(height: AppSpacing.md),
                  AppErrorBanner(message: lookupError(l10n, _errorKey!)),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
