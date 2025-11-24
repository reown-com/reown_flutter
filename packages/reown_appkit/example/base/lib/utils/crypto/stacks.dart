class Stacks {
  static final List<String> methods = [
    'stx_signMessage',
    // 'stx_signTransaction',
    // 'stx_transferStx'
  ];
  static final List<String> events = [];

  static Map<String, dynamic> stxSignMessage({
    required String chainId,
    required String walletAdress,
  }) {
    return {
      'address': walletAdress,
      'message': 'Welcome to Flutter AppKit on Stacks ($chainId)',
      'messageType': 'utf8',
      // 'network': chainData.chainId,
      // 'domain': packageName,
    };
  }
}
