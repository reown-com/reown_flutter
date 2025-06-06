package com.reown.reown_yttrium

import android.content.Context

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

class ReownYttriumPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var applicationContext: Context // ✅ Store application context

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    applicationContext = flutterPluginBinding.applicationContext // ✅ Get application context
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "reown_yttrium")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      // Chain Abstraction methods
      "ca_init" -> ChainAbstraction.initialize(applicationContext.packageName, call.arguments, result)
      "ca_erc20TokenBalance" -> ChainAbstraction.erc20TokenBalance(call.arguments, result)
      "ca_estimateFees" -> ChainAbstraction.estimateFees(call.arguments, result)
      "ca_prepareDetailed" -> ChainAbstraction.prepareDetailed(call.arguments, result)
      "ca_execute" -> ChainAbstraction.execute(call.arguments, result)
      // Sui methods
      "sui_init" -> Sui.initialize(applicationContext.packageName, call.arguments, result)
      "sui_generateKeyPair" -> Sui.generateKeyPair(result)
      "sui_getPublicKeyFromKeyPair" -> Sui.getPublicKeyFromKeyPair(call.arguments, result)
      "sui_getAddressFromPublicKey" -> Sui.getAddressFromPublicKey(call.arguments, result)
      "sui_personalSign" -> Sui.personalSign(call.arguments, result)
      "sui_signTransaction" -> Sui.signTransaction(call.arguments, result)
      "sui_signAndExecuteTransaction" -> Sui.signAndExecuteTransaction(call.arguments, result)
      //
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
