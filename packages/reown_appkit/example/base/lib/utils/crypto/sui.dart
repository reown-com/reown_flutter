class Sui {
  static final List<String> methods = [
    'sui_signPersonalMessage',
    // 'sui_signTransaction',
    // 'sui_signAndExecuteTransaction'
  ];
  static final List<String> events = [];

  static Map<String, dynamic> suiSignPersonalMessage({
    required String chainId,
    required String walletAdress,
  }) {
    return {
      'message': 'Welcome to Flutter AppKit on Sui ($chainId)',
      'address': walletAdress,
    };
  }
}
