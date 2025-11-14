import Flutter
import UIKit

public class ReownYttriumUtilsPlugin: NSObject, FlutterPlugin {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "reown_yttrium_utils", binaryMessenger: registrar.messenger())
        let instance = ReownYttriumUtilsPlugin()
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
            // === STACKS METHODS ===
        case "stx_init":
            Stacks.initialize(call.arguments ?? {}, result: result)
        case "stx_generateWallet":
            Stacks.generateWallet(call.arguments ?? {}, result: result)
        case "stx_getAddress":
            Stacks.getAddress(call.arguments ?? {}, result: result)
        case "stx_signMessage":
            Stacks.signMessage(call.arguments ?? {}, result: result)
        case "stx_transferStx":
            Stacks.transferStx(call.arguments ?? {}, result: result)
            // === SUI METHODS ===
        case "sui_init":
            Sui.initialize(call.arguments ?? {}, result: result)
        case "sui_generateKeyPair":
            Sui.generateKeyPair(call.arguments ?? {}, result: result)
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
            // === TON METHODS ===
        case "ton_init":
            Ton.initialize(call.arguments ?? {}, result: result)
        case "ton_generateKeypair":
            Ton.generateKeypair(call.arguments ?? {}, result: result)
        case "ton_generateKeypairFromTonMnemonic":
            Ton.generateKeypairFromTonMnemonic(call.arguments ?? {}, result: result) // TODO
        case "ton_generateKeypairFromBip39Mnemonic":
            Ton.generateKeypairFromBip39Mnemonic(call.arguments ?? {}, result: result) // TODO
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
