import Flutter
import UIKit
import YttriumWrapper

public class ReownYttriumPlugin: NSObject, FlutterPlugin {
    struct CustomError: Error {
        let message: String
    }
    
    private var client: ChainAbstractionClient?
    private var pendingPrepareDetailed: [String: UiFields] = [:]
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "reown_yttrium", binaryMessenger: registrar.messenger())
        let instance = ReownYttriumPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "init":
            initialize(call.arguments ?? {}, result: result)
        case "erc20TokenBalance":
            erc20TokenBalance(call.arguments ?? {}, result: result)
        case "estimateFees":
            estimateFees(call.arguments ?? {}, result: result)
        case "prepareDetailed":
            prepareDetailed(call.arguments ?? {}, result: result)
        case "execute":
            execute(call.arguments ?? {}, result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    func initialize(_ params: Any, result: @escaping FlutterResult) {
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
        let pulseMetadata = PulseMetadata(url: url, bundleId: bundleID, sdkVersion: sdkVersion, sdkPlatform: sdkPlatform)
        
        client = ChainAbstractionClient(projectId: projectId, pulseMetadata: pulseMetadata)
        
        result(true)
    }
    
    func erc20TokenBalance(_ params: Any, result: @escaping FlutterResult) {
        print("erc20TokenBalance called with ", params)
        
        guard let dict = params as? [String: Any],
              let chainId = dict["chainId"] as? String,
              let token = dict["token"] as? FfiAddress,  // aka String
              let owner = dict["owner"] as? FfiAddress,
              let client = client else {
            result(FlutterError(code: "erc20TokenBalance", message: "Invalid parameters", details: params))
            return
        }
        
        Task {
            do {
                let balanceResponse = try await client.erc20TokenBalance(chainId: chainId, token: token, owner: owner)
                
                if let balance = balanceResponse as String? {
                    print("balanceResponse", balance)
                    result(balance)
                } else {
                    result(FlutterError(code: "erc20TokenBalance", message: "Response error: balance is nil", details: nil))
                }
            } catch {
                result(FlutterError(code: "erc20TokenBalance", message: error.localizedDescription, details: nil))
            }
        }
    }
    
    func estimateFees(_ params: Any, result: @escaping FlutterResult) {
        print("estimateFees called with ", params)
        
        guard let dict = params as? [String: Any],
              let chainId = dict["chainId"] as? String,
              let client = client else {
            result(FlutterError(code: "estimateFees", message: "Invalid parameters", details: params))
            return
        }
        
        Task {
            do {
                let feesResponse = try await client.estimateFees(chainId: chainId)
                
                if let fees = feesResponse as Eip1559Estimation? {
                    print("feesResponse", fees)
                    result(fees.toJson())
                } else {
                    result(FlutterError(code: "estimateFees", message: "Response error: fees is nil", details: nil))
                }
            } catch {
                result(FlutterError(code: "estimateFees", message: error.localizedDescription, details: nil))
            }
        }
    }
    
    func prepareDetailed(_ params: Any, result: @escaping FlutterResult) {
        print("prepareDetailed called with ", params)
        
        guard let dict = params as? [String: Any],
              let chainId = dict["chainId"] as? String,
              let from = dict["from"] as? String,
              let accounts = dict["accounts"] as? [String],
              let useLifi = dict["useLifi"] as? Bool,
              let call = dict["call"] as? [String: Any],
              let to = call["to"] as? String,  // Address (String)
              let value = call["value"] as? String,  // U256 (String)
              let input = call["input"] as? String,  // Bytes (String)
              let localCurrency = dict["localCurrency"] as? String,
              let client = client else {
            result(FlutterError(code: "prepareDetailed", message: "Invalid parameters", details: nil))
            return
        }
        
        Task {
            do {
                let currency = Currency.fromString(value: localCurrency)
                let call = Call(to: to, value: value, input: input)
                let prepareResponse = try await client.prepareDetailed(chainId: chainId,
                                                                                       from: from,
                                                                                       call: call,
                                                                                       accounts: accounts,
                                                                                       localCurrency: currency,
                                                                                       useLifi: useLifi)
                
                switch prepareResponse {
                case .success(let successData):
                    switch successData {
                    case .available(let uiFields):
                        pendingPrepareDetailed[uiFields.routeResponse.orchestrationId] = uiFields
                        result(["available": uiFields.toJson()])
                    case .notRequired(let prepareResponseNotRequired):
                        result(["notRequired": prepareResponseNotRequired.toJson()])
                    }
                case .error(let errorData):
                    result(errorData.toJson())
                }
            } catch {
                result(FlutterError(code: "prepareDetailed", message: error.localizedDescription, details: nil))
            }
        }
    }
    
    func execute(_ params: Any, result: @escaping FlutterResult) {
        print("execute called with ", params)
        
        guard let dict = params as? [String: Any],
              let orchestrationId = dict["orchestrationId"] as? String,
              let rawSigs = dict["routeTxnSigs"] as? [Any],
              let initialTxnSig = dict["initialTxnSig"] as? String,
              let client = client else {
            result(FlutterError(code: "execute", message: "Invalid parameters", details: params))
            return
        }
        
        Task {
            do {
                guard let uiFields = pendingPrepareDetailed[orchestrationId] else {
                    throw CustomError(message: "prepareDetailed result not found, try again")
                }
                
                // Try converting to [RouteSig]
                let routeTxnSigs: [RouteSig] = rawSigs.compactMap { $0 as? RouteSig }
                if routeTxnSigs.count != rawSigs.count {
                    result(FlutterError(code: "execute", message: "Invalid item(s) in routeTxnSigs", details: params))
                    return
                }

                
                
                let executeResponse = try await client.execute(uiFields: uiFields,
                                                               routeTxnSigs: routeTxnSigs,
                                                               initialTxnSig: initialTxnSig)
                
                pendingPrepareDetailed.removeValue(forKey: orchestrationId)
                
                let jsonResponse = executeResponse.toJson()
                print("execute success", jsonResponse)
                result(jsonResponse)
            } catch {
                result(FlutterError(code: "execute", message: error.localizedDescription, details: nil))
            }
        }
    }
    
}
