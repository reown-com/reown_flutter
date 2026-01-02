package com.walletconnect.walletconnect_pay

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** WalletconnectPayPlugin */
class WalletconnectPayPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "walletconnect_pay")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "initialize" -> WalletConnectPayClient.initialize(call.arguments, result)
            "confirmPayment" -> WalletConnectPayClient.confirmPayment(call.arguments, result)
            "getPaymentOptions" -> WalletConnectPayClient.getPaymentOptions(call.arguments, result)
            "getRequiredPaymentActions" -> WalletConnectPayClient.getRequiredPaymentActions(call.arguments, result)
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
