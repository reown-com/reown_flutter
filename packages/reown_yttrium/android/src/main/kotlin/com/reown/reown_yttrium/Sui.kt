package com.reown.reown_yttrium

import android.annotation.SuppressLint
import android.content.Context
import android.util.Base64
import android.util.Log
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import uniffi.yttrium_utils.PulseMetadata
import uniffi.yttrium_utils.SuiClient
import uniffi.yttrium_utils.suiGenerateKeypair
import uniffi.yttrium_utils.suiGetAddress
import uniffi.yttrium_utils.suiGetPublicKey
import uniffi.yttrium_utils.suiPersonalSign

/**
 * Sui.kt
 *
 * Supports multiple SuiClient instances (e.g. mainnet, testnet).
 * Use networkId ("sui:mainnet", "sui:testnet", etc.) to identify each client.
 */
class Sui(private val projectId: String, private val networkId: String, private val pulseMetadata: PulseMetadata) {
    private val suiClient: SuiClient = SuiClient(
        projectId = projectId,
        pulseMetadata = pulseMetadata
    )

    // ==== INSTANCE METHODS ====

    fun generateKeyPair(result: MethodChannel.Result) {
        try {
            val response = suiGenerateKeypair()
            result.success(response)
        } catch (e: Exception) {
            result.error("Sui.generateKeyPair", e.message, null)
        }
    }

    @SuppressLint("LongLogTag")
    fun getAddressFromPublicKey(params: Any?, result: MethodChannel.Result) {
        val dict = params as? Map<*, *> ?: return result.error("Sui.getAddressFromPublicKey", "Invalid parameters: not a map", null)
        Log.d("🤖 Sui.getAddressFromPublicKey", "params: $dict")

        val publicKey = dict["publicKey"] as? String ?: return errorMissing("publicKey", params, result)
        try {
            val response = suiGetAddress(publicKey)
            result.success(response)
        } catch (e: Exception) {
            result.error("Sui.getAddressFromPublicKey", e.message, null)
        }
    }

    @SuppressLint("LongLogTag")
    fun getPublicKeyFromKeyPair(params: Any?, result: MethodChannel.Result) {
        val dict = params as? Map<*, *> ?: return result.error("Sui.getPublicKeyFromKeyPair", "Invalid parameters: not a map", null)
        Log.d("🤖 Sui.getPublicKeyFromKeyPair", "params: $dict")

        val keyPair = dict["keyPair"] as? String ?: return errorMissing("keyPair", params, result)
        try {
            val response = suiGetPublicKey(keyPair)
            result.success(response)
        } catch (e: Exception) {
            result.error("Sui.getPublicKeyFromKeyPair", e.message, null)
        }
    }

    fun personalSign(params: Any?, result: MethodChannel.Result) {
        val dict = params as? Map<*, *> ?: return result.error("Sui.personalSign", "Invalid parameters: not a map", null)
        Log.d("🤖 Sui.personalSign", "params: $dict")

        val keyPair = dict["keyPair"] as? String ?: return errorMissing("keyPair", params, result)
        val message = dict["message"] as? String ?: return errorMissing("message", params, result)

        try {
            val response = suiPersonalSign(keyPair, message.toByteArray(Charsets.UTF_8))
            result.success(response)
        } catch (e: Exception) {
            result.error("Sui.personalSign", e.message, null)
        }
    }

    fun signTransaction(params: Any?, result: MethodChannel.Result) {
        val dict = params as? Map<*, *> ?: return result.error("Sui.signTransaction", "Invalid parameters: not a map", null)
        Log.d("🤖 Sui.signTransaction", "params: $dict")

        val networkId = dict["networkId"] as? String ?: return errorMissing("networkId", params, result)
        val keyPair = dict["keyPair"] as? String ?: return errorMissing("keyPair", params, result)
        val txData = dict["txData"] as? String ?: return errorMissing("txData", params, result)
        val dataBytes = Base64.decode(txData, Base64.DEFAULT)

        CoroutineScope(Dispatchers.IO).launch {
            try {
                val response = suiClient.signTransaction(chainId = networkId, keyPair, dataBytes)
                val resultMap = mapOf(
                    "signature" to response.signature,
                    "transactionBytes" to response.txBytes
                )
                result.success(resultMap)
            } catch (e: Exception) {
                result.error("Sui.signTransaction", e.message, null)
            }
        }
    }

    @SuppressLint("LongLogTag")
    fun signAndExecuteTransaction(params: Any?, result: MethodChannel.Result) {
        val dict = params as? Map<*, *> ?: return result.error("Sui.signAndExecuteTransaction", "Invalid parameters: not a map", null)
        Log.d("🤖 Sui.signAndExecuteTransaction", "params: $dict")

        val networkId = dict["networkId"] as? String ?: return errorMissing("networkId", params, result)
        val keyPair = dict["keyPair"] as? String ?: return errorMissing("keyPair", params, result)
        val txData = dict["txData"] as? String ?: return errorMissing("txData", params, result)
        val dataBytes = Base64.decode(txData, Base64.DEFAULT)

        CoroutineScope(Dispatchers.IO).launch {
            try {
                val response = suiClient.signAndExecuteTransaction(chainId = networkId, keyPair, dataBytes)
                result.success(response)
            } catch (e: Exception) {
                result.error("Sui.signAndExecuteTransaction", e.message, null)
            }
        }
    }

    fun dispose() {
        Log.d("🤖 Sui.dispose", "Disposing SuiClient for networkId: $networkId")
    }

    // ==== COMPANION: registry & static entrypoints ====

    companion object {
        private val clients = mutableMapOf<String, Sui>()

        fun init(applicationContext: Context, params: Any?, result: MethodChannel.Result) {
            val dict = params as? Map<*, *> ?: return result.error("sui_init", "Invalid parameters", null)
            Log.d("🤖 Sui.init", "params: $dict")

            val projectId = dict["projectId"] as? String ?: return errorMissing("projectId", params, result)
            val networkId = dict["networkId"] as? String ?: return errorMissing("networkId", params, result)
            val pulseMetadataDict = dict["pulseMetadata"] as? Map<*, *> ?: return errorMissing("pulseMetadata", params, result)

            val url = pulseMetadataDict["url"] as? String
            val packageName = applicationContext.packageName
            val sdkVersion = pulseMetadataDict["sdkVersion"] as? String ?: return errorMissing("sdkVersion", params, result)
            val sdkPlatform = pulseMetadataDict["sdkPlatform"] as? String ?: return errorMissing("sdkPlatform", params, result)

            val pulseMetadata = PulseMetadata(url, packageName, sdkVersion, sdkPlatform)
            val instance = Sui(projectId = projectId, networkId = networkId, pulseMetadata = pulseMetadata)
            clients[networkId] = instance
            result.success(true)
        }

        private fun getClient(networkId: String, result: MethodChannel.Result): Sui? {
            val client = clients[networkId]
            if (client == null) result.error("SuiClient", "networkId '$networkId' not found", null)
            return client
        }

        fun generateKeyPair(params: Any?, result: MethodChannel.Result) {
            val dict = params as? Map<*, *> ?: return result.error("sui_generateKeyPair", "Invalid parameters", null)
            Log.d("🤖 Sui.generateKeyPair", "params: $dict")

            val networkId = dict["networkId"] as? String ?: return errorMissing("networkId", params, result)
            getClient(networkId, result)?.generateKeyPair(result)
        }

        @SuppressLint("LongLogTag")
        fun getAddressFromPublicKey(params: Any?, result: MethodChannel.Result) {
            val dict = params as? Map<*, *> ?: return result.error("sui_getAddressFromPublicKey", "Invalid parameters", null)
            Log.d("🤖 Sui.getAddressFromPublicKey", "params: $dict")

            val networkId = dict["networkId"] as? String ?: return errorMissing("networkId", params, result)
            getClient(networkId, result)?.getAddressFromPublicKey(dict, result)
        }

        @SuppressLint("LongLogTag")
        fun getPublicKeyFromKeyPair(params: Any?, result: MethodChannel.Result) {
            val dict = params as? Map<*, *> ?: return result.error("sui_getPublicKeyFromKeyPair", "Invalid parameters", null)
            Log.d("🤖 Sui.getPublicKeyFromKeyPair", "params: $dict")

            val networkId = dict["networkId"] as? String ?: return errorMissing("networkId", params, result)
            getClient(networkId, result)?.getPublicKeyFromKeyPair(dict, result)
        }

        fun personalSign(params: Any?, result: MethodChannel.Result) {
            val dict = params as? Map<*, *> ?: return result.error("sui_personalSign", "Invalid parameters", null)
            Log.d("🤖 Sui.personalSign", "params: $dict")

            val networkId = dict["networkId"] as? String ?: return errorMissing("networkId", params, result)
            getClient(networkId, result)?.personalSign(dict, result)
        }

        fun signTransaction(params: Any?, result: MethodChannel.Result) {
            val dict = params as? Map<*, *> ?: return result.error("sui_signTransaction", "Invalid parameters", null)
            Log.d("🤖 Sui.signTransaction", "params: $dict")

            val networkId = dict["networkId"] as? String ?: return errorMissing("networkId", params, result)
            getClient(networkId, result)?.signTransaction(dict, result)
        }

        @SuppressLint("LongLogTag")
        fun signAndExecuteTransaction(params: Any?, result: MethodChannel.Result) {
            val dict = params as? Map<*, *> ?: return result.error("sui_signAndExecuteTransaction", "Invalid parameters", null)
            Log.d("🤖 Sui.signAndExecuteTransaction", "params: $dict")

            val networkId = dict["networkId"] as? String ?: return errorMissing("networkId", params, result)
            getClient(networkId, result)?.signAndExecuteTransaction(dict, result)
        }

        fun dispose(params: Any?, result: MethodChannel.Result) {
            val dict = params as? Map<*, *> ?: return result.error("sui_dispose", "Invalid parameters", null)
            val networkId = dict["networkId"] as? String ?: return errorMissing("networkId", params, result)
            clients.remove(networkId)?.dispose()
            result.success(true)
        }
    }
}
