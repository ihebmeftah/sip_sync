import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/errors/error_mapper.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../view_models/ingredients_view_model.dart';
import 'unit_labels.dart';

/// Owner dialog to create an ingredient.
Future<bool> showIngredientDialog(
  BuildContext context, {
  required String buildingId,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => _IngredientDialog(buildingId: buildingId),
  );
  return result ?? false;
}

class _IngredientDialog extends ConsumerStatefulWidget {
  const _IngredientDialog({required this.buildingId});

  final String buildingId;

  @override
  ConsumerState<_IngredientDialog> createState() => _IngredientDialogState();
}

class _IngredientDialogState extends ConsumerState<_IngredientDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _current;
  late final TextEditingController _threshold;
  var _unit = UnitsType.kilogram;
  var _saving = false;
  String? _errorKey;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    _current = TextEditingController(text: '0');
    _threshold = TextEditingController(text: '0');
  }

  @override
  void dispose() {
    _name.dispose();
    _current.dispose();
    _threshold.dispose();
    super.dispose();
  }

  double? _parseStock(String raw) =>
      double.tryParse(raw.trim().replaceAll(',', '.'));

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    final current = _parseStock(_current.text);
    final threshold = _parseStock(_threshold.text);
    if (current == null || threshold == null) {
      setState(() => _errorKey = 'errorInvalidInput');
      return;
    }
    setState(() {
      _saving = true;
      _errorKey = null;
    });
    try {
      await ref
          .read(ingredientsViewModelProvider(widget.buildingId).notifier)
          .createIngredient(
            name: _name.text,
            unit: _unit,
            currentStock: current,
            thresholdStock: threshold,
          );
      if (!mounted) {
        return;
      }
      Navigator.of(context).pop(true);
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _saving = false;
        _errorKey = mapError(error).l10nKey;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;

    return AlertDialog(
      title: Text(l10n.addIngredient),
      content: SizedBox(
        width: 380,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(l10n.ingredientFormHint, style: text.bodyMedium),
                const SizedBox(height: AppSpacing.lg),
                AppTextField(
                  controller: _name,
                  label: l10n.ingredientName,
                  prefixIcon: Icons.science_outlined,
                  validator: (value) {
                    final n = value?.trim() ?? '';
                    if (n.isEmpty || n.length > 80) {
                      return l10n.validationIngredientName;
                    }
                    return null;
                  },
                ),
                AppDropdownField<UnitsType>(
                  label: l10n.ingredientUnit,
                  value: _unit,
                  prefixIcon: Icons.straighten_outlined,
                  items: [
                    for (final unit in UnitsType.values)
                      DropdownMenuItem(
                        value: unit,
                        child: Text(unitTypeLabel(l10n, unit)),
                      ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _unit = value);
                    }
                  },
                ),
                AppTextField(
                  controller: _current,
                  label: l10n.ingredientCurrentStock,
                  prefixIcon: Icons.inventory_2_outlined,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  validator: (value) {
                    final n = _parseStock(value ?? '');
                    if (n == null || n < 0) {
                      return l10n.validationIngredientStock;
                    }
                    return null;
                  },
                ),
                AppTextField(
                  controller: _threshold,
                  label: l10n.ingredientThresholdStock,
                  prefixIcon: Icons.warning_amber_outlined,
                  helperText: l10n.ingredientThresholdHint,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  validator: (value) {
                    final n = _parseStock(value ?? '');
                    if (n == null || n < 0) {
                      return l10n.validationIngredientStock;
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
      ),
      actions: [
        TextButton(
          onPressed: _saving ? null : () => Navigator.of(context).pop(false),
          child: Text(l10n.cancel),
        ),
        FilledButton(
          onPressed: _saving ? null : _submit,
          child: _saving
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(l10n.addIngredient),
        ),
      ],
    );
  }
}
