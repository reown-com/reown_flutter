import Flutter
import UIKit
import YttriumWrapper

class Sign {
    
    private static var client: SignClient?
    
    static func initialize(_ params: Any, result: @escaping FlutterResult) {
        guard let dict = params as? [String: Any],
              let projectId = dict["projectId"] as? String else {
            result(FlutterError(code: "initialize", message: "Invalid parameters", details: params))
            return
        }
        
        client = SignClient(projectId: projectId)
        
        result(true)
    }
    
    static func setKey(_ params: Any, result: @escaping FlutterResult) {
        guard client != nil else {
            result(FlutterError(code: "Sign.setKey", message: "SignClient not initialized", details: nil))
            return
        }
        
        guard let key = params as? String,
              let keyData = key.hexStringToData() as Data? else {
            result(FlutterError(code: "Sign.setKey", message: "Invalid parameters", details: params))
            return
        }
        
        Task {
            await client!.setKey(key: keyData)
            result(true)
        }
    }
    
    static func generateKey(result: @escaping FlutterResult) {
        guard client != nil else {
            result(FlutterError(code: "Sign.generateKey", message: "SignClient not initialized", details: nil))
            return
        }
        
        Task {
            let keyData = client!.generateKey()
            result(keyData.dataToHexString())
        }
    }
    
    static func pair(_ params: Any, result: @escaping FlutterResult) {
        guard client != nil else {
            result(FlutterError(code: "Sign.pair", message: "SignClient not initialized", details: nil))
            return
        }
        
        guard let pairingUri = params as? String else {
            result(FlutterError(code: "Sign.pair", message: "Invalid parameters", details: params))
            return
        }
        
        Task {
            do {
                let pairResponse = try await client!.pairJson(uri: pairingUri)
                result(pairResponse)
            } catch {
                result(FlutterError(code: "Sign.pair", message: error.localizedDescription, details: nil))
            }
        }
    }
    
    static func approve(_ params: Any, result: @escaping FlutterResult) {        
        guard client != nil else {
            result(FlutterError(code: "Sign.approve", message: "SignClient not initialized", details: nil))
            return
        }
        
        guard let dict = params as? [String: Any],
              let proposal = dict["proposal"] as? String,
              let approvedNamespaces = dict["approvedNamespaces"] as? String,
              let selfMetadata = dict["selfMetadata"] as? String else {
            result(FlutterError(code: "Sign.approve", message: "Invalid parameters", details: params))
            return
        }
        
        Task {
            do {
                let approveResponse = try await client!.approveJson(proposal: proposal,
                                                                 approvedNamespaces: approvedNamespaces,
                                                                 selfMetadata: selfMetadata)
                result(approveResponse)
            } catch {
                result(FlutterError(code: "Sign.approve", message: error.localizedDescription, details: nil))
            }
        }
    }
}

