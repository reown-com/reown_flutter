import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:reown_appkit_example/services/contracts/usdt_contract.dart';
import 'package:reown_appkit/reown_appkit.dart';

// ignore: depend_on_referenced_packages
import 'package:convert/convert.dart';

import 'package:reown_appkit_example/services/contracts/aave_contract.dart';
import 'package:reown_appkit_example/services/contracts/test_data.dart';

enum EIP155UIMethods {
  personalSign,
  ethSendTransaction,
  requestAccounts,
  ethSignTypedData,
  ethSignTypedDataV3,
  ethSignTypedDataV4,
  ethSignTransaction,
  walletWatchAsset;

  String get name {
    switch (this) {
      case personalSign:
        return 'personal_sign';
      case ethSignTypedDataV4:
        return 'eth_signTypedData_v4';
      case ethSendTransaction:
        return 'eth_sendTransaction';
      case requestAccounts:
        return 'eth_requestAccounts';
      case ethSignTypedDataV3:
        return 'eth_signTypedData_v3';
      case ethSignTypedData:
        return 'eth_signTypedData';
      case ethSignTransaction:
        return 'eth_signTransaction';
      case walletWatchAsset:
        return 'wallet_watchAsset';
    }
  }
}

class EIP155 {
  static EIP155UIMethods methodFromName(String name) {
    switch (name) {
      case 'personal_sign':
        return EIP155UIMethods.personalSign;
      case 'eth_signTypedData_v4':
        return EIP155UIMethods.ethSignTypedDataV4;
      case 'eth_sendTransaction':
        return EIP155UIMethods.ethSendTransaction;
      case 'eth_requestAccounts':
        return EIP155UIMethods.requestAccounts;
      case 'eth_signTypedData_v3':
        return EIP155UIMethods.ethSignTypedDataV3;
      case 'eth_signTypedData':
        return EIP155UIMethods.ethSignTypedData;
      case 'eth_signTransaction':
        return EIP155UIMethods.ethSignTransaction;
      case 'wallet_watchAsset':
        return EIP155UIMethods.walletWatchAsset;
      default:
        throw Exception('Unrecognized method');
    }
  }

  static Future<dynamic> callMethod({
    required ReownAppKitModal appKit,
    required String topic,
    required EIP155UIMethods method,
    required String chainId,
    required String address,
  }) {
    final cid = int.parse(chainId);
    switch (method) {
      case EIP155UIMethods.requestAccounts:
        return requestAccounts(
          appKit: appKit,
        );
      case EIP155UIMethods.personalSign:
        return personalSign(
          appKit: appKit,
          message: testSignData,
        );
      case EIP155UIMethods.ethSignTypedDataV3:
        return ethSignTypedDataV3(
          appKit: appKit,
          data: jsonEncode(typeDataV3(cid)),
        );
      case EIP155UIMethods.ethSignTypedData:
        return ethSignTypedData(
          appKit: appKit,
          data: jsonEncode(typedData()),
        );
      case EIP155UIMethods.ethSignTypedDataV4:
        return ethSignTypedDataV4(
          appKit: appKit,
          data: jsonEncode(typeDataV4(cid)),
        );
      case EIP155UIMethods.ethSignTransaction:
      case EIP155UIMethods.ethSendTransaction:
        return ethSendOrSignTransaction(
          appKit: appKit,
          method: method,
          transaction: Transaction(
            from: EthereumAddress.fromHex(address),
            to: EthereumAddress.fromHex(
              '0x59e2f66C0E96803206B6486cDb39029abAE834c0',
            ),
            value: EtherAmount.fromInt(EtherUnit.finney, 11), // == 0.011
            data: utf8.encode('0x'), // to make it work with some wallets
          ),
        );
      case EIP155UIMethods.walletWatchAsset:
        return walletWatchAsset(
          appKit: appKit,
        );
    }
  }

  static Future<dynamic> requestAccounts({
    required ReownAppKitModal appKit,
  }) async {
    return await appKit.request(
      topic: appKit.session!.topic,
      chainId: appKit.selectedChain!.chainId,
      request: SessionRequestParams(
        method: EIP155UIMethods.requestAccounts.name,
        params: [],
      ),
    );
  }

  static Future<dynamic> personalSign({
    required ReownAppKitModal appKit,
    required String message,
  }) async {
    final bytes = utf8.encode(message);
    final encoded = hex.encode(bytes);

    return await appKit.request(
      topic: appKit.session!.topic,
      chainId: appKit.selectedChain!.chainId,
      request: SessionRequestParams(
        method: EIP155UIMethods.personalSign.name,
        params: [
          '0x$encoded',
          appKit.session!.address!,
        ],
      ),
    );
  }

  static Future<dynamic> ethSignTypedData({
    required ReownAppKitModal appKit,
    required String data,
  }) async {
    return await appKit.request(
      topic: appKit.session!.topic,
      chainId: appKit.selectedChain!.chainId,
      request: SessionRequestParams(
        method: EIP155UIMethods.ethSignTypedData.name,
        params: [
          data,
          appKit.session!.address!,
        ],
      ),
    );
  }

  static Future<dynamic> ethSignTypedDataV3({
    required ReownAppKitModal appKit,
    required String data,
  }) async {
    return await appKit.request(
      topic: appKit.session!.topic,
      chainId: appKit.selectedChain!.chainId,
      request: SessionRequestParams(
        method: EIP155UIMethods.ethSignTypedDataV3.name,
        params: [
          data,
          appKit.session!.address!,
        ],
      ),
    );
  }

  static Future<dynamic> ethSignTypedDataV4({
    required ReownAppKitModal appKit,
    required String data,
  }) async {
    return await appKit.request(
      topic: appKit.session!.topic,
      chainId: appKit.selectedChain!.chainId,
      request: SessionRequestParams(
        method: EIP155UIMethods.ethSignTypedDataV4.name,
        params: [
          data,
          appKit.session!.address!,
        ],
      ),
    );
  }

  static Future<dynamic> ethSendOrSignTransaction({
    required ReownAppKitModal appKit,
    required Transaction transaction,
    required EIP155UIMethods method,
  }) async {
    return await appKit.request(
      topic: appKit.session!.topic,
      chainId: appKit.selectedChain!.chainId,
      request: SessionRequestParams(
        method: method.name,
        params: [
          transaction.toJson(),
        ],
      ),
    );
  }

  static Future<dynamic> walletWatchAsset({
    required ReownAppKitModal appKit,
  }) async {
    return await appKit.request(
      topic: appKit.session!.topic,
      chainId: appKit.selectedChain!.chainId,
      request: SessionRequestParams(
        method: EIP155UIMethods.walletWatchAsset.name,
        params: {
          'type': 'ERC20',
          'options': {
            'address': '0xcf664087a5bb0237a0bad6742852ec6c8d69a27a',
            'symbol': 'WONE',
            'decimals': 18,
            'image':
                'https://s2.coinmarketcap.com/static/img/coins/64x64/11696.png'
          }
        },
      ),
    );
  }

  // Example of calling `transfer` function from AAVE token Smart Contract
  static Future<dynamic> callTestSmartContract({
    required ReownAppKitModal appKit,
    required String action,
  }) async {
    // Create DeployedContract object using contract's ABI and address
    final deployedContract = DeployedContract(
      ContractAbi.fromJson(
        jsonEncode(AAVESepoliaContract.contractABI),
        'AAVE Token (Sepolia)',
      ),
      EthereumAddress.fromHex(AAVESepoliaContract.contractAddress),
    );

    switch (action) {
      case 'read':
        return _readSmartContract(
          appKit: appKit,
          contract: deployedContract,
        );
      case 'write':
        // return await appKit.requestWriteContract(
        //   topic: appKit.session?.topic ?? '',
        //   chainId: 'eip155:11155111',
        //   deployedContract: deployedContract,
        //   functionName: 'subscribe',
        //   parameters: [],
        //   transaction: Transaction(
        //     from: EthereumAddress.fromHex(appKit.session!.address!),
        //     value: EtherAmount.fromInt(EtherUnit.finney, 1),
        //   ),
        // );
        // we first call `decimals` function, which is a read function,
        // to check how much decimal we need to use to parse the amount value
        final decimals = await appKit.requestReadContract(
          topic: appKit.session!.topic,
          chainId: appKit.selectedChain!.chainId,
          deployedContract: deployedContract,
          functionName: 'decimals',
        );
        final d = (decimals.first as BigInt);
        final requestValue = _formatValue(0.01, decimals: d);
        // now we call `transfer` write function with the parsed value.
        return appKit.requestWriteContract(
          topic: appKit.session!.topic,
          chainId: appKit.selectedChain!.chainId,
          deployedContract: deployedContract,
          functionName: 'transfer',
          transaction: Transaction(
            from: EthereumAddress.fromHex(appKit.session!.address!),
          ),
          parameters: [
            EthereumAddress.fromHex(
              '0x59e2f66C0E96803206B6486cDb39029abAE834c0',
            ),
            requestValue, // == 0.12
          ],
        );
      // payable function with no parameters such as:
      // {
      //   "inputs": [],
      //   "name": "functionName",
      //   "outputs": [],
      //   "stateMutability": "payable",
      //   "type": "function"
      // },
      // return appKit.requestWriteContract(
      //   topic: appKit.session?.topic ?? '',
      //   chainId: 'eip155:11155111',
      //   rpcUrl: 'https://ethereum-sepolia.publicnode.com',
      //   deployedContract: deployedContract,
      //   functionName: 'functionName',
      //   transaction: Transaction(
      //     from: EthereumAddress.fromHex(appKit.session!.address!),
      //     value: EtherAmount.fromInt(EtherUnit.finney, 1),
      //   ),
      //   parameters: [],
      // );
      default:
        return Future.value();
    }
  }

  // Example of calling `transfer` function from USDT token Smart Contract
  static Future<dynamic> callUSDTSmartContract({
    required ReownAppKitModal appKit,
    required String action,
  }) async {
    // Create DeployedContract object using contract's ABI and address
    final deployedContract = DeployedContract(
      ContractAbi.fromJson(
        jsonEncode(USDTContract.contractABI),
        'Tether USD',
      ),
      EthereumAddress.fromHex(USDTContract.contractAddress),
    );

    switch (action) {
      case 'read':
        return _readSmartContract(
          appKit: appKit,
          contract: deployedContract,
        );
      case 'write':
        // we first call `decimals` function, which is a read function,
        // to check how much decimal we need to use to parse the amount value
        final decimals = await appKit.requestReadContract(
          topic: appKit.session!.topic,
          chainId: appKit.selectedChain!.chainId,
          deployedContract: deployedContract,
          functionName: 'decimals',
        );
        final d = (decimals.first as BigInt);
        final requestValue = _formatValue(0.23, decimals: d);
        // now we call `transfer` write function with the parsed value.
        return appKit.requestWriteContract(
          topic: appKit.session!.topic,
          chainId: appKit.selectedChain!.chainId,
          deployedContract: deployedContract,
          functionName: 'transfer',
          transaction: Transaction(
            from: EthereumAddress.fromHex(appKit.session!.address!),
          ),
          parameters: [
            EthereumAddress.fromHex(
              '0x59e2f66C0E96803206B6486cDb39029abAE834c0',
            ),
            requestValue, // == 0.23
          ],
        );
      default:
        return Future.value();
    }
  }

  static Future<dynamic> _readSmartContract({
    required ReownAppKitModal appKit,
    required DeployedContract contract,
  }) async {
    final results = await Future.wait([
      // results[0]
      appKit.requestReadContract(
        topic: appKit.session!.topic,
        chainId: appKit.selectedChain!.chainId,
        deployedContract: contract,
        functionName: 'name',
      ),
      // results[1]
      appKit.requestReadContract(
        topic: appKit.session!.topic,
        chainId: appKit.selectedChain!.chainId,
        deployedContract: contract,
        functionName: 'totalSupply',
      ),
      // results[2]
      appKit.requestReadContract(
        topic: appKit.session!.topic,
        chainId: appKit.selectedChain!.chainId,
        deployedContract: contract,
        functionName: 'balanceOf',
        parameters: [
          EthereumAddress.fromHex(appKit.session!.address!),
        ],
      ),
      // results[4]
      appKit.requestReadContract(
        topic: appKit.session!.topic,
        chainId: appKit.selectedChain!.chainId,
        deployedContract: contract,
        functionName: 'decimals',
      ),
    ]);

    //
    final name = (results[0].first as String);
    final multiplier = _multiplier(results[3].first);
    final total = (results[1].first as BigInt) / BigInt.from(multiplier);
    final balance = (results[2].first as BigInt) / BigInt.from(multiplier);
    final formatter = NumberFormat('#,##0.00000', 'en_US');

    return {
      'name': name,
      'totalSupply': formatter.format(total),
      'balance': formatter.format(balance),
    };
  }

  static BigInt _formatValue(num value, {required BigInt decimals}) {
    final multiplier = _multiplier(decimals);
    final result = EtherAmount.fromInt(
      EtherUnit.ether,
      (value * multiplier).toInt(),
    );
    return result.getInEther;
  }

  static int _multiplier(BigInt decimals) {
    final d = decimals.toInt();
    final pad = '1'.padRight(d + 1, '0');
    return int.parse(pad);
  }
}
