import 'package:reown_walletkit/reown_walletkit.dart';

abstract class IChainAbstraction {
  Future<void> init();

  Future<Eip1559EstimationCompat> estimateFees({
    required String chainId,
  });

  Future<String> erc20TokenBalance({
    required String chainId,
    required String token,
    required String owner,
  });

  Future<PrepareDetailedResponseCompat> prepare({
    required String chainId,
    required String from,
    required CallCompat call,
    required Currency localCurrency,
  });

  Future<ExecuteDetailsCompat> execute({
    required UiFieldsCompat uiFields,
    required List<PrimitiveSignatureCompat> routeTxnSigs,
    required PrimitiveSignatureCompat initialTxnSig,
  });
}
