import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:reown_appkit/modal/constants/string_constants.dart';
import 'package:reown_appkit/modal/services/analytics_service/analytics_service_singleton.dart';
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
  static const _safeDomains = [
    'auth.magic.link',
    'launchdarkly.com',
  ];
  static const supportedMethods = [
    'personal_sign',
    'eth_sign',
    'eth_sendTransaction',
    'eth_signTypedData_v4',
    'wallet_switchEthereumChain',
    'wallet_addEthereumChain',
  ];
  static const defaultWalletData = ReownAppKitModalWalletInfo(
    listing: Listing(
      id: '',
      name: 'Email Wallet',
      homepage: '',
      imageId: '',
      order: 10000,
    ),
    installed: false,
    recent: false,
  );

  @override
  ConnectionMetadata get metadata => ConnectionMetadata(
        metadata: PairingMetadata(
          name: defaultWalletData.listing.name,
          description: '',
          url: defaultWalletData.listing.homepage,
          icons: [''],
        ),
        publicKey: '',
      );

  //
  // final IReownAppKit _appKit;
  Timer? _timeOutTimer;
  String? _connectionChainId;
  int _onLoadCount = 0;
  String _packageName = '';

  late final WebViewController _webViewController;
  WebViewController get controller => _webViewController;

  late final WebViewWidget _webview;
  WebViewWidget get webview => _webview;

  late Completer<bool> _initialized;
  late Completer<bool> _connected;
  late Completer<dynamic> _response;
  late Completer<bool> _disconnect;

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

  final isEnabled = ValueNotifier(false);
  final isReady = ValueNotifier(false);
  final isConnected = ValueNotifier(false);
  final isTimeout = ValueNotifier(false);

  final email = ValueNotifier<String>('');
  final newEmail = ValueNotifier<String>('');
  final step = ValueNotifier<EmailLoginStep>(EmailLoginStep.idle);

  late final IReownCore _core;
  late final PairingMetadata _metadata;

  MagicService({
    // required IReownAppKit appKit,
    required IReownCore core,
    required PairingMetadata metadata,
    bool enabled = false,
  })  : _core = core,
        _metadata = metadata {
    isEnabled.value = enabled;
    if (isEnabled.value) {
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

  @override
  Future<void> init() async {
    if (!isEnabled.value) {
      _initialized = Completer<bool>();
      _initialized.complete(false);
      _connected = Completer<bool>();
      _connected.complete(false);
      return;
    }
    _packageName = await ReownCoreUtils.getPackageName();
    await _init();
    await _initialized.future;
    await _isConnected();
    await _connected.future;
    isReady.value = true;
    _syncDappData();
    return;
  }

  Future<void> _init() async {
    _initialized = Completer<bool>();

    await _webViewController.setBackgroundColor(Colors.transparent);
    await _webViewController.setJavaScriptMode(JavaScriptMode.unrestricted);
    await _webViewController.addJavaScriptChannel(
      'w3mWebview',
      onMessageReceived: _onFrameMessage,
    );
    await _webViewController.setNavigationDelegate(
      NavigationDelegate(
        onNavigationRequest: (NavigationRequest request) {
          if (_isAllowedDomain(request.url)) {
            return NavigationDecision.navigate;
          }
          if (isReady.value) {
            launchUrlString(
              request.url,
              mode: LaunchMode.externalApplication,
            );
          }
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
          Future.delayed(Duration(milliseconds: 600)).then((value) {
            if (_initialized.isCompleted) return;
            _initialized.complete(true);
          });
        },
      ),
    );
    await _setDebugMode();
    await _loadRequest();
  }

  @override
  void setEmail(String value) {
    email.value = value;
  }

  @override
  void setNewEmail(String value) {
    newEmail.value = value;
  }

  // ****** W3mFrameProvider public methods ******* //

  @override
  Future<void> connectEmail({required String value, String? chainId}) async {
    if (!isEnabled.value || !isReady.value) return;
    _connectionChainId = chainId ?? _connectionChainId;
    final message = ConnectEmail(email: value).toString();
    await _webViewController.runJavaScript('sendMessage($message)');
  }

  @override
  Future<void> updateEmail({required String value}) async {
    if (!isEnabled.value || !isReady.value) return;
    step.value = EmailLoginStep.loading;
    final message = UpdateEmail(email: value).toString();
    await _webViewController.runJavaScript('sendMessage($message)');
  }

  @override
  Future<void> updateEmailPrimaryOtp({required String otp}) async {
    if (!isEnabled.value || !isReady.value) return;
    step.value = EmailLoginStep.loading;
    final message = UpdateEmailPrimaryOtp(otp: otp).toString();
    await _webViewController.runJavaScript('sendMessage($message)');
  }

  @override
  Future<void> updateEmailSecondaryOtp({required String otp}) async {
    if (!isEnabled.value || !isReady.value) return;
    step.value = EmailLoginStep.loading;
    final message = UpdateEmailSecondaryOtp(otp: otp).toString();
    await _webViewController.runJavaScript('sendMessage($message)');
  }

  @override
  Future<void> connectOtp({required String otp}) async {
    if (!isEnabled.value || !isReady.value) return;
    step.value = EmailLoginStep.loading;
    final message = ConnectOtp(otp: otp).toString();
    await _webViewController.runJavaScript('sendMessage($message)');
  }

  @override
  Future<void> getChainId() async {
    if (!isEnabled.value || !isReady.value) return;
    final message = GetChainId().toString();
    await _webViewController.runJavaScript('sendMessage($message)');
  }

  @override
  Future<void> syncTheme(ReownAppKitModalTheme? theme) async {
    if (!isEnabled.value || !isReady.value) return;
    final message = SyncTheme(theme: theme).toString();
    await _webViewController.runJavaScript('sendMessage($message)');
  }

  void _syncDappData() async {
    if (!isEnabled.value || !isReady.value) return;
    final message = SyncAppData(
      metadata: _metadata,
      projectId: _core.projectId,
      sdkVersion: 'flutter-${CoreConstants.X_SDK_VERSION}',
    ).toString();
    await _webViewController.runJavaScript('sendMessage($message)');
  }

  @override
  Future<void> getUser({String? chainId}) async {
    if (!isEnabled.value || !isReady.value) return;
    return await _getUser(chainId);
  }

  Future<void> _getUser(String? chainId) async {
    final message = GetUser(chainId: chainId).toString();
    return await _webViewController.runJavaScript('sendMessage($message)');
  }

  @override
  Future<void> switchNetwork({required String chainId}) async {
    if (!isEnabled.value || !isReady.value) return;
    final message = SwitchNetwork(chainId: chainId).toString();
    await _webViewController.runJavaScript('sendMessage($message)');
  }

  @override
  Future<dynamic> request({
    String? chainId,
    required SessionRequestParams request,
  }) async {
    if (!isEnabled.value) return;
    await _awaitReadyness.future;
    await _rpcRequest(request.toJson());
    return await _response.future;
  }

  Future<void> _rpcRequest(Map<String, dynamic> parameters) async {
    _response = Completer<dynamic>();
    if (!isConnected.value) {
      onMagicLoginRequest.broadcast(MagicSessionEvent(email: email.value));
      _connected = Completer<bool>();
      await connectEmail(value: email.value);
      final success = await _connected.future;
      if (!success) return;
    }
    onMagicRpcRequest.broadcast(MagicRequestEvent(request: parameters));
    final method = parameters['method'];
    final params = parameters['params'] as List;
    final message = RpcRequest(method: method, params: params).toString();
    await _webViewController.runJavaScript('sendMessage($message)');
  }

  @override
  Future<bool> disconnect() async {
    if (!isEnabled.value || !isReady.value) return false;
    _disconnect = Completer<bool>();
    if (!isConnected.value) {
      _resetTimeOut();
      _disconnect.complete(true);
      return (await _disconnect.future);
    }
    final message = SignOut().toString();
    await _webViewController.runJavaScript('sendMessage($message)');
    return (await _disconnect.future);
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
      final queryParams = {
        'projectId': _core.projectId,
        'bundleId': _packageName,
      };
      await _webViewController.loadRequest(
        uri.replace(queryParameters: queryParams),
        headers: headers,
      );
      // in case connection message or even the request itself hangs there's no other way to continue the flow than timing it out.
      _timeOutTimer ??= Timer.periodic(Duration(seconds: 1), _timeOut);
    } catch (e) {
      _initialized.complete(false);
    }
  }

  Future<void> _isConnected() async {
    _connected = Completer<bool>();
    final message = IsConnected().toString();
    await _webViewController.runJavaScript('sendMessage($message)');
  }

  void _onFrameMessage(JavaScriptMessage jsMessage) async {
    if (Platform.isAndroid) {
      _core.logger.d('[$runtimeType] jsMessage ${jsMessage.message}');
    }
    try {
      final frameMessage = jsMessage.toFrameMessage();
      if (!frameMessage.isValidOrigin || !frameMessage.isValidData) {
        return;
      }
      final messageData = frameMessage.data!;
      if (messageData.syncDataSuccess) {
        _resetTimeOut();
      }
      // ****** IS_CONNECTED
      if (messageData.isConnectSuccess) {
        _resetTimeOut();
        isConnected.value = messageData.getPayloadMapKey<bool>('isConnected');
        if (!_connected.isCompleted) {
          _connected.complete(isConnected.value);
        }
        onMagicConnect.broadcast(MagicConnectEvent(isConnected.value));
        if (isConnected.value) {
          await _getUser(_connectionChainId);
        }
      }
      // ****** CONNECT_EMAIL
      if (messageData.connectEmailSuccess) {
        if (step.value != EmailLoginStep.loading) {
          final action = messageData.getPayloadMapKey<String>('action');
          final value = action.toString().toUpperCase();
          final newStep = EmailLoginStep.fromAction(value);
          if (newStep == EmailLoginStep.verifyOtp) {
            if (step.value == EmailLoginStep.verifyDevice) {
              analyticsService.instance.sendEvent(DeviceRegisteredForEmail());
            }
            analyticsService.instance.sendEvent(EmailVerificationCodeSent());
          }
          step.value = newStep;
        }
      }
      // ****** CONNECT_OTP
      if (messageData.connectOtpSuccess) {
        analyticsService.instance.sendEvent(EmailVerificationCodePass());
        step.value = EmailLoginStep.idle;
        await _getUser(_connectionChainId);
      }
      // ****** UPDAET_EMAIL
      if (messageData.updateEmailSuccess) {
        final action = messageData.getPayloadMapKey<String>('action');
        if (action == 'VERIFY_SECONDARY_OTP') {
          step.value = EmailLoginStep.verifyOtp2;
        } else {
          step.value = EmailLoginStep.verifyOtp;
        }
        analyticsService.instance.sendEvent(EmailEdit());
      }
      // ****** UPDATE_EMAIL_PRIMARY_OTP
      if (messageData.updateEmailPrimarySuccess) {
        step.value = EmailLoginStep.verifyOtp2;
      }
      // ****** UPDATE_EMAIL_SECONDARY_OTP
      if (messageData.updateEmailSecondarySuccess) {
        analyticsService.instance.sendEvent(EmailEditComplete());
        step.value = EmailLoginStep.idle;
        setEmail(newEmail.value);
        setNewEmail('');
        await _getUser(_connectionChainId);
      }
      // ****** SWITCH_NETWORK
      if (messageData.switchNetworkSuccess) {
        final chainId = messageData.getPayloadMapKey<int?>('chainId');
        onMagicUpdate.broadcast(MagicSessionEvent(chainId: chainId));
      }
      // ****** GET_CHAIN_ID
      if (messageData.getChainIdSuccess) {
        final chainId = messageData.getPayloadMapKey<int?>('chainId');
        onMagicUpdate.broadcast(MagicSessionEvent(chainId: chainId));
        _connectionChainId = chainId?.toString();
      }
      // ****** RPC_REQUEST
      if (messageData.rpcRequestSuccess) {
        final hash = messageData.payload as String?;
        _response.complete(hash);
        onMagicRpcRequest.broadcast(
          MagicRequestEvent(
            request: null,
            result: hash,
            success: true,
          ),
        );
      }
      // ****** GET_USER
      if (messageData.getUserSuccess) {
        isConnected.value = true;
        final data = MagicData.fromJson(messageData.payload!);
        if (!_connected.isCompleted) {
          final event = MagicSessionEvent(
            email: data.email,
            address: data.address,
            chainId: data.chainId,
          );
          onMagicUpdate.broadcast(event);
          _connected.complete(isConnected.value);
        } else {
          final session = data.copytWith(
            peer: metadata,
            self: ConnectionMetadata(
              metadata: _metadata,
              publicKey: '',
            ),
          );
          onMagicLoginSuccess.broadcast(MagicLoginEvent(session));
        }
      }
      // ****** SIGN_OUT
      if (messageData.signOutSuccess) {
        _resetTimeOut();
        _disconnect.complete(true);
      }
      // ****** SESSION_UPDATE
      if (messageData.sessionUpdate) {
        // onMagicUpdate.broadcast(MagicSessionEvent(...));
      }
      if (messageData.isConnectError) {
        _error(IsConnectedErrorEvent());
      }
      if (messageData.connectEmailError) {
        String? message = messageData.payload?['message']?.toString();
        if (message?.toLowerCase() == 'invalid params') {
          message = 'Wrong email format';
        }
        _error(ConnectEmailErrorEvent(message: message));
      }
      if (messageData.updateEmailError) {
        final message = messageData.payload?['message']?.toString();
        _error(UpdateEmailErrorEvent(message: message));
      }
      if (messageData.updateEmailPrimaryOtpError) {
        final message = messageData.payload?['message']?.toString();
        _error(UpdateEmailPrimaryOtpErrorEvent(message: message));
      }
      if (messageData.updateEmailSecondaryOtpError) {
        final message = messageData.payload?['message']?.toString();
        _error(UpdateEmailSecondaryOtpErrorEvent(message: message));
      }
      if (messageData.connectOtpError) {
        analyticsService.instance.sendEvent(EmailVerificationCodeFail());
        final message = messageData.payload?['message']?.toString();
        _error(ConnectOtpErrorEvent(message: message));
      }
      if (messageData.getUserError) {
        _error(GetUserErrorEvent());
      }
      if (messageData.switchNetworkError) {
        _error(SwitchNetworkErrorEvent());
      }
      if (messageData.rpcRequestError) {
        final message = messageData.getPayloadMapKey<String?>('message');
        _error(RpcRequestErrorEvent(message));
      }
      if (messageData.signOutError) {
        _error(SignOutErrorEvent());
      }
    } catch (e, s) {
      _core.logger.d('[$runtimeType] $jsMessage', stackTrace: s);
    }
  }

  void _error(MagicErrorEvent errorEvent) {
    if (errorEvent is RpcRequestErrorEvent) {
      _response.completeError(JsonRpcError(code: 0, message: errorEvent.error));
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
      _disconnect.complete(false);
    }
    if (!_connected.isCompleted) {
      _connected.complete(isConnected.value);
    }
    onMagicError.broadcast(errorEvent);
  }

  Future<void> _runJavascript() async {
    return await _webViewController.runJavaScript('''
      const iframeFL = document.getElementById('frame-mobile-sdk')

      window.addEventListener('message', ({ data, origin }) => {
        console.log('[MagicService] received <=== ' + JSON.stringify({data,origin}))
        window.w3mWebview.postMessage(JSON.stringify({data,origin}))
      })

      const sendMessage = async (message) => {
        console.log('[MagicService] posted =====> ' + JSON.stringify(message))
        iframeFL.contentWindow.postMessage(message, '*')
      }
    ''');
  }

  // sendMessage({type:"@w3m-app/GET_SOCIAL_REDIRECT_URI",payload:{provider:"x"}});
  // sendMessage({type:"@w3m-app/CONNECT_SOCIAL",payload:{uri:"https://auth.magic.link/v1/oauth2/twitter/start?magic_api_key=pk_live_B080E9DC31E5875E&magic_challenge=9HbSG6KYL3r2b7LqzhD7-EcjoHLj-a7wt7npmSBR2fw&state=FfR0W7idPzp81HM2KE~zBPR7bbSQM97CL5zZZMHd_2_ZHZ~rLvnO63MO3fd6eB4LMymif9pQupdhVL11l4NsQk4D-zQDfPGB17PpiWjPobCemCZwP.HdkH4dQeSDgkiH&platform=web&redirect_uri=https%3A%2F%2Fsecure.walletconnect.com%2Fsdk%2Foauth%3FprojectId%3Dcad4956f31a5e40a00b62865b030c6f8"}});

  void _onDebugConsoleReceived(JavaScriptConsoleMessage message) {
    _core.logger.d('[$runtimeType] JS Console ${message.message}');
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
      Uri.parse(UrlConstants.secureService).authority,
      Uri.parse(UrlConstants.secureDashboard).authority,
      ..._safeDomains,
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
            AndroidWebViewController.enableDebugging(true);
            (_webViewController.platform as AndroidWebViewController)
                .setMediaPlaybackRequiresUserGesture(false);

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
