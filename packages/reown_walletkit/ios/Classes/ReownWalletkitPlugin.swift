import Flutter
import UIKit

public class ReownWalletkitPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "reown_walletkit", binaryMessenger: registrar.messenger())
    let instance = ReownWalletkitPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }
}
