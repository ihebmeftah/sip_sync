import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../view_models/categories_view_model.dart';
import '../widgets/category_dialog.dart';

/// Per-building category list with owner create/edit dialogs.
class CategoriesListView extends ConsumerWidget {
  const CategoriesListView({super.key, required this.buildingId});

  final String buildingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final isOwner = ref.watch(appSessionStoreProvider).isOwner;
    final async = ref.watch(categoriesViewModelProvider(buildingId));

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l10n.navCategories, style: text.headlineSmall),
                        const SizedBox(height: AppSpacing.xs),
                        Text(l10n.categoriesHint, style: text.bodyMedium),
                      ],
                    ),
                  ),
                  if (isOwner)
                    FilledButton.icon(
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(0, 44),
                      ),
                      onPressed: () =>
                          showCategoryDialog(context, buildingId: buildingId),
                      icon: const Icon(Icons.add),
                      label: Text(l10n.addCategory),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
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
                            categoriesViewModelProvider(buildingId).notifier,
                          )
                          .refresh(),
                      child: Text(l10n.retry),
                    ),
                  ],
                ),
                data: (categories) {
                  if (categories.isEmpty) {
                    return AppSurfaceCard(
                      child: Text(
                        isOwner
                            ? l10n.categoriesEmptyOwner
                            : l10n.categoriesEmpty,
                      ),
                    );
                  }
                  return AppSurfaceCard(
                    child: Column(
                      children: [
                        for (final category in categories)
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(
                              backgroundColor: scheme.secondaryContainer,
                              foregroundColor: scheme.onSecondaryContainer,
                              child: const Icon(Icons.category_outlined),
                            ),
                            title: Text(category.name),
                            subtitle: Text(
                              (category.description?.trim().isNotEmpty ?? false)
                                  ? category.description!
                                  : l10n.noDescription,
                            ),
                            onTap: isOwner
                                ? () => showCategoryDialog(
                                    context,
                                    buildingId: buildingId,
                                    existing: category,
                                  )
                                : null,
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
