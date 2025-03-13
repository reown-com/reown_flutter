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
        let dict = params as? [String: Any]
        
        if let projectId = dict?["projectId"] as? String,
           let pulseMetadata = dict?["pulseMetadata"] as? [String: Any],
           let url = pulseMetadata["url"] as? String,
           let bundleId = pulseMetadata["bundleId"] as? String,
           let sdkVersion = pulseMetadata["sdkVersion"] as? String,
           let sdkPlatform = pulseMetadata["sdkPlatform"] as? String {
            let bundleID = Bundle.main.bundleIdentifier ?? bundleId
            let pulseMetadata = PulseMetadata(url: url, bundleId: bundleID, sdkVersion: sdkVersion, sdkPlatform: sdkPlatform)
            client = ChainAbstractionClient(projectId: projectId, pulseMetadata: pulseMetadata)
            result(true)
        } else {
            result(FlutterError(code: "initialize", message: "invalid params", details: nil))
        }
    }
    
    func erc20TokenBalance(_ params: Any, result: @escaping FlutterResult) {
        print("erc20TokenBalance called with ", params)
        let dict = params as? [String: Any]
        
        if let chainId = dict?["chainId"] as? String,
           let token = dict?["token"] as? FfiAddress, // aka String
           let owner = dict?["owner"] as? FfiAddress {
            
            Task {
                do {
                    let balanceResponse = try await client?.erc20TokenBalance(chainId: chainId, token: token, owner: owner)
                    print("balanceResponse", balanceResponse ?? "")
                    result(balanceResponse)
                    if (balanceResponse != nil) {
                        result(balanceResponse!)
                    } else {
                        result(FlutterError(code: "erc20TokenBalance", message: "response error", details: balanceResponse))
                    }
                } catch {
                    result(FlutterError(code: "erc20TokenBalance", message: error.localizedDescription, details: nil))
                }
            }
        } else {
            result(FlutterError(code: "erc20TokenBalance", message: "invalid params", details: nil))
        }
    }
    
    func estimateFees(_ params: Any, result: @escaping FlutterResult) {
        print("erc20TokenBalance called with ", params)
        let dict = params as? [String: Any]
        
        if let chainId = dict?["chainId"] as? String {
            Task {
                do {
                    let feesResponse = try await client?.estimateFees(chainId: chainId)
                    print("feesResponse", feesResponse ?? "")
                    if (feesResponse != nil) {
                        result(feesResponse!.toMap())
                    } else {
                        result(FlutterError(code: "estimateFees", message: "response error", details: feesResponse))
                    }
                } catch {
                    result(FlutterError(code: "estimateFees", message: error.localizedDescription, details: nil))
                }
            }
        } else {
            result(FlutterError(code: "estimateFees", message: "invalid params", details: nil))
        }
    }
    
    func prepareDetailed(_ params: Any, result: @escaping FlutterResult) {
        print("prepareDetailed called with ", params)
        let dict = params as? [String: Any]
        
        if let chainId = dict?["chainId"] as? String,
           let from = dict?["from"] as? String,
           let call = dict?["call"] as? [String: Any],
           let to = call["to"] as? Address, // aka String
           let value = call["value"] as? U256, // aka String
           let input = call["input"] as? Bytes, // aka String
           let localCurrency = dict?["localCurrency"] as? String {
            
            print("created client, checking route...")
            Task {
                do {
                    let currency = Currency.fromString(value: localCurrency)
                    let call = Call(to: to, value: value, input: input)
                    let prepareResponse = try await client?.prepareDetailed(chainId: chainId,
                                                                            from: from,
                                                                            call: call,
                                                                            localCurrency: currency)
                    
                    switch prepareResponse {
                    case .success(let successData):
                        if case .available(let uiFields) = successData {
                            pendingPrepareDetailed[uiFields.routeResponse.orchestrationId] = uiFields
                            result(["available": uiFields.toJson()])
                        } else if case .notRequired(let prepareResponseNotRequired) = successData {
                            result(["notRequired": prepareResponseNotRequired.toJson()])
                        } else {
                            result(FlutterError(code: "prepareDetailed", message: "response error (.success)", details: nil))
                        }
                    case .error(let errorData):
                        result(errorData.toJson())
                    case .none:
                        result(FlutterError(code: "prepareDetailed", message: "response error (.none)", details: nil))
                    }
                } catch {
                    result(FlutterError(code: "prepareDetailed", message: error.localizedDescription, details: nil))
                }
            }
        } else {
            result(FlutterError(code: "prepareDetailed", message: "invalid params", details: nil))
        }
    }
    
    func execute(_ params: Any, result: @escaping FlutterResult) {
        print("execute called with ", params)
        let dict = params as? [String: Any]
        
        
        if let orchestrationId = dict?["orchestrationId"] as? String,
           let routeTxnSigs = dict?["routeTxnSigs"] as? Array<String>,
           let initialTxnSig = dict?["initialTxnSig"] as? String {
            
            Task {
                do {
                    guard let uiFields = pendingPrepareDetailed[orchestrationId] else {
                        throw CustomError(message: "prepareDetailed result not found, try again")
                    }
                    
                    let executeResponse = try await client?.execute(uiFields: uiFields,
                                                           routeTxnSigs: routeTxnSigs,
                                                           initialTxnSig: initialTxnSig)
                    pendingPrepareDetailed.removeValue(forKey: orchestrationId)
                    print("execute success", executeResponse!.toMap())
                    result(executeResponse!.toMap())
                } catch {
                    result(FlutterError(code: "execute", message: error.localizedDescription, details: nil))
                }
            }
        } else {
            result(FlutterError(code: "execute", message: "invalid params", details: params))
        }
    }
    
}
