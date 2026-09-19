import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../auth/view_models/auth_view_model.dart';
import 'articles_view_model.dart';

part 'article_composition_view_model.g.dart';

@Riverpod(keepAlive: true)
class ArticleCompositionViewModel extends _$ArticleCompositionViewModel {
  late String _articleId;
  late String _buildingId;

  @override
  Future<List<ArticleCompositionView>> build({
    required String buildingId,
    required String articleId,
  }) async {
    _buildingId = buildingId;
    _articleId = articleId;
    ref.watch(signedInActorIdProvider);
    if (articleId.isEmpty) {
      return const [];
    }
    return ref
        .read(articleCompositionRepositoryProvider)
        .list(UuidValue.fromString(articleId));
  }

  Future<void> refresh() async {
    state = await AsyncValue.guard(() async {
      if (_articleId.isEmpty) {
        return const <ArticleCompositionView>[];
      }
      return ref
          .read(articleCompositionRepositoryProvider)
          .list(UuidValue.fromString(_articleId));
    });
  }

  Future<void> addLine({
    required UuidValue ingredientId,
    required double quantity,
  }) async {
    await ref
        .read(articleCompositionRepositoryProvider)
        .create(
          articleId: UuidValue.fromString(_articleId),
          ingredientId: ingredientId,
          quantity: quantity,
        );
    await refresh();
    await ref.read(articlesViewModelProvider(_buildingId).notifier).refresh();
  }

  Future<void> updateQuantity({
    required UuidValue id,
    required double quantity,
  }) async {
    await ref
        .read(articleCompositionRepositoryProvider)
        .update(id: id, quantity: quantity);
    await refresh();
  }

  Future<void> removeLine(UuidValue id) async {
    await ref.read(articleCompositionRepositoryProvider).delete(id);
    await refresh();
    await ref.read(articlesViewModelProvider(_buildingId).notifier).refresh();
  }
}
