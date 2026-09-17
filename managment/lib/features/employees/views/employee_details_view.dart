import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/error_mapper.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../view_models/employee_details_view_model.dart';

class EmployeeDetailsPage extends ConsumerWidget {
  const EmployeeDetailsPage({
    super.key,
    required this.buildingId,
    required this.authUserId,
  });

  final String buildingId;
  final String authUserId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final async = ref.watch(employeeDetailsViewModelProvider(authUserId));
    final text = Theme.of(context).textTheme;

    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppBreakpoints.formMax),
          child: async.when(
            loading: () => const Padding(
              padding: EdgeInsets.all(AppSpacing.xxl),
              child: LinearProgressIndicator(),
            ),
            error: (error, _) => Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: AppErrorBanner(
                message: lookupError(l10n, mapError(error).l10nKey),
              ),
            ),
            data: (employee) => ListView(
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
                      onPressed: () => EmployeeEditRoute(
                        buildingId: buildingId,
                        authUserId: authUserId,
                      ).go(context),
                      child: Text(l10n.editEmployee),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
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
                        onChanged: (value) => ref
                            .read(
                              employeeDetailsViewModelProvider(
                                authUserId,
                              ).notifier,
                            )
                            .setEnabled(value),
                      ),
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
                        title: Text(l10n.phone),
                        subtitle: Text(employee.phoneNumber),
                      ),
                      Wrap(
                        spacing: AppSpacing.sm,
                        children: [
                          for (final role in employee.roles)
                            Chip(label: Text(role)),
                        ],
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
