package com.reown.reown_yttrium

import android.util.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import uniffi.yttrium.Logger
import uniffi.yttrium.registerLogger

class ReownYttriumPlugin : FlutterPlugin, MethodCallHandler {
  private lateinit var methodChannel: MethodChannel

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    Sign.setEventChannel(flutterPluginBinding.binaryMessenger)
    ChainAbstraction.setApplicationContext(flutterPluginBinding.applicationContext)

    methodChannel = MethodChannel(flutterPluginBinding.binaryMessenger, "reown_yttrium")
    methodChannel.setMethodCallHandler(this)

    android.os.Handler(android.os.Looper.getMainLooper()).post {
      registerLogger(RustLogger())
    }
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      // Chain Abstraction methods
      "ca_init" -> ChainAbstraction.initialize(call.arguments, result)
      "ca_erc20TokenBalance" -> ChainAbstraction.erc20TokenBalance(call.arguments, result)
      "ca_estimateFees" -> ChainAbstraction.estimateFees(call.arguments, result)
      "ca_prepareDetailed" -> ChainAbstraction.prepareDetailed(call.arguments, result)
      "ca_execute" -> ChainAbstraction.execute(call.arguments, result)
      //
      // Sign methods
      "sign_init" -> Sign.initialize(call.arguments, result)
      "sign_generateKey" -> Sign.generateKey(result)
      "sign_pair" -> Sign.pair(call.arguments, result)
      "sign_approve" -> Sign.approve(call.arguments, result)
      "sign_reject" -> Sign.reject(call.arguments, result)
      "sign_respond" -> Sign.respond(call.arguments, result)
//      "sign_respond_error" -> Sign.respondError(call.arguments, result)
      //
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    methodChannel.setMethodCallHandler(null)
  }
}

class RustLogger: Logger {
  override fun log(message: String) {
    Log.d("🧪 RustLogger", message)
  }
}