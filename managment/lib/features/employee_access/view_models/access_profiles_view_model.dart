import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../auth/view_models/auth_view_model.dart';

part 'access_profiles_view_model.g.dart';

@Riverpod(keepAlive: true)
class AccessProfilesViewModel extends _$AccessProfilesViewModel {
  late String _buildingId;

  @override
  Future<List<EmployeeAccessView>> build(String buildingId) async {
    _buildingId = buildingId;
    ref.watch(signedInActorIdProvider);
    if (buildingId.isEmpty) {
      return const [];
    }
    return ref
        .read(employeeAccessRepositoryProvider)
        .list(UuidValue.fromString(buildingId));
  }

  Future<void> refresh() async {
    state = await AsyncValue.guard(() async {
      if (_buildingId.isEmpty) {
        return const <EmployeeAccessView>[];
      }
      return ref
          .read(employeeAccessRepositoryProvider)
          .list(UuidValue.fromString(_buildingId));
    });
  }

  Future<EmployeeAccessView> createProfile({
    required String name,
    required bool orderCreation,
    required bool orderPayment,
    required bool cancelOrder,
    required bool preparation,
    required bool serving,
    required bool consultAllOrders,
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
        );
    await refresh();
    return saved;
  }

  Future<void> deleteProfile(UuidValue id) async {
    await ref.read(employeeAccessRepositoryProvider).delete(id);
    await refresh();
  }
}
