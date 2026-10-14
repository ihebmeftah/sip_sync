import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/error_mapper.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../core/widgets/app_loader.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../widgets/employee_access_flags.dart';
import '../view_models/employee_details_view_model.dart';

class EmployeeDetailsPage extends ConsumerStatefulWidget {
  const EmployeeDetailsPage({
    super.key,
    required this.buildingId,
    required this.employeeId,
  });

  final String buildingId;
  final String employeeId;

  @override
  ConsumerState<EmployeeDetailsPage> createState() =>
      _EmployeeDetailsPageState();
}

class _EmployeeDetailsPageState extends ConsumerState<EmployeeDetailsPage> {
  var _toggling = false;
  String? _actionErrorKey;

  Future<void> _onEnabledChanged(bool value) async {
    if (_toggling) {
      return;
    }
    setState(() {
      _toggling = true;
      _actionErrorKey = null;
    });
    try {
      await ref
          .read(employeeDetailsViewModelProvider(widget.employeeId).notifier)
          .setEnabled(value);
    } catch (error) {
      if (mounted) {
        setState(() => _actionErrorKey = mapError(error).l10nKey);
      }
    } finally {
      if (mounted) {
        setState(() => _toggling = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final async = ref.watch(
      employeeDetailsViewModelProvider(widget.employeeId),
    );
    final text = Theme.of(context).textTheme;
    final employee = async.asData?.value;

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
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        l10n.employeeProfile,
                        style: text.headlineSmall,
                      ),
                    ),
                    FilledButton.tonal(
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(0, 40),
                        visualDensity: VisualDensity.compact,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () => EmployeeEditRoute(
                        buildingId: widget.buildingId,
                        employeeId: widget.employeeId,
                      ).go(context),
                      child: Text(l10n.editEmployee),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                if (async.isLoading && employee == null)
                  const AppScreenLoader(),
                if (async.hasError && employee == null) ...[
                  AppErrorBanner(
                    message: lookupError(l10n, mapError(async.error!).l10nKey),
                  ),
                  TextButton(
                    onPressed: () => ref.invalidate(
                      employeeDetailsViewModelProvider(widget.employeeId),
                    ),
                    child: Text(l10n.retry),
                  ),
                ],
                if (_actionErrorKey != null) ...[
                  AppErrorBanner(message: lookupError(l10n, _actionErrorKey!)),
                  const SizedBox(height: AppSpacing.md),
                ],
                if (employee != null)
                  AppSurfaceCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(l10n.accountEnabled),
                          subtitle: Text(
                            employee.isEnabled
                                ? l10n.accountEnabledHint
                                : l10n.accountDisabledHint,
                          ),
                          value: employee.isEnabled,
                          onChanged: _toggling ? null : _onEnabledChanged,
                        ),
                        if (_toggling) const AppScreenLoader(),
                        const Divider(),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(l10n.firstName),
                          subtitle: Text(employee.firstName),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(l10n.lastName),
                          subtitle: Text(employee.lastName),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(l10n.username),
                          subtitle: Text(employee.username),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(l10n.accessProfile),
                          subtitle: employee.accessId == null
                              ? Text(l10n.accessProfileNone)
                              : null,
                        ),
                        if (employee.accessId != null)
                          _AccessBody(accessId: employee.accessId!.uuid),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(l10n.phone),
                          subtitle: Text(employee.phoneNumber),
                        ),
                      ],
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

class _AccessBody extends ConsumerWidget {
  const _AccessBody({required this.accessId});

  final String accessId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final access = ref.watch(employeeAssignedAccessProvider(accessId));
    return access.when(
      loading: () => const Padding(
        padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: AppScreenLoader(),
      ),
      error: (error, _) => Text(lookupError(l10n, mapError(error).l10nKey)),
      data: (profile) => EmployeeAccessFlags(access: profile),
    );
  }
}
