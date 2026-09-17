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

@ProviderFor(customerAuthRepository)
const customerAuthRepositoryProvider = CustomerAuthRepositoryProvider._();

final class CustomerAuthRepositoryProvider
    extends
        $FunctionalProvider<
          CustomerAuthRepository,
          CustomerAuthRepository,
          CustomerAuthRepository
        >
    with $Provider<CustomerAuthRepository> {
  const CustomerAuthRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'customerAuthRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$customerAuthRepositoryHash();

  @$internal
  @override
  $ProviderElement<CustomerAuthRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CustomerAuthRepository create(Ref ref) {
    return customerAuthRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CustomerAuthRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CustomerAuthRepository>(value),
    );
  }
}

String _$customerAuthRepositoryHash() =>
    r'28f22042f622830942a79977cf8255720bc99b76';

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
