import 'dart:convert';

import 'package:eth_sig_util/util/utils.dart';
import 'package:intl/intl.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:reown_appkit_dapp/utils/crypto/polkadot.dart';
import 'package:reown_appkit_dapp/utils/crypto/tron.dart';
import 'package:reown_appkit_dapp/utils/smart_contracts.dart';
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
            // to: should be the recipient address
            to: EthereumAddress.fromHex(address),
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

Future<dynamic> callSmartContract({
  required ReownAppKitModal appKitModal,
  required SmartContract smartContract,
  required String action,
}) async {
  // Create DeployedContract object using contract's ABI and address
  final deployedContract = DeployedContract(
    ContractAbi.fromJson(
      jsonEncode(smartContract.contractABI),
      smartContract.name,
    ),
    EthereumAddress.fromHex(smartContract.contractAddress),
  );

  switch (action) {
    case 'read':
      return _readSmartContract(
        appKitModal: appKitModal,
        contract: deployedContract,
      );
    case 'write':
      final transferValue = 0.01; //EtherAmount.fromInt(EtherUnit.finney, 11)
      // we first call `decimals` function, which is a read function,
      // to check how much decimal we need to use to parse the amount value
      final decimals = await appKitModal.requestReadContract(
        topic: appKitModal.session!.topic,
        chainId: appKitModal.selectedChain!.chainId,
        deployedContract: deployedContract,
        functionName: 'decimals',
      );

      final requestValue = _formatValue(
        transferValue,
        decimals: (decimals.first as BigInt),
      );
      // now we call `transfer` write function with the parsed value.
      final namespace = NamespaceUtils.getNamespaceFromChain(
        appKitModal.selectedChain!.chainId,
      );
      final senderAddress = appKitModal.session!.getAddress(namespace)!;
      return await appKitModal.requestWriteContract(
        topic: appKitModal.session!.topic,
        chainId: appKitModal.selectedChain!.chainId,
        deployedContract: deployedContract,
        functionName: 'transfer',
        transaction: Transaction(
          from: EthereumAddress.fromHex(senderAddress),
        ),
        parameters: [
          // should be the recipient address
          EthereumAddress.fromHex(senderAddress),
          requestValue, // == 0.23
        ],
      );
    // return await appKitModal.requestWriteContract(
    //   topic: appKitModal.session!.topic,
    //   chainId: appKitModal.selectedChain!.chainId,
    //   deployedContract: deployedContract,
    //   functionName: 'pay',
    //   transaction: Transaction(
    //     from: EthereumAddress.fromHex(senderAddress),
    //     // value: EtherAmount.fromUnitAndValue(EtherUnit.wei, weiValue),
    //   ),
    //   parameters: [
    //     'cartId1',
    //     'uid1',
    //     EtherAmount.fromInt(EtherUnit.finney, 0).getInWei,
    //   ],
    // );
    // --------
    // payable function with no parameters such as:
    // {
    //   "inputs": [],
    //   "name": "functionName",
    //   "outputs": [],
    //   "stateMutability": "payable",
    //   "type": "function"
    // },
    // return appKitModal.requestWriteContract(
    //   topic: appKitModal.session?.topic ?? '',
    //   chainId: 'eip155:11155111',
    //   rpcUrl: 'https://ethereum-sepolia.publicnode.com',
    //   deployedContract: deployedContract,
    //   functionName: 'functionName',
    //   transaction: Transaction(
    //     from: EthereumAddress.fromHex(appKitModal.session!.address!),
    //     value: EtherAmount.fromInt(EtherUnit.finney, 1),
    //   ),
    //   parameters: [],
    // );
    // ------
    // return await appKitModal.requestWriteContract(
    //   topic: appKitModal.session?.topic ?? '',
    //   chainId: 'eip155:11155111',
    //   deployedContract: deployedContract,
    //   functionName: 'subscribe',
    //   parameters: [],
    //   transaction: Transaction(
    //     from: EthereumAddress.fromHex(appKitModal.session!.address!),
    //     value: EtherAmount.fromInt(EtherUnit.finney, 1),
    //   ),
    // );
    // ------
    // return await appKitModal.requestWriteContract(
    //   topic: appKitModal.session?.topic ?? '',
    //   chainId: 'eip155:11155111',
    //   deployedContract: deployedContract,
    //   functionName: 'transfer',
    //   parameters: [
    //     EthereumAddress.fromHex(
    //       appKitModal.session!.getAddress(namespace)!,
    //     ),
    //     requestValue, // == 0.12
    //   ],
    //   transaction: Transaction(
    //     from: EthereumAddress.fromHex(
    //       appKitModal.session!.getAddress(namespace)!,
    //     ),
    //   ),
    // );
    default:
      return Future.value();
  }
}

Future<dynamic> _readSmartContract({
  required ReownAppKitModal appKitModal,
  required DeployedContract contract,
}) async {
  final namespace = NamespaceUtils.getNamespaceFromChain(
    appKitModal.selectedChain!.chainId,
  );
  final results = await Future.wait([
    // results[0]
    appKitModal.requestReadContract(
      topic: appKitModal.session!.topic,
      chainId: appKitModal.selectedChain!.chainId,
      deployedContract: contract,
      functionName: 'name',
    ),
    // results[1]
    appKitModal.requestReadContract(
      topic: appKitModal.session!.topic,
      chainId: appKitModal.selectedChain!.chainId,
      deployedContract: contract,
      functionName: 'symbol',
    ),
    // results[2]
    appKitModal.requestReadContract(
      topic: appKitModal.session!.topic,
      chainId: appKitModal.selectedChain!.chainId,
      deployedContract: contract,
      functionName: 'totalSupply',
    ),
    // results[3]
    appKitModal.requestReadContract(
      topic: appKitModal.session!.topic,
      chainId: appKitModal.selectedChain!.chainId,
      deployedContract: contract,
      functionName: 'balanceOf',
      parameters: [
        EthereumAddress.fromHex(appKitModal.session!.getAddress(namespace)!),
      ],
    ),
    // results[4]
    appKitModal.requestReadContract(
      topic: appKitModal.session!.topic,
      chainId: appKitModal.selectedChain!.chainId,
      deployedContract: contract,
      functionName: 'decimals',
    ),
  ]);

  //
  final name = (results[0].first as String);
  final symbol = (results[1].first as String);
  final decimals = results[4].first;
  final multiplier = _multiplier(decimals);
  final total = (results[2].first as BigInt) / BigInt.from(multiplier);
  final balance = (results[3].first as BigInt) / BigInt.from(multiplier);
  final formatter = NumberFormat('#,##0.00000', 'en_US');

  return {
    'name': name,
    'symbol': symbol,
    'decimals': '$decimals',
    'totalSupply': formatter.format(total),
    'balance': formatter.format(balance),
  };
}

BigInt _formatValue(num value, {required BigInt decimals}) {
  final multiplier = _multiplier(decimals);
  final result = EtherAmount.fromInt(
    EtherUnit.ether,
    (value * multiplier).toInt(),
  );
  return result.getInEther;
}

int _multiplier(BigInt decimals) {
  final d = decimals.toInt();
  final pad = '1'.padRight(d + 1, '0');
  return int.parse(pad);
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
