package com.walletconnect.walletconnect_pay

import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
//import uniffi.yttrium.WalletConnectPay
import uniffi.yttrium.WalletConnectPayJson

class WalletConnectPayClient {
    companion object {
        private lateinit var walletConnectPayClient: WalletConnectPayJson
//        private lateinit var walletConnectPay: WalletConnectPay

        fun initialize(params: Any?, result: MethodChannel.Result) {
            val sdkConfig = params as? String ?: return result.error("WalletConnectPay.initialize", "Invalid parameters: $params", null)

            walletConnectPayClient = WalletConnectPayJson(sdkConfig)
            result.success(true)
        }

        fun getPaymentOptions(params: Any?, result: MethodChannel.Result) {
            val requestJson = params as? String ?: return result.error("WalletConnectPay.getPaymentOptions", "Invalid parameters: $params", null)

            CoroutineScope(Dispatchers.IO).launch {
                try {
                    val createPaymentResponse = walletConnectPayClient.getPaymentOptions(requestJson)
                    result.success(createPaymentResponse)
                } catch (e: Exception) {
                    result.error("WalletConnectPay", "getPaymentOptions error: ${e.message}", null)
                }
            }

        }

        fun getRequiredPaymentActions(params: Any?, result: MethodChannel.Result) {
            val requestJson = params as? String ?: return result.error("WalletConnectPay.getRequiredPaymentActions", "Invalid parameters: $params", null)

            CoroutineScope(Dispatchers.IO).launch {
                try {
                    val createPaymentResponse = walletConnectPayClient.getRequiredPaymentActions(requestJson)
                    result.success(createPaymentResponse)
                } catch (e: Exception) {
                    result.error("WalletConnectPay", "getRequiredPaymentActions error: ${e.message}", null)
                }
            }

        }

        fun confirmPayment(params: Any?, result: MethodChannel.Result) {
            val requestJson = params as? String ?: return result.error("WalletConnectPay.confirmPayment", "Invalid parameters: $params", null)

            CoroutineScope(Dispatchers.IO).launch {
                try {
                    val createPaymentResponse = walletConnectPayClient.confirmPayment(requestJson)
                    result.success(createPaymentResponse)
                } catch (e: Exception) {
                    result.error("WalletConnectPay", "confirmPayment error: ${e.message}", null)
                }
            }

        }
    }
}