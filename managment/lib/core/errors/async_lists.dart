import 'package:flutter_riverpod/flutter_riverpod.dart';

/// True only after [async] has loaded a list and that list is empty.
///
/// A first load or a refresh must not count as empty. Screens that say
/// "create X first" were treating a catalog still in flight as "there is no X".
bool isSettledEmpty<T>(AsyncValue<List<T>> async) {
  if (async.isLoading || async.hasError) {
    return false;
  }
  final items = async.asData?.value;
  return items != null && items.isEmpty;
}

/// The list when it has arrived. Null while the first load is still running
/// or the load failed before any value existed.
List<T>? settledList<T>(AsyncValue<List<T>> async) => async.asData?.value;
