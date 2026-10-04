// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_stats_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Venue counts per country for the map screen.

@ProviderFor(CountryStatsViewModel)
const countryStatsViewModelProvider = CountryStatsViewModelProvider._();

/// Venue counts per country for the map screen.
final class CountryStatsViewModelProvider
    extends
        $AsyncNotifierProvider<
          CountryStatsViewModel,
          List<CountryBuildingStat>
        > {
  /// Venue counts per country for the map screen.
  const CountryStatsViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'countryStatsViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$countryStatsViewModelHash();

  @$internal
  @override
  CountryStatsViewModel create() => CountryStatsViewModel();
}

String _$countryStatsViewModelHash() =>
    r'f72e1ae3eb836a5ee1605f30a8ce54f3330eb2ab';

/// Venue counts per country for the map screen.

abstract class _$CountryStatsViewModel
    extends $AsyncNotifier<List<CountryBuildingStat>> {
  FutureOr<List<CountryBuildingStat>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<CountryBuildingStat>>,
              List<CountryBuildingStat>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<CountryBuildingStat>>,
                List<CountryBuildingStat>
              >,
              AsyncValue<List<CountryBuildingStat>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
