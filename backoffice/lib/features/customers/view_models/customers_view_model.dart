import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';

part 'customers_view_model.g.dart';

/// Owners and customers loaded together for the directory tabs.
class PlatformDirectoryState {
  const PlatformDirectoryState({required this.owners, required this.customers});

  final List<PlatformPersonView> owners;
  final List<PlatformPersonView> customers;
}

/// Platform owner and customer lists for the backoffice console.
@Riverpod(keepAlive: true)
class CustomersViewModel extends _$CustomersViewModel {
  @override
  Future<PlatformDirectoryState> build() => _load();

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_load);
  }

  Future<PlatformDirectoryState> _load() async {
    final repository = ref.read(platformDirectoryRepositoryProvider);
    final results = await Future.wait([
      repository.listOwners(),
      repository.listCustomers(),
    ]);
    return PlatformDirectoryState(owners: results[0], customers: results[1]);
  }
}
