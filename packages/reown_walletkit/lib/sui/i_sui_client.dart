/// ---------------------------------
/// ⚠️ This client is experimental. Use with caution.
/// ---------------------------------
abstract class ISuiClient {
  /// ---------------------------------
  /// ⚠️ This method is experimental. Use with caution.
  /// ---------------------------------
  Future<void> init();

  /// ---------------------------------
  /// ⚠️ This method is experimental. Use with caution.
  /// ---------------------------------
  Future<String> generateKeyPair();

  /// ---------------------------------
  /// ⚠️ This method is experimental. Use with caution.
  /// ---------------------------------
  Future<String> getPublicKeyFromKeyPair({required String keyPair});

  /// ---------------------------------
  /// ⚠️ This method is experimental. Use with caution.
  /// ---------------------------------
  Future<String> getAddressFromPublicKey({required String publicKey});

  /// ---------------------------------
  /// ⚠️ This method is experimental. Use with caution.
  /// ---------------------------------
  Future<String> personalSign({
    required String keyPair,
    required String message,
  });

  /// ---------------------------------
  /// ⚠️ This method is experimental. Use with caution.
  /// ---------------------------------
  /// It returns a Record of (signature,transactionBytes)
  Future<(String, String)> signTransaction({
    required String chainId,
    required String keyPair,
    required String txData,
  });

  /// ---------------------------------
  /// ⚠️ This method is experimental. Use with caution.
  /// ---------------------------------
  Future<String> signAndExecuteTransaction({
    required String chainId,
    required String keyPair,
    required String txData,
  });
}
