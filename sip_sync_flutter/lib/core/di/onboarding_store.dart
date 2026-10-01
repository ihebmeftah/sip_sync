import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Remembers that the customer finished or skipped first-launch onboarding.
class OnboardingStore extends ChangeNotifier {
  static const _key = 'sip_customer_onboarding_done';

  bool _complete = false;

  bool get isComplete => _complete;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _complete = prefs.getBool(_key) ?? false;
    notifyListeners();
  }

  /// Marks onboarding done so later launches open sign-in or home.
  Future<void> complete() async {
    if (_complete) {
      return;
    }
    _complete = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, true);
    notifyListeners();
  }
}
