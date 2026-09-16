import 'package:flutter/foundation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

/// Selected venue for ops screens. [GoRouter] listens so redirects can wait
/// until the owner picks a building.
class BuildingSession extends ChangeNotifier {
  List<BuildingView> buildings = const [];
  UuidValue? selectedId;
  bool loaded = false;

  BuildingView? get selected {
    for (final building in buildings) {
      if (building.id == selectedId) {
        return building;
      }
    }
    return null;
  }

  void replace(List<BuildingView> next) {
    buildings = next;
    if (selectedId != null && !next.any((b) => b.id == selectedId)) {
      selectedId = null;
    }
    loaded = true;
    notifyListeners();
  }

  void select(UuidValue id) {
    selectedId = id;
    notifyListeners();
  }

  void upsert(BuildingView building) {
    final next = [...buildings.where((b) => b.id != building.id), building];
    buildings = next;
    notifyListeners();
  }

  void clear() {
    buildings = const [];
    selectedId = null;
    loaded = false;
    notifyListeners();
  }
}
