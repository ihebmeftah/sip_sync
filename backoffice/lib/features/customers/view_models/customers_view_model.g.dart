// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customers_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Platform owner and customer lists for the backoffice console.

@ProviderFor(CustomersViewModel)
const customersViewModelProvider = CustomersViewModelProvider._();

/// Platform owner and customer lists for the backoffice console.
final class CustomersViewModelProvider
    extends $AsyncNotifierProvider<CustomersViewModel, PlatformDirectoryState> {
  /// Platform owner and customer lists for the backoffice console.
  const CustomersViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'customersViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$customersViewModelHash();

  @$internal
  @override
  CustomersViewModel create() => CustomersViewModel();
}

String _$customersViewModelHash() =>
    r'abb03858975aa9f3359d9f41d81daa663671d79e';

/// Platform owner and customer lists for the backoffice console.

abstract class _$CustomersViewModel
    extends $AsyncNotifier<PlatformDirectoryState> {
  FutureOr<PlatformDirectoryState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<PlatformDirectoryState>, PlatformDirectoryState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<PlatformDirectoryState>,
                PlatformDirectoryState
              >,
              AsyncValue<PlatformDirectoryState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
