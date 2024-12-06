import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:reown_appkit_dapp/utils/crypto/helpers.dart';
import 'package:reown_appkit_dapp/utils/smart_contracts.dart';

enum EIP155Methods {
  personalSign,
  ethSign,
  ethSignTransaction,
  ethSignTypedData,
  ethSendTransaction,
}

enum EIP155Events {
  chainChanged,
  accountsChanged,
}

class EIP155 {
  static final Map<EIP155Methods, String> methods = {
    EIP155Methods.personalSign: 'personal_sign',
    EIP155Methods.ethSign: 'eth_sign',
    EIP155Methods.ethSignTransaction: 'eth_signTransaction',
    EIP155Methods.ethSignTypedData: 'eth_signTypedData',
    EIP155Methods.ethSendTransaction: 'eth_sendTransaction',
  };

  static final Map<EIP155Events, String> events = {
    EIP155Events.chainChanged: 'chainChanged',
    EIP155Events.accountsChanged: 'accountsChanged',
  };

  static Future<dynamic> callMethod({
    required IReownAppKit appKit,
    required String topic,
    required String method,
    required ReownAppKitModalNetworkInfo chainData,
    required String address,
  }) {
    switch (method) {
      case 'personal_sign':
        return personalSign(
          appKit: appKit,
          topic: topic,
          chainId: chainData.chainId,
          address: address,
        );
      case 'eth_sign':
        return ethSign(
          appKit: appKit,
          topic: topic,
          chainId: chainData.chainId,
          address: address,
        );
      case 'eth_signTypedData':
        return ethSignTypedData(
          appKit: appKit,
          topic: topic,
          chainId: chainData.chainId,
          address: address,
        );
      case 'eth_signTransaction':
        return ethSignTransaction(
          appKit: appKit,
          topic: topic,
          chainId: chainData.chainId,
        );
      case 'eth_sendTransaction':
        return ethSendTransaction(
          appKit: appKit,
          topic: topic,
          chainId: chainData.chainId,
        );
      default:
        throw 'Method unimplemented';
    }
  }

  static Future<dynamic> callSmartContract({
    required IReownAppKit appKit,
    required String topic,
    required String address,
    required String action,
  }) {
    // Create DeployedContract object using contract's ABI and address
    final deployedContract = DeployedContract(
      ContractAbi.fromJson(
        jsonEncode(SepoliaTestContract.readContractAbi),
        'Alfreedoms',
      ),
      EthereumAddress.fromHex(SepoliaTestContract.contractAddress),
    );

    final sepolia = ReownAppKitModalNetworks.getNetworkById(
      'eip155',
      '11155111',
    )!;

    switch (action) {
      case 'read':
        return readSmartContract(
          appKit: appKit,
          rpcUrl: sepolia.rpcUrl,
          contract: deployedContract,
          address: address,
        );
      case 'write':
        return appKit.requestWriteContract(
          topic: topic,
          chainId: 'eip155:${sepolia.chainId}',
          deployedContract: deployedContract,
          functionName: 'transfer',
          transaction: Transaction(
            from: EthereumAddress.fromHex(address),
          ),
          parameters: [
            // Recipient
            EthereumAddress.fromHex(
              '0x59e2f66C0E96803206B6486cDb39029abAE834c0',
            ),
            // Amount to Transfer
            EtherAmount.fromInt(EtherUnit.finney, 10).getInWei, // == 0.010
          ],
        );
      default:
        return Future.value();
    }
  }

  static Future<dynamic> personalSign({
    required IReownAppKit appKit,
    required String topic,
    required String chainId,
    required String address,
  }) async {
    return await appKit.request(
      topic: topic,
      chainId: 'eip155:$chainId',
      request: (await getParams('personal_sign', address))!,
    );
  }

  static Future<dynamic> ethSign({
    required IReownAppKit appKit,
    required String topic,
    required String chainId,
    required String address,
  }) async {
    return await appKit.request(
      topic: topic,
      chainId: 'eip155:$chainId',
      request: (await getParams('eth_sign', address))!,
    );
  }

  static Future<dynamic> ethSignTypedData({
    required IReownAppKit appKit,
    required String topic,
    required String chainId,
    required String address,
  }) async {
    return await appKit.request(
      topic: topic,
      chainId: 'eip155:$chainId',
      request: (await getParams('eth_signTypedData', address))!,
    );
  }

  static Future<dynamic> ethSignTransaction({
    required IReownAppKit appKit,
    required String topic,
    required String chainId,
  }) async {
    return await appKit.request(
      topic: topic,
      chainId: 'eip155:$chainId',
      request: (await getParams('eth_signTransaction', ''))!,
    );
  }

  static Future<dynamic> ethSendTransaction({
    required IReownAppKit appKit,
    required String topic,
    required String chainId,
  }) async {
    return await appKit.request(
      topic: topic,
      chainId: 'eip155:$chainId',
      request: (await getParams('eth_sendTransaction', ''))!,
    );
  }

  static Future<dynamic> readSmartContract({
    required IReownAppKit appKit,
    required String rpcUrl,
    required String address,
    required DeployedContract contract,
  }) async {
    final results = await Future.wait([
      // results[0]
      appKit.requestReadContract(
        deployedContract: contract,
        functionName: 'name',
        rpcUrl: rpcUrl,
      ),
      // results[1]
      appKit.requestReadContract(
        deployedContract: contract,
        functionName: 'totalSupply',
        rpcUrl: rpcUrl,
      ),
      // results[2]
      appKit.requestReadContract(
        deployedContract: contract,
        functionName: 'balanceOf',
        rpcUrl: rpcUrl,
        parameters: [
          EthereumAddress.fromHex(address),
        ],
      ),
    ]);

    final oCcy = NumberFormat('#,##0.00', 'en_US');
    final name = results[0].first.toString();
    final total = results[1].first / BigInt.from(1000000000000000000);
    final balance = results[2].first / BigInt.from(1000000000000000000);

    return {
      'name': name,
      'totalSupply': oCcy.format(total),
      'balance': oCcy.format(balance),
    };
  }
}
