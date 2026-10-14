import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/errors/app_notice.dart';
import '../../../core/errors/async_lists.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../core/widgets/app_loader.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../view_models/articles_view_model.dart';
import '../view_models/categories_view_model.dart';

/// Full-screen create/edit article (mobile); wide layouts still use the dialog.
class ArticleFormView extends ConsumerStatefulWidget {
  const ArticleFormView({super.key, required this.buildingId, this.articleId});

  final String buildingId;
  final String? articleId;

  @override
  ConsumerState<ArticleFormView> createState() => _ArticleFormViewState();
}

class _ArticleFormViewState extends ConsumerState<ArticleFormView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _description;
  late final TextEditingController _price;
  UuidValue? _categoryId;
  var _saving = false;
  var _filled = false;
  String? _errorKey;

  bool get _isEdit => (widget.articleId ?? '').isNotEmpty;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    _description = TextEditingController();
    _price = TextEditingController();
  }

  @override
  void dispose() {
    _name.dispose();
    _description.dispose();
    _price.dispose();
    super.dispose();
  }

  String _formatPrice(double price) {
    if (price == price.roundToDouble()) {
      return '${price.round()}';
    }
    return price.toStringAsFixed(2);
  }

  void _fillFromList(List<MenuArticleView> articles) {
    if (!_isEdit || _filled) {
      return;
    }
    for (final article in articles) {
      if (article.id.uuid == widget.articleId) {
        _name.text = article.name;
        _description.text = article.description ?? '';
        _price.text = _formatPrice(article.price);
        _categoryId = article.categoryId;
        _filled = true;
        return;
      }
    }
  }

  Future<void> _submit(MenuArticleView? existing) async {
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
        final id = existing?.id ?? UuidValue.fromString(widget.articleId!);
        await vm.updateArticle(
          id: id,
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
    final articlesAsync = ref.watch(
      articlesViewModelProvider(widget.buildingId),
    );
    final categoriesAsync = ref.watch(
      categoryCatalogProvider(widget.buildingId),
    );
    final articles = settledList(articlesAsync) ?? const <MenuArticleView>[];
    final categories = settledList(categoriesAsync);
    final categoriesFailed = categories == null && categoriesAsync.hasError;
    final categoriesPending = categories == null && !categoriesFailed;
    final categoriesMissing = isSettledEmpty(categoriesAsync);
    _fillFromList(articles);

    MenuArticleView? existing;
    if (_isEdit) {
      for (final article in articles) {
        if (article.id.uuid == widget.articleId) {
          existing = article;
          break;
        }
      }
    }

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
                  _isEdit ? l10n.editArticle : l10n.addArticle,
                  style: text.headlineSmall,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(l10n.articleFormHint, style: text.bodyMedium),
                const SizedBox(height: AppSpacing.lg),
                if (_isEdit && articlesAsync.isLoading && existing == null)
                  const AppScreenLoader(),
                AppSurfaceCard(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
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
                            onChanged: (value) =>
                                setState(() => _categoryId = value),
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
                            if (price == null ||
                                price <= 0 ||
                                price > 1000000) {
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
                        const SizedBox(height: AppSpacing.md),
                        AppFilledButton(
                          label: _isEdit ? l10n.saveArticle : l10n.addArticle,
                          busy: _saving,
                          onPressed:
                              categoriesPending ||
                                  categoriesFailed ||
                                  categoriesMissing ||
                                  (_isEdit && existing == null && !_filled)
                              ? null
                              : () => _submit(existing),
                        ),
                      ],
                    ),
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
