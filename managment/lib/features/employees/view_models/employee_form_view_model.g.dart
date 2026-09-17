// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_form_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EmployeeFormViewModel)
const employeeFormViewModelProvider = EmployeeFormViewModelFamily._();

final class EmployeeFormViewModelProvider
    extends $NotifierProvider<EmployeeFormViewModel, EmployeeFormState> {
  const EmployeeFormViewModelProvider._({
    required EmployeeFormViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'employeeFormViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$employeeFormViewModelHash();

  @override
  String toString() {
    return r'employeeFormViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  EmployeeFormViewModel create() => EmployeeFormViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EmployeeFormState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EmployeeFormState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is EmployeeFormViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$employeeFormViewModelHash() =>
    r'f87fafb0e34a847c8df8ed398247b1bd292c6e3c';

final class EmployeeFormViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          EmployeeFormViewModel,
          EmployeeFormState,
          EmployeeFormState,
          EmployeeFormState,
          String
        > {
  const EmployeeFormViewModelFamily._()
    : super(
        retry: null,
        name: r'employeeFormViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EmployeeFormViewModelProvider call(String employeeId) =>
      EmployeeFormViewModelProvider._(argument: employeeId, from: this);

  @override
  String toString() => r'employeeFormViewModelProvider';
}

abstract class _$EmployeeFormViewModel extends $Notifier<EmployeeFormState> {
  late final _$args = ref.$arg as String;
  String get employeeId => _$args;

  EmployeeFormState build(String employeeId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<EmployeeFormState, EmployeeFormState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<EmployeeFormState, EmployeeFormState>,
              EmployeeFormState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
