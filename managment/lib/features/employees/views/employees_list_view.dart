import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../view_models/employees_view_model.dart';

class EmployeesListView extends ConsumerWidget {
  const EmployeesListView({super.key, required this.buildingId});

  final String buildingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final isOwner = ref.watch(appSessionStoreProvider).isOwner;
    final async = ref.watch(employeesViewModelProvider(buildingId));

    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppBreakpoints.pageMax),
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.xl),
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(l10n.navEmployees, style: text.headlineSmall),
                  ),
                  if (isOwner) ...[
                    TextButton(
                      onPressed: () => AccessProfilesRoute(
                        buildingId: buildingId,
                      ).go(context),
                      child: Text(l10n.navAccessProfiles),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    FilledButton.icon(
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(0, 44),
                      ),
                      onPressed: () => EmployeeCreateRoute(
                        buildingId: buildingId,
                      ).go(context),
                      icon: const Icon(Icons.add),
                      label: AppButtonLabel(l10n.addEmployee),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              if (!isOwner)
                AppErrorBanner(message: l10n.employeesOwnerOnly)
              else
                async.when(
                  loading: () => const LinearProgressIndicator(),
                  error: (error, _) => Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppErrorBanner(
                        message: lookupError(l10n, mapError(error).l10nKey),
                      ),
                      TextButton(
                        onPressed: () => ref
                            .read(
                              employeesViewModelProvider(buildingId).notifier,
                            )
                            .refresh(),
                        child: Text(l10n.retry),
                      ),
                    ],
                  ),
                  data: (employees) {
                    if (employees.isEmpty) {
                      return AppSurfaceCard(
                        child: Text(l10n.employeesEmptyBuilding),
                      );
                    }
                    return AppSurfaceCard(
                      child: Column(
                        children: [
                          for (final employee in employees)
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: CircleAvatar(
                                backgroundColor: scheme.secondaryContainer,
                                foregroundColor: scheme.onSecondaryContainer,
                                child: Text(
                                  employee.firstName.isEmpty
                                      ? '?'
                                      : employee.firstName.characters.first,
                                ),
                              ),
                              title: Text(
                                '${employee.firstName} ${employee.lastName}',
                              ),
                              subtitle: Text(
                                employee.accessName == null ||
                                        employee.accessName!.isEmpty
                                    ? employee.username
                                    : '${employee.username} · ${employee.accessName}',
                              ),
                              trailing: Chip(
                                label: Text(
                                  employee.isEnabled
                                      ? l10n.accountEnabled
                                      : l10n.accountDisabled,
                                ),
                              ),
                              onTap: () => EmployeeDetailsRoute(
                                buildingId: buildingId,
                                employeeId: employee.id.uuid,
                              ).go(context),
                            ),
                        ],
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
