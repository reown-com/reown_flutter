import Flutter
import UIKit
import YttriumWrapper

class Sui {
    static var client: SuiClient?
    
    static func initialize(_ params: Any, result: @escaping FlutterResult) {
        guard let dict = params as? [String: Any],
              let projectId = dict["projectId"] as? String,
              let pulseMetadataDict = dict["pulseMetadata"] as? [String: Any],
              let url = pulseMetadataDict["url"] as? String,
              let bundleId = pulseMetadataDict["bundleId"] as? String,
              let sdkVersion = pulseMetadataDict["sdkVersion"] as? String,
              let sdkPlatform = pulseMetadataDict["sdkPlatform"] as? String else {
            result(FlutterError(code: "initialize", message: "Invalid parameters", details: params))
            return
        }
        
        let bundleID = Bundle.main.bundleIdentifier ?? bundleId
        let pulseMetadata = PulseMetadata(url: url,
                                          bundleId: bundleID,
                                          sdkVersion: sdkVersion,
                                          sdkPlatform: sdkPlatform)
        
        client = SuiClient(projectId: projectId,
                           pulseMetadata: pulseMetadata)
        
        result(true)
    }
    
    static func personalSign(_ params: Any, result: @escaping FlutterResult) {
        print("personalSign called with ", params)
        
        guard client != nil else {
            result(FlutterError(code: "Sui", message: "SuiClient not initialized", details: nil))
            return
        }
        
        guard let dict = params as? [String: Any],
              let keyPair = dict["keyPair"] as? String,
              let message = dict["message"] as? String else {
            result(FlutterError(code: "personalSign", message: "Invalid parameters", details: params))
            return
        }
        
        let response = suiPersonalSign(keypair: keyPair, message: message.data(using: .utf8)!)
        result(response)
    }
    
    static func signTransaction(_ params: Any, result: @escaping FlutterResult) {
        print("signTransaction called with ", params)
        
        guard client != nil else {
            result(FlutterError(code: "Sui", message: "SuiClient not initialized", details: nil))
            return
        }
        
        guard let dict = params as? [String: Any],
              let chainId = dict["chainId"] as? String,
              let keyPair = dict["keyPair"] as? String,
              let txData = dict["txData"] as? String,
              let dataBytes = Data(base64Encoded: txData) else {
            result(FlutterError(code: "signTransaction", message: "Invalid parameters", details: params))
            return
        }
        
        Task {
            do {
                let response = try await client!.signTransaction(chainId: chainId, keypair: keyPair, txData: dataBytes)
                result([
                    "signature": response.signature,
                    "transactionBytes": response.txBytes
                ])
            } catch {
                result(FlutterError(code: "Sui.signTransaction", message: error.localizedDescription, details: nil))
            }
        }
    }
    
    static func signAndExecuteTransaction(_ params: Any, result: @escaping FlutterResult) {
        print("signAndExecuteTransaction called with ", params)
        
        guard client != nil else {
            result(FlutterError(code: "Sui", message: "SuiClient not initialized", details: nil))
            return
        }
        
        guard let dict = params as? [String: Any],
              let chainId = dict["chainId"] as? String,
              let keyPair = dict["keyPair"] as? String,
              let txData = dict["txData"] as? String,
              let dataBytes = Data(base64Encoded: txData) else {
            result(FlutterError(code: "signAndExecuteTransaction", message: "Invalid parameters", details: params))
            return
        }
        
        Task {
            do {
                let response = try await client!.signAndExecuteTransaction(chainId: chainId, keypair: keyPair, txData: dataBytes)
                result(response)
            } catch {
                result(FlutterError(code: "Sui.signAndExecuteTransaction", message: error.localizedDescription, details: nil))
            }
        }
    }
    
    static func generateKeyPair(result: @escaping FlutterResult) {
        result(suiGenerateKeypair())
    }
    
    static func getAddressFromPublicKey(_ params: Any, result: @escaping FlutterResult) {
        guard let dict = params as? [String: Any],
              let publicKey = dict["publicKey"] as? String else {
            result(FlutterError(code: "getAddressFromPublicKey", message: "Invalid parameters", details: params))
            return
        }
        
        result(suiGetAddress(publicKey: publicKey))
    }
    
    static func getPublicKeyFromKeyPair(_ params: Any, result: @escaping FlutterResult) {
        guard let dict = params as? [String: Any],
              let keyPair = dict["keyPair"] as? String else {
            result(FlutterError(code: "getPublicKeyFromKeyPair", message: "Invalid parameters", details: params))
            return
        }
        
        result(suiGetPublicKey(keypair: keyPair))
    }
}
