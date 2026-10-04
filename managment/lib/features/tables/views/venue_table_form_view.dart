import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/errors/app_notice.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../view_models/tables_view_model.dart';

/// Full-screen create/edit table (mobile); wide layouts still use the dialog.
class VenueTableFormView extends ConsumerStatefulWidget {
  const VenueTableFormView({
    super.key,
    required this.buildingId,
    this.tableId,
    this.suggestedNumber,
  });

  final String buildingId;
  final String? tableId;
  final int? suggestedNumber;

  @override
  ConsumerState<VenueTableFormView> createState() => _VenueTableFormViewState();
}

class _VenueTableFormViewState extends ConsumerState<VenueTableFormView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _count;
  late final TextEditingController _seats;
  late final TextEditingController _lockedNumber;
  late bool _isActive;
  var _saving = false;
  var _filled = false;
  String? _errorKey;

  bool get _isEdit => (widget.tableId ?? '').isNotEmpty;

  @override
  void initState() {
    super.initState();
    _count = TextEditingController(text: '1')..addListener(_onCountChanged);
    _seats = TextEditingController(text: '4');
    _lockedNumber = TextEditingController();
    _isActive = true;
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

  void _fillFromList(List<VenueTableView> tables) {
    if (!_isEdit || _filled) {
      return;
    }
    for (final table in tables) {
      if (table.id.uuid == widget.tableId) {
        _seats.text = '${table.maxSeats}';
        _lockedNumber.text = '${table.number}';
        _isActive = table.isActive;
        _filled = true;
        return;
      }
    }
  }

  Future<void> _submit(VenueTableView? existing) async {
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
        final id = existing?.id ?? UuidValue.fromString(widget.tableId!);
        await vm.updateTable(id: id, maxSeats: seats, isActive: _isActive);
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
    final async = ref.watch(tablesViewModelProvider(widget.buildingId));
    final tables = async.asData?.value ?? const <VenueTableView>[];
    _fillFromList(tables);

    VenueTableView? existing;
    if (_isEdit) {
      for (final table in tables) {
        if (table.id.uuid == widget.tableId) {
          existing = table;
          break;
        }
      }
    }

    final next =
        widget.suggestedNumber ??
        (tables.isEmpty
            ? 1
            : tables.map((t) => t.number).reduce((a, b) => a > b ? a : b) + 1);
    final countPreview = int.tryParse(_count.text.trim()) ?? 1;
    final lastNumber = next + (countPreview < 1 ? 0 : countPreview - 1);

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
                  _isEdit ? l10n.editTable : l10n.addTable,
                  style: text.headlineSmall,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  _isEdit ? l10n.tableEditHint : l10n.tableFormHint,
                  style: text.bodyMedium,
                ),
                const SizedBox(height: AppSpacing.lg),
                if (_isEdit && async.isLoading && existing == null)
                  const LinearProgressIndicator(),
                if (_isEdit && async.hasError && existing == null)
                  AppErrorBanner(
                    message: lookupError(l10n, mapError(async.error!).l10nKey),
                  ),
                AppSurfaceCard(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
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
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
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
                          onChanged: (value) =>
                              setState(() => _isActive = value),
                        ),
                        if (_errorKey != null)
                          AppErrorBanner(
                            message: lookupError(l10n, _errorKey!),
                          ),
                        const SizedBox(height: AppSpacing.md),
                        AppFilledButton(
                          label: _isEdit ? l10n.saveTable : l10n.addTable,
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
