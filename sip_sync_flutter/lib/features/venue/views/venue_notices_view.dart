import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/errors/app_notice.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/paging/list_paging.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../core/widgets/app_loader.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../notifications/notification_copy.dart';
import '../../notifications/view_models/notification_inbox_view_model.dart';

/// Stored alerts for this customer. A tap marks the row read and opens it.
///
/// Opens on [buildingId]. The chips can widen that to every venue, this
/// month, or unread rows.
class VenueNoticesView extends ConsumerStatefulWidget {
  const VenueNoticesView({super.key, required this.buildingId});

  final String buildingId;

  @override
  ConsumerState<VenueNoticesView> createState() => _VenueNoticesViewState();
}

class _VenueNoticesViewState extends ConsumerState<VenueNoticesView> {
  String? _errorKey;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _focus());
  }

  @override
  void didUpdateWidget(covariant VenueNoticesView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.buildingId != widget.buildingId) {
      _focus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final inbox = ref.watch(notificationInboxProvider);
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: AppBreakpoints.pageMax),
        child: inbox.when(
          loading: () => const AppScreenLoader(),
          error: (error, _) => Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              children: [
                AppErrorBanner(
                  message: lookupError(l10n, mapError(error).l10nKey),
                ),
                AppTonalButton(
                  label: l10n.retry,
                  onPressed: () => ref.invalidate(notificationInboxProvider),
                ),
              ],
            ),
          ),
          data: (page) {
            if (page.appliedBuildingId != widget.buildingId) {
              if (_errorKey != null) {
                return Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    children: [
                      AppErrorBanner(message: lookupError(l10n, _errorKey!)),
                      AppTonalButton(label: l10n.retry, onPressed: _focus),
                    ],
                  ),
                );
              }
              return const AppScreenLoader();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Filters(
                  page: page,
                  onThisBuilding: (value) => _run(
                    () => ref
                        .read(notificationInboxProvider.notifier)
                        .setThisBuilding(value),
                  ),
                  onMonth: (value) => _run(
                    () => ref
                        .read(notificationInboxProvider.notifier)
                        .setCurrentMonth(value),
                  ),
                  onUnread: (value) => _run(
                    () => ref
                        .read(notificationInboxProvider.notifier)
                        .setUnreadOnly(value),
                  ),
                  onMarkAll: page.markingAll ? null : _markAll,
                ),
                Expanded(
                  child: page.items.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(AppSpacing.xl),
                          child: Column(
                            children: [
                              const Spacer(),
                              Icon(
                                AppIcons.notifications,
                                size: 56,
                                color: scheme.primary,
                              ),
                              const SizedBox(height: AppSpacing.lg),
                              Text(
                                l10n.notifications,
                                style: text.headlineSmall,
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              Text(
                                l10n.notificationsReady,
                                textAlign: TextAlign.center,
                                style: text.bodyLarge?.copyWith(
                                  color: scheme.onSurfaceVariant,
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        )
                      : NotificationListener<ScrollNotification>(
                          onNotification: (notification) {
                            if (nearListEnd(notification)) {
                              ref
                                  .read(notificationInboxProvider.notifier)
                                  .loadMore();
                            }
                            return false;
                          },
                          child: ListView.separated(
                            padding: const EdgeInsets.all(AppSpacing.lg),
                            itemCount:
                                page.items.length + (page.loadingMore ? 1 : 0),
                            separatorBuilder: (_, _) =>
                                const SizedBox(height: AppSpacing.sm),
                            itemBuilder: (context, index) {
                              if (index >= page.items.length) {
                                return const AppScreenLoader(compact: true);
                              }
                              final row = page.items[index];
                              final when = DateFormat.yMMMd(
                                Localizations.localeOf(context).toString(),
                              ).add_Hm().format(row.createdAt.toLocal());
                              return Material(
                                color: row.read
                                    ? scheme.surfaceContainerLowest
                                    : scheme.primaryContainer.withValues(
                                        alpha: 0.35,
                                      ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppRadii.lg,
                                  ),
                                  side: BorderSide(
                                    color: scheme.outlineVariant,
                                  ),
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: InkWell(
                                  onTap: () => _open(row),
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                      AppSpacing.lg,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          notificationBody(l10n, row),
                                          style: text.titleMedium?.copyWith(
                                            fontWeight: row.read
                                                ? FontWeight.w500
                                                : FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(height: AppSpacing.xs),
                                        Text(
                                          '${row.venueName} · $when',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: text.bodySmall?.copyWith(
                                            color: scheme.onSurfaceVariant,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _focus() async {
    try {
      await ref
          .read(notificationInboxProvider.notifier)
          .focusBuilding(UuidValue.fromString(widget.buildingId));
      if (mounted) {
        setState(() => _errorKey = null);
      }
    } catch (error) {
      if (mounted) {
        setState(() => _errorKey = mapError(error).l10nKey);
      }
    }
  }

  Future<void> _run(Future<void> Function() action) async {
    try {
      await action();
    } catch (error) {
      if (mounted) {
        showMappedError(context, error);
      }
    }
  }

  Future<void> _markAll() => _run(
    () => ref.read(notificationInboxProvider.notifier).markAllRead(),
  );

  Future<void> _open(AppNotificationView row) async {
    try {
      if (!row.read) {
        await ref.read(notificationInboxProvider.notifier).markRead(row.id);
      }
    } catch (error) {
      if (mounted) {
        showMappedError(context, error);
      }
      return;
    }
    if (!mounted) {
      return;
    }
    switch (row.kind) {
      case AppNotificationKind.reservation:
        VenueReserveRoute(id: row.buildingId.uuid).go(context);
      case AppNotificationKind.order:
      case AppNotificationKind.orderItem:
        CustomerOrderRoute(
          id: row.buildingId.uuid,
          orderId: row.subjectId.uuid,
        ).go(context);
    }
  }
}

class _Filters extends StatelessWidget {
  const _Filters({
    required this.page,
    required this.onThisBuilding,
    required this.onMonth,
    required this.onUnread,
    required this.onMarkAll,
  });

  final NotificationInboxState page;
  final ValueChanged<bool> onThisBuilding;
  final ValueChanged<bool> onMonth;
  final ValueChanged<bool> onUnread;
  final VoidCallback? onMarkAll;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                FilterChip(
                  label: Text(l10n.notificationThisVenue),
                  selected: page.thisBuilding,
                  showCheckmark: false,
                  selectedColor: scheme.primaryContainer,
                  onSelected: (_) => onThisBuilding(true),
                ),
                const SizedBox(width: AppSpacing.sm),
                FilterChip(
                  label: Text(l10n.allVenues),
                  selected: !page.thisBuilding,
                  showCheckmark: false,
                  selectedColor: scheme.primaryContainer,
                  onSelected: (_) => onThisBuilding(false),
                ),
                const SizedBox(width: AppSpacing.sm),
                FilterChip(
                  label: Text(l10n.notificationThisMonth),
                  selected: page.currentMonth,
                  showCheckmark: false,
                  selectedColor: scheme.primaryContainer,
                  onSelected: onMonth,
                ),
                const SizedBox(width: AppSpacing.sm),
                FilterChip(
                  label: Text(l10n.notificationUnreadOnly),
                  selected: page.unreadOnly,
                  showCheckmark: false,
                  selectedColor: scheme.primaryContainer,
                  onSelected: onUnread,
                ),
              ],
            ),
          ),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: TextButton(
              onPressed: onMarkAll,
              child: Text(l10n.notificationMarkAllRead),
            ),
          ),
        ],
      ),
    );
  }
}
