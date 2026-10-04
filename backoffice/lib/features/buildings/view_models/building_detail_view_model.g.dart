// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'building_detail_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// One venue for the backoffice detail screen.

@ProviderFor(BuildingDetailViewModel)
const buildingDetailViewModelProvider = BuildingDetailViewModelFamily._();

/// One venue for the backoffice detail screen.
final class BuildingDetailViewModelProvider
    extends
        $AsyncNotifierProvider<BuildingDetailViewModel, AdminBuildingDetail> {
  /// One venue for the backoffice detail screen.
  const BuildingDetailViewModelProvider._({
    required BuildingDetailViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'buildingDetailViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$buildingDetailViewModelHash();

  @override
  String toString() {
    return r'buildingDetailViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  BuildingDetailViewModel create() => BuildingDetailViewModel();

  @override
  bool operator ==(Object other) {
    return other is BuildingDetailViewModelProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$buildingDetailViewModelHash() =>
    r'dee6debe2430ed3346b1403b1b373d32a242b8af';

/// One venue for the backoffice detail screen.

final class BuildingDetailViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          BuildingDetailViewModel,
          AsyncValue<AdminBuildingDetail>,
          AdminBuildingDetail,
          FutureOr<AdminBuildingDetail>,
          String
        > {
  const BuildingDetailViewModelFamily._()
    : super(
        retry: null,
        name: r'buildingDetailViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// One venue for the backoffice detail screen.

  BuildingDetailViewModelProvider call(String buildingId) =>
      BuildingDetailViewModelProvider._(argument: buildingId, from: this);

  @override
  String toString() => r'buildingDetailViewModelProvider';
}

/// One venue for the backoffice detail screen.

abstract class _$BuildingDetailViewModel
    extends $AsyncNotifier<AdminBuildingDetail> {
  late final _$args = ref.$arg as String;
  String get buildingId => _$args;

  FutureOr<AdminBuildingDetail> build(String buildingId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref as $Ref<AsyncValue<AdminBuildingDetail>, AdminBuildingDetail>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AdminBuildingDetail>, AdminBuildingDetail>,
              AsyncValue<AdminBuildingDetail>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
