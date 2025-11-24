package com.reown.reown_yttrium

import android.annotation.SuppressLint
import android.content.Context
import android.util.Log
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import uniffi.yttrium.Erc6492Client
import kotlin.collections.get

class EIP6492Verifier(private val projectId: String, private val networkId: String) {
    private val erc6492Client: Erc6492Client = Erc6492Client(
        "https://rpc.walletconnect.com/v1?chainId=$networkId&projectId=$projectId"
    )

    // ---------------------------------------------------------
    // INSTANCE: verifySignature
    // ---------------------------------------------------------
    private fun verifySignature(dict: Map<*, *>, result: MethodChannel.Result) {
        val signature = dict["signature"] as? String ?: return result.error("verifySignature", "Missing signature", null)
        val address = dict["address"] as? String ?: return result.error("verifySignature", "Missing address", null)
        val hexStringPrefixedMessageHash = dict["hexStringPrefixedMessageHash"] as? String ?: return result.error("verifySignature", "Missing hexStringPrefixedMessageHash", null)

        CoroutineScope(Dispatchers.IO).launch {
            try {
                val verificationResult = erc6492Client.verifySignature(
                    signature = signature,
                    address = address,
                    messageHash = hexStringPrefixedMessageHash
                )
                result.success(verificationResult)
            } catch (e: Exception) {
                result.error("Erc6492Client.verifySignature", e.message, null)
            }
        }
    }

    @SuppressLint("LongLogTag")
    fun dispose() {
        Log.d("🤖 EIP6492Verifier.dispose", "Erc6492Client TonClient for network: $networkId")
    }

    // ---------------------------------------------------------
    // COMPANION OBJECT — multi-instance registry
    // ---------------------------------------------------------
    companion object {
        private val clients = mutableMapOf<String, EIP6492Verifier>()

        fun init(params: Any?, result: MethodChannel.Result) {
            val dict = params as? Map<*, *> ?: return result.error("erc6492_init", "Invalid parameters", null)
            Log.d("🤖 EIP6492Verifier.init", "params: $dict")

            val projectId = dict["projectId"] as? String ?: return errorMissing("projectId", params, result)
            val networkId = dict["networkId"] as? String ?: return errorMissing("networkId", params, result)

            val instance = EIP6492Verifier(projectId, networkId)
            clients[networkId] = instance
            result.success(true)
        }

        private fun getClient(networkId: String, result: MethodChannel.Result): EIP6492Verifier? {
            val client = clients[networkId]
            if (client == null) result.error("EIP6492Verifier", "networkId '$networkId' not found", null)
            return client
        }

        // ---------------------------------------------------------
        // STATIC ENTRYPOINT
        // ---------------------------------------------------------

        @SuppressLint("LongLogTag")
        fun verifySignature(params: Any?, result: MethodChannel.Result) {
            val dict = params as? Map<*, *> ?: return result.error("erc6492_verify", "Invalid parameters", null)
            Log.d("🤖 EIP6492Verifier.verifySignature", "params: $dict")

            val networkId = dict["networkId"] as? String ?: return result.error("erc6492_verify", "Missing networkId", null)
            getClient(networkId, result)?.verifySignature(dict, result)
        }

        fun dispose(params: Any?, result: MethodChannel.Result) {
            val dict = params as? Map<*, *> ?: return result.error("erc6492_dispose", "Invalid parameters", null)
            val networkId = dict["networkId"] as? String ?: return result.error("erc6492_dispose", "Missing networkId", null)
            clients.remove(networkId)?.dispose()
            result.success(true)
        }
    }
}
