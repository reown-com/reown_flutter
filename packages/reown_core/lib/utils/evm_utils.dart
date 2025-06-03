class EvmChainUtils {
  static bool isValidContractData(String data) {
    bool isValidData = false;

    try {
      // Ensure the data starts with '0x' for consistency
      if (data.startsWith('0x')) data = data.substring(2);
      if (data.isEmpty) return false;

      // Extract method ID (first 4 bytes)
      final methodId = data.substring(0, 8);
      isValidData = methodId.isNotEmpty;

      // Extract recipient address (next 32 bytes, right-padded with zeros)
      final recipient = data.substring(8, 72).replaceFirst(RegExp('^0+'), '');
      isValidData = recipient.isNotEmpty;

      // Extract amount (final 32 bytes, big-endian encoded)
      final amount = data.substring(72).replaceFirst(RegExp('^0+'), '');
      // final amount = BigInt.parse(amountHex, radix: 16);
      isValidData = amount.isNotEmpty;

      return isValidData;
    } catch (e) {
      rethrow;
    }
  }
}
