// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredients_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(IngredientsViewModel)
const ingredientsViewModelProvider = IngredientsViewModelFamily._();

final class IngredientsViewModelProvider
    extends $AsyncNotifierProvider<IngredientsViewModel, List<IngredientView>> {
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
    r'824c4ef182db2d2cb98e10213969c993ff49263f';

final class IngredientsViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          IngredientsViewModel,
          AsyncValue<List<IngredientView>>,
          List<IngredientView>,
          FutureOr<List<IngredientView>>,
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

abstract class _$IngredientsViewModel
    extends $AsyncNotifier<List<IngredientView>> {
  late final _$args = ref.$arg as String;
  String get buildingId => _$args;

  FutureOr<List<IngredientView>> build(String buildingId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref
            as $Ref<AsyncValue<List<IngredientView>>, List<IngredientView>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<IngredientView>>,
                List<IngredientView>
              >,
              AsyncValue<List<IngredientView>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
