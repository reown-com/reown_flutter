package com.reown.reown_yttrium

import android.content.Context

import android.util.Base64
import com.yttrium.YttriumKt
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import uniffi.yttrium.PulseMetadata
import uniffi.yttrium.SuiClient
import uniffi.yttrium.suiGenerateKeypair
import uniffi.yttrium.suiGetAddress
import uniffi.yttrium.suiGetPublicKey
import uniffi.yttrium.suiPersonalSign
import kotlin.collections.get

class Sui {
    companion object {
        private lateinit var suiClient: SuiClient

        fun initialize(applicationContext: Context, params: Any?, result: MethodChannel.Result) {
            YttriumKt.initializeTls(applicationContext)

            val dict = params as? Map<*, *> ?: return result.error("initialize", "Invalid parameters: not a map", null)

            val projectId = dict["projectId"] as? String ?: return errorMissing("projectId", params, result)
            val pulseMetadataDict = dict["pulseMetadata"] as? Map<*, *> ?: return errorMissing("pulseMetadata", params, result)

            val url = pulseMetadataDict["url"] as? String ?: return errorMissing("url", params, result)
            val packageName = applicationContext.packageName ?: pulseMetadataDict["packageName"] as? String ?: return errorMissing("packageName", params, result)
            val sdkVersion = pulseMetadataDict["sdkVersion"] as? String ?: return errorMissing("sdkVersion", params, result)
            val sdkPlatform = pulseMetadataDict["sdkPlatform"] as? String ?: return errorMissing("sdkPlatform", params, result)

            val pulseMetadata = PulseMetadata(url, packageName, sdkVersion, sdkPlatform)

            suiClient = SuiClient(projectId = projectId, pulseMetadata = pulseMetadata)

            result.success(true)
        }

        // keyPair: String, message: ByteArray
        fun personalSign(params: Any?, result: MethodChannel.Result) {
            check(::suiClient.isInitialized) { "Initialize SuiClient before using it." }

            val dict = params as? Map<*, *> ?: return result.error("personalSign", "Invalid parameters: not a map", null)

            val keyPair = dict["keyPair"] as? String ?: return errorMissing("keyPair", params, result)
            val message = dict["message"] as? String ?: return errorMissing("message", params, result) // plain message

            val response = suiPersonalSign(keyPair, message.toByteArray(Charsets.UTF_8))
            result.success(response) // String
        }

        fun signTransaction(params: Any?, result: MethodChannel.Result) {
            check(::suiClient.isInitialized) { "Initialize SuiClient before using it." }

            val dict = params as? Map<*, *> ?: return result.error("signTransactionCall", "Invalid parameters: not a map", null)

            val chainId = dict["chainId"] as? String ?: return errorMissing("chainId", params, result)
            val keyPair = dict["keyPair"] as? String ?: return errorMissing("keyPair", params, result)
            val txData = dict["txData"] as? String ?: return errorMissing("txData", params, result)
            val dataBytes: ByteArray = Base64.decode(txData, Base64.DEFAULT)

            CoroutineScope(Dispatchers.IO).launch {
                try {
                    val response = suiClient.signTransaction(chainId, keyPair, dataBytes)
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

        fun signAndExecuteTransaction(params: Any?, result: MethodChannel.Result) {
            check(::suiClient.isInitialized) { "Initialize SuiClient before using it." }

            val dict = params as? Map<*, *> ?: return result.error("signAndExecuteTransaction", "Invalid parameters: not a map", null)

            val chainId = dict["chainId"] as? String ?: return errorMissing("chainId", params, result)
            val keyPair = dict["keyPair"] as? String ?: return errorMissing("keyPair", params, result)
            val txData = dict["txData"] as? String ?: return errorMissing("txData", params, result)
            val dataBytes: ByteArray = Base64.decode(txData, Base64.DEFAULT)

            CoroutineScope(Dispatchers.IO).launch {
                try {
                    val response: String = suiClient.signAndExecuteTransaction(chainId, keyPair, dataBytes)
                    result.success(response) // return String
                } catch (e: Exception) {
                    result.error("Sui.signAndExecuteTransaction", e.message, null)
                }
            }
        }

        fun generateKeyPair(result: MethodChannel.Result) {
            val response = suiGenerateKeypair()
            result.success(response) // String
        }

        fun getAddressFromPublicKey(params: Any?, result: MethodChannel.Result) {
            val dict = params as? Map<*, *> ?: return result.error("getAddressFromPublicKey", "Invalid parameters: not a map", null)

            val publicKey = dict["publicKey"] as? String ?: return errorMissing("publicKey", params, result)

            val response = suiGetAddress(publicKey)
            result.success(response) // String
        }

        fun getPublicKeyFromKeyPair(params: Any?, result: MethodChannel.Result) {
            val dict = params as? Map<*, *> ?: return result.error("getPublicKeyFromKeyPair", "Invalid parameters: not a map", null)

            val keyPair = dict["keyPair"] as? String ?: return errorMissing("keyPair", params, result)

            val response = suiGetPublicKey(keyPair)
            result.success(response) // String
        }
    }
}