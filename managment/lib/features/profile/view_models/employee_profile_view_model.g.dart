// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_profile_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EmployeeProfileViewModel)
const employeeProfileViewModelProvider = EmployeeProfileViewModelFamily._();

final class EmployeeProfileViewModelProvider
    extends $AsyncNotifierProvider<EmployeeProfileViewModel, ProfileView> {
  const EmployeeProfileViewModelProvider._({
    required EmployeeProfileViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'employeeProfileViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$employeeProfileViewModelHash();

  @override
  String toString() {
    return r'employeeProfileViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  EmployeeProfileViewModel create() => EmployeeProfileViewModel();

  @override
  bool operator ==(Object other) {
    return other is EmployeeProfileViewModelProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$employeeProfileViewModelHash() =>
    r'203e093510bb3b1c5230877a476460f168b5947c';

final class EmployeeProfileViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          EmployeeProfileViewModel,
          AsyncValue<ProfileView>,
          ProfileView,
          FutureOr<ProfileView>,
          String
        > {
  const EmployeeProfileViewModelFamily._()
    : super(
        retry: null,
        name: r'employeeProfileViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EmployeeProfileViewModelProvider call(String authUserId) =>
      EmployeeProfileViewModelProvider._(argument: authUserId, from: this);

  @override
  String toString() => r'employeeProfileViewModelProvider';
}

abstract class _$EmployeeProfileViewModel extends $AsyncNotifier<ProfileView> {
  late final _$args = ref.$arg as String;
  String get authUserId => _$args;

  FutureOr<ProfileView> build(String authUserId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<ProfileView>, ProfileView>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ProfileView>, ProfileView>,
              AsyncValue<ProfileView>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
