import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';

part 'notification_toasts.g.dart';

/// Live alerts piled at the top of the screen. The inbox keeps the history.
@Riverpod(keepAlive: true)
class NotificationToasts extends _$NotificationToasts {
  @override
  List<AppNotificationView> build() {
    ref.listen(appSessionStoreProvider, (previous, next) {
      if (!next.isSignedIn && state.isNotEmpty) {
        state = const [];
      }
    });
    return const [];
  }

  /// Adds [view] unless that alert is already on screen.
  void push(AppNotificationView view) {
    if (state.any((row) => row.id == view.id)) {
      return;
    }
    state = [view, ...state];
  }

  /// Removes one snackbar. The inbox row stays until it is opened.
  void dismiss(UuidValue id) {
    state = [
      for (final row in state)
        if (row.id != id) row,
    ];
  }

  /// Closes every snackbar. The inbox rows stay until they are opened.
  void dismissAll() {
    if (state.isEmpty) {
      return;
    }
    state = const [];
  }
}
