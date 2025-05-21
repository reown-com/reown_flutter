import 'package:polkadart/polkadart.dart';
import 'package:convert/convert.dart';
import 'dart:typed_data';

import 'package:reown_appkit/reown_appkit.dart';

enum PolkadotMethods {
  polkadotSignTransaction,
  polkadotSignMessage,
}

enum PolkadotEvents {
  none,
}

class Polkadot {
  static final Map<PolkadotMethods, String> methods = {
    PolkadotMethods.polkadotSignTransaction: 'polkadot_signTransaction',
    PolkadotMethods.polkadotSignMessage: 'polkadot_signMessage'
  };

  static final Map<PolkadotEvents, String> events = {};

  static Map<String, dynamic> transactionPayload(String address) => {
        'specVersion': '0x00002468',
        'transactionVersion': '0x0000000e',
        'address': address,
        'blockHash':
            '0x554d682a74099d05e8b7852d19c93b527b5fae1e9e1969f6e1b82a2f09a14cc9',
        'blockNumber': '0x00cb539c',
        'era': '0xc501',
        'genesisHash':
            '0xe143f23803ac50e8f6f8e62695d1ce9e4e1d68aa36c1cd2cfd15340213f3423e',
        'method':
            '0x0001784920616d207369676e696e672074686973207472616e73616374696f6e21',
        'nonce': '0x00000000',
        'signedExtensions': [
          'CheckNonZeroSender',
          'CheckSpecVersion',
          'CheckTxVersion',
          'CheckGenesis',
          'CheckMortality',
          'CheckNonce',
          'CheckWeight',
          'ChargeTransactionPayment',
        ],
        'tip': '0x00000000000000000000000000000000',
        'version': 4,
      };

  // https://polkadot.subscan.io/extrinsic/26099230-2
  static Map<String, dynamic> createExtrinsic(String address) {
    // Convert the address to a Uint8List for the signer
    final signer = PolkadotChainUtils.ss58AddressToPublicKey(address);

    // Balances.transfer_keep_alive method
    final method =
        Uint8List.fromList(hex.decode('0x0403'.replaceAll('0x', '')));

    // Real signature from the transaction
    final signature = Uint8List.fromList(hex.decode(
      '0xfd65726905fb5e484613834fbba1101201b25117aca99cc0805ee2ff640285238ea9047ed7010b165610bba2b5abf2a702ccf19e6562e36d8b1c5176eee95f04'
          .replaceAll('0x', ''),
    ));

    return ExtrinsicPayload(
      signer: Uint8List.fromList(signer),
      method: method,
      signature: signature,
      eraPeriod: 32, // Should be determined from the chain's current era
      blockNumber: 26099230, // Actual block number from the transaction
      nonce: 34579, // Actual nonce from the transaction
      tip: 0, // No tip in this transaction
      // customSignedExtensions: {
      //   'CheckNonZeroSender': null,
      //   'CheckSpecVersion': '0x00002468', // From the transaction payload
      //   'CheckTxVersion': '0x0000000e', // From the transaction payload
      //   'CheckGenesis':
      //       '0xe143f23803ac50e8f6f8e62695d1ce9e4e1d68aa36c1cd2cfd15340213f3423e', // From the transaction payload
      //   'CheckMortality':
      //       '0x554d682a74099d05e8b7852d19c93b527b5fae1e9e1969f6e1b82a2f09a14cc9', // From the transaction payload
      //   'CheckNonce': 34579, // Same as the nonce
      //   'CheckWeight': null,
      //   'ChargeTransactionPayment': 0, // No tip
      // },
    ).toEncodedMap(null);
  }
}
