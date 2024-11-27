import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_appkit/modal/services/analytics_service/i_analytics_service.dart';
import 'package:reown_appkit/modal/utils/core_utils.dart';

import 'package:reown_appkit/reown_appkit.dart';
import 'package:reown_appkit/modal/constants/string_constants.dart';
import 'package:reown_appkit/modal/services/analytics_service/models/analytics_event.dart';
import 'package:reown_appkit/modal/services/magic_service/models/email_login_step.dart';
import 'package:reown_appkit/modal/services/magic_service/i_magic_service.dart';
import 'package:reown_appkit/modal/services/magic_service/models/magic_data.dart';
import 'package:reown_appkit/modal/services/magic_service/models/magic_events.dart';
import 'package:reown_appkit/modal/services/magic_service/models/frame_message.dart';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

class MagicService implements IMagicService {
  static const _thirdPartySafeDomains = [
    'auth.magic.link',
    'launchdarkly.com',
  ];

  ConnectionMetadata get _selfMetadata => ConnectionMetadata(
        metadata: _metadata,
        publicKey: '',
      );

  // TODO export this
  ConnectionMetadata get _peerMetadata => ConnectionMetadata(
        metadata: PairingMetadata(
          name: _socialProvider != null
              ? '$_socialProvider Wallet'
              : 'Email Wallet',
          description: '',
          url: '',
          icons: [''],
        ),
        publicKey: '',
      );

  //
  Timer? _timeOutTimer;
  String? _connectionChainId;
  int _onLoadCount = 0;
  String _packageName = '';
  AppKitSocialOption? _socialProvider;
  String? _socialUsername;
  ReownAppKitModalTheme? _appTheme;

  late final IReownCore _core;
  late final PairingMetadata _metadata;
  late final FeaturesConfig _features;
  late final WebViewController _webViewController;
  late final WebViewWidget _webview;

  @override
  Map<String, List<String>> get supportedMethods => {
        NetworkUtils.eip155: [
          'personal_sign',
          'eth_sendTransaction',
          'eth_accounts',
          'eth_sendRawTransaction',
          'eth_signTypedData_v4',
        ],
        NetworkUtils.solana:
            NetworkUtils.defaultNetworkMethods[NetworkUtils.solana]!,
      };

  @override
  WebViewWidget get webview => _webview;
  @override
  final isReady = ValueNotifier(false);
  @override
  final isConnected = ValueNotifier(false);
  @override
  final isTimeout = ValueNotifier(false);
  @override
  final isEmailEnabled = ValueNotifier(false);
  @override
  final isSocialEnabled = ValueNotifier(false);
  @override
  final email = ValueNotifier<String>('');
  @override
  final newEmail = ValueNotifier<String>('');
  @override
  final step = ValueNotifier<EmailLoginStep>(EmailLoginStep.idle);

  @override
  List<AppKitSocialOption> get socials => _features.socials;

  @override
  Event<MagicSessionEvent> onMagicLoginRequest = Event<MagicSessionEvent>();

  @override
  Event<MagicLoginEvent> onMagicLoginSuccess = Event<MagicLoginEvent>();

  @override
  Event<MagicConnectEvent> onMagicConnect = Event<MagicConnectEvent>();

  @override
  Event<MagicErrorEvent> onMagicError = Event<MagicErrorEvent>();

  @override
  Event<MagicSessionEvent> onMagicUpdate = Event<MagicSessionEvent>();

  @override
  Event<MagicRequestEvent> onMagicRpcRequest = Event<MagicRequestEvent>();

  @override
  Event<CompleteSocialLoginEvent> onCompleteSocialLogin =
      Event<CompleteSocialLoginEvent>();

  IAnalyticsService get _analyticsService => GetIt.I<IAnalyticsService>();

  MagicService({
    required IReownCore core,
    required PairingMetadata metadata,
    required FeaturesConfig featuresConfig,
  })  : _core = core,
        _metadata = metadata,
        _features = featuresConfig {
    isEmailEnabled.value = _features.email;
    isSocialEnabled.value = _features.socials.isNotEmpty;
    //
    if (isEmailEnabled.value || isSocialEnabled.value) {
      _webViewController = WebViewController();
      _webview = WebViewWidget(controller: _webViewController);
      isReady.addListener(_readyListener);
    }
  }

  final _awaitReadyness = Completer<bool>();
  void _readyListener() {
    if (isReady.value && !_awaitReadyness.isCompleted) {
      _awaitReadyness.complete(true);
    }
  }

  Completer<bool> _initializedCompleter = Completer<bool>();
  @override
  Future<void> init({String? chainId}) async {
    _connectionChainId = chainId;
    _initializedCompleter = Completer<bool>();
    _isConnectedCompleter = Completer<bool>();
    if (!isEmailEnabled.value && !isSocialEnabled.value) {
      _initializedCompleter.complete(false);
      _isConnectedCompleter.complete(false);
      return;
    }
    _packageName = await ReownCoreUtils.getPackageName();
    await _init();
    await _isConnected();
    await _syncAppData();
    isReady.value = true;
    await syncTheme(_appTheme);
  }

  Future<bool> _init() async {
    await _webViewController.setBackgroundColor(Colors.transparent);
    await _webViewController.setJavaScriptMode(JavaScriptMode.unrestricted);
    await _webViewController.enableZoom(false);
    await _webViewController.addJavaScriptChannel(
      'w3mWebview',
      onMessageReceived: _onFrameMessage,
    );
    await _webViewController.setNavigationDelegate(
      NavigationDelegate(
        onNavigationRequest: (NavigationRequest request) async {
          try {
            final uri = Uri.parse(request.url);
            if (uri.host.isEmpty || uri.authority.isEmpty) {
              return NavigationDecision.prevent;
            }
            if (_isAllowedDomain(uri.toString())) {
              await _fitToScreen();
              return NavigationDecision.navigate;
            }
            if (isReady.value) {
              ReownCoreUtils.openURL(uri.toString());
              return NavigationDecision.prevent;
            }
          } catch (_) {}
          return NavigationDecision.prevent;
        },
        onWebResourceError: _onWebResourceError,
        onPageFinished: (String url) async {
          _onLoadCount++;
          // If bundleId/packageName is whitelisted in cloud then for some reason it enters here twice
          // Like as if secure-mobile.walletconnect.com is loaded twice
          // If bundleId/packageName is NOT whitelisted in cloud then it enter just once.
          // This is happening only on Android devices, on iOS only once execution is done no matter what.
          if (_onLoadCount < 2 && Platform.isAndroid) return;
          await _runJavascript();
          await _fitToScreen();
          Future.delayed(Duration(milliseconds: 600)).then((value) {
            if (_initializedCompleter.isCompleted) return;
            _initializedCompleter.complete(true);
          });
        },
      ),
    );
    await _setDebugMode();
    await _loadRequest();
    return await _initializedCompleter.future;
  }

  Completer<bool> _isConnectedCompleter = Completer<bool>();
  Future<bool> _isConnected() async {
    _isConnectedCompleter = Completer<bool>();
    final message = IsConnected().toString();
    await _webViewController.runJavaScript('sendMessage($message)');
    return await _isConnectedCompleter.future;
  }

  Completer<bool> _syncAppDataCompleter = Completer<bool>();
  Future<bool> _syncAppData() async {
    _syncAppDataCompleter = Completer<bool>();
    final message = SyncAppData(
      metadata: _metadata,
      projectId: _core.projectId,
      sdkVersion: CoreUtils.getUserAgent(),
    ).toString();
    await _webViewController.runJavaScript('sendMessage($message)');
    return await _syncAppDataCompleter.future;
  }

  @override
  void setEmail(String value) {
    email.value = value;
  }

  @override
  void setNewEmail(String value) {
    newEmail.value = value;
  }

  @override
  void setProvider(AppKitSocialOption? provider) {
    _socialProvider = provider;
  }

  bool get _socialsNotReady => (!isSocialEnabled.value || !isReady.value);
  bool get _emailNotReady => (!isEmailEnabled.value || !isReady.value);
  bool get _serviceNotReady =>
      (!isEmailEnabled.value && !isSocialEnabled.value) || !isReady.value;

  // ****** W3mFrameProvider public methods ******* //

  // SOCIAL LOGIN RELATED METHODS

  Completer<String?> _getSocialRedirectUri = Completer<String?>();
  @override
  Future<String?> getSocialRedirectUri({
    required AppKitSocialOption provider,
    String? schema,
    String? chainId,
  }) async {
    if (_socialsNotReady) {
      throw Exception('Service is not ready');
    }
    //
    _getSocialRedirectUri = Completer<String?>();
    _connectionChainId = chainId ?? _connectionChainId;
    _socialProvider = provider;
    final message = GetSocialRedirectUri(
      provider: _socialProvider!.name.toLowerCase(),
      schema: schema,
    ).toString();
    await _webViewController.runJavaScript('sendMessage($message)');
    return await _getSocialRedirectUri.future;
  }

  Completer<bool> _connectSocial = Completer<bool>();
  @override
  Future<dynamic> connectSocial({required String uri}) async {
    if (_socialsNotReady) {
      throw Exception('Service is not ready');
    }
    //
    _connectSocial = Completer<bool>();
    final message = ConnectSocial(uri: uri).toString();
    await _webViewController.runJavaScript('sendMessage($message)');
    return await _connectSocial.future;
  }

  @override
  void completeSocialLogin({required String url}) {
    onCompleteSocialLogin.broadcast(CompleteSocialLoginEvent(url));
  }

  Completer<String?> _getFarcasterUri = Completer<String?>();
  @override
  Future<String?> getFarcasterUri({String? chainId}) async {
    if (_socialsNotReady) {
      throw Exception('Service is not ready');
    }
    if (_getFarcasterUri.isCompleted) {
      return await _getFarcasterUri.future;
    }
    //
    _getFarcasterUri = Completer<String?>();
    _connectionChainId = chainId ?? _connectionChainId;
    _socialProvider = AppKitSocialOption.Farcaster;
    final message = GetFarcasterUri().toString();
    await _webViewController.runJavaScript('sendMessage($message)');
    return await _getFarcasterUri.future;
  }

  Completer<bool> _connectFarcaster = Completer<bool>();
  @override
  Future<bool> awaitFarcasterResponse() async {
    if (_socialsNotReady) {
      throw Exception('Service is not ready');
    }
    //
    _connectFarcaster = Completer<bool>();
    // final message = ConnectFarcaster().toString();
    // await _webViewController.runJavaScript('sendMessage($message)');
    return await _connectFarcaster.future;
  }

  // EMAIL RELATED METHODS

  @override
  Future<void> connectEmail({required String value, String? chainId}) async {
    if (_emailNotReady) {
      throw Exception('Service is not ready');
    }
    //
    _socialProvider = null;
    _connectionChainId = chainId ?? _connectionChainId;
    final message = ConnectEmail(email: value).toString();
    await _webViewController.runJavaScript('sendMessage($message)');
  }

  @override
  Future<void> updateEmail({required String value}) async {
    if (_emailNotReady) {
      throw Exception('Service is not ready');
    }
    //
    step.value = EmailLoginStep.loading;
    final message = UpdateEmail(email: value).toString();
    await _webViewController.runJavaScript('sendMessage($message)');
  }

  @override
  Future<void> updateEmailPrimaryOtp({required String otp}) async {
    if (_emailNotReady) {
      throw Exception('Service is not ready');
    }
    //
    step.value = EmailLoginStep.loading;
    final message = UpdateEmailPrimaryOtp(otp: otp).toString();
    await _webViewController.runJavaScript('sendMessage($message)');
  }

  @override
  Future<void> updateEmailSecondaryOtp({required String otp}) async {
    if (_emailNotReady) {
      throw Exception('Service is not ready');
    }
    //
    step.value = EmailLoginStep.loading;
    final message = UpdateEmailSecondaryOtp(otp: otp).toString();
    await _webViewController.runJavaScript('sendMessage($message)');
  }

  @override
  Future<void> connectOtp({required String otp}) async {
    if (_emailNotReady) {
      throw Exception('Service is not ready');
    }
    //
    step.value = EmailLoginStep.loading;
    final message = ConnectOtp(otp: otp).toString();
    await _webViewController.runJavaScript('sendMessage($message)');
  }

  @override
  Future<void> syncTheme(ReownAppKitModalTheme? theme) async {
    _appTheme = theme;
    if (_serviceNotReady || _appTheme == null) return;
    //
    final message = SyncTheme(theme: _appTheme).toString();
    await _webViewController.runJavaScript('sendMessage($message)');
  }

  Completer<String?> _getChainIdCompleter = Completer<String?>();
  @override
  Future<String?> getChainId() async {
    if (_serviceNotReady) {
      throw Exception('Service is not ready');
    }
    //
    _getChainIdCompleter = Completer<String?>();
    final message = GetChainId().toString();
    await _webViewController.runJavaScript('sendMessage($message)');
    return await _getChainIdCompleter.future;
  }

  Completer<bool> _getUserCompleter = Completer<bool>();
  bool _isUpdateUser = false;
  @override
  Future<bool> getUser({
    required String? chainId,
    required bool isUpdate,
  }) async {
    if (_serviceNotReady) {
      throw Exception('Service is not ready');
    }
    //
    await _getUser(chainId, isUpdate);
    return await _getUserCompleter.future;
  }

  Future<void> _getUser(String? chainId, bool isUpdate) async {
    _isUpdateUser = isUpdate;
    _getUserCompleter = Completer<bool>();
    String? cid = chainId ?? _connectionChainId;
    if (cid != null && !NamespaceUtils.isValidChainId(cid)) {
      try {
        cid = ReownAppKitModalNetworks.getCaip2Chain(cid);
      } catch (_) {
        cid = null;
      }
    }
    final message = GetUser(chainId: cid).toString();
    return await _webViewController.runJavaScript('sendMessage($message)');
  }

  Completer<bool> _switchNetworkCompleter = Completer<bool>();
  @override
  Future<bool> switchNetwork({required String chainId}) async {
    if (_serviceNotReady) {
      throw Exception('Service is not ready');
    }
    //
    await _awaitReadyness.future;
    _switchNetworkCompleter = Completer<bool>();
    await _switchNetwork(chainId);
    return await _switchNetworkCompleter.future;
  }

  Future<void> _switchNetwork(String chainId) async {
    if (!isConnected.value) {
      _isConnectedCompleter = Completer<bool>();
      if (_socialProvider != null) {
        onMagicLoginRequest.broadcast(MagicSessionEvent(
          provider: _socialProvider,
        ));
      } else {
        onMagicLoginRequest.broadcast(MagicSessionEvent(
          email: email.value,
        ));
        await connectEmail(value: email.value);
      }
      final success = await _isConnectedCompleter.future;
      if (!success) return;
    }
    final message = SwitchNetwork(chainId: chainId).toString();
    await _webViewController.runJavaScript('sendMessage($message)');
  }

  Completer<dynamic> _requestCompleter = Completer<dynamic>();
  @override
  Future<dynamic> request({
    String? chainId,
    required SessionRequestParams request,
  }) async {
    if (_serviceNotReady) {
      throw Exception('Service is not ready');
    }
    //
    await _awaitReadyness.future;
    _requestCompleter = Completer<dynamic>();
    // if (chainId != _connectionChainId && chainId != null) {
    //   await switchNetwork(chainId: chainId);
    // }
    await _rpcRequest(request.toJson());
    return await _requestCompleter.future;
  }

  Future<void> _rpcRequest(Map<String, dynamic> parameters) async {
    if (!isConnected.value) {
      _isConnectedCompleter = Completer<bool>();
      if (_socialProvider != null) {
        onMagicLoginRequest.broadcast(MagicSessionEvent(
          provider: _socialProvider,
        ));
      } else {
        onMagicLoginRequest.broadcast(MagicSessionEvent(
          email: email.value,
        ));
        await connectEmail(value: email.value);
      }
      final success = await _isConnectedCompleter.future;
      if (!success) return;
    }
    onMagicRpcRequest.broadcast(MagicRequestEvent(request: parameters));
    final method = parameters['method'];
    final params = parameters['params'];
    final message = RpcRequest(method: method, params: params).toString();
    await _webViewController.runJavaScript('sendMessage($message)');
  }

  Completer<bool> _disconnectCompleter = Completer<bool>();
  @override
  Future<bool> disconnect() async {
    if (_serviceNotReady) {
      throw Exception('Service is not ready');
    }
    //
    _disconnectCompleter = Completer<bool>();
    if (!isConnected.value) {
      _resetTimeOut();
      _disconnectCompleter.complete(true);
      return await _disconnectCompleter.future;
    }
    final message = SignOut().toString();
    await _webViewController.runJavaScript('sendMessage($message)');
    return await _disconnectCompleter.future;
  }

  // ****** Private Methods ******* //

  Future<void> _loadRequest() async {
    try {
      final headers = {
        // secure-site's middleware requires a referer otherwise it throws `400: Missing projectId or referer`
        'referer': _metadata.url,
        'x-bundle-id': _packageName,
      };
      final uri = Uri.parse(UrlConstants.secureService);
      final cid = (_connectionChainId ?? '');
      final queryParams = {
        'projectId': _core.projectId,
        if (cid.isNotEmpty) 'chainId': cid,
      };
      final requestUri = uri.replace(queryParameters: queryParams);
      await _webViewController.loadRequest(requestUri, headers: headers);
      // in case connection message or even the request itself hangs there's no other way to continue the flow than timing it out.
      _timeOutTimer ??= Timer.periodic(Duration(seconds: 1), _timeOut);
    } catch (e) {
      _initializedCompleter.complete(false);
    }
  }

  void _onFrameMessage(JavaScriptMessage jsMessage) async {
    if (Platform.isAndroid) {
      _core.logger.d('[$runtimeType] JS Console: ${jsMessage.message}');
    }
    try {
      final frameMessage = jsMessage.toFrameMessage();
      if (!frameMessage.isValidOrigin || !frameMessage.isValidData) {
        return;
      }
      _core.logger.d('[$runtimeType] ${frameMessage.data!.toRawJson()}');
      _successMessageHandler(frameMessage.data!); // await?
      _errorMessageHandler(frameMessage.data!);
    } catch (e, s) {
      _core.logger.e('[$runtimeType] $jsMessage $e', stackTrace: s);
    }
  }

  Future<void> _successMessageHandler(MessageData messageData) async {
    // ******* SYNC_DAPP_DATA_SUCCESS
    if (messageData.syncDataSuccess) {
      _resetTimeOut();
      _syncAppDataCompleter.complete(true);
    }
    // ****** IS_CONNECTED_SUCCESS
    if (messageData.isConnectSuccess) {
      _resetTimeOut();
      isConnected.value = messageData.getPayloadMapKey<bool>('isConnected');
      if (!_isConnectedCompleter.isCompleted) {
        _isConnectedCompleter.complete(isConnected.value);
      }
      onMagicConnect.broadcast(MagicConnectEvent(isConnected.value));
      if (isConnected.value) {
        await _getUser(_connectionChainId, false);
      }
    }
    if (messageData.getSocialRedirectUriSuccess) {
      final uri = messageData.getPayloadMapKey<String>('uri');
      _getSocialRedirectUri.complete(uri);
    }
    // ****** CONNECT_SOCIAL_SUCCESS
    if (messageData.connectSocialSuccess) {
      final username = messageData.getPayloadMapKey<String?>('userName');
      final email = messageData.getPayloadMapKey<String?>('email');
      _socialUsername = username ?? email;
      _connectSocial.complete(true);
    }
    // ****** GET_FARCASTER_URI_SUCCESS
    if (messageData.getFarcasterUriSuccess) {
      final url = messageData.getPayloadMapKey<String>('url');
      _getFarcasterUri.complete(url);
    }
    // ****** CONNECT_FARCASTER_SUCCESS
    if (messageData.connectFarcasterSuccess) {
      final username = messageData.getPayloadMapKey<String?>('userName');
      final email = messageData.getPayloadMapKey<String?>('email');
      _socialUsername = username ?? email;
      _connectFarcaster.complete(true);
    }
    // ****** CONNECT_EMAIL
    if (messageData.connectEmailSuccess) {
      if (step.value != EmailLoginStep.loading) {
        final action = messageData.getPayloadMapKey<String>('action');
        final value = action.toString().toUpperCase();
        final newStep = EmailLoginStep.fromAction(value);
        if (newStep == EmailLoginStep.verifyOtp) {
          if (step.value == EmailLoginStep.verifyDevice) {
            _analyticsService.sendEvent(DeviceRegisteredForEmail());
          }
          _analyticsService.sendEvent(EmailVerificationCodeSent());
        }
        step.value = newStep;
      }
    }
    // ****** CONNECT_OTP
    if (messageData.connectOtpSuccess) {
      _analyticsService.sendEvent(EmailVerificationCodePass());
      step.value = EmailLoginStep.idle;
      await _getUser(_connectionChainId, false);
    }
    // ****** UPDAET_EMAIL
    if (messageData.updateEmailSuccess) {
      final action = messageData.getPayloadMapKey<String>('action');
      if (action == 'VERIFY_SECONDARY_OTP') {
        step.value = EmailLoginStep.verifyOtp2;
      } else {
        step.value = EmailLoginStep.verifyOtp;
      }
      _analyticsService.sendEvent(EmailEdit());
    }
    // ****** UPDATE_EMAIL_PRIMARY_OTP
    if (messageData.updateEmailPrimarySuccess) {
      step.value = EmailLoginStep.verifyOtp2;
    }
    // ****** UPDATE_EMAIL_SECONDARY_OTP
    if (messageData.updateEmailSecondarySuccess) {
      _analyticsService.sendEvent(EmailEditComplete());
      step.value = EmailLoginStep.idle;
      setEmail(newEmail.value);
      setNewEmail('');
      await _getUser(_connectionChainId, true);
    }
    // ****** SWITCH_NETWORK_SUCCESS
    if (messageData.switchNetworkSuccess) {
      final chainId = messageData.getPayloadMapKey<dynamic>('chainId');
      if (chainId is String && chainId.contains(':')) {
        final cid = chainId.split(':').last;
        onMagicUpdate.broadcast(MagicSessionEvent(chainId: cid.toString()));
        _connectionChainId = cid.toString();
      } else {
        onMagicUpdate.broadcast(MagicSessionEvent(
          chainId: chainId?.toString(),
        ));
        _connectionChainId = chainId?.toString();
      }
      _switchNetworkCompleter.complete(true);
    }
    // ****** GET_CHAIN_ID
    if (messageData.getChainIdSuccess) {
      final chainId = messageData.getPayloadMapKey<dynamic>('chainId');
      if (chainId is String && chainId.contains(':')) {
        final cid = chainId.split(':').last;
        _connectionChainId = cid.toString();
      } else {
        _connectionChainId = chainId?.toString();
      }
      _getChainIdCompleter.complete(_connectionChainId);
    }
    // ****** RPC_REQUEST_SUCCESS
    if (messageData.rpcRequestSuccess) {
      final hash = messageData.payload;
      _requestCompleter.complete(hash);
      onMagicRpcRequest.broadcast(
        MagicRequestEvent(
          request: null,
          result: hash,
          success: true,
        ),
      );
    }
    // ****** GET_USER_SUCCESS
    if (messageData.getUserSuccess) {
      isConnected.value = true;
      final magicData = MagicData.fromJson(messageData.payload!).copytWith(
        userName: _socialUsername,
      );
      if (!_isConnectedCompleter.isCompleted) {
        final event = MagicSessionEvent(
          email: magicData.email,
          userName: magicData.userName,
          address: magicData.address,
          chainId: magicData.chainId,
          provider: magicData.provider,
        );
        onMagicUpdate.broadcast(event);
        _isConnectedCompleter.complete(isConnected.value);
      } else if (_isUpdateUser) {
        final event = MagicSessionEvent(
          email: magicData.email,
          userName: magicData.userName,
          address: magicData.address,
          chainId: magicData.chainId,
          provider: magicData.provider,
        );
        onMagicUpdate.broadcast(event);
      } else {
        final session = magicData.copytWith(
          peer: _peerMetadata.copyWith(
            metadata: _peerMetadata.metadata.copyWith(
              name: _socialProvider?.name ?? 'Email Wallet',
            ),
          ),
          self: _selfMetadata,
          provider: _socialProvider,
        );
        onMagicLoginSuccess.broadcast(MagicLoginEvent(session));
      }
      // TODO this try/catch is a temporary workaround
      try {
        _getUserCompleter.complete(true);
      } catch (_) {}
    }
    // ****** SIGN_OUT_SUCCESS
    if (messageData.signOutSuccess) {
      _socialUsername = null;
      _resetTimeOut();
      _disconnectCompleter.complete(true);
    }
  }

  void _errorMessageHandler(MessageData messageData) {
    if (messageData.syncDataError) {
      _resetTimeOut();
      _syncAppDataCompleter.complete(false);
    }
    if (messageData.isConnectError) {
      _error(IsConnectedErrorEvent());
    }
    if (messageData.connectEmailError) {
      String? message = messageData.getPayloadMapKey<String?>('message');
      if (message?.toLowerCase() == 'invalid params') {
        message = 'Wrong email format';
      }
      _error(ConnectEmailErrorEvent(message: message));
    }
    if (messageData.updateEmailError) {
      final message = messageData.getPayloadMapKey<String?>('message');
      _error(UpdateEmailErrorEvent(message: message));
    }
    if (messageData.updateEmailPrimaryOtpError) {
      final message = messageData.getPayloadMapKey<String?>('message');
      _error(UpdateEmailPrimaryOtpErrorEvent(message: message));
    }
    if (messageData.updateEmailSecondaryOtpError) {
      final message = messageData.getPayloadMapKey<String?>('message');
      _error(UpdateEmailSecondaryOtpErrorEvent(message: message));
    }
    if (messageData.connectOtpError) {
      _analyticsService.sendEvent(EmailVerificationCodeFail());
      final message = messageData.getPayloadMapKey<String?>('message');
      _error(ConnectOtpErrorEvent(message: message));
    }
    if (messageData.getSocialRedirectUriError) {
      String? message = messageData.getPayloadMapKey<String?>('message');
      message = message?.replaceFirst(
        'Error: Magic RPC Error: [-32600] ',
        '',
      );
      _error(MagicErrorEvent(message));
      _getSocialRedirectUri.complete(null);
    }
    if (messageData.connectSocialError) {
      String? message = messageData.getPayloadMapKey<String?>('message');
      message = message?.replaceFirst(
        'Error: Magic RPC Error: [-32600] ',
        '',
      );
      _error(MagicErrorEvent(message));
      _connectSocial.complete(false);
    }
    if (messageData.getFarcasterUriError) {
      String? message = messageData.getPayloadMapKey<String?>('message');
      message = message?.replaceFirst(
        'Error: Magic RPC Error: [-32600] ',
        '',
      );
      _error(MagicErrorEvent(message));
      _getFarcasterUri.complete(null);
    }
    if (messageData.connectFarcasterError) {
      String? message = messageData.getPayloadMapKey<String?>('message');
      message = message?.replaceFirst(
        'Error: Magic RPC Error: [-32600] ',
        '',
      );
      _error(MagicErrorEvent(message));
      _connectFarcaster.complete(false);
    }
    // GET_USER_ERROR
    if (messageData.getUserError) {
      final message = messageData.getPayloadMapKey<String?>('message');
      _error(GetUserErrorEvent(message: message));
      _getUserCompleter.complete(false);
    }
    if (messageData.switchNetworkError) {
      final message = messageData.getPayloadMapKey<String?>('message');
      _error(SwitchNetworkErrorEvent(message: message));
      _switchNetworkCompleter.complete(false);
    }
    if (messageData.getChainIdError) {
      final message = messageData.getPayloadMapKey<String?>('message');
      _error(SwitchNetworkErrorEvent(message: message));
      _getChainIdCompleter.complete(null);
    }
    if (messageData.rpcRequestError) {
      final message = messageData.getPayloadMapKey<String?>('message');
      _error(RpcRequestErrorEvent(message));
    }
    if (messageData.signOutError) {
      _error(SignOutErrorEvent());
    }
  }

  void _error(MagicErrorEvent errorEvent) {
    if (errorEvent is RpcRequestErrorEvent) {
      _requestCompleter.completeError(JsonRpcError(
        code: 0,
        message: errorEvent.error,
      ));
      onMagicRpcRequest.broadcast(
        MagicRequestEvent(
          request: null,
          result: JsonRpcError(code: 0, message: errorEvent.error),
          success: false,
        ),
      );
      return;
    }
    if (errorEvent is IsConnectedErrorEvent) {
      isReady.value = false;
      isConnected.value = false;
      step.value = EmailLoginStep.idle;
    }
    if (errorEvent is ConnectEmailErrorEvent) {
      isConnected.value = false;
      step.value = EmailLoginStep.idle;
    }
    if (errorEvent is UpdateEmailErrorEvent) {
      isConnected.value = false;
      step.value = EmailLoginStep.verifyOtp;
    }
    if (errorEvent is UpdateEmailPrimaryOtpErrorEvent) {
      step.value = EmailLoginStep.verifyOtp;
    }
    if (errorEvent is UpdateEmailSecondaryOtpErrorEvent) {
      step.value = EmailLoginStep.verifyOtp2;
    }
    if (errorEvent is ConnectOtpErrorEvent) {
      isConnected.value = false;
      step.value = EmailLoginStep.verifyOtp;
    }
    if (errorEvent is SignOutErrorEvent) {
      isConnected.value = true;
      _disconnectCompleter.complete(false);
    }
    if (!_isConnectedCompleter.isCompleted) {
      _isConnectedCompleter.complete(isConnected.value);
    }
    onMagicError.broadcast(errorEvent);
  }

  Future<void> _fitToScreen() async {
    return await _webViewController.runJavaScript('''
      if (document.querySelector('meta[name="viewport"]') === null) {
        var meta = document.createElement('meta');
        meta.name = 'viewport';
        meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no';
        document.head.appendChild(meta);
      } else {
        document.querySelector('meta[name="viewport"]').setAttribute('content', 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no');
      }
    ''');
  }

  Future<void> _runJavascript() async {
    return await _webViewController.runJavaScript('''
      window.addEventListener('message', ({ data, origin }) => {
        window.w3mWebview.postMessage(JSON.stringify({data,origin}))
      })

      const sendMessage = async (message) => {
        const iframeFL = document.getElementById('frame-mobile-sdk')
        console.log('postMessage(' + JSON.stringify(message) + ')')
        iframeFL.contentWindow.postMessage(message, '*')
      }
    ''');
  }

  void _onDebugConsoleReceived(JavaScriptConsoleMessage message) {
    _core.logger.d('[$runtimeType] ${message.message}');
  }

  void _onWebResourceError(WebResourceError error) {
    if (error.isForMainFrame == true) {
      isReady.value = false;
      isConnected.value = false;
      step.value = EmailLoginStep.idle;
      debugPrint('''
              [$runtimeType] Page resource error:
              code: ${error.errorCode}
              description: ${error.description}
              errorType: ${error.errorType}
              isForMainFrame: ${error.isForMainFrame}
              url: ${error.url}
            ''');
    }
  }

  bool _isAllowedDomain(String domain) {
    final domains = [
      UrlConstants.secureOrigin1,
      UrlConstants.secureOrigin2,
      ..._thirdPartySafeDomains,
    ].join('|');
    return RegExp(r'' + domains).hasMatch(domain);
  }

  void _timeOut(Timer time) {
    if (time.tick > 30) {
      _resetTimeOut();
      _error(IsConnectedErrorEvent());
      isTimeout.value = true;
      _core.logger.e(
        '[EmailLogin] initialization timed out. Please check if your '
        'bundleId/packageName $_packageName is whitelisted in your cloud '
        'configuration at ${UrlConstants.cloudService} for project id ${_core.projectId}',
      );
    }
  }

  Future<void> _setDebugMode() async {
    if (kDebugMode) {
      try {
        if (Platform.isIOS) {
          await _webViewController.setOnConsoleMessage(
            _onDebugConsoleReceived,
          );
          final webkitCtrl =
              _webViewController.platform as WebKitWebViewController;
          webkitCtrl.setInspectable(true);
        }
        if (Platform.isAndroid) {
          if (_webViewController.platform is AndroidWebViewController) {
            final platform =
                _webViewController.platform as AndroidWebViewController;
            AndroidWebViewController.enableDebugging(true);
            platform.setMediaPlaybackRequiresUserGesture(false);

            final cookieManager =
                WebViewCookieManager().platform as AndroidWebViewCookieManager;
            cookieManager.setAcceptThirdPartyCookies(
              _webViewController.platform as AndroidWebViewController,
              true,
            );
          }
        }
      } catch (_) {}
    }
  }

  void _resetTimeOut() {
    _timeOutTimer?.cancel();
    _timeOutTimer = null;
  }
}

extension JavaScriptMessageExtension on JavaScriptMessage {
  FrameMessage toFrameMessage() {
    final decodeMessage = jsonDecode(message) as Map<String, dynamic>;
    return FrameMessage.fromJson(decodeMessage);
  }
}
