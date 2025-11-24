class Ton {
  static final List<String> methods = ['ton_signData'];
  static final List<String> events = [];

  static Map<String, dynamic> tonSignData({
    required String chainId,
    required String walletAdress,
  }) {
    return {
      'type': 'text',
      'text': 'Welcome to Flutter AppKit on Ton ($chainId)',
      'from': walletAdress,
    };
  }
}
