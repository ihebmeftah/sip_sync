import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../view_models/articles_view_model.dart';
import '../view_models/categories_view_model.dart';
import '../widgets/article_composition_dialog.dart';
import '../widgets/article_dialog.dart';

/// Per-building article list with owner create/edit dialogs.
class ArticlesListView extends ConsumerWidget {
  const ArticlesListView({super.key, required this.buildingId});

  final String buildingId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final isOwner = ref.watch(appSessionStoreProvider).isOwner;
    final currency = ref.watch(buildingSelectionProvider)?.currencyCode ?? '';
    final async = ref.watch(articlesViewModelProvider(buildingId));
    final categories =
        ref.watch(categoriesViewModelProvider(buildingId)).asData?.value ??
        const <MenuCategoryView>[];

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
                        Text(l10n.navArticles, style: text.headlineSmall),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          l10n.articlesHint,
                          style: text.bodyMedium,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  if (isOwner) ...[
                    const SizedBox(width: AppSpacing.sm),
                    FilledButton.icon(
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(0, 44),
                      ),
                      onPressed: () =>
                          openArticleForm(context, buildingId: buildingId),
                      icon: const Icon(Icons.add),
                      label: AppButtonLabel(l10n.addArticle),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              if (isOwner && categories.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                  child: AppErrorBanner(message: l10n.articlesNeedCategory),
                ),
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
                          .read(articlesViewModelProvider(buildingId).notifier)
                          .refresh(),
                      child: Text(l10n.retry),
                    ),
                  ],
                ),
                data: (articles) {
                  if (articles.isEmpty) {
                    return AppSurfaceCard(
                      child: Text(
                        isOwner ? l10n.articlesEmptyOwner : l10n.articlesEmpty,
                      ),
                    );
                  }
                  return AppSurfaceCard(
                    child: Column(
                      children: [
                        for (final article in articles)
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: CircleAvatar(
                                  backgroundColor: scheme.secondaryContainer,
                                  foregroundColor: scheme.onSecondaryContainer,
                                  child: const Icon(
                                    Icons.restaurant_menu_outlined,
                                  ),
                                ),
                                title: Text(article.name),
                                subtitle: Text(
                                  [
                                    article.categoryName,
                                    if (article.description
                                            ?.trim()
                                            .isNotEmpty ??
                                        false)
                                      article.description!,
                                  ].join(' · '),
                                ),
                                trailing: Text(
                                  _formatMoney(article.price, currency),
                                  style: text.titleSmall?.copyWith(
                                    color: scheme.primary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                onTap: isOwner
                                    ? () => openArticleForm(
                                        context,
                                        buildingId: buildingId,
                                        existing: article,
                                      )
                                    : null,
                              ),
                              TextButton.icon(
                                onPressed: () => openArticleComposition(
                                  context,
                                  buildingId: buildingId,
                                  article: article,
                                ),
                                icon: const Icon(Icons.blender_outlined),
                                label: Text(
                                  article.compositionLineCount == 0
                                      ? l10n.compositionNone
                                      : l10n.compositionCount(
                                          article.compositionLineCount,
                                        ),
                                ),
                              ),
                              Divider(),
                            ],
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

  String _formatMoney(double price, String currency) {
    final amount = price == price.roundToDouble()
        ? '${price.round()}'
        : price.toStringAsFixed(2);
    if (currency.isEmpty) {
      return amount;
    }
    return '$amount $currency';
  }
}
