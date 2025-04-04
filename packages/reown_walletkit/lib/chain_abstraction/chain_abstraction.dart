import 'package:reown_walletkit/chain_abstraction/i_chain_abstraction.dart';
import 'package:reown_walletkit/reown_walletkit.dart';

class ChainAbstraction implements IChainAbstraction {
  final IReownCore core;
  final PulseMetadataCompat pulseMetadata;

  ChainAbstraction({required this.core, required this.pulseMetadata});

  // YttriumClient get _yttrium => YttriumClient.instance;
  ReownYttrium get _reownYttrium => ReownYttrium();

  @override
  Future<void> init() async {
    try {
      final packageName = await ReownCoreUtils.getPackageName();
      await _reownYttrium.init(
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
    return await _reownYttrium.erc20TokenBalance(
      chainId: chainId,
      token: token,
      owner: owner,
    );
  }

  @override
  Future<Eip1559EstimationCompat> estimateFees({
    required String chainId,
  }) async {
    return await _reownYttrium.estimateFees(
      chainId: chainId,
    );
  }

  /// ---------------------------------
  /// ⚠️ This method is experimental. Use with caution.
  /// ---------------------------------
  @override
  Future<PrepareDetailedResponseCompat> prepare({
    required String chainId,
    required String from,
    required CallCompat call,
    Currency? localCurrency,
  }) async {
    if (call.value == null) {
      call = call.copyWith(value: BigInt.zero);
    }
    return await _reownYttrium.prepareDetailed(
      chainId: chainId,
      from: from,
      call: call,
      localCurrency: localCurrency ?? Currency.usd,
    );
  }

  /// ---------------------------------
  /// ⚠️ This method is experimental. Use with caution.
  /// ---------------------------------
  @override
  Future<ExecuteDetailsCompat> execute({
    required UiFieldsCompat uiFields,
    required List<String> routeTxnSigs,
    required String initialTxnSig,
  }) async {
    // This conversion is useless while using swift YttriumWrapper swift pod
    // But used if we decide to go back to flutter_rust_bridge approach
    final initialTxnSigPrimitive = initialTxnSig.toPrimitiveSignature();
    final routeTxnSigsPrimitive = routeTxnSigs.map((signature) {
      return signature.toPrimitiveSignature();
    }).toList();
    return await _reownYttrium.execute(
      uiFields: uiFields,
      routeTxnSigs: routeTxnSigsPrimitive,
      initialTxnSig: initialTxnSigPrimitive,
    );
  }
}
