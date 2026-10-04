// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Platform totals for the stats screen.

@ProviderFor(StatsViewModel)
const statsViewModelProvider = StatsViewModelProvider._();

/// Platform totals for the stats screen.
final class StatsViewModelProvider
    extends $AsyncNotifierProvider<StatsViewModel, PlatformStats> {
  /// Platform totals for the stats screen.
  const StatsViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'statsViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$statsViewModelHash();

  @$internal
  @override
  StatsViewModel create() => StatsViewModel();
}

String _$statsViewModelHash() => r'd7a3ac752398d3537de829b4f1f952437a7c7b8e';

/// Platform totals for the stats screen.

abstract class _$StatsViewModel extends $AsyncNotifier<PlatformStats> {
  FutureOr<PlatformStats> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<PlatformStats>, PlatformStats>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PlatformStats>, PlatformStats>,
              AsyncValue<PlatformStats>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
