import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/errors/error_mapper.dart';
import '../../../core/errors/form_validators.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../pack_money.dart';
import '../view_models/packs_view_model.dart';

/// Create or update a pack. A new venue starts on the free pack by itself.
class PackFormDialog extends ConsumerStatefulWidget {
  const PackFormDialog({super.key, this.pack});

  final PackView? pack;

  @override
  ConsumerState<PackFormDialog> createState() => _PackFormDialogState();
}

class _PackFormDialogState extends ConsumerState<PackFormDialog> {
  late final TextEditingController _code;
  late final TextEditingController _name;
  late final TextEditingController _monthly;
  late final TextEditingController _annual;
  late final TextEditingController _fee;
  late final TextEditingController _sort;
  late final TextEditingController _employees;
  late final TextEditingController _tables;
  late final TextEditingController _categories;
  late final TextEditingController _articles;
  late final TextEditingController _ingredients;
  late final TextEditingController _reservationsPerDay;
  late bool _public;
  late bool _enabled;
  late bool _discovery;
  late bool _qr;
  late bool _ordering;
  late bool _inventory;
  late bool _append;
  late bool _multiOrder;
  late bool _strict;
  late bool _customAccess;
  late bool _reservations;
  String? _errorKey;
  final _fieldErrors = <String, String>{};
  bool _saving = false;

  bool get _editing => widget.pack != null;

  @override
  void initState() {
    super.initState();
    final pack = widget.pack;
    final caps = pack?.capabilities;
    _code = TextEditingController(text: pack?.code ?? '');
    _name = TextEditingController(text: pack?.name ?? '');
    _monthly = TextEditingController(
      text: pack == null ? '' : formatMillimes(pack.monthlyMillimes),
    );
    _annual = TextEditingController(
      text: pack?.annualMillimes == null
          ? ''
          : formatMillimes(pack!.annualMillimes!),
    );
    _fee = TextEditingController(
      text: pack == null ? '0' : formatBps(pack.customerOrderFeeBps),
    );
    _sort = TextEditingController(text: '${pack?.sortOrder ?? 0}');
    _employees = TextEditingController(text: _limit(caps?.maxEmployees));
    _tables = TextEditingController(text: _limit(caps?.maxTables));
    _categories = TextEditingController(text: _limit(caps?.maxCategories));
    _articles = TextEditingController(text: _limit(caps?.maxArticles));
    _ingredients = TextEditingController(text: _limit(caps?.maxIngredients));
    _reservationsPerDay = TextEditingController(
      text: _limit(caps?.maxReservationsPerDay),
    );
    _public = pack?.isPublic ?? false;
    _enabled = pack?.isEnabled ?? true;
    _discovery = caps?.customerDiscovery ?? true;
    _qr = caps?.tableQr ?? true;
    _ordering = caps?.customerOrdering ?? false;
    _inventory = caps?.inventory ?? true;
    _append = caps?.allowAppendingItems ?? true;
    _multiOrder = caps?.tableMultiOrder ?? false;
    _strict = caps?.strictMode ?? false;
    _customAccess = caps?.customAccessProfiles ?? false;
    _reservations = caps?.reservations ?? false;
  }

  String _limit(int? value) => value == null ? '' : '$value';

  @override
  void dispose() {
    _code.dispose();
    _name.dispose();
    _monthly.dispose();
    _annual.dispose();
    _fee.dispose();
    _sort.dispose();
    _employees.dispose();
    _tables.dispose();
    _categories.dispose();
    _articles.dispose();
    _ingredients.dispose();
    _reservationsPerDay.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = ShadTheme.of(context);

    return ShadDialog(
      title: Text(_editing ? l10n.editPack : l10n.createPack),
      constraints: const BoxConstraints(maxWidth: 640),
      scrollable: true,
      actions: [
        ShadButton.outline(
          onPressed: _saving ? null : () => Navigator.of(context).pop(),
          child: Text(l10n.cancel),
        ),
        ShadButton(onPressed: _saving ? null : _submit, child: Text(l10n.save)),
      ],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_errorKey != null)
            AppErrorBanner(message: lookupError(l10n, _errorKey!)),
          if (_editing)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.lg),
              child: Text(widget.pack!.code, style: theme.textTheme.muted),
            )
          else
            AppTextField(
              controller: _code,
              label: l10n.packCode,
              prefixIcon: LucideIcons.hash,
              textInputAction: TextInputAction.next,
              error: _fieldErrors['code'],
              onChanged: (_) => _clearField('code'),
            ),
          AppTextField(
            controller: _name,
            label: l10n.packName,
            prefixIcon: LucideIcons.package,
            textInputAction: TextInputAction.next,
            error: _fieldErrors['name'],
            onChanged: (_) => _clearField('name'),
          ),
          AppTextField(
            controller: _monthly,
            label: l10n.packMonthly,
            prefixIcon: LucideIcons.coins,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            textInputAction: TextInputAction.next,
            error: _fieldErrors['monthly'],
            onChanged: (_) => _clearField('monthly'),
          ),
          AppTextField(
            controller: _annual,
            label: l10n.packAnnual,
            prefixIcon: LucideIcons.calendar,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            textInputAction: TextInputAction.next,
            error: _fieldErrors['annual'],
            onChanged: (_) => _clearField('annual'),
          ),
          Text(l10n.packAnnualHint, style: theme.textTheme.muted),
          const SizedBox(height: AppSpacing.lg),
          AppTextField(
            controller: _fee,
            label: l10n.packFee,
            prefixIcon: LucideIcons.percent,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            textInputAction: TextInputAction.next,
            error: _fieldErrors['fee'],
            onChanged: (_) => _clearField('fee'),
          ),
          Text(l10n.packFeeHint, style: theme.textTheme.muted),
          const SizedBox(height: AppSpacing.lg),
          AppTextField(
            controller: _sort,
            label: l10n.packSortOrder,
            prefixIcon: LucideIcons.arrowDownWideNarrow,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            error: _fieldErrors['sort'],
            onChanged: (_) => _clearField('sort'),
          ),
          _Flag(
            label: l10n.packPublic,
            hint: _public ? l10n.packPublicHint : l10n.packPrivateHint,
            value: _public,
            onChanged: (value) => setState(() => _public = value),
          ),
          _Flag(
            label: l10n.packEnabled,
            hint: l10n.packEnabledHint,
            value: _enabled,
            onChanged: (value) => setState(() => _enabled = value),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(l10n.packLimits, style: theme.textTheme.small),
          const SizedBox(height: AppSpacing.xs),
          Text(l10n.packUnlimitedHint, style: theme.textTheme.muted),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            controller: _employees,
            label: l10n.capMaxEmployees,
            hint: l10n.capMaxEmployeesHint,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            error: _fieldErrors['employees'],
            onChanged: (_) => _clearField('employees'),
          ),
          AppTextField(
            controller: _tables,
            label: l10n.capMaxTables,
            hint: l10n.capMaxTablesHint,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            error: _fieldErrors['tables'],
            onChanged: (_) => _clearField('tables'),
          ),
          AppTextField(
            controller: _categories,
            label: l10n.capMaxCategories,
            hint: l10n.capMaxCategoriesHint,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            error: _fieldErrors['categories'],
            onChanged: (_) => _clearField('categories'),
          ),
          AppTextField(
            controller: _articles,
            label: l10n.capMaxArticles,
            hint: l10n.capMaxArticlesHint,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            error: _fieldErrors['articles'],
            onChanged: (_) => _clearField('articles'),
          ),
          AppTextField(
            controller: _ingredients,
            label: l10n.capMaxIngredients,
            hint: l10n.capMaxIngredientsHint,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            error: _fieldErrors['ingredients'],
            onChanged: (_) => _clearField('ingredients'),
          ),
          AppTextField(
            controller: _reservationsPerDay,
            label: l10n.capMaxReservations,
            hint: l10n.capMaxReservationsHint,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            error: _fieldErrors['reservations'],
            onChanged: (_) => _clearField('reservations'),
          ),
          Text(l10n.packCapabilities, style: theme.textTheme.small),
          const SizedBox(height: AppSpacing.sm),
          _Flag(
            label: l10n.capCustomerDiscovery,
            hint: l10n.capCustomerDiscoveryHint,
            value: _discovery,
            onChanged: (value) => setState(() => _discovery = value),
          ),
          _Flag(
            label: l10n.capTableQr,
            hint: l10n.capTableQrHint,
            value: _qr,
            onChanged: (value) => setState(() => _qr = value),
          ),
          _Flag(
            label: l10n.capCustomerOrdering,
            hint: l10n.capCustomerOrderingHint,
            value: _ordering,
            onChanged: (value) => setState(() => _ordering = value),
          ),
          _Flag(
            label: l10n.capInventory,
            hint: l10n.capInventoryHint,
            value: _inventory,
            onChanged: (value) => setState(() => _inventory = value),
          ),
          _Flag(
            label: l10n.capAllowAppending,
            hint: l10n.capAllowAppendingHint,
            value: _append,
            onChanged: (value) => setState(() => _append = value),
          ),
          _Flag(
            label: l10n.capTableMultiOrder,
            hint: l10n.capTableMultiOrderHint,
            value: _multiOrder,
            onChanged: (value) => setState(() => _multiOrder = value),
          ),
          _Flag(
            label: l10n.capStrictMode,
            hint: l10n.capStrictModeHint,
            value: _strict,
            onChanged: (value) => setState(() => _strict = value),
          ),
          _Flag(
            label: l10n.capCustomAccess,
            hint: l10n.capCustomAccessHint,
            value: _customAccess,
            onChanged: (value) => setState(() => _customAccess = value),
          ),
          _Flag(
            label: l10n.capReservations,
            hint: l10n.capReservationsHint,
            value: _reservations,
            onChanged: (value) => setState(() => _reservations = value),
          ),
        ],
      ),
    );
  }

  void _clearField(String key) {
    if (_fieldErrors.remove(key) != null) {
      setState(() {});
    }
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context)!;
    final name = _name.text.trim();
    final code = _code.text.trim().toLowerCase();
    final monthly = tryParseMillimes(_monthly.text);
    final annualText = _annual.text.trim();
    final annual = annualText.isEmpty ? null : tryParseMillimes(annualText);
    final fee = tryParsePercentToBps(_fee.text);
    final sort = int.tryParse(_sort.text.trim());
    final employees = tryParseLimit(_employees.text);
    final tables = tryParseLimit(_tables.text);
    final categories = tryParseLimit(_categories.text);
    final articles = tryParseLimit(_articles.text);
    final ingredients = tryParseLimit(_ingredients.text);
    final reservationsPerDay = tryParseLimit(_reservationsPerDay.text);
    final errors = <String, String>{};
    if (!_editing) {
      final codeError = FormValidators.packCode(l10n, code);
      if (codeError != null) {
        errors['code'] = codeError;
      }
    }
    final nameError = FormValidators.packName(l10n, name);
    if (nameError != null) {
      errors['name'] = nameError;
    }
    if (monthly == null) {
      errors['monthly'] = l10n.validationPackMoney;
    }
    if (annualText.isNotEmpty && annual == null) {
      errors['annual'] = l10n.validationPackMoney;
    }
    if (fee == null) {
      errors['fee'] = l10n.validationPackFee;
    }
    if (sort == null) {
      errors['sort'] = l10n.validationPackSort;
    }
    if (employees.invalid) {
      errors['employees'] = l10n.validationPackLimit;
    }
    if (tables.invalid) {
      errors['tables'] = l10n.validationPackLimit;
    }
    if (categories.invalid) {
      errors['categories'] = l10n.validationPackLimit;
    }
    if (articles.invalid) {
      errors['articles'] = l10n.validationPackLimit;
    }
    if (ingredients.invalid) {
      errors['ingredients'] = l10n.validationPackLimit;
    }
    if (reservationsPerDay.invalid) {
      errors['reservations'] = l10n.validationPackLimit;
    }
    if (errors.isNotEmpty) {
      setState(() {
        _fieldErrors
          ..clear()
          ..addAll(errors);
      });
      return;
    }
    final monthlyMillimes = monthly!;
    final feeBps = fee!;
    final sortOrder = sort!;

    final capabilities = PackCapabilities(
      maxEmployees: employees.value,
      maxTables: tables.value,
      maxCategories: categories.value,
      maxArticles: articles.value,
      maxIngredients: ingredients.value,
      customerDiscovery: _discovery,
      tableQr: _qr,
      customerOrdering: _ordering,
      inventory: _inventory,
      allowAppendingItems: _append,
      tableMultiOrder: _multiOrder,
      strictMode: _strict,
      customAccessProfiles: _customAccess,
      reservations: _reservations,
      maxReservationsPerDay: reservationsPerDay.value,
    );

    setState(() {
      _saving = true;
      _errorKey = null;
      _fieldErrors.clear();
    });
    final notifier = ref.read(packsViewModelProvider.notifier);
    String? errorKey;
    PackView? created;
    if (_editing) {
      errorKey = await notifier.save(
        PackUpdate(
          id: widget.pack!.id,
          name: name,
          monthlyMillimes: monthlyMillimes,
          annualMillimes: annual,
          customerOrderFeeBps: feeBps,
          isPublic: _public,
          isEnabled: _enabled,
          sortOrder: sortOrder,
          capabilities: capabilities,
        ),
      );
    } else {
      final result = await notifier.create(
        PackCreate(
          code: code,
          name: name,
          monthlyMillimes: monthlyMillimes,
          annualMillimes: annual,
          customerOrderFeeBps: feeBps,
          isPublic: _public,
          isEnabled: _enabled,
          sortOrder: sortOrder,
          capabilities: capabilities,
        ),
      );
      errorKey = result.errorKey;
      created = result.pack;
    }
    if (!mounted) {
      return;
    }
    if (errorKey == null) {
      Navigator.of(context).pop(created);
      return;
    }
    setState(() {
      _saving = false;
      _errorKey = errorKey;
    });
  }
}

class _Flag extends StatelessWidget {
  const _Flag({
    required this.label,
    required this.value,
    required this.onChanged,
    this.hint,
  });

  final String label;
  final String? hint;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: theme.textTheme.small),
                if (hint != null) Text(hint!, style: theme.textTheme.muted),
              ],
            ),
          ),
          ShadSwitch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}
