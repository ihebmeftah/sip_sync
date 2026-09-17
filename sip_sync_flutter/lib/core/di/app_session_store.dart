import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

/// Persists the opaque bearer token and customer session.
class AppSessionStore extends ChangeNotifier implements ClientAuthKeyProvider {
  AppSessionStore();

  static const _tokenKey = 'sip_customer_token';
  static const _refreshKey = 'sip_customer_refresh';
  static const _sessionKey = 'sip_customer_session';

  String? _token;
  String? refreshToken;
  CustomerSessionView? customer;

  String? get token => _token;
  bool get isSignedIn => _token != null && _token!.isNotEmpty;

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
    final raw = prefs.getString(_sessionKey);
    if (raw != null && raw.isNotEmpty) {
      try {
        customer = CustomerSessionView.fromJson(
          jsonDecode(raw) as Map<String, dynamic>,
        );
      } catch (_) {
        customer = null;
      }
    }
    notifyListeners();
  }

  Future<void> _persistSession() async {
    final prefs = await SharedPreferences.getInstance();
    final view = customer;
    if (view == null) {
      await prefs.remove(_sessionKey);
      return;
    }
    await prefs.setString(_sessionKey, jsonEncode(view.toJson()));
  }

  Future<void> applyAuth(AuthTokenResult result) async {
    _token = result.token;
    refreshToken = result.refreshToken;
    customer = result.customer;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, result.token);
    await prefs.setString(_refreshKey, result.refreshToken);
    await _persistSession();
    notifyListeners();
  }

  Future<void> setCustomer(CustomerSessionView view) async {
    customer = view;
    await _persistSession();
    notifyListeners();
  }

  Future<void> clear() async {
    _token = null;
    refreshToken = null;
    customer = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_refreshKey);
    await prefs.remove(_sessionKey);
    notifyListeners();
  }
}
