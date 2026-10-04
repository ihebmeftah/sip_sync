import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/paging/list_paging.dart';

part 'customers_view_model.g.dart';

/// Owners and customers loaded together for the directory tabs.
class PlatformDirectoryState {
  const PlatformDirectoryState({required this.owners, required this.customers});

  final PlatformPersonPage owners;
  final PlatformPersonPage customers;

  PlatformDirectoryState copyWith({
    PlatformPersonPage? owners,
    PlatformPersonPage? customers,
  }) {
    return PlatformDirectoryState(
      owners: owners ?? this.owners,
      customers: customers ?? this.customers,
    );
  }
}

/// Platform owner and customer lists for the backoffice console.
@Riverpod(keepAlive: true)
class CustomersViewModel extends _$CustomersViewModel {
  var _ownersOffset = 0;
  var _customersOffset = 0;

  @override
  Future<PlatformDirectoryState> build() => _load();

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_load);
  }

  Future<void> previousOwners() => _showOwners(_ownersOffset - listPageSize);

  Future<void> nextOwners() => _showOwners(_ownersOffset + listPageSize);

  Future<void> previousCustomers() =>
      _showCustomers(_customersOffset - listPageSize);

  Future<void> nextCustomers() =>
      _showCustomers(_customersOffset + listPageSize);

  Future<void> _showOwners(int offset) async {
    _ownersOffset = offset < 0 ? 0 : offset;
    final current = state.asData?.value;
    final page = await ref
        .read(platformDirectoryRepositoryProvider)
        .listOwners(limit: listPageSize, offset: _ownersOffset);
    if (current == null) {
      state = await AsyncValue.guard(_load);
      return;
    }
    state = AsyncData(current.copyWith(owners: page));
  }

  Future<void> _showCustomers(int offset) async {
    _customersOffset = offset < 0 ? 0 : offset;
    final current = state.asData?.value;
    final page = await ref
        .read(platformDirectoryRepositoryProvider)
        .listCustomers(limit: listPageSize, offset: _customersOffset);
    if (current == null) {
      state = await AsyncValue.guard(_load);
      return;
    }
    state = AsyncData(current.copyWith(customers: page));
  }

  Future<PlatformDirectoryState> _load() async {
    final repository = ref.read(platformDirectoryRepositoryProvider);
    final results = await Future.wait([
      repository.listOwners(limit: listPageSize, offset: _ownersOffset),
      repository.listCustomers(limit: listPageSize, offset: _customersOffset),
    ]);
    return PlatformDirectoryState(owners: results[0], customers: results[1]);
  }
}
