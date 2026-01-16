import Flutter
import Foundation
import YttriumWrapper

class WalletConnectPayClient {
    private static var walletConnectPayClient: WalletConnectPayJson?
    
    static func initialize(params: Any?, result: @escaping FlutterResult) {
        guard let sdkConfig = params as? String else {
            result(FlutterError(
                code: "WalletConnectPay.initialize",
                message: "Invalid parameters: \(String(describing: params))",
                details: nil
            ))
            return
        }
        
        print("🤖 WalletConnectPayClient.initialize sdkConfig: \(sdkConfig)")
        
        do {
            walletConnectPayClient = try WalletConnectPayJson(sdkConfig: sdkConfig)
            result(true)
        } catch {
            print("🤖 WalletConnectPayClient.initialize ❌: \(error.localizedDescription)")
            result(FlutterError(
                code: "WalletConnectPayClient",
                message: "initialize error: \(error.localizedDescription)",
                details: nil
            ))
        }
    }
    
    static func getPaymentOptions(params: Any?, result: @escaping FlutterResult) {
        guard let requestJson = params as? String else {
            result(FlutterError(
                code: "WalletConnectPay.getPaymentOptions",
                message: "Invalid parameters: \(String(describing: params))",
                details: nil
            ))
            return
        }
        
        print("🤖 WalletConnectPayClient.getPaymentOptions requestJson: \(requestJson)")
        
        guard let client = walletConnectPayClient else {
            result(FlutterError(
                code: "WalletConnectPayClient",
                message: "Client not initialized. Call initialize first.",
                details: nil
            ))
            return
        }
        
        Task {
            do {
                let response = try await client.getPaymentOptions(requestJson: requestJson)
                result(response)
            } catch {
                print("🤖 WalletConnectPayClient.getPaymentOptions ❌: \(error.localizedDescription)")
                result(FlutterError(
                    code: "WalletConnectPayClient",
                    message: "getPaymentOptions error: \(error.localizedDescription)",
                    details: nil
                ))
            }
        }
    }
    
    static func getRequiredPaymentActions(params: Any?, result: @escaping FlutterResult) {
        guard let requestJson = params as? String else {
            result(FlutterError(
                code: "WalletConnectPay.getRequiredPaymentActions",
                message: "Invalid parameters: \(String(describing: params))",
                details: nil
            ))
            return
        }
        
        print("🤖 WalletConnectPayClient.getRequiredPaymentActions requestJson: \(requestJson)")
        
        guard let client = walletConnectPayClient else {
            result(FlutterError(
                code: "WalletConnectPayClient",
                message: "Client not initialized. Call initialize first.",
                details: nil
            ))
            return
        }
        
        Task {
            do {
                let response = try await client.getRequiredPaymentActions(requestJson: requestJson)
                result(response)
            } catch {
                print("🤖 WalletConnectPayClient.getRequiredPaymentActions ❌: \(error.localizedDescription)")
                result(FlutterError(
                    code: "WalletConnectPayClient",
                    message: "getRequiredPaymentActions error: \(error.localizedDescription)",
                    details: nil
                ))
            }
        }
    }
    
    static func confirmPayment(params: Any?, result: @escaping FlutterResult) {
        guard let requestJson = params as? String else {
            result(FlutterError(
                code: "WalletConnectPay.confirmPayment",
                message: "Invalid parameters: \(String(describing: params))",
                details: nil
            ))
            return
        }
        
        print("🤖 WalletConnectPayClient.confirmPayment requestJson: \(requestJson)")
        
        guard let client = walletConnectPayClient else {
            result(FlutterError(
                code: "WalletConnectPayClient",
                message: "Client not initialized. Call initialize first.",
                details: nil
            ))
            return
        }
        
        Task {
            do {
                let response = try await client.confirmPayment(requestJson: requestJson)
                result(response)
            } catch {
                print("🤖 WalletConnectPayClient.confirmPayment ❌: \(error.localizedDescription)")
                result(FlutterError(
                    code: "WalletConnectPayClient",
                    message: "confirmPayment error: \(error.localizedDescription)",
                    details: nil
                ))
            }
        }
    }
}
