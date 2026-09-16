/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'package:sip_sync_client/src/protocol/protocol.dart' as _iozg9o5r;
import '../auth/profile_view.dart' as _ihlmgtq9;

abstract class BackofficeUserView
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  BackofficeUserView._({
    required this.profile,
    required this.isAdmin,
    required this.isSystemDefault,
  });

  factory BackofficeUserView({
    required _ihlmgtq9.ProfileView profile,
    required bool isAdmin,
    required bool isSystemDefault,
  }) = _BackofficeUserViewImpl;

  factory BackofficeUserView.fromJson(Map<String, dynamic> jsonSerialization) {
    return BackofficeUserView(
      profile: _iozg9o5r.Protocol().deserialize<_ihlmgtq9.ProfileView>(
        jsonSerialization['profile'],
      ),
      isAdmin: _isc.BoolJsonExtension.fromJson(jsonSerialization['isAdmin']),
      isSystemDefault: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['isSystemDefault'],
      ),
    );
  }

  _ihlmgtq9.ProfileView profile;

  bool isAdmin;

  bool isSystemDefault;

  /// Returns a shallow copy of this [BackofficeUserView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  BackofficeUserView copyWith({
    _ihlmgtq9.ProfileView? profile,
    bool? isAdmin,
    bool? isSystemDefault,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BackofficeUserView',
      'profile': profile.toJson(),
      'isAdmin': isAdmin,
      'isSystemDefault': isSystemDefault,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BackofficeUserView',
      'profile': profile.toJsonForProtocol(),
      'isAdmin': isAdmin,
      'isSystemDefault': isSystemDefault,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _BackofficeUserViewImpl extends BackofficeUserView {
  _BackofficeUserViewImpl({
    required _ihlmgtq9.ProfileView profile,
    required bool isAdmin,
    required bool isSystemDefault,
  }) : super._(
         profile: profile,
         isAdmin: isAdmin,
         isSystemDefault: isSystemDefault,
       );

  /// Returns a shallow copy of this [BackofficeUserView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  BackofficeUserView copyWith({
    _ihlmgtq9.ProfileView? profile,
    bool? isAdmin,
    bool? isSystemDefault,
  }) {
    return BackofficeUserView(
      profile: profile ?? this.profile.copyWith(),
      isAdmin: isAdmin ?? this.isAdmin,
      isSystemDefault: isSystemDefault ?? this.isSystemDefault,
    );
  }
}
