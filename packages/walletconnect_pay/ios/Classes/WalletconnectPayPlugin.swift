import Flutter
import UIKit

public class WalletconnectPayPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "walletconnect_pay", binaryMessenger: registrar.messenger())
    let instance = WalletconnectPayPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "initialize":
      WalletConnectPayClient.initialize(params: call.arguments, result: result)
    case "confirmPayment":
      WalletConnectPayClient.confirmPayment(params: call.arguments, result: result)
    case "getPaymentOptions":
      WalletConnectPayClient.getPaymentOptions(params: call.arguments, result: result)
    case "getRequiredPaymentActions":
      WalletConnectPayClient.getRequiredPaymentActions(params: call.arguments, result: result)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
