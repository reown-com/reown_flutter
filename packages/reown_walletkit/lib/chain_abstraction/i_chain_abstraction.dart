import 'package:reown_walletkit/reown_walletkit.dart';

abstract class IChainAbstractionClient {
  Future<void> init();

  /// ---------------------------------
  /// ⚠️ This method is experimental. Use with caution.
  /// ---------------------------------
  Future<Eip1559EstimationCompat> estimateFees({
    required String chainId,
  });

  /// ---------------------------------
  /// ⚠️ This method is experimental. Use with caution.
  /// ---------------------------------
  Future<String> erc20TokenBalance({
    required String chainId,
    required String token,
    required String owner,
  });

  /// ---------------------------------
  /// ⚠️ This method is experimental. Use with caution.
  /// ---------------------------------
  Future<PrepareDetailedResponseCompat> prepare({
    required String chainId,
    required String from,
    required CallCompat call,
    List<String> accounts = const [],
    Currency localCurrency = Currency.usd,
    bool useLifi = false,
  });

  /// ---------------------------------
  /// ⚠️ This method is experimental. Use with caution.
  /// ---------------------------------
  Future<ExecuteDetailsCompat> execute({
    required UiFieldsCompat uiFields,
    required List<String> routeTxnSigs,
    required String initialTxnSig,
  });
}
