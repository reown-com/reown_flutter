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
            // ChainAbstraction methods
        case "ca_init":
            ChainAbstraction.initialize(call.arguments ?? {}, result: result)
        case "ca_erc20TokenBalance":
            ChainAbstraction.erc20TokenBalance(call.arguments ?? {}, result: result)
        case "ca_estimateFees":
            ChainAbstraction.estimateFees(call.arguments ?? {}, result: result)
        case "ca_prepareDetailed":
            ChainAbstraction.prepareDetailed(call.arguments ?? {}, result: result)
        case "ca_execute":
            ChainAbstraction.execute(call.arguments ?? {}, result: result)
            // Sui methods
        case "sui_init":
            Sui.initialize(call.arguments ?? {}, result: result)
        case "sui_generateKeyPair":
            Sui.generateKeyPair(result: result)
        case "sui_getPublicKeyFromKeyPair":
            Sui.getPublicKeyFromKeyPair(call.arguments ?? {}, result: result)
        case "sui_getAddressFromPublicKey":
            Sui.getAddressFromPublicKey(call.arguments ?? {}, result: result)
        case "sui_personalSign":
            Sui.personalSign(call.arguments ?? {}, result: result)
        case "sui_signTransaction":
            Sui.signTransaction(call.arguments ?? {}, result: result)
        case "sui_signAndExecuteTransaction":
            Sui.signAndExecuteTransaction(call.arguments ?? {}, result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
