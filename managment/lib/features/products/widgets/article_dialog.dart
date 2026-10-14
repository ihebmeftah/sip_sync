import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/errors/app_notice.dart';
import '../../../core/errors/async_lists.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../core/widgets/app_loader.dart';
import '../../../core/widgets/form_presentation.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../view_models/articles_view_model.dart';
import '../view_models/categories_view_model.dart';

/// Opens article create/edit — full screen on mobile, dialog on wide layouts.
Future<bool> openArticleForm(
  BuildContext context, {
  required String buildingId,
  MenuArticleView? existing,
}) async {
  if (!useFormDialog(context)) {
    final result = existing == null
        ? await ArticleCreateRoute(buildingId: buildingId).push<bool>(context)
        : await ArticleEditRoute(
            buildingId: buildingId,
            articleId: existing.id.uuid,
          ).push<bool>(context);
    return result ?? false;
  }
  return showArticleDialog(context, buildingId: buildingId, existing: existing);
}

/// Owner dialog to create or edit a menu article.
Future<bool> showArticleDialog(
  BuildContext context, {
  required String buildingId,
  MenuArticleView? existing,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) =>
        _ArticleDialog(buildingId: buildingId, existing: existing),
  );
  return result ?? false;
}

class _ArticleDialog extends ConsumerStatefulWidget {
  const _ArticleDialog({required this.buildingId, this.existing});

  final String buildingId;
  final MenuArticleView? existing;

  @override
  ConsumerState<_ArticleDialog> createState() => _ArticleDialogState();
}

class _ArticleDialogState extends ConsumerState<_ArticleDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _description;
  late final TextEditingController _price;
  UuidValue? _categoryId;
  var _saving = false;
  String? _errorKey;

  bool get _isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final existing = widget.existing;
    _name = TextEditingController(text: existing?.name ?? '');
    _description = TextEditingController(text: existing?.description ?? '');
    _price = TextEditingController(
      text: existing != null ? _formatPrice(existing.price) : '',
    );
    _categoryId = existing?.categoryId;
  }

  String _formatPrice(double price) {
    if (price == price.roundToDouble()) {
      return '${price.round()}';
    }
    return price.toStringAsFixed(2);
  }

  @override
  void dispose() {
    _name.dispose();
    _description.dispose();
    _price.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    final categoryId = _categoryId;
    if (categoryId == null) {
      setState(() => _errorKey = 'validationArticleCategory');
      return;
    }
    final price = double.tryParse(_price.text.trim().replaceAll(',', '.'));
    if (price == null) {
      setState(() => _errorKey = 'errorInvalidInput');
      return;
    }
    setState(() {
      _saving = true;
      _errorKey = null;
    });
    final description = _description.text.trim();
    try {
      final vm = ref.read(
        articlesViewModelProvider(widget.buildingId).notifier,
      );
      if (_isEdit) {
        await vm.updateArticle(
          id: widget.existing!.id,
          categoryId: categoryId,
          name: _name.text,
          description: description.isEmpty ? null : description,
          price: price,
        );
      } else {
        await vm.createArticle(
          categoryId: categoryId,
          name: _name.text,
          description: description.isEmpty ? null : description,
          price: price,
        );
      }
      if (!mounted) {
        return;
      }
      popWithSnackBar(context, AppLocalizations.of(context)!.noticeSaved);
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _saving = false;
        _errorKey = captureError(context, error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final categoriesAsync = ref.watch(
      categoryCatalogProvider(widget.buildingId),
    );
    final categories = settledList(categoriesAsync);
    final categoriesFailed = categories == null && categoriesAsync.hasError;
    final categoriesPending = categories == null && !categoriesFailed;
    final categoriesMissing = isSettledEmpty(categoriesAsync);

    return AlertDialog(
      title: Text(_isEdit ? l10n.editArticle : l10n.addArticle),
      content: SizedBox(
        width: 380,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(l10n.articleFormHint, style: text.bodyMedium),
              const SizedBox(height: AppSpacing.lg),
              if (categoriesPending)
                const AppScreenLoader(compact: true)
              else if (categoriesFailed)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    LoadFailureNotice(error: categoriesAsync.error),
                    AppErrorBanner(
                      message: lookupError(
                        l10n,
                        mapError(categoriesAsync.error!).l10nKey,
                      ),
                    ),
                  ],
                )
              else if (categoriesMissing)
                AppErrorBanner(message: l10n.articlesNeedCategory)
              else
                DropdownButtonFormField<UuidValue>(
                  initialValue:
                      _categoryId != null &&
                          categories!.any((c) => c.id == _categoryId)
                      ? _categoryId
                      : null,
                  decoration: InputDecoration(
                    labelText: l10n.articleCategory,
                    prefixIcon: const Icon(Icons.category_outlined),
                  ),
                  items: [
                    for (final category in categories!)
                      DropdownMenuItem(
                        value: category.id,
                        child: Text(category.name),
                      ),
                  ],
                  onChanged: (value) => setState(() => _categoryId = value),
                  validator: (value) {
                    if (value == null) {
                      return l10n.validationArticleCategory;
                    }
                    return null;
                  },
                ),
              const SizedBox(height: AppSpacing.lg),
              AppTextField(
                controller: _name,
                label: l10n.articleName,
                prefixIcon: Icons.restaurant_menu_outlined,
                validator: (value) {
                  final n = value?.trim() ?? '';
                  if (n.isEmpty || n.length > 80) {
                    return l10n.validationArticleName;
                  }
                  return null;
                },
              ),
              AppTextField(
                controller: _description,
                label: l10n.articleDescription,
                prefixIcon: Icons.notes_outlined,
                helperText: l10n.optionalFieldHint,
                validator: (value) {
                  final n = value?.trim() ?? '';
                  if (n.length > 500) {
                    return l10n.validationDescription;
                  }
                  return null;
                },
              ),
              AppTextField(
                controller: _price,
                label: l10n.articlePrice,
                prefixIcon: Icons.payments_outlined,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: (value) {
                  final price = double.tryParse(
                    (value ?? '').trim().replaceAll(',', '.'),
                  );
                  if (price == null || price <= 0 || price > 1000000) {
                    return l10n.validationArticlePrice;
                  }
                  return null;
                },
              ),
              if (_errorKey != null)
                AppErrorBanner(
                  message: _errorKey == 'validationArticleCategory'
                      ? l10n.validationArticleCategory
                      : lookupError(l10n, _errorKey!),
                ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _saving ? null : () => Navigator.of(context).pop(false),
          child: Text(l10n.cancel),
        ),
        FilledButton(
          onPressed:
              _saving ||
                  categoriesPending ||
                  categoriesFailed ||
                  categoriesMissing
              ? null
              : _submit,
          child: _saving
              ? const SizedBox(width: 18, height: 18, child: AppBusyIndicator())
              : Text(_isEdit ? l10n.saveArticle : l10n.addArticle),
        ),
      ],
    );
  }
}
