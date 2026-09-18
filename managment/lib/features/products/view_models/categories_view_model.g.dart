// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CategoriesViewModel)
const categoriesViewModelProvider = CategoriesViewModelFamily._();

final class CategoriesViewModelProvider
    extends
        $AsyncNotifierProvider<CategoriesViewModel, List<MenuCategoryView>> {
  const CategoriesViewModelProvider._({
    required CategoriesViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'categoriesViewModelProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$categoriesViewModelHash();

  @override
  String toString() {
    return r'categoriesViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CategoriesViewModel create() => CategoriesViewModel();

  @override
  bool operator ==(Object other) {
    return other is CategoriesViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$categoriesViewModelHash() =>
    r'22abcda4978b4fd0ac7e6ddfff477b800a24ed54';

final class CategoriesViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          CategoriesViewModel,
          AsyncValue<List<MenuCategoryView>>,
          List<MenuCategoryView>,
          FutureOr<List<MenuCategoryView>>,
          String
        > {
  const CategoriesViewModelFamily._()
    : super(
        retry: null,
        name: r'categoriesViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  CategoriesViewModelProvider call(String buildingId) =>
      CategoriesViewModelProvider._(argument: buildingId, from: this);

  @override
  String toString() => r'categoriesViewModelProvider';
}

abstract class _$CategoriesViewModel
    extends $AsyncNotifier<List<MenuCategoryView>> {
  late final _$args = ref.$arg as String;
  String get buildingId => _$args;

  FutureOr<List<MenuCategoryView>> build(String buildingId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref
            as $Ref<AsyncValue<List<MenuCategoryView>>, List<MenuCategoryView>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<MenuCategoryView>>,
                List<MenuCategoryView>
              >,
              AsyncValue<List<MenuCategoryView>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
