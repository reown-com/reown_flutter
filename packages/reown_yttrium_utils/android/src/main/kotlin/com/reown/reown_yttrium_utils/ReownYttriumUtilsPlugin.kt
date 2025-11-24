package com.reown.reown_yttrium_utils

import android.content.Context

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** ReownYttriumUtilsPlugin */
class ReownYttriumUtilsPlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var channel : MethodChannel
  private lateinit var applicationContext: Context // ✅ Store application context

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    applicationContext = flutterPluginBinding.applicationContext // ✅ Get application context
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "reown_yttrium_utils")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      // === CHAIN ABSTRACTION METHODS ===
      "ca_init" -> ChainAbstraction.initialize(applicationContext, call.arguments, result)
      "ca_erc20TokenBalance" -> ChainAbstraction.erc20TokenBalance(call.arguments, result)
      "ca_estimateFees" -> ChainAbstraction.estimateFees(call.arguments, result)
      "ca_prepareDetailed" -> ChainAbstraction.prepareDetailed(call.arguments, result)
      "ca_execute" -> ChainAbstraction.execute(call.arguments, result)
      // === STACKS METHODS ===
      "stx_init" -> Stacks.init(applicationContext, call.arguments, result)
      "stx_generateWallet" -> Stacks.generateWallet(call.arguments, result)
      "stx_getAddress" -> Stacks.getAddress(call.arguments, result)
      "stx_signMessage" -> Stacks.signMessage(call.arguments, result)
      "stx_transferStx" -> Stacks.transferStx(call.arguments, result)
      "stx_getAccount" -> Stacks.getAccount(call.arguments, result)
      "stx_transferFeeRate" -> Stacks.transferFeeRate(call.arguments, result)
      // "stx_estimateFees" -> Stacks.estimateFees(call.arguments, result)
      // "stx_getNonce" -> Stacks.getNonce(call.arguments, result)
      "stx_dispose" -> Stacks.dispose(call.arguments, result)
      // === SUI METHODS ===
      "sui_init" -> Sui.init(applicationContext, call.arguments, result)
      "sui_generateKeyPair" -> Sui.generateKeyPair(call.arguments, result)
      "sui_getPublicKeyFromKeyPair" -> Sui.getPublicKeyFromKeyPair(call.arguments, result)
      "sui_getAddressFromPublicKey" -> Sui.getAddressFromPublicKey(call.arguments, result)
      "sui_personalSign" -> Sui.personalSign(call.arguments, result)
      "sui_signTransaction" -> Sui.signTransaction(call.arguments, result)
      "sui_signAndExecuteTransaction" -> Sui.signAndExecuteTransaction(call.arguments, result)
      "sui_dispose" -> Sui.dispose(call.arguments, result)
      // === TON METHODS ===
      "ton_init" -> Ton.init(applicationContext, call.arguments, result)
      "ton_generateKeypair" -> Ton.generateKeypair(call.arguments, result)
      "ton_generateKeypairFromTonMnemonic" -> Ton.generateKeypairFromTonMnemonic(call.arguments, result)
      "ton_generateKeypairFromBip39Mnemonic" -> Ton.generateKeypairFromBip39Mnemonic(call.arguments, result)
      "ton_getAddressFromKeypair" -> Ton.getAddressFromKeypair(call.arguments, result)
      "ton_signData" -> Ton.signData(call.arguments, result)
      "ton_sendMessage" -> Ton.sendMessage(call.arguments, result)
      "ton_broadcastMessage" -> Ton.broadcastMessage(call.arguments, result)
      "ton_dispose" -> Ton.dispose(call.arguments, result)
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
