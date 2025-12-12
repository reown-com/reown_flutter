package com.reown.reown_yttrium

import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import uniffi.yttrium.WalletConnectPay
import uniffi.yttrium.WalletConnectPayJson

class WalletConnectPay {
    companion object {
        private lateinit var walletConnectPay: WalletConnectPayJson

        fun initialize(params: Any?, result: MethodChannel.Result) {
            val jsonString = params as? String ?: return result.error("WalletConnectPay", "Invalid parameters", null)
//            val dict = jsonStringToMap(jsonString)
//            val baseUrl = dict["baseUrl"] as? String ?: return result.error("WalletConnectPay", "Missing baseUrl", null)

            walletConnectPay = WalletConnectPayJson(jsonString)
            result.success(true)
        }

        fun createPayment(params: Any?, result: MethodChannel.Result) {
            val jsonString = params as? String ?: return result.error("WalletConnectPay", "Invalid parameters", null)
//            val dict = jsonStringToMap(jsonString)
//            val referenceId = dict["referenceId"] as? String ?: return result.error("WalletConnectPay", "Missing paymentId", null)
//            val amountUnit = dict["amountUnit"] as? String ?: return result.error("WalletConnectPay", "Missing paymentId", null)
//            val amountValue = dict["amountValue"] as? String ?: return result.error("WalletConnectPay", "Missing paymentId", null)

            CoroutineScope(Dispatchers.IO).launch {
                try {
                    val createPaymentResponse = walletConnectPay.createPayment(jsonString)
                    result.success(createPaymentResponse)
                } catch (e: Exception) {
                    result.error("WalletConnectPay", "getPayment: ${e.message}", null)
                }
            }

        }
    }
}