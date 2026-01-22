package com.walletconnect.walletconnect_pay

import android.util.Log
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import uniffi.yttrium_wcpay.PayJsonException

import uniffi.yttrium_wcpay.WalletConnectPayJson

class WalletConnectPayClient {
    companion object {
        private lateinit var walletConnectPayClient: WalletConnectPayJson

        private fun handlePayJsonException(e: PayJsonException, result: MethodChannel.Result) {
            val errorCode = e::class.simpleName ?: "PayError"
            result.error(errorCode, e.message, null)
        }

        fun initialize(params: Any?, result: MethodChannel.Result) {
            val sdkConfig = params as? String ?: return result.error("PayError", "Invalid init parameters: $params", null)
            Log.d("🤖 WalletConnectPayClient.initialize", "sdkConfig: $sdkConfig")

            try {
                walletConnectPayClient = WalletConnectPayJson(sdkConfig)
                result.success(true)
            } catch (e: PayJsonException) {
                handlePayJsonException(e, result)
            } catch (e: Exception) {
                Log.d("🤖 WalletConnectPayClient.initialize", "❌: ${e.message}")
                result.error("PayError", e.message, null)
            }
        }

        fun getPaymentOptions(params: Any?, result: MethodChannel.Result) {
            val requestJson = params as? String ?: return result.error("PayError", "Invalid getPaymentOptions parameters: $params", null)
            Log.d("🤖 WalletConnectPayClient.getPaymentOptions", "requestJson: $requestJson")

            CoroutineScope(Dispatchers.IO).launch {
                try {
                    val createPaymentResponse = walletConnectPayClient.getPaymentOptions(requestJson)
                    result.success(createPaymentResponse)
                } catch (e: PayJsonException) {
                    handlePayJsonException(e, result)
                } catch (e: Exception) {
                    Log.d("🤖 WalletConnectPayClient.getPaymentOptions", "❌: ${e.message}")
                    result.error("PayError", e.message, null)
                }
            }

        }

        fun getRequiredPaymentActions(params: Any?, result: MethodChannel.Result) {
            val requestJson = params as? String ?: return result.error("PayError", "Invalid getRequiredPaymentActions parameters: $params", null)
            Log.d("🤖 WalletConnectPayClient.getRequiredPaymentActions", "requestJson: $requestJson")

            CoroutineScope(Dispatchers.IO).launch {
                try {
                    val createPaymentResponse = walletConnectPayClient.getRequiredPaymentActions(requestJson)
                    result.success(createPaymentResponse)
                } catch (e: PayJsonException) {
                    handlePayJsonException(e, result)
                } catch (e: Exception) {
                    Log.d("🤖 WalletConnectPayClient.getRequiredPaymentActions", "❌: ${e.message}")
                    result.error("PayError", e.message, null)
                }
            }

        }

        fun confirmPayment(params: Any?, result: MethodChannel.Result) {
            val requestJson = params as? String ?: return result.error("PayError", "Invalid confirmPayment parameters: $params", null)
            Log.d("🤖 WalletConnectPayClient.confirmPayment", "requestJson: $requestJson")

            CoroutineScope(Dispatchers.IO).launch {
                try {
                    val createPaymentResponse = walletConnectPayClient.confirmPayment(requestJson)
                    result.success(createPaymentResponse)
                } catch (e: PayJsonException) {
                    handlePayJsonException(e, result)
                } catch (e: Exception) {
                    Log.d("🤖 WalletConnectPayClient.confirmPayment", "❌: ${e.message}")
                    result.error("PayError", e.message, null)
                }
            }

        }
    }
}