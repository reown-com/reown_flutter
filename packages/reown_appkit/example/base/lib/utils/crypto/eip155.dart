import 'dart:convert';

import 'package:eth_sig_util/util/utils.dart';
import 'package:intl/intl.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:reown_appkit_dapp/models/chain_metadata.dart';
import 'package:reown_appkit_dapp/utils/crypto/chain_data.dart';
import 'package:reown_appkit_dapp/utils/smart_contracts.dart';
import 'package:reown_appkit_dapp/utils/test_data.dart';

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
    required ReownAppKit appKit,
    required String topic,
    required String method,
    required ChainMetadata chainData,
    required String address,
  }) {
    switch (method) {
      case 'personal_sign':
        return personalSign(
          appKit: appKit,
          topic: topic,
          chainId: chainData.chainId,
          address: address,
          message: testSignData,
        );
      case 'eth_sign':
        return ethSign(
          appKit: appKit,
          topic: topic,
          chainId: chainData.chainId,
          address: address,
          message: testSignData,
        );
      case 'eth_signTypedData':
        return ethSignTypedData(
          appKit: appKit,
          topic: topic,
          chainId: chainData.chainId,
          address: address,
          data: typedData,
        );
      case 'eth_signTransaction':
        return ethSignTransaction(
          appKit: appKit,
          topic: topic,
          chainId: chainData.chainId,
          transaction: Transaction(
            from: EthereumAddress.fromHex(address),
            to: EthereumAddress.fromHex(
              '0x59e2f66C0E96803206B6486cDb39029abAE834c0',
            ),
            value: EtherAmount.fromInt(EtherUnit.finney, 12), // == 0.012
          ),
        );
      case 'eth_sendTransaction':
        return ethSendTransaction(
          appKit: appKit,
          topic: topic,
          chainId: chainData.chainId,
          transaction: Transaction(
            from: EthereumAddress.fromHex(address),
            to: EthereumAddress.fromHex(
              '0x59e2f66C0E96803206B6486cDb39029abAE834c0',
            ),
            value: EtherAmount.fromInt(EtherUnit.finney, 11), // == 0.011
          ),
        );
      default:
        throw 'Method unimplemented';
    }
  }

  static Future<dynamic> callSmartContract({
    required ReownAppKit appKit,
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

    final sepolia =
        ChainData.allChains.firstWhere((e) => e.chainId == 'eip155:11155111');

    switch (action) {
      case 'read':
        return readSmartContract(
          appKit: appKit,
          rpcUrl: sepolia.rpc.first,
          contract: deployedContract,
          address: address,
        );
      case 'write':
        return appKit.requestWriteContract(
          topic: topic,
          chainId: sepolia.chainId,
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
    required ReownAppKit appKit,
    required String topic,
    required String chainId,
    required String address,
    required String message,
  }) async {
    final bytes = utf8.encode(message);
    final encoded = bytesToHex(bytes);

    return await appKit.request(
      topic: topic,
      chainId: chainId,
      request: SessionRequestParams(
        method: methods[EIP155Methods.personalSign]!,
        params: [encoded, address],
      ),
    );
  }

  static Future<dynamic> ethSign({
    required ReownAppKit appKit,
    required String topic,
    required String chainId,
    required String address,
    required String message,
  }) async {
    return await appKit.request(
      topic: topic,
      chainId: chainId,
      request: SessionRequestParams(
        method: methods[EIP155Methods.ethSign]!,
        params: [address, message],
      ),
    );
  }

  static Future<dynamic> ethSignTypedData({
    required ReownAppKit appKit,
    required String topic,
    required String chainId,
    required String address,
    required String data,
  }) async {
    return await appKit.request(
      topic: topic,
      chainId: chainId,
      request: SessionRequestParams(
        method: methods[EIP155Methods.ethSignTypedData]!,
        params: [address, data],
      ),
    );
  }

  static Future<dynamic> ethSignTransaction({
    required ReownAppKit appKit,
    required String topic,
    required String chainId,
    required Transaction transaction,
  }) async {
    return await appKit.request(
      topic: topic,
      chainId: chainId,
      request: SessionRequestParams(
        method: methods[EIP155Methods.ethSignTransaction]!,
        params: [transaction.toJson()],
      ),
    );
  }

  static Future<dynamic> ethSendTransaction({
    required ReownAppKit appKit,
    required String topic,
    required String chainId,
    required Transaction transaction,
  }) async {
    return await appKit.request(
      topic: topic,
      chainId: chainId,
      request: SessionRequestParams(
        method: methods[EIP155Methods.ethSendTransaction]!,
        params: [transaction.toJson()],
      ),
    );
  }

  static Future<dynamic> readSmartContract({
    required ReownAppKit appKit,
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
