package com.reown.reown_yttrium

import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import uniffi.yttrium.SignClient
import kotlin.collections.get

class Sign {
    companion object {
        private lateinit var signClient: SignClient

        fun initialize(params: Any?, result: MethodChannel.Result) {
            try {
                val dict = params as? Map<*, *> ?: return result.error("Sign.initialize", "Invalid parameters: not a map", null)
                val projectId = dict["projectId"] as? String ?: return result.error("Sign.initialize", "Invalid projectId", null)
                signClient = SignClient(projectId = projectId)
                result.success(true)
            } catch (e: Exception) {
                result.error("Sign.initialize", e.message, null)
            }
        }

        fun setKey(params: Any?, result: MethodChannel.Result) {
            check(::signClient.isInitialized) { "Initialize SignClient before using it." }

            val key = params as? String ?: return result.error("Sign.setKey", "Invalid parameters: not a String", null)

            CoroutineScope(Dispatchers.IO).launch {
                try {
                    signClient.setKey(key = key.hexStringToByteArray())
                    result.success(true)
                } catch (e: Exception) {
                    result.error("Sign.setKey", e.message, null)
                }
            }
        }

        fun generateKey(result: MethodChannel.Result) {
            check(::signClient.isInitialized) { "Initialize SignClient before using it." }

            try {
                val key = signClient.generateKey()
                result.success(key.byteArrayToHexString())
            } catch (e: Exception) {
                result.error("Sign.generateKey", e.message, null)
            }
        }

        fun pair(params: Any?, result: MethodChannel.Result) {
            check(::signClient.isInitialized) { "Initialize SignClient before using it." }

            val pairingUri = params as? String ?: return result.error("Sign.pair", "Invalid parameters: not a String", null)

            CoroutineScope(Dispatchers.IO).launch {
                try {
                    val response: String = signClient.pairJson(pairingUri);
                    result.success(response)
                } catch (e: Exception) {
                    result.error("Sign.pair", e.message, null)
                }
            }
        }

        fun approve(params: Any?, result: MethodChannel.Result) {
            check(::signClient.isInitialized) { "Initialize SignClient before using it." }

            val dict = params as? Map<*, *> ?: return result.error("Sign.approve", "Invalid parameters: not a map", null)

            val proposal = dict["proposal"] as? String ?: return result.error("Sign.approve", "Invalid parameter proposal", null)
            val approvedNamespaces = dict["approvedNamespaces"] as? String ?: return result.error("Sign.approve", "Invalid parameter approvedNamespaces", null)
            val selfMetadata = dict["selfMetadata"] as? String ?: return result.error("Sign.approve", "Invalid parameter selfMetadata", null)

            CoroutineScope(Dispatchers.IO).launch {
                try {
                    val response: String = signClient.approveJson(
                        proposal = proposal,
                        approvedNamespaces = approvedNamespaces,
                        selfMetadata = selfMetadata,
                    )
                    result.success(response)
                } catch (e: Exception) {
                    result.error("Sign.approve", e.message, null)
                }
            }
        }
    }
}