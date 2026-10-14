import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/routing/app_router.dart';

import '../../../core/errors/app_notice.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../notification_copy.dart';
import '../view_models/notification_inbox_view_model.dart';
import '../view_models/notification_toasts.dart';

/// How long one live alert stays before it closes itself.
const notificationToastDuration = Duration(seconds: 10);

/// Draws live alerts on the navigator overlay, piled at the top.
///
/// The child is returned unchanged so ScaffoldMessenger error snackbars keep
/// working. Cards overlap, newest in front, each for 10 seconds. Mark as read
/// sits beside close. Mark all and view all sit once above the pile. Empty
/// space lets taps through.
class NotificationToastHost extends ConsumerStatefulWidget {
  const NotificationToastHost({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<NotificationToastHost> createState() =>
      _NotificationToastHostState();
}

class _NotificationToastHostState extends ConsumerState<NotificationToastHost> {
  final _timers = <String, Timer>{};
  List<AppNotificationView> _items = const [];
  OverlayEntry? _entry;
  String? _busyId;

  @override
  void dispose() {
    for (final timer in _timers.values) {
      timer.cancel();
    }
    _removeEntry();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(notificationInboxProvider);
    ref.listen(notificationToastsProvider, (previous, next) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) {
          return;
        }
        _sync(next);
      });
    });
    return widget.child;
  }

  void _sync(List<AppNotificationView> toasts) {
    final ids = toasts.map((view) => view.id.uuid).toSet();
    for (final id in _timers.keys.toList()) {
      if (!ids.contains(id)) {
        _timers.remove(id)?.cancel();
      }
    }
    for (final view in toasts) {
      _timers.putIfAbsent(view.id.uuid, () {
        return Timer(notificationToastDuration, () {
          if (!mounted) {
            return;
          }
          ref.read(notificationToastsProvider.notifier).dismiss(view.id);
        });
      });
    }
    _items = toasts;
    if (toasts.isEmpty) {
      _removeEntry();
      return;
    }
    final overlay = _navigatorOverlay();
    if (overlay == null) {
      return;
    }
    if (_entry == null) {
      _entry = OverlayEntry(builder: (context) => _pile(context));
      overlay.insert(_entry!);
    } else {
      _entry!.markNeedsBuild();
    }
  }

  void _removeEntry() {
    if (_entry?.mounted ?? false) {
      _entry!.remove();
    }
    _entry?.dispose();
    _entry = null;
  }

  OverlayState? _navigatorOverlay() {
    NavigatorState? navigator;
    void visit(Element element) {
      if (navigator != null) {
        return;
      }
      if (element is StatefulElement && element.state is NavigatorState) {
        navigator = element.state as NavigatorState;
        return;
      }
      element.visitChildren(visit);
    }

    context.visitChildElements(visit);
    return navigator?.overlay;
  }

  Future<void> _markRead(UuidValue id) async {
    if (_busyId != null) {
      return;
    }
    _busyId = id.uuid;
    _entry?.markNeedsBuild();
    try {
      await ref.read(notificationInboxProvider.notifier).markRead(id);
      if (!mounted) {
        return;
      }
      ref.read(notificationToastsProvider.notifier).dismiss(id);
    } catch (error) {
      if (!mounted) {
        return;
      }
      showMappedError(context, error);
    } finally {
      _busyId = null;
      _entry?.markNeedsBuild();
    }
  }

  Future<void> _markAll() async {
    if (_busyId != null) {
      return;
    }
    _busyId = '*';
    _entry?.markNeedsBuild();
    try {
      await ref.read(notificationInboxProvider.notifier).markAllRead();
      if (!mounted) {
        return;
      }
      ref.read(notificationToastsProvider.notifier).dismissAll();
    } catch (error) {
      if (!mounted) {
        return;
      }
      showMappedError(context, error);
    } finally {
      _busyId = null;
      _entry?.markNeedsBuild();
    }
  }

  void _viewAll() {
    if (_items.isEmpty) {
      return;
    }
    final buildingId = _items.first.buildingId.uuid;
    ref.read(appRouterProvider).go('/venues/$buildingId?notices=1');
    ref.read(notificationToastsProvider.notifier).dismissAll();
  }

  Widget _pile(BuildContext context) {
    final visible = _items.take(5).toList();
    final busy = _busyId != null;
    return Stack(
      children: [
        const Positioned.fill(child: IgnorePointer(child: SizedBox.expand())),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _PileActions(
                        busy: busy,
                        onMarkAll: _markAll,
                        onViewAll: _viewAll,
                      ),
                      const SizedBox(height: 8),
                      Stack(
                        children: [
                          for (
                            var index = visible.length - 1;
                            index >= 0;
                            index--
                          )
                            Padding(
                              padding: EdgeInsetsDirectional.only(
                                top: index * 10,
                                start: index * 8,
                                end: index * 8,
                              ),
                              child: _ToastCard(
                                key: ValueKey(visible[index].id.uuid),
                                view: visible[index],
                                busy: busy,
                                onClose: () => ref
                                    .read(notificationToastsProvider.notifier)
                                    .dismiss(visible[index].id),
                                onMarkRead: () => _markRead(visible[index].id),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PileActions extends StatelessWidget {
  const _PileActions({
    required this.busy,
    required this.onMarkAll,
    required this.onViewAll,
  });

  final bool busy;
  final VoidCallback onMarkAll;
  final VoidCallback onViewAll;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final style = TextButton.styleFrom(
      foregroundColor: scheme.primary,
      backgroundColor: const Color(0xE6FFFFFF),
      visualDensity: VisualDensity.compact,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      minimumSize: Size.zero,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      textStyle: Theme.of(context).textTheme.labelSmall,
    );
    return Row(
      children: [
        TextButton(
          style: style,
          onPressed: busy ? null : onMarkAll,
          child: Text(l10n.notificationMarkAllRead),
        ),
        const Spacer(),
        TextButton(
          style: style,
          onPressed: busy ? null : onViewAll,
          child: Text(l10n.notificationViewAll),
        ),
      ],
    );
  }
}

class _ToastCard extends StatelessWidget {
  const _ToastCard({
    super.key,
    required this.view,
    required this.busy,
    required this.onClose,
    required this.onMarkRead,
  });

  final AppNotificationView view;
  final bool busy;
  final VoidCallback onClose;
  final VoidCallback onMarkRead;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    return Material(
      elevation: 8,
      color: scheme.inverseSurface.withValues(alpha: 0.88),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 4, 4),
        child: Row(
          children: [
            Expanded(
              child: Text(
                notificationBody(l10n, view),
                style: TextStyle(color: scheme.onInverseSurface),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: scheme.inversePrimary,
                visualDensity: VisualDensity.compact,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: busy ? null : onMarkRead,
              child: Text(l10n.notificationMarkRead),
            ),
            IconButton(
              tooltip: l10n.close,
              visualDensity: VisualDensity.compact,
              onPressed: busy ? null : onClose,
              icon: Icon(Icons.close, color: scheme.onInverseSurface),
            ),
          ],
        ),
      ),
    );
  }
}
