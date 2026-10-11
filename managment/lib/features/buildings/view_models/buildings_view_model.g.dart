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
    extends $AsyncNotifierProvider<BuildingsViewModel, BuildingPage> {
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
    r'a4adc0a33538a58049db03c27653400ea4b0d741';

abstract class _$BuildingsViewModel extends $AsyncNotifier<BuildingPage> {
  FutureOr<BuildingPage> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<BuildingPage>, BuildingPage>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<BuildingPage>, BuildingPage>,
              AsyncValue<BuildingPage>,
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
    r'a3743eaad3f64af7c929b5e55aad8f80a4454a07';

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
