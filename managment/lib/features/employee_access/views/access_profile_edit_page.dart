import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/errors/error_mapper.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../core/widgets/app_loader.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../view_models/access_profiles_view_model.dart';
import 'access_profile_form_view.dart';

/// Loads an access profile from the building list, then shows the edit form.
class AccessProfileEditPage extends ConsumerWidget {
  const AccessProfileEditPage({
    super.key,
    required this.buildingId,
    required this.accessId,
  });

  final String buildingId;
  final String accessId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final async = ref.watch(accessCatalogProvider(buildingId));

    return async.when(
      loading: () => ColoredBox(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: const AppScreenLoader(),
      ),
      error: (error, _) => ColoredBox(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppErrorBanner(
                message: lookupError(l10n, mapError(error).l10nKey),
              ),
              TextButton(
                onPressed: () =>
                    ref.invalidate(accessCatalogProvider(buildingId)),
                child: Text(l10n.retry),
              ),
            ],
          ),
        ),
      ),
      data: (profiles) {
        EmployeeAccessView? existing;
        for (final p in profiles) {
          if (p.id.uuid == accessId) {
            existing = p;
            break;
          }
        }
        if (existing == null) {
          return ColoredBox(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: AppErrorBanner(message: l10n.errorNotFound),
            ),
          );
        }
        return AccessProfileFormView(
          buildingId: buildingId,
          existing: existing,
        );
      },
    );
  }
}
