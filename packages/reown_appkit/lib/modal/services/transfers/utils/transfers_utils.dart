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
