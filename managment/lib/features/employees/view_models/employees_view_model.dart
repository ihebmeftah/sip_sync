import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/paging/list_paging.dart';
import '../../auth/view_models/auth_view_model.dart';

part 'employees_view_model.g.dart';

@Riverpod(keepAlive: true)
class EmployeesViewModel extends _$EmployeesViewModel {
  late String _buildingId;
  var _offset = 0;

  @override
  Future<EmployeePage> build(String buildingId) async {
    _buildingId = buildingId;
    _offset = 0;
    ref.watch(signedInActorIdProvider);
    return _load();
  }

  Future<void> refresh() async {
    state = await AsyncValue.guard(_load);
  }

  Future<void> previousPage() => _show(_offset - listPageSize);

  Future<void> nextPage() => _show(_offset + listPageSize);

  Future<void> _show(int offset) async {
    _offset = offset < 0 ? 0 : offset;
    state = const AsyncLoading();
    state = await AsyncValue.guard(_load);
  }

  Future<EmployeePage> _load() async {
    final isOwner = ref.read(appSessionStoreProvider).isOwner;
    if (!isOwner || _buildingId.isEmpty) {
      return EmployeePage(
        items: const [],
        total: 0,
        limit: listPageSize,
        offset: 0,
      );
    }
    final page = await ref
        .read(buildingRepositoryProvider)
        .listEmployees(
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
}
