import 'dart:convert';

class TVFData {
  final List<String>? rpcMethods;
  final String? chainId;
  final List<String>? contractAddresses;
  final List<String>? txHashes;
  final dynamic requestParams;

  const TVFData({
    this.rpcMethods,
    this.chainId,
    this.contractAddresses,
    this.txHashes,
    this.requestParams,
  });

  Map<String, dynamic> toJson({bool includeAll = false}) => {
    'rpcMethods': rpcMethods,
    'chainId': chainId,
    'contractAddresses': contractAddresses,
    // requestParams is not included in this method because this is used to add tvf data to the publish method
    if (includeAll) 'txHashes': txHashes,
  };

  TVFData copyWith({
    List<String>? rpcMethods,
    String? chainId,
    List<String>? contractAddresses,
    List<String>? txHashes,
    dynamic requestParams,
  }) {
    return TVFData(
      rpcMethods: rpcMethods ?? this.rpcMethods,
      chainId: chainId ?? this.chainId,
      contractAddresses: contractAddresses ?? this.contractAddresses,
      txHashes: txHashes ?? this.txHashes,
      requestParams: requestParams ?? this.requestParams,
    );
  }

  @override
  String toString() => jsonEncode(toJson());

  static final tvfRequestMethods = [
    'eth_sendTransaction',
    'eth_sendRawTransaction',
    'solana_signAndSendTransaction',
    'solana_signTransaction',
    'solana_signAllTransactions',
    'wallet_sendCalls',
    // Cosmos
    'cosmos_signDirect',
    // 'cosmos_signAmino',
    // Polkadot
    'polkadot_signTransaction',
    // Near
    'near_signTransaction',
    'near_signTransactions',
    // Stacks
    'stx_transferStx',
    // Bitcoin
    'sendTransfer',
    // Hedera
    'hedera_signAndExecuteTransaction',
    'hedera_executeTransaction',
    // TRON
    'tron_signTransaction',
    // XRPL
    'xrpl_signTransaction',
    'xrpl_signTransactionFor',
    // Algorand
    'algo_signTxn',
    // SUI
    'sui_signTransaction',
    'sui_signAndExecuteTransaction',
  ];
}
