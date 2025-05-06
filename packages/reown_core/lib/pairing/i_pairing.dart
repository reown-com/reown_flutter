import 'package:event/event.dart';
import 'package:reown_core/crypto/crypto_models.dart';
import 'package:reown_core/models/json_rpc_models.dart';
import 'package:reown_core/models/tvf_data.dart';

import 'package:reown_core/pairing/i_pairing_store.dart';
import 'package:reown_core/pairing/utils/pairing_models.dart';
import 'package:reown_core/relay_client/relay_client_models.dart';

abstract class IPairing {
  abstract final Event<PairingEvent> onPairingCreate;
  abstract final Event<PairingActivateEvent> onPairingActivate;
  abstract final Event<PairingEvent> onPairingPing;
  abstract final Event<PairingInvalidEvent> onPairingInvalid;
  abstract final Event<PairingEvent> onPairingDelete;
  abstract final Event<PairingEvent> onPairingExpire;

  Future<void> init();
  Future<PairingInfo> pair({
    required Uri uri,
    bool activatePairing,
  });
  Future<CreateResponse> create({
    List<List<String>>? methods,
    TransportType transportType = TransportType.relay,
  });
  Future<void> activate({required String topic});
  void register({
    required String method,
    required Function(String, JsonRpcRequest, [TransportType]) function,
    required ProtocolType type,
  });
  Future<void> setReceiverPublicKey({
    required String topic,
    required String publicKey,
    int? expiry,
  });
  Future<void> updateExpiry({
    required String topic,
    required int expiry,
  });
  Future<void> updateMetadata({
    required String topic,
    required PairingMetadata metadata,
  });
  Future<void> checkAndExpire();
  List<PairingInfo> getPairings();
  PairingInfo? getPairing({required String topic});
  Future<void> ping({required String topic});
  Future<void> disconnect({required String topic});
  IPairingStore getStore();

  Future sendRequest(
    String topic,
    String method,
    Map<String, dynamic> params, {
    int? id,
    int? ttl,
    EncodeOptions? encodeOptions,
    String? appLink,
    bool openUrl = true,
    TVFData? tvf,
  });

  Future<void> sendResult(
    int id,
    String topic,
    String method,
    dynamic result, {
    EncodeOptions? encodeOptions,
    String? appLink,
    TVFData? tvf,
  });

  Future<void> sendError(
    int id,
    String topic,
    String method,
    JsonRpcError error, {
    EncodeOptions? encodeOptions,
    RpcOptions? rpcOptions,
    String? appLink,
    TVFData? tvf,
  });

  Future<void> isValidPairingTopic({
    required String topic,
  });

  void dispatchEnvelope({
    required String topic,
    required String envelope,
  });
}
