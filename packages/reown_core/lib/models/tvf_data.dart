import 'dart:convert';

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
        'rpcMethods': rpcMethods,
        'chainId': chainId,
        'contractAddresses': contractAddresses,
        if (includeAll) 'txHashes': txHashes,
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
    'eth_sendTransaction',
    'eth_sendRawTransaction',
    'solana_signAndSendTransaction',
    'solana_signTransaction',
    'solana_signAllTransactions',
    'wallet_sendCalls',
    // Near
    'near_signTransaction',
    'near_signTransactions',
    // Stacks
    'stacks_stxTransfer',
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
