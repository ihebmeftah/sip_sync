import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/errors/error_mapper.dart';
import 'employees_view_model.dart';

part 'employee_form_view_model.g.dart';

class EmployeeFormState {
  const EmployeeFormState({
    this.existing,
    this.loading = false,
    this.saving = false,
    this.errorKey,
  });

  final EmployeeView? existing;
  final bool loading;
  final bool saving;
  final String? errorKey;

  EmployeeFormState copyWith({
    EmployeeView? existing,
    bool? loading,
    bool? saving,
    String? errorKey,
    bool clearError = false,
  }) {
    return EmployeeFormState(
      existing: existing ?? this.existing,
      loading: loading ?? this.loading,
      saving: saving ?? this.saving,
      errorKey: clearError ? null : (errorKey ?? this.errorKey),
    );
  }
}

@riverpod
class EmployeeFormViewModel extends _$EmployeeFormViewModel {
  @override
  EmployeeFormState build(String authUserId) {
    if (authUserId.isNotEmpty) {
      Future<void>.microtask(() => load(authUserId));
    }
    return EmployeeFormState(loading: authUserId.isNotEmpty);
  }

  Future<void> load(String authUserId) async {
    state = state.copyWith(loading: true, clearError: true);
    try {
      final existing = await ref
          .read(employeeRepositoryProvider)
          .get(UuidValue.fromString(authUserId));
      state = state.copyWith(existing: existing, loading: false);
    } catch (error) {
      state = state.copyWith(loading: false, errorKey: mapError(error).l10nKey);
    }
  }

  Future<EmployeeView?> save({
    required String password,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required UuidValue buildingId,
  }) async {
    state = state.copyWith(saving: true, clearError: true);
    try {
      final existing = state.existing;
      late final EmployeeView saved;
      if (existing == null) {
        saved = await ref
            .read(employeeRepositoryProvider)
            .add(
              password: password,
              phoneNumber: phoneNumber,
              firstName: firstName,
              lastName: lastName,
              buildingId: buildingId,
            );
      } else {
        saved = await ref
            .read(employeeRepositoryProvider)
            .update(
              authUserId: existing.authUserId,
              phoneNumber: phoneNumber,
              firstName: firstName,
              lastName: lastName,
            );
      }
      await ref
          .read(employeesViewModelProvider(buildingId.uuid).notifier)
          .refresh();
      state = state.copyWith(saving: false, existing: saved);
      return saved;
    } catch (error) {
      state = state.copyWith(saving: false, errorKey: mapError(error).l10nKey);
      return null;
    }
  }
}
