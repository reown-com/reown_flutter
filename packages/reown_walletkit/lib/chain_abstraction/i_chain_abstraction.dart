import 'package:reown_walletkit/reown_walletkit.dart';

abstract class IChainAbstractionClient {
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
    List<String> accounts = const [],
    Currency localCurrency = Currency.usd,
    bool useLifi = false,
  });

  Future<ExecuteDetailsCompat> execute({
    required UiFieldsCompat uiFields,
    required List<String> routeTxnSigs,
    required String initialTxnSig,
  });
}
