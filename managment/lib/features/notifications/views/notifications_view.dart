import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/errors/app_notice.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/paging/list_paging.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../core/widgets/app_loader.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../view_models/notification_inbox_view_model.dart';

/// Stored alerts for the signed-in owner or employee.
///
/// Stays on [buildingId]: the venue the owner has open, or the building the
/// employee works in. The chips can limit that to this month or unread rows.
class NotificationsView extends ConsumerStatefulWidget {
  const NotificationsView({super.key, required this.buildingId});

  final String buildingId;

  @override
  ConsumerState<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends ConsumerState<NotificationsView> {
  String? _errorKey;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _focus());
  }

  @override
  void didUpdateWidget(covariant NotificationsView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.buildingId != widget.buildingId) {
      _focus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final inbox = ref.watch(notificationInboxProvider);
    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Align(
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
                  AppFilledButton(
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
                        AppFilledButton(label: l10n.retry, onPressed: _focus),
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
                        ? Center(child: Text(l10n.notificationsReady))
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
                                  page.items.length +
                                  (page.loadingMore ? 1 : 0),
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
                                return ListTile(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      AppRadii.md,
                                    ),
                                    side: BorderSide(
                                      color: scheme.outlineVariant,
                                    ),
                                  ),
                                  title: Text(
                                    _body(l10n, row),
                                    style: text.titleMedium?.copyWith(
                                      fontWeight: row.read
                                          ? FontWeight.w500
                                          : FontWeight.w700,
                                    ),
                                  ),
                                  subtitle: Text('${row.venueName} · $when'),
                                  onTap: () => _open(row),
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
        final l10n = AppLocalizations.of(context)!;
        showAppSnackBar(context, lookupError(l10n, mapError(error).l10nKey));
      }
    }
  }

  Future<void> _markAll() =>
      _run(() => ref.read(notificationInboxProvider.notifier).markAllRead());

  String _body(AppLocalizations l10n, AppNotificationView row) {
    if (row.kind == AppNotificationKind.reservation &&
        row.reservationStatus == ReservationStatus.cancelled) {
      return l10n.notificationReservationCancelled;
    }
    if (row.kind == AppNotificationKind.reservation) {
      return l10n.notificationReservationAccepted;
    }
    return row.venueName;
  }

  Future<void> _open(AppNotificationView row) async {
    try {
      if (!row.read) {
        await ref.read(notificationInboxProvider.notifier).markRead(row.id);
      }
    } catch (error) {
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        showAppSnackBar(context, lookupError(l10n, mapError(error).l10nKey));
      }
      return;
    }
    if (!mounted) {
      return;
    }
    switch (row.kind) {
      case AppNotificationKind.reservation:
        ReservationsRoute(buildingId: row.buildingId.uuid).go(context);
      case AppNotificationKind.order:
      case AppNotificationKind.orderItem:
        OrderDetailRoute(
          buildingId: row.buildingId.uuid,
          orderId: row.subjectId.uuid,
        ).go(context);
    }
  }
}

class _Filters extends StatelessWidget {
  const _Filters({
    required this.page,
    required this.onMonth,
    required this.onUnread,
    required this.onMarkAll,
  });

  final NotificationInboxState page;
  final ValueChanged<bool> onMonth;
  final ValueChanged<bool> onUnread;
  final VoidCallback? onMarkAll;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
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
                AppFilterChip(
                  label: l10n.notificationThisMonth,
                  selected: page.currentMonth,
                  onSelected: onMonth,
                ),
                const SizedBox(width: AppSpacing.sm),
                AppFilterChip(
                  label: l10n.notificationUnreadOnly,
                  selected: page.unreadOnly,
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
