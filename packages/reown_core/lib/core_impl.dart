import 'dart:convert';
import 'dart:math';

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
  void addLogListener(Function(String) callback) {
    try {
      _logCallback = (LogEvent event) {
        if (event.level == _logLevel.toLevel()) {
          callback.call('[LogLevel ${event.level.name}] ${event.message}');
        }
      };
      Logger.addLogListener(_logCallback!);
    } catch (_) {}
  }

  late final LogLevel _logLevel;
  late final LogCallback? _logCallback;

  @override
  bool removeLogListener(Function(String) callback) {
    if (_logCallback != null) {
      return Logger.removeLogListener(_logCallback!);
    }
    return false;
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
    PrettyPrinter();
    _logLevel = logLevel;
    _logger = Logger(
      level: _logLevel.toLevel(),
      printer: _LogPrinter(
        stackTraceBeginIndex: 0,
        methodCount:
            _logLevel == LogLevel.debug || _logLevel == LogLevel.error ? 8 : 0,
        errorMethodCount: 8,
      ),
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
  Future<bool> addLinkModeSupportedApp(String universalLink) async {
    logger.d('[$runtimeType] addLinkModeSupportedApp $universalLink');
    return await linkModeStore.update(universalLink);
  }

  @override
  List<String> getLinkModeSupportedApps() {
    final linoModeApps = linkModeStore.getList();
    logger.d('[$runtimeType] getLinkModeSupportedApps $linoModeApps');
    return linoModeApps;
  }

  @override
  void confirmOnlineStateOrThrow() {
    if (!connectivity.isOnline.value) {
      throw ReownCoreError(code: -1, message: 'No internet connection');
    }
  }
}

class _LogPrinter extends LogPrinter {
  static const topLeftCorner = '┌';
  static const bottomLeftCorner = '└';
  static const middleCorner = '├';
  static const verticalLine = '│';
  static const doubleDivider = '─';
  static const singleDivider = '┄';

  static final Map<Level, String> defaultLevelEmojis = {
    Level.debug: '🐛',
    Level.info: '📝',
    Level.error: '❌',
  };

  static final _deviceStackTraceRegex = RegExp(r'#[0-9]+\s+(.+) \((\S+)\)');

  static final _webStackTraceRegex = RegExp(r'^((packages|dart-sdk)/\S+/)');

  static final _browserStackTraceRegex =
      RegExp(r'^(?:package:)?(dart:\S+|\S+)');

  final int stackTraceBeginIndex;

  final int? methodCount;

  final int? errorMethodCount;

  final int lineLength = 200;

  final Map<Level, bool> excludeBox = const {};

  final bool noBoxingByDefault = false;

  final List<String> excludePaths = const [];

  /// Contains the parsed rules resulting from [excludeBox] and [noBoxingByDefault].
  late final Map<Level, bool> _includeBox;
  String _topBorder = '';
  String _middleBorder = '';
  String _bottomBorder = '';

  _LogPrinter({
    this.stackTraceBeginIndex = 0,
    this.methodCount = 0,
    this.errorMethodCount = 8,
  }) {
    var doubleDividerLine = StringBuffer();
    var singleDividerLine = StringBuffer();
    for (var i = 0; i < lineLength - 1; i++) {
      doubleDividerLine.write(doubleDivider);
      singleDividerLine.write(singleDivider);
    }

    _topBorder = '$topLeftCorner$doubleDividerLine';
    _middleBorder = '$middleCorner$singleDividerLine';
    _bottomBorder = '$bottomLeftCorner$doubleDividerLine';

    // Translate excludeBox map (constant if default) to includeBox map with all Level enum possibilities
    _includeBox = {};
    for (var l in Level.values) {
      _includeBox[l] = !noBoxingByDefault;
    }
    excludeBox.forEach((k, v) => _includeBox[k] = !v);
  }

  @override
  List<String> log(LogEvent event) {
    var messageStr = stringifyMessage(event.message);

    String? stackTraceStr;
    if (event.error != null) {
      if ((errorMethodCount == null || errorMethodCount! > 0)) {
        stackTraceStr = formatStackTrace(
          event.stackTrace ?? StackTrace.current,
          errorMethodCount,
        );
      }
    } else if (methodCount == null || methodCount! > 0) {
      stackTraceStr = formatStackTrace(
        event.stackTrace ?? StackTrace.current,
        methodCount,
      );
    }

    var errorStr = event.error?.toString();

    return _formatAndPrint(
      event.level,
      messageStr,
      DateTime.now().toString(),
      errorStr,
      stackTraceStr,
    );
  }

  String? formatStackTrace(StackTrace? stackTrace, int? methodCount) {
    List<String> lines = stackTrace
        .toString()
        .split('\n')
        .where(
          (line) =>
              !_discardDeviceStacktraceLine(line) &&
              !_discardWebStacktraceLine(line) &&
              !_discardBrowserStacktraceLine(line) &&
              line.isNotEmpty,
        )
        .toList();
    List<String> formatted = [];

    int stackTraceLength =
        (methodCount != null ? min(lines.length, methodCount) : lines.length);
    for (int count = 0; count < stackTraceLength; count++) {
      var line = lines[count];
      if (count < stackTraceBeginIndex) {
        continue;
      }
      formatted.add('#$count   ${line.replaceFirst(RegExp(r'#\d+\s+'), '')}');
    }

    if (formatted.isEmpty) {
      return null;
    } else {
      return formatted.join('\n');
    }
  }

  bool _isInExcludePaths(String segment) {
    for (var element in excludePaths) {
      if (segment.startsWith(element)) {
        return true;
      }
    }
    return false;
  }

  bool _discardDeviceStacktraceLine(String line) {
    var match = _deviceStackTraceRegex.matchAsPrefix(line);
    if (match == null) {
      return false;
    }
    final segment = match.group(2)!;
    if (segment.startsWith('package:logger')) {
      return true;
    }
    return _isInExcludePaths(segment);
  }

  bool _discardWebStacktraceLine(String line) {
    var match = _webStackTraceRegex.matchAsPrefix(line);
    if (match == null) {
      return false;
    }
    final segment = match.group(1)!;
    if (segment.startsWith('packages/logger') ||
        segment.startsWith('dart-sdk/lib')) {
      return true;
    }
    return _isInExcludePaths(segment);
  }

  bool _discardBrowserStacktraceLine(String line) {
    var match = _browserStackTraceRegex.matchAsPrefix(line);
    if (match == null) {
      return false;
    }
    final segment = match.group(1)!;
    if (segment.startsWith('package:logger') || segment.startsWith('dart:')) {
      return true;
    }
    return _isInExcludePaths(segment);
  }

  // Handles any object that is causing JsonEncoder() problems
  Object toEncodableFallback(dynamic object) {
    return object.toString();
  }

  String stringifyMessage(dynamic message) {
    final finalMessage = message is Function ? message() : message;
    if (finalMessage is Map || finalMessage is Iterable) {
      var encoder = JsonEncoder.withIndent('  ', toEncodableFallback);
      return encoder.convert(finalMessage);
    } else {
      return finalMessage.toString();
    }
  }

  String _getEmoji(Level level) {
    // if (printEmojis) {
    final String? emoji = defaultLevelEmojis[level];
    if (emoji != null) {
      return '$emoji ';
    }
    // }
    return '';
  }

  List<String> _formatAndPrint(
    Level level,
    String message,
    String time,
    String? error,
    String? stacktrace,
  ) {
    final hasBorders = methodCount != null && methodCount! > 0;

    List<String> buffer = [];
    var verticalLineAtLevel =
        (_includeBox[level]!) && hasBorders ? ('$verticalLine ') : '';

    if (_includeBox[level]! && hasBorders) buffer.add(_topBorder);

    if (error != null) {
      for (var line in error.split('\n')) {
        if (line.isNotEmpty) {
          buffer.add('$verticalLineAtLevel$line');
        }
      }
      if (_includeBox[level]! && hasBorders) buffer.add(_middleBorder);
    }

    if (stacktrace != null) {
      for (var line in stacktrace.split('\n')) {
        if (line.isNotEmpty) {
          buffer.add('$verticalLineAtLevel$line');
        }
      }
      if (_includeBox[level]! && hasBorders) buffer.add(_middleBorder);
    }

    var emoji = _getEmoji(level);
    for (var line in message.split('\n')) {
      if (line.isNotEmpty) {
        buffer.add('$verticalLineAtLevel$time $emoji$line');
      }
    }
    if (_includeBox[level]! && hasBorders) buffer.add(_bottomBorder);

    return buffer;
  }
}
