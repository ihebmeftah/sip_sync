// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredients_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Full ingredient catalog for recipe editors.

@ProviderFor(ingredientCatalog)
const ingredientCatalogProvider = IngredientCatalogFamily._();

/// Full ingredient catalog for recipe editors.

final class IngredientCatalogProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<IngredientView>>,
          List<IngredientView>,
          FutureOr<List<IngredientView>>
        >
    with
        $FutureModifier<List<IngredientView>>,
        $FutureProvider<List<IngredientView>> {
  /// Full ingredient catalog for recipe editors.
  const IngredientCatalogProvider._({
    required IngredientCatalogFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'ingredientCatalogProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$ingredientCatalogHash();

  @override
  String toString() {
    return r'ingredientCatalogProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<IngredientView>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<IngredientView>> create(Ref ref) {
    final argument = this.argument as String;
    return ingredientCatalog(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is IngredientCatalogProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$ingredientCatalogHash() => r'68deeea6a1bb89bdd7a4d81b638422e7d678abdb';

/// Full ingredient catalog for recipe editors.

final class IngredientCatalogFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<IngredientView>>, String> {
  const IngredientCatalogFamily._()
    : super(
        retry: null,
        name: r'ingredientCatalogProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Full ingredient catalog for recipe editors.

  IngredientCatalogProvider call(String buildingId) =>
      IngredientCatalogProvider._(argument: buildingId, from: this);

  @override
  String toString() => r'ingredientCatalogProvider';
}

@ProviderFor(IngredientsViewModel)
const ingredientsViewModelProvider = IngredientsViewModelFamily._();

final class IngredientsViewModelProvider
    extends $AsyncNotifierProvider<IngredientsViewModel, IngredientPage> {
  const IngredientsViewModelProvider._({
    required IngredientsViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'ingredientsViewModelProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$ingredientsViewModelHash();

  @override
  String toString() {
    return r'ingredientsViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  IngredientsViewModel create() => IngredientsViewModel();

  @override
  bool operator ==(Object other) {
    return other is IngredientsViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$ingredientsViewModelHash() =>
    r'7183c62dd2fc571d234d75767257823b9283348f';

final class IngredientsViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          IngredientsViewModel,
          AsyncValue<IngredientPage>,
          IngredientPage,
          FutureOr<IngredientPage>,
          String
        > {
  const IngredientsViewModelFamily._()
    : super(
        retry: null,
        name: r'ingredientsViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  IngredientsViewModelProvider call(String buildingId) =>
      IngredientsViewModelProvider._(argument: buildingId, from: this);

  @override
  String toString() => r'ingredientsViewModelProvider';
}

abstract class _$IngredientsViewModel extends $AsyncNotifier<IngredientPage> {
  late final _$args = ref.$arg as String;
  String get buildingId => _$args;

  FutureOr<IngredientPage> build(String buildingId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<IngredientPage>, IngredientPage>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<IngredientPage>, IngredientPage>,
              AsyncValue<IngredientPage>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
