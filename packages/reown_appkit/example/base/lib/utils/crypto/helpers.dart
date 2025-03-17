import 'dart:convert';

import 'package:eth_sig_util/util/utils.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:reown_appkit_dapp/utils/crypto/polkadot.dart';
import 'package:reown_appkit_dapp/utils/crypto/tron.dart';
import 'package:reown_appkit_dapp/utils/test_data.dart';

import 'package:reown_appkit/solana/solana_web3/solana_web3.dart' as solana;
import 'package:reown_appkit/solana/solana_web3/programs.dart' as programs;

List<String> getChainMethods(String namespace) {
  switch (namespace) {
    case 'eip155':
      return [
        'personal_sign',
        'eth_sign',
        'eth_signTypedData',
        'eth_signTypedData_v4',
        'eth_signTransaction',
        'eth_sendTransaction',
      ];
    case 'solana':
      return [
        'solana_signMessage',
        'solana_signTransaction',
        'solana_signAndSendTransaction',
        'solana_signAllTransactions',
      ];
    case 'polkadot':
      return Polkadot.methods.values.toList();
    case 'tron':
      return Tron.methods.values.toList();
    case 'mvx':
      return ['mvx_signMessage', 'mvx_signTransaction'];
    default:
      return [];
  }
}

List<String> getChainEvents(String namespace) {
  switch (namespace) {
    case 'eip155':
      return NetworkUtils.defaultNetworkEvents['eip155']!.toList();
    case 'solana':
      return NetworkUtils.defaultNetworkEvents['solana']!.toList();
    case 'polkadot':
      return Polkadot.events.values.toList();
    case 'tron':
      return Tron.events.values.toList();
    case 'mvx':
      return [];
    default:
      return [];
  }
}

Future<SessionRequestParams?> getParams(
  String method,
  String address,
  ReownAppKitModalNetworkInfo chainData,
) async {
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
    case 'eth_signTypedData_v4':
      return SessionRequestParams(
        method: method,
        params: [
          address,
          typeDataV4(int.parse(chainData.chainId)),
        ],
      );
    case 'eth_signTransaction':
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
            data: utf8.encode('0x'), // to make it work with some wallets
          ).toJson(),
        ],
      );
    case 'solana_signMessage':
      final bytes = utf8.encode('Welcome to Flutter AppKit on Solana');
      final message = base58.encode(bytes);
      return SessionRequestParams(
        method: method,
        params: {
          'pubkey': address,
          'message': message,
        },
      );
    case 'solana_signTransaction':
    case 'solana_signAndSendTransaction':
      final transactionV0_2 = await _contructSolanaTX_2(address, chainData);

      const config = solana.TransactionSerializableConfig(
        verifySignatures: false,
      );
      final bytes = transactionV0_2.serialize(config).asUint8List();
      final encodedV0Trx = base64.encode(bytes);

      return SessionRequestParams(
        method: method,
        params: {
          'transaction': encodedV0Trx,
          'pubkey': address,
          'feePayer': address,
          ...transactionV0_2.message.toJson(),
        },
      );
    case 'solana_signAllTransactions':
      final transactionV0_1 = await _contructSolanaTX(address, chainData);
      final transactionV0_2 = await _contructSolanaTX_2(address, chainData);

      const config = solana.TransactionSerializableConfig(
        verifySignatures: false,
      );
      final bytes_1 = transactionV0_1.serialize(config).asUint8List();
      final encodedV0Trx_1 = base64.encode(bytes_1);
      final bytes_2 = transactionV0_2.serialize(config).asUint8List();
      final encodedV0Trx_2 = base64.encode(bytes_2);

      return SessionRequestParams(
        method: method,
        params: {
          'transactions': [encodedV0Trx_1, encodedV0Trx_2],
        },
      );
    case 'tron_signMessage':
      return SessionRequestParams(
        method: method,
        params: {
          'address': address,
          'message': testSignData,
        },
      );
    case 'tron_signTransaction':
      //
      final transaction = await Tron.triggerSmartContract(
        chainData: chainData,
        walletAdress: address,
      );
      return SessionRequestParams(
        method: method,
        params: {
          'address': address,
          'transaction': transaction,
        },
      );
    default:
      return SessionRequestParams(
        method: method,
        params: null,
      );
  }
}

Future<solana.Transaction> _contructSolanaTX(
  String address,
  ReownAppKitModalNetworkInfo chainData,
) async {
  // Create a connection to the devnet cluster.
  final cluster = solana.Cluster.https(
    Uri.parse(chainData.rpcUrl).authority,
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
    ],
  );

  return transactionv0;
}

Future<solana.Transaction> _contructSolanaTX_2(
  String address,
  ReownAppKitModalNetworkInfo chainData,
) async {
  // Create a connection to the devnet cluster.
  final cluster = solana.Cluster.https(
    Uri.parse(chainData.rpcUrl).authority,
  );
  // final cluster = solana.Cluster.devnet;
  final connection = solana.Connection(cluster);

  // Fetch the latest blockhash.
  final blockhash = await connection.getLatestBlockhash();

  // Define transfer amount in lamports (1 SOL = 1,000,000,000 lamports)
  // Amount to send in lamports (0.01 SOL)
  final lamports = BigInt.from(10000000);

  // Create the transfer instruction
  final transferInstruction = programs.SystemProgram.transfer(
    fromPubkey: solana.Pubkey.fromBase58(address),
    toPubkey: solana.Pubkey.fromBase58(address),
    lamports: lamports,
  );

  final transactionv0 = solana.Transaction.v0(
    payer: solana.Pubkey.fromBase58(address),
    recentBlockhash: blockhash.blockhash,
    instructions: [
      transferInstruction,
    ],
  );

  return transactionv0;
}
