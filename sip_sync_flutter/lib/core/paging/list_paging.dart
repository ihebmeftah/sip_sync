import 'package:flutter/widgets.dart';

/// Rows requested from list endpoints. Matches the server default.
const listPageSize = 20;

/// True when a vertical list is within [threshold] pixels of its end.
bool nearListEnd(ScrollNotification notification, {double threshold = 480}) {
  if (notification.metrics.axis != Axis.vertical) {
    return false;
  }
  return notification.metrics.extentAfter < threshold;
}
