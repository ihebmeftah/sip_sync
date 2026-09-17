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

@ProviderFor(accountRepository)
const accountRepositoryProvider = AccountRepositoryProvider._();

final class AccountRepositoryProvider
    extends
        $FunctionalProvider<
          AccountRepository,
          AccountRepository,
          AccountRepository
        >
    with $Provider<AccountRepository> {
  const AccountRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'accountRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$accountRepositoryHash();

  @$internal
  @override
  $ProviderElement<AccountRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AccountRepository create(Ref ref) {
    return accountRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AccountRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AccountRepository>(value),
    );
  }
}

String _$accountRepositoryHash() => r'9f0d02cdfa37317cffc67c91cd016399030035a6';

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

/// Mirrors [BuildingSession.selected] so widgets rebuild when a venue is picked.

@ProviderFor(BuildingSelection)
const buildingSelectionProvider = BuildingSelectionProvider._();

/// Mirrors [BuildingSession.selected] so widgets rebuild when a venue is picked.
final class BuildingSelectionProvider
    extends $NotifierProvider<BuildingSelection, BuildingView?> {
  /// Mirrors [BuildingSession.selected] so widgets rebuild when a venue is picked.
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

/// Mirrors [BuildingSession.selected] so widgets rebuild when a venue is picked.

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
