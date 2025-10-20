import 'package:reown_core/events/models/basic_event.dart';

enum AnalyticsPlatform { mobile, web, qrcode, email, unsupported }

abstract class _AnalyticsEvent implements BasicCoreEvent {
  @override
  String get type => CoreEventType.TRACK;

  @override
  CoreEventProperties? get properties => null;

  @override
  Map<String, dynamic> toJson() => {
    'type': type,
    'event': event,
    if (properties != null) 'properties': properties?.toJson(),
  };
}

class ModalCreatedEvent extends _AnalyticsEvent {
  @override
  String get event => CoreEventEvent.ModalTrack.MODAL_CREATED;
}

class ModalLoadedEvent extends _AnalyticsEvent {
  @override
  String get event => CoreEventEvent.ModalTrack.MODAL_LOADED;
}

class InitializeEvent extends _AnalyticsEvent {
  final bool? _showWallets;
  final Map<String, dynamic>? _siweConfig;
  final String? _themeMode;
  final List<String>? _networks;
  final String? _defaultNetwork;
  final List<String>? _chainImages;
  final Map<String, dynamic>? _metadata;

  InitializeEvent({
    required bool? showWallets,
    required Map<String, dynamic>? siweConfig,
    required String? themeMode,
    required List<String>? networks,
    required String? defaultNetwork,
    required List<String>? chainImages,
    required Map<String, dynamic>? metadata,
  }) : _showWallets = showWallets,
       _siweConfig = siweConfig,
       _themeMode = themeMode,
       _networks = networks,
       _defaultNetwork = defaultNetwork,
       _chainImages = chainImages,
       _metadata = metadata;

  @override
  String get event => CoreEventEvent.ModalTrack.INITIALIZE;

  @override
  CoreEventProperties? get properties => CoreEventProperties(
    showWallets: _showWallets,
    siweConfig: _siweConfig,
    themeMode: _themeMode,
    networks: _networks,
    defaultNetwork: _defaultNetwork,
    chainImages: _chainImages,
    metadata: _metadata,
  );
}

class ModalOpenEvent extends _AnalyticsEvent {
  final bool _connected;
  ModalOpenEvent({required bool connected}) : _connected = connected;

  @override
  String get event => CoreEventEvent.ModalTrack.MODAL_OPEN;

  @override
  CoreEventProperties? get properties =>
      CoreEventProperties(connected: _connected);
}

class ModalCloseEvent extends _AnalyticsEvent {
  final bool _connected;
  ModalCloseEvent({required bool connected}) : _connected = connected;

  @override
  String get event => CoreEventEvent.ModalTrack.MODAL_CLOSE;

  @override
  CoreEventProperties? get properties =>
      CoreEventProperties(connected: _connected);
}

class ClickAllWalletsEvent extends _AnalyticsEvent {
  @override
  String get event => CoreEventEvent.ModalTrack.CLICK_ALL_WALLETS;
}

class ClickNetworksEvent extends _AnalyticsEvent {
  @override
  String get event => CoreEventEvent.ModalTrack.CLICK_NETWORKS;
}

class SwitchNetworkEvent extends _AnalyticsEvent {
  final String _network;
  SwitchNetworkEvent({required String network}) : _network = network;

  @override
  String get event => CoreEventEvent.ModalTrack.SWITCH_NETWORK;

  @override
  CoreEventProperties? get properties => CoreEventProperties(network: _network);
}

class SelectWalletEvent extends _AnalyticsEvent {
  final String _name;
  final String? _explorerId;
  final String? _platform;
  final int? _walletRank;
  final int? _displayIndex;
  final String? _view;
  SelectWalletEvent({
    required String name,
    String? explorerId,
    AnalyticsPlatform? platform,
    int? walletRank,
    int? displayIndex,
    String? view,
  }) : _name = name,
       _explorerId = explorerId,
       _platform = platform?.name,
       _walletRank = walletRank,
       _displayIndex = displayIndex,
       _view = view;

  @override
  String get event => CoreEventEvent.ModalTrack.SELECT_WALLET;

  @override
  CoreEventProperties? get properties => CoreEventProperties(
    name: _name,
    platform: _platform,
    explorerId: _explorerId,
    walletRank: _walletRank,
    displayIndex: _displayIndex, // TODO analytics
    view: _view,
  );
}

class ConnectSuccessEvent extends _AnalyticsEvent {
  final String _name;
  final String? _method;
  final String? _explorerId;
  final String? _caipNetworkId;
  final bool? _reconnect;

  ConnectSuccessEvent({
    required String name,
    String? explorerId,
    AnalyticsPlatform? method,
    String? caipNetworkId,
    bool? reconnect,
  }) : _name = name,
       _explorerId = explorerId,
       _method = method?.name,
       _caipNetworkId = caipNetworkId,
       _reconnect = reconnect;

  @override
  String get event => CoreEventEvent.ModalTrack.CONNECT_SUCCESS;

  @override
  CoreEventProperties? get properties => CoreEventProperties(
    name: _name,
    explorerId: _explorerId,
    method: _method,
    caipNetworkId: _caipNetworkId,
    reconnect: _reconnect,
  );
}

class ConnectErrorEvent extends _AnalyticsEvent {
  final String _message;
  ConnectErrorEvent({required String message}) : _message = message;

  @override
  String get event => CoreEventEvent.ModalTrack.CONNECT_ERROR;

  @override
  CoreEventProperties? get properties => CoreEventProperties(message: _message);
}

class DisconnectSuccessEvent extends _AnalyticsEvent {
  final String? _namespace;
  DisconnectSuccessEvent({required String? namespace}) : _namespace = namespace;

  @override
  String get event => CoreEventEvent.ModalTrack.DISCONNECT_SUCCESS;

  @override
  CoreEventProperties? get properties =>
      CoreEventProperties(namespace: _namespace);
}

class DisconnectErrorEvent extends _AnalyticsEvent {
  @override
  String get event => CoreEventEvent.ModalTrack.DISCONNECT_ERROR;
}

class ClickWalletHelpEvent extends _AnalyticsEvent {
  @override
  String get event => CoreEventEvent.ModalTrack.CLICK_WALLET_HELP;
}

class ClickNetworkHelpEvent extends _AnalyticsEvent {
  @override
  String get event => CoreEventEvent.ModalTrack.CLICK_NETWORK_HELP;
}

class ClickGetWalletHelpEvent extends _AnalyticsEvent {
  @override
  String get event => CoreEventEvent.ModalTrack.CLICK_GET_WALLET_HELP;
}

class GetWalletEvent extends _AnalyticsEvent {
  final String _name;
  final int _walletRank;
  final String _explorerId;
  final String _link;
  final String _linkType;

  GetWalletEvent({
    required String name,
    required int walletRank,
    required String explorerId,
    required String link,
    required String linkType,
  }) : _name = name,
       _walletRank = walletRank,
       _explorerId = explorerId,
       _link = link,
       _linkType = linkType;

  @override
  String get event => CoreEventEvent.ModalTrack.GET_WALLET;

  @override
  CoreEventProperties? get properties => CoreEventProperties(
    name: _name,
    walletRank: _walletRank,
    explorerId: _explorerId,
    link: _link,
    linkType: _linkType,
  );
}

class EmailLoginSelected extends _AnalyticsEvent {
  @override
  String get event => CoreEventEvent.ModalTrack.EMAIL_LOGIN_SELECTED;
}

class EmailSubmitted extends _AnalyticsEvent {
  @override
  String get event => CoreEventEvent.ModalTrack.EMAIL_SUBMITTED;
}

class DeviceRegisteredForEmail extends _AnalyticsEvent {
  @override
  String get event => CoreEventEvent.ModalTrack.DEVICE_REGISTERED_FOR_EMAIL;
}

class EmailVerificationCodeSent extends _AnalyticsEvent {
  @override
  String get event => CoreEventEvent.ModalTrack.EMAIL_VERIFICATION_CODE_SENT;
}

class EmailVerificationCodePass extends _AnalyticsEvent {
  @override
  String get event => CoreEventEvent.ModalTrack.EMAIL_VERIFICATION_CODE_PASS;
}

class EmailVerificationCodeFail extends _AnalyticsEvent {
  @override
  String get event => CoreEventEvent.ModalTrack.EMAIL_VERIFICATION_CODE_FAIL;
}

class EmailEdit extends _AnalyticsEvent {
  @override
  String get event => CoreEventEvent.ModalTrack.EMAIL_EDIT;
}

class EmailEditComplete extends _AnalyticsEvent {
  @override
  String get event => CoreEventEvent.ModalTrack.EMAIL_EDIT_COMPLETE;
}

class EmailUpgradeFromModal extends _AnalyticsEvent {
  @override
  String get event => CoreEventEvent.ModalTrack.EMAIL_UPGRADE_FROM_MODAL;
}

class ClickSignSiweMessage extends _AnalyticsEvent {
  final String _network;
  ClickSignSiweMessage({required String network}) : _network = network;

  @override
  String get event => CoreEventEvent.ModalTrack.CLICK_SIGN_SIWE_MESSAGE;

  @override
  CoreEventProperties? get properties => CoreEventProperties(network: _network);
}

class ClickCancelSiwe extends _AnalyticsEvent {
  final String _network;
  ClickCancelSiwe({required String network}) : _network = network;

  @override
  String get event => CoreEventEvent.ModalTrack.CLICK_CANCEL_SIWE;

  @override
  CoreEventProperties? get properties => CoreEventProperties(network: _network);
}

class SiweAuthSuccess extends _AnalyticsEvent {
  final String _network;
  SiweAuthSuccess({required String network}) : _network = network;

  @override
  String get event => CoreEventEvent.ModalTrack.SIWE_AUTH_SUCCESS;

  @override
  CoreEventProperties? get properties => CoreEventProperties(network: _network);
}

class SiweAuthError extends _AnalyticsEvent {
  final String _network;
  SiweAuthError({required String network}) : _network = network;

  @override
  String get event => CoreEventEvent.ModalTrack.SIWE_AUTH_ERROR;

  @override
  CoreEventProperties? get properties => CoreEventProperties(network: _network);
}

class SocialLoginStarted extends _AnalyticsEvent {
  final String _provider;
  SocialLoginStarted({required String provider}) : _provider = provider;

  @override
  String get event => CoreEventEvent.ModalTrack.SOCIAL_LOGIN_STARTED;

  @override
  CoreEventProperties? get properties =>
      CoreEventProperties(provider: _provider);
}

class SocialLoginSuccess extends _AnalyticsEvent {
  final String _provider;
  SocialLoginSuccess({required String provider}) : _provider = provider;

  @override
  String get event => CoreEventEvent.ModalTrack.SOCIAL_LOGIN_SUCCESS;

  @override
  CoreEventProperties? get properties =>
      CoreEventProperties(provider: _provider);
}

class SocialLoginError extends _AnalyticsEvent {
  final String _provider;
  SocialLoginError({required String provider}) : _provider = provider;

  @override
  String get event => CoreEventEvent.ModalTrack.SOCIAL_LOGIN_ERROR;

  @override
  CoreEventProperties? get properties =>
      CoreEventProperties(provider: _provider);
}

class SocialLoginRequestUserData extends _AnalyticsEvent {
  final String _provider;
  SocialLoginRequestUserData({required String provider}) : _provider = provider;

  @override
  String get event => CoreEventEvent.ModalTrack.SOCIAL_LOGIN_REQUEST_USER_DATA;

  @override
  CoreEventProperties? get properties =>
      CoreEventProperties(provider: _provider);
}

class SocialLoginCanceled extends _AnalyticsEvent {
  final String _provider;
  SocialLoginCanceled({required String provider}) : _provider = provider;

  @override
  String get event => CoreEventEvent.ModalTrack.SOCIAL_LOGIN_CANCELED;

  @override
  CoreEventProperties? get properties =>
      CoreEventProperties(provider: _provider);
}

class WalletFeatureOpenSend extends _AnalyticsEvent {
  final String _network;
  WalletFeatureOpenSend({required String network}) : _network = network;

  @override
  String get event => CoreEventEvent.ModalTrack.OPEN_SEND;

  @override
  CoreEventProperties? get properties => CoreEventProperties(network: _network);
}

class WalletFeatureSendInitiated extends _AnalyticsEvent {
  final String _network;
  final String _sendToken;
  final String _sendAmount;

  WalletFeatureSendInitiated({
    required String network,
    required String sendToken,
    required String sendAmount,
  }) : _network = network,
       _sendToken = sendToken,
       _sendAmount = sendAmount;

  @override
  String get event => CoreEventEvent.ModalTrack.SEND_INITIATED;

  @override
  CoreEventProperties? get properties => CoreEventProperties(
    network: _network,
    sendToken: _sendToken,
    sendAmount: _sendAmount,
  );
}

class WalletFeatureSendSuccess extends _AnalyticsEvent {
  final String _network;
  final String _sendToken;
  final String _sendAmount;

  WalletFeatureSendSuccess({
    required String network,
    required String sendToken,
    required String sendAmount,
  }) : _network = network,
       _sendToken = sendToken,
       _sendAmount = sendAmount;

  @override
  String get event => CoreEventEvent.ModalTrack.SEND_SUCCESS;

  @override
  CoreEventProperties? get properties => CoreEventProperties(
    network: _network,
    sendToken: _sendToken,
    sendAmount: _sendAmount,
  );
}

class WalletFeatureSendError extends _AnalyticsEvent {
  final String _network;
  final String _sendToken;
  final String _sendAmount;

  WalletFeatureSendError({
    required String network,
    required String sendToken,
    required String sendAmount,
  }) : _network = network,
       _sendToken = sendToken,
       _sendAmount = sendAmount;

  @override
  String get event => CoreEventEvent.ModalTrack.SEND_ERROR;

  @override
  CoreEventProperties? get properties => CoreEventProperties(
    network: _network,
    sendToken: _sendToken,
    sendAmount: _sendAmount,
  );
}

// class WalletFeatureSignTransaction extends _AnalyticsEvent {
//   final String _network;
//   final String _sendToken;
//   final String _sendAmount;

//   WalletFeatureSignTransaction({
//     required String network,
//     required String sendToken,
//     required String sendAmount,
//   }) : _network = network,
//        _sendToken = sendToken,
//        _sendAmount = sendAmount;

//   @override
//   String get event => CoreEventEvent.ModalTrack.SIGN_TRANSACTION;

//   @override
//   CoreEventProperties? get properties => CoreEventProperties(
//     network: _network,
//     sendToken: _sendToken,
//     sendAmount: _sendAmount,
//   );
// }

class ClickTransactionsEvent extends _AnalyticsEvent {
  @override
  String get event => CoreEventEvent.ModalTrack.CLICK_TRANSACTIONS;
}

class LoadMoreTransactionsEvent extends _AnalyticsEvent {
  final String? _address;
  final String _projectId;
  final String? _cursor;
  LoadMoreTransactionsEvent({
    required String projectId,
    String? address,
    String? cursor,
  }) : _address = address,
       _projectId = projectId,
       _cursor = cursor;

  @override
  String get event => CoreEventEvent.ModalTrack.LOAD_MORE_TRANSACTIONS;

  @override
  CoreEventProperties? get properties => CoreEventProperties(
    address: _address,
    project_id: _projectId,
    cursor: _cursor,
  );
}

class ErrorFetchTransactionsEvent extends _AnalyticsEvent {
  final String? _address;
  final String _projectId;
  final String? _cursor;
  ErrorFetchTransactionsEvent({
    required String projectId,
    String? address,
    String? cursor,
  }) : _address = address,
       _projectId = projectId,
       _cursor = cursor;

  @override
  String get event => CoreEventEvent.ModalTrack.LOAD_MORE_TRANSACTIONS;

  @override
  CoreEventProperties? get properties => CoreEventProperties(
    address: _address,
    project_id: _projectId,
    cursor: _cursor,
  );
}

class PayExchangeSelectedEvent extends _AnalyticsEvent {
  final Map<String, String> _exchange;
  final Map<String, String> _configuration;
  final Map<String, String> _currentPayment;
  final String _source;
  final bool _headless;

  PayExchangeSelectedEvent({
    required Map<String, String> exchange,
    required Map<String, String> configuration,
    required Map<String, String> currentPayment,
    required String source,
    required bool headless,
  }) : _exchange = exchange,
       _configuration = configuration,
       _currentPayment = currentPayment,
       _source = source,
       _headless = headless;

  @override
  String get event => CoreEventEvent.ModalTrack.PAY_EXCHANGE_SELECTED;

  @override
  CoreEventProperties? get properties => CoreEventProperties(
    exchange: _exchange,
    configuration: _configuration,
    currentPayment: _currentPayment,
    source: _source,
    headless: _headless,
  );
}
