import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../auth/view_models/auth_view_model.dart';

part 'articles_view_model.g.dart';

@Riverpod(keepAlive: true)
class ArticlesViewModel extends _$ArticlesViewModel {
  late String _buildingId;

  @override
  Future<List<MenuArticleView>> build(String buildingId) async {
    _buildingId = buildingId;
    ref.watch(signedInActorIdProvider);
    if (buildingId.isEmpty) {
      return const [];
    }
    return ref
        .read(menuArticleRepositoryProvider)
        .list(UuidValue.fromString(buildingId));
  }

  Future<void> refresh() async {
    state = await AsyncValue.guard(() async {
      if (_buildingId.isEmpty) {
        return const <MenuArticleView>[];
      }
      return ref
          .read(menuArticleRepositoryProvider)
          .list(UuidValue.fromString(_buildingId));
    });
  }

  Future<MenuArticleView> createArticle({
    required UuidValue categoryId,
    required String name,
    String? description,
    required double price,
  }) async {
    final saved = await ref
        .read(menuArticleRepositoryProvider)
        .create(
          buildingId: UuidValue.fromString(_buildingId),
          categoryId: categoryId,
          name: name,
          description: description,
          price: price,
        );
    await refresh();
    return saved;
  }

  Future<MenuArticleView> updateArticle({
    required UuidValue id,
    required UuidValue categoryId,
    required String name,
    String? description,
    required double price,
  }) async {
    final saved = await ref
        .read(menuArticleRepositoryProvider)
        .update(
          id: id,
          categoryId: categoryId,
          name: name,
          description: description,
          price: price,
        );
    await refresh();
    return saved;
  }
}
