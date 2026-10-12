// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_inbox_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Badge count plus the list. A live stream inserts new rows.

@ProviderFor(NotificationInbox)
const notificationInboxProvider = NotificationInboxProvider._();

/// Badge count plus the list. A live stream inserts new rows.
final class NotificationInboxProvider
    extends $AsyncNotifierProvider<NotificationInbox, NotificationInboxState> {
  /// Badge count plus the list. A live stream inserts new rows.
  const NotificationInboxProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationInboxProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationInboxHash();

  @$internal
  @override
  NotificationInbox create() => NotificationInbox();
}

String _$notificationInboxHash() => r'4d930dd7a4904196a2e68f47fbaadc1295f17896';

/// Badge count plus the list. A live stream inserts new rows.

abstract class _$NotificationInbox
    extends $AsyncNotifier<NotificationInboxState> {
  FutureOr<NotificationInboxState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<NotificationInboxState>, NotificationInboxState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<NotificationInboxState>,
                NotificationInboxState
              >,
              AsyncValue<NotificationInboxState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
