import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/paging/list_paging.dart';
import '../../auth/view_models/auth_view_model.dart';

part 'access_profiles_view_model.g.dart';

/// Every access profile, for the employee form and the edit screen.
@riverpod
Future<List<EmployeeAccessView>> accessCatalog(Ref ref, String buildingId) {
  ref.watch(signedInActorIdProvider);
  if (buildingId.isEmpty) {
    return Future.value(const []);
  }
  return ref
      .read(employeeAccessRepositoryProvider)
      .listAll(UuidValue.fromString(buildingId));
}

@Riverpod(keepAlive: true)
class AccessProfilesViewModel extends _$AccessProfilesViewModel {
  late String _buildingId;
  var _offset = 0;

  @override
  Future<EmployeeAccessPage> build(String buildingId) async {
    _buildingId = buildingId;
    _offset = 0;
    ref.watch(signedInActorIdProvider);
    return _load();
  }

  Future<void> refresh() async {
    ref.invalidate(accessCatalogProvider(_buildingId));
    state = await AsyncValue.guard(_load);
  }

  Future<void> previousPage() => _show(_offset - listPageSize);

  Future<void> nextPage() => _show(_offset + listPageSize);

  Future<void> _show(int offset) async {
    _offset = offset < 0 ? 0 : offset;
    state = const AsyncLoading();
    state = await AsyncValue.guard(_load);
  }

  Future<EmployeeAccessPage> _load() async {
    if (_buildingId.isEmpty) {
      return EmployeeAccessPage(
        items: const [],
        total: 0,
        limit: listPageSize,
        offset: 0,
      );
    }
    final page = await ref
        .read(employeeAccessRepositoryProvider)
        .list(
          UuidValue.fromString(_buildingId),
          limit: listPageSize,
          offset: _offset,
        );
    if (page.items.isEmpty && page.offset > 0 && page.total > 0) {
      _offset = ((page.total - 1) ~/ listPageSize) * listPageSize;
      return _load();
    }
    return page;
  }

  Future<EmployeeAccessView> createProfile({
    required String name,
    required bool orderCreation,
    required bool orderPayment,
    required bool cancelOrder,
    required bool preparation,
    required bool serving,
    required bool consultAllOrders,
    required bool reservations,
    required bool cashRegister,
  }) async {
    final saved = await ref
        .read(employeeAccessRepositoryProvider)
        .create(
          buildingId: UuidValue.fromString(_buildingId),
          name: name,
          orderCreation: orderCreation,
          orderPayment: orderPayment,
          cancelOrder: cancelOrder,
          preparation: preparation,
          serving: serving,
          consultAllOrders: consultAllOrders,
          reservations: reservations,
          cashRegister: cashRegister,
        );
    await refresh();
    return saved;
  }

  Future<EmployeeAccessView> updateProfile({
    required UuidValue id,
    required String name,
    required bool orderCreation,
    required bool orderPayment,
    required bool cancelOrder,
    required bool preparation,
    required bool serving,
    required bool consultAllOrders,
    required bool reservations,
    required bool cashRegister,
  }) async {
    final saved = await ref
        .read(employeeAccessRepositoryProvider)
        .update(
          id: id,
          name: name,
          orderCreation: orderCreation,
          orderPayment: orderPayment,
          cancelOrder: cancelOrder,
          preparation: preparation,
          serving: serving,
          consultAllOrders: consultAllOrders,
          reservations: reservations,
          cashRegister: cashRegister,
        );
    await refresh();
    return saved;
  }

  Future<void> deleteProfile(UuidValue id) async {
    await ref.read(employeeAccessRepositoryProvider).delete(id);
    await refresh();
  }
}
