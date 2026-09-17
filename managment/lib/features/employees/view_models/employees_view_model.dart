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
    ref.listen(authViewModelProvider, (previous, next) {
      if (previous?.session?.profile.authUserId !=
          next.session?.profile.authUserId) {
        ref.invalidateSelf();
      }
    });
    if (!_isOwner || buildingId.isEmpty) {
      return const [];
    }
    return ref
        .read(buildingRepositoryProvider)
        .listEmployees(UuidValue.fromString(buildingId));
  }

  bool get _isOwner {
    final roles =
        ref.read(authViewModelProvider).session?.profile.roles ??
        const <String>[];
    return roles.contains('owner');
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      if (!_isOwner || _buildingId.isEmpty) {
        return const <EmployeeView>[];
      }
      return ref
          .read(buildingRepositoryProvider)
          .listEmployees(UuidValue.fromString(_buildingId));
    });
  }
}
