import Flutter
import Foundation
import YttriumWrapper

class WalletConnectPayClient {
    private static var walletConnectPayClient: WalletConnectPayJson?
    
    static func initialize(params: Any?, result: @escaping FlutterResult) {
        guard let sdkConfig = params as? String else {
            result(FlutterError(code: "PayError", message: "Invalid init parameters: \(String(describing: params))", details: nil))
            return
        }
        
        print("🤖 WalletConnectPayClient.initialize sdkConfig: \(sdkConfig)")
        
        do {
            walletConnectPayClient = try WalletConnectPayJson(sdkConfig: sdkConfig)
            result(true)
        } catch let e as ConfigError {
            switch e {
            case .MissingAuth:
                result(FlutterError(code: "MissingAuth", message: e.errorDescription ?? "Missing authentication", details: nil))
            }
        } catch {
            print("🤖 WalletConnectPayClient.initialize ❌: \(error.localizedDescription)")
            result(FlutterError(code: "PayError", message: error.localizedDescription, details: nil))
        }
    }
    
    static func getPaymentOptions(params: Any?, result: @escaping FlutterResult) {
        guard let requestJson = params as? String else {
            result(FlutterError(code: "PayError", message: "Invalid getPaymentOptions parameters: \(String(describing: params))", details: nil))
            return
        }
        
        print("🤖 WalletConnectPayClient.getPaymentOptions requestJson: \(requestJson)")
        
        guard let client = walletConnectPayClient else {
            result(FlutterError(code: "WalletConnectPayClient", message: "Client not initialized. Call initialize first.", details: nil))
            return
        }
        
        Task {
            do {
                let response = try await client.getPaymentOptions(requestJson: requestJson)
                result(response)
            } catch let e as GetPaymentOptionsError {
                switch e {
                case .Http(let message):
                    result(FlutterError(code: "Http", message: message, details: nil))
                case .ComplianceFailed(let message):
                    result(FlutterError(code: "ComplianceFailed", message: message, details: nil))
                case .InternalError(let message):
                    result(FlutterError(code: "InternalException", message: message, details: nil))
                case .InvalidAccount(let message):
                    result(FlutterError(code: "InvalidAccount", message: message, details: nil))
                case .InvalidRequest(let message):
                    result(FlutterError(code: "InvalidRequest", message: message, details: nil))
                case .OptionNotFound(let message):
                    result(FlutterError(code: "OptionNotFound", message: message, details: nil))
                case .PaymentExpired(let message):
                    result(FlutterError(code: "PaymentExpired", message: message, details: nil))
                case .PaymentNotFound(let message):
                    result(FlutterError(code: "PaymentNotFound", message: message, details: nil))
                case .PaymentNotReady(let message):
                    result(FlutterError(code: "PaymentNotReady", message: message, details: nil))
                }
            } catch {
                print("🤖 WalletConnectPayClient.getPaymentOptions ❌: \(error.localizedDescription)")
                result(FlutterError(code: "PayError", message: error.localizedDescription, details: nil))
            }
        }
    }
    
    static func getRequiredPaymentActions(params: Any?, result: @escaping FlutterResult) {
        guard let requestJson = params as? String else {
            result(FlutterError(code: "PayError", message: "Invalid getRequiredPaymentActions parameters: \(String(describing: params))", details: nil))
            return
        }
        
        print("🤖 WalletConnectPayClient.getRequiredPaymentActions requestJson: \(requestJson)")
        
        guard let client = walletConnectPayClient else {
            result(FlutterError(code: "WalletConnectPayClient", message: "Client not initialized. Call initialize first.", details: nil))
            return
        }
        
        Task {
            do {
                let response = try await client.getRequiredPaymentActions(requestJson: requestJson)
                result(response)
            } catch let e as GetPaymentRequestError {
                switch e {
                case .Http(let message):
                    result(FlutterError(code: "Http", message: message, details: nil))
                case .FetchError(let message):
                    result(FlutterError(code: "FetchException", message: message, details: nil))
                case .InternalError(let message):
                    result(FlutterError(code: "InternalException", message: message, details: nil))
                case .InvalidAccount(let message):
                    result(FlutterError(code: "InvalidAccount", message: message, details: nil))
                case .OptionNotFound(let message):
                    result(FlutterError(code: "OptionNotFound", message: message, details: nil))
                case .PaymentNotFound(let message):
                    result(FlutterError(code: "PaymentNotFound", message: message, details: nil))
                }
            } catch {
                print("🤖 WalletConnectPayClient.getRequiredPaymentActions ❌: \(error.localizedDescription)")
                result(FlutterError(code: "PayError", message: error.localizedDescription, details: nil))
            }
        }
    }
    
    static func confirmPayment(params: Any?, result: @escaping FlutterResult) {
        guard let requestJson = params as? String else {
            result(FlutterError(code: "PayError", message: "Invalid confirmPayment parameters: \(String(describing: params))", details: nil))
            return
        }
        
        print("🤖 WalletConnectPayClient.confirmPayment requestJson: \(requestJson)")
        
        guard let client = walletConnectPayClient else {
            result(FlutterError(code: "WalletConnectPayClient", message: "Client not initialized. Call initialize first.", details: nil))
            return
        }
        
        Task {
            do {
                let response = try await client.confirmPayment(requestJson: requestJson)
                result(response)
            } catch let e as ConfirmPaymentError {
                switch e {
                case .Http(let message):
                    result(FlutterError(code: "Http", message: message, details: nil))
                case .InternalError(let message):
                    result(FlutterError(code: "InternalException", message: message, details: nil))
                case .InvalidOption(let message):
                    result(FlutterError(code: "InvalidOption", message: message, details: nil))
                case .InvalidSignature(let message):
                    result(FlutterError(code: "InvalidSignature", message: message, details: nil))
                case .PaymentExpired(let message):
                    result(FlutterError(code: "PaymentExpired", message: message, details: nil))
                case .PaymentNotFound(let message):
                    result(FlutterError(code: "PaymentNotFound", message: message, details: nil))
                case .RouteExpired(let message):
                    result(FlutterError(code: "RouteExpired", message: message, details: nil))
                case .UnsupportedMethod(let message):
                    result(FlutterError(code: "UnsupportedMethod", message: message, details: nil))
                }
            } catch {
                print("🤖 WalletConnectPayClient.confirmPayment ❌: \(error.localizedDescription)")
                result(FlutterError(code: "PayError", message: error.localizedDescription, details: nil))
            }
        }
    }
}
