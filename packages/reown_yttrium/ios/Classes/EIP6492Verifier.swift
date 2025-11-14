import Flutter
import UIKit

import YttriumWrapper

class EIP6492Verifier {
    private let erc6492Client: Erc6492Client
    private let projectId: String
    private let networkId: String
    
    private init(projectId: String, networkId: String) {
        self.projectId = projectId
        self.networkId = networkId
        
        let rpcUrl = "https://rpc.walletconnect.com/v1?chainId=\(networkId)&projectId=\(projectId)"
        self.erc6492Client = Erc6492Client(rpcUrl: rpcUrl)
    }
    
    // Private helper method containing the common logic
    private func verifySignature(params: [String: Any], result: @escaping FlutterResult) {
        // signature: String, message: String, address: String, networkId: String
        guard let signature = params["signature"] as? String,
              let hexStringPrefixedMessageHash = params["hexStringPrefixedMessageHash"] as? String,
              let address = params["address"] as? String
        else {
            return result(FlutterError(code: "Erc6492Client.verifySignature", message: "Missing required fields", details: nil))
        }
        
        //  guard let messageData = message.data(using: .utf8) else {
        //      return result(FlutterError(code: "Erc6492Client.verifySignature", message: "Failed to encode string using UTF-8.", details: nil))
        //  }
        
        //  let prefixedMessage = messageData.prefixed
        //  let messageHash = crypto.keccak256(prefixedMessage)
        
        Task {
            do {
                let verificationResult = try await self.erc6492Client.verifySignature(
                    signature: signature,
                    address: address,
                    messageHash: hexStringPrefixedMessageHash,
                )
                return result(verificationResult)
                
            } catch {
                return result(FlutterError(code: "Erc6492Client.verifySignature", message: error.localizedDescription, details: nil))
            }
        }
    }
    
    private func dispose() {
        print("🧹 Disposing TonClient for network \(networkId)")
    }
    
    // MARK: - Static instance manager
    
    private static var clients: [String: EIP6492Verifier] = [:]
    
    static func initialize(_ params: Any, result: @escaping FlutterResult) {
        guard let dict = params as? [String: Any] else {
            result(FlutterError(code: "Erc6492Client.initialize", message: "Invalid parameters: not a map", details: params))
            return
        }
        
        guard
            let networkId = dict["networkId"] as? String,
            let projectId = dict["projectId"] as? String
        else {
            result(FlutterError(code: "Erc6492Client.initialize", message: "Missing required fields", details: dict))
            return
        }
        
        let eIP6492Verifier = EIP6492Verifier(projectId: projectId, networkId: networkId)
        clients[networkId] = eIP6492Verifier
        result(true)
    }
    
    private static func getClient(for networkId: String, result: FlutterResult) -> EIP6492Verifier? {
        guard let client = clients[networkId] else {
            result(FlutterError(code: "Erc6492Client", message: "networkId '\(networkId)' not found", details: nil))
            return nil
        }
        return client
    }
    
    // MARK: - Static entrypoints
    
    // Private helper method containing the common logic
    public static func verifySignature(_ params: Any, result: @escaping FlutterResult) {
        guard let dict = params as? [String: Any],
              let networkId = dict["networkId"] as? String else {
            result(FlutterError(code: "Erc6492Client.sendMessage", message: "Invalid parameters", details: params))
            return
        }
        
        guard let client = getClient(for: networkId, result: result) else {
            result(FlutterError(code: "Erc6492Client.verifySignature", message: "Erc6492Client for networkId \(networkId) not found", details: nil))
            return
        }
        
        client.verifySignature(params: dict, result: result)
    }
    
    // Private helper method containing the common logic
    public static func dispose(_ params: Any, result: @escaping FlutterResult) {
        guard let dict = params as? [String: Any],
              let networkId = dict["networkId"] as? String else {
            result(FlutterError(code: "Erc6492Client.dispose", message: "Invalid parameters", details: params))
            return
        }
        
        clients.removeValue(forKey: networkId)?.dispose()
    }
}
