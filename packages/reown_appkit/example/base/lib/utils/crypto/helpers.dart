import 'dart:convert';

import 'package:bs58/bs58.dart';
import 'package:eth_sig_util/util/utils.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:reown_appkit_dapp/utils/crypto/eip155.dart';
import 'package:reown_appkit_dapp/utils/crypto/polkadot.dart';
import 'package:reown_appkit_dapp/utils/crypto/solana.dart';
import 'package:reown_appkit_dapp/utils/test_data.dart';

import 'package:solana_web3/solana_web3.dart' as solana;

List<String> getChainMethods(String namespace) {
  switch (namespace) {
    case 'eip155':
      return EIP155.methods.values.toList();
    case 'solana':
      return Solana.methods.values.toList();
    case 'polkadot':
      return Polkadot.methods.values.toList();
    default:
      return [];
  }
}

List<String> getChainEvents(String namespace) {
  switch (namespace) {
    case 'eip155':
      return EIP155.events.values.toList();
    case 'solana':
      return Solana.events.values.toList();
    case 'polkadot':
      return Polkadot.events.values.toList();
    default:
      return [];
  }
}

Future<SessionRequestParams?> getParams(
  String method,
  String address, {
  String? rpcUrl,
}) async {
  switch (method) {
    case 'personal_sign':
      final bytes = utf8.encode(testSignData);
      final encoded = bytesToHex(bytes, include0x: true);
      return SessionRequestParams(
        method: method,
        params: [encoded, address],
      );
    case 'eth_sign':
      return SessionRequestParams(
        method: method,
        params: [address, testSignData],
      );
    case 'eth_signTypedData':
      return SessionRequestParams(
        method: method,
        params: [address, typedData],
      );
    case 'eth_signTransaction':
      return SessionRequestParams(
        method: method,
        params: [
          Transaction(
            from: EthereumAddress.fromHex(address),
            to: EthereumAddress.fromHex(
              '0x59e2f66C0E96803206B6486cDb39029abAE834c0',
            ),
            value: EtherAmount.fromInt(EtherUnit.finney, 12), // == 0.012
          ).toJson(),
        ],
      );
    case 'eth_sendTransaction':
      return SessionRequestParams(
        method: method,
        params: [
          Transaction(
            from: EthereumAddress.fromHex(address),
            to: EthereumAddress.fromHex(
              '0x59e2f66C0E96803206B6486cDb39029abAE834c0',
            ),
            value: EtherAmount.fromInt(EtherUnit.finney, 12), // == 0.012
          ).toJson(),
        ],
      );
    case 'solana_signMessage':
      final bytes = utf8.encode(testSignData);
      final message = base58.encode(bytes);
      return SessionRequestParams(
        method: method,
        params: {'pubkey': address, 'message': message},
      );
    case 'solana_signTransaction':
      // Create a connection to the devnet cluster.
      final cluster = solana.Cluster.https(
        Uri.parse(rpcUrl!).authority,
      );
      // final cluster = solana.Cluster.devnet;
      final connection = solana.Connection(cluster);

      // Fetch the latest blockhash.
      final blockhash = await connection.getLatestBlockhash();

      // Create a System Program instruction to transfer 0.5 SOL from [address1] to [address2].
      final transactionv0 = solana.Transaction.v0(
        payer: solana.Pubkey.fromBase58(address),
        recentBlockhash: blockhash.blockhash,
        instructions: [
          solana.TransactionInstruction.fromJson({
            'programId': '11111111111111111111111111111111',
            'data': [2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0],
            'keys': [
              {
                'isSigner': true,
                'isWritable': true,
                'pubkey': address,
              },
              {
                'isSigner': false,
                'isWritable': true,
                'pubkey': '8vCyX7oB6Pc3pbWMGYYZF5pbSnAdQ7Gyr32JqxqCy8ZR'
              }
            ]
          }),
          // SystemProgram.transfer(
          //   fromPubkey: solana.Pubkey.fromBase58(address),
          //   toPubkey: solana.Pubkey.fromBase58(
          //     '8vCyX7oB6Pc3pbWMGYYZF5pbSnAdQ7Gyr32JqxqCy8ZR',
          //   ),
          //   lamports: solana.solToLamports(0.5),
          // ),
        ],
      );

      const config = solana.TransactionSerializableConfig(
        verifySignatures: false,
      );
      final bytes = transactionv0.serialize(config).asUint8List();
      final encodedV0Trx = base64.encode(bytes);

      return SessionRequestParams(
        method: method,
        params: {
          'transaction': encodedV0Trx,
          // 'pubkey': address,
          // 'feePayer': address,
          // ...transactionv0.message.toJson(),
        },
      );
    default:
      return null;
  }
}
