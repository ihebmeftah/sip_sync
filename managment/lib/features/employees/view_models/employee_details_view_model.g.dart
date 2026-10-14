// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_details_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Loads a single employee; keeps prior data while toggling enabled.

@ProviderFor(EmployeeDetailsViewModel)
const employeeDetailsViewModelProvider = EmployeeDetailsViewModelFamily._();

/// Loads a single employee; keeps prior data while toggling enabled.
final class EmployeeDetailsViewModelProvider
    extends $AsyncNotifierProvider<EmployeeDetailsViewModel, EmployeeView> {
  /// Loads a single employee; keeps prior data while toggling enabled.
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
    r'4d3977bf787bc8f722156c85b26ff17780f79c25';

/// Loads a single employee; keeps prior data while toggling enabled.

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

  /// Loads a single employee; keeps prior data while toggling enabled.

  EmployeeDetailsViewModelProvider call(String employeeId) =>
      EmployeeDetailsViewModelProvider._(argument: employeeId, from: this);

  @override
  String toString() => r'employeeDetailsViewModelProvider';
}

/// Loads a single employee; keeps prior data while toggling enabled.

abstract class _$EmployeeDetailsViewModel extends $AsyncNotifier<EmployeeView> {
  late final _$args = ref.$arg as String;
  String get employeeId => _$args;

  FutureOr<EmployeeView> build(String employeeId);
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

/// The permission set assigned to one employee, for the details screen.

@ProviderFor(employeeAssignedAccess)
const employeeAssignedAccessProvider = EmployeeAssignedAccessFamily._();

/// The permission set assigned to one employee, for the details screen.

final class EmployeeAssignedAccessProvider
    extends
        $FunctionalProvider<
          AsyncValue<EmployeeAccessView?>,
          EmployeeAccessView?,
          FutureOr<EmployeeAccessView?>
        >
    with
        $FutureModifier<EmployeeAccessView?>,
        $FutureProvider<EmployeeAccessView?> {
  /// The permission set assigned to one employee, for the details screen.
  const EmployeeAssignedAccessProvider._({
    required EmployeeAssignedAccessFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'employeeAssignedAccessProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$employeeAssignedAccessHash();

  @override
  String toString() {
    return r'employeeAssignedAccessProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<EmployeeAccessView?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<EmployeeAccessView?> create(Ref ref) {
    final argument = this.argument as String;
    return employeeAssignedAccess(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is EmployeeAssignedAccessProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$employeeAssignedAccessHash() =>
    r'b80371a5ff23d103264bf98b26c459101c1a8585';

/// The permission set assigned to one employee, for the details screen.

final class EmployeeAssignedAccessFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<EmployeeAccessView?>, String> {
  const EmployeeAssignedAccessFamily._()
    : super(
        retry: null,
        name: r'employeeAssignedAccessProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The permission set assigned to one employee, for the details screen.

  EmployeeAssignedAccessProvider call(String accessId) =>
      EmployeeAssignedAccessProvider._(argument: accessId, from: this);

  @override
  String toString() => r'employeeAssignedAccessProvider';
}
