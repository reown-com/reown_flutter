String scaleAmountToBaseUnits(String amount, int decimals) {
  final normalized = amount.trim();
  final match = RegExp(r'^(\d*)(?:\.(\d*))?$').firstMatch(normalized);
  if (match == null) {
    throw ArgumentError('Invalid amount format: $amount');
  }

  final intPart = (match.group(1)!.isEmpty) ? '0' : match.group(1)!;
  final fracPart = match.group(2) ?? '';

  if (fracPart.length > decimals) {
    final truncated = fracPart.substring(0, decimals);
    return BigInt.parse(intPart + truncated).toString();
  } else {
    final padded = fracPart.padRight(decimals, '0');
    return BigInt.parse(intPart + padded).toString();
  }
}

final Map<String, String> DEAD_ADDRESSES_BY_NAMESPACE = {
  'eip155': '0x000000000000000000000000000000000000dead',
  'solana': 'CbKGgVKLJFb8bBrf58DnAkdryX6ubewVytn7X957YwNr',
  'bip122': 'bc1q4vxn43l44h30nkluqfxd9eckf45vr2awz38lwa',
};

/// Converts a human-readable token amount string to BigInt in smallest units
/// Equivalent to JavaScript's parseUnits(value, decimals)
BigInt parseUnits(String value, int decimals) {
  // Remove any whitespace
  value = value.trim();

  // Split by decimal point
  final parts = value.split('.');
  final integerPart = parts[0].replaceAll(RegExp(r'^[+-]?0*'), '');
  final decimalPart = parts.length > 1 ? parts[1] : '';

  // Pad decimal part to exactly match decimals
  final paddedDecimal = decimalPart.padRight(decimals, '0');

  // Truncate if too long
  final adjustedDecimal = paddedDecimal.length > decimals
      ? paddedDecimal.substring(0, decimals)
      : paddedDecimal;

  // Combine and parse
  final combined = integerPart + adjustedDecimal;

  if (combined.isEmpty) return BigInt.zero;

  // Handle negative
  if (value.startsWith('-')) {
    return -BigInt.parse(combined);
  }

  return BigInt.parse(combined);
}
