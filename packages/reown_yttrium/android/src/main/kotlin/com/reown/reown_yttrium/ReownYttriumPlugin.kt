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
          val pulseMetadata = PulseMetadata(url, packageNAME, sdkVersion, sdkPlatform)

          client = ChainAbstractionClient(projectId, pulseMetadata)
          result.success(true)
          return
        }
      }
    }

    // If any required field is missing, return an error
    result.error("initialize", "Invalid parameters", params)
  }

  private fun erc20TokenBalance(params: Any?, result: Result) {
    println("erc20TokenBalance called with $params")

    (params as? Map<*, *>)?.let { dict ->
      val tokenAddress = dict["token"] as? String
      val ownerAddress = dict["owner"] as? String
      val chainId = dict["chainId"] as? String

      if (tokenAddress != null && ownerAddress != null && chainId != null) {
        CoroutineScope(Dispatchers.IO).launch {
          try {
            val balanceResponse = client.erc20TokenBalance(chainId, tokenAddress, ownerAddress)
            println("erc20TokenBalance response $balanceResponse")
            result.success(balanceResponse)

          } catch (e: Exception) {
            result.error("erc20TokenBalance", "Yttrium erc20TokenBalance Error: ${e.message}", null)
          }
        }
        return
      }
    }

    result.error("erc20TokenBalance", "Invalid parameters", params)
  }

  private fun estimateFees(params: Any?, result: Result) {
    println("estimateFees called with $params")

    (params as? Map<*, *>)?.let { dict ->
      val chainId = dict["chainId"] as? String

      if (chainId != null) {
        CoroutineScope(Dispatchers.IO).launch {
          try {
            val feesResponse: Eip1559Estimation = client.estimateFees(chainId)
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

  private fun prepareDetailed(params: Any?, result: Result) {
    println("prepareDetailed called with $params")

    (params as? Map<*, *>)?.let { dict ->
      val chainId = dict["chainId"] as? String
      val from = dict["from"] as? String
      val accounts = (dict["accounts"] as? List<*>)?.filterIsInstance<String>()
      val call = dict["call"] as? Map<*, *>
      val to = call?.get("to") as? String
      val value = call?.get("value") as? String
      val input = call?.get("input") as? String
      val localCurrency = dict["localCurrency"] as? String
      val useLifi = dict["useLifi"] as? Boolean

      if (chainId != null && from != null && call != null && to != null && value != null && input != null && localCurrency != null) {
        CoroutineScope(Dispatchers.IO).launch {
          val response = client.prepareDetailed(
            chainId = chainId,
            from = from,
            accounts = accounts!!,
            call = Call(
              to = to,
              value = value,
              input = input
            ),
            localCurrency = Currency.valueOf(localCurrency.uppercase()),
            useLifi = useLifi!!,
          )

          when (response) {
            is PrepareDetailedResponse.Success -> {
              when (response.v1) {
                is PrepareDetailedResponseSuccess.Available -> {
                  val uiFields: UiFields = (response.v1 as PrepareDetailedResponseSuccess.Available).v1
                  pendingPrepareDetailed[uiFields.routeResponse.orchestrationId] =  uiFields
                  println("prepareDetailed response $uiFields")
                  result.success(mapOf("available" to uiFields.toMap()))
                }
                is PrepareDetailedResponseSuccess.NotRequired -> {
                  val notRequired = (response.v1 as PrepareDetailedResponseSuccess.NotRequired).v1
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
        return
      }
    }

    result.error("prepareDetailed", "Invalid parameters $params", null)
  }

  private fun execute(params: Any?, result: Result) {
    println("execute called with $params")

    (params as? Map<*, *>)?.let { dict ->
      val orchestrationId = dict["orchestrationId"] as? String
      val routeTxnSigs = (dict["routeTxnSigs"] as? List<*>)?.filterIsInstance<uniffi.yttrium.RouteSig>()
      val initialTxnSig = dict["initialTxnSig"] as? String

      if (orchestrationId != null && routeTxnSigs != null && initialTxnSig != null) {
        CoroutineScope(Dispatchers.IO).launch {
          try {
            val prepareDetailedResult = pendingPrepareDetailed[orchestrationId]
            val executionResult = prepareDetailedResult?.let {
              client.execute(
                uiFields = it,
                routeTxnSigs = routeTxnSigs,
                initialTxnSig = initialTxnSig
              )
            }

            println("execute response $executionResult")
            pendingPrepareDetailed.remove(orchestrationId)
            result.success(executionResult?.toMap())

          } catch (e: Exception) {
            println("execute response $e")
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
