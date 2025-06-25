import Flutter
import UIKit
import YttriumWrapper

class Stacks {
    static var stacksClient: StacksClient?
    
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
        
        stacksClient = StacksClient(projectId: projectId,
                                    pulseMetadata: pulseMetadata)
        
        result(true)
    }
    
    static func generateWallet(result: @escaping FlutterResult) {
        let response = stacksGenerateWallet()
        result(response)
    }
    
    static func getAddress(_ params: Any, result: @escaping FlutterResult) {
        guard let dict = params as? [String: Any],
              let wallet = dict["wallet"] as? String,
              let version = dict["version"] as? String else {
            result(FlutterError(code: "Stacks.getAddress", 
                             message: "Invalid parameters \(params)", 
                             details: nil))
            return
        }
        
        do {
            let address = try stacksGetAddress(wallet: wallet,
                                               version: version)
            result(address)
        } catch {
            result(FlutterError(code: "Stacks.getAddress", 
                             message: error.localizedDescription, 
                             details: nil))
        }
    }
    
    static func signMessage(_ params: Any, result: @escaping FlutterResult) {
        print("signMessage called with", params)
        
        guard let dict = params as? [String: Any],
              let wallet = dict["wallet"] as? String,
              let message = dict["message"] as? String else {
            result(FlutterError(code: "Stacks.signMessage", 
                             message: "Invalid parameters \(params)", 
                             details: nil))
            return
        }
        
        do {
            let signature = try stacksSignMessage(wallet: wallet,
                                                  message: message)
            result(signature)
        } catch {
            result(FlutterError(code: "Stacks.signMessage", 
                             message: error.localizedDescription, 
                             details: nil))
        }
    }
    
    static func transferStx(_ params: Any, result: @escaping FlutterResult) {
        print("transferStx called with", params)
        
        guard stacksClient != nil else {
            result(FlutterError(code: "Stacks.transferStx", 
                             message: "StacksClient not initialized", 
                             details: nil))
            return
        }
        
        guard let dict = params as? [String: Any],
              let wallet = dict["wallet"] as? String,
              let network = dict["network"] as? String,
              let request = dict["request"] as? [String: Any],
              let amount = request["amount"] as? String,
              let recipient = request["recipient"] as? String else {
            result(FlutterError(code: "Stacks.transferStx", 
                             message: "Invalid parameters \(params)", 
                             details: nil))
            return
        }
        
        Task {
            do {
                let memo = request["memo"] as? String ?? ""
                let amountValue = UInt64(amount)!
                let transferRequest = TransferStxRequest(amount: amountValue,
                                                         recipient: recipient,
                                                         memo: memo)
                
                let response = try await stacksClient!.transferStx(wallet: wallet,
                                                                   network: network,
                                                                   request: transferRequest)
                result([
                    "transaction": response.transaction,
                    "txid": response.txid
                ])
            } catch {
                result(FlutterError(code: "Stacks.transferStx",
                                    message: error.localizedDescription,
                                    details: nil))
            }
        }
    }
}
