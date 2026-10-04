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
    extends $AsyncNotifierProvider<PacksViewModel, PackPage> {
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

String _$packsViewModelHash() => r'61f992442a4379f10ccea59ffc7f524dee665148';

/// Pack catalog plus create, update, and delete.

abstract class _$PacksViewModel extends $AsyncNotifier<PackPage> {
  FutureOr<PackPage> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<PackPage>, PackPage>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PackPage>, PackPage>,
              AsyncValue<PackPage>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
