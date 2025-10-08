import 'package:reown_yttrium/channels/ton_channel.dart';
import 'package:reown_yttrium/models/chain_abstraction.dart';
import 'package:reown_yttrium/models/shared.dart';
import 'reown_yttrium_platform_interface.dart';

export 'utils/signature_utils.dart';

class ReownYttrium {
  ReownYttriumPlatform get _yttrium => ReownYttriumPlatform.instance;

  Future<bool> init({
    required String projectId,
    required PulseMetadataCompat pulseMetadata,
  }) async {
    return await _yttrium.init(
      projectId: projectId,
      pulseMetadata: pulseMetadata,
    );
  }

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

  Future<Eip1559EstimationCompat> estimateFees({
    required String chainId,
  }) async {
    return await _yttrium.estimateFees(
      chainId: chainId,
    );
  }

  Future<PrepareDetailedResponseCompat> prepareDetailed({
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

  MethodChannelTon get tonClient => _yttrium.tonChannel;
}
