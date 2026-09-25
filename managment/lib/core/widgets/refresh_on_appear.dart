import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// OpsShell list routes dispose when left; keepAlive ViewModels keep stale data.
///
/// Call from [State.initState]. Pass [providerAlreadyAlive] from
/// `ref.exists(provider)` **before** [build] watches it:
/// - first open → provider missing → skip ( [AsyncNotifier.build] fetches once )
/// - return visit → provider still alive → refresh
void refreshCachedListOnAppear(
  ConsumerState state, {
  required bool providerAlreadyAlive,
  required Future<void> Function() refresh,
}) {
  if (!providerAlreadyAlive) return;
  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (!state.mounted) return;
    refresh();
  });
}
