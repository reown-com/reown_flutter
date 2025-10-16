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

        fun init(applicationContext: Context, params: Any?, result: MethodChannel.Result) {
            val dict = params as? Map<*, *> ?: return result.error("stx_init", "Invalid parameters", null)
            Log.d("🤖 Stacks.init", "params: $dict")

            val projectId = dict["projectId"] as? String ?: return errorMissing("projectId", params, result)
            val pulseMetadataDict = dict["pulseMetadata"] as? Map<*, *> ?: return errorMissing("pulseMetadata", params, result)

            val url = pulseMetadataDict["url"] as? String
            val packageName = applicationContext.packageName ?: pulseMetadataDict["packageName"] as? String ?: return errorMissing("packageName", params, result)
            val sdkVersion = pulseMetadataDict["sdkVersion"] as? String ?: return errorMissing("sdkVersion", params, result)
            val sdkPlatform = pulseMetadataDict["sdkPlatform"] as? String ?: return errorMissing("sdkPlatform", params, result)

            val pulseMetadata = PulseMetadata(url, packageName, sdkVersion, sdkPlatform)

            stacksClient = StacksClient(projectId = projectId, pulseMetadata = pulseMetadata)

            result.success(true)
        }

        fun generateWallet(result: MethodChannel.Result) {
            try {
                val response = stacksGenerateWallet()
                result.success(response) // String
            } catch (e: Exception) {
                parseException("Stacks.generateWallet", e, result)
            }
        }

        fun getAddress(params: Any?, result: MethodChannel.Result) {
            val dict = params as? Map<*, *> ?: return result.error("Stacks.getAddress", "Invalid parameters: not a map", null)

            val wallet = dict["wallet"] as? String ?: return errorMissing("wallet", params, result)
            val version = dict["version"] as? String ?: return errorMissing("version", params, result) // plain message

            try {
                val response = stacksGetAddress(wallet, version)
                result.success(response) // String
            } catch (e: Exception) {
                parseException("Stacks.signMessage", e, result)
            }
        }

        fun signMessage(params: Any?, result: MethodChannel.Result) {
            val dict = params as? Map<*, *> ?: return result.error("Stacks.signMessage", "Invalid parameters: not a map", null)

            val wallet = dict["wallet"] as? String ?: return errorMissing("wallet", params, result)
            val message = dict["message"] as? String ?: return errorMissing("message", params, result) // plain message

            try {
                val response = stacksSignMessage(wallet, message)
                result.success(response) // String
            } catch (e: Exception) {
                parseException("Stacks.signMessage", e, result)
            }
        }

        fun transferStx(params: Any?, result: MethodChannel.Result) {
            check(::stacksClient.isInitialized) { "Initialize StacksClient before using it." }

            val dict = params as? Map<*, *> ?: return result.error("Stacks.transferStx", "Invalid parameters: not a map", null)

            val wallet = dict["wallet"] as? String ?: return errorMissing("wallet", params, result)
            val network = dict["network"] as? String ?: return errorMissing("network", params, result)
            val request = dict["request"] as? Map<*, *> ?: return errorMissing("request", params, result)

            val sender = request["sender"] as? String ?: return errorMissing("request.sender", params, result)
            val amount = request["amount"]?.toString()?.toULongOrNull() ?: return errorMissing("request.amount", params, result)
            val recipient = request["recipient"] as? String ?: return errorMissing("request.recipient", params, result)
            val memo = request["memo"] as? String?

            CoroutineScope(Dispatchers.IO).launch {
                try {
                    val response = stacksClient.transferStx(
                        wallet = wallet,
                        network = network,
                        request = TransferStxRequest(
                            sender = sender,
                            amount = amount,
                            memo = memo ?: "",
                            recipient = recipient,
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
            check(::stacksClient.isInitialized) { "Initialize StacksClient before using it." }

            val dict = params as? Map<*, *> ?: return result.error("Stacks.getAccount", "Invalid parameters: not a map", null)

            val network = dict["network"] as? String ?: return errorMissing("network", params, result)
            val principal = dict["principal"] as? String ?: return errorMissing("principal", params, result)

            CoroutineScope(Dispatchers.IO).launch {
                try {
                    val response = stacksClient.getAccount(
                        network = network,
                        principal = principal
                    )
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

        fun transferFeeRate(params: Any?, result: MethodChannel.Result) {
            check(::stacksClient.isInitialized) { "Initialize StacksClient before using it." }

            val dict = params as? Map<*, *> ?: return result.error("Stacks.transferFeeRate", "Invalid parameters: not a map", null)

            val network = dict["network"] as? String ?: return errorMissing("network", params, result)

            CoroutineScope(Dispatchers.IO).launch {
                try {
                    val response = stacksClient.transferFees(
                        network = network,
                    )
                    result.success(response.toString())
                } catch (e: Exception) {
                    parseException("Stacks.transferFeeRate", e, result)
                }
            }
        }

//        fun estimateFees(params: Any?, result: MethodChannel.Result) {
//            check(::stacksClient.isInitialized) { "Initialize StacksClient before using it." }
//
//            val dict = params as? Map<*, *> ?: return result.error("Stacks.estimateFees", "Invalid parameters: not a map", null)
//
//            val network = dict["network"] as? String ?: return errorMissing("network", params, result)
//            val transactionPayload = dict["transaction_payload"] as? String ?: return errorMissing("transaction_payload", params, result)
//
//            CoroutineScope(Dispatchers.IO).launch {
//                try {
//                    val response = stacksClient.estimateFees(
//                        network = network,
//                        transactionPayload = transactionPayload
//                    )
//                    val resultMap = mapOf(
//                        "cost_scalar_change_by_byte" to response.costScalarChangeByByte,
//                        "estimated_cost_scalar" to response.estimatedCostScalar,
//                        "estimated_cost" to mapOf(
//                            "read_count" to response.estimatedCost.readCount,
//                            "read_length" to response.estimatedCost.readLength,
//                            "runtime" to response.estimatedCost.runtime,
//                            "write_count" to response.estimatedCost.writeCount,
//                            "write_length" to response.estimatedCost.writeLength,
//                        ),
//                        "estimations" to response.estimations.map {
//                            mapOf(
//                                "fee" to it.fee,
//                                "fee_rate" to it.feeRate
//                            )
//                        }
//                    )
//                    result.success(resultMap)
//                } catch (e: Exception) {
//                    result.error("Stacks.estimateFees error", e.message, null)
//                }
//            }
//        }

//        fun getNonce(params: Any?, result: MethodChannel.Result) {
//            check(::stacksClient.isInitialized) { "Initialize StacksClient before using it." }
//
//            val dict = params as? Map<*, *> ?: return result.error("Stacks.getNonce", "Invalid parameters: not a map", null)
//
//            val network = dict["network"] as? String ?: return errorMissing("network", params, result)
//            val principal = dict["principal"] as? String ?: return errorMissing("principal", params, result)
//
//            CoroutineScope(Dispatchers.IO).launch {
//                try {
//                    val response = stacksClient.getNonce(
//                        network = network,
//                        principal = principal
//                    )
//                    result.success(response)
//                } catch (e: Exception) {
//                    result.error("Stacks.getNonce error", e.message, null)
//                }
//            }
//        }

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
