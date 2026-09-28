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

@ProviderFor(superAdminAuthRepository)
const superAdminAuthRepositoryProvider = SuperAdminAuthRepositoryProvider._();

final class SuperAdminAuthRepositoryProvider
    extends
        $FunctionalProvider<
          SuperAdminAuthRepository,
          SuperAdminAuthRepository,
          SuperAdminAuthRepository
        >
    with $Provider<SuperAdminAuthRepository> {
  const SuperAdminAuthRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'superAdminAuthRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$superAdminAuthRepositoryHash();

  @$internal
  @override
  $ProviderElement<SuperAdminAuthRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SuperAdminAuthRepository create(Ref ref) {
    return superAdminAuthRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SuperAdminAuthRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SuperAdminAuthRepository>(value),
    );
  }
}

String _$superAdminAuthRepositoryHash() =>
    r'6a6c34fa9c369e87109c0c64cc0bad037701f1e3';

@ProviderFor(adminBuildingRepository)
const adminBuildingRepositoryProvider = AdminBuildingRepositoryProvider._();

final class AdminBuildingRepositoryProvider
    extends
        $FunctionalProvider<
          AdminBuildingRepository,
          AdminBuildingRepository,
          AdminBuildingRepository
        >
    with $Provider<AdminBuildingRepository> {
  const AdminBuildingRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminBuildingRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminBuildingRepositoryHash();

  @$internal
  @override
  $ProviderElement<AdminBuildingRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AdminBuildingRepository create(Ref ref) {
    return adminBuildingRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdminBuildingRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdminBuildingRepository>(value),
    );
  }
}

String _$adminBuildingRepositoryHash() =>
    r'13875e9c445c18029e13d8e023a2b7618296d820';

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
