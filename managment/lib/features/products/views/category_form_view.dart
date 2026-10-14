import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/errors/app_notice.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../core/widgets/app_loader.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../view_models/categories_view_model.dart';

/// Full-screen create/edit category (mobile); wide layouts still use the dialog.
class CategoryFormView extends ConsumerStatefulWidget {
  const CategoryFormView({
    super.key,
    required this.buildingId,
    this.categoryId,
  });

  final String buildingId;
  final String? categoryId;

  @override
  ConsumerState<CategoryFormView> createState() => _CategoryFormViewState();
}

class _CategoryFormViewState extends ConsumerState<CategoryFormView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _description;
  var _saving = false;
  var _filled = false;
  String? _errorKey;

  bool get _isEdit => (widget.categoryId ?? '').isNotEmpty;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    _description = TextEditingController();
  }

  @override
  void dispose() {
    _name.dispose();
    _description.dispose();
    super.dispose();
  }

  void _fillFromList(List<MenuCategoryView> categories) {
    if (!_isEdit || _filled) {
      return;
    }
    for (final category in categories) {
      if (category.id.uuid == widget.categoryId) {
        _name.text = category.name;
        _description.text = category.description ?? '';
        _filled = true;
        return;
      }
    }
  }

  Future<void> _submit(MenuCategoryView? existing) async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    setState(() {
      _saving = true;
      _errorKey = null;
    });
    final description = _description.text.trim();
    try {
      final vm = ref.read(
        categoriesViewModelProvider(widget.buildingId).notifier,
      );
      if (_isEdit) {
        final id = existing?.id ?? UuidValue.fromString(widget.categoryId!);
        await vm.updateCategory(
          id: id,
          name: _name.text,
          description: description.isEmpty ? null : description,
        );
      } else {
        await vm.createCategory(
          name: _name.text,
          description: description.isEmpty ? null : description,
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
    final async = ref.watch(categoryCatalogProvider(widget.buildingId));
    final categories = async.asData?.value ?? const <MenuCategoryView>[];
    _fillFromList(categories);

    MenuCategoryView? existing;
    if (_isEdit) {
      for (final category in categories) {
        if (category.id.uuid == widget.categoryId) {
          existing = category;
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
                  _isEdit ? l10n.editCategory : l10n.addCategory,
                  style: text.headlineSmall,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(l10n.categoryFormHint, style: text.bodyMedium),
                const SizedBox(height: AppSpacing.lg),
                if (_isEdit && async.isLoading && existing == null)
                  const AppScreenLoader(),
                if (_isEdit && async.hasError && existing == null) ...[
                  LoadFailureNotice(error: async.error),
                  AppErrorBanner(
                    message: lookupError(l10n, mapError(async.error!).l10nKey),
                  ),
                ],
                AppSurfaceCard(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AppTextField(
                          controller: _name,
                          label: l10n.categoryName,
                          prefixIcon: Icons.category_outlined,
                          validator: (value) {
                            final n = value?.trim() ?? '';
                            if (n.isEmpty || n.length > 80) {
                              return l10n.validationCategoryName;
                            }
                            return null;
                          },
                        ),
                        AppTextField(
                          controller: _description,
                          label: l10n.categoryDescription,
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
                        if (_errorKey != null)
                          AppErrorBanner(
                            message: lookupError(l10n, _errorKey!),
                          ),
                        const SizedBox(height: AppSpacing.md),
                        AppFilledButton(
                          label: _isEdit ? l10n.saveCategory : l10n.addCategory,
                          busy: _saving,
                          onPressed: (_isEdit && existing == null && !_filled)
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
