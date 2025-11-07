class BIP122 {
  static final List<String> methods = [
    'signMessage',
    // 'sui_signTransaction',
    // 'sui_signAndExecuteTransaction'
  ];
  static final List<String> events = [];

  static Map<String, dynamic> signMessage({
    required String chainId,
    required String walletAdress,
  }) {
    return {
      'account': walletAdress,
      'message': 'Welcome to Flutter AppKit on Bitcoin ($chainId)',
    };
  }
}
