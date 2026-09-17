// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(client)
const clientProvider = ClientProvider._();

final class ClientProvider extends $FunctionalProvider<Client, Client, Client>
    with $Provider<Client> {
  const ClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clientProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clientHash();

  @$internal
  @override
  $ProviderElement<Client> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Client create(Ref ref) {
    return client(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Client value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Client>(value),
    );
  }
}

String _$clientHash() => r'cd1ac107ee15d79c82574cd6d6680bc53670e85b';

@ProviderFor(ownerAuthRepository)
const ownerAuthRepositoryProvider = OwnerAuthRepositoryProvider._();

final class OwnerAuthRepositoryProvider
    extends
        $FunctionalProvider<
          OwnerAuthRepository,
          OwnerAuthRepository,
          OwnerAuthRepository
        >
    with $Provider<OwnerAuthRepository> {
  const OwnerAuthRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ownerAuthRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ownerAuthRepositoryHash();

  @$internal
  @override
  $ProviderElement<OwnerAuthRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  OwnerAuthRepository create(Ref ref) {
    return ownerAuthRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OwnerAuthRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OwnerAuthRepository>(value),
    );
  }
}

String _$ownerAuthRepositoryHash() =>
    r'0512ee2aec5e3e8d0e742f61f90bce5f7a05c568';

@ProviderFor(buildingRepository)
const buildingRepositoryProvider = BuildingRepositoryProvider._();

final class BuildingRepositoryProvider
    extends
        $FunctionalProvider<
          BuildingRepository,
          BuildingRepository,
          BuildingRepository
        >
    with $Provider<BuildingRepository> {
  const BuildingRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'buildingRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$buildingRepositoryHash();

  @$internal
  @override
  $ProviderElement<BuildingRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BuildingRepository create(Ref ref) {
    return buildingRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BuildingRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BuildingRepository>(value),
    );
  }
}

String _$buildingRepositoryHash() =>
    r'6c7f41e1ecb66a8ddd889faec57caa201f470381';

@ProviderFor(employeeRepository)
const employeeRepositoryProvider = EmployeeRepositoryProvider._();

final class EmployeeRepositoryProvider
    extends
        $FunctionalProvider<
          EmployeeRepository,
          EmployeeRepository,
          EmployeeRepository
        >
    with $Provider<EmployeeRepository> {
  const EmployeeRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'employeeRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$employeeRepositoryHash();

  @$internal
  @override
  $ProviderElement<EmployeeRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EmployeeRepository create(Ref ref) {
    return employeeRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EmployeeRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EmployeeRepository>(value),
    );
  }
}

String _$employeeRepositoryHash() =>
    r'ef1b4c01ecac48242df944ddc03227ef80daaa19';

@ProviderFor(appSessionStore)
const appSessionStoreProvider = AppSessionStoreProvider._();

final class AppSessionStoreProvider
    extends
        $FunctionalProvider<AppSessionStore, AppSessionStore, AppSessionStore>
    with $Provider<AppSessionStore> {
  const AppSessionStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appSessionStoreProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appSessionStoreHash();

  @$internal
  @override
  $ProviderElement<AppSessionStore> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppSessionStore create(Ref ref) {
    return appSessionStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppSessionStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppSessionStore>(value),
    );
  }
}

String _$appSessionStoreHash() => r'4119692888a986f5a2fb6225be75421170f4563d';

@ProviderFor(BuildingSelection)
const buildingSelectionProvider = BuildingSelectionProvider._();

final class BuildingSelectionProvider
    extends $NotifierProvider<BuildingSelection, BuildingView?> {
  const BuildingSelectionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'buildingSelectionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$buildingSelectionHash();

  @$internal
  @override
  BuildingSelection create() => BuildingSelection();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BuildingView? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BuildingView?>(value),
    );
  }
}

String _$buildingSelectionHash() => r'80ea972d407c9100b52c96acfd5b2b767ea05a4e';

abstract class _$BuildingSelection extends $Notifier<BuildingView?> {
  BuildingView? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<BuildingView?, BuildingView?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<BuildingView?, BuildingView?>,
              BuildingView?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
