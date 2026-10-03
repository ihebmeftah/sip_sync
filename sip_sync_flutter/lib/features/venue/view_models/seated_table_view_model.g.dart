// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seated_table_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Session seat. Cleared when the app process restarts.

@ProviderFor(SeatedTable)
const seatedTableProvider = SeatedTableProvider._();

/// Session seat. Cleared when the app process restarts.
final class SeatedTableProvider
    extends $NotifierProvider<SeatedTable, SeatedTableNotice?> {
  /// Session seat. Cleared when the app process restarts.
  const SeatedTableProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'seatedTableProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$seatedTableHash();

  @$internal
  @override
  SeatedTable create() => SeatedTable();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SeatedTableNotice? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SeatedTableNotice?>(value),
    );
  }
}

String _$seatedTableHash() => r'875f52373e7ca02ea0c346192d252db6522df014';

/// Session seat. Cleared when the app process restarts.

abstract class _$SeatedTable extends $Notifier<SeatedTableNotice?> {
  SeatedTableNotice? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<SeatedTableNotice?, SeatedTableNotice?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SeatedTableNotice?, SeatedTableNotice?>,
              SeatedTableNotice?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
