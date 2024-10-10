enum AnalyticsPlatform {
  mobile,
  web,
  qrcode,
  email,
  unsupported,
}

abstract class AnalyticsEvent {
  abstract final String type;
  abstract final String event;
  abstract final Map<String, dynamic>? properties;

  Map<String, dynamic> toMap();
}

class ModalCreatedEvent implements AnalyticsEvent {
  @override
  String get type => 'track';

  @override
  String get event => 'MODAL_CREATED';

  @override
  Map<String, dynamic>? get properties => null;

  @override
  Map<String, dynamic> toMap() => {
        'type': type,
        'event': event,
        if (properties != null) 'properties': properties,
      };
}

class ModalLoadedEvent implements AnalyticsEvent {
  @override
  String get type => 'track';

  @override
  String get event => 'MODAL_LOADED';

  @override
  Map<String, dynamic>? get properties => null;

  @override
  Map<String, dynamic> toMap() => {
        'type': type,
        'event': event,
        if (properties != null) 'properties': properties,
      };
}

class ModalOpenEvent implements AnalyticsEvent {
  final bool _connected;
  ModalOpenEvent({
    required bool connected,
  }) : _connected = connected;

  @override
  String get type => 'track';

  @override
  String get event => 'MODAL_OPEN';

  @override
  Map<String, dynamic>? get properties => {
        'connected': _connected,
      };

  @override
  Map<String, dynamic> toMap() => {
        'type': type,
        'event': event,
        if (properties != null) 'properties': properties,
      };
}

class ModalCloseEvent implements AnalyticsEvent {
  final bool _connected;
  ModalCloseEvent({
    required bool connected,
  }) : _connected = connected;

  @override
  String get type => 'track';

  @override
  String get event => 'MODAL_CLOSE';

  @override
  Map<String, dynamic>? get properties => {
        'connected': _connected,
      };

  @override
  Map<String, dynamic> toMap() => {
        'type': type,
        'event': event,
        if (properties != null) 'properties': properties,
      };
}

class ClickAllWalletsEvent implements AnalyticsEvent {
  @override
  String get type => 'track';

  @override
  String get event => 'CLICK_ALL_WALLETS';

  @override
  Map<String, dynamic>? get properties => null;

  @override
  Map<String, dynamic> toMap() => {
        'type': type,
        'event': event,
        if (properties != null) 'properties': properties,
      };
}

class ClickNetworksEvent implements AnalyticsEvent {
  @override
  String get type => 'track';

  @override
  String get event => 'CLICK_NETWORKS';

  @override
  Map<String, dynamic>? get properties => null;

  @override
  Map<String, dynamic> toMap() => {
        'type': type,
        'event': event,
        if (properties != null) 'properties': properties,
      };
}

class SwitchNetworkEvent implements AnalyticsEvent {
  final String _network;
  SwitchNetworkEvent({
    required String network,
  }) : _network = network;

  @override
  String get type => 'track';

  @override
  String get event => 'SWITCH_NETWORK';

  @override
  Map<String, dynamic>? get properties => {
        'network': _network,
      };

  @override
  Map<String, dynamic> toMap() => {
        'type': type,
        'event': event,
        if (properties != null) 'properties': properties,
      };
}

class SelectWalletEvent implements AnalyticsEvent {
  final String _name;
  final String? _platform;
  SelectWalletEvent({
    required String name,
    AnalyticsPlatform? platform,
  })  : _name = name,
        _platform = platform?.name;

  @override
  String get type => 'track';

  @override
  String get event => 'SELECT_WALLET';

  @override
  Map<String, dynamic>? get properties => {
        'name': _name,
        if (_platform != null) 'platform': _platform,
      };

  @override
  Map<String, dynamic> toMap() => {
        'type': type,
        'event': event,
        if (properties != null) 'properties': properties,
      };
}

class ConnectSuccessEvent implements AnalyticsEvent {
  final String _name;
  final String? _method;
  ConnectSuccessEvent({
    required String name,
    AnalyticsPlatform? method,
  })  : _name = name,
        _method = method?.name;

  @override
  String get type => 'track';

  @override
  String get event => 'CONNECT_SUCCESS';

  @override
  Map<String, dynamic>? get properties => {
        'name': _name,
        if (_method != null) 'method': _method,
      };

  @override
  Map<String, dynamic> toMap() => {
        'type': type,
        'event': event,
        if (properties != null) 'properties': properties,
      };
}

class ConnectErrorEvent implements AnalyticsEvent {
  final String _message;
  ConnectErrorEvent({
    required String message,
  }) : _message = message;

  @override
  String get type => 'track';

  @override
  String get event => 'CONNECT_ERROR';

  @override
  Map<String, dynamic>? get properties => {
        'message': _message,
      };

  @override
  Map<String, dynamic> toMap() => {
        'type': type,
        'event': event,
        if (properties != null) 'properties': properties,
      };
}

class DisconnectSuccessEvent implements AnalyticsEvent {
  @override
  String get type => 'track';

  @override
  String get event => 'DISCONNECT_SUCCESS';

  @override
  Map<String, dynamic>? get properties => null;

  @override
  Map<String, dynamic> toMap() => {
        'type': type,
        'event': event,
        if (properties != null) 'properties': properties,
      };
}

class DisconnectErrorEvent implements AnalyticsEvent {
  @override
  String get type => 'track';

  @override
  String get event => 'DISCONNECT_ERROR';

  @override
  Map<String, dynamic>? get properties => null;

  @override
  Map<String, dynamic> toMap() => {
        'type': type,
        'event': event,
        if (properties != null) 'properties': properties,
      };
}

class ClickWalletHelpEvent implements AnalyticsEvent {
  @override
  String get type => 'track';

  @override
  String get event => 'CLICK_WALLET_HELP';

  @override
  Map<String, dynamic>? get properties => null;

  @override
  Map<String, dynamic> toMap() => {
        'type': type,
        'event': event,
        if (properties != null) 'properties': properties,
      };
}

class ClickNetworkHelpEvent implements AnalyticsEvent {
  @override
  String get type => 'track';

  @override
  String get event => 'CLICK_NETWORK_HELP';

  @override
  Map<String, dynamic>? get properties => null;

  @override
  Map<String, dynamic> toMap() => {
        'type': type,
        'event': event,
        if (properties != null) 'properties': properties,
      };
}

class ClickGetWalletEvent implements AnalyticsEvent {
  @override
  String get type => 'track';

  @override
  String get event => 'CLICK_GET_WALLET';

  @override
  Map<String, dynamic>? get properties => null;

  @override
  Map<String, dynamic> toMap() => {
        'type': type,
        'event': event,
        if (properties != null) 'properties': properties,
      };
}

class EmailLoginSelected implements AnalyticsEvent {
  @override
  String get type => 'track';

  @override
  String get event => 'EMAIL_LOGIN_SELECTED';

  @override
  Map<String, dynamic>? get properties => null;

  @override
  Map<String, dynamic> toMap() => {
        'type': type,
        'event': event,
        if (properties != null) 'properties': properties,
      };
}

class EmailSubmitted implements AnalyticsEvent {
  @override
  String get type => 'track';

  @override
  String get event => 'EMAIL_SUBMITTED';

  @override
  Map<String, dynamic>? get properties => null;

  @override
  Map<String, dynamic> toMap() => {
        'type': type,
        'event': event,
        if (properties != null) 'properties': properties,
      };
}

class DeviceRegisteredForEmail implements AnalyticsEvent {
  @override
  String get type => 'track';

  @override
  String get event => 'DEVICE_REGISTERED_FOR_EMAIL';

  @override
  Map<String, dynamic>? get properties => null;

  @override
  Map<String, dynamic> toMap() => {
        'type': type,
        'event': event,
        if (properties != null) 'properties': properties,
      };
}

class EmailVerificationCodeSent implements AnalyticsEvent {
  @override
  String get type => 'track';

  @override
  String get event => 'EMAIL_VERIFICATION_CODE_SENT';

  @override
  Map<String, dynamic>? get properties => null;

  @override
  Map<String, dynamic> toMap() => {
        'type': type,
        'event': event,
        if (properties != null) 'properties': properties,
      };
}

class EmailVerificationCodePass implements AnalyticsEvent {
  @override
  String get type => 'track';

  @override
  String get event => 'EMAIL_VERIFICATION_CODE_PASS';

  @override
  Map<String, dynamic>? get properties => null;

  @override
  Map<String, dynamic> toMap() => {
        'type': type,
        'event': event,
        if (properties != null) 'properties': properties,
      };
}

class EmailVerificationCodeFail implements AnalyticsEvent {
  @override
  String get type => 'track';

  @override
  String get event => 'EMAIL_VERIFICATION_CODE_FAIL';

  @override
  Map<String, dynamic>? get properties => null;

  @override
  Map<String, dynamic> toMap() => {
        'type': type,
        'event': event,
        if (properties != null) 'properties': properties,
      };
}

class EmailEdit implements AnalyticsEvent {
  @override
  String get type => 'track';

  @override
  String get event => 'EMAIL_EDIT';

  @override
  Map<String, dynamic>? get properties => null;

  @override
  Map<String, dynamic> toMap() => {
        'type': type,
        'event': event,
        if (properties != null) 'properties': properties,
      };
}

class EmailEditComplete implements AnalyticsEvent {
  @override
  String get type => 'track';

  @override
  String get event => 'EMAIL_EDIT_COMPLETE';

  @override
  Map<String, dynamic>? get properties => null;

  @override
  Map<String, dynamic> toMap() => {
        'type': type,
        'event': event,
        if (properties != null) 'properties': properties,
      };
}

class EmailUpgradeFromModal implements AnalyticsEvent {
  @override
  String get type => 'track';

  @override
  String get event => 'EMAIL_UPGRADE_FROM_MODAL';

  @override
  Map<String, dynamic>? get properties => null;

  @override
  Map<String, dynamic> toMap() => {
        'type': type,
        'event': event,
        if (properties != null) 'properties': properties,
      };
}

class ClickSignSiweMessage implements AnalyticsEvent {
  final String _network;
  ClickSignSiweMessage({required String network}) : _network = network;

  @override
  String get type => 'track';

  @override
  String get event => 'CLICK_SIGN_SIWE_MESSAGE';

  @override
  Map<String, dynamic>? get properties => {
        'network': _network,
      };

  @override
  Map<String, dynamic> toMap() => {
        'type': type,
        'event': event,
        if (properties != null) 'properties': properties,
      };
}

class ClickCancelSiwe implements AnalyticsEvent {
  final String _network;
  ClickCancelSiwe({required String network}) : _network = network;

  @override
  String get type => 'track';

  @override
  String get event => 'CLICK_CANCEL_SIWE';

  @override
  Map<String, dynamic>? get properties => {
        'network': _network,
      };

  @override
  Map<String, dynamic> toMap() => {
        'type': type,
        'event': event,
        if (properties != null) 'properties': properties,
      };
}

class SiweAuthSuccess implements AnalyticsEvent {
  final String _network;
  SiweAuthSuccess({required String network}) : _network = network;

  @override
  String get type => 'track';

  @override
  String get event => 'SIWE_AUTH_SUCCESS';

  @override
  Map<String, dynamic>? get properties => {
        'network': _network,
      };

  @override
  Map<String, dynamic> toMap() => {
        'type': type,
        'event': event,
        if (properties != null) 'properties': properties,
      };
}

class SiweAuthError implements AnalyticsEvent {
  final String _network;
  SiweAuthError({required String network}) : _network = network;

  @override
  String get type => 'track';

  @override
  String get event => 'SIWE_AUTH_ERROR';

  @override
  Map<String, dynamic>? get properties => {
        'network': _network,
      };

  @override
  Map<String, dynamic> toMap() => {
        'type': type,
        'event': event,
        if (properties != null) 'properties': properties,
      };
}

class SocialLoginStarted implements AnalyticsEvent {
  final String _provider;
  SocialLoginStarted({required String provider}) : _provider = provider;

  @override
  String get type => 'track';

  @override
  String get event => 'LOGIN_STARTED';

  @override
  Map<String, dynamic>? get properties => {
        'provider': _provider,
      };

  @override
  Map<String, dynamic> toMap() => {
        'type': type,
        'event': event,
        if (properties != null) 'properties': properties,
      };
}

class SocialLoginSuccess implements AnalyticsEvent {
  final String _provider;
  SocialLoginSuccess({required String provider}) : _provider = provider;

  @override
  String get type => 'track';

  @override
  String get event => 'LOGIN_SUCCESS';

  @override
  Map<String, dynamic>? get properties => {
        'provider': _provider,
      };

  @override
  Map<String, dynamic> toMap() => {
        'type': type,
        'event': event,
        if (properties != null) 'properties': properties,
      };
}

class SocialLoginError implements AnalyticsEvent {
  final String _provider;
  SocialLoginError({required String provider}) : _provider = provider;

  @override
  String get type => 'track';

  @override
  String get event => 'LOGIN_ERROR';

  @override
  Map<String, dynamic>? get properties => {
        'provider': _provider,
      };

  @override
  Map<String, dynamic> toMap() => {
        'type': type,
        'event': event,
        if (properties != null) 'properties': properties,
      };
}
