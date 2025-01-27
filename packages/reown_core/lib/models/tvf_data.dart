import 'dart:convert';
import 'package:flutter/foundation.dart';

class TVFData {
  final List<String>? rpcMethods;
  final String? chainId;
  final List<String>? contractAddresses;
  final List<String>? txHashes;

  const TVFData({
    this.rpcMethods,
    this.chainId,
    this.contractAddresses,
    this.txHashes,
  });

  Map<String, dynamic> toJson({bool includeAll = false}) => {
        'rpc_methods': rpcMethods,
        'chain_id': chainId,
        'contract_addresses': contractAddresses,
        if (includeAll) 'tx_hashes': txHashes,
      };

  TVFData copytWith({
    List<String>? rpcMethods,
    String? chainId,
    List<String>? contractAddresses,
    List<String>? txHashes,
  }) {
    return TVFData(
      rpcMethods: rpcMethods ?? this.rpcMethods,
      chainId: chainId ?? this.chainId,
      contractAddresses: contractAddresses ?? this.contractAddresses,
      txHashes: txHashes ?? this.txHashes,
    );
  }

  @override
  String toString() => jsonEncode(toJson());

  static final tvfRequestMethods = [
    if (kDebugMode) 'eth_signTransaction',
    'eth_sendTransaction',
    'eth_sendRawTransaction',
    'solana_signAndSendTransaction',
    'solana_signTransaction',
    'solana_signAllTransactions',
    'wallet_sendCalls',
  ];
}
