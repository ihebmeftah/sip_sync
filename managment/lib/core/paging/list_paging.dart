import 'package:flutter/widgets.dart';

/// Rows requested from list endpoints. Matches the server default.
const listPageSize = 20;

/// Walks pages of at most 100 rows until [total] is reached.
///
/// Pickers (category menus, recipe ingredients, access profiles) need the
/// whole catalog. List screens stay on one page.
Future<List<T>> collectPages<T>({
  required Future<({List<T> items, int total})> Function(int offset) load,
}) async {
  final all = <T>[];
  var offset = 0;
  while (true) {
    final page = await load(offset);
    if (page.items.isEmpty) {
      return all;
    }
    all.addAll(page.items);
    offset += page.items.length;
    if (offset >= page.total) {
      return all;
    }
  }
}

/// True when a vertical list is within [threshold] pixels of its end.
bool nearListEnd(ScrollNotification notification, {double threshold = 480}) {
  if (notification.metrics.axis != Axis.vertical) {
    return false;
  }
  return notification.metrics.extentAfter < threshold;
}
