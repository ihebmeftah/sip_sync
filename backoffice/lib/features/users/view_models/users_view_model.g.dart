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
    extends $AsyncNotifierProvider<UsersViewModel, List<SuperAdminView>> {
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

String _$usersViewModelHash() => r'0650b76f86b1ef323d10ccd4280615494dc17f44';

/// Backoffice user list plus create, update, enable, and delete.

abstract class _$UsersViewModel extends $AsyncNotifier<List<SuperAdminView>> {
  FutureOr<List<SuperAdminView>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<List<SuperAdminView>>, List<SuperAdminView>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<SuperAdminView>>,
                List<SuperAdminView>
              >,
              AsyncValue<List<SuperAdminView>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
