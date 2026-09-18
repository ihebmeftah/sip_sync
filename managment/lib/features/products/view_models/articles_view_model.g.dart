// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'articles_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ArticlesViewModel)
const articlesViewModelProvider = ArticlesViewModelFamily._();

final class ArticlesViewModelProvider
    extends $AsyncNotifierProvider<ArticlesViewModel, List<MenuArticleView>> {
  const ArticlesViewModelProvider._({
    required ArticlesViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'articlesViewModelProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$articlesViewModelHash();

  @override
  String toString() {
    return r'articlesViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ArticlesViewModel create() => ArticlesViewModel();

  @override
  bool operator ==(Object other) {
    return other is ArticlesViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$articlesViewModelHash() => r'7d2a893bdcdd78e4fc8155336903bab8ee7fad95';

final class ArticlesViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          ArticlesViewModel,
          AsyncValue<List<MenuArticleView>>,
          List<MenuArticleView>,
          FutureOr<List<MenuArticleView>>,
          String
        > {
  const ArticlesViewModelFamily._()
    : super(
        retry: null,
        name: r'articlesViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  ArticlesViewModelProvider call(String buildingId) =>
      ArticlesViewModelProvider._(argument: buildingId, from: this);

  @override
  String toString() => r'articlesViewModelProvider';
}

abstract class _$ArticlesViewModel
    extends $AsyncNotifier<List<MenuArticleView>> {
  late final _$args = ref.$arg as String;
  String get buildingId => _$args;

  FutureOr<List<MenuArticleView>> build(String buildingId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref
            as $Ref<AsyncValue<List<MenuArticleView>>, List<MenuArticleView>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<MenuArticleView>>,
                List<MenuArticleView>
              >,
              AsyncValue<List<MenuArticleView>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
