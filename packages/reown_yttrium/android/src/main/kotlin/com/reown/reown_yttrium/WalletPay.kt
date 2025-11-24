package com.reown.reown_yttrium

import android.annotation.SuppressLint
import android.util.Log
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import uniffi.yttrium.DisplayData
import uniffi.yttrium.WalletPayAction
import uniffi.yttrium.WalletPayRequest
import uniffi.yttrium.WalletPayResponseResultV1
import uniffi.yttrium.createWalletPayRequest

class WalletPay {
    companion object {
        private var walletPayRequest: WalletPayRequest? = null

        @SuppressLint("LongLogTag")
        fun createWalletPay(params: Any?, result: MethodChannel.Result) {
            val dict = params as? Map<*, *> ?: return result.error("WalletPay.createWalletPay", "Invalid parameters", null)
            Log.d("🤖 WalletPay.createWalletPay", "params: $dict")

            val rawData = dict["rawData"] as? String ?: return errorMissing("rawData", params, result)

            CoroutineScope(Dispatchers.IO).launch {
                try {
                    walletPayRequest = createWalletPayRequest(rawData = rawData)
                    result.success(true)
                } catch (e: Exception) {
                    Log.e("🤖 WalletPay.createWalletPay", "Error: ${e.message}")
                    result.error("WalletPay.createWalletPay", e.message, null)
                }
            }
        }

        @SuppressLint("LongLogTag")
        fun getDisplayData(result: MethodChannel.Result) {
            if (walletPayRequest == null) {
                result.error("WalletPay.getDisplayData", "No WalletPayRequest. Call first createWalletPay.", null)
                return
            }

            CoroutineScope(Dispatchers.IO).launch {
                try {
                    val displayData: DisplayData = walletPayRequest!!.getDisplayData()
                    result.success(displayData.toMap())
                } catch (e: Exception) {
                    Log.e("🤖 WalletPay.getDisplayData", "Error: ${e.message}")
                    result.error("WalletPay.getDisplayData", e.message, null)
                }
            }
        }

        @SuppressLint("LongLogTag")
        fun getPaymentAction(params: Any?, result: MethodChannel.Result) {
            if (walletPayRequest == null) {
                result.error("WalletPay.getPaymentAction", "No WalletPayRequest. Call first createWalletPay.", null)
                return
            }

            val dict = params as? Map<*, *> ?: return result.error("WalletPay.getPaymentAction", "Invalid parameters", null)
            Log.d("🤖 WalletPay.getPaymentAction", "params: $dict")

            val optionIndex = dict["optionIndex"] as? String ?: return errorMissing("optionIndex", params, result)

            CoroutineScope(Dispatchers.IO).launch {
                try {
                    val paymentAction: WalletPayAction = walletPayRequest!!.getPaymentAction(optionIndex = optionIndex.toULong())
                    result.success(paymentAction.toMap())
                } catch (e: Exception) {
                    Log.e("🤖 WalletPay.getPaymentAction", "Error: ${e.message}")
                    result.error("WalletPay.getPaymentAction", e.message, null)
                }
            }
        }

        @SuppressLint("LongLogTag")
        fun getActionFromPaymentOption(params: Any?, result: MethodChannel.Result) {
            if (walletPayRequest == null) {
                result.error("WalletPay.getActionFromPaymentOption", "No WalletPayRequest. Call first createWalletPay.", null)
                return
            }

            val dict = params as? Map<*, *> ?: return result.error("WalletPay.getActionFromPaymentOption", "Invalid parameters", null)
            Log.d("🤖 WalletPay.getActionFromPaymentOption", "params: $dict")

            val paymentOption = dict["paymentOption"] as? Map<*, *> ?: return errorMissing("paymentOption", params, result)

            CoroutineScope(Dispatchers.IO).launch {
                try {
                    val paymentAction: WalletPayAction = walletPayRequest!!.getActionFromPaymentOption(
                        paymentOption = paymentOption.toPaymentOption()
                    )
                    result.success(paymentAction.toMap())
                } catch (e: Exception) {
                    Log.e("🤖 WalletPay.getActionFromPaymentOption", "Error: ${e.message}")
                    result.error("WalletPay.getActionFromPaymentOption", e.message, null)
                }
            }
        }

        fun finalize(params: Any?, result: MethodChannel.Result) {
            if (walletPayRequest == null) {
                result.error("WalletPay.finalize", "No WalletPayRequest. Call first createWalletPay.", null)
                return
            }

            val dict = params as? Map<*, *> ?: return result.error("WalletPay.finalize", "Invalid parameters", null)
            Log.d("🤖 WalletPay.finalize", "params: $dict")

            val optionIndex = dict["optionIndex"] as? String ?: return errorMissing("optionIndex", params, result)
            val signature = dict["signature"] as? String ?: return errorMissing("signature", params, result)

            CoroutineScope(Dispatchers.IO).launch {
                try {
                    val walletPayResult: WalletPayResponseResultV1 = walletPayRequest!!.finalize(
                        optionIndex = optionIndex.toULong(),
                        signature = signature,
                    )
                    walletPayRequest = null
                    result.success(walletPayResult.toMap())
                } catch (e: Exception) {
                    Log.e("🤖 WalletPay.finalize", "Error: ${e.message}")
                    result.error("WalletPay.finalize", e.message, null)
                }
            }
        }

        fun dispose(result: MethodChannel.Result) {
            if (walletPayRequest == null) {
                result.error("WalletPay.dispose", "No WalletPayRequest. Call first createWalletPay.", null)
                return
            }

            walletPayRequest = null
            result.success(true)
        }
    }
}