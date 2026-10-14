// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredients_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// When true, the ingredient list shows only rows with no current stock.

@ProviderFor(IngredientListFilter)
const ingredientListFilterProvider = IngredientListFilterFamily._();

/// When true, the ingredient list shows only rows with no current stock.
final class IngredientListFilterProvider
    extends $NotifierProvider<IngredientListFilter, bool> {
  /// When true, the ingredient list shows only rows with no current stock.
  const IngredientListFilterProvider._({
    required IngredientListFilterFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'ingredientListFilterProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$ingredientListFilterHash();

  @override
  String toString() {
    return r'ingredientListFilterProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  IngredientListFilter create() => IngredientListFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is IngredientListFilterProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$ingredientListFilterHash() =>
    r'bf4bd434843c90db9047622ba5cc40e59c3d3c2e';

/// When true, the ingredient list shows only rows with no current stock.

final class IngredientListFilterFamily extends $Family
    with $ClassFamilyOverride<IngredientListFilter, bool, bool, bool, String> {
  const IngredientListFilterFamily._()
    : super(
        retry: null,
        name: r'ingredientListFilterProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// When true, the ingredient list shows only rows with no current stock.

  IngredientListFilterProvider call(String buildingId) =>
      IngredientListFilterProvider._(argument: buildingId, from: this);

  @override
  String toString() => r'ingredientListFilterProvider';
}

/// When true, the ingredient list shows only rows with no current stock.

abstract class _$IngredientListFilter extends $Notifier<bool> {
  late final _$args = ref.$arg as String;
  String get buildingId => _$args;

  bool build(String buildingId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

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
    r'248d9af7cbaba8962192644559c93c9f399de231';

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

/// Ingredients with nothing left. Products and Ingredients show this count.

@ProviderFor(OutOfStockIngredientCount)
const outOfStockIngredientCountProvider = OutOfStockIngredientCountFamily._();

/// Ingredients with nothing left. Products and Ingredients show this count.
final class OutOfStockIngredientCountProvider
    extends $AsyncNotifierProvider<OutOfStockIngredientCount, int> {
  /// Ingredients with nothing left. Products and Ingredients show this count.
  const OutOfStockIngredientCountProvider._({
    required OutOfStockIngredientCountFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'outOfStockIngredientCountProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$outOfStockIngredientCountHash();

  @override
  String toString() {
    return r'outOfStockIngredientCountProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  OutOfStockIngredientCount create() => OutOfStockIngredientCount();

  @override
  bool operator ==(Object other) {
    return other is OutOfStockIngredientCountProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$outOfStockIngredientCountHash() =>
    r'0956bb410773260e24386bdd281eb2bd2e0d5b95';

/// Ingredients with nothing left. Products and Ingredients show this count.

final class OutOfStockIngredientCountFamily extends $Family
    with
        $ClassFamilyOverride<
          OutOfStockIngredientCount,
          AsyncValue<int>,
          int,
          FutureOr<int>,
          String
        > {
  const OutOfStockIngredientCountFamily._()
    : super(
        retry: null,
        name: r'outOfStockIngredientCountProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Ingredients with nothing left. Products and Ingredients show this count.

  OutOfStockIngredientCountProvider call(String buildingId) =>
      OutOfStockIngredientCountProvider._(argument: buildingId, from: this);

  @override
  String toString() => r'outOfStockIngredientCountProvider';
}

/// Ingredients with nothing left. Products and Ingredients show this count.

abstract class _$OutOfStockIngredientCount extends $AsyncNotifier<int> {
  late final _$args = ref.$arg as String;
  String get buildingId => _$args;

  FutureOr<int> build(String buildingId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<int>, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<int>, int>,
              AsyncValue<int>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
