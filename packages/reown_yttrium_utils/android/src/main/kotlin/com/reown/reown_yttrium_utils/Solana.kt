package com.reown.reown_yttrium_utils

import android.annotation.SuppressLint
import android.util.Log
import io.flutter.plugin.common.MethodChannel
import uniffi.yttrium_utils.solanaGenerateKeypair
import uniffi.yttrium_utils.solanaPubkeyForKeypair
import uniffi.yttrium_utils.solanaSignAllTransactions
import uniffi.yttrium_utils.solanaSignMessage
import uniffi.yttrium_utils.solanaSignTransaction

/**
 * Solana.kt
 *
 * Thin wrapper around the yttrium-utils Solana UniFFI free functions
 * (no per-network client state).
 */
object Solana {

    fun generateKeyPair(result: MethodChannel.Result) {
        try {
            result.success(solanaGenerateKeypair())
        } catch (e: Exception) {
            result.error("Solana.generateKeyPair", e.message, null)
        }
    }

    @SuppressLint("LongLogTag")
    fun getPublicKey(params: Any?, result: MethodChannel.Result) {
        val dict = params as? Map<*, *>
            ?: return result.error("Solana.getPublicKey", "Invalid parameters", null)
        val keyPair = dict["keyPair"] as? String
            ?: return errorMissing("keyPair", params, result)
        try {
            result.success(solanaPubkeyForKeypair(keyPair))
        } catch (e: Exception) {
            result.error("Solana.getPublicKey", e.message, null)
        }
    }

    fun signTransaction(params: Any?, result: MethodChannel.Result) {
        val dict = params as? Map<*, *>
            ?: return result.error("Solana.signTransaction", "Invalid parameters", null)
        val keyPair = dict["keyPair"] as? String
            ?: return errorMissing("keyPair", params, result)
        val transaction = dict["transaction"] as? String
            ?: return errorMissing("transaction", params, result)
        try {
            val signed = solanaSignTransaction(keyPair, transaction)
            result.success(
                mapOf(
                    "transaction" to signed.transaction,
                    "signature" to signed.signature,
                )
            )
        } catch (e: Exception) {
            Log.e("🤖 Solana.signTransaction", e.message ?: "unknown")
            result.error("Solana.signTransaction", e.message, null)
        }
    }

    fun signAllTransactions(params: Any?, result: MethodChannel.Result) {
        val dict = params as? Map<*, *>
            ?: return result.error("Solana.signAllTransactions", "Invalid parameters", null)
        val keyPair = dict["keyPair"] as? String
            ?: return errorMissing("keyPair", params, result)
        @Suppress("UNCHECKED_CAST")
        val transactions = dict["transactions"] as? List<String>
            ?: return errorMissing("transactions", params, result)
        try {
            val signed = solanaSignAllTransactions(keyPair, transactions)
            result.success(
                signed.map { mapOf("transaction" to it.transaction, "signature" to it.signature) }
            )
        } catch (e: Exception) {
            Log.e("🤖 Solana.signAllTransactions", e.message ?: "unknown")
            result.error("Solana.signAllTransactions", e.message, null)
        }
    }

    fun signMessage(params: Any?, result: MethodChannel.Result) {
        val dict = params as? Map<*, *>
            ?: return result.error("Solana.signMessage", "Invalid parameters", null)
        val keyPair = dict["keyPair"] as? String
            ?: return errorMissing("keyPair", params, result)
        val message = dict["message"] as? ByteArray
            ?: return errorMissing("message", params, result)
        try {
            // Yttrium's UniFFI `Bytes` custom type lifts from a `0x`-prefixed
            // hex string (see uniffi::custom_type!(Bytes, String, ...)).
            val hexMessage = "0x" + message.joinToString("") { "%02x".format(it) }
            result.success(solanaSignMessage(keyPair, hexMessage))
        } catch (e: Exception) {
            result.error("Solana.signMessage", e.message, null)
        }
    }
}
