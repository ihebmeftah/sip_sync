import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/errors/app_notice.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../core/widgets/pack_locked_action.dart';
import '../../../core/widgets/app_loader.dart';
import '../../../core/widgets/list_page_bar.dart';
import '../../../core/widgets/refresh_on_appear.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../view_models/categories_view_model.dart';
import '../widgets/category_dialog.dart';

/// Per-building category list; owner create/edit uses screen on mobile, dialog on wide.
class CategoriesListView extends ConsumerStatefulWidget {
  const CategoriesListView({super.key, required this.buildingId});

  final String buildingId;

  @override
  ConsumerState<CategoriesListView> createState() => _CategoriesListViewState();
}

class _CategoriesListViewState extends ConsumerState<CategoriesListView> {
  @override
  void initState() {
    super.initState();
    refreshCachedListOnAppear(
      this,
      providerAlreadyAlive: ref.exists(
        categoriesViewModelProvider(widget.buildingId),
      ),
      refresh: () => ref
          .read(categoriesViewModelProvider(widget.buildingId).notifier)
          .refresh(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final isOwner = ref.watch(appSessionStoreProvider).isOwner;
    final async = ref.watch(categoriesViewModelProvider(widget.buildingId));
    final addLocked = packCapReached(
      max: ref.watch(buildingSelectionProvider)?.pack.maxCategories,
      current: async.asData?.value.total ?? 0,
    );

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
                    PackLockedAction(
                      locked: addLocked,
                      child: FilledButton.icon(
                        style: FilledButton.styleFrom(
                          minimumSize: const Size(0, 44),
                        ),
                        onPressed: addLocked
                            ? null
                            : () => openCategoryForm(
                                context,
                                buildingId: widget.buildingId,
                              ),
                        icon: const Icon(Icons.add),
                        label: AppButtonLabel(l10n.addCategory),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              async.when(
                loading: () => const AppScreenLoader(),
                error: (error, _) => Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    LoadFailureNotice(error: error),
                    AppErrorBanner(
                      message: lookupError(l10n, mapError(error).l10nKey),
                    ),
                    TextButton(
                      onPressed: () => ref
                          .read(
                            categoriesViewModelProvider(
                              widget.buildingId,
                            ).notifier,
                          )
                          .refresh(),
                      child: Text(l10n.retry),
                    ),
                  ],
                ),
                data: (page) {
                  final categories = page.items;
                  if (categories.isEmpty) {
                    return AppSurfaceCard(
                      child: Text(
                        isOwner
                            ? l10n.categoriesEmptyOwner
                            : l10n.categoriesEmpty,
                      ),
                    );
                  }
                  return Column(
                    children: [
                      AppSurfaceCard(
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
                                  (category.description?.trim().isNotEmpty ??
                                          false)
                                      ? category.description!
                                      : l10n.noDescription,
                                ),
                                onTap: isOwner
                                    ? () => openCategoryForm(
                                        context,
                                        buildingId: widget.buildingId,
                                        existing: category,
                                      )
                                    : null,
                              ),
                          ],
                        ),
                      ),
                      ListPageBar(
                        total: page.total,
                        limit: page.limit,
                        offset: page.offset,
                        onPrevious: () => ref
                            .read(
                              categoriesViewModelProvider(
                                widget.buildingId,
                              ).notifier,
                            )
                            .previousPage(),
                        onNext: () => ref
                            .read(
                              categoriesViewModelProvider(
                                widget.buildingId,
                              ).notifier,
                            )
                            .nextPage(),
                      ),
                    ],
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
