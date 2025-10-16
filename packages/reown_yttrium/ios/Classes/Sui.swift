import Flutter
import UIKit
import YttriumUtilsWrapper

/**
 * Sui.swift
 *
 * Supports multiple SuiClient instances (e.g. mainnet, testnet).
 * Each instance is identified by its `networkId`.
 */
class Sui {
    private let client: SuiClient
    private let networkId: String
    
    init(projectId: String, networkId: String, pulseMetadata: PulseMetadata) {
        self.networkId = networkId
        self.client = SuiClient(projectId: projectId, pulseMetadata: pulseMetadata)
    }
    
    // MARK: - Instance Methods
    
    func generateKeyPair(result: @escaping FlutterResult) {
        result(suiGenerateKeypair())
    }
    
    func getAddressFromPublicKey(_ params: [String: Any], result: @escaping FlutterResult) {
        guard let publicKey = params["publicKey"] as? String else {
            result(FlutterError(code: "Sui.getAddressFromPublicKey", message: "Invalid parameters", details: params))
            return
        }
        result(suiGetAddress(publicKey: publicKey))
    }
    
    func getPublicKeyFromKeyPair(_ params: [String: Any], result: @escaping FlutterResult) {
        guard let keyPair = params["keyPair"] as? String else {
            result(FlutterError(code: "Sui.getPublicKeyFromKeyPair", message: "Invalid parameters", details: params))
            return
        }
        result(suiGetPublicKey(keypair: keyPair))
    }
    
    func personalSign(_ params: [String: Any], result: @escaping FlutterResult) {
        guard let keyPair = params["keyPair"] as? String,
              let message = params["message"] as? String else {
            result(FlutterError(code: "Sui.personalSign", message: "Invalid parameters", details: params))
            return
        }
        
        let response = suiPersonalSign(keypair: keyPair, message: message.data(using: .utf8)!)
        result(response)
    }
    
    func signTransaction(_ params: [String: Any], result: @escaping FlutterResult) {
        guard let keyPair = params["keyPair"] as? String,
              let txData = params["txData"] as? String,
              let dataBytes = Data(base64Encoded: txData) else {
            result(FlutterError(code: "Sui.signTransaction", message: "Invalid parameters", details: params))
            return
        }
        
        Task {
            do {
                let response = try await client.signTransaction(chainId: networkId, keypair: keyPair, txData: dataBytes)
                result([
                    "signature": response.signature,
                    "transactionBytes": response.txBytes
                ])
            } catch {
                result(FlutterError(code: "Sui.signTransaction", message: error.localizedDescription, details: nil))
            }
        }
    }
    
    func signAndExecuteTransaction(_ params: [String: Any], result: @escaping FlutterResult) {
        guard
            let keyPair = params["keyPair"] as? String,
            let txData = params["txData"] as? String,
            let dataBytes = Data(base64Encoded: txData) else {
            result(FlutterError(code: "Sui.signAndExecuteTransaction", message: "Invalid parameters", details: params))
            return
        }
        
        Task {
            do {
                let response = try await client.signAndExecuteTransaction(chainId: networkId, keypair: keyPair, txData: dataBytes)
                result(response)
            } catch {
                result(FlutterError(code: "Sui.signAndExecuteTransaction", message: error.localizedDescription, details: nil))
            }
        }
    }
    
    func dispose() {
        print("🤖 Disposing SuiClient for networkId: \(networkId)")
    }
    
    // MARK: - Static Registry (multi-instance management)
    
    private static var clients: [String: Sui] = [:]
    
    static func initialize(_ params: Any, result: @escaping FlutterResult) {
        guard let dict = params as? [String: Any],
              let projectId = dict["projectId"] as? String,
              let networkId = dict["networkId"] as? String,
              let pulseMetadataDict = dict["pulseMetadata"] as? [String: Any],
              let sdkVersion = pulseMetadataDict["sdkVersion"] as? String,
              let sdkPlatform = pulseMetadataDict["sdkPlatform"] as? String else {
            result(FlutterError(code: "Sui.initialize", message: "Missing required fields", details: params))
            return
        }
        
        let url = pulseMetadataDict["url"] as? String
        let bundleId = pulseMetadataDict["bundleId"] as? String
        
        let pulseMetadata = PulseMetadata(
            url: url,
            bundleId: bundleId ?? Bundle.main.bundleIdentifier,
            sdkVersion: sdkVersion,
            sdkPlatform: sdkPlatform
        )
        
        let instance = Sui(projectId: projectId, networkId: networkId, pulseMetadata: pulseMetadata)
        clients[networkId] = instance
        result(true)
    }
    
    private static func getClient(for networkId: String, result: @escaping FlutterResult) -> Sui? {
        guard let client = clients[networkId] else {
            result(FlutterError(code: "SuiClient", message: "No client found for networkId \(networkId)", details: nil))
            return nil
        }
        return client
    }
    
    // MARK: - Flutter Static Entry Points
    
    static func generateKeyPair(_ params: Any, result: @escaping FlutterResult) {
        guard let dict = params as? [String: Any],
              let networkId = dict["networkId"] as? String else {
            result(FlutterError(code: "Sui.generateKeyPair", message: "Invalid parameters", details: params))
            return
        }
        
        guard let client = getClient(for: networkId, result: result) else {
            result(FlutterError(code: "Sui.generateKeyPair", message: "SuiClient for networkId \(networkId) not found", details: nil))
            return
        }
        
        client.generateKeyPair(result: result)
    }
    
    static func getAddressFromPublicKey(_ params: Any, result: @escaping FlutterResult) {
        guard let dict = params as? [String: Any],
              let networkId = dict["networkId"] as? String else {
            result(FlutterError(code: "Sui.getAddressFromPublicKey", message: "Invalid parameters", details: params))
            return
        }
        
        guard let client = getClient(for: networkId, result: result) else {
            result(FlutterError(code: "Sui.getAddressFromPublicKey", message: "SuiClient for networkId \(networkId) not found", details: nil))
            return
        }
        
        client.getAddressFromPublicKey(dict, result: result)
    }
    
    static func getPublicKeyFromKeyPair(_ params: Any, result: @escaping FlutterResult) {
        guard let dict = params as? [String: Any],
              let networkId = dict["networkId"] as? String else {
            result(FlutterError(code: "Sui.getPublicKeyFromKeyPair", message: "Invalid parameters", details: params))
            return
        }
        
        guard let client = getClient(for: networkId, result: result) else {
            result(FlutterError(code: "Sui.getPublicKeyFromKeyPair", message: "SuiClient for networkId \(networkId) not found", details: nil))
            return
        }
        
        client.getPublicKeyFromKeyPair(dict, result: result)
    }
    
    static func personalSign(_ params: Any, result: @escaping FlutterResult) {
        guard let dict = params as? [String: Any],
              let networkId = dict["networkId"] as? String else {
            result(FlutterError(code: "Sui.personalSign", message: "Invalid parameters", details: params))
            return
        }
        
        guard let client = getClient(for: networkId, result: result) else {
            result(FlutterError(code: "Sui.personalSign", message: "SuiClient for networkId \(networkId) not found", details: nil))
            return
        }
        
        client.personalSign(dict, result: result)
    }
    
    static func signTransaction(_ params: Any, result: @escaping FlutterResult) {
        guard let dict = params as? [String: Any],
              let networkId = dict["networkId"] as? String else {
            result(FlutterError(code: "Sui.signTransaction", message: "Invalid parameters", details: params))
            return
        }
        
        guard let client = getClient(for: networkId, result: result) else {
            result(FlutterError(code: "Sui.signTransaction", message: "SuiClient for networkId \(networkId) not found", details: nil))
            return
        }
        
        client.signTransaction(dict, result: result)
    }
    
    static func signAndExecuteTransaction(_ params: Any, result: @escaping FlutterResult) {
        guard let dict = params as? [String: Any],
              let networkId = dict["networkId"] as? String else {
            result(FlutterError(code: "Sui.signAndExecuteTransaction", message: "Invalid parameters", details: params))
            return
        }
        
        guard let client = getClient(for: networkId, result: result) else {
            result(FlutterError(code: "Sui.signAndExecuteTransaction", message: "SuiClient for networkId \(networkId) not found", details: nil))
            return
        }
        
        client.signAndExecuteTransaction(dict, result: result)
    }
    
    static func dispose(_ params: Any, result: @escaping FlutterResult) {
        guard let dict = params as? [String: Any],
              let networkId = dict["networkId"] as? String else {
            result(FlutterError(code: "Sui.dispose", message: "Invalid parameters", details: params))
            return
        }
        
        guard let client = getClient(for: networkId, result: result) else {
            result(FlutterError(code: "Sui.dispose", message: "SuiClient for networkId \(networkId) not found", details: nil))
            return
        }
        
        client.dispose()
        clients.removeValue(forKey: networkId)
        
        result(true)
    }
}
