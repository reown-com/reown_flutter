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
import uniffi.uniffi_yttrium.ChainAbstractionClient
import uniffi.uniffi_yttrium.Eip1559Estimation
import uniffi.yttrium.Call
import uniffi.yttrium.Currency
import uniffi.yttrium.PrepareDetailedResponse
import uniffi.yttrium.PrepareDetailedResponseSuccess
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

  private lateinit var chainAbstractionClient: ChainAbstractionClient

  private var pendingPrepareDetailed: MutableMap<String, UiFields> = mutableMapOf()

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    applicationContext = flutterPluginBinding.applicationContext // ✅ Get application context
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "reown_yttrium")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "ca_init" -> caInitialize(call.arguments, result)
      "ca_erc20TokenBalance" -> caErc20TokenBalance(call.arguments, result)
      "ca_estimateFees" -> caEstimateFees(call.arguments, result)
      "ca_prepareDetailed" -> caPrepareDetailed(call.arguments, result)
      "ca_execute" -> caExecute(call.arguments, result)
      else -> result.notImplemented()
    }
  }

  private fun caInitialize(params: Any?, result: Result) {
    val dict = params as? Map<*, *> ?: return result.error("initialize", "Invalid parameters: not a map", null)

    val projectId = dict["projectId"] as? String ?: return errorMissing("projectId", params, result)
    val pulseMetadataDict = dict["pulseMetadata"] as? Map<*, *> ?: return errorMissing("pulseMetadata", params, result)

    val url = pulseMetadataDict["url"] as? String ?: return errorMissing("url", params, result)
    val packageName = pulseMetadataDict["packageName"] as? String ?: return errorMissing("packageName", params, result)
    val sdkVersion = pulseMetadataDict["sdkVersion"] as? String ?: return errorMissing("sdkVersion", params, result)
    val sdkPlatform = pulseMetadataDict["sdkPlatform"] as? String ?: return errorMissing("sdkPlatform", params, result)

    val finalPackageName = applicationContext.packageName ?: packageName
    val pulseMetadata = PulseMetadata(url, finalPackageName, sdkVersion, sdkPlatform)

    chainAbstractionClient = ChainAbstractionClient(projectId = projectId, pulseMetadata = pulseMetadata)

    result.success(true)
  }

  private fun caErc20TokenBalance(params: Any?, result: Result) {
    println("erc20TokenBalance called with $params")

    val dict = params as? Map<*, *> ?: return result.error("erc20TokenBalance", "Invalid parameters: not a map", null)

    val tokenAddress = dict["token"] as? String ?: return errorMissing("token", params, result)
    val ownerAddress = dict["owner"] as? String ?: return errorMissing("owner", params, result)
    val chainId = dict["chainId"] as? String ?: return errorMissing("chainId", params, result)

    CoroutineScope(Dispatchers.IO).launch {
      try {
        val balanceResponse = chainAbstractionClient.erc20TokenBalance(chainId, tokenAddress, ownerAddress)
        println("erc20TokenBalance response $balanceResponse")
        result.success(balanceResponse)
      } catch (e: Exception) {
        result.error("erc20TokenBalance", "Yttrium erc20TokenBalance Error: ${e.message}", null)
      }
    }
  }

  private fun caEstimateFees(params: Any?, result: Result) {
    println("estimateFees called with $params")

    (params as? Map<*, *>)?.let { dict ->
      val chainId = dict["chainId"] as? String

      if (chainId != null) {
        CoroutineScope(Dispatchers.IO).launch {
          try {
            val feesResponse: Eip1559Estimation = chainAbstractionClient.estimateFees(chainId)
            println("estimateFees response $feesResponse")
            result.success(feesResponse.toMap())
          } catch (e: Exception) {
            result.error("estimateFees", "Yttrium estimateFees Error: ${e.message}", null)
          }
        }
        return
      }
    }

    result.error("estimateFees", "Invalid parameters $params", null)
  }

  private fun caPrepareDetailed(params: Any?, result: Result) {
    println("prepareDetailed called with $params")

    val dict = params as? Map<*, *> ?: return result.error("prepareDetailed", "Invalid parameters: not a map", null)

    val chainId = dict["chainId"] as? String ?: return errorMissing("chainId", params, result)
    val from = dict["from"] as? String ?: return errorMissing("from", params, result)
    val accounts = (dict["accounts"] as? List<*>)?.filterIsInstance<String>() ?: return errorMissing("accounts", params, result)
    val call = dict["call"] as? Map<*, *> ?: return errorMissing("call", params, result)
    val to = call["to"] as? String ?: return errorMissing("call.to", params, result)
    val value = call["value"] as? String ?: return errorMissing("call.value", params, result)
    val input = call["input"] as? String ?: return errorMissing("call.input", params, result)
    val localCurrency = dict["localCurrency"] as? String ?: return errorMissing("localCurrency", params, result)
    val useLifi = dict["useLifi"] as? Boolean ?: return errorMissing("useLifi", params, result)

    CoroutineScope(Dispatchers.IO).launch {
      val response = chainAbstractionClient.prepareDetailed(
        chainId = chainId,
        from = from,
        accounts = accounts,
        call = Call(
          to = to,
          value = value,
          input = input
        ),
        localCurrency = Currency.valueOf(localCurrency.uppercase()),
        useLifi = useLifi,
      )

      when (response) {
        is PrepareDetailedResponse.Success -> {
          when (val success = response.v1) {
            is PrepareDetailedResponseSuccess.Available -> {
              val uiFields = success.v1
              pendingPrepareDetailed[uiFields.routeResponse.orchestrationId] = uiFields
              println("prepareDetailed response $uiFields")
              result.success(mapOf("available" to uiFields.toMap()))
            }
            is PrepareDetailedResponseSuccess.NotRequired -> {
              val notRequired = success.v1
              println("prepareDetailed notRequired $notRequired")
              result.success(mapOf("notRequired" to notRequired.toMap()))
            }
          }
        }
        is PrepareDetailedResponse.Error -> {
          println("prepareDetailed: error -> ${response.v1}")
          result.success(response.v1.toMap())
        }
      }
    }
  }

  private fun caExecute(params: Any?, result: Result) {
    println("execute called with $params")

    val dict = params as? Map<*, *> ?: return result.error("execute", "Invalid parameters: not a map", null)

    val orchestrationId = dict["orchestrationId"] as? String ?: return errorMissing("orchestrationId", params, result)
    val routeTxnSigs = (dict["routeTxnSigs"] as? List<*>)?.filterIsInstance<uniffi.yttrium.RouteSig>()
      ?: return errorMissing("routeTxnSigs", params, result)
    val initialTxnSig = dict["initialTxnSig"] as? String ?: return errorMissing("initialTxnSig", params, result)

    CoroutineScope(Dispatchers.IO).launch {
      try {
        val prepareDetailedResult = pendingPrepareDetailed[orchestrationId]
        val executionResult = prepareDetailedResult?.let {
          chainAbstractionClient.execute(
            uiFields = it,
            routeTxnSigs = routeTxnSigs,
            initialTxnSig = initialTxnSig
          )
        }

        println("execute response $executionResult")
        pendingPrepareDetailed.remove(orchestrationId)
        result.success(executionResult?.toMap())
      } catch (e: Exception) {
        println("execute error: $e")
        result.error("execute", "Yttrium execute Error: ${e.message}", null)
      }
    }
  }

  private fun errorMissing(key: String, originalParams: Any?, result: Result): Nothing {
    result.error("prepareDetailed", "Missing or invalid parameter: $key in $originalParams", null)
    throw IllegalArgumentException("Missing parameter: $key") // stops execution
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
