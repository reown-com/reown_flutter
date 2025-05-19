import 'dart:math';

import 'dart:typed_data';
import 'package:bs58/bs58.dart';

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

  static Uint8List toBorshBytes(Map<String, dynamic> txJson) {
    final writer = BorshWriter();

    // 1. signerId
    writer.writeString(txJson['signerId']);

    // 2. publicKey
    final publicKey = txJson['publicKey'] as String;
    final keyBytes = base58.decode(publicKey.split(':')[1]);
    writer.writeU8(0); // ed25519 = 0
    writer.writeFixedArray(keyBytes);

    // 3. nonce (u64) from bytes
    final nonceBytes = txJson['nonce'] as Uint8List;
    // if (nonceBytes.length != 8) {
    //   throw ArgumentError('Nonce must be exactly 8 bytes (u64)');
    // }
    writer.writeFixedArray(nonceBytes);

    // 4. receiverId
    writer.writeString(txJson['receiverId']);

    // 5. blockHash
    final blockHash = base58.decode(txJson['blockHash']);
    if (blockHash.length != 32) {
      throw ArgumentError('blockHash must decode to 32 bytes');
    }
    writer.writeFixedArray(blockHash);

    // 6. actions
    final actions = txJson['actions'] as List;
    writer.writeU32(actions.length);
    for (final action in actions) {
      final type = action['type'];
      final params = action['params'] ?? {};

      if (type == 'Transfer') {
        writer.writeU8(3); // Transfer enum value
        final deposit = BigInt.parse(params['deposit']);
        writer.writeU128(deposit);
      } else {
        throw UnimplementedError('Action type $type not supported');
      }
    }

    return writer.toBytes();
  }
}

class BorshWriter {
  final BytesBuilder _builder = BytesBuilder();

  Uint8List toBytes() => _builder.toBytes();

  void writeU8(int value) => _builder.addByte(value);
  void writeU32(int value) =>
      _builder.add(List.generate(4, (i) => (value >> (8 * i)) & 0xFF));
  void writeU64(BigInt value) => _builder.add(_writeLEBigInt(value, 8));
  void writeU128(BigInt value) => _builder.add(_writeLEBigInt(value, 16));
  void writeFixedArray(Uint8List bytes) => _builder.add(bytes);

  void writeString(String value) {
    final stringBytes = Uint8List.fromList(value.codeUnits);
    writeU32(stringBytes.length);
    _builder.add(stringBytes);
  }

  Uint8List _writeLEBigInt(BigInt number, int size) {
    final result = Uint8List(size);
    var temp = number;
    for (int i = 0; i < size; i++) {
      result[i] = (temp & BigInt.from(0xFF)).toInt();
      temp = temp >> 8;
    }
    return result;
  }
}
