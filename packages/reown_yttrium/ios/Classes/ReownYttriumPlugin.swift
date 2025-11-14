import Flutter
import UIKit

import YttriumWrapper

public class ReownYttriumPlugin: NSObject, FlutterPlugin {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "reown_yttrium", binaryMessenger: registrar.messenger())
        let instance = ReownYttriumPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
            // TODO implement 6492 methods
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
