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
            // === CHAIN ABSTRACTION METHODS ===
            //        case "ca_init":
            //            ChainAbstraction.initialize(call.arguments ?? {}, result: result)
            //        case "ca_erc20TokenBalance":
            //            ChainAbstraction.erc20TokenBalance(call.arguments ?? {}, result: result)
            //        case "ca_estimateFees":
            //            ChainAbstraction.estimateFees(call.arguments ?? {}, result: result)
            //        case "ca_prepareDetailed":
            //            ChainAbstraction.prepareDetailed(call.arguments ?? {}, result: result)
            //        case "ca_execute":
            //            ChainAbstraction.execute(call.arguments ?? {}, result: result)
            // === TON METHODS ===
        case "ton_init":
            Ton.initialize(call.arguments ?? {}, result: result)
        case "ton_generateKeypair":
            Ton.generateKeypair(call.arguments ?? {}, result: result)
        case "ton_generateKeypairFromTonMnemonic":
            Ton.generateKeypair(call.arguments ?? {}, result: result) // TODO
        case "ton_generateKeypairFromBip39Mnemonic":
            Ton.generateKeypair(call.arguments ?? {}, result: result) // TODO
        case "ton_getAddressFromKeypair":
            Ton.getAddressFromKeypair(call.arguments ?? {}, result: result)
        case "ton_signData":
            Ton.signData(call.arguments ?? {}, result: result)
        case "ton_sendMessage":
            Ton.sendMessage(call.arguments ?? {}, result: result)
        case "ton_broadcastMessage":
            Ton.broadcastMessage(call.arguments ?? {}, result: result)
        case "ton_dispose":
            Ton.dispose(call.arguments ?? {}, result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}

