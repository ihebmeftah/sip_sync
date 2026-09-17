import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import 'employees_view_model.dart';

part 'employee_details_view_model.g.dart';

@riverpod
class EmployeeDetailsViewModel extends _$EmployeeDetailsViewModel {
  @override
  Future<EmployeeView> build(String authUserId) {
    return ref
        .read(employeeRepositoryProvider)
        .get(UuidValue.fromString(authUserId));
  }

  Future<void> setEnabled(bool isEnabled) async {
    final current = state.asData?.value;
    if (current == null) {
      return;
    }
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final updated = await ref
          .read(employeeRepositoryProvider)
          .setEnabled(authUserId: current.authUserId, isEnabled: isEnabled);
      await ref
          .read(employeesViewModelProvider(current.buildingId.uuid).notifier)
          .refresh();
      return updated;
    });
  }
}
