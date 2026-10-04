// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Backoffice user list plus create, update, enable, and delete.

@ProviderFor(UsersViewModel)
const usersViewModelProvider = UsersViewModelProvider._();

/// Backoffice user list plus create, update, enable, and delete.
final class UsersViewModelProvider
    extends $AsyncNotifierProvider<UsersViewModel, SuperAdminPage> {
  /// Backoffice user list plus create, update, enable, and delete.
  const UsersViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'usersViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$usersViewModelHash();

  @$internal
  @override
  UsersViewModel create() => UsersViewModel();
}

String _$usersViewModelHash() => r'da878d07a3fcb3a501715011a5febf366c13c3b7';

/// Backoffice user list plus create, update, enable, and delete.

abstract class _$UsersViewModel extends $AsyncNotifier<SuperAdminPage> {
  FutureOr<SuperAdminPage> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<SuperAdminPage>, SuperAdminPage>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SuperAdminPage>, SuperAdminPage>,
              AsyncValue<SuperAdminPage>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
