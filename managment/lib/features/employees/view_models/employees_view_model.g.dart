// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employees_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EmployeesViewModel)
const employeesViewModelProvider = EmployeesViewModelProvider._();

final class EmployeesViewModelProvider
    extends $AsyncNotifierProvider<EmployeesViewModel, List<EmployeeView>> {
  const EmployeesViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'employeesViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$employeesViewModelHash();

  @$internal
  @override
  EmployeesViewModel create() => EmployeesViewModel();
}

String _$employeesViewModelHash() =>
    r'2156cd2069adf0c1d531b77f7bff9e61f4802acb';

abstract class _$EmployeesViewModel extends $AsyncNotifier<List<EmployeeView>> {
  FutureOr<List<EmployeeView>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
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
