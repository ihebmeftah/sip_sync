import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/errors/form_validators.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../core/widgets/app_loader.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../dashboard/view_models/dashboard_view_model.dart';
import '../../orders/view_models/order_kitchen_board_view_model.dart';
import '../../orders/view_models/orders_view_model.dart';
import '../view_models/cash_register_view_model.dart';

/// Open shift and the history of closed ones.
class CashRegisterView extends ConsumerStatefulWidget {
  const CashRegisterView({super.key, required this.buildingId});

  final String buildingId;

  @override
  ConsumerState<CashRegisterView> createState() => _CashRegisterViewState();
}

class _CashRegisterViewState extends ConsumerState<CashRegisterView> {
  var _busy = false;
  String? _errorKey;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final currency = ref.watch(buildingSelectionProvider)?.currencyCode ?? '';
    final isOwner = ref.watch(appSessionStoreProvider).isOwner;
    final register = ref.watch(
      cashRegisterViewModelProvider(widget.buildingId),
    );
    return register.when(
      loading: () => const AppScreenLoader(),
      error: (error, _) => Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppErrorBanner(message: lookupError(l10n, mapError(error).l10nKey)),
            AppFilledButton(
              label: l10n.retry,
              onPressed: () => ref.invalidate(
                cashRegisterViewModelProvider(widget.buildingId),
              ),
            ),
          ],
        ),
      ),
      data: (page) {
        final open = page.current;
        final history = [
          for (final shift in page.history)
            if (shift.id != open?.id) shift,
        ];
        final material = MaterialLocalizations.of(context);
        final dayLabel = page.historyDay == null
            ? l10n.cashRegisterHistoryPickDay
            : material.formatMediumDate(page.historyDay!);
        return ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            Text(l10n.cashRegisterTitle, style: text.headlineSmall),
            const SizedBox(height: AppSpacing.md),
            if (open == null)
              Text(l10n.cashRegisterNone, style: text.bodyMedium)
            else
              _ShiftCard(
                shift: open,
                open: true,
                currency: currency,
                showOpeningCash: isOwner,
                showClosingCash: isOwner,
                showPaid: true,
                canCorrect: isOwner,
                onCorrect: () => _correct(open),
              ),
            const SizedBox(height: AppSpacing.md),
            if (_errorKey != null) ...[
              AppErrorBanner(message: lookupError(l10n, _errorKey!)),
              const SizedBox(height: AppSpacing.md),
            ],
            AppFilledButton(
              label: open == null
                  ? l10n.cashRegisterOpen
                  : l10n.cashRegisterClose,
              busy: _busy,
              onPressed: () => open == null ? _open() : _close(open),
            ),
            if (open != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(l10n.cashRegisterCloseHint, style: text.bodySmall),
            ],
            const SizedBox(height: AppSpacing.xl),
            Text(l10n.cashRegisterHistory, style: text.titleMedium),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                AppFilterChip(
                  label: l10n.cashRegisterHistoryAll,
                  selected: page.historyDay == null,
                  onSelected: (_) => ref
                      .read(
                        cashRegisterViewModelProvider(
                          widget.buildingId,
                        ).notifier,
                      )
                      .setHistoryDay(null),
                ),
                AppFilterChip(
                  label: dayLabel,
                  selected: page.historyDay != null,
                  onSelected: (_) => _pickDay(page.historyDay),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            if (history.isEmpty)
              Text(l10n.cashRegisterHistoryEmpty, style: text.bodyMedium)
            else
              LayoutBuilder(
                builder: (context, constraints) {
                  final columns = constraints.maxWidth >= 840
                      ? 3
                      : constraints.maxWidth >= 340
                      ? 2
                      : 1;
                  const gap = AppSpacing.sm;
                  final tileWidth =
                      (constraints.maxWidth - gap * (columns - 1)) / columns;
                  return Wrap(
                    spacing: gap,
                    runSpacing: gap,
                    children: [
                      for (final shift in history)
                        SizedBox(
                          width: tileWidth,
                          child: _ShiftCard(
                            shift: shift,
                            open: false,
                            currency: currency,
                            showOpeningCash: isOwner,
                            showClosingCash: isOwner,
                            showPaid: isOwner,
                            canCorrect: isOwner,
                            onCorrect: () => _correct(shift),
                          ),
                        ),
                    ],
                  );
                },
              ),
            if (page.hasMore)
              TextButton(
                onPressed: page.loadingMore
                    ? null
                    : () => ref
                          .read(
                            cashRegisterViewModelProvider(
                              widget.buildingId,
                            ).notifier,
                          )
                          .loadMore(),
                child: Text(
                  page.loadingMore ? l10n.loadingMore : l10n.nextPage,
                ),
              ),
          ],
        );
      },
    );
  }

  void _retarget() {
    ref.invalidate(orderKitchenBoardProvider(widget.buildingId));
    ref.invalidate(ordersViewModelProvider(widget.buildingId));
    ref.invalidate(dashboardViewModelProvider(widget.buildingId));
  }

  Future<void> _pickDay(DateTime? current) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final initial = current ?? today;
    final picked = await showDatePicker(
      context: context,
      initialDate: initial.isAfter(today) ? today : initial,
      firstDate: DateTime(today.year - 2),
      lastDate: today,
    );
    if (!mounted || picked == null) {
      return;
    }
    await ref
        .read(cashRegisterViewModelProvider(widget.buildingId).notifier)
        .setHistoryDay(picked);
  }

  Future<void> _open() async {
    final l10n = AppLocalizations.of(context)!;
    final counted = await showDialog<_CountedCash>(
      context: context,
      builder: (context) => _CashDialog(
        title: l10n.cashRegisterOpen,
        label: l10n.cashRegisterStartCash,
        hint: l10n.cashRegisterStartCashHint,
        confirm: l10n.cashRegisterOpen,
        requiredAmount: false,
      ),
    );
    if (counted == null || !mounted) {
      return;
    }
    await _run(() async {
      await ref
          .read(cashRegisterViewModelProvider(widget.buildingId).notifier)
          .open(startCash: counted.amount);
      _retarget();
    });
  }

  Future<void> _close(CashRegisterSessionView open) async {
    final l10n = AppLocalizations.of(context)!;
    final requiredAmount = open.startCash != null;
    final counted = await showDialog<_CountedCash>(
      context: context,
      builder: (context) => _CashDialog(
        title: l10n.cashRegisterCloseConfirm,
        body: requiredAmount
            ? '${l10n.cashRegisterCloseHint}\n${l10n.cashRegisterEndCashRequiredHint}'
            : l10n.cashRegisterCloseHint,
        label: l10n.cashRegisterEndCash,
        hint: requiredAmount
            ? l10n.cashRegisterEndCashRequiredHint
            : l10n.cashRegisterEndCashHint,
        confirm: l10n.cashRegisterClose,
        requiredAmount: requiredAmount,
      ),
    );
    if (counted == null || !mounted) {
      return;
    }
    await _run(() async {
      await ref
          .read(cashRegisterViewModelProvider(widget.buildingId).notifier)
          .close(open.id, endCash: counted.amount);
      _retarget();
    });
  }

  Future<void> _correct(CashRegisterSessionView shift) async {
    final l10n = AppLocalizations.of(context)!;
    final fixed = await showDialog<_CashFix>(
      context: context,
      builder: (context) =>
          _CorrectCashDialog(title: l10n.cashRegisterCorrect, shift: shift),
    );
    if (fixed == null || !mounted) {
      return;
    }
    await _run(() async {
      await ref
          .read(cashRegisterViewModelProvider(widget.buildingId).notifier)
          .correct(
            shift.id,
            startCash: fixed.startCash,
            endCash: fixed.endCash,
          );
    });
  }

  Future<void> _run(Future<void> Function() action) async {
    setState(() {
      _busy = true;
      _errorKey = null;
    });
    try {
      await action();
    } catch (error) {
      if (mounted) {
        setState(() => _errorKey = mapError(error).l10nKey);
      }
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
    }
  }
}

class _CountedCash {
  const _CountedCash(this.amount);

  final double? amount;
}

class _CashFix {
  const _CashFix({this.startCash, this.endCash});

  final double? startCash;
  final double? endCash;
}

class _CashDialog extends StatefulWidget {
  const _CashDialog({
    required this.title,
    required this.label,
    required this.hint,
    required this.confirm,
    required this.requiredAmount,
    this.body,
  });

  final String title;
  final String? body;
  final String label;
  final String hint;
  final String confirm;
  final bool requiredAmount;

  @override
  State<_CashDialog> createState() => _CashDialogState();
}

class _CashDialogState extends State<_CashDialog> {
  final _formKey = GlobalKey<FormState>();
  final _amount = TextEditingController();

  @override
  void dispose() {
    _amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(widget.title),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (widget.body != null) ...[
              Text(widget.body!),
              const SizedBox(height: AppSpacing.md),
            ],
            AppTextField(
              compact: true,
              controller: _amount,
              label: widget.label,
              helperText: widget.hint,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              validator: (value) => widget.requiredAmount
                  ? FormValidators.requiredCash(l10n, value)
                  : FormValidators.optionalCash(l10n, value),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.cancel),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState?.validate() != true) {
              return;
            }
            Navigator.of(
              context,
            ).pop(_CountedCash(FormValidators.parseOptionalCash(_amount.text)));
          },
          child: Text(widget.confirm),
        ),
      ],
    );
  }
}

class _CorrectCashDialog extends StatefulWidget {
  const _CorrectCashDialog({required this.title, required this.shift});

  final String title;
  final CashRegisterSessionView shift;

  @override
  State<_CorrectCashDialog> createState() => _CorrectCashDialogState();
}

class _CorrectCashDialogState extends State<_CorrectCashDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _start = TextEditingController(
    text: _seed(widget.shift.startCash),
  );
  late final TextEditingController _end = TextEditingController(
    text: _seed(widget.shift.endCash),
  );

  bool get _closed => widget.shift.status == CashRegisterStatus.closed;

  @override
  void dispose() {
    _start.dispose();
    _end.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(widget.title),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppTextField(
              compact: true,
              controller: _start,
              label: l10n.cashRegisterStartCash,
              helperText: l10n.cashRegisterStartCashHint,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              validator: (value) => FormValidators.optionalCash(l10n, value),
              onChanged: (_) => setState(() {}),
            ),
            if (_closed)
              AppTextField(
                compact: true,
                controller: _end,
                label: l10n.cashRegisterEndCash,
                helperText: _startHasAmount
                    ? l10n.cashRegisterEndCashRequiredHint
                    : l10n.cashRegisterEndCashHint,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: (value) => _startHasAmount
                    ? FormValidators.requiredCash(l10n, value)
                    : FormValidators.optionalCash(l10n, value),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.cancel),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState?.validate() != true) {
              return;
            }
            Navigator.of(context).pop(
              _CashFix(
                startCash: FormValidators.parseOptionalCash(_start.text),
                endCash: _closed
                    ? FormValidators.parseOptionalCash(_end.text)
                    : null,
              ),
            );
          },
          child: Text(l10n.save),
        ),
      ],
    );
  }

  bool get _startHasAmount =>
      FormValidators.parseOptionalCash(_start.text) != null;
}

String _seed(double? amount) {
  if (amount == null) {
    return '';
  }
  return amount == amount.roundToDouble()
      ? '${amount.round()}'
      : amount.toStringAsFixed(2);
}

String formatCash(double amount, String currency) {
  final text = amount == amount.roundToDouble()
      ? '${amount.round()}'
      : amount.toStringAsFixed(2);
  return currency.isEmpty ? text : '$text $currency';
}

/// Thousandths, so a float remainder does not flip a matching drawer.
int _milli(double value) => (value * 1000).round();

class _ShiftCard extends StatelessWidget {
  const _ShiftCard({
    required this.shift,
    required this.open,
    required this.currency,
    required this.showOpeningCash,
    required this.showClosingCash,
    required this.showPaid,
    required this.canCorrect,
    required this.onCorrect,
  });

  final CashRegisterSessionView shift;
  final bool open;
  final String currency;

  /// Opening cash stays off the employee card.
  final bool showOpeningCash;

  /// Closing cash and the drawer check stay on the owner card.
  final bool showClosingCash;

  /// Paid-order total. Hidden on employee history cards.
  final bool showPaid;
  final bool canCorrect;
  final VoidCallback onCorrect;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final material = MaterialLocalizations.of(context);
    final use24 = MediaQuery.alwaysUse24HourFormatOf(context);
    final balance = showOpeningCash && showClosingCash && showPaid
        ? _balance(scheme)
        : null;
    String stamp(DateTime value) {
      final local = value.toLocal();
      final date = material.formatMediumDate(local);
      final time = material.formatTimeOfDay(
        TimeOfDay.fromDateTime(local),
        alwaysUse24HourFormat: use24,
      );
      return '$date, $time';
    }

    String person(OrderActorView actor) {
      final name = '${actor.firstName} ${actor.lastName}'.trim();
      return name.isEmpty ? actor.type.name : name;
    }

    return Material(
      color: scheme.surfaceContainerLowest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.md),
        side: BorderSide(
          color: balance?.color ?? scheme.outlineVariant,
          width: balance == null ? 1 : 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              open
                  ? l10n.cashRegisterInProgress
                  : l10n.cashRegisterStatusClosed,
              style: text.labelLarge?.copyWith(color: scheme.primary),
            ),
            if (open) ...[
              const SizedBox(height: AppSpacing.xs),
              _Elapsed(openedAt: shift.openedAt),
            ],
            const SizedBox(height: AppSpacing.xs),
            Text(
              l10n.cashRegisterOpenedLine(
                stamp(shift.openedAt),
                person(shift.openedBy),
              ),
              style: text.bodyMedium,
            ),
            if (showOpeningCash && shift.startCash != null)
              Text(
                l10n.cashRegisterStartCashLine(
                  formatCash(shift.startCash!, currency),
                ),
                style: text.bodyMedium,
              ),
            if (shift.closedAt != null && shift.closedBy != null)
              Text(
                l10n.cashRegisterClosedLine(
                  stamp(shift.closedAt!),
                  person(shift.closedBy!),
                ),
                style: text.bodyMedium,
              ),
            if (showClosingCash && shift.endCash != null)
              Text(
                l10n.cashRegisterEndCashLine(
                  formatCash(shift.endCash!, currency),
                ),
                style: text.bodyMedium,
              ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              l10n.cashRegisterOrderCount(shift.orderCount),
              style: text.bodySmall,
            ),
            if (showPaid)
              Text(
                l10n.cashRegisterPaidTotal(
                  formatCash(shift.paidTotal, currency),
                ),
                style: text.bodySmall,
              ),
            if (balance != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                balance.label(l10n, currency),
                style: text.labelLarge?.copyWith(color: balance.color),
              ),
            ],
            if (canCorrect) ...[
              const SizedBox(height: AppSpacing.sm),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: TextButton(
                  onPressed: onCorrect,
                  child: Text(l10n.cashRegisterCorrect),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  _DrawerBalance? _balance(ColorScheme scheme) {
    final start = shift.startCash;
    final end = shift.endCash;
    if (start == null || end == null) {
      return null;
    }
    final difference = _milli(end) - _milli(start + shift.paidTotal);
    if (difference == 0) {
      return _DrawerBalance.correct(scheme.primary);
    }
    final amount = difference.abs() / 1000;
    if (difference > 0) {
      return _DrawerBalance.tips(_tipsColor(scheme), amount);
    }
    return _DrawerBalance.short(scheme.error, amount);
  }

  Color _tipsColor(ColorScheme scheme) {
    return scheme.brightness == Brightness.dark
        ? const Color(0xFF7DCEA0)
        : const Color(0xFF1B7F4E);
  }
}

class _DrawerBalance {
  const _DrawerBalance._(this.kind, this.color, this.amount);

  factory _DrawerBalance.correct(Color color) {
    return _DrawerBalance._(_DrawerKind.correct, color, 0);
  }

  factory _DrawerBalance.tips(Color color, double amount) {
    return _DrawerBalance._(_DrawerKind.tips, color, amount);
  }

  factory _DrawerBalance.short(Color color, double amount) {
    return _DrawerBalance._(_DrawerKind.short, color, amount);
  }

  final _DrawerKind kind;
  final Color color;
  final double amount;

  String label(AppLocalizations l10n, String currency) {
    return switch (kind) {
      _DrawerKind.correct => l10n.cashRegisterBalanceCorrect,
      _DrawerKind.tips => l10n.cashRegisterBalanceTips(
        formatCash(amount, currency),
      ),
      _DrawerKind.short => l10n.cashRegisterBalanceShort(
        formatCash(amount, currency),
      ),
    };
  }
}

enum _DrawerKind { correct, tips, short }

class _Elapsed extends StatefulWidget {
  const _Elapsed({required this.openedAt});

  final DateTime openedAt;

  @override
  State<_Elapsed> createState() => _ElapsedState();
}

class _ElapsedState extends State<_Elapsed> {
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    var elapsed = DateTime.now().difference(widget.openedAt);
    if (elapsed.isNegative) {
      elapsed = Duration.zero;
    }
    final hours = elapsed.inHours.toString().padLeft(2, '0');
    final minutes = elapsed.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = elapsed.inSeconds.remainder(60).toString().padLeft(2, '0');
    return Text(
      l10n.cashRegisterElapsed('$hours:$minutes:$seconds'),
      style: text.titleMedium?.copyWith(color: scheme.primary),
    );
  }
}
