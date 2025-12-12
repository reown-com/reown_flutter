package com.reown.reown_yttrium

import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import uniffi.yttrium.WalletConnectPayJson

class WalletConnectPay {
    companion object {
        private lateinit var walletConnectPay: WalletConnectPayJson

        fun initialize(params: Any?, result: MethodChannel.Result) {
            val baseUrl = params as? String ?: return result.error("WalletConnectPay", "Invalid parameters", null)
            walletConnectPay = WalletConnectPayJson(baseUrl)
            result.success(true)
        }

        fun createPayment(params: Any?, result: MethodChannel.Result) {
            val requestJson = params as? String ?: return result.error("WalletConnectPay", "Invalid parameters", null)

            CoroutineScope(Dispatchers.IO).launch {
                try {
                    val createPaymentResponse = walletConnectPay.createPayment(requestJson)
                    result.success(createPaymentResponse)
                } catch (e: Exception) {
                    result.error("WalletConnectPay", "getPayment: ${e.message}", null)
                }
            }

        }
    }
}