import 'package:logger/logger.dart';
import 'package:reown_core/connectivity/connectivity.dart';
import 'package:reown_core/connectivity/i_connectivity.dart';
import 'package:reown_core/crypto/crypto.dart';
import 'package:reown_core/crypto/i_crypto.dart';
import 'package:reown_core/echo/echo.dart';
import 'package:reown_core/echo/echo_client.dart';
import 'package:reown_core/echo/i_echo.dart';
import 'package:reown_core/heartbit/heartbeat.dart';
import 'package:reown_core/heartbit/i_heartbeat.dart';
import 'package:reown_core/i_core_impl.dart';
import 'package:reown_core/pairing/expirer.dart';
import 'package:reown_core/pairing/i_expirer.dart';
import 'package:reown_core/pairing/json_rpc_history.dart';
import 'package:reown_core/pairing/pairing.dart';
import 'package:reown_core/pairing/pairing_store.dart';
import 'package:reown_core/pairing/utils/pairing_models.dart';
import 'package:reown_core/relay_client/message_tracker.dart';
import 'package:reown_core/relay_client/relay_client.dart';
import 'package:reown_core/relay_client/websocket/http_client.dart';
import 'package:reown_core/relay_client/websocket/i_http_client.dart';
import 'package:reown_core/relay_client/websocket/i_websocket_handler.dart';
import 'package:reown_core/store/generic_store.dart';
import 'package:reown_core/store/i_store.dart';
import 'package:reown_core/relay_client/i_relay_client.dart';
import 'package:reown_core/pairing/i_pairing.dart';
import 'package:reown_core/store/shared_prefs_store.dart';
import 'package:reown_core/store/link_mode_store.dart';
import 'package:reown_core/utils/constants.dart';
import 'package:reown_core/verify/i_verify.dart';
import 'package:reown_core/verify/verify.dart';
import 'package:reown_core/utils/log_level.dart';
import 'package:reown_core/utils/utils.dart';
import 'package:reown_core/models/basic_models.dart';

class ReownCore implements IReownCore {
  @override
  String get protocol => 'wc';
  @override
  String get version => '2';

  @override
  final String projectId;

  @override
  String relayUrl = ReownConstants.DEFAULT_RELAY_URL;

  @override
  String pushUrl = ReownConstants.DEFAULT_PUSH_URL;

  @override
  late ICrypto crypto;

  @override
  late IRelayClient relayClient;

  @override
  late IExpirer expirer;

  @override
  late IPairing pairing;

  @override
  late IEcho echo;

  @override
  late IHeartBeat heartbeat;

  @override
  late IVerify verify;

  @override
  late IConnectivity connectivity;

  @override
  late ILinkModeStore linkModeStore;

  Logger _logger = Logger(
    level: Level.off,
    printer: PrettyPrinter(),
  );
  @override
  Logger get logger => _logger;

  @override
  void addLogListener(LogCallback callback) {
    Logger.addLogListener(callback);
  }

  @override
  bool removeLogListener(LogCallback callback) {
    return Logger.removeLogListener(callback);
  }

  @override
  late IStore<Map<String, dynamic>> storage;

  ReownCore({
    required this.projectId,
    this.relayUrl = ReownConstants.DEFAULT_RELAY_URL,
    this.pushUrl = ReownConstants.DEFAULT_PUSH_URL,
    bool memoryStore = false,
    LogLevel logLevel = LogLevel.nothing,
    IHttpClient httpClient = const HttpWrapper(),
    IWebSocketHandler? webSocketHandler,
  }) {
    _logger = Logger(
      level: logLevel.toLevel(),
      printer: PrettyPrinter(methodCount: null),
    );
    heartbeat = HeartBeat();
    storage = SharedPrefsStores(
      memoryStore: memoryStore,
    );
    crypto = Crypto(
      core: this,
      keyChain: GenericStore<String>(
        storage: storage,
        context: StoreVersions.CONTEXT_KEYCHAIN,
        version: StoreVersions.VERSION_KEYCHAIN,
        fromJson: (dynamic value) => value as String,
      ),
    );
    relayClient = RelayClient(
      core: this,
      messageTracker: MessageTracker(
        storage: storage,
        context: StoreVersions.CONTEXT_MESSAGE_TRACKER,
        version: StoreVersions.VERSION_MESSAGE_TRACKER,
        fromJson: (dynamic value) {
          return ReownCoreUtils.convertMapTo<String>(value);
        },
      ),
      topicMap: GenericStore<String>(
        storage: storage,
        context: StoreVersions.CONTEXT_TOPIC_MAP,
        version: StoreVersions.VERSION_TOPIC_MAP,
        fromJson: (dynamic value) => value as String,
      ),
      socketHandler: webSocketHandler,
    );
    expirer = Expirer(
      storage: storage,
      context: StoreVersions.CONTEXT_EXPIRER,
      version: StoreVersions.VERSION_EXPIRER,
      fromJson: (dynamic value) => value as int,
    );
    pairing = Pairing(
      core: this,
      pairings: PairingStore(
        storage: storage,
        context: StoreVersions.CONTEXT_PAIRINGS,
        version: StoreVersions.VERSION_PAIRINGS,
        fromJson: (dynamic value) {
          return PairingInfo.fromJson(value as Map<String, dynamic>);
        },
      ),
      history: JsonRpcHistory(
        storage: storage,
        context: StoreVersions.CONTEXT_JSON_RPC_HISTORY,
        version: StoreVersions.VERSION_JSON_RPC_HISTORY,
        fromJson: (dynamic value) => JsonRpcRecord.fromJson(value),
      ),
      topicToReceiverPublicKey: GenericStore(
        storage: storage,
        context: StoreVersions.CONTEXT_TOPIC_TO_RECEIVER_PUBLIC_KEY,
        version: StoreVersions.VERSION_TOPIC_TO_RECEIVER_PUBLIC_KEY,
        fromJson: (dynamic value) => ReceiverPublicKey.fromJson(value),
      ),
    );
    echo = Echo(
      core: this,
      echoClient: EchoClient(
        baseUrl: pushUrl,
        httpClient: httpClient,
      ),
    );
    verify = Verify(
      core: this,
      httpClient: httpClient,
    );
    connectivity = ConnectivityState(
      core: this,
    );
    linkModeStore = LinkModeStore(
      storage: storage,
      context: StoreVersions.CONTEXT_LINKMODE,
      version: StoreVersions.VERSION_LINKMODE,
      fromJson: (dynamic value) => value as List<String>,
    );
  }

  @override
  Future<void> start() async {
    await storage.init();
    await crypto.init();
    await relayClient.init();
    await expirer.init();
    await pairing.init();
    await connectivity.init();
    await linkModeStore.init();
    heartbeat.init();
  }

  @override
  Future<void> addLinkModeSupportedApp(String universalLink) async {
    return await linkModeStore.update(universalLink);
  }

  @override
  List<String> getLinkModeSupportedApps() {
    return linkModeStore.getList();
  }

  @override
  void confirmOnlineStateOrThrow() {
    if (!connectivity.isOnline.value) {
      throw ReownCoreError(code: -1, message: 'No internet connection');
    }
  }
}
