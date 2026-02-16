import 'package:freezed_annotation/freezed_annotation.dart';

part 'basic_event.g.dart';
part 'basic_event.freezed.dart';

class BasicCoreEvent {
  final String? type;
  final String event;
  final CoreEventProperties? properties;

  BasicCoreEvent({this.type, required this.event, required this.properties});

  Map<String, dynamic> toJson() => {
    'type': type,
    'event': event,
    if (properties != null) 'properties': properties?.toJson(),
  };
}

@freezed
sealed class CoreEventProperties with _$CoreEventProperties {
  @JsonSerializable(includeIfNull: false)
  const factory CoreEventProperties({
    String? message,
    String? name,
    String? method,
    bool? connected,
    String? namespace,
    String? network,
    String? caipNetworkId,
    String? explorerId,
    int? walletRank,
    int? displayIndex,
    String? view,
    String? provider,
    String? platform,
    List<String>? trace,
    String? topic,
    int? correlation_id,
    String? client_id,
    String? direction,
    String? userAgent,
    String? token,
    String? amount,
    String? hash,
    String? address,
    String? project_id,
    String? cursor,
    Map<String, String>? exchange,
    Map<String, String>? configuration,
    Map<String, String>? currentPayment,
    String? source,
    bool? headless,
    bool? reconnect,
    String? link,
    String? linkType,
    bool? showWallets,
    Map<String, dynamic>? siweConfig,
    String? themeMode,
    //   themeVariables?: ThemeVariables
    //   allowUnsupportedChain?: boolean
    List<String>? networks,
    String? defaultNetwork,
    List<String>? chainImages,
    //   connectorImages?: Record<string, string>
    //   coinbasePreference?: 'all' | 'smartWalletOnly' | 'eoaOnly'
    Map<String, dynamic>? metadata,
    String? accountType,
    String? query,
    bool? certified,
    bool? installed,
  }) = _CoreEventProperties;

  factory CoreEventProperties.fromJson(Map<String, dynamic> json) =>
      _$CoreEventPropertiesFromJson(json);
}

class CoreEventType {
  static const String ERROR = 'ERROR';
  static const String SUCCESS = 'SUCCESS';
  static const String INIT = 'INIT';
  static const String TRACK = 'TRACK';
}

class CoreEventEvent {
  static const Error = _ErrorOptions();
  static const ModalTrack = _ModalTrackOptions();
}

class _ErrorOptions {
  const _ErrorOptions();

  String get NO_WSS_CONNECTION => 'NO_WSS_CONNECTION';
  String get NO_INTERNET_CONNECTION => 'NO_INTERNET_CONNECTION';
  String get MALFORMED_PAIRING_URI => 'MALFORMED_PAIRING_URI';
  String get PAIRING_ALREADY_EXIST => 'PAIRING_ALREADY_EXIST';
  String get PAIRING_SUBSCRIPTION_FAILURE =>
      'FAILED_TO_SUBSCRIBE_TO_PAIRING_TOPIC';
  String get PAIRING_URI_EXPIRED => 'PAIRING_URI_EXPIRED';
  String get PAIRING_EXPIRED => 'PAIRING_EXPIRED';
  String get PROPOSAL_EXPIRED => 'PROPOSAL_EXPIRED';
  String get SESSION_SUBSCRIPTION_FAILURE => 'SESSION_SUBSCRIPTION_FAILURE';
  String get SESSION_APPROVE_PUBLISH_FAILURE =>
      'SESSION_APPROVE_PUBLISH_FAILURE';
  String get SESSION_SETTLE_PUBLISH_FAILURE => 'SESSION_SETTLE_PUBLISH_FAILURE';
  String get SESSION_APPROVE_NAMESPACE_VALIDATION_FAILURE =>
      'SESSION_APPROVE_NAMESPACE_VALIDATION_FAILURE';
  String get REQUIRED_NAMESPACE_VALIDATION_FAILURE =>
      'REQUIRED_NAMESPACE_VALIDATION_FAILURE';
  String get OPTIONAL_NAMESPACE_VALIDATION_FAILURE =>
      'OPTIONAL_NAMESPACE_VALIDATION_FAILURE';
  String get SESSION_PROPERTIES_VALIDATION_FAILURE =>
      'SESSION_PROPERTIES_VALIDATION_FAILURE';
  String get MISSING_SESSION_AUTH_REQUEST => 'MISSING_SESSION_AUTH_REQUEST';
  String get SESSION_AUTH_REQUEST_EXPIRED => 'SESSION_AUTH_REQUEST_EXPIRED';
  String get CHAINS_CAIP2_COMPLIANT_FAILURE => 'CHAINS_CAIP2_COMPLIANT_FAILURE';
  String get CHAINS_EVM_COMPLIANT_FAILURE => 'CHAINS_EVM_COMPLIANT_FAILURE';
  String get INVALID_CACAO => 'INVALID_CACAO';
  String get SUBSCRIBE_AUTH_SESSION_TOPIC_FAILURE =>
      'SUBSCRIBE_AUTH_SESSION_TOPIC_FAILURE';
  String get AUTHENTICATED_SESSION_APPROVE_PUBLISH_FAILURE =>
      'AUTHENTICATED_SESSION_APPROVE_PUBLISH_FAILURE';
  String get AUTHENTICATED_SESSION_EXPIRED => 'AUTHENTICATED_SESSION_EXPIRED';
}

class _ModalTrackOptions {
  const _ModalTrackOptions();

  // basic
  String get MODAL_CREATED => 'MODAL_CREATED';
  String get MODAL_LOADED => 'MODAL_LOADED';
  String get MODAL_OPEN => 'MODAL_OPEN';
  String get MODAL_CLOSE => 'MODAL_CLOSE';
  String get CLICK_ALL_WALLETS => 'CLICK_ALL_WALLETS';
  String get CLICK_NETWORKS => 'CLICK_NETWORKS';
  String get SWITCH_NETWORK => 'SWITCH_NETWORK';
  String get SELECT_WALLET => 'SELECT_WALLET';
  String get CONNECT_SUCCESS => 'CONNECT_SUCCESS';
  String get CONNECT_ERROR => 'CONNECT_ERROR';
  String get DISCONNECT_SUCCESS => 'DISCONNECT_SUCCESS';
  String get DISCONNECT_ERROR => 'DISCONNECT_ERROR';
  String get CLICK_WALLET_HELP => 'CLICK_WALLET_HELP';
  String get CLICK_NETWORK_HELP => 'CLICK_NETWORK_HELP';
  String get CLICK_GET_WALLET_HELP => 'CLICK_GET_WALLET_HELP';
  String get GET_WALLET => 'GET_WALLET';
  String get WALLET_IMPRESSION => 'WALLET_IMPRESSION';
  String get INITIALIZE => 'INITIALIZE';
  String get USER_REJECTED => 'USER_REJECTED';

  // email login
  String get EMAIL_LOGIN_SELECTED => 'EMAIL_LOGIN_SELECTED';
  String get EMAIL_SUBMITTED => 'EMAIL_SUBMITTED';
  String get DEVICE_REGISTERED_FOR_EMAIL => 'DEVICE_REGISTERED_FOR_EMAIL';
  String get EMAIL_VERIFICATION_CODE_SENT => 'EMAIL_VERIFICATION_CODE_SENT';
  String get EMAIL_VERIFICATION_CODE_PASS => 'EMAIL_VERIFICATION_CODE_PASS';
  String get EMAIL_VERIFICATION_CODE_FAIL => 'EMAIL_VERIFICATION_CODE_FAIL';
  String get EMAIL_EDIT => 'EMAIL_EDIT';
  String get EMAIL_EDIT_COMPLETE => 'EMAIL_EDIT_COMPLETE';
  String get EMAIL_UPGRADE_FROM_MODAL => 'EMAIL_UPGRADE_FROM_MODAL';

  // siwe
  String get CLICK_SIGN_SIWE_MESSAGE => 'CLICK_SIGN_SIWE_MESSAGE';
  String get CLICK_CANCEL_SIWE => 'CLICK_CANCEL_SIWE';
  String get SIWE_AUTH_SUCCESS => 'SIWE_AUTH_SUCCESS';
  String get SIWE_AUTH_ERROR => 'SIWE_AUTH_ERROR';

  // smart accounts
  String get SET_PREFERRED_ACCOUNT_TYPE => 'SET_PREFERRED_ACCOUNT_TYPE';

  // social
  String get SOCIAL_LOGIN_STARTED => 'SOCIAL_LOGIN_STARTED';
  String get SOCIAL_LOGIN_SUCCESS => 'SOCIAL_LOGIN_SUCCESS';
  String get SOCIAL_LOGIN_ERROR => 'SOCIAL_LOGIN_ERROR';
  String get SOCIAL_LOGIN_REQUEST_USER_DATA => 'SOCIAL_LOGIN_REQUEST_USER_DATA';
  String get SOCIAL_LOGIN_CANCELED => 'SOCIAL_LOGIN_CANCELED';

  // wallet features
  String get OPEN_SEND => 'OPEN_SEND';
  String get SEND_INITIATED => 'SEND_INITIATED';
  String get SEND_SUCCESS => 'SEND_SUCCESS';
  String get SEND_ERROR => 'SEND_ERROR';

  // final SIGN_TRANSACTION = 'SIGN_TRANSACTION';

  // Transactions History
  String get CLICK_TRANSACTIONS => 'CLICK_TRANSACTIONS';
  String get ERROR_FETCH_TRANSACTIONS => 'ERROR_FETCH_TRANSACTIONS';
  String get LOAD_MORE_TRANSACTIONS => 'LOAD_MORE_TRANSACTIONS';

  // fund from exchange
  String get PAY_EXCHANGE_SELECTED => 'PAY_EXCHANGE_SELECTED';
}
