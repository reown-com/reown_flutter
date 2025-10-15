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
    @Deprecated(
      'requiredNamespaces are automatically assigned to optionalNamespaces. Considering using only optionalNamespaces',
    )
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

  void registerEventHandler({
    required String chainId,
    required String event,
    dynamic Function(String, dynamic)? handler,
  });
  Future<void> ping({required String topic});

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
