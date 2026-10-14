import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/errors/app_notice.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../core/widgets/app_loader.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../view_models/ingredients_view_model.dart';
import 'unit_labels.dart';

/// Dialog to add incoming quantity to an ingredient’s current stock.
Future<bool> showIngredientRestockDialog(
  BuildContext context, {
  required String buildingId,
  required IngredientView ingredient,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => _IngredientRestockDialog(
      buildingId: buildingId,
      ingredient: ingredient,
    ),
  );
  return result ?? false;
}

class _IngredientRestockDialog extends ConsumerStatefulWidget {
  const _IngredientRestockDialog({
    required this.buildingId,
    required this.ingredient,
  });

  final String buildingId;
  final IngredientView ingredient;

  @override
  ConsumerState<_IngredientRestockDialog> createState() =>
      _IngredientRestockDialogState();
}

class _IngredientRestockDialogState
    extends ConsumerState<_IngredientRestockDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _qty;
  var _saving = false;
  String? _errorKey;

  @override
  void initState() {
    super.initState();
    _qty = TextEditingController();
  }

  @override
  void dispose() {
    _qty.dispose();
    super.dispose();
  }

  double? _parse(String raw) =>
      double.tryParse(raw.trim().replaceAll(',', '.'));

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final quantity = _parse(_qty.text);
    if (quantity == null || quantity <= 0) {
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
          .restock(id: widget.ingredient.id, quantity: quantity);
      if (!mounted) return;
      popWithSnackBar(context, AppLocalizations.of(context)!.noticeSaved);
    } catch (error) {
      if (!mounted) return;
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
    final unit = unitTypeAbbrev(l10n, widget.ingredient.unit);

    return AlertDialog(
      title: Text(l10n.ingredientRestock),
      content: SizedBox(
        width: 360,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.ingredientRestockHint(widget.ingredient.name),
                style: text.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                l10n.ingredientStockLine(
                  _fmt(widget.ingredient.currentStock),
                  unit,
                  _fmt(widget.ingredient.thresholdStock),
                ),
                style: text.bodySmall,
              ),
              const SizedBox(height: AppSpacing.lg),
              AppTextField(
                controller: _qty,
                label: l10n.ingredientRestockQuantity,
                prefixIcon: Icons.add_box_outlined,
                helperText: unit,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: (value) {
                  final n = _parse(value ?? '');
                  if (n == null || n <= 0) {
                    return l10n.validationIngredientRestock;
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
              : Text(l10n.ingredientRestock),
        ),
      ],
    );
  }

  String _fmt(double value) => value == value.roundToDouble()
      ? '${value.round()}'
      : value.toStringAsFixed(2);
}
