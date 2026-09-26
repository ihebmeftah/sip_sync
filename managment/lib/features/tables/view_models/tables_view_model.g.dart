// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tables_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TablesViewModel)
const tablesViewModelProvider = TablesViewModelFamily._();

final class TablesViewModelProvider
    extends $AsyncNotifierProvider<TablesViewModel, List<VenueTableView>> {
  const TablesViewModelProvider._({
    required TablesViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'tablesViewModelProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$tablesViewModelHash();

  @override
  String toString() {
    return r'tablesViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  TablesViewModel create() => TablesViewModel();

  @override
  bool operator ==(Object other) {
    return other is TablesViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$tablesViewModelHash() => r'a2f0d917faa8a85be5dac07eca070a1449a9f5d4';

final class TablesViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          TablesViewModel,
          AsyncValue<List<VenueTableView>>,
          List<VenueTableView>,
          FutureOr<List<VenueTableView>>,
          String
        > {
  const TablesViewModelFamily._()
    : super(
        retry: null,
        name: r'tablesViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  TablesViewModelProvider call(String buildingId) =>
      TablesViewModelProvider._(argument: buildingId, from: this);

  @override
  String toString() => r'tablesViewModelProvider';
}

abstract class _$TablesViewModel extends $AsyncNotifier<List<VenueTableView>> {
  late final _$args = ref.$arg as String;
  String get buildingId => _$args;

  FutureOr<List<VenueTableView>> build(String buildingId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref
            as $Ref<AsyncValue<List<VenueTableView>>, List<VenueTableView>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<VenueTableView>>,
                List<VenueTableView>
              >,
              AsyncValue<List<VenueTableView>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
