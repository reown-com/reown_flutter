//
//  Ton.swift
//  reown_yttrium_utils
//
//  Created by Alfredo Rinaudo on 15/10/2025.
//
import Flutter
import UIKit
import YttriumUtilsWrapper

class Ton {
    private let tonClient: TonClient
    private let projectId: String
    private let networkId: String
    private let pulseMetadata: PulseMetadata
    
    private init(projectId: String, networkId: String, pulseMetadata: PulseMetadata) {
        self.projectId = projectId
        self.networkId = networkId
        self.pulseMetadata = pulseMetadata
        
        let config = TonClientConfig(networkId: networkId)
        self.tonClient = TonClient(cfg: config, projectId: projectId, pulseMetadata: pulseMetadata)
    }
    
    // MARK: - Instance methods
    
    private func generateKeypair(result: FlutterResult) {
        let keyPair = tonClient.generateKeypair()
        result([
            "pk": keyPair.pk,
            "sk": keyPair.sk
        ])
    }
    
    private func generateKeypairFromTonMnemonic(params: [String: Any], result: FlutterResult) {
        guard let mnemonic = params["mnemonic"] as? String else {
            return result(FlutterError(code: "Ton.generateKeypairFromTonMnemonic", message: "Missing mnemonic", details: nil))
        }
        
        do {
            let keyPair = try tonClient.generateKeypairFromTonMnemonic(mnemonic: mnemonic)
            result(["pk": keyPair.pk, "sk": keyPair.sk])
        } catch {
            result(FlutterError(code: "Ton.generateKeypairFromTonMnemonic", message: error.localizedDescription, details: nil))
        }
        
    }
    
    private func generateKeypairFromBip39Mnemonic(params: [String: Any], result: FlutterResult) {
        guard let mnemonic = params["mnemonic"] as? String else {
            return result(FlutterError(code: "Ton.generateKeypairFromBip39Mnemonic", message: "Missing mnemonic", details: nil))
        }
        
        do {
            let keyPair = try tonClient.generateKeypairFromBip39Mnemonic(mnemonic: mnemonic)
            result(["pk": keyPair.pk, "sk": keyPair.sk])
        } catch {
            result(FlutterError(code: "Ton.generateKeypairFromBip39Mnemonic", message: error.localizedDescription, details: nil))
        }
    }
    
    private func getAddressFromKeypair(params: [String: Any], result: FlutterResult) {
        guard
            let sk = params["sk"] as? String,
            let pk = params["pk"] as? String
        else {
            return result(FlutterError(code: "Ton.getAddressFromKeypair", message: "Missing sk or pk", details: nil))
        }
        
        do {
            let keyPair = Keypair(sk: sk, pk: pk)
            let identity = try tonClient.getAddressFromKeypair(keypair: keyPair)
            result([
                "friendlyEq": identity.friendly,
                "rawHex": identity.rawHex,
                "workchain": String(identity.workchain)
            ])
        } catch {
            result(FlutterError(code: "Ton.getAddressFromKeypair", message: error.localizedDescription, details: nil))
        }
    }
    
    private func signData(params: [String: Any], result: FlutterResult) {
        guard
            let text = params["text"] as? String,
            let sk = params["sk"] as? String,
            let pk = params["pk"] as? String
        else {
            return result(FlutterError(code: "Ton.signData", message: "Missing text/sk/pk", details: nil))
        }
        do {
            let keyPair = Keypair(sk: sk, pk: pk)
            let response = try tonClient.signData(text: text, keypair: keyPair)
            result(response)
        } catch {
            result(FlutterError(code: "Ton.signData", message: error.localizedDescription, details: nil))
        }
    }
    
    private func sendMessage(params: [String: Any], result: @escaping FlutterResult) {
        guard
            let networkId = params["networkId"] as? String,
            let from = params["from"] as? String,
            let validUntil = params["validUntil"] as? Int,
            let messages = params["messages"] as? [[String: Any]],
            let sk = params["sk"] as? String,
            let pk = params["pk"] as? String
        else {
            return result(FlutterError(code: "Ton.sendMessage", message: "Missing required fields", details: nil))
        }
        
        Task {
            do {
                let keyPair = Keypair(sk: sk, pk: pk)
                let txMessages = messages.toSendTxMessageList()
                let response = try await self.tonClient.sendMessage(
                    network: networkId,
                    from: from,
                    keypair: keyPair,
                    validUntil: UInt32(validUntil),
                    messages: txMessages
                )
                result(response)
            } catch {
                result(FlutterError(code: "Ton.sendMessage", message: error.localizedDescription, details: nil))
            }
        }
    }
    
    private func broadcastMessage(params: [String: Any], result: @escaping FlutterResult) {
        guard
            let from = params["from"] as? String,
            let validUntil = params["validUntil"] as? UInt,
            let messages = params["messages"] as? [[String: Any]],
            let sk = params["sk"] as? String,
            let pk = params["pk"] as? String
        else {
            return result(FlutterError(code: "Ton.broadcastMessage", message: "Missing required fields", details: nil))
        }
        
        Task {
            do {
                let keyPair = Keypair(sk: sk, pk: pk)
                let txMessages = messages.toSendTxMessageList()
                let response = try await self.tonClient.broadcastMessage(
                    from: from,
                    keypair: keyPair,
                    validUntil: UInt32(validUntil),
                    messages: txMessages
                )
                result(response)
            } catch {
                result(FlutterError(code: "Ton.broadcastMessage", message: error.localizedDescription, details: nil))
            }
        }
    }
    
    private func dispose() {
        print("🧹 Disposing TonClient for network \(networkId)")
    }
    
    // MARK: - Static instance manager
    
    private static var clients: [String: Ton] = [:]
    
    static func initialize(_ params: Any, result: @escaping FlutterResult) {
        guard let dict = params as? [String: Any] else {
            result(FlutterError(code: "Ton.initialize", message: "Invalid parameters: not a map", details: params))
            return
        }
        
        guard
            let networkId = dict["networkId"] as? String,
            let projectId = dict["projectId"] as? String,
            let pulseMetadataDict = dict["pulseMetadata"] as? [String: Any],
            let sdkVersion = pulseMetadataDict["sdkVersion"] as? String,
            let sdkPlatform = pulseMetadataDict["sdkPlatform"] as? String
        else {
            result(FlutterError(code: "Ton.initialize", message: "Missing required fields", details: dict))
            return
        }
        
        let url = pulseMetadataDict["url"] as? String
        let bundleId = pulseMetadataDict["bundleId"] as? String
        
        let pulseMetadata = PulseMetadata(url: url,
                                          bundleId: bundleId ?? Bundle.main.bundleIdentifier,
                                          sdkVersion: sdkVersion,
                                          sdkPlatform: sdkPlatform)
        
        let ton = Ton(projectId: projectId, networkId: networkId, pulseMetadata: pulseMetadata)
        clients[networkId] = ton
        result(true)
    }
    
    private static func getClient(for networkId: String, result: FlutterResult) -> Ton? {
        guard let client = clients[networkId] else {
            result(FlutterError(code: "TonClient", message: "networkId '\(networkId)' not found", details: nil))
            return nil
        }
        return client
    }
    
    // MARK: - Static entrypoints
    
    public static func generateKeypair(_ params: Any, result: @escaping FlutterResult) {
        guard let dict = params as? [String: Any],
              let networkId = dict["networkId"] as? String else {
            result(FlutterError(code: "Ton.generateKeypair", message: "Invalid parameters", details: params))
            return
        }
        
        guard let client = getClient(for: networkId, result: result) else {
            result(FlutterError(code: "Ton.generateKeypair", message: "TonClient for networkId \(networkId) not found", details: nil))
            return
        }
        
        client.generateKeypair(result: result)
    }
    
    public static func generateKeypairFromTonMnemonic(_ params: Any, result: FlutterResult) {
        guard let dict = params as? [String: Any],
              let networkId = dict["networkId"] as? String else {
            result(FlutterError(code: "Ton.generateKeypairFromTonMnemonic", message: "Invalid parameters", details: params))
            return
        }
        
        guard let client = getClient(for: networkId, result: result) else {
            result(FlutterError(code: "Ton.generateKeypairFromTonMnemonic", message: "TonClient for networkId \(networkId) not found", details: nil))
            return
        }
        
        client.generateKeypairFromTonMnemonic(params: dict, result: result)
    }
    
    public static func generateKeypairFromBip39Mnemonic(_ params: Any, result: FlutterResult) {
        guard let dict = params as? [String: Any],
              let networkId = dict["networkId"] as? String else {
            result(FlutterError(code: "Ton.generateKeypairFromBip39Mnemonic", message: "Invalid parameters", details: params))
            return
        }
        
        guard let client = getClient(for: networkId, result: result) else {
            result(FlutterError(code: "Ton.generateKeypairFromBip39Mnemonic", message: "TonClient for networkId \(networkId) not found", details: nil))
            return
        }
        
        client.generateKeypairFromBip39Mnemonic(params: dict, result: result)
    }
    
    public static func getAddressFromKeypair(_ params: Any, result: @escaping FlutterResult) {
        guard let dict = params as? [String: Any],
              let networkId = dict["networkId"] as? String else {
            result(FlutterError(code: "Ton.getAddressFromKeypair", message: "Invalid parameters", details: params))
            return
        }
        
        guard let client = getClient(for: networkId, result: result) else {
            result(FlutterError(code: "Ton.getAddressFromKeypair", message: "TonClient for networkId \(networkId) not found", details: nil))
            return
        }
        
        client.getAddressFromKeypair(params: dict, result: result)
    }
    
    public static func signData(_ params: Any, result: @escaping FlutterResult) {
        guard let dict = params as? [String: Any],
              let networkId = dict["networkId"] as? String else {
            result(FlutterError(code: "Ton.signData", message: "Invalid parameters", details: params))
            return
        }
        
        guard let client = getClient(for: networkId, result: result) else {
            result(FlutterError(code: "Ton.signData", message: "TonClient for networkId \(networkId) not found", details: nil))
            return
        }
        
        client.signData(params: dict, result: result)
    }
    
    public static func sendMessage(_ params: Any, result: @escaping FlutterResult) {
        guard let dict = params as? [String: Any],
              let networkId = dict["networkId"] as? String else {
            result(FlutterError(code: "Ton.sendMessage", message: "Invalid parameters", details: params))
            return
        }
        
        guard let client = getClient(for: networkId, result: result) else {
            result(FlutterError(code: "Ton.sendMessage", message: "TonClient for networkId \(networkId) not found", details: nil))
            return
        }
        
        client.sendMessage(params: dict, result: result)
    }
    
    public static func broadcastMessage(_ params: Any, result: @escaping FlutterResult) {
        guard let dict = params as? [String: Any],
              let networkId = dict["networkId"] as? String else {
            result(FlutterError(code: "Ton.broadcastMessage", message: "Invalid parameters", details: params))
            return
        }
        
        guard let client = getClient(for: networkId, result: result) else {
            result(FlutterError(code: "Ton.broadcastMessage", message: "TonClient for networkId \(networkId) not found", details: nil))
            return
        }
        
        client.broadcastMessage(params: dict, result: result)
    }
    
    public static func dispose(_ params: Any, result: @escaping FlutterResult) {
        guard let dict = params as? [String: Any],
              let networkId = dict["networkId"] as? String else {
            result(FlutterError(code: "Ton.dispose", message: "Invalid parameters", details: params))
            return
        }
        
        guard let client = getClient(for: networkId, result: result) else {
            result(FlutterError(code: "Ton.dispose", message: "TonClient for networkId \(networkId) not found", details: nil))
            return
        }
        
        client.dispose()
        clients.removeValue(forKey: networkId)
        
        result(true)
    }
}
