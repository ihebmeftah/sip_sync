import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/errors/app_notice.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../core/widgets/app_loader.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../products/view_models/articles_view_model.dart';
import '../../products/view_models/categories_view_model.dart';
import '../view_models/order_draft_view_model.dart';
import '../view_models/orders_view_model.dart';
import '../widgets/order_item_info_sheet.dart';

/// Pick article units (each + adds another order line of that article).
class OrderCreateArticlesView extends ConsumerStatefulWidget {
  const OrderCreateArticlesView({super.key, required this.buildingId});

  final String buildingId;

  @override
  ConsumerState<OrderCreateArticlesView> createState() =>
      _OrderCreateArticlesViewState();
}

class _OrderCreateArticlesViewState
    extends ConsumerState<OrderCreateArticlesView> {
  final _search = TextEditingController();
  String? _categoryId;
  bool _confirming = false;
  String? _errorKey;

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  Future<void> _confirm() async {
    final draft = ref.read(orderDraftViewModelProvider(widget.buildingId));
    if (draft.totalArticleCount == 0) return;
    if (!draft.isAppending && draft.venueTableId == null) return;

    setState(() {
      _confirming = true;
      _errorKey = null;
    });

    try {
      final lines = ref
          .read(orderDraftViewModelProvider(widget.buildingId).notifier)
          .toCreateLines();
      final OrderView order;
      if (draft.isAppending) {
        order = await ref
            .read(ordersViewModelProvider(widget.buildingId).notifier)
            .addItems(orderId: draft.appendOrderId!, items: lines);
      } else {
        order = await ref
            .read(ordersViewModelProvider(widget.buildingId).notifier)
            .createOrder(venueTableId: draft.venueTableId, items: lines);
      }
      if (!mounted) return;
      showSavedSnackBar(context);
      // Navigate first; keep _confirming true so clearing the draft cannot
      // trigger the empty-table redirect back to the floor map.
      OrderDetailRoute(
        buildingId: widget.buildingId,
        orderId: order.id.uuid,
      ).go(context);
      ref.read(orderDraftViewModelProvider(widget.buildingId).notifier).clear();
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _errorKey = captureError(context, error);
        _confirming = false;
      });
    }
  }

  void _resetArticles() {
    ref
        .read(orderDraftViewModelProvider(widget.buildingId).notifier)
        .clearArticles();
  }

  void _changeTable() {
    setState(() => _confirming = true);
    ref
        .read(orderDraftViewModelProvider(widget.buildingId).notifier)
        .changeTable();
    TablesRoute(buildingId: widget.buildingId).go(context);
  }

  /// Abandon create and open the floor map in normal view (not pick mode).
  void _cancelCreate() {
    setState(() => _confirming = true);
    ref.read(orderDraftViewModelProvider(widget.buildingId).notifier).clear();
    TablesRoute(buildingId: widget.buildingId).go(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final currency = ref.watch(buildingSelectionProvider)?.currencyCode ?? '';
    final draft = ref.watch(orderDraftViewModelProvider(widget.buildingId));
    final categoriesAsync = ref.watch(
      categoryCatalogProvider(widget.buildingId),
    );
    final articlesAsync = ref.watch(
      articlesViewModelProvider(widget.buildingId),
    );
    final categories = categoriesAsync.asData?.value ?? const [];
    final articles = articlesAsync.asData?.value ?? const [];
    final query = _search.text.trim().toLowerCase();
    final filtered = articles.where((a) {
      if (_categoryId != null && a.categoryId.uuid != _categoryId) {
        return false;
      }
      if (query.isNotEmpty && !a.name.toLowerCase().contains(query)) {
        return false;
      }
      return true;
    }).toList();

    if (!_confirming && draft.venueTableId == null && !draft.isAppending) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted || _confirming) return;
        ref
            .read(orderDraftViewModelProvider(widget.buildingId).notifier)
            .beginCreate();
        TablesRoute(buildingId: widget.buildingId).go(context);
      });
    }

    final draftVm = ref.read(
      orderDraftViewModelProvider(widget.buildingId).notifier,
    );

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(right: AppSpacing.md),
          child: Center(
            child: Badge(
              isLabelVisible: draft.totalArticleCount > 0,
              label: Text('${draft.totalArticleCount}'),
              child: Icon(Icons.shopping_bag_outlined, color: scheme.onSurface),
            ),
          ),
        ),
        title: Text(
          draft.tableNumber == null
              ? l10n.orderAppendArticles
              : '${l10n.orderAppendArticles} · ${l10n.orderTableNumber(draft.tableNumber!)}',
        ),
        actions: [
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: scheme.error,
              side: BorderSide(color: scheme.error.withValues(alpha: 0.5)),
            ),
            onPressed: _confirming ? null : _cancelCreate,
            icon: const Icon(Icons.close, size: 18),
            label: AppButtonLabel(l10n.orderCancelCreate),
          ),
        ],
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppBreakpoints.pageMax),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.xl,
                  AppSpacing.lg,
                  AppSpacing.xl,
                  AppSpacing.sm,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: [
                        OutlinedButton.icon(
                          onPressed: _confirming || draft.totalArticleCount == 0
                              ? null
                              : _resetArticles,
                          icon: const Icon(Icons.restart_alt, size: 18),
                          label: AppButtonLabel(l10n.orderResetArticles),
                        ),
                        if (!draft.isAppending)
                          OutlinedButton.icon(
                            onPressed: _confirming ? null : _changeTable,
                            icon: const Icon(
                              Icons.table_restaurant_outlined,
                              size: 18,
                            ),
                            label: AppButtonLabel(l10n.orderChangeTable),
                          ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextField(
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      controller: _search,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        hintText: l10n.orderSearchArticles,
                        prefixIcon: const Icon(Icons.search),
                        border: const OutlineInputBorder(),
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          FilterChip(
                            selected: _categoryId == null,
                            label: Text(l10n.orderAllCategories),
                            onSelected: (_) =>
                                setState(() => _categoryId = null),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          for (final category in categories) ...[
                            FilterChip(
                              selected: _categoryId == category.id.uuid,
                              label: Text(category.name),
                              onSelected: (_) => setState(
                                () => _categoryId = category.id.uuid,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                          ],
                        ],
                      ),
                    ),
                    if (_errorKey != null) ...[
                      const SizedBox(height: AppSpacing.md),
                      AppErrorBanner(message: lookupError(l10n, _errorKey!)),
                    ],
                  ],
                ),
              ),
              Expanded(
                child: articlesAsync.when(
                  loading: () => const AppScreenLoader(),
                  error: (error, _) => Padding(
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        LoadFailureNotice(error: error),
                        AppErrorBanner(
                          message: lookupError(l10n, mapError(error).l10nKey),
                        ),
                      ],
                    ),
                  ),
                  data: (_) {
                    if (filtered.isEmpty) {
                      return Center(child: Text(l10n.orderNoArticlesMatch));
                    }
                    return ListView.separated(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.xl,
                        AppSpacing.sm,
                        AppSpacing.xl,
                        100,
                      ),
                      itemCount: filtered.length,
                      separatorBuilder: (_, _) =>
                          const SizedBox(height: AppSpacing.sm),
                      itemBuilder: (context, index) {
                        final article = filtered[index];
                        final count = draft.unitCounts[article.id.uuid] ?? 0;
                        return AppSurfaceCard(
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(article.name, style: text.titleSmall),
                                    const SizedBox(height: 2),
                                    Text(
                                      formatOrderMoney(article.price, currency),
                                      style: text.bodySmall?.copyWith(
                                        color: scheme.primary,
                                      ),
                                    ),
                                    if (article
                                        .outOfStockIngredientNames
                                        .isNotEmpty) ...[
                                      const SizedBox(height: 2),
                                      Text(
                                        l10n.orderIngredientOutOfStock(
                                          article.outOfStockIngredientNames
                                              .join(', '),
                                        ),
                                        style: text.bodySmall?.copyWith(
                                          color: scheme.error,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              IconButton.filledTonal(
                                tooltip: l10n.orderRemoveUnit,
                                onPressed: count <= 0
                                    ? null
                                    : () => draftVm.decrement(article.id),
                                style: IconButton.styleFrom(
                                  foregroundColor: scheme.error,
                                  disabledForegroundColor: scheme.onSurface
                                      .withValues(alpha: 0.3),
                                ),
                                icon: const Icon(Icons.remove),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.sm,
                                ),
                                child: Text(
                                  '$count',
                                  style: text.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              IconButton.filled(
                                tooltip: l10n.orderAddUnit,
                                onPressed: () => draftVm.increment(article.id),
                                icon: const Icon(Icons.add),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: FilledButton.icon(
            style: FilledButton.styleFrom(minimumSize: const Size(0, 48)),
            onPressed: _confirming || draft.totalArticleCount == 0
                ? null
                : _confirm,
            icon: _confirming
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: AppBusyIndicator(),
                  )
                : Badge(
                    isLabelVisible: draft.totalArticleCount > 0,
                    label: Text('${draft.totalArticleCount}'),
                    child: const Icon(Icons.check),
                  ),
            label: AppButtonLabel(l10n.orderConfirm),
          ),
        ),
      ),
    );
  }
}
