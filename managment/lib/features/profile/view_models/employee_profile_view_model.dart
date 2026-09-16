import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';

part 'employee_profile_view_model.g.dart';

@riverpod
class EmployeeProfileViewModel extends _$EmployeeProfileViewModel {
  @override
  Future<ProfileView> build(String authUserId) {
    return ref
        .read(accountRepositoryProvider)
        .getEmployee(UuidValue.fromString(authUserId));
  }
}
