import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'walletconnect_pay_method_channel.dart';

abstract class WalletconnectPayPlatform extends PlatformInterface {
  /// Constructs a WalletconnectPayPlatform.
  WalletconnectPayPlatform() : super(token: _token);

  static final Object _token = Object();

  static WalletconnectPayPlatform _instance = MethodChannelWalletconnectPay();

  /// The default instance of [WalletconnectPayPlatform] to use.
  ///
  /// Defaults to [MethodChannelWalletconnectPay].
  static WalletconnectPayPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [WalletconnectPayPlatform] when
  /// they register themselves.
  static set instance(WalletconnectPayPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> initialize({
    String? apiKey,
    String? appId,
    String? clientId,
    String? baseUrl,
  });

  Future<String> confirmPayment({required String requestJson});

  Future<String> getPaymentOptions({required String requestJson});

  Future<String> getRequiredPaymentActions({required String requestJson});
}
