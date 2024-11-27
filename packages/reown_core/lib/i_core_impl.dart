import 'package:logger/logger.dart';
import 'package:reown_core/connectivity/i_connectivity.dart';
import 'package:reown_core/crypto/i_crypto.dart';
import 'package:reown_core/echo/i_echo.dart';
import 'package:reown_core/heartbit/i_heartbeat.dart';
import 'package:reown_core/pairing/i_expirer.dart';
import 'package:reown_core/pairing/i_pairing.dart';
import 'package:reown_core/relay_client/i_relay_client.dart';
import 'package:reown_core/store/i_store.dart';
import 'package:reown_core/store/link_mode_store.dart';
import 'package:reown_core/verify/i_verify.dart';

abstract class IReownCore {
  final String protocol = 'wc';
  final String version = '2';

  abstract String relayUrl;
  abstract final String projectId;
  abstract final String pushUrl;

  abstract IHeartBeat heartbeat;
  abstract ICrypto crypto;
  abstract IRelayClient relayClient;
  abstract IStore<Map<String, dynamic>> storage;

  abstract IConnectivity connectivity;
  abstract IExpirer expirer;
  abstract IPairing pairing;
  abstract IEcho echo;
  abstract final Logger logger;
  abstract IVerify verify;
  abstract ILinkModeStore linkModeStore;

  Future<void> start();

  void confirmOnlineStateOrThrow();

  Future<bool> addLinkModeSupportedApp(String universalLink);

  List<String> getLinkModeSupportedApps();

  void addLogListener(Function(String) callback);
  bool removeLogListener(Function(String) callback);
}
