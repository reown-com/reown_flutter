package com.walletconnect.walletconnect_pay

import android.util.Log
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import uniffi.yttrium_wcpay.ConfigException
import uniffi.yttrium_wcpay.GetPaymentOptionsException
import uniffi.yttrium_wcpay.GetPaymentRequestException
import uniffi.yttrium_wcpay.ConfirmPaymentException

import uniffi.yttrium_wcpay.WalletConnectPayJson

class WalletConnectPayClient {
    companion object {
        private lateinit var walletConnectPayClient: WalletConnectPayJson

        fun initialize(params: Any?, result: MethodChannel.Result) {
            val sdkConfig = params as? String ?: return result.error("PayError", "Invalid init parameters: $params", null)
            Log.d("🤖 WalletConnectPayClient.initialize", "sdkConfig: $sdkConfig")

            try {
                walletConnectPayClient = WalletConnectPayJson(sdkConfig)
                result.success(true)
            } catch (e: ConfigException) {
                when (e) {
                    is ConfigException.MissingAuth -> result.error("MissingAuth", e.message, null)
                }
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
                } catch (e: GetPaymentOptionsException) {
                    when (e) {
                        is GetPaymentOptionsException.Http -> result.error("Http", e.message, null)
                        is GetPaymentOptionsException.ComplianceFailed -> result.error("ComplianceFailed", e.message, null)
                        is GetPaymentOptionsException.InternalException -> result.error("InternalException", e.message, null)
                        is GetPaymentOptionsException.InvalidAccount -> result.error("InvalidAccount", e.message, null)
                        is GetPaymentOptionsException.InvalidRequest -> result.error("InvalidRequest", e.message, null)
                        is GetPaymentOptionsException.OptionNotFound -> result.error("OptionNotFound", e.message, null)
                        is GetPaymentOptionsException.PaymentExpired -> result.error("PaymentExpired", e.message, null)
                        is GetPaymentOptionsException.PaymentNotFound -> result.error("PaymentNotFound", e.message, null)
                        is GetPaymentOptionsException.PaymentNotReady -> result.error("PaymentNotReady", e.message, null)
                    }
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
                } catch (e: GetPaymentRequestException) {
                    when (e) {
                        is GetPaymentRequestException.Http -> result.error("Http", e.message, null)
                        is GetPaymentRequestException.FetchException -> result.error("FetchException", e.message, null)
                        is GetPaymentRequestException.InternalException -> result.error("InternalException", e.message, null)
                        is GetPaymentRequestException.InvalidAccount -> result.error("InvalidAccount", e.message, null)
                        is GetPaymentRequestException.OptionNotFound -> result.error("OptionNotFound", e.message, null)
                        is GetPaymentRequestException.PaymentNotFound -> result.error("PaymentNotFound", e.message, null)
                    }
                } catch (e: Exception) {
                    Log.d("🤖 WalletConnectPayClient.getPaymentOptions", "❌: ${e.message}")
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
                } catch (e: ConfirmPaymentException) {
                    when (e) {
                        is ConfirmPaymentException.Http -> result.error("Http", e.message, null)
                        is ConfirmPaymentException.InternalException -> result.error("InternalException", e.message, null)
                        is ConfirmPaymentException.InvalidOption -> result.error("InvalidOption", e.message, null)
                        is ConfirmPaymentException.InvalidSignature -> result.error("InvalidSignature", e.message, null)
                        is ConfirmPaymentException.PaymentExpired -> result.error("PaymentExpired", e.message, null)
                        is ConfirmPaymentException.PaymentNotFound -> result.error("PaymentNotFound", e.message, null)
                        is ConfirmPaymentException.RouteExpired -> result.error("RouteExpired", e.message, null)
                        is ConfirmPaymentException.UnsupportedMethod -> result.error("UnsupportedMethod", e.message, null)
                    }
                } catch (e: Exception) {
                    Log.d("🤖 WalletConnectPayClient.getPaymentOptions", "❌: ${e.message}")
                    result.error("PayError", e.message, null)
                }
            }

        }
    }
}