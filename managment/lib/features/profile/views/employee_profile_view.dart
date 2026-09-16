import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/error_mapper.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../view_models/employee_profile_view_model.dart';

class EmployeeProfileView extends ConsumerWidget {
  const EmployeeProfileView({super.key, required this.authUserId});

  final String authUserId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final async = ref.watch(employeeProfileViewModelProvider(authUserId));
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
                AppSurfaceCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l10n.employeeProfile, style: text.headlineSmall),
                      const SizedBox(height: AppSpacing.lg),
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
                        title: Text(l10n.email),
                        subtitle: Text(employee.email),
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
