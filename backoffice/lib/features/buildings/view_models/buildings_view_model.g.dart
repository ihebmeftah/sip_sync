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
    extends
        $AsyncNotifierProvider<BuildingsViewModel, List<AdminBuildingView>> {
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
    r'cde7f9e108f071ef721feadeb79c041b369b9f03';

/// Platform building list for the backoffice console.

abstract class _$BuildingsViewModel
    extends $AsyncNotifier<List<AdminBuildingView>> {
  FutureOr<List<AdminBuildingView>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<AdminBuildingView>>,
              List<AdminBuildingView>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<AdminBuildingView>>,
                List<AdminBuildingView>
              >,
              AsyncValue<List<AdminBuildingView>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
