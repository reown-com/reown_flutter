package com.reown.reown_yttrium

import android.content.Context
import android.util.Log

import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import uniffi.yttrium.PulseMetadata
import uniffi.yttrium.StacksClient
import uniffi.yttrium.TransferStxRequest
import uniffi.yttrium.stacksGenerateWallet
import uniffi.yttrium.stacksGetAddress
import uniffi.yttrium.stacksSignMessage
import kotlin.collections.get

class Stacks {
    companion object {
        private lateinit var stacksClient: StacksClient

        fun initialize(applicationContext: Context, params: Any?, result: MethodChannel.Result) {
            val dict = params as? Map<*, *> ?: return result.error("initialize", "Invalid parameters: not a map", null)

            val projectId = dict["projectId"] as? String ?: return errorMissing("projectId", params, result)
            val pulseMetadataDict = dict["pulseMetadata"] as? Map<*, *> ?: return errorMissing("pulseMetadata", params, result)

            val url = pulseMetadataDict["url"] as? String ?: return errorMissing("url", params, result)
            val packageName = applicationContext.packageName ?: pulseMetadataDict["packageName"] as? String ?: return errorMissing("packageName", params, result)
            val sdkVersion = pulseMetadataDict["sdkVersion"] as? String ?: return errorMissing("sdkVersion", params, result)
            val sdkPlatform = pulseMetadataDict["sdkPlatform"] as? String ?: return errorMissing("sdkPlatform", params, result)

            val pulseMetadata = PulseMetadata(url, packageName, sdkVersion, sdkPlatform)

            stacksClient = StacksClient(projectId = projectId, pulseMetadata = pulseMetadata)

            result.success(true)
        }

        fun generateWallet(result: MethodChannel.Result) {
            val response = stacksGenerateWallet()
            result.success(response) // String
        }

        fun getAddress(params: Any?, result: MethodChannel.Result) {
            val dict = params as? Map<*, *> ?: return result.error("Stacks.getAddress", "Invalid parameters: not a map", null)

            val wallet = dict["wallet"] as? String ?: return errorMissing("wallet", params, result)
            val version = dict["version"] as? String ?: return errorMissing("version", params, result) // plain message

            val response = stacksGetAddress(wallet, version)
            result.success(response) // String
        }

        fun signMessage(params: Any?, result: MethodChannel.Result) {
            val dict = params as? Map<*, *> ?: return result.error("Stacks.signMessage", "Invalid parameters: not a map", null)

            val wallet = dict["wallet"] as? String ?: return errorMissing("wallet", params, result)
            val message = dict["message"] as? String ?: return errorMissing("message", params, result) // plain message

            val response = stacksSignMessage(wallet, message)
            result.success(response) // String
        }

        fun transferStx(params: Any?, result: MethodChannel.Result) {
            check(::stacksClient.isInitialized) { "Initialize StacksClient before using it." }

            val dict = params as? Map<*, *> ?: return result.error("Stacks.transferStx", "Invalid parameters: not a map", null)

            val wallet = dict["wallet"] as? String ?: return errorMissing("wallet", params, result)
            val network = dict["network"] as? String ?: return errorMissing("network", params, result)
            val request = dict["request"] as? Map<*, *> ?: return errorMissing("request", params, result)

            val amount = request["amount"]?.toString()?.toULongOrNull() ?: return errorMissing("request.amount", params, result)
            val recipient = request["recipient"] as? String ?: return errorMissing("request.recipient", params, result)
            val memo = request["memo"] as? String?

            CoroutineScope(Dispatchers.IO).launch {
                try {
                    val response = stacksClient.transferStx(
                        wallet = wallet,
                        network = network,
                        request = TransferStxRequest(
                            amount = amount,
                            memo = memo ?: "",
                            recipient = recipient,
                        )
                    )
                    val resultMap = mapOf(
                        "transaction" to response.transaction,
                        "txid" to response.txid
                    )
                    result.success(resultMap)
                } catch (e: Exception) {
                    result.error("Stacks.transferStx error", e.message, null)
                }
            }
        }
    }
}