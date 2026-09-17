import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

/// Persists the opaque bearer token and actor session for management.
class AppSessionStore extends ChangeNotifier implements ClientAuthKeyProvider {
  AppSessionStore();

  static const _tokenKey = 'sip_mgmt_token';
  static const _refreshKey = 'sip_mgmt_refresh';
  static const _actorKey = 'sip_mgmt_actor';
  static const _sessionKey = 'sip_mgmt_session';

  String? _token;
  String? refreshToken;
  ActorType? _actorType;
  OwnerSessionView? owner;
  EmployeeSessionView? employee;

  String? get token => _token;
  ActorType? get actorType => _actorType;
  bool get isSignedIn => _token != null && _token!.isNotEmpty;

  bool get isOwner => _actorType == ActorType.owner;
  bool get isEmployee => _actorType == ActorType.employee;

  UuidValue? get employeeBuildingId => employee?.buildingId;

  UuidValue? get actorId => owner?.id ?? employee?.id;

  @override
  Future<String?> get authHeaderValue async {
    final t = _token;
    if (t == null || t.isEmpty) {
      return null;
    }
    return wrapAsBearerAuthHeaderValue(t);
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString(_tokenKey);
    refreshToken = prefs.getString(_refreshKey);
    final actor = prefs.getString(_actorKey);
    _actorType = switch (actor) {
      'owner' => ActorType.owner,
      'employee' => ActorType.employee,
      _ => null,
    };
    _readSessionJson(prefs.getString(_sessionKey));
    notifyListeners();
  }

  void _readSessionJson(String? raw) {
    if (raw == null || raw.isEmpty) {
      return;
    }
    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      if (_actorType == ActorType.owner) {
        owner = OwnerSessionView.fromJson(map);
      } else if (_actorType == ActorType.employee) {
        employee = EmployeeSessionView.fromJson(map);
      }
    } catch (_) {
      owner = null;
      employee = null;
    }
  }

  Future<void> _persistSessionJson() async {
    final prefs = await SharedPreferences.getInstance();
    final Map<String, dynamic>? json = owner?.toJson() ?? employee?.toJson();
    if (json == null) {
      await prefs.remove(_sessionKey);
      return;
    }
    await prefs.setString(_sessionKey, jsonEncode(json));
  }

  Future<void> applyAuth(AuthTokenResult result) async {
    _token = result.token;
    refreshToken = result.refreshToken;
    _actorType = result.actorType;
    owner = result.owner;
    employee = result.employee;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, result.token);
    await prefs.setString(_refreshKey, result.refreshToken);
    await prefs.setString(_actorKey, result.actorType.name);
    await _persistSessionJson();
    notifyListeners();
  }

  Future<void> setOwner(OwnerSessionView view) async {
    owner = view;
    _actorType = ActorType.owner;
    await _persistSessionJson();
    notifyListeners();
  }

  Future<void> setEmployee(EmployeeSessionView view) async {
    employee = view;
    _actorType = ActorType.employee;
    await _persistSessionJson();
    notifyListeners();
  }

  Future<void> clear() async {
    _token = null;
    refreshToken = null;
    _actorType = null;
    owner = null;
    employee = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_refreshKey);
    await prefs.remove(_actorKey);
    await prefs.remove(_sessionKey);
    notifyListeners();
  }
}
