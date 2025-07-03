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
            // Stacks methods
        case "stx_init":
            Stacks.initialize(call.arguments ?? {}, result: result)
        case "stx_generateWallet":
            Stacks.generateWallet(result: result)
        case "stx_getAddress":
            Stacks.getAddress(call.arguments ?? {}, result: result)
        case "stx_signMessage":
            Stacks.signMessage(call.arguments ?? {}, result: result)
        case "stx_transferStx":
            Stacks.transferStx(call.arguments ?? {}, result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
