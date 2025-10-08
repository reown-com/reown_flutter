package com.reown.reown_yttrium

import android.content.Context

import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import uniffi.yttrium.Keypair
import uniffi.yttrium.PulseMetadata
import uniffi.yttrium.TonClient
import uniffi.yttrium.TonClientConfig
import kotlin.collections.get

class Ton {
    companion object {
        private lateinit var tonClient: TonClient
        private var initialized = false

        fun init(applicationContext: Context, params: Any?, result: MethodChannel.Result) {
            val dict = params as? Map<*, *> ?: return result.error("initialize", "Invalid parameters: not a map", null)

            val projectId = dict["projectId"] as? String ?: return errorMissing("projectId", params, result)
            val networkId = dict["networkId"] as? String ?: return errorMissing("networkId", params, result)
            val pulseMetadataDict = dict["pulseMetadata"] as? Map<*, *> ?: return errorMissing("pulseMetadata", params, result)

            val url = pulseMetadataDict["url"] as? String ?: return errorMissing("url", params, result)
            val packageName = applicationContext.packageName ?: pulseMetadataDict["packageName"] as? String ?: return errorMissing("packageName", params, result)
            val sdkVersion = pulseMetadataDict["sdkVersion"] as? String ?: return errorMissing("sdkVersion", params, result)
            val sdkPlatform = pulseMetadataDict["sdkPlatform"] as? String ?: return errorMissing("sdkPlatform", params, result)
            val pulseMetadata = PulseMetadata(url, packageName, sdkVersion, sdkPlatform)

            val config = TonClientConfig(networkId = networkId)
            tonClient = TonClient(cfg = config, projectId = projectId, pulseMetadata = pulseMetadata)

            initialized = true
            result.success(true)
        }

        fun generateKeypair(result: MethodChannel.Result) {
            check(initialized == true) { "Initialize TonClient before using it." }

            val keyPair = tonClient.generateKeypair()
            val resultMap = mapOf(
                "pk" to keyPair.pk,
                "sk" to keyPair.sk
            )
            result.success(resultMap)
        }

        fun getAddressFromKeypair(params: Any?, result: MethodChannel.Result) {
            check(initialized == true) { "Initialize TonClient before using it." }

            val dict = params as? Map<*, *> ?: return result.error("getAddressFromKeypair", "Invalid parameters: not a map", null)

            val sk = dict["sk"] as? String ?: return errorMissing("sk", params, result)
            val pk = dict["pk"] as? String ?: return errorMissing("pk", params, result)

            try {
                val keyPair = Keypair(sk, pk)
                val identity = tonClient.getAddressFromKeypair(keypair = keyPair)
                val resultMap = mapOf(
                    "friendlyEq" to identity.friendlyEq,
                    "rawHex" to identity.rawHex,
                    "workchain" to identity.workchain.toHexString()
                )
                result.success(resultMap)
            } catch (e: Exception) {
                result.error("Ton.getAddressFromKeypair", e.message, null)
            }
        }

        fun signData(params: Any?, result: MethodChannel.Result) {
            check(initialized == true) { "Initialize TonClient before using it." }

            val dict = params as? Map<*, *> ?: return result.error("signData", "Invalid parameters: not a map", null)

            val text = dict["text"] as? String ?: return errorMissing("text", params, result)
            val sk = dict["sk"] as? String ?: return errorMissing("sk", params, result)
            val pk = dict["pk"] as? String ?: return errorMissing("pk", params, result)

            try {
                val keyPair = Keypair(sk, pk)
                val response = tonClient.signData(text = text, keypair = keyPair)
                result.success(response)
            } catch (e: Exception) {
                result.error("Ton.signData", e.message, null)
            }
        }

        fun sendMessage(params: Any?, result: MethodChannel.Result) {
            check(initialized == true) { "Initialize TonClient before using it." }

            val dict = params as? Map<*, *> ?: return result.error("sendMessage", "Invalid parameters: not a map", null)

            val network = dict["network"] as? String ?: return errorMissing("network", params, result)
            val from = dict["from"] as? String ?: return errorMissing("from", params, result)
            val validUntil = dict["validUntil"] as? UInt ?: return errorMissing("validUntil", params, result)
            val messages = dict["messages"] as? List<*> ?: return errorMissing("messages", params, result)
            val sk = dict["sk"] as? String ?: return errorMissing("sk", params, result)
            val pk = dict["pk"] as? String ?: return errorMissing("pk", params, result)

            CoroutineScope(Dispatchers.IO).launch {
                try {
                    val keyPair = Keypair(sk, pk)
                    val response = tonClient.sendMessage(
                        network = network,
                        from = from,
                        keypair = keyPair,
                        validUntil = validUntil,
                        messages = messages.toSendTxMessageList()
                    )
                    result.success(response)
                } catch (e: Exception) {
                    result.error("Ton.signData", e.message, null)
                }
            }
        }

        fun broadcastMessage(params: Any?, result: MethodChannel.Result) {
            check(initialized == true) { "Initialize TonClient before using it." }

            val dict = params as? Map<*, *> ?: return result.error("broadcastMessage", "Invalid parameters: not a map", null)

            val from = dict["from"] as? String ?: return errorMissing("from", params, result)
            val validUntil = dict["validUntil"] as? UInt ?: return errorMissing("validUntil", params, result)
            val messages = dict["messages"] as? List<*> ?: return errorMissing("messages", params, result)
            val sk = dict["sk"] as? String ?: return errorMissing("sk", params, result)
            val pk = dict["pk"] as? String ?: return errorMissing("pk", params, result)

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
                    result.error("Ton.signData", e.message, null)
                }
            }
        }
    }
}