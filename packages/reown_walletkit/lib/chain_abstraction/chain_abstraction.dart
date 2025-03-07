import 'package:reown_walletkit/chain_abstraction/i_chain_abstraction.dart';
import 'package:reown_walletkit/reown_walletkit.dart';

class ChainAbstraction implements IChainAbstraction {
  final IReownCore core;
  final PulseMetadataCompat pulseMetadata;

  ChainAbstraction({required this.core, required this.pulseMetadata});

  YttriumClient get _yttrium => YttriumClient.instance;

  @override
  Future<void> init() async {
    try {
      final packageName = await ReownCoreUtils.getPackageName();
      await _yttrium.init(
        projectId: core.projectId,
        pulseMetadata: pulseMetadata.copyWith(
          packageName:
              pulseMetadata.sdkPlatform == 'android' ? packageName : null,
          bundleId: pulseMetadata.sdkPlatform == 'ios' ? packageName : null,
        ),
      );
    } catch (e) {
      core.logger.e('[$runtimeType] $e');
    }
  }

  @override
  Future<String> erc20TokenBalance({
    required String chainId,
    required String token,
    required String owner,
  }) async {
    return await _yttrium.erc20TokenBalance(
      chainId: chainId,
      token: token,
      owner: owner,
    );
  }

  @override
  Future<Eip1559EstimationCompat> estimateFees({
    required String chainId,
  }) async {
    return await _yttrium.estimateFees(
      chainId: chainId,
    );
  }

  @override
  Future<PrepareDetailedResponseCompat> prepare({
    required String chainId,
    required String from,
    required CallCompat call,
    required Currency localCurrency,
  }) async {
    return await _yttrium.prepareDetailed(
      chainId: chainId,
      from: from,
      call: call,
      localCurrency: localCurrency,
    );
  }

  @override
  Future<ExecuteDetailsCompat> execute({
    required UiFieldsCompat uiFields,
    required List<PrimitiveSignatureCompat> routeTxnSigs,
    required PrimitiveSignatureCompat initialTxnSig,
  }) async {
    return await _yttrium.execute(
      uiFields: uiFields,
      routeTxnSigs: routeTxnSigs,
      initialTxnSig: initialTxnSig,
    );
  }
}
