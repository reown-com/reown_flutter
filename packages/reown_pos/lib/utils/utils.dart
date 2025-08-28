class CurrencyUtils {
  static String ethToHexWei(String ethAmount) {
    final parsed = double.tryParse(ethAmount);
    if (parsed == null) throw ArgumentError('Invalid ETH string amount');
    final weiAmount = BigInt.from(parsed * 1e18);
    return '0x${weiAmount.toRadixString(16)}';
  }
}
