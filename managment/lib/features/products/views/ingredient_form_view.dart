import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/errors/app_notice.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../view_models/ingredients_view_model.dart';
import '../widgets/unit_labels.dart';

/// Full-screen create ingredient (mobile); wide layouts still use the dialog.
class IngredientFormView extends ConsumerStatefulWidget {
  const IngredientFormView({super.key, required this.buildingId});

  final String buildingId;

  @override
  ConsumerState<IngredientFormView> createState() => _IngredientFormViewState();
}

class _IngredientFormViewState extends ConsumerState<IngredientFormView> {
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
                Text(l10n.addIngredient, style: text.headlineSmall),
                const SizedBox(height: AppSpacing.sm),
                Text(l10n.ingredientFormHint, style: text.bodyMedium),
                const SizedBox(height: AppSpacing.lg),
                AppSurfaceCard(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
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
                          AppErrorBanner(
                            message: lookupError(l10n, _errorKey!),
                          ),
                        const SizedBox(height: AppSpacing.md),
                        AppFilledButton(
                          label: l10n.addIngredient,
                          busy: _saving,
                          onPressed: _submit,
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
