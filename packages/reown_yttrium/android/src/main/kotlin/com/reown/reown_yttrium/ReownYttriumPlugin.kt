package com.reown.reown_yttrium

import android.content.Context
import androidx.annotation.NonNull
import com.google.gson.Gson
import com.google.gson.JsonElement

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.DelicateCoroutinesApi
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import uniffi.uniffi_yttrium.ChainAbstractionClient
import uniffi.yttrium.Call
import uniffi.yttrium.Currency
import uniffi.yttrium.PrepareDetailedResponse
import uniffi.yttrium.PrepareDetailedResponseSuccess
import uniffi.yttrium.PrepareResponseAvailable
import uniffi.yttrium.PulseMetadata
import uniffi.yttrium.UiFields

/** ReownYttriumPlugin */
class ReownYttriumPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var applicationContext: Context // ✅ Store application context

  private lateinit var client: ChainAbstractionClient
  private var pendingPrepareDetailed: MutableMap<String, UiFields> = mutableMapOf()

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    applicationContext = flutterPluginBinding.applicationContext // ✅ Get application context
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "reown_yttrium")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "init" -> initialize(call.arguments, result)
      "erc20TokenBalance" -> erc20TokenBalance(call.arguments, result)
      "estimateFees" -> estimateFees(call.arguments, result)
      "prepareDetailed" -> prepareDetailed(call.arguments, result)
      "execute" -> execute(call.arguments, result)
      else -> result.notImplemented()
    }
  }

  private fun initialize(params: Any?, result: Result) {
    (params as? Map<*, *>)?.let { dict ->
      val projectId = dict["projectId"] as? String
      val pulseMetadataDict = dict["pulseMetadata"] as? Map<*, *>

      pulseMetadataDict?.let { metadata ->
        val url = metadata["url"] as? String
        val packageName = metadata["packageName"] as? String
        val sdkVersion = metadata["sdkVersion"] as? String
        val sdkPlatform = metadata["sdkPlatform"] as? String

        if (projectId != null && url != null && packageName != null && sdkVersion != null && sdkPlatform != null) {
          val packageNAME = applicationContext.packageName ?: packageName
          val pulseMetadata = PulseMetadata(url, null, packageNAME, sdkVersion, sdkPlatform)

          client = ChainAbstractionClient(projectId, pulseMetadata)
          result.success(true)
          return
        }
      }
    }

    // If any required field is missing, return an error
    result.error("initialize", "Invalid parameters", params)
  }

  private fun erc20TokenBalance(params: Any?, result: MethodChannel.Result) {
    println("erc20TokenBalance called with $params")

    (params as? Map<*, *>)?.let { dict ->
      val tokenAddress = dict["tokenAddress"] as? String
      val ownerAddress = dict["ownerAddress"] as? String
      val chainId = dict["chainId"] as? String

      if (tokenAddress != null && ownerAddress != null && chainId != null) {
        CoroutineScope(Dispatchers.IO).launch {
          try {
            val balanceResponse = client.erc20TokenBalance(chainId, tokenAddress, ownerAddress)

            val gson = Gson()
            val resultJson: JsonElement = gson.toJsonTree(balanceResponse)
            result.success(gson.toJson(resultJson))

          } catch (e: Exception) {
            result.error("getERC20Balance", "Yttrium getERC20Balance Error: ${e.message}", null)
          }
        }
        return
      }
    }


    result.error("getERC20Balance", "Invalid parameters", params)
  }

  private fun estimateFees(params: Any?, result: MethodChannel.Result) {
    println("estimateFees called with $params")

    (params as? Map<*, *>)?.let { dict ->
      val chainId = dict["chainId"] as? String

      if (chainId != null) {
        CoroutineScope(Dispatchers.IO).launch {
          try {
            val feesResponse = client.estimateFees(chainId)

            val gson = Gson()
            val resultJson: JsonElement = gson.toJsonTree(feesResponse)
            result.success(gson.toJson(resultJson))

          } catch (e: Exception) {
            result.error("estimateFees", "Yttrium estimateFees Error: ${e.message}", null)
          }
        }
        return
      }
    }


    // If any parameter is missing, return an error
    result.error("estimateFees", "Invalid parameters", params)
  }

  private fun prepareDetailed(params: Any?, result: MethodChannel.Result) {
    println("prepareDetailed: Hello from YttriumPlugin")
    (params as? Map<*, *>)?.let { dict ->
      val chainId = dict["chainId"] as? String
      val from = dict["from"] as? String
      val call = dict["call"] as? Map<*, *>
      val to = call?.get("to") as? String
      val value = call?.get("value") as? String
      val input = call?.get("input") as? String
      val localCurrency = dict["localCurrency"] as? String

      if (chainId != null && from != null && call != null && to != null && value != null && input != null && localCurrency != null) {
        CoroutineScope(Dispatchers.IO).launch {
          val response = client.prepareDetailed(
            chainId = chainId, from = from, Call(
              to = to,
              value = value,
              input = input
            ), Currency.valueOf(localCurrency),
          )

          when (response) {
            is PrepareDetailedResponse.Success -> {
              when (response.v1) {
                is PrepareDetailedResponseSuccess.Available -> {
                  val availableResult = (response.v1 as PrepareDetailedResponseSuccess.Available).v1
                  pendingPrepareDetailed[availableResult.routeResponse.orchestrationId] =  availableResult
                }
                is PrepareDetailedResponseSuccess.NotRequired -> {
                  println("prepareDetailed: NotRequired")
                }
              }
            }

            is PrepareDetailedResponse.Error -> {
              println("prepareDetailed: error -> ${response.v1.error}")
            }
          }

          val gson = Gson()
          val jsonResult = gson.toJson(response)
          result.success(jsonResult)
        }
        return
      }
    }
  }

  private fun execute(params: Any?, result: MethodChannel.Result) {
    println("execute: Hello from YttriumPlugin")

    (params as? Map<*, *>)?.let { dict ->
      val orchestrationId = dict["orchestrationId"] as? String
      val bridgeSignedTransactions = (dict["bridgeSignedTransactions"] as? List<*>)?.filterIsInstance<String>()
      val initialSignedTransaction = dict["initialSignedTransaction"] as? String

      if (orchestrationId != null && bridgeSignedTransactions != null && initialSignedTransaction != null) {
        CoroutineScope(Dispatchers.IO).launch {
          try {
            val prepareDetailedResult = pendingPrepareDetailed[orchestrationId]
            pendingPrepareDetailed.remove(orchestrationId)

            val executionResult = prepareDetailedResult?.let {
              client.execute(
                uiFields = it,
                routeTxnSigs = bridgeSignedTransactions,
                initialTxnSig = initialSignedTransaction
              )
            }

            val gson = Gson()
            val resultJson: JsonElement = gson.toJsonTree(executionResult)
            result.success(gson.toJson(resultJson))

          } catch (e: Exception) {
            result.error("execute", "Yttrium execute Error: ${e.message}", null)
          }
        }
        return
      }
    }

    result.error("execute", "Invalid parameters", params)
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
