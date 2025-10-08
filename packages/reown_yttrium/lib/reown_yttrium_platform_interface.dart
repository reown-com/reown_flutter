import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:reown_yttrium/channels/ton_channel.dart';
import 'package:reown_yttrium/models/chain_abstraction.dart';
import 'package:reown_yttrium/models/shared.dart';

import 'reown_yttrium_method_channel.dart';

abstract class ReownYttriumPlatform extends PlatformInterface {
  /// Constructs a ReownYttriumPlatform.
  ReownYttriumPlatform() : super(token: _token);

  static final Object _token = Object();

  static ReownYttriumPlatform _instance = MethodChannelReownYttrium();

  /// The default instance of [ReownYttriumPlatform] to use.
  ///
  /// Defaults to [MethodChannelReownYttrium].
  static ReownYttriumPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ReownYttriumPlatform] when
  /// they register themselves.
  static set instance(ReownYttriumPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

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
    required CallCompat call,
    required Currency localCurrency,
  });

  Future<ExecuteDetailsCompat> execute({
    required UiFieldsCompat uiFields,
    required List<PrimitiveSignatureCompat> routeTxnSigs,
    required PrimitiveSignatureCompat initialTxnSig,
  });

  abstract final MethodChannelTon tonChannel;
}
