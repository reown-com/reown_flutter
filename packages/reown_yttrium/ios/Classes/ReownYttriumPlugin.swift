import Flutter
import UIKit

public class ReownYttriumPlugin: NSObject, FlutterPlugin {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "reown_yttrium", binaryMessenger: registrar.messenger())
        let instance = ReownYttriumPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "erc6492_init":
            EIP6492Verifier.initialize(call.arguments ?? {}, result: result)
        case "erc6492_verify":
            EIP6492Verifier.verifySignature(call.arguments ?? {}, result: result)
        case "erc6492_dispose":
            EIP6492Verifier.dispose(call.arguments ?? {}, result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
    
