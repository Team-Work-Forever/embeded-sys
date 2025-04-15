class GroupingHelper {
  static Map<K, List<T>> groupAndSort<T, K>({
    required List<T> items,
    required K Function(T item) groupBy,
    int Function(K a, K b)? groupSort,
    int Function(T a, T b)? itemSort,
  }) {
    final Map<K, List<T>> grouped = {};

    for (final item in items) {
      final key = groupBy(item);
      grouped.putIfAbsent(key, () => []).add(item);
    }

    for (final list in grouped.values) {
      if (itemSort != null) {
        list.sort(itemSort);
      }
    }

    final entries = grouped.entries.toList();
    if (groupSort != null) {
      entries.sort((a, b) => groupSort(a.key, b.key));
    }

    return Map.fromEntries(entries);
  }
}
