package com.reown.reown_yttrium

import android.util.Base64
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

        fun initialize(packageName: String?, params: Any?, result: MethodChannel.Result) {
            val dict = params as? Map<*, *> ?: return result.error("initialize", "Invalid parameters: not a map", null)

            val projectId = dict["projectId"] as? String ?: return errorMissing("projectId", params, result)
            val pulseMetadataDict = dict["pulseMetadata"] as? Map<*, *> ?: return errorMissing("pulseMetadata", params, result)

            val url = pulseMetadataDict["url"] as? String ?: return errorMissing("url", params, result)
            val packageName = packageName ?: pulseMetadataDict["packageName"] as? String ?: return errorMissing("packageName", params, result)
            val sdkVersion = pulseMetadataDict["sdkVersion"] as? String ?: return errorMissing("sdkVersion", params, result)
            val sdkPlatform = pulseMetadataDict["sdkPlatform"] as? String ?: return errorMissing("sdkPlatform", params, result)

            val pulseMetadata = PulseMetadata(url, packageName, sdkVersion, sdkPlatform)

            suiClient = SuiClient(projectId = projectId, pulseMetadata = pulseMetadata)

            result.success(true)
        }

        // chaiId: String, keyPair: String, txData: ByteArray
        fun signAndExecuteTransaction(params: Any?, result: MethodChannel.Result) {
            CoroutineScope(Dispatchers.Main).launch {
                try {
                    signAndExecuteTransactioncall(params, result)
                } catch (e: Exception) {
                    result.error("Sui.signAndExecuteTransaction", e.message, null)
                }
            }
        }

        private suspend fun signAndExecuteTransactioncall(params: Any?, result: MethodChannel.Result) {
            check(::suiClient.isInitialized) { "Initialize SuiClient before using it." }
            val dict = params as? Map<*, *> ?: return result.error("signAndExecuteTransaction", "Invalid parameters: not a map", null)

            val chaiId = dict["chaiId"] as? String ?: return errorMissing("chaiId", params, result)
            val keyPair = dict["keyPair"] as? String ?: return errorMissing("keyPair", params, result)
            val txData = dict["txData"] as? String ?: return errorMissing("txData", params, result)
            val dataBytes: ByteArray = Base64.decode(txData, Base64.DEFAULT)

            val response: String = suiClient.signAndExecuteTransaction(chaiId, keyPair, dataBytes)
            result.success(response) // return String
        }

        // chaiId: String, keyPair: String, txData: ByteArray
        fun signTransaction(params: Any?, result: MethodChannel.Result) {
            CoroutineScope(Dispatchers.Main).launch {
                try {
                    signTransactionCall(params, result)
                } catch (e: Exception) {
                    result.error("Sui.signTransaction", e.message, null)
                }
            }
        }

        private suspend fun signTransactionCall(params: Any?, result: MethodChannel.Result) {
            check(::suiClient.isInitialized) { "Initialize SuiClient before using it." }
            val dict = params as? Map<*, *> ?: return result.error("signTransactionCall", "Invalid parameters: not a map", null)

            val chaiId = dict["chaiId"] as? String ?: return errorMissing("chaiId", params, result)
            val keyPair = dict["keyPair"] as? String ?: return errorMissing("keyPair", params, result)
            val txData = dict["txData"] as? String ?: return errorMissing("txData", params, result)
            val dataBytes: ByteArray = Base64.decode(txData, Base64.DEFAULT)

            val response = suiClient.signTransaction(chaiId, keyPair, dataBytes)
            val pair = Pair(response.signature, response.txBytes)
            result.success(pair) // Pair<String, String>
        }

        // keyPair: String, message: ByteArray
        fun personalSign(params: Any?, result: MethodChannel.Result) {
            val dict = params as? Map<*, *> ?: return result.error("personalSign", "Invalid parameters: not a map", null)

            val keyPair = dict["keyPair"] as? String ?: return errorMissing("keyPair", params, result)
            val message = dict["message"] as? String ?: return errorMissing("message", params, result)
            val messageBytes: ByteArray = Base64.decode(message, Base64.DEFAULT)

            val response = suiPersonalSign(keyPair, messageBytes)
            result.success(response) // String
        }

        fun generateKeyPair(result: MethodChannel.Result) {
            val response = suiGenerateKeypair()
            result.success(response) // String
        }

        // publicKey: String
        fun getAddressFromPublicKey(params: Any?, result: MethodChannel.Result) {
            val dict = params as? Map<*, *> ?: return result.error("getAddressFromPublicKey", "Invalid parameters: not a map", null)

            val publicKey = dict["publicKey"] as? String ?: return errorMissing("publicKey", params, result)

            val response = suiGetAddress(publicKey)
            result.success(response) // String
        }

        // keyPair: String
        fun getPublicKeyFromKeyPair(params: Any?, result: MethodChannel.Result) {
            val dict = params as? Map<*, *> ?: return result.error("getPublicKeyFromKeyPair", "Invalid parameters: not a map", null)

            val keyPair = dict["keyPair"] as? String ?: return errorMissing("keyPair", params, result)

            val response = suiGetPublicKey(keyPair)
            result.success(response) // String
        }
    }
}