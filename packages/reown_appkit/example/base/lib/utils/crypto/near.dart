enum NearMethods {
  nearSignMessage,
  nearSignTransaction,
  nearSignTransactions,
  // nearSignAndSendTransaction,
  // nearRequestSignTransactions,
}

enum NearEvents {
  chainChanged,
  accountsChanged,
}

class Near {
  static final Map<NearMethods, String> methods = {
    NearMethods.nearSignMessage: 'near_signMessage',
    NearMethods.nearSignTransaction: 'near_signTransaction',
    NearMethods.nearSignTransactions: 'near_signTransactions',
  };

  static final Map<NearEvents, String> events = {
    NearEvents.chainChanged: 'chainChanged',
    NearEvents.accountsChanged: 'accountsChanged',
  };

  // https://github.com/near/wallet-selector/blob/dd19db77feee3941b4f53d2e3e1e4b74420f11c6/packages/wallet-connect/src/lib/wallet-connect.ts#L313
  static Map<String, dynamic> get demoMessage => {
        'message': 'Welcome to Flutter AppKit on Near',
        'nonce': '123456789',
        'recipient': 'bob.near',
        // 'callbackUrl': 'https://example.com/callback'
      };

  // https://github.com/near/wallet-selector/blob/dd19db77feee3941b4f53d2e3e1e4b74420f11c6/packages/wallet-connect/src/lib/wallet-connect.ts#L333
  static Map<String, dynamic> get demoTransaction => {
        'signerId': 'alice.near',
        'publicKey':
            'ed25519:3u1Qw2k5v6y7z8x9w0v1u2t3s4r5q6p7o8n9m0l1k2j3h4g5f6d7s8a9b0c1d2e3',
        'receiverId': 'bob.near',
        'nonce': 123456,
        'actions': [
          {
            'type': 'Transfer',
            'params': {
              'deposit': '1000000000000000000000000',
            }
          }
        ],
        'blockHash':
            '9N8Q7W6E5R4T3Y2U1I0O9P8L7K6J5H4G3F2D1S0A9B8C7D6E5F4G3H2J1K0L9M8N7'
      };
}
