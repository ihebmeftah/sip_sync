// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_composition_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ArticleCompositionViewModel)
const articleCompositionViewModelProvider =
    ArticleCompositionViewModelFamily._();

final class ArticleCompositionViewModelProvider
    extends
        $AsyncNotifierProvider<
          ArticleCompositionViewModel,
          List<ArticleCompositionView>
        > {
  const ArticleCompositionViewModelProvider._({
    required ArticleCompositionViewModelFamily super.from,
    required ({String buildingId, String articleId}) super.argument,
  }) : super(
         retry: null,
         name: r'articleCompositionViewModelProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$articleCompositionViewModelHash();

  @override
  String toString() {
    return r'articleCompositionViewModelProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  ArticleCompositionViewModel create() => ArticleCompositionViewModel();

  @override
  bool operator ==(Object other) {
    return other is ArticleCompositionViewModelProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$articleCompositionViewModelHash() =>
    r'b12d5d2cadd4b10e8b05345b31c8f1bc1c658d78';

final class ArticleCompositionViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          ArticleCompositionViewModel,
          AsyncValue<List<ArticleCompositionView>>,
          List<ArticleCompositionView>,
          FutureOr<List<ArticleCompositionView>>,
          ({String buildingId, String articleId})
        > {
  const ArticleCompositionViewModelFamily._()
    : super(
        retry: null,
        name: r'articleCompositionViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  ArticleCompositionViewModelProvider call({
    required String buildingId,
    required String articleId,
  }) => ArticleCompositionViewModelProvider._(
    argument: (buildingId: buildingId, articleId: articleId),
    from: this,
  );

  @override
  String toString() => r'articleCompositionViewModelProvider';
}

abstract class _$ArticleCompositionViewModel
    extends $AsyncNotifier<List<ArticleCompositionView>> {
  late final _$args = ref.$arg as ({String buildingId, String articleId});
  String get buildingId => _$args.buildingId;
  String get articleId => _$args.articleId;

  FutureOr<List<ArticleCompositionView>> build({
    required String buildingId,
    required String articleId,
  });
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(
      buildingId: _$args.buildingId,
      articleId: _$args.articleId,
    );
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<ArticleCompositionView>>,
              List<ArticleCompositionView>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<ArticleCompositionView>>,
                List<ArticleCompositionView>
              >,
              AsyncValue<List<ArticleCompositionView>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
