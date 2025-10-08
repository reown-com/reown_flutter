package com.walletconnect.reown_walletkit

import android.app.Application
import android.content.Context
import android.os.Handler
import android.os.Looper
import android.util.Log
import com.reown.android.Core
import com.reown.android.CoreClient
import com.reown.android.relay.ConnectionType
import com.reown.walletkit.client.Wallet
import com.reown.walletkit.client.WalletKit
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import kotlin.collections.get
import com.reown.walletkit.client.Wallet.Model
import io.flutter.plugin.common.EventChannel

/** ReownWalletkitPlugin */
class ReownWalletkitPlugin : FlutterPlugin, MethodCallHandler, EventChannel.StreamHandler {

    private lateinit var applicationContext: Context // ✅ Store application context
    private lateinit var methodChannel: MethodChannel
    private lateinit var eventChannel: EventChannel

    private var eventChannelSink: EventChannel.EventSink? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        applicationContext = flutterPluginBinding.applicationContext

        methodChannel = MethodChannel(flutterPluginBinding.binaryMessenger, "reown_walletkit/methods")
        methodChannel.setMethodCallHandler(this)

        eventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "reown_walletkit/events")
        eventChannel.setStreamHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "initialize" -> initialize(call.arguments, result)
            "pair" -> pair(call.arguments, result)
            "approveSession" -> approveSession(call.arguments, result)
            "rejectSession" -> rejectSession(call.arguments, result)
            "updateSession" -> updateSession(call.arguments, result)
            "extendSession" -> extendSession(call.arguments, result)
            "respondSessionRequest" -> respondSessionRequest(call.arguments, result)
            "emitSessionEvent" -> emitSessionEvent(call.arguments, result)
            "disconnectSession" -> disconnectSession(call.arguments, result)
            "dispatchEnvelope" -> dispatchEnvelope(call.arguments, result)
            "approveSessionAuthenticate" -> approveSessionAuthenticate(call.arguments, result)
            "rejectSessionAuthenticate" -> rejectSessionAuthenticate(call.arguments, result)
            "formatAuthMessage" -> formatAuthMessage(call.arguments, result)
            "getPendingListOfSessionRequests" -> getPendingListOfSessionRequests(call.arguments, result)
            "getSessionProposals" -> getSessionProposals(result)
            "getActiveSessionByTopic" -> getActiveSessionByTopic(call.arguments, result)
            "getListOfActiveSessions" -> getListOfActiveSessions(result)
            else -> result.notImplemented()
        }
    }

    private fun initialize(params: Any?, result: Result) {
        Log.d("🤖 initialize", params.toString())
        (params as? Map<*, *>)?.let { dict ->
            try {
                val projectId = dict["projectId"] as String
                val metadataDict = dict["metadata"] as Map<*, *>

                metadataDict.let { metadata ->
                    val appMetaData = Core.Model.AppMetaData(
                        name = metadata["name"] as String,
                        description =  metadata["description"] as String,
                        url = metadata["url"] as String,
                        icons = emptyList(),
                        redirect = metadata["redirect"] as? String
                    )
                    CoreClient.initialize(
                        application = applicationContext as Application,
                        projectId = projectId,
                        metaData = appMetaData,
                        connectionType = ConnectionType.AUTOMATIC,
                        telemetryEnabled = true,
                        onError = { error ->
                            Log.d("Initialize", "Error; ${error.throwable.stackTraceToString()}")
                            result.error("initialize", "Error initializing CoreClient: $error", null)
                        }
                    )
                    val initParams = Wallet.Params.Init(core = CoreClient)
                    WalletKit.initialize(
                        initParams,
                        onSuccess = {
                            WalletKit.setWalletDelegate(walletDelegate)
                            result.success(true)
                        },
                        onError = { error ->
                            // Error will be thrown if there's an issue during initialization
                            Log.d("Initialize", "Error; ${error.throwable.stackTraceToString()}")
                            result.error("initialize", "Error initializing WalletKit: $error", null)
                        })
                }
            } catch (e: Exception) {
                result.error("initialize", "Error initializing: ${e.message}", null)
            }
        }
    }

    private fun pair(params: Any?, result: Result) {
        Log.d("🤖 pair", params.toString())
        (params as? Map<*, *>)?.let { dict ->
            try {
                val pairingUri = params["uri"] as String
                val cleanUri = pairingUri.replaceFirst("wc:", "wc://")
                val pairParams = Wallet.Params.Pair(uri = cleanUri)
                WalletKit.pair(
                    pairParams,
                    onSuccess = { params ->
                        Log.d("🤖 pair", "success")
                        result.success(pairParams.uri.replaceFirst("wc://", "wc:")) },
                    onError = { error ->
                        Log.d("🤖 pair", "onError: $error")
                        result.error("pair", "Error pairing uri ${pairParams.uri}: $error", null)
                    })
            } catch (e: Exception) {
                result.error("pair", "Error pairing uri: ${e.message}", null)
            }
        }
    }

    private fun approveSession(params: Any?, result: Result) {
        Log.d("🤖 approveSession", params.toString())
        (params as? Map<*, *>)?.let { dict ->
            try {
                val proposalPublicKey = dict["proposalPublicKey"] as String
                val sessionProposal = WalletKit.getSessionProposals().find { it.proposerPublicKey == proposalPublicKey }

                if (sessionProposal != null) {
                    val namespaces = dict["namespaces"] as Map<*, *>
                    val sessionProperties = dict["sessionProperties"] as? Map<*, *>
                    val scopedProperties = dict["scopedProperties"] as? Map<*, *>

                    val approveProposal = Wallet.Params.SessionApprove(
                        proposerPublicKey = sessionProposal.proposerPublicKey,
                        namespaces = namespaces.toSessionNamespaceMap(),
                        properties = sessionProperties.toStringMap(),
                        scopedProperties = scopedProperties.toStringMap()
                    )

                    WalletKit.approveSession(
                        approveProposal,
                        onError = { error ->
                            Log.d("🤖 approveSession", "onError: ${error.throwable.stackTraceToString()}")
                            result.error("approveSession", "Error $error", null)
                        },
                        onSuccess = {
                            Log.d("🤖 approveSession", "onSuccess")
                            result.success(true)
                        })
                } else {
                    result.error("approveSession", "No proposal found for public key", null)
                }
            } catch (e: Exception) {
                result.error("approveSession", "Error: ${e.message}", null)
            }
        }
    }

    private fun rejectSession(params: Any?, result: Result) {
        (params as? Map<*, *>)?.let { dict ->
            try {
                val proposalPublicKey = dict["proposalPublicKey"] as String
                val rejectionReason = dict["rejectionReason"] as String
                val sessionProposal = WalletKit.getSessionProposals().find { it.proposerPublicKey == proposalPublicKey }

                if (sessionProposal != null) {
                    val rejectParams = Wallet.Params.SessionReject(
                        proposerPublicKey = sessionProposal.proposerPublicKey,
                        reason = rejectionReason
                    )

                    WalletKit.rejectSession(
                        rejectParams,
                        onSuccess = {
//                            WCDelegate.sessionProposalEvent = null
                            result.success(true)
                        },
                        onError = { error ->
//                            WCDelegate.sessionProposalEvent = null
                            result.error("rejectSession", "Error $error", null)
                        })
                } else {
                    result.error("rejectSession", "No proposal found for public key", null)
                }
            } catch (e: Exception) {
                result.error("rejectSession", "Error: ${e.message}", null)
            }
        }

        result.error("rejectSession", "Invalid parameters", params)
    }

    private fun updateSession(params: Any?, result: Result) {
        (params as? Map<*, *>)?.let { dict ->
            try {
                val topic = dict["topic"] as String
                val namespaces = dict["namespaces"] as Map<*, *>
                val updateParams = Wallet.Params.SessionUpdate(
                    topic,
                    namespaces.toSessionNamespaceMap()
                )
                WalletKit.updateSession(
                    updateParams,
                    onSuccess = {
                        result.success(true)
                    },
                    onError = { error ->
                        result.error("updateSession", "Error $error", null)
                    }
                )
            } catch (e: Exception) {
                result.error("updateSession", "Error: ${e.message}", null)
            }
        }

        result.error("updateSession", "Invalid parameters", params)
    }

    private fun extendSession(params: Any?, result: Result) {
        (params as? Map<*, *>)?.let { dict ->
            try {
                val topic = dict["topic"] as String
                val extendParams = Wallet.Params.SessionExtend(
                    topic,
                )
                WalletKit.extendSession(
                    extendParams,
                    onSuccess = {
                        result.success(true)
                    },
                    onError = { error ->
                        result.error("extendSession", "Error $error", null)
                    }
                )
            } catch (e: Exception) {
                result.error("extendSession", "Error: ${e.message}", null)
            }
        }

        result.error("extendSession", "Invalid parameters", params)
    }

    private fun respondSessionRequest(params: Any?, result: Result) {
        (params as? Map<*, *>)?.let { dict ->
            try {
                val sessionTopic = dict["topic"] as String
                val response = dict["response"] as Map<*,*>
                val requestResponse = Wallet.Params.SessionRequestResponse(
                    sessionTopic = sessionTopic,
                    jsonRpcResponse = if (response["result"] != null) Model.JsonRpcResponse.JsonRpcResult(
                        response["id"] as Long,
                        response["result"] as? String,
                    ) else Model.JsonRpcResponse.JsonRpcError(
                        response["id"] as Long,
                        (response["error"] as? Map<*, *>)?.get("code") as Int,
                        (response["error"] as? Map<*, *>)?.get("message") as String,
                    )
                )

                WalletKit.respondSessionRequest(
                    requestResponse,
                    onSuccess = {
                        result.success(true)
                    },
                    onError = { error ->
                        result.error("respondSessionRequest", "Error $error", null)
                    })
            } catch (e: Exception) {
                result.error("respondSessionRequest", "Error: ${e.message}", null)
            }
        }

        result.error("respondSessionRequest", "Invalid parameters", params)
    }

    private fun emitSessionEvent(params: Any?, result: Result) {
        (params as? Map<*, *>)?.let { dict ->
            try {
                val sessionTopic = dict["topic"] as String
                val chainId = dict["chainId"] as String
                val eventName = dict["name"] as String
                val eventData = dict["data"] as String
                var eventParams = Wallet.Params.SessionEmit(
                    sessionTopic,
                    Model.SessionEvent(eventName, eventData),
                    chainId
                )
                WalletKit.emitSessionEvent(
                    eventParams,
                    onSuccess = {
                        result.success(true)
                    },
                    onError = { error ->
                        result.error("emitSessionEvent", "Error $error", null)
                    }
                )
            } catch (e: Exception) {
                result.error("emitSessionEvent", "Error: ${e.message}", null)
            }
        }

        result.error("emitSessionEvent", "Invalid parameters", params)
    }

    private fun disconnectSession(params: Any?, result: Result) {
        (params as? Map<*, *>)?.let { dict ->
            try {
                val topic = dict["topic"] as String
                val disconnectParams = Wallet.Params.SessionDisconnect(topic)
                WalletKit.disconnectSession(
                    disconnectParams,
                    onSuccess = {
                        result.success(true)
                    },
                    onError = { error ->
                        result.error("disconnectSession", "Error $error", null)
                    })
            } catch (e: Exception) {
                result.error("disconnectSession", "Error: ${e.message}", null)
            }
        }

        result.error("disconnectSession", "Invalid parameters", params)
    }

    private fun dispatchEnvelope(params: Any?, result: Result) {
        (params as? Map<*, *>)?.let { dict ->
            try {
                val uri = dict["uri"] as? String
                WalletKit.dispatchEnvelope(
                    uri ?: "",
                    onError = { error ->
                        result.error("dispatchEnvelope", "Error $error", null)
                })
                result.success(true)
            } catch (e: Exception) {
                result.error("dispatchEnvelope", "Error: ${e.message}", null)
            }
        }

        result.error("dispatchEnvelope", "Invalid parameters", params)
    }

    private fun approveSessionAuthenticate(params: Any?, result: Result) {
        (params as? Map<*, *>)?.let { dict ->
            try {
                val id = dict["id"] as Long
                val auths = dict["auths"] as? List<*>
                val approveProposal = Wallet.Params.ApproveSessionAuthenticate(
                    id = id,
                    auths = auths?.toCacaoList() ?: emptyList()
                )
                WalletKit.approveSessionAuthenticate(approveProposal,
                    onSuccess = {
//                        WCDelegate.sessionAuthenticateEvent = null
                        result.success(true)
                    },
                    onError = { error ->
                        result.error("dispatchEnvelope", "Error $error", null)
                    }
                )
            } catch (e: Exception) {
                result.error("approveSessionAuthenticate", "Error: ${e.message}", null)
            }
        }

        result.error("approveSessionAuthenticate", "Invalid parameters", params)
    }

    private fun rejectSessionAuthenticate(params: Any?, result: Result) {
        (params as? Map<*, *>)?.let { dict ->
            try {
                val id = dict["id"] as Long
                val rejectionReason = dict["rejectionReason"] as String

                val rejectParams = Wallet.Params.RejectSessionAuthenticate(
                    id = id,
                    reason = rejectionReason
                )

                WalletKit.rejectSessionAuthenticate(
                    rejectParams,
                    onSuccess = {
//                            WCDelegate.sessionProposalEvent = null
                        result.success(true)
                    },
                    onError = { error ->
//                            WCDelegate.sessionProposalEvent = null
                        result.error("rejectSessionAuthenticate", "Error $error", null)
                    })
            } catch (e: Exception) {
                result.error("rejectSessionAuthenticate", "Error: ${e.message}", null)
            }
        }

        result.error("rejectSessionAuthenticate", "Invalid parameters", params)
    }

    private fun formatAuthMessage(params: Any?, result: Result) {
        (params as? Map<*, *>)?.let { dict ->
            try {
                val issuer = dict["issuer"] as String
                val payload = dict["payload"] as Map<*, *>
                val payloadParams = payload.toPayloadAuthRequestParams()
                val message = try {
                    WalletKit.formatAuthMessage(Wallet.Params.FormatAuthMessage(payloadParams, issuer))
                } catch (e: Exception) {
                    result.error("formatAuthMessage", "Error ${e.message}", null)
                }
                result.success(message)
            } catch (e: Exception) {
                result.error("rejectSessionAuthenticate", "Error: ${e.message}", null)
            }
        }
    }

    private fun getPendingListOfSessionRequests(params: Any?, result: Result) {
        (params as? Map<*, *>)?.let { dict ->
            try {
                val topic = dict["topic"] as String
                val pendingRequests = WalletKit.getPendingListOfSessionRequests(topic)
                result.success(pendingRequests.toSessionRequestMapList())
            } catch (e: Exception) {
                result.error("pendingSessionRequests", "Error: ${e.message}", null)
            }
        }
    }

    private fun getSessionProposals(result: Result) {
        try {
            val pendingProposals = WalletKit.getSessionProposals()
            result.success(pendingProposals.toSessionProposalMapList())
        } catch (e: Exception) {
            result.error("getSessionProposals", "Error: ${e.message}", null)
        }
    }

    private fun getActiveSessionByTopic(params: Any?, result: Result) {
        (params as? Map<*, *>)?.let { dict ->
            try {
                val topic = dict["topic"] as String
                val session = WalletKit.getActiveSessionByTopic(topic)
                if (session != null) {
                    result.success(session.toMap())
                } else {
                    result.error("getActiveSessionByTopic", "No session found for topic $topic", null)
                }
            } catch (e: Exception) {
                result.error("getActiveSessionByTopic", "Error: ${e.message}", null)
            }
        }
    }

    private fun getListOfActiveSessions(result: Result) {
        try {
            val sessions = WalletKit.getListOfActiveSessions()
            result.success(sessions.toSessionMapList())
        } catch (e: Exception) {
            result.error("getListOfActiveSessions", "Error: ${e.message}", null)
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        methodChannel.setMethodCallHandler(null)
        eventChannel.setStreamHandler(null)
    }

    val walletDelegate = object : WalletKit.WalletDelegate {
        override fun onSessionProposal(sessionProposal: Model.SessionProposal, verifyContext: Model.VerifyContext) {
            Log.d("onSessionProposal", sessionProposal.toString())
            val event = mapOf(
                "event" to "on_session_proposal",
                "data" to sessionProposal.toMap(),
                "verifyContext" to verifyContext.toMap(),
            )
            Handler(Looper.getMainLooper()).post {
                eventChannelSink!!.success(event)
            }
        }

        override fun onSessionRequest(sessionRequest: Model.SessionRequest, verifyContext: Model.VerifyContext) {
            Log.d("onSessionRequest", sessionRequest.toString())
            val event = mapOf(
                "event" to "on_session_request",
                "data" to sessionRequest.toMap(),
                "verifyContext" to verifyContext.toMap(),
            )
            Handler(Looper.getMainLooper()).post {
                eventChannelSink!!.success(event)
            }
        }

        override fun onSessionDelete(sessionDelete: Model.SessionDelete) {
            Log.d("onSessionDelete", sessionDelete.toString())
            val event = mapOf(
                "event" to "on_session_delete",
                "data" to sessionDelete.toMap(),
            )
            Handler(Looper.getMainLooper()).post {
                eventChannelSink!!.success(event)
            }
        }

        override fun onSessionExtend(session: Model.Session) {
            Log.d("onSessionExtend", session.toString())
            val event = mapOf(
                "event" to "on_session_extend",
                "data" to session.toMap(),
            )
            Handler(Looper.getMainLooper()).post {
                eventChannelSink!!.success(event)
            }
        }

        override fun onSessionSettleResponse(settleSessionResponse: Model.SettledSessionResponse) {
            Log.d("onSessionSettleResponse", settleSessionResponse.toString())
            val event = mapOf(
                "event" to "on_session_settle_response",
                "data" to settleSessionResponse.toMap(),
            )
            Handler(Looper.getMainLooper()).post {
                eventChannelSink!!.success(event)
            }
        }

        override fun onSessionUpdateResponse(sessionUpdateResponse: Model.SessionUpdateResponse) {
            Log.d("onSessionUpdateResponse", sessionUpdateResponse.toString())
            val event = mapOf(
                "event" to "on_session_update_response",
                "data" to sessionUpdateResponse.toMap(),
            )
            Handler(Looper.getMainLooper()).post {
                eventChannelSink!!.success(event)
            }
        }

        override fun onConnectionStateChange(state: Model.ConnectionState) {
            Log.d("onConnectionStateChange", state.toString())
            val event = mapOf(
                "event" to "on_connection_state_change",
                "state" to state.toMap(),
            )
            Handler(Looper.getMainLooper()).post {
                try {
                    eventChannelSink!!.success(event)
                } catch (e: Exception) {
                    Log.e("onConnectionStateChange", e.toString())
                }
            }
        }

        override fun onError(error: Model.Error) {
            Log.d("onError", error.toString())
            val event = mapOf(
                "event" to "on_error",
                "error" to error.toMap()
            )
            Handler(Looper.getMainLooper()).post {
                eventChannelSink!!.success(event)
            }
        }
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventChannelSink = events
        Log.d("onListen", "eventChannelSink: $eventChannelSink")
    }

    override fun onCancel(arguments: Any?) {
        Log.d("onCancel", "eventChannelSink: $eventChannelSink")
        eventChannelSink = null;
    }
}

