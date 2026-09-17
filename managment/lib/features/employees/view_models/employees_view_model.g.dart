// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employees_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EmployeesViewModel)
const employeesViewModelProvider = EmployeesViewModelFamily._();

final class EmployeesViewModelProvider
    extends $AsyncNotifierProvider<EmployeesViewModel, List<EmployeeView>> {
  const EmployeesViewModelProvider._({
    required EmployeesViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'employeesViewModelProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$employeesViewModelHash();

  @override
  String toString() {
    return r'employeesViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  EmployeesViewModel create() => EmployeesViewModel();

  @override
  bool operator ==(Object other) {
    return other is EmployeesViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$employeesViewModelHash() =>
    r'1343e0f200f8f7de5f99217adff540db401972d2';

final class EmployeesViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          EmployeesViewModel,
          AsyncValue<List<EmployeeView>>,
          List<EmployeeView>,
          FutureOr<List<EmployeeView>>,
          String
        > {
  const EmployeesViewModelFamily._()
    : super(
        retry: null,
        name: r'employeesViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  EmployeesViewModelProvider call(String buildingId) =>
      EmployeesViewModelProvider._(argument: buildingId, from: this);

  @override
  String toString() => r'employeesViewModelProvider';
}

abstract class _$EmployeesViewModel extends $AsyncNotifier<List<EmployeeView>> {
  late final _$args = ref.$arg as String;
  String get buildingId => _$args;

  FutureOr<List<EmployeeView>> build(String buildingId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref as $Ref<AsyncValue<List<EmployeeView>>, List<EmployeeView>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<EmployeeView>>, List<EmployeeView>>,
              AsyncValue<List<EmployeeView>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
