import 'package:reown_yttrium/models/chain_abstraction.dart';

abstract class IChainAbstractionClient {
  Future<String> erc20TokenBalance({
    required String chainId,
    required String token,
    required String owner,
  });

  Future<Eip1559EstimationCompat> estimateFees({
    required String chainId,
  });

  Future<PrepareDetailedResponseCompat> prepareDetailed({
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
