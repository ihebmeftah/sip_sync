import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../auth/view_models/auth_view_model.dart';

part 'employees_view_model.g.dart';

@Riverpod(keepAlive: true)
class EmployeesViewModel extends _$EmployeesViewModel {
  late String _buildingId;

  @override
  Future<List<EmployeeView>> build(String buildingId) async {
    _buildingId = buildingId;
    ref.watch(signedInActorIdProvider);
    final isOwner = ref.read(appSessionStoreProvider).isOwner;
    if (!isOwner || buildingId.isEmpty) {
      return const [];
    }
    return ref
        .read(buildingRepositoryProvider)
        .listEmployees(UuidValue.fromString(buildingId));
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final isOwner = ref.read(appSessionStoreProvider).isOwner;
      if (!isOwner || _buildingId.isEmpty) {
        return const <EmployeeView>[];
      }
      return ref
          .read(buildingRepositoryProvider)
          .listEmployees(UuidValue.fromString(_buildingId));
    });
  }
}
