import 'package:event/event.dart';
import 'package:reown_core/reown_core.dart';
import 'package:reown_sign/i_sign_common.dart';
import 'package:reown_sign/reown_sign.dart';

abstract class IReownSignDapp extends IReownSignCommon {
  abstract final Event<SessionUpdate> onSessionUpdate;
  abstract final Event<SessionExtend> onSessionExtend;
  abstract final Event<SessionEvent> onSessionEvent;
  abstract final Event<SessionAuthResponse> onSessionAuthResponse;

  Future<ConnectResponse> connect({
    Map<String, RequiredNamespace>? requiredNamespaces,
    Map<String, RequiredNamespace>? optionalNamespaces,
    Map<String, String>? sessionProperties,
    String? pairingTopic,
    List<Relay>? relays,
    List<List<String>>? methods,
  });
  Future<dynamic> request({
    int? requestId,
    required String topic,
    required String chainId,
    required SessionRequestParams request,
  });
  Future<List<dynamic>> requestReadContract({
    required DeployedContract deployedContract,
    required String functionName,
    required String rpcUrl,
    EthereumAddress? sender,
    List<dynamic> parameters = const [],
  });
  Future<dynamic> requestWriteContract({
    required String topic,
    required String chainId,
    required DeployedContract deployedContract,
    required String functionName,
    required Transaction transaction,
    String? method,
    List<dynamic> parameters = const [],
  });

  void registerEventHandler({
    required String chainId,
    required String event,
    dynamic Function(String, dynamic)? handler,
  });
  Future<void> ping({
    required String topic,
  });

  Future<SessionAuthRequestResponse> authenticate({
    required SessionAuthRequestParams params,
    String? walletUniversalLink,
    String? pairingTopic,
    List<List<String>>? methods,
  });

  Future<bool> redirectToWallet({
    required String topic,
    required Redirect? redirect,
  });
}
