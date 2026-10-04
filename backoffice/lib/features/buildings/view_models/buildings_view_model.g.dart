// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buildings_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Platform building list for the backoffice console.

@ProviderFor(BuildingsViewModel)
const buildingsViewModelProvider = BuildingsViewModelProvider._();

/// Platform building list for the backoffice console.
final class BuildingsViewModelProvider
    extends $AsyncNotifierProvider<BuildingsViewModel, AdminBuildingPage> {
  /// Platform building list for the backoffice console.
  const BuildingsViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'buildingsViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$buildingsViewModelHash();

  @$internal
  @override
  BuildingsViewModel create() => BuildingsViewModel();
}

String _$buildingsViewModelHash() =>
    r'10cb8c1b4b0e607cf8072257232fe4f18c064b1d';

/// Platform building list for the backoffice console.

abstract class _$BuildingsViewModel extends $AsyncNotifier<AdminBuildingPage> {
  FutureOr<AdminBuildingPage> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<AdminBuildingPage>, AdminBuildingPage>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AdminBuildingPage>, AdminBuildingPage>,
              AsyncValue<AdminBuildingPage>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
