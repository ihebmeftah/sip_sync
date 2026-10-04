// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'packs_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Pack catalog plus create, update, and delete.

@ProviderFor(PacksViewModel)
const packsViewModelProvider = PacksViewModelProvider._();

/// Pack catalog plus create, update, and delete.
final class PacksViewModelProvider
    extends $AsyncNotifierProvider<PacksViewModel, List<PackView>> {
  /// Pack catalog plus create, update, and delete.
  const PacksViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'packsViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$packsViewModelHash();

  @$internal
  @override
  PacksViewModel create() => PacksViewModel();
}

String _$packsViewModelHash() => r'246903f9ed35f94637c2e09930e3be7601c2c7b4';

/// Pack catalog plus create, update, and delete.

abstract class _$PacksViewModel extends $AsyncNotifier<List<PackView>> {
  FutureOr<List<PackView>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<PackView>>, List<PackView>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<PackView>>, List<PackView>>,
              AsyncValue<List<PackView>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
