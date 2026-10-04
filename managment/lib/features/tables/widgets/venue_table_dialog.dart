import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/errors/app_notice.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../core/widgets/form_presentation.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../view_models/tables_view_model.dart';

/// Opens table create/edit — full screen on mobile, dialog on wide layouts.
Future<bool> openVenueTableForm(
  BuildContext context, {
  required String buildingId,
  VenueTableView? existing,
  int? suggestedNumber,
}) async {
  if (!useFormDialog(context)) {
    final result = existing == null
        ? await TableCreateRoute(
            buildingId: buildingId,
            suggestedNumber: suggestedNumber,
          ).push<bool>(context)
        : await TableEditRoute(
            buildingId: buildingId,
            tableId: existing.id.uuid,
          ).push<bool>(context);
    return result ?? false;
  }
  return showVenueTableDialog(
    context,
    buildingId: buildingId,
    existing: existing,
    suggestedNumber: suggestedNumber,
  );
}

/// Owner dialog to create a batch of tables or edit seats / active.
Future<bool> showVenueTableDialog(
  BuildContext context, {
  required String buildingId,
  VenueTableView? existing,
  int? suggestedNumber,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => _VenueTableDialog(
      buildingId: buildingId,
      existing: existing,
      nextNumber: suggestedNumber,
    ),
  );
  return result ?? false;
}

class _VenueTableDialog extends ConsumerStatefulWidget {
  const _VenueTableDialog({
    required this.buildingId,
    this.existing,
    this.nextNumber,
  });

  final String buildingId;
  final VenueTableView? existing;
  final int? nextNumber;

  @override
  ConsumerState<_VenueTableDialog> createState() => _VenueTableDialogState();
}

class _VenueTableDialogState extends ConsumerState<_VenueTableDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _count;
  late final TextEditingController _seats;
  late final TextEditingController _lockedNumber;
  late bool _isActive;
  var _saving = false;
  String? _errorKey;

  bool get _isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final existing = widget.existing;
    _count = TextEditingController(text: '1')..addListener(_onCountChanged);
    _seats = TextEditingController(
      text: existing != null ? '${existing.maxSeats}' : '4',
    );
    _lockedNumber = TextEditingController(
      text: existing != null ? '${existing.number}' : '',
    );
    _isActive = existing?.isActive ?? true;
  }

  void _onCountChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _count.removeListener(_onCountChanged);
    _count.dispose();
    _seats.dispose();
    _lockedNumber.dispose();
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
    final seats = int.tryParse(_seats.text.trim());
    if (seats == null) {
      setState(() {
        _saving = false;
        _errorKey = 'errorInvalidInput';
      });
      return;
    }
    try {
      final vm = ref.read(tablesViewModelProvider(widget.buildingId).notifier);
      if (_isEdit) {
        await vm.updateTable(
          id: widget.existing!.id,
          maxSeats: seats,
          isActive: _isActive,
        );
      } else {
        final count = int.tryParse(_count.text.trim());
        if (count == null) {
          setState(() {
            _saving = false;
            _errorKey = 'errorInvalidInput';
          });
          return;
        }
        await vm.createBatch(
          count: count,
          maxSeats: seats,
          isActive: _isActive,
        );
      }
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
        _errorKey = captureError(context, error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final next = widget.nextNumber ?? 1;
    final countPreview = int.tryParse(_count.text.trim()) ?? 1;
    final lastNumber = next + (countPreview < 1 ? 0 : countPreview - 1);

    return AlertDialog(
      title: Text(_isEdit ? l10n.editTable : l10n.addTable),
      content: SizedBox(
        width: 360,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                _isEdit ? l10n.tableEditHint : l10n.tableFormHint,
                style: text.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.lg),
              if (_isEdit)
                AppTextField(
                  controller: _lockedNumber,
                  label: l10n.tableNumber,
                  prefixIcon: Icons.tag,
                  readOnly: true,
                  helperText: l10n.tableNumberLocked,
                )
              else ...[
                AppTextField(
                  controller: _count,
                  label: l10n.tableCountToAdd,
                  prefixIcon: Icons.grid_view_outlined,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    final n = int.tryParse(value?.trim() ?? '');
                    if (n == null || n < 1 || n > 100) {
                      return l10n.validationTableCount;
                    }
                    return null;
                  },
                ),
                Text(
                  l10n.tableNumberRange(
                    next,
                    lastNumber < next ? next : lastNumber,
                  ),
                  style: text.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
              ],
              AppTextField(
                controller: _seats,
                label: l10n.tableMaxSeats,
                prefixIcon: Icons.event_seat_outlined,
                keyboardType: TextInputType.number,
                validator: (value) {
                  final n = int.tryParse(value?.trim() ?? '');
                  if (n == null || n < 1 || n > 50) {
                    return l10n.validationTableSeats;
                  }
                  return null;
                },
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(l10n.tableActive),
                subtitle: Text(l10n.tableActiveHint),
                value: _isActive,
                onChanged: (value) => setState(() => _isActive = value),
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
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(_isEdit ? l10n.saveTable : l10n.addTable),
        ),
      ],
    );
  }
}
