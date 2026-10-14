// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_toasts.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Live alerts piled at the top of the screen. The inbox keeps the history.

@ProviderFor(NotificationToasts)
const notificationToastsProvider = NotificationToastsProvider._();

/// Live alerts piled at the top of the screen. The inbox keeps the history.
final class NotificationToastsProvider
    extends $NotifierProvider<NotificationToasts, List<AppNotificationView>> {
  /// Live alerts piled at the top of the screen. The inbox keeps the history.
  const NotificationToastsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationToastsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationToastsHash();

  @$internal
  @override
  NotificationToasts create() => NotificationToasts();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<AppNotificationView> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<AppNotificationView>>(value),
    );
  }
}

String _$notificationToastsHash() =>
    r'076b83c9f09361ffe773ad207de17546fd8d20af';

/// Live alerts piled at the top of the screen. The inbox keeps the history.

abstract class _$NotificationToasts
    extends $Notifier<List<AppNotificationView>> {
  List<AppNotificationView> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<List<AppNotificationView>, List<AppNotificationView>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<AppNotificationView>, List<AppNotificationView>>,
              List<AppNotificationView>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
