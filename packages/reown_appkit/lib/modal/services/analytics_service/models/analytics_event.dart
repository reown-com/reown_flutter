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
  String get event => CoreEventEvent.Track.MODAL_CREATED;
}

class ModalLoadedEvent extends _AnalyticsEvent {
  @override
  String get event => CoreEventEvent.Track.MODAL_LOADED;
}

class ModalOpenEvent extends _AnalyticsEvent {
  final bool _connected;
  ModalOpenEvent({required bool connected}) : _connected = connected;

  @override
  String get event => CoreEventEvent.Track.MODAL_OPEN;

  @override
  CoreEventProperties? get properties =>
      CoreEventProperties(connected: _connected);
}

class ModalCloseEvent extends _AnalyticsEvent {
  final bool _connected;
  ModalCloseEvent({required bool connected}) : _connected = connected;

  @override
  String get event => CoreEventEvent.Track.MODAL_CLOSE;

  @override
  CoreEventProperties? get properties =>
      CoreEventProperties(connected: _connected);
}

class ClickAllWalletsEvent extends _AnalyticsEvent {
  @override
  String get event => CoreEventEvent.Track.CLICK_ALL_WALLETS;
}

class ClickNetworksEvent extends _AnalyticsEvent {
  @override
  String get event => CoreEventEvent.Track.CLICK_NETWORKS;
}

class SwitchNetworkEvent extends _AnalyticsEvent {
  final String _network;
  SwitchNetworkEvent({required String network}) : _network = network;

  @override
  String get event => CoreEventEvent.Track.SWITCH_NETWORK;

  @override
  CoreEventProperties? get properties => CoreEventProperties(network: _network);
}

class SelectWalletEvent extends _AnalyticsEvent {
  final String _name;
  final String? _explorerId;
  final String? _platform;
  SelectWalletEvent({
    required String name,
    String? explorerId,
    AnalyticsPlatform? platform,
  }) : _name = name,
       _explorerId = explorerId,
       _platform = platform?.name;

  @override
  String get event => CoreEventEvent.Track.SELECT_WALLET;

  @override
  CoreEventProperties? get properties => CoreEventProperties(
    name: _name,
    explorer_id: _explorerId,
    platform: _platform,
  );
}

class ConnectSuccessEvent extends _AnalyticsEvent {
  final String _name;
  final String? _explorerId;
  final String? _method;
  ConnectSuccessEvent({
    required String name,
    String? explorerId,
    AnalyticsPlatform? method,
  }) : _name = name,
       _explorerId = explorerId,
       _method = method?.name;

  @override
  String get event => CoreEventEvent.Track.CONNECT_SUCCESS;

  @override
  CoreEventProperties? get properties => CoreEventProperties(
    name: _name,
    explorer_id: _explorerId,
    method: _method,
  );
}

class ConnectErrorEvent extends _AnalyticsEvent {
  final String _message;
  ConnectErrorEvent({required String message}) : _message = message;

  @override
  String get event => CoreEventEvent.Track.CONNECT_ERROR;

  @override
  CoreEventProperties? get properties => CoreEventProperties(message: _message);
}

class DisconnectSuccessEvent extends _AnalyticsEvent {
  @override
  String get event => CoreEventEvent.Track.DISCONNECT_SUCCESS;
}

class DisconnectErrorEvent extends _AnalyticsEvent {
  @override
  String get event => CoreEventEvent.Track.DISCONNECT_ERROR;
}

class ClickWalletHelpEvent extends _AnalyticsEvent {
  @override
  String get event => CoreEventEvent.Track.CLICK_WALLET_HELP;
}

class ClickNetworkHelpEvent extends _AnalyticsEvent {
  @override
  String get event => CoreEventEvent.Track.CLICK_NETWORK_HELP;
}

class ClickGetWalletEvent extends _AnalyticsEvent {
  @override
  String get event => CoreEventEvent.Track.CLICK_GET_WALLET;
}

class EmailLoginSelected extends _AnalyticsEvent {
  @override
  String get event => CoreEventEvent.Track.EMAIL_LOGIN_SELECTED;
}

class EmailSubmitted extends _AnalyticsEvent {
  @override
  String get event => CoreEventEvent.Track.EMAIL_SUBMITTED;
}

class DeviceRegisteredForEmail extends _AnalyticsEvent {
  @override
  String get event => CoreEventEvent.Track.DEVICE_REGISTERED_FOR_EMAIL;
}

class EmailVerificationCodeSent extends _AnalyticsEvent {
  @override
  String get event => CoreEventEvent.Track.EMAIL_VERIFICATION_CODE_SENT;
}

class EmailVerificationCodePass extends _AnalyticsEvent {
  @override
  String get event => CoreEventEvent.Track.EMAIL_VERIFICATION_CODE_PASS;
}

class EmailVerificationCodeFail extends _AnalyticsEvent {
  @override
  String get event => CoreEventEvent.Track.EMAIL_VERIFICATION_CODE_FAIL;
}

class EmailEdit extends _AnalyticsEvent {
  @override
  String get event => CoreEventEvent.Track.EMAIL_EDIT;
}

class EmailEditComplete extends _AnalyticsEvent {
  @override
  String get event => CoreEventEvent.Track.EMAIL_EDIT_COMPLETE;
}

class EmailUpgradeFromModal extends _AnalyticsEvent {
  @override
  String get event => CoreEventEvent.Track.EMAIL_UPGRADE_FROM_MODAL;
}

class ClickSignSiweMessage extends _AnalyticsEvent {
  final String _network;
  ClickSignSiweMessage({required String network}) : _network = network;

  @override
  String get event => CoreEventEvent.Track.CLICK_SIGN_SIWE_MESSAGE;

  @override
  CoreEventProperties? get properties => CoreEventProperties(network: _network);
}

class ClickCancelSiwe extends _AnalyticsEvent {
  final String _network;
  ClickCancelSiwe({required String network}) : _network = network;

  @override
  String get event => CoreEventEvent.Track.CLICK_CANCEL_SIWE;

  @override
  CoreEventProperties? get properties => CoreEventProperties(network: _network);
}

class SiweAuthSuccess extends _AnalyticsEvent {
  final String _network;
  SiweAuthSuccess({required String network}) : _network = network;

  @override
  String get event => CoreEventEvent.Track.SIWE_AUTH_SUCCESS;

  @override
  CoreEventProperties? get properties => CoreEventProperties(network: _network);
}

class SiweAuthError extends _AnalyticsEvent {
  final String _network;
  SiweAuthError({required String network}) : _network = network;

  @override
  String get event => CoreEventEvent.Track.SIWE_AUTH_ERROR;

  @override
  CoreEventProperties? get properties => CoreEventProperties(network: _network);
}

class SocialLoginStarted extends _AnalyticsEvent {
  final String _provider;
  SocialLoginStarted({required String provider}) : _provider = provider;

  @override
  String get event => CoreEventEvent.Track.SOCIAL_LOGIN_STARTED;

  @override
  CoreEventProperties? get properties =>
      CoreEventProperties(provider: _provider);
}

class SocialLoginSuccess extends _AnalyticsEvent {
  final String _provider;
  SocialLoginSuccess({required String provider}) : _provider = provider;

  @override
  String get event => CoreEventEvent.Track.SOCIAL_LOGIN_SUCCESS;

  @override
  CoreEventProperties? get properties =>
      CoreEventProperties(provider: _provider);
}

class SocialLoginError extends _AnalyticsEvent {
  final String _provider;
  SocialLoginError({required String provider}) : _provider = provider;

  @override
  String get event => CoreEventEvent.Track.SOCIAL_LOGIN_ERROR;

  @override
  CoreEventProperties? get properties =>
      CoreEventProperties(provider: _provider);
}

class SocialLoginRequestUserData extends _AnalyticsEvent {
  final String _provider;
  SocialLoginRequestUserData({required String provider}) : _provider = provider;

  @override
  String get event => CoreEventEvent.Track.SOCIAL_LOGIN_REQUEST_USER_DATA;

  @override
  CoreEventProperties? get properties =>
      CoreEventProperties(provider: _provider);
}

class SocialLoginCanceled extends _AnalyticsEvent {
  final String _provider;
  SocialLoginCanceled({required String provider}) : _provider = provider;

  @override
  String get event => CoreEventEvent.Track.SOCIAL_LOGIN_CANCELED;

  @override
  CoreEventProperties? get properties =>
      CoreEventProperties(provider: _provider);
}

class WalletFeatureOpenSend extends _AnalyticsEvent {
  final String _network;
  WalletFeatureOpenSend({required String network}) : _network = network;

  @override
  String get event => CoreEventEvent.Track.OPEN_SEND;

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
  String get event => CoreEventEvent.Track.SEND_INITIATED;

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
  String get event => CoreEventEvent.Track.SEND_SUCCESS;

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
  String get event => CoreEventEvent.Track.SEND_ERROR;

  @override
  CoreEventProperties? get properties => CoreEventProperties(
    network: _network,
    sendToken: _sendToken,
    sendAmount: _sendAmount,
  );
}

class WalletFeatureSignTransaction extends _AnalyticsEvent {
  final String _network;
  final String _sendToken;
  final String _sendAmount;

  WalletFeatureSignTransaction({
    required String network,
    required String sendToken,
    required String sendAmount,
  }) : _network = network,
       _sendToken = sendToken,
       _sendAmount = sendAmount;

  @override
  String get event => CoreEventEvent.Track.SIGN_TRANSACTION;

  @override
  CoreEventProperties? get properties => CoreEventProperties(
    network: _network,
    sendToken: _sendToken,
    sendAmount: _sendAmount,
  );
}

class ClickTransactionsEvent extends _AnalyticsEvent {
  @override
  String get event => CoreEventEvent.Track.CLICK_TRANSACTIONS;
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
  String get event => CoreEventEvent.Track.LOAD_MORE_TRANSACTIONS;

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
  String get event => CoreEventEvent.Track.LOAD_MORE_TRANSACTIONS;

  @override
  CoreEventProperties? get properties => CoreEventProperties(
    address: _address,
    project_id: _projectId,
    cursor: _cursor,
  );
}
