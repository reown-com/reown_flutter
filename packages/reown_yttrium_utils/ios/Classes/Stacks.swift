import Flutter
import UIKit
import YttriumUtilsWrapper

/**
 * Stacks.swift
 *
 * Supports multiple StacksClient instances (e.g. mainnet, testnet).
 * Uses networkId ("stx:mainnet", "stx:testnet", etc.) to identify each client.
 */
class Stacks {
    private let stacksClient: StacksClient
    private let networkId: String
    
    init(projectId: String, networkId: String, pulseMetadata: PulseMetadata) {
        self.networkId = networkId
        self.stacksClient = StacksClient(projectId: projectId, pulseMetadata: pulseMetadata)
    }
    
    // ==== INSTANCE METHODS ====
    
    func generateWallet(result: @escaping FlutterResult) {
        let response = stacksGenerateWallet()
        result(response)
    }
    
    func getAddress(_ params: [String: Any], result: @escaping FlutterResult) {
        guard let wallet = params["wallet"] as? String,
              let version = params["version"] as? String else {
            result(FlutterError(code: "Stacks.getAddress", message: "Invalid parameters \(params)", details: nil))
            return
        }
        
        do {
            let address = try stacksGetAddress(wallet: wallet, version: version)
            result(address)
        } catch {
            result(FlutterError(code: "Stacks.getAddress", message: error.localizedDescription, details: nil))
        }
    }
    
    func signMessage(_ params: [String: Any], result: @escaping FlutterResult) {
        guard let wallet = params["wallet"] as? String,
              let message = params["message"] as? String else {
            result(FlutterError(code: "Stacks.signMessage", message: "Invalid parameters \(params)", details: nil))
            return
        }
        
        do {
            let signature = try stacksSignMessage(wallet: wallet, message: message)
            result(signature)
        } catch {
            result(FlutterError(code: "Stacks.signMessage", message: error.localizedDescription, details: nil))
        }
    }
    
    func transferStx(_ params: [String: Any], result: @escaping FlutterResult) {
        guard
            let wallet = params["wallet"] as? String,
            let request = params["request"] as? [String: Any],
            let amount = request["amount"] as? String,
            let sender = request["sender"] as? String,
            let recipient = request["recipient"] as? String else {
            result(FlutterError(code: "Stacks.transferStx", message: "Invalid parameters \(params)", details: nil))
            return
        }
        
        Task {
            do {
                let memo = request["memo"] as? String ?? ""
                let amountValue = UInt64(amount)!
                let transferRequest = TransferStxRequest(sender: sender, amount: amountValue, recipient: recipient, memo: memo)
                
                let response = try await self.stacksClient.transferStx(wallet: wallet, network: networkId, request: transferRequest)
                result([
                    "transaction": response.transaction,
                    "txid": response.txid.hasPrefix("0x") ? response.txid : "0x" + response.txid
                ])
            } catch {
                Stacks.parseException("Stacks.transferStx", error, result: result)
            }
        }
    }
    
    func getAccount(_ params: [String: Any], result: @escaping FlutterResult) {
        guard
            let principal = params["principal"] as? String else {
            result(FlutterError(code: "Stacks.getAccount", message: "Invalid parameters \(params)", details: nil))
            return
        }
        
        Task {
            do {
                let response = try await stacksClient.getAccount(network: networkId, principal: principal)
                result([
                    "balance": response.balance,
                    "locked": response.locked,
                    "unlock_height": "\(response.unlockHeight)",
                    "nonce": "\(response.nonce)",
                    "balance_proof": response.balanceProof,
                    "nonce_proof": response.nonceProof
                ])
            } catch {
                Stacks.parseException("Stacks.getAccount", error, result: result)
            }
        }
    }
    
    func transferFeeRate(_ params: [String: Any], result: @escaping FlutterResult) {
        guard let network = params["network"] as? String else {
            result(FlutterError(code: "Stacks.transferFeeRate", message: "Invalid parameters \(params)", details: nil))
            return
        }
        
        Task {
            do {
                let response = try await stacksClient.transferFees(network: network)
                result("\(response)")
            } catch {
                Stacks.parseException("Stacks.transferFeeRate", error, result: result)
            }
        }
    }
    
    func dispose() {
        print("🤖 Disposing StacksClient for networkId: \(networkId)")
    }
    
    // ==== STATIC REGISTRY ====
    
    private static var clients: [String: Stacks] = [:]
    
    static func initialize(_ params: Any, result: @escaping FlutterResult) {
        guard let dict = params as? [String: Any],
              let projectId = dict["projectId"] as? String,
              let networkId = dict["networkId"] as? String,
              let pulseMetadataDict = dict["pulseMetadata"] as? [String: Any],
              let sdkVersion = pulseMetadataDict["sdkVersion"] as? String,
              let sdkPlatform = pulseMetadataDict["sdkPlatform"] as? String else {
            result(FlutterError(code: "Stacks.initialize", message: "Missing required fields", details: params))
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
        
        let instance = Stacks(projectId: projectId, networkId: networkId, pulseMetadata: pulseMetadata)
        clients[networkId] = instance
        result(true)
    }
    
    private static func getClient(for networkId: String, result: @escaping FlutterResult) -> Stacks? {
        guard let client = clients[networkId] else {
            result(FlutterError(code: "StacksClient", message: "No client found for networkId \(networkId)", details: nil))
            return nil
        }
        return client
    }
    
    // ==== STATIC DISPATCHERS (Flutter entrypoints) ====
    
    static func generateWallet(_ params: Any, result: @escaping FlutterResult) {
        guard let dict = params as? [String: Any],
              let networkId = dict["networkId"] as? String else {
            result(FlutterError(code: "Stacks.generateWallet", message: "Invalid parameters", details: params))
            return
        }
        
        guard let client = getClient(for: networkId, result: result) else {
            result(FlutterError(code: "Stacks.generateWallet", message: "StacksClient for networkId \(networkId) not found", details: nil))
            return
        }
        
        client.generateWallet(result: result)
    }
    
    static func getAddress(_ params: Any, result: @escaping FlutterResult) {
        guard let dict = params as? [String: Any],
              let networkId = dict["networkId"] as? String else {
            result(FlutterError(code: "Stacks.getAddress", message: "Invalid parameters", details: params))
            return
        }
        
        guard let client = getClient(for: networkId, result: result) else {
            result(FlutterError(code: "Stacks.getAddress", message: "StacksClient for networkId \(networkId) not found", details: nil))
            return
        }
        
        client.getAddress(dict, result: result)
    }
    
    static func signMessage(_ params: Any, result: @escaping FlutterResult) {
        guard let dict = params as? [String: Any],
              let networkId = dict["networkId"] as? String else {
            result(FlutterError(code: "Stacks.signMessage", message: "Invalid parameters", details: params))
            return
        }
        
        guard let client = getClient(for: networkId, result: result) else {
            result(FlutterError(code: "Stacks.signMessage", message: "StacksClient for networkId \(networkId) not found", details: nil))
            return
        }
        
        client.signMessage(dict, result: result)
    }
    
    static func transferStx(_ params: Any, result: @escaping FlutterResult) {
        guard let dict = params as? [String: Any],
              let networkId = dict["networkId"] as? String else {
            result(FlutterError(code: "Stacks.transferStx", message: "Invalid parameters", details: params))
            return
        }
        
        guard let client = getClient(for: networkId, result: result) else {
            result(FlutterError(code: "Stacks.transferStx", message: "StacksClient for networkId \(networkId) not found", details: nil))
            return
        }
        
        client.transferStx(dict, result: result)
    }
    
    static func getAccount(_ params: Any, result: @escaping FlutterResult) {
        guard let dict = params as? [String: Any],
              let networkId = dict["networkId"] as? String else {
            result(FlutterError(code: "Stacks.getAccount", message: "Invalid parameters", details: params))
            return
        }
        
        guard let client = getClient(for: networkId, result: result) else {
            result(FlutterError(code: "Stacks.getAccount", message: "StacksClient for networkId \(networkId) not found", details: nil))
            return
        }
        
        client.getAccount(dict, result: result)
    }
    
    static func transferFeeRate(_ params: Any, result: @escaping FlutterResult) {
        guard let dict = params as? [String: Any],
              let networkId = dict["networkId"] as? String else {
            result(FlutterError(code: "Stacks.transferFeeRate", message: "Invalid parameters", details: params))
            return
        }
        
        guard let client = getClient(for: networkId, result: result) else {
            result(FlutterError(code: "Stacks.transferFeeRate", message: "StacksClient for networkId \(networkId) not found", details: nil))
            return
        }
        
        client.transferFeeRate(dict, result: result)
    }
    
    static func dispose(_ params: Any, result: @escaping FlutterResult) {
        guard let dict = params as? [String: Any],
              let networkId = dict["networkId"] as? String else {
            result(FlutterError(code: "Stacks.dispose", message: "Invalid parameters", details: params))
            return
        }
        
        guard let client = getClient(for: networkId, result: result) else {
            result(FlutterError(code: "Stacks.dispose", message: "StacksClient for networkId \(networkId) not found", details: nil))
            return
        }
        
        client.dispose()
        clients.removeValue(forKey: networkId)
        
        result(true)
    }
    
    // ==== ERROR HANDLER ====
    
    static func parseException(_ code: String, _ error: Error, result: @escaping FlutterResult) {
        let message = error.localizedDescription
        
        if message.contains("MemoTooLong") {
            result(FlutterError(code: code, message: "Memo too long: maximum allowed is 34 bytes", details: nil))
        } else if message.contains("TransferFees") {
            result(FlutterError(code: code, message: "Failed to fetch fee rate", details: nil))
        } else if message.contains("FetchAccount") {
            result(FlutterError(code: code, message: "Failed to fetch account", details: nil))
        } else {
            result(FlutterError(code: code, message: message, details: nil))
        }
    }
}
