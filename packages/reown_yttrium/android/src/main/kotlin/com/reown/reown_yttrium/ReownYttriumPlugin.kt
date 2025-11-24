package com.reown.reown_yttrium

import android.content.Context

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** ReownYttriumPlugin */
class ReownYttriumPlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var channel : MethodChannel
  private lateinit var applicationContext: Context // ✅ Store application context

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    applicationContext = flutterPluginBinding.applicationContext // ✅ Get application context
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "reown_yttrium")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      // === ERC6492 SIGNATURE VERIFICATION ===
      "erc6492_init" -> EIP6492Verifier.init(call.arguments, result)
      "erc6492_verify" -> EIP6492Verifier.verifySignature(call.arguments, result)
      "erc6492_dispose" -> EIP6492Verifier.dispose(call.arguments, result)
      // === WALLET_PAY ===
      "wallet_pay_createWalletPay" -> WalletPay.createWalletPay(call.arguments, result)
      "wallet_pay_getDisplayData" -> WalletPay.getDisplayData(result)
      "wallet_pay_getPaymentAction" -> WalletPay.getPaymentAction(call.arguments, result)
      "wallet_pay_getActionFromPaymentOption" -> WalletPay.getActionFromPaymentOption(call.arguments, result)
      "wallet_pay_finalize" -> WalletPay.finalize(call.arguments, result)
      "wallet_pay_dispose" -> WalletPay.dispose(result)
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
