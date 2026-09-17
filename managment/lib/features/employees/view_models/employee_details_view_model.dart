import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import 'employees_view_model.dart';

part 'employee_details_view_model.g.dart';

/// Loads a single employee; keeps prior data while toggling enabled.
@riverpod
class EmployeeDetailsViewModel extends _$EmployeeDetailsViewModel {
  @override
  Future<EmployeeView> build(String employeeId) async {
    final id = _parseId(employeeId);
    return ref.read(employeeRepositoryProvider).get(id);
  }

  Future<void> setEnabled(bool isEnabled) async {
    final current = state.asData?.value;
    if (current == null) {
      return;
    }

    // Optimistic update — keep the profile mounted (bare AsyncLoading can
    // dispose the Switch mid-gesture and crash, especially on web).
    state = AsyncData(current.copyWith(isEnabled: isEnabled));

    try {
      final updated = await ref
          .read(employeeRepositoryProvider)
          .setEnabled(id: current.id, isEnabled: isEnabled);
      state = AsyncData(updated);
      await ref
          .read(employeesViewModelProvider(updated.buildingId.uuid).notifier)
          .refresh();
    } catch (error, stackTrace) {
      state = AsyncData(current);
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  static UuidValue _parseId(String raw) {
    final trimmed = raw.trim();
    if (trimmed.isEmpty) {
      throw const FormatException('Missing employee id');
    }
    return UuidValue.fromString(trimmed);
  }
}
