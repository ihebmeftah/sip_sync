// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_profiles_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AccessProfilesViewModel)
const accessProfilesViewModelProvider = AccessProfilesViewModelFamily._();

final class AccessProfilesViewModelProvider
    extends
        $AsyncNotifierProvider<
          AccessProfilesViewModel,
          List<EmployeeAccessView>
        > {
  const AccessProfilesViewModelProvider._({
    required AccessProfilesViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'accessProfilesViewModelProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$accessProfilesViewModelHash();

  @override
  String toString() {
    return r'accessProfilesViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  AccessProfilesViewModel create() => AccessProfilesViewModel();

  @override
  bool operator ==(Object other) {
    return other is AccessProfilesViewModelProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$accessProfilesViewModelHash() =>
    r'8cd9e9439bba08ff0567f3ebbd18b1bca83a28e7';

final class AccessProfilesViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          AccessProfilesViewModel,
          AsyncValue<List<EmployeeAccessView>>,
          List<EmployeeAccessView>,
          FutureOr<List<EmployeeAccessView>>,
          String
        > {
  const AccessProfilesViewModelFamily._()
    : super(
        retry: null,
        name: r'accessProfilesViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  AccessProfilesViewModelProvider call(String buildingId) =>
      AccessProfilesViewModelProvider._(argument: buildingId, from: this);

  @override
  String toString() => r'accessProfilesViewModelProvider';
}

abstract class _$AccessProfilesViewModel
    extends $AsyncNotifier<List<EmployeeAccessView>> {
  late final _$args = ref.$arg as String;
  String get buildingId => _$args;

  FutureOr<List<EmployeeAccessView>> build(String buildingId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<EmployeeAccessView>>,
              List<EmployeeAccessView>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<EmployeeAccessView>>,
                List<EmployeeAccessView>
              >,
              AsyncValue<List<EmployeeAccessView>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
