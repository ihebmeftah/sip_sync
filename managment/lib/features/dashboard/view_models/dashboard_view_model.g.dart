// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Today's house counts for one building.
///
/// The local calendar day is sent as UTC midnight, matching the reservation list.
/// A new visit loads fresh counts; pull to refresh does the same while the screen stays open.

@ProviderFor(DashboardViewModel)
const dashboardViewModelProvider = DashboardViewModelFamily._();

/// Today's house counts for one building.
///
/// The local calendar day is sent as UTC midnight, matching the reservation list.
/// A new visit loads fresh counts; pull to refresh does the same while the screen stays open.
final class DashboardViewModelProvider
    extends $AsyncNotifierProvider<DashboardViewModel, DashboardSummary> {
  /// Today's house counts for one building.
  ///
  /// The local calendar day is sent as UTC midnight, matching the reservation list.
  /// A new visit loads fresh counts; pull to refresh does the same while the screen stays open.
  const DashboardViewModelProvider._({
    required DashboardViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'dashboardViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$dashboardViewModelHash();

  @override
  String toString() {
    return r'dashboardViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  DashboardViewModel create() => DashboardViewModel();

  @override
  bool operator ==(Object other) {
    return other is DashboardViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$dashboardViewModelHash() =>
    r'30bf648b3aad8f399011050c4860b9ef58d1e028';

/// Today's house counts for one building.
///
/// The local calendar day is sent as UTC midnight, matching the reservation list.
/// A new visit loads fresh counts; pull to refresh does the same while the screen stays open.

final class DashboardViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          DashboardViewModel,
          AsyncValue<DashboardSummary>,
          DashboardSummary,
          FutureOr<DashboardSummary>,
          String
        > {
  const DashboardViewModelFamily._()
    : super(
        retry: null,
        name: r'dashboardViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Today's house counts for one building.
  ///
  /// The local calendar day is sent as UTC midnight, matching the reservation list.
  /// A new visit loads fresh counts; pull to refresh does the same while the screen stays open.

  DashboardViewModelProvider call(String buildingId) =>
      DashboardViewModelProvider._(argument: buildingId, from: this);

  @override
  String toString() => r'dashboardViewModelProvider';
}

/// Today's house counts for one building.
///
/// The local calendar day is sent as UTC midnight, matching the reservation list.
/// A new visit loads fresh counts; pull to refresh does the same while the screen stays open.

abstract class _$DashboardViewModel extends $AsyncNotifier<DashboardSummary> {
  late final _$args = ref.$arg as String;
  String get buildingId => _$args;

  FutureOr<DashboardSummary> build(String buildingId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref as $Ref<AsyncValue<DashboardSummary>, DashboardSummary>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<DashboardSummary>, DashboardSummary>,
              AsyncValue<DashboardSummary>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
