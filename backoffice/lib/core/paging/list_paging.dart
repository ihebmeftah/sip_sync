/// Rows requested from list endpoints. Matches the server default.
const listPageSize = 20;

/// Walks pages of at most 100 rows until [total] is reached.
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
