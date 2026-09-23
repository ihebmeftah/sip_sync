// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buildings_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BuildingsViewModel)
const buildingsViewModelProvider = BuildingsViewModelProvider._();

final class BuildingsViewModelProvider
    extends $AsyncNotifierProvider<BuildingsViewModel, List<BuildingView>> {
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
    r'1bbac8cbf8c4a33ad28cfba401f6662a81ee04a1';

abstract class _$BuildingsViewModel extends $AsyncNotifier<List<BuildingView>> {
  FutureOr<List<BuildingView>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<BuildingView>>, List<BuildingView>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<BuildingView>>, List<BuildingView>>,
              AsyncValue<List<BuildingView>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(BuildingFormViewModel)
const buildingFormViewModelProvider = BuildingFormViewModelFamily._();

final class BuildingFormViewModelProvider
    extends $AsyncNotifierProvider<BuildingFormViewModel, BuildingView?> {
  const BuildingFormViewModelProvider._({
    required BuildingFormViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'buildingFormViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$buildingFormViewModelHash();

  @override
  String toString() {
    return r'buildingFormViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  BuildingFormViewModel create() => BuildingFormViewModel();

  @override
  bool operator ==(Object other) {
    return other is BuildingFormViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$buildingFormViewModelHash() =>
    r'f0514d237eeb5a8dd4829f2eca4af35805b10f50';

final class BuildingFormViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          BuildingFormViewModel,
          AsyncValue<BuildingView?>,
          BuildingView?,
          FutureOr<BuildingView?>,
          String
        > {
  const BuildingFormViewModelFamily._()
    : super(
        retry: null,
        name: r'buildingFormViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  BuildingFormViewModelProvider call(String buildingId) =>
      BuildingFormViewModelProvider._(argument: buildingId, from: this);

  @override
  String toString() => r'buildingFormViewModelProvider';
}

abstract class _$BuildingFormViewModel extends $AsyncNotifier<BuildingView?> {
  late final _$args = ref.$arg as String;
  String get buildingId => _$args;

  FutureOr<BuildingView?> build(String buildingId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<BuildingView?>, BuildingView?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<BuildingView?>, BuildingView?>,
              AsyncValue<BuildingView?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
