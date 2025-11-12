package com.reown.reown_yttrium

import android.annotation.SuppressLint
import android.content.Context
import android.util.Log
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import uniffi.yttrium_utils.PulseMetadata
import uniffi.yttrium_utils.StacksClient
import uniffi.yttrium_utils.TransferStxRequest
import uniffi.yttrium_utils.stacksGenerateWallet
import uniffi.yttrium_utils.stacksGetAddress
import uniffi.yttrium_utils.stacksSignMessage
import kotlin.collections.get

/**
 * Stacks.kt
 *
 * Supports multiple StacksClient instances (e.g. mainnet, testnet).
 * Use networkId ("stx:mainnet", "stx:testnet", etc.) to identify each client.
 */
class Stacks(private val projectId: String, private val networkId: String, private val pulseMetadata: PulseMetadata) {
    private val stacksClient: StacksClient = StacksClient(
        projectId = projectId,
        pulseMetadata = pulseMetadata
    )

    // ==== INSTANCE METHODS ====

    fun generateWallet(result: MethodChannel.Result) {
        try {
            val response = stacksGenerateWallet() // String
            result.success(response)
        } catch (e: Exception) {
            parseException("Stacks.generateWallet", e, result)
        }
    }

    fun getAddress(params: Any?, result: MethodChannel.Result) {
        val dict = params as? Map<*, *> ?: return result.error("Stacks.getAddress", "Invalid parameters: not a map", null)
        Log.d("🤖 Stacks.getAddress", "params: $dict")

        val wallet = dict["wallet"] as? String ?: return errorMissing("wallet", params, result)
        val version = dict["version"] as? String ?: return errorMissing("version", params, result)
        try {
            val response = stacksGetAddress(wallet, version) // String
            result.success(response)
        } catch (e: Exception) {
            parseException("Stacks.getAddress", e, result)
        }
    }

    fun signMessage(params: Any?, result: MethodChannel.Result) {
        val dict = params as? Map<*, *> ?: return result.error("Stacks.signMessage", "Invalid parameters: not a map", null)
        Log.d("🤖 Stacks.signMessage", "params: $dict")

        val wallet = dict["wallet"] as? String ?: return errorMissing("wallet", params, result)
        val message = dict["message"] as? String ?: return errorMissing("message", params, result)
        try {
            val response = stacksSignMessage(wallet, message) // String
            result.success(response)
        } catch (e: Exception) {
            parseException("Stacks.signMessage", e, result)
        }
    }

    fun transferStx(params: Any?, result: MethodChannel.Result) {
        val dict = params as? Map<*, *> ?: return result.error("Stacks.transferStx", "Invalid parameters: not a map", null)
        Log.d("🤖 Stacks.transferStx", "params: $dict")

        val wallet = dict["wallet"] as? String ?: return errorMissing("wallet", params, result)
        val networkId = dict["networkId"] as? String ?: return errorMissing("networkId", params, result)
        val request = dict["request"] as? Map<*, *> ?: return errorMissing("request", params, result)

        val sender = request["sender"] as? String ?: return errorMissing("request.sender", params, result)
        val amount = request["amount"]?.toString()?.toULongOrNull() ?: return errorMissing("request.amount", params, result)
        val recipient = request["recipient"] as? String ?: return errorMissing("request.recipient", params, result)
        val memo = request["memo"] as? String?

        CoroutineScope(Dispatchers.IO).launch {
            try {
                val response = stacksClient.transferStx(
                    wallet = wallet,
                    network = networkId,
                    request = TransferStxRequest(
                        sender = sender,
                        amount = amount,
                        memo = memo ?: "",
                        recipient = recipient
                    )
                )
                val resultMap = mapOf(
                    "transaction" to response.transaction,
                    "txid" to if (response.txid.startsWith("0x")) response.txid else "0x${response.txid}"
                )
                result.success(resultMap)
            } catch (e: Exception) {
                parseException("Stacks.transferStx", e, result)
            }
        }
    }

    fun getAccount(params: Any?, result: MethodChannel.Result) {
        val dict = params as? Map<*, *> ?: return result.error("Stacks.getAccount", "Invalid parameters: not a map", null)
        Log.d("🤖 Stacks.getAccount", "params: $dict")

        val networkId = dict["networkId"] as? String ?: return errorMissing("networkId", params, result)
        val principal = dict["principal"] as? String ?: return errorMissing("principal", params, result)

        CoroutineScope(Dispatchers.IO).launch {
            try {
                val response = stacksClient.getAccount(network = networkId, principal = principal)
                val resultMap = mapOf(
                    "balance" to response.balance,
                    "locked" to response.locked,
                    "unlock_height" to response.unlockHeight.toString(),
                    "nonce" to response.nonce.toString(),
                    "balance_proof" to response.balanceProof,
                    "nonce_proof" to response.nonceProof
                )
                result.success(resultMap)
            } catch (e: Exception) {
                parseException("Stacks.getAccount", e, result)
            }
        }
    }

    @SuppressLint("LongLogTag")
    fun transferFeeRate(params: Any?, result: MethodChannel.Result) {
        val dict = params as? Map<*, *> ?: return result.error("Stacks.transferFeeRate", "Invalid parameters: not a map", null)
        Log.d("🤖 Stacks.transferFeeRate", "params: $dict")

        val networkId = dict["networkId"] as? String ?: return errorMissing("networkId", params, result)

        CoroutineScope(Dispatchers.IO).launch {
            try {
                val response = stacksClient.transferFees(network = networkId)
                result.success(response.toString())
            } catch (e: Exception) {
                parseException("Stacks.transferFeeRate", e, result)
            }
        }
    }

    fun dispose() {
        Log.d("🤖 Stacks.dispose", "Disposing StacksClient for networkId: $networkId")
    }

    // ==== COMPANION: registry & static entrypoints ====

    companion object {
        private val clients = mutableMapOf<String, Stacks>()

        fun init(applicationContext: Context, params: Any?, result: MethodChannel.Result) {
            val dict = params as? Map<*, *> ?: return result.error("stx_init", "Invalid parameters", null)
            Log.d("🤖 Stacks.init", "params: $dict")

            val projectId = dict["projectId"] as? String ?: return errorMissing("projectId", params, result)
            val networkId = dict["networkId"] as? String ?: return errorMissing("networkId", params, result)
            val pulseMetadataDict = dict["pulseMetadata"] as? Map<*, *> ?: return errorMissing("pulseMetadata", params, result)

            val url = pulseMetadataDict["url"] as? String
            val packageName = applicationContext.packageName
            val sdkVersion = pulseMetadataDict["sdkVersion"] as? String ?: return errorMissing("sdkVersion", params, result)
            val sdkPlatform = pulseMetadataDict["sdkPlatform"] as? String ?: return errorMissing("sdkPlatform", params, result)

            val pulseMetadata = PulseMetadata(url, packageName, sdkVersion, sdkPlatform)

            val instance = Stacks(projectId = projectId, networkId = networkId, pulseMetadata = pulseMetadata)
            clients[networkId] = instance
            result.success(true)
        }

        private fun getClient(networkId: String, result: MethodChannel.Result): Stacks? {
            val client = clients[networkId]
            if (client == null) result.error("StacksClient", "networkId '$networkId' not found", null)
            return client
        }

        @SuppressLint("LongLogTag")
        fun generateWallet(params: Any?, result: MethodChannel.Result) {
            val dict = params as? Map<*, *> ?: return result.error("stx_generateWallet", "Invalid parameters", null)
            Log.d("🤖 Stacks.generateWallet", "params: $dict")

            val networkId = dict["networkId"] as? String ?: return errorMissing("networkId", params, result)
            getClient(networkId, result)?.generateWallet(result)
        }

        fun getAddress(params: Any?, result: MethodChannel.Result) {
            val dict = params as? Map<*, *> ?: return result.error("stx_getAddress", "Invalid parameters", null)
            Log.d("🤖 Stacks.getAddress", "params: $dict")

            val networkId = dict["networkId"] as? String ?: return errorMissing("networkId", params, result)
            getClient(networkId, result)?.getAddress(dict, result)
        }

        fun signMessage(params: Any?, result: MethodChannel.Result) {
            val dict = params as? Map<*, *> ?: return result.error("stx_signMessage", "Invalid parameters", null)
            Log.d("🤖 Stacks.signMessage", "params: $dict")

            val networkId = dict["networkId"] as? String ?: return errorMissing("networkId", params, result)
            getClient(networkId, result)?.signMessage(dict, result)
        }

        fun transferStx(params: Any?, result: MethodChannel.Result) {
            val dict = params as? Map<*, *> ?: return result.error("stx_transferStx", "Invalid parameters", null)
            Log.d("🤖 Stacks.transferStx", "params: $dict")

            val networkId = dict["networkId"] as? String ?: return errorMissing("networkId", params, result)
            getClient(networkId, result)?.transferStx(dict, result)
        }

        fun getAccount(params: Any?, result: MethodChannel.Result) {
            val dict = params as? Map<*, *> ?: return result.error("stx_getAccount", "Invalid parameters", null)
            Log.d("🤖 Stacks.getAccount", "params: $dict")

            val networkId = dict["networkId"] as? String ?: return errorMissing("networkId", params, result)
            getClient(networkId, result)?.getAccount(dict, result)
        }

        @SuppressLint("LongLogTag")
        fun transferFeeRate(params: Any?, result: MethodChannel.Result) {
            val dict = params as? Map<*, *> ?: return result.error("stx_transferFeeRate", "Invalid parameters", null)
            Log.d("🤖 Stacks.transferFeeRate", "params: $dict")

            val networkId = dict["networkId"] as? String ?: return errorMissing("networkId", params, result)
            getClient(networkId, result)?.transferFeeRate(dict, result)
        }

        fun dispose(params: Any?, result: MethodChannel.Result) {
            val dict = params as? Map<*, *> ?: return result.error("stx_dispose", "Invalid parameters", null)
            val networkId = dict["networkId"] as? String ?: return errorMissing("networkId", params, result)
            clients.remove(networkId)?.dispose()
            result.success(true)
        }

        private fun parseException(c: String, e: Exception, result: MethodChannel.Result) {
            if (e.message?.contains("MemoTooLong") == true) {
                result.error(c, "Memo too long: maximum allowed is 34 bytes", null)
            } else if (e.message?.contains("TransferFees") == true) {
                result.error(c, "Failed to fetch fee rate", null)
            } else if (e.message?.contains("FetchAccount") == true) {
                result.error(c, "Failed to fetch account", null)
            } else {
                result.error(c, e.message, null)
            }
        }
    }
}
