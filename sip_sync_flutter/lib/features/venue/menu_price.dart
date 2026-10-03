/// Menu price plus the venue currency, always with two decimals.
String formatMenuPrice(double price, String currencyCode) {
  return '${price.toStringAsFixed(2)} $currencyCode';
}

/// Recipe names as `Mint . Lemon`. Empty when the dish has no ingredients.
String formatIngredientLine(List<String> names) {
  return names
      .map((name) => name.trim())
      .where((name) => name.isNotEmpty)
      .join(' . ');
}
