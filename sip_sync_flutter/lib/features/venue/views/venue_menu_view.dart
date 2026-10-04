import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/errors/app_notice.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/paging/list_paging.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../menu_price.dart';
import '../view_models/order_cart_view_model.dart';
import '../view_models/venue_menu_view_model.dart';
import '../widgets/menu_image_slot.dart';
import '../widgets/venue_chrome.dart';

/// Full menu: a sticky category rail and one flowing section per category.
class VenueMenuView extends ConsumerStatefulWidget {
  const VenueMenuView({super.key, required this.buildingId, this.venueName});

  final String buildingId;
  final String? venueName;

  @override
  ConsumerState<VenueMenuView> createState() => _VenueMenuViewState();
}

class _VenueMenuViewState extends ConsumerState<VenueMenuView> {
  final _sectionKeys = <GlobalKey>[];
  var _selected = 0;
  var _lockSelection = false;

  void _ensureKeys(int count) {
    if (_sectionKeys.length == count) {
      return;
    }
    _sectionKeys
      ..clear()
      ..addAll(List.generate(count, (_) => GlobalKey()));
    if (_selected >= count) {
      _selected = 0;
    }
  }

  Future<void> _scrollTo(int index) async {
    setState(() {
      _selected = index;
      _lockSelection = true;
    });
    await ref
        .read(venueMenuViewModelProvider(widget.buildingId).notifier)
        .loadUntil(index);
    if (!mounted) {
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final target = index < _sectionKeys.length
          ? _sectionKeys[index].currentContext
          : null;
      if (target == null) {
        if (mounted) {
          setState(() => _lockSelection = false);
        }
        return;
      }
      Scrollable.ensureVisible(
        target,
        duration: const Duration(milliseconds: 420),
        curve: Curves.easeOutCubic,
        alignment: 0.08,
      ).whenComplete(() {
        if (mounted) {
          setState(() => _lockSelection = false);
        }
      });
    });
  }

  bool _followScroll(ScrollNotification notification) {
    if (nearListEnd(notification)) {
      ref
          .read(venueMenuViewModelProvider(widget.buildingId).notifier)
          .loadMore();
    }
    if (_lockSelection || notification.metrics.axis != Axis.vertical) {
      return false;
    }
    var next = _selected;
    for (var i = 0; i < _sectionKeys.length; i++) {
      final box =
          _sectionKeys[i].currentContext?.findRenderObject() as RenderBox?;
      if (box == null || !box.hasSize) {
        continue;
      }
      if (box.localToGlobal(Offset.zero).dy < 220) {
        next = i;
      }
    }
    if (next != _selected) {
      setState(() => _selected = next);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final menu = ref.watch(venueMenuViewModelProvider(widget.buildingId));
    return Scaffold(
      body: SafeArea(
        child: menu.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => _MenuMessage(
            message: lookupError(l10n, mapError(error).l10nKey),
            onRetry: () =>
                ref.invalidate(venueMenuViewModelProvider(widget.buildingId)),
          ),
          data: (page) {
            _ensureKeys(page.categories.length);
            return _MenuBody(
              buildingId: widget.buildingId,
              venueName: widget.venueName,
              menu: page,
              selected: _selected,
              sectionKeys: _sectionKeys,
              onSelect: (index) {
                _scrollTo(index);
              },
              onScroll: _followScroll,
            );
          },
        ),
      ),
    );
  }
}

class _MenuBody extends ConsumerWidget {
  const _MenuBody({
    required this.buildingId,
    required this.venueName,
    required this.menu,
    required this.selected,
    required this.sectionKeys,
    required this.onSelect,
    required this.onScroll,
  });

  final String buildingId;
  final String? venueName;
  final VenueMenuState menu;
  final int selected;
  final List<GlobalKey> sectionKeys;
  final ValueChanged<int> onSelect;
  final bool Function(ScrollNotification notification) onScroll;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final cart = ref.watch(orderCartProvider(buildingId));
    final title = (venueName == null || venueName!.trim().isEmpty)
        ? l10n.menu
        : venueName!.trim();
    final sections = menu.visibleSections;
    if (menu.categories.isEmpty) {
      return Column(
        children: [
          const Align(
            alignment: AlignmentDirectional.centerStart,
            child: VenueBackButton(),
          ),
          const Spacer(),
          Icon(AppIcons.menuBook, size: 56, color: scheme.primary),
          const SizedBox(height: AppSpacing.lg),
          Text(l10n.menu, style: text.headlineMedium),
          const SizedBox(height: AppSpacing.sm),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
            child: Text(
              l10n.emptyMenu,
              textAlign: TextAlign.center,
              style: text.bodyLarge?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ),
          const Spacer(),
        ],
      );
    }
    final menuScroll = NotificationListener<ScrollNotification>(
      onNotification: onScroll,
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.sm,
                    AppSpacing.sm,
                    AppSpacing.lg,
                    AppSpacing.md,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const VenueBackButton(),
                      if (!menu.customerOrdering)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            AppSpacing.md,
                            0,
                            AppSpacing.md,
                            AppSpacing.md,
                          ),
                          child: Text(
                            l10n.orderingUnavailable,
                            style: text.bodyMedium?.copyWith(
                              color: scheme.error,
                            ),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                        ),
                        child: Text(
                          l10n.menu,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: text.labelLarge?.copyWith(
                            color: scheme.primary,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                        ),
                        child: Text(
                          title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: text.displaySmall,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _RailDelegate(
                  selected: selected,
                  categories: menu.categories,
                  onSelect: onSelect,
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.lg,
                  AppSpacing.lg,
                  AppSpacing.xxl,
                ),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    children: [
                      for (var index = 0; index < sections.length; index++)
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: index == sections.length - 1
                                ? 0
                                : AppSpacing.xl,
                          ),
                          child: _MenuSection(
                            key: sectionKeys[index],
                            buildingId: buildingId,
                            section: sections[index],
                            currencyCode: menu.currencyCode,
                          ),
                        ),
                      if (menu.loadingMore)
                        const Padding(
                          padding: EdgeInsets.only(top: AppSpacing.lg),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    return Column(
      children: [
        Expanded(child: menuScroll),
        if (cart.isNotEmpty && menu.customerOrdering)
          _CartBar(
            buildingId: buildingId,
            venueName: title,
            currencyCode: menu.currencyCode,
            units: cartUnits(cart),
            total: formatMenuPrice(cartTotal(cart), menu.currencyCode),
          ),
      ],
    );
  }
}

class _CartBar extends StatelessWidget {
  const _CartBar({
    required this.buildingId,
    required this.venueName,
    required this.currencyCode,
    required this.units,
    required this.total,
  });

  final String buildingId;
  final String venueName;
  final String currencyCode;
  final int units;
  final String total;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    return Material(
      color: AppColors.paper,
      elevation: 8,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.md,
            AppSpacing.lg,
            AppSpacing.md,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  l10n.cartSummary(units, total),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: text.titleMedium,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              AppFilledButton(
                expand: false,
                label: l10n.passOrder,
                onPressed: () => OrderReviewRoute(
                  id: buildingId,
                  venueName: venueName,
                  currencyCode: currencyCode,
                ).push(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RailDelegate extends SliverPersistentHeaderDelegate {
  _RailDelegate({
    required this.selected,
    required this.categories,
    required this.onSelect,
  });

  final int selected;
  final List<CustomerCategoryPreview> categories;
  final ValueChanged<int> onSelect;

  @override
  double get minExtent => 64;

  @override
  double get maxExtent => 64;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          bottom: BorderSide(
            color: overlapsContent ? scheme.outlineVariant : Colors.transparent,
          ),
        ),
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        itemCount: categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) {
          return Align(
            alignment: Alignment.center,
            child: _CategoryChip(
              key: ValueKey('menu-chip-$index'),
              label: categories[index].name,
              selected: index == selected,
              onTap: () => onSelect(index),
            ),
          );
        },
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _RailDelegate oldDelegate) {
    return oldDelegate.selected != selected ||
        oldDelegate.categories != categories;
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final radius = BorderRadius.circular(999);
    return Material(
      color: selected ? scheme.primary : scheme.surfaceContainerLowest,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: BorderSide(
          color: selected ? scheme.primary : scheme.outlineVariant,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 200),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.sm,
            ),
            child: Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: text.labelLarge?.copyWith(
                color: selected ? scheme.onPrimary : scheme.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuSection extends StatelessWidget {
  const _MenuSection({
    super.key,
    required this.buildingId,
    required this.section,
    required this.currencyCode,
  });

  final String buildingId;
  final CustomerMenuSection section;
  final String currencyCode;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          section.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: text.headlineMedium,
        ),
        if (section.description != null && section.description!.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            section.description!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
          ),
        ],
        const SizedBox(height: AppSpacing.md),
        if (section.articles.isEmpty)
          Text(
            l10n.emptyMenuSection,
            style: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
          )
        else
          for (final article in section.articles) ...[
            _ArticleRow(
              buildingId: buildingId,
              article: article,
              currencyCode: currencyCode,
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
      ],
    );
  }
}

class _ArticleRow extends ConsumerWidget {
  const _ArticleRow({
    required this.buildingId,
    required this.article,
    required this.currencyCode,
  });

  final String buildingId;
  final CustomerArticlePreview article;
  final String currencyCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final quantity = ref
        .watch(orderCartProvider(buildingId))
        .where((line) => line.articleId == article.id.uuid)
        .fold(0, (sum, line) => sum + line.quantity);
    final cart = ref.read(orderCartProvider(buildingId).notifier);
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final ingredients = formatIngredientLine(article.ingredientNames);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadii.lg),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadii.lg),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ColoredBox(
                color: scheme.primary,
                child: const SizedBox(width: 5),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const MenuImageSlot(size: 64),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              article.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: text.titleMedium,
                            ),
                            if (article.description != null &&
                                article.description!.isNotEmpty) ...[
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                article.description!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: text.bodyMedium?.copyWith(
                                  color: scheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                            if (ingredients.isNotEmpty) ...[
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                ingredients,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: text.bodySmall?.copyWith(
                                  color: scheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                            const SizedBox(height: AppSpacing.sm),
                            Row(
                              children: [
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: scheme.primaryContainer,
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: AppSpacing.md,
                                      vertical: AppSpacing.sm,
                                    ),
                                    child: Text(
                                      formatMenuPrice(
                                        article.price,
                                        currencyCode,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: text.labelLarge?.copyWith(
                                        color: scheme.onPrimaryContainer,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                if (quantity > 0) ...[
                                  _QtyButton(
                                    tooltip: l10n.removeArticle,
                                    icon: AppIcons.remove,
                                    onPressed: () =>
                                        cart.remove(article.id.uuid),
                                  ),
                                  SizedBox(
                                    width: 28,
                                    child: Text(
                                      '$quantity',
                                      textAlign: TextAlign.center,
                                      style: text.titleMedium,
                                    ),
                                  ),
                                ],
                                _QtyButton(
                                  tooltip: l10n.addArticle,
                                  icon: AppIcons.add,
                                  onPressed: () {
                                    final ordering = ref
                                        .read(
                                          venueMenuViewModelProvider(
                                            buildingId,
                                          ),
                                        )
                                        .asData
                                        ?.value
                                        .customerOrdering;
                                    if (ordering == false) {
                                      showAppSnackBar(
                                        context,
                                        l10n.errorPackFeatureOrdering,
                                      );
                                      return;
                                    }
                                    cart.add(article);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  const _QtyButton({
    required this.tooltip,
    required this.icon,
    required this.onPressed,
  });

  final String tooltip;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      visualDensity: VisualDensity.compact,
      icon: Icon(icon),
    );
  }
}

class _MenuMessage extends StatelessWidget {
  const _MenuMessage({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          const Align(
            alignment: AlignmentDirectional.centerStart,
            child: VenueBackButton(),
          ),
          const Spacer(),
          AppErrorBanner(message: message),
          AppTonalButton(label: l10n.retry, onPressed: onRetry),
          const Spacer(),
        ],
      ),
    );
  }
}
