// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_details_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EmployeeDetailsViewModel)
const employeeDetailsViewModelProvider = EmployeeDetailsViewModelFamily._();

final class EmployeeDetailsViewModelProvider
    extends $AsyncNotifierProvider<EmployeeDetailsViewModel, EmployeeView> {
  const EmployeeDetailsViewModelProvider._({
    required EmployeeDetailsViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'employeeDetailsViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$employeeDetailsViewModelHash();

  @override
  String toString() {
    return r'employeeDetailsViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  EmployeeDetailsViewModel create() => EmployeeDetailsViewModel();

  @override
  bool operator ==(Object other) {
    return other is EmployeeDetailsViewModelProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$employeeDetailsViewModelHash() =>
    r'3b18641bc40e91a94eb3e0baff13f46184b4205a';

final class EmployeeDetailsViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          EmployeeDetailsViewModel,
          AsyncValue<EmployeeView>,
          EmployeeView,
          FutureOr<EmployeeView>,
          String
        > {
  const EmployeeDetailsViewModelFamily._()
    : super(
        retry: null,
        name: r'employeeDetailsViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EmployeeDetailsViewModelProvider call(String authUserId) =>
      EmployeeDetailsViewModelProvider._(argument: authUserId, from: this);

  @override
  String toString() => r'employeeDetailsViewModelProvider';
}

abstract class _$EmployeeDetailsViewModel extends $AsyncNotifier<EmployeeView> {
  late final _$args = ref.$arg as String;
  String get authUserId => _$args;

  FutureOr<EmployeeView> build(String authUserId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<EmployeeView>, EmployeeView>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<EmployeeView>, EmployeeView>,
              AsyncValue<EmployeeView>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
