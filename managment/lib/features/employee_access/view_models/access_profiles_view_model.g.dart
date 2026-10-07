// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_profiles_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Every access profile, for the employee form and the edit screen.

@ProviderFor(accessCatalog)
const accessCatalogProvider = AccessCatalogFamily._();

/// Every access profile, for the employee form and the edit screen.

final class AccessCatalogProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<EmployeeAccessView>>,
          List<EmployeeAccessView>,
          FutureOr<List<EmployeeAccessView>>
        >
    with
        $FutureModifier<List<EmployeeAccessView>>,
        $FutureProvider<List<EmployeeAccessView>> {
  /// Every access profile, for the employee form and the edit screen.
  const AccessCatalogProvider._({
    required AccessCatalogFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'accessCatalogProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$accessCatalogHash();

  @override
  String toString() {
    return r'accessCatalogProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<EmployeeAccessView>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<EmployeeAccessView>> create(Ref ref) {
    final argument = this.argument as String;
    return accessCatalog(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AccessCatalogProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$accessCatalogHash() => r'b4892b0be941196677cae6a3560704997f25604c';

/// Every access profile, for the employee form and the edit screen.

final class AccessCatalogFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<EmployeeAccessView>>, String> {
  const AccessCatalogFamily._()
    : super(
        retry: null,
        name: r'accessCatalogProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Every access profile, for the employee form and the edit screen.

  AccessCatalogProvider call(String buildingId) =>
      AccessCatalogProvider._(argument: buildingId, from: this);

  @override
  String toString() => r'accessCatalogProvider';
}

@ProviderFor(AccessProfilesViewModel)
const accessProfilesViewModelProvider = AccessProfilesViewModelFamily._();

final class AccessProfilesViewModelProvider
    extends
        $AsyncNotifierProvider<AccessProfilesViewModel, EmployeeAccessPage> {
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
    r'2558d9dfc913e683e631046fd78bf23d576761ac';

final class AccessProfilesViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          AccessProfilesViewModel,
          AsyncValue<EmployeeAccessPage>,
          EmployeeAccessPage,
          FutureOr<EmployeeAccessPage>,
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
    extends $AsyncNotifier<EmployeeAccessPage> {
  late final _$args = ref.$arg as String;
  String get buildingId => _$args;

  FutureOr<EmployeeAccessPage> build(String buildingId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref as $Ref<AsyncValue<EmployeeAccessPage>, EmployeeAccessPage>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<EmployeeAccessPage>, EmployeeAccessPage>,
              AsyncValue<EmployeeAccessPage>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
