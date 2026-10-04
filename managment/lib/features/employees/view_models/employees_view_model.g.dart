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
    extends $AsyncNotifierProvider<EmployeesViewModel, EmployeePage> {
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
    r'a17658a2ff88bfc8c66a6989dddca60bf91435d0';

final class EmployeesViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          EmployeesViewModel,
          AsyncValue<EmployeePage>,
          EmployeePage,
          FutureOr<EmployeePage>,
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

abstract class _$EmployeesViewModel extends $AsyncNotifier<EmployeePage> {
  late final _$args = ref.$arg as String;
  String get buildingId => _$args;

  FutureOr<EmployeePage> build(String buildingId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<EmployeePage>, EmployeePage>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<EmployeePage>, EmployeePage>,
              AsyncValue<EmployeePage>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
