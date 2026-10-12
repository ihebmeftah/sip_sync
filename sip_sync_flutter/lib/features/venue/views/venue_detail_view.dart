import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/errors/error_mapper.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../core/widgets/app_loader.dart';
import '../../../core/widgets/page_band.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../discover/venue_distance.dart';
import '../../home/widgets/venue_card.dart';
import '../../orders/views/customer_orders_view.dart';
import '../menu_price.dart';
import '../../notifications/view_models/notification_inbox_view_model.dart';
import '../view_models/customer_order_view_model.dart';
import '../view_models/seated_table_view_model.dart';
import '../view_models/venue_detail_view_model.dart';
import '../widgets/menu_image_slot.dart';
import '../widgets/venue_chrome.dart';
import '../widgets/venue_visit_bar.dart';
import 'venue_menu_view.dart';
import 'venue_notices_view.dart';
import 'venue_profile_view.dart';

/// A venue visit: overview, menu, scan, orders, and profile on one bar.
class VenueDetailView extends ConsumerStatefulWidget {
  const VenueDetailView({super.key, required this.buildingId});

  final String buildingId;

  @override
  ConsumerState<VenueDetailView> createState() => _VenueDetailViewState();
}

class _VenueDetailViewState extends ConsumerState<VenueDetailView> {
  var _tab = VenueVisitTab.overview;
  var _notices = false;

  void _select(VenueVisitTab tab) {
    setState(() {
      _tab = tab;
      _notices = false;
    });
  }

  void _openScan() {
    final l10n = AppLocalizations.of(context)!;
    final open = ref.read(openCustomerOrderProvider).asData?.value;
    final openHere = open != null && open.buildingId.uuid == widget.buildingId;
    if (openHere) {
      final messenger = ScaffoldMessenger.of(context);
      messenger.hideCurrentSnackBar();
      messenger.showSnackBar(SnackBar(content: Text(l10n.scanDisabled)));
      return;
    }
    TableScanRoute(
      changing: true,
      buildingId: widget.buildingId,
    ).push(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final detail = ref.watch(venueDetailViewModelProvider(widget.buildingId));
    final venueName = detail.asData?.value.venue.name;
    final open = ref.watch(openCustomerOrderProvider).asData?.value;
    final unread =
        ref.watch(notificationInboxProvider).asData?.value.unread ?? 0;
    final stay =
        open != null &&
        open.status == OrderStatus.progress &&
        open.buildingId.uuid == widget.buildingId;
    return PopScope(
      canPop: !stay,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop || !stay) {
          return;
        }
        final messenger = ScaffoldMessenger.of(context);
        messenger.hideCurrentSnackBar();
        messenger.showSnackBar(
          SnackBar(content: Text(l10n.orderKeepsYouHere)),
        );
      },
      child: Scaffold(
        body: Column(
          children: [
            SafeArea(
              bottom: false,
              child: PageBand(
                child: _VisitHeader(
                  noticesOpen: _notices,
                  unread: unread,
                  showBack: !stay,
                  onNotices: () => setState(() => _notices = !_notices),
                ),
              ),
            ),
            Expanded(
              child: _notices
                  ? VenueNoticesView(buildingId: widget.buildingId)
                  : switch (_tab) {
                      VenueVisitTab.overview => detail.when(
                        loading: () => const AppScreenLoader(),
                        error: (error, _) => _VenueMessage(
                          message: lookupError(l10n, mapError(error).l10nKey),
                          onRetry: () => ref.invalidate(
                            venueDetailViewModelProvider(widget.buildingId),
                          ),
                        ),
                        data: (page) => _DetailBody(
                          buildingId: widget.buildingId,
                          page: page,
                          onOpenMenu: () => _select(VenueVisitTab.menu),
                        ),
                      ),
                      VenueVisitTab.menu => VenueMenuView(
                        buildingId: widget.buildingId,
                        venueName: venueName,
                        embedded: true,
                      ),
                      VenueVisitTab.orders => VenueOrdersPane(
                        buildingId: widget.buildingId,
                      ),
                      VenueVisitTab.profile => const VenueProfileView(),
                    },
            ),
            PageBand(
              child: VenueVisitBar(
                tab: _tab,
                onSelect: _select,
                onScan: _openScan,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VisitHeader extends StatelessWidget {
  const _VisitHeader({
    required this.noticesOpen,
    required this.unread,
    required this.showBack,
    required this.onNotices,
  });

  final bool noticesOpen;
  final int unread;
  final bool showBack;
  final VoidCallback onNotices;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: AppSpacing.xs),
      child: Row(
        children: [
          if (showBack) const VenueBackButton(),
          const LocaleMenuButton(),
          const Spacer(),
          IconButton(
            tooltip: l10n.notifications,
            onPressed: onNotices,
            isSelected: noticesOpen,
            icon: Badge(
              isLabelVisible: unread > 0,
              label: Text(unread > 99 ? '99+' : '$unread'),
              child: Icon(
                AppIcons.notifications,
                color: noticesOpen ? scheme.primary : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailBody extends ConsumerStatefulWidget {
  const _DetailBody({
    required this.buildingId,
    required this.page,
    required this.onOpenMenu,
  });

  final String buildingId;
  final CustomerVenueDetail page;
  final VoidCallback onOpenMenu;

  @override
  ConsumerState<_DetailBody> createState() => _DetailBodyState();
}

class _DetailBodyState extends ConsumerState<_DetailBody> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _announceSeat());
  }

  void _announceSeat() {
    if (!mounted) {
      return;
    }
    final notice = ref.read(seatedTableProvider);
    if (notice == null ||
        !notice.announce ||
        notice.table.buildingId.uuid != widget.buildingId) {
      return;
    }
    _showChanged(notice.table.number);
    ref.read(seatedTableProvider.notifier).clearAnnouncement();
  }

  void _showChanged(int number) {
    final l10n = AppLocalizations.of(context)!;
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.moss,
        content: Text(
          l10n.tableChanged(number),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.paper,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(seatedTableProvider, (previous, next) {
      if (next == null ||
          !next.announce ||
          next.table.buildingId.uuid != widget.buildingId) {
        return;
      }
      _showChanged(next.table.number);
      ref.read(seatedTableProvider.notifier).clearAnnouncement();
    });

    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final venue = widget.page.venue;
    final notice = ref.watch(seatedTableProvider);
    final seated =
        notice != null && notice.table.buildingId.uuid == widget.buildingId
        ? notice.table
        : null;
    final open = ref.watch(openCustomerOrderProvider).asData?.value;
    final openHere = open != null && open.buildingId.uuid == widget.buildingId;
    void openMenu() => widget.onOpenMenu();

    return Column(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AppBreakpoints.pageMax,
              ),
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.lg,
                      AppSpacing.sm,
                      AppSpacing.lg,
                      AppSpacing.xl,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        venueTypeIcon(venue.type),
                                        color: scheme.primary,
                                      ),
                                      const SizedBox(width: AppSpacing.sm),
                                      Flexible(
                                        child: Text(
                                          venueTypeLabel(l10n, venue.type),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: text.labelLarge?.copyWith(
                                            color: scheme.primary,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: AppSpacing.md),
                                  Text(
                                    venue.name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: text.displaySmall,
                                  ),
                                  const SizedBox(height: AppSpacing.md),
                                  _MetaLine(
                                    icon: AppIcons.place,
                                    label: venue.address,
                                  ),
                                  const SizedBox(height: AppSpacing.sm),
                                  _MetaLine(
                                    icon: AppIcons.schedule,
                                    label: l10n.hoursRange(
                                      formatClock(venue.openingMinutes),
                                      formatClock(venue.closingMinutes),
                                    ),
                                  ),
                                  const SizedBox(height: AppSpacing.sm),
                                  _MetaLine(
                                    icon: AppIcons.phone,
                                    label: venue.phoneNumber,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _TablesBand(
                                    tables: widget.page.availableTables,
                                    seated: seated,
                                  ),
                                  const SizedBox(height: AppSpacing.md),
                                  AppTonalButton(
                                    label: l10n.reserveNow,
                                    icon: AppIcons.table,
                                    onPressed:
                                        widget.page.reservationsClosedByVenue
                                        ? null
                                        : () => VenueReserveRoute(
                                            id: widget.buildingId,
                                          ).go(context),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        if (openHere) ...[
                          _OpenOrderBand(order: open),
                          const SizedBox(height: AppSpacing.xl),
                        ],
                        const SizedBox(height: AppSpacing.xl),
                        Text(l10n.previewCategories, style: text.headlineSmall),
                        const SizedBox(height: AppSpacing.md),
                        if (widget.page.categories.isEmpty)
                          Text(
                            l10n.emptyMenuPreview,
                            style: text.bodyMedium?.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
                          )
                        else
                          SizedBox(
                            height: 76,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.page.categories.length + 1,
                              separatorBuilder: (_, _) =>
                                  const SizedBox(width: AppSpacing.md),
                              itemBuilder: (context, index) {
                                if (index == widget.page.categories.length) {
                                  return _SeeAllCard(onTap: openMenu);
                                }
                                final category = widget.page.categories[index];
                                return _CategoryPreview(
                                  title: category.name,
                                  subtitle: l10n.articleCount(
                                    category.articleCount,
                                  ),
                                );
                              },
                            ),
                          ),
                        const SizedBox(height: AppSpacing.xl),
                        Text(l10n.previewArticles, style: text.headlineSmall),
                        const SizedBox(height: AppSpacing.md),
                        if (widget.page.articles.isEmpty)
                          Text(
                            l10n.emptyMenuPreview,
                            style: text.bodyMedium?.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
                          )
                        else
                          SizedBox(
                            height: 168,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.page.articles.length + 1,
                              separatorBuilder: (_, _) =>
                                  const SizedBox(width: AppSpacing.md),
                              itemBuilder: (context, index) {
                                if (index == widget.page.articles.length) {
                                  return _SeeAllCard(onTap: openMenu);
                                }
                                final article = widget.page.articles[index];
                                final ingredients = formatIngredientLine(
                                  article.ingredientNames,
                                );
                                return _ArticlePreview(
                                  title: article.name,
                                  subtitle: ingredients.isEmpty
                                      ? article.categoryName
                                      : ingredients,
                                  price: formatMenuPrice(
                                    article.price,
                                    widget.page.currencyCode,
                                  ),
                                );
                              },
                            ),
                          ),
                        const SizedBox(height: AppSpacing.xl),
                        if (!widget.page.customerOrdering &&
                            !widget.page.orderingClosedByVenue)
                          Text(
                            l10n.orderingUnavailable,
                            textAlign: TextAlign.center,
                            style: text.bodyMedium?.copyWith(
                              color: scheme.error,
                            ),
                          ),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _OpenOrderBand extends StatelessWidget {
  const _OpenOrderBand({required this.order});

  final CustomerOrderView order;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.sand,
        borderRadius: BorderRadius.circular(AppRadii.lg),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.lg,
          AppSpacing.md,
          AppSpacing.sm,
          AppSpacing.md,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.openOrderNote,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: text.titleMedium?.copyWith(
                      color: scheme.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    l10n.openOrderLead,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: text.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    formatMenuPrice(order.totalAmount, order.currencyCode),
                    style: text.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () => CustomerOrderRoute(
                id: order.buildingId.uuid,
                orderId: order.id.uuid,
              ).push(context),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(l10n.openOrderDetails),
                  const SizedBox(width: AppSpacing.xs),
                  Transform.flip(
                    flipX: Directionality.of(context) == TextDirection.rtl,
                    child: const Icon(AppIcons.forward, size: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TablesBand extends StatelessWidget {
  const _TablesBand({required this.tables, required this.seated});

  final List<CustomerTablePreview> tables;
  final CustomerSeatedTable? seated;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.mist,
        borderRadius: BorderRadius.circular(AppRadii.lg),
        border: Border.all(color: AppColors.moss.withValues(alpha: 0.28)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Icon(AppIcons.table, color: AppColors.moss, size: 32),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    l10n.availableTables(tables.length),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: text.headlineSmall?.copyWith(color: AppColors.moss),
                  ),
                ),
              ],
            ),
            if (seated != null) ...[
              const SizedBox(height: AppSpacing.md),
              Text(
                l10n.yourTable,
                style: text.labelLarge?.copyWith(
                  color: AppColors.moss,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                l10n.seatedAt(seated!.number),
                style: text.titleMedium?.copyWith(color: AppColors.moss),
              ),
              Text(
                l10n.seatCount(seated!.maxSeats),
                style: text.bodySmall?.copyWith(color: AppColors.moss),
              ),
            ],
            if (tables.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.md),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  for (final table in tables)
                    _TableChip(
                      table: table,
                      yours: seated != null && seated!.tableId == table.id,
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _TableChip extends StatelessWidget {
  const _TableChip({required this.table, required this.yours});

  final CustomerTablePreview table;
  final bool yours;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final foreground = yours ? AppColors.paper : AppColors.moss;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: yours ? AppColors.moss : AppColors.field,
        borderRadius: BorderRadius.circular(AppRadii.md),
        border: Border.all(color: AppColors.moss.withValues(alpha: 0.35)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                final iconSpace = yours ? 16 + AppSpacing.xs : 0.0;
                final textMax = constraints.maxWidth.isFinite
                    ? (constraints.maxWidth - iconSpace).clamp(
                        0.0,
                        constraints.maxWidth,
                      )
                    : double.infinity;
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: textMax),
                      child: Text(
                        l10n.tableNumber(table.number),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: text.labelLarge?.copyWith(
                          color: foreground,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    if (yours) ...[
                      const SizedBox(width: AppSpacing.xs),
                      Icon(AppIcons.check, size: 16, color: foreground),
                    ],
                  ],
                );
              },
            ),
            Text(
              l10n.seatCount(table.maxSeats),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: text.bodySmall?.copyWith(color: foreground),
            ),
            if (table.reservationPhase == ReservationPhase.soon)
              Text(
                l10n.reservationSoon,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: text.bodySmall?.copyWith(color: foreground),
              ),
            if (table.reservationPhase == ReservationPhase.holding)
              Text(
                l10n.reservationHolding,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: text.bodySmall?.copyWith(color: foreground),
              ),
          ],
        ),
      ),
    );
  }
}

class _MetaLine extends StatelessWidget {
  const _MetaLine({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: scheme.onSurfaceVariant),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
          ),
        ),
      ],
    );
  }
}

class _CategoryPreview extends StatelessWidget {
  const _CategoryPreview({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: 168,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: scheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(AppRadii.md),
          border: Border.all(color: scheme.outlineVariant),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: text.titleSmall,
              ),
              Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: text.labelLarge?.copyWith(color: scheme.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ArticlePreview extends StatelessWidget {
  const _ArticlePreview({
    required this.title,
    required this.subtitle,
    required this.price,
  });

  final String title;
  final String subtitle;
  final String price;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: 168,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: scheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(AppRadii.md),
          border: Border.all(color: scheme.outlineVariant),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MenuImageSlot(size: 52),
              const SizedBox(height: AppSpacing.sm),
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: text.titleSmall,
              ),
              Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: text.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
              ),
              const Spacer(),
              Text(
                price,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: text.labelLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SeeAllCard extends StatelessWidget {
  const _SeeAllCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: 112,
      child: Material(
        color: scheme.primaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.md),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
              child: Text(
                l10n.seeAll,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: text.labelLarge?.copyWith(
                  color: scheme.onPrimaryContainer,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _VenueMessage extends StatelessWidget {
  const _VenueMessage({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          const Spacer(),
          AppErrorBanner(message: message),
          AppTonalButton(label: l10n.retry, onPressed: onRetry),
          const Spacer(),
        ],
      ),
    );
  }
}
