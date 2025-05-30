import 'dart:math';

import 'dart:typed_data';
// import 'package:bs58/bs58.dart';

enum NearMethods {
  nearSignMessage,
  nearSignTransaction,
  nearSignTransactions,
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

  static Uint8List _generateBase64Nonce() {
    final random = Random.secure();
    return Uint8List.fromList(List.generate(32, (_) => random.nextInt(256)));
  }

  // https://github.com/near/wallet-selector/blob/dd19db77feee3941b4f53d2e3e1e4b74420f11c6/packages/wallet-connect/src/lib/wallet-connect.ts#L313
  static Map<String, dynamic> demoMessageParams(String address) => {
        'message': 'Welcome to Flutter AppKit on Near',
        'nonce': _generateBase64Nonce(),
        'recipient': address, // could be also in the form of 'myaccount.near'
        // 'callbackUrl': 'mydapp://', // Optional, for redirect after signing
        // 'accountId': '<optional>',       // If multiple accounts are connected
      };

  // https://github.com/near/wallet-selector/blob/dd19db77feee3941b4f53d2e3e1e4b74420f11c6/packages/wallet-connect/src/lib/wallet-connect.ts#L333
  static Map<String, dynamic> demoNEARTransferParams(
    String address,
    String pubKey,
  ) =>
      {
        'signerId': address,
        'publicKey': pubKey,
        'receiverId': address,
        'nonce': _generateBase64Nonce(),
        'blockHash': '772yv3sStrcpwY7h33wM5byeox5xZxNGtmyGGQvezMy5',
        'actions': [
          {
            'type': 'Transfer',
            'params': {
              'deposit':
                  '1000000000000000000000000' // 1 NEAR in yoctoNEAR (1e24)
            }
          }
        ]
      };

  static Map<String, dynamic> demoUSDCTransfer(
    String address,
    String pubKey,
  ) =>
      {
        'signerId': address,
        'publicKey': pubKey,
        'receiverId': 'usdc.fakes.testnet', // contract address/id
        'nonce': _generateBase64Nonce(),
        'blockHash': '772yv3sStrcpwY7h33wM5byeox5xZxNGtmyGGQvezMy5',
        'actions': [
          {
            'type': 'FunctionCall',
            'params': {
              'methodName': 'ft_transfer',
              'args': {
                'receiver_id': address,
                'amount':
                    '1000000' // Amount in yocto (depending on token decimals)
              },
              'gas': '30000000000000', // 30 Tgas
              'deposit': '1' // 1 yoctoNEAR required for ft_transfer
            }
          }
        ]
      };

  static Map<String, dynamic> demoFromReactDapp(String address) => {
        'signerId': address,
        'receiverId': 'guest-book.testnet',
        'actions': [
          {
            'type': 'FunctionCall',
            'params': {
              'methodName': 'addMessage',
              'args': {'text': 'Hello from Wallet Connect!'},
              'gas': '30000000000000',
              'deposit': '0',
            },
          },
        ],
      };
}
