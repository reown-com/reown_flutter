package com.reown.reown_yttrium

import android.annotation.SuppressLint
import android.content.Context
import android.util.Log

import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import uniffi.yttrium.Keypair
import uniffi.yttrium.PulseMetadata
import uniffi.yttrium.TonClient
import uniffi.yttrium.TonClientConfig
import kotlin.collections.get

/**
 * Ton.kt
 *
 * Supports multiple TonClient instances (e.g. mainnet, testnet).
 * Use clientId (e.g. "mainnet", "testnet") to identify each client.
 */
class Ton(private val projectId: String, private val networkId: String, private val pulseMetadata: PulseMetadata) {
    private val tonClient: TonClient = TonClient(
        cfg = TonClientConfig(networkId = networkId),
        projectId = projectId,
        pulseMetadata = pulseMetadata
    )

    // ==== INSTANCE METHODS ====

    fun generateKeypair(result: MethodChannel.Result) {
        val keyPair = tonClient.generateKeypair()
        result.success(mapOf("pk" to keyPair.pk, "sk" to keyPair.sk))
    }

    @SuppressLint("LongLogTag")
    fun generateKeypairFromTonMnemonic(params: Any?, result: MethodChannel.Result) {
        val dict = params as? Map<*, *> ?: return result.error("Ton.generateKeypairFromTonMnemonic", "Invalid parameters", null)
        Log.d("🤖 Ton.generateKeypairFromTonMnemonic", "params: $dict")

        val mnemonic = dict["mnemonic"] as? String ?: return result.error("Ton.generateKeypairFromTonMnemonic", "Missing mnemonic", null)
        val keyPair = tonClient.generateKeypairFromTonMnemonic(mnemonic = mnemonic)
        result.success(mapOf("pk" to keyPair.pk, "sk" to keyPair.sk))
    }

    @SuppressLint("LongLogTag")
    fun generateKeypairFromBip39Mnemonic(params: Any?, result: MethodChannel.Result) {
        val dict = params as? Map<*, *> ?: return result.error("Ton.generateKeypairFromBip39Mnemonic", "Invalid parameters", null)
        Log.d("🤖 Ton.generateKeypairFromBip39Mnemonic", "params: $dict")

        val mnemonic = dict["mnemonic"] as? String ?: return result.error("Ton.generateKeypairFromBip39Mnemonic", "Missing mnemonic", null)
        val keyPair = tonClient.generateKeypairFromBip39Mnemonic(mnemonic = mnemonic)
        result.success(mapOf("pk" to keyPair.pk, "sk" to keyPair.sk))
    }

    @SuppressLint("LongLogTag")
    fun getAddressFromKeypair(params: Any?, result: MethodChannel.Result) {
        val dict = params as? Map<*, *> ?: return result.error("getAddressFromKeypair", "Invalid parameters", null)
        Log.d("🤖 Ton.getAddressFromKeypair", "params: $dict")

        val sk = dict["sk"] as? String ?: return result.error("getAddressFromKeypair", "Missing sk", null)
        val pk = dict["pk"] as? String ?: return result.error("getAddressFromKeypair", "Missing pk", null)

        try {
            val keyPair = Keypair(sk, pk)
            val identity = tonClient.getAddressFromKeypair(keypair = keyPair)
            result.success(
                mapOf(
                    "friendlyEq" to identity.friendly,
                    "rawHex" to identity.rawHex,
                    "workchain" to identity.workchain.toHexString()
                )
            )
        } catch (e: Exception) {
            result.error("Ton.getAddressFromKeypair", e.message, null)
        }
    }

    fun signData(params: Any?, result: MethodChannel.Result) {
        val dict = params as? Map<*, *> ?: return result.error("signData", "Invalid parameters", null)
        Log.d("🤖 Ton.signData", "params: $dict")

        val text = dict["text"] as? String ?: return result.error("signData", "Missing text", null)
        val sk = dict["sk"] as? String ?: return result.error("signData", "Missing sk", null)
        val pk = dict["pk"] as? String ?: return result.error("signData", "Missing pk", null)

        try {
            val keyPair = Keypair(sk, pk)
            val response = tonClient.signData(text = text, keypair = keyPair)
            result.success(response)
        } catch (e: Exception) {
            result.error("Ton.signData", e.message, null)
        }
    }

    fun sendMessage(params: Any?, result: MethodChannel.Result) {
        val dict = params as? Map<*, *> ?: return result.error("sendMessage", "Invalid parameters", null)
        Log.d("🤖 Ton.sendMessage", "params: $dict")

        val networkId = dict["networkId"] as? String ?: return result.error("sendMessage", "Missing network", null)
        val from = dict["from"] as? String ?: return result.error("sendMessage", "Missing from", null)
        val validUntil = dict["validUntil"] as? Int ?: return result.error("sendMessage", "Missing validUntil", null)
        val messages = dict["messages"] as? List<*> ?: return result.error("sendMessage", "Missing messages", null)
        val sk = dict["sk"] as? String ?: return result.error("sendMessage", "Missing sk", null)
        val pk = dict["pk"] as? String ?: return result.error("sendMessage", "Missing pk", null)

        CoroutineScope(Dispatchers.IO).launch {
            try {
                val keyPair = Keypair(sk, pk)
                val response = tonClient.sendMessage(
                    network = networkId,
                    from = from,
                    keypair = keyPair,
                    validUntil = validUntil.toUInt(),
                    messages = messages.toSendTxMessageList()
                )
                result.success(response)
            } catch (e: Exception) {
                Log.e("🤖 Ton.sendMessage", "Error: ${e.message}")
                result.error("Ton.sendMessage", e.message, null)
            }
        }
    }

    fun broadcastMessage(params: Any?, result: MethodChannel.Result) {
        val dict = params as? Map<*, *> ?: return result.error("broadcastMessage", "Invalid parameters", null)
        Log.d("🤖 Ton.broadcastMessage", "params: $dict")

        val from = dict["from"] as? String ?: return result.error("broadcastMessage", "Missing from", null)
        val validUntil = dict["validUntil"] as? UInt ?: return result.error("broadcastMessage", "Missing validUntil", null)
        val messages = dict["messages"] as? List<*> ?: return result.error("broadcastMessage", "Missing messages", null)
        val sk = dict["sk"] as? String ?: return result.error("broadcastMessage", "Missing sk", null)
        val pk = dict["pk"] as? String ?: return result.error("broadcastMessage", "Missing pk", null)

        CoroutineScope(Dispatchers.IO).launch {
            try {
                val keyPair = Keypair(sk, pk)
                val response = tonClient.broadcastMessage(
                    from = from,
                    keypair = keyPair,
                    validUntil = validUntil,
                    messages = messages.toSendTxMessageList()
                )
                result.success(response)
            } catch (e: Exception) {
                Log.e("🤖 Ton.broadcastMessage", "Error: ${e.message}")
                result.error("Ton.broadcastMessage", e.message, null)
            }
        }
    }

    fun dispose() {
        // Clean up resources if TonClient exposes something like close()
        Log.d("🤖 Ton.dispose", "Disposing TonClient for network: $networkId")
    }

    // endregion

    // region ==== COMPANION OBJECT ====

    companion object {
        private val clients = mutableMapOf<String, Ton>()

        fun init(applicationContext: Context, params: Any?, result: MethodChannel.Result) {
            val dict = params as? Map<*, *> ?: return result.error("ton_init", "Invalid parameters", null)
            Log.d("🤖 Ton.init", "params: $dict")

            val projectId = dict["projectId"] as? String ?: return errorMissing("projectId", params, result)
            val networkId = dict["networkId"] as? String ?: return errorMissing("networkId", params, result)
            val pulseMetadataDict = dict["pulseMetadata"] as? Map<*, *> ?: return errorMissing("pulseMetadata", params, result)

            val url = pulseMetadataDict["url"] as? String
            val packageName = applicationContext.packageName ?: pulseMetadataDict["packageName"] as? String ?: return errorMissing("packageName", params, result)
            val sdkVersion = pulseMetadataDict["sdkVersion"] as? String ?: return errorMissing("sdkVersion", params, result)
            val sdkPlatform = pulseMetadataDict["sdkPlatform"] as? String ?: return errorMissing("sdkPlatform", params, result)

            val pulseMetadata = PulseMetadata(url, packageName, sdkVersion, sdkPlatform)

            val ton = Ton(projectId, networkId, pulseMetadata)
            clients[networkId] = ton
            result.success(true)
        }

        private fun getClient(networkId: String, result: MethodChannel.Result): Ton? {
            val client = clients[networkId]
            if (client == null) result.error("TonClient", "networkId '$networkId' not found", null)
            return client
        }

        fun generateKeypair(params: Any?, result: MethodChannel.Result) {
            val dict = params as? Map<*, *> ?: return result.error("ton_generateKeypair", "Invalid parameters", null)
            Log.d("🤖 Ton.generateKeypair", "params: $dict")

            val networkId = dict["networkId"] as? String ?: return result.error("ton_generateKeypair", "Missing networkId", null)
            getClient(networkId, result)?.generateKeypair(result)
        }

        @SuppressLint("LongLogTag")
        fun generateKeypairFromTonMnemonic(params: Any?, result: MethodChannel.Result) {
            val dict = params as? Map<*, *> ?: return result.error("ton_generateKeypairFromTonMnemonic", "Invalid parameters", null)
            Log.d("🤖 Ton.generateKeypairFromTonMnemonic", "params: $dict")

            val networkId = dict["networkId"] as? String ?: return result.error("ton_generateKeypairFromTonMnemonic", "Missing networkId", null)
            getClient(networkId, result)?.generateKeypairFromTonMnemonic(dict, result)
        }

        @SuppressLint("LongLogTag")
        fun generateKeypairFromBip39Mnemonic(params: Any?, result: MethodChannel.Result) {
            val dict = params as? Map<*, *> ?: return result.error("ton_generateKeypairFromBip39Mnemonic", "Invalid parameters", null)
            Log.d("🤖 Ton.generateKeypairFromBip39Mnemonic", "params: $dict")

            val networkId = dict["networkId"] as? String ?: return result.error("ton_generateKeypairFromBip39Mnemonic", "Missing networkId", null)
            getClient(networkId, result)?.generateKeypairFromBip39Mnemonic(dict, result)
        }

        @SuppressLint("LongLogTag")
        fun getAddressFromKeypair(params: Any?, result: MethodChannel.Result) {
            val dict = params as? Map<*, *> ?: return result.error("ton_getAddressFromKeypair", "Invalid parameters", null)
            Log.d("🤖 Ton.getAddressFromKeypair", "params: $dict")

            val networkId = dict["networkId"] as? String ?: return result.error("ton_getAddressFromKeypair", "Missing networkId", null)
            getClient(networkId, result)?.getAddressFromKeypair(dict, result)
        }

        fun signData(params: Any?, result: MethodChannel.Result) {
            val dict = params as? Map<*, *> ?: return result.error("ton_signData", "Invalid parameters", null)
            Log.d("🤖 Ton.signData", "params: $dict")

            val networkId = dict["networkId"] as? String ?: return result.error("ton_signData", "Missing networkId", null)
            getClient(networkId, result)?.signData(dict, result)
        }

        fun sendMessage(params: Any?, result: MethodChannel.Result) {
            val dict = params as? Map<*, *> ?: return result.error("ton_sendMessage", "Invalid parameters", null)
            Log.d("🤖 Ton.sendMessage", "params: $dict")

            val networkId = dict["networkId"] as? String ?: return result.error("ton_sendMessage", "Missing networkId", null)
            getClient(networkId, result)?.sendMessage(dict, result)
        }

        fun broadcastMessage(params: Any?, result: MethodChannel.Result) {
            val dict = params as? Map<*, *> ?: return result.error("ton_broadcastMessage", "Invalid parameters", null)
            Log.d("🤖 Ton.broadcastMessage", "params: $dict")

            val networkId = dict["networkId"] as? String ?: return result.error("ton_broadcastMessage", "Missing networkId", null)
            getClient(networkId, result)?.broadcastMessage(dict, result)
        }

        fun dispose(params: Any?, result: MethodChannel.Result) {
            val dict = params as? Map<*, *> ?: return result.error("ton_dispose", "Invalid parameters", null)
            val networkId = dict["networkId"] as? String ?: return result.error("ton_dispose", "Missing networkId", null)
            clients.remove(networkId)?.dispose()
            result.success(true)
        }
    }
    // endregion
}