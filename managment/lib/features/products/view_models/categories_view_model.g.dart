// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Full category catalog for forms and the order wizard.

@ProviderFor(categoryCatalog)
const categoryCatalogProvider = CategoryCatalogFamily._();

/// Full category catalog for forms and the order wizard.

final class CategoryCatalogProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<MenuCategoryView>>,
          List<MenuCategoryView>,
          FutureOr<List<MenuCategoryView>>
        >
    with
        $FutureModifier<List<MenuCategoryView>>,
        $FutureProvider<List<MenuCategoryView>> {
  /// Full category catalog for forms and the order wizard.
  const CategoryCatalogProvider._({
    required CategoryCatalogFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'categoryCatalogProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$categoryCatalogHash();

  @override
  String toString() {
    return r'categoryCatalogProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<MenuCategoryView>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<MenuCategoryView>> create(Ref ref) {
    final argument = this.argument as String;
    return categoryCatalog(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CategoryCatalogProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$categoryCatalogHash() => r'4e3bd52bd7e8e2fa38bf9ce6d0d165abc1bec65b';

/// Full category catalog for forms and the order wizard.

final class CategoryCatalogFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<MenuCategoryView>>, String> {
  const CategoryCatalogFamily._()
    : super(
        retry: null,
        name: r'categoryCatalogProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Full category catalog for forms and the order wizard.

  CategoryCatalogProvider call(String buildingId) =>
      CategoryCatalogProvider._(argument: buildingId, from: this);

  @override
  String toString() => r'categoryCatalogProvider';
}

@ProviderFor(CategoriesViewModel)
const categoriesViewModelProvider = CategoriesViewModelFamily._();

final class CategoriesViewModelProvider
    extends $AsyncNotifierProvider<CategoriesViewModel, MenuCategoryPage> {
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
    r'79286e700261c11b535bd67fcd70d597e49fcadc';

final class CategoriesViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          CategoriesViewModel,
          AsyncValue<MenuCategoryPage>,
          MenuCategoryPage,
          FutureOr<MenuCategoryPage>,
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

abstract class _$CategoriesViewModel extends $AsyncNotifier<MenuCategoryPage> {
  late final _$args = ref.$arg as String;
  String get buildingId => _$args;

  FutureOr<MenuCategoryPage> build(String buildingId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref as $Ref<AsyncValue<MenuCategoryPage>, MenuCategoryPage>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<MenuCategoryPage>, MenuCategoryPage>,
              AsyncValue<MenuCategoryPage>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
