import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/errors/app_notice.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../core/widgets/app_loader.dart';
import '../../../core/widgets/form_presentation.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../view_models/categories_view_model.dart';

/// Opens category create/edit — full screen on mobile, dialog on wide layouts.
Future<bool> openCategoryForm(
  BuildContext context, {
  required String buildingId,
  MenuCategoryView? existing,
}) async {
  if (!useFormDialog(context)) {
    final result = existing == null
        ? await CategoryCreateRoute(buildingId: buildingId).push<bool>(context)
        : await CategoryEditRoute(
            buildingId: buildingId,
            categoryId: existing.id.uuid,
          ).push<bool>(context);
    return result ?? false;
  }
  return showCategoryDialog(
    context,
    buildingId: buildingId,
    existing: existing,
  );
}

/// Owner dialog to create or edit a menu category.
Future<bool> showCategoryDialog(
  BuildContext context, {
  required String buildingId,
  MenuCategoryView? existing,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) =>
        _CategoryDialog(buildingId: buildingId, existing: existing),
  );
  return result ?? false;
}

class _CategoryDialog extends ConsumerStatefulWidget {
  const _CategoryDialog({required this.buildingId, this.existing});

  final String buildingId;
  final MenuCategoryView? existing;

  @override
  ConsumerState<_CategoryDialog> createState() => _CategoryDialogState();
}

class _CategoryDialogState extends ConsumerState<_CategoryDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _description;
  var _saving = false;
  String? _errorKey;

  bool get _isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final existing = widget.existing;
    _name = TextEditingController(text: existing?.name ?? '');
    _description = TextEditingController(text: existing?.description ?? '');
  }

  @override
  void dispose() {
    _name.dispose();
    _description.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
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
        await vm.updateCategory(
          id: widget.existing!.id,
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

    return AlertDialog(
      title: Text(_isEdit ? l10n.editCategory : l10n.addCategory),
      content: SizedBox(
        width: 360,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(l10n.categoryFormHint, style: text.bodyMedium),
              const SizedBox(height: AppSpacing.lg),
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
                AppErrorBanner(message: lookupError(l10n, _errorKey!)),
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
          onPressed: _saving ? null : _submit,
          child: _saving
              ? const SizedBox(width: 18, height: 18, child: AppBusyIndicator())
              : Text(_isEdit ? l10n.saveCategory : l10n.addCategory),
        ),
      ],
    );
  }
}
