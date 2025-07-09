import 'package:reown_yttrium/models/chain_abstraction.dart';
import 'package:reown_yttrium/models/shared.dart';

abstract class IChainAbstractionClient {
  Future<bool> init({
    required String projectId,
    required PulseMetadataCompat pulseMetadata,
  });

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
    required List<String> accounts,
    required CallCompat call,
    required Currency localCurrency,
    required bool useLifi,
  });

  Future<ExecuteDetailsCompat> execute({
    required UiFieldsCompat uiFields,
    required List<PrimitiveSignatureCompat> routeTxnSigs,
    required PrimitiveSignatureCompat initialTxnSig,
  });
}
