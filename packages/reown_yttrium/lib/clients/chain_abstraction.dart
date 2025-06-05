import 'package:reown_yttrium/clients/i_chain_abstraction.dart';
import 'package:reown_yttrium/models/chain_abstraction.dart';
import 'package:reown_yttrium/reown_yttrium_platform_interface.dart';

class ChainAbstractionClient implements IChainAbstractionClient {
  ReownYttriumPlatformInterface get _yttriumInstance =>
      ReownYttriumPlatformInterface.instance;

  @override
  Future<String> erc20TokenBalance({
    required String chainId,
    required String token,
    required String owner,
  }) async {
    return await _yttriumInstance.chainAbstractionClient.erc20TokenBalance(
      chainId: chainId,
      token: token,
      owner: owner,
    );
  }

  @override
  Future<Eip1559EstimationCompat> estimateFees({
    required String chainId,
  }) async {
    return await _yttriumInstance.chainAbstractionClient.estimateFees(
      chainId: chainId,
    );
  }

  @override
  Future<PrepareDetailedResponseCompat> prepareDetailed({
    required String chainId,
    required String from,
    required List<String> accounts,
    required CallCompat call,
    required Currency localCurrency,
    required bool useLifi,
  }) async {
    return await _yttriumInstance.chainAbstractionClient.prepareDetailed(
      chainId: chainId,
      from: from,
      accounts: accounts,
      call: call,
      localCurrency: localCurrency,
      useLifi: useLifi,
    );
  }

  @override
  Future<ExecuteDetailsCompat> execute({
    required UiFieldsCompat uiFields,
    required List<PrimitiveSignatureCompat> routeTxnSigs,
    required PrimitiveSignatureCompat initialTxnSig,
  }) async {
    return await _yttriumInstance.chainAbstractionClient.execute(
      uiFields: uiFields,
      routeTxnSigs: routeTxnSigs,
      initialTxnSig: initialTxnSig,
    );
  }
}
