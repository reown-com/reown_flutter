import Flutter
import UIKit
import YttriumUtilsWrapper

/**
 * Solana.swift
 *
 * Thin wrapper around the yttrium-utils Solana UniFFI free functions
 * (no per-network client state).
 */
class Solana {
    static func generateKeyPair(_ params: Any, result: @escaping FlutterResult) {
        result(solanaGenerateKeypair())
    }

    static func getPublicKey(_ params: Any, result: @escaping FlutterResult) {
        guard let dict = params as? [String: Any],
              let keyPair = dict["keyPair"] as? String else {
            result(FlutterError(code: "Solana.getPublicKey", message: "Invalid parameters", details: params))
            return
        }
        do {
            result(try solanaPubkeyForKeypair(keypair: keyPair))
        } catch {
            result(FlutterError(code: "Solana.getPublicKey", message: error.localizedDescription, details: nil))
        }
    }

    static func signTransaction(_ params: Any, result: @escaping FlutterResult) {
        guard let dict = params as? [String: Any],
              let keyPair = dict["keyPair"] as? String,
              let transaction = dict["transaction"] as? String else {
            result(FlutterError(code: "Solana.signTransaction", message: "Invalid parameters", details: params))
            return
        }
        do {
            let signed = try solanaSignTransaction(keypair: keyPair, transaction: transaction)
            result([
                "transaction": signed.transaction,
                "signature": signed.signature,
            ])
        } catch {
            result(FlutterError(code: "Solana.signTransaction", message: error.localizedDescription, details: nil))
        }
    }

    static func signAllTransactions(_ params: Any, result: @escaping FlutterResult) {
        guard let dict = params as? [String: Any],
              let keyPair = dict["keyPair"] as? String,
              let transactions = dict["transactions"] as? [String] else {
            result(FlutterError(code: "Solana.signAllTransactions", message: "Invalid parameters", details: params))
            return
        }
        do {
            let signed = try solanaSignAllTransactions(keypair: keyPair, transactions: transactions)
            result(signed.map { ["transaction": $0.transaction, "signature": $0.signature] })
        } catch {
            result(FlutterError(code: "Solana.signAllTransactions", message: error.localizedDescription, details: nil))
        }
    }

    static func signMessage(_ params: Any, result: @escaping FlutterResult) {
        guard let dict = params as? [String: Any],
              let keyPair = dict["keyPair"] as? String,
              let messageData = dict["message"] as? FlutterStandardTypedData else {
            result(FlutterError(code: "Solana.signMessage", message: "Invalid parameters", details: params))
            return
        }
        // Yttrium's UniFFI `Bytes` custom type lifts from a `0x`-prefixed hex
        // string (see uniffi::custom_type!(Bytes, String, ...)).
        let hexMessage = "0x" + messageData.data.map { String(format: "%02x", $0) }.joined()
        result(solanaSignMessage(keypair: keyPair, message: hexMessage))
    }
}
