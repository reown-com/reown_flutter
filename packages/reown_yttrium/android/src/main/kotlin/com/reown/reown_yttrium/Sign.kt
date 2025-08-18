package com.reown.reown_yttrium

import android.annotation.SuppressLint
import android.util.Log
//import com.reown.reown_yttrium.Sign.Companion.sessionRequestListener
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.StreamHandler
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import uniffi.yttrium.SessionFfi
import uniffi.yttrium.SessionProposalFfi
import uniffi.yttrium.SessionRequestJsonRpcFfi
import uniffi.yttrium.SessionRequestListener
import uniffi.yttrium.SignClient
import uniffi.yttrium.metadataFromJson
import uniffi.yttrium.registerLogger
import uniffi.yttrium.sessionFfiToJson
import uniffi.yttrium.sessionProposalFfiFromJson
import uniffi.yttrium.sessionProposalFfiToJson
import uniffi.yttrium.sessionRequestJsonRpcFfiToJson
import kotlin.collections.get

class Sign {
    companion object {
        private lateinit var signClient: SignClient
        private lateinit var eventChannel: EventChannel
        private var onSessionRequest = OnSessionRequest()

        // Called during plugin registration
        fun setEventChannel(messenger: BinaryMessenger) {
            eventChannel = EventChannel(messenger, "reown_yttrium/session_requests")
            eventChannel.setStreamHandler(onSessionRequest)
        }

        fun initialize(params: Any?, result: MethodChannel.Result) {
            val dict = params as? Map<*, *> ?: return result.error("Yttrium.Sign.initialize", "Invalid parameters: not a map", null)
            val projectId = dict["projectId"] as? String ?: return result.error("Yttrium.Sign.initialize", "Invalid projectId", null)

            CoroutineScope(Dispatchers.IO).launch {
                try {
                    signClient = SignClient(projectId = projectId)
                    signClient.registerSessionRequestListener(onSessionRequest)
                    Log.d("🤖 Yttrium.Sign", "initialize success")
                    result.success(true)
                } catch (e: Exception) {
                    result.error("Yttrium.Sign.initialize", e.message, null)
                }
            }
        }

        fun setKey(params: Any?, result: MethodChannel.Result) {
            check(::signClient.isInitialized) { "Initialize Yttrium.Sign.SignClient before using it." }

            val key = params as? String ?: return result.error("Yttrium.Sign.setKey", "Invalid parameters: not a String", null)

            CoroutineScope(Dispatchers.IO).launch {
                try {
                    signClient.setKey(key = key.hexStringToByteArray())
                    result.success(true)
                } catch (e: Exception) {
                    result.error("Yttrium.Sign.setKey", e.message, null)
                }
            }
        }

        fun generateKey(result: MethodChannel.Result) {
            check(::signClient.isInitialized) { "Initialize Yttrium.Sign.SignClient before using it." }

            try {
                val key = signClient.generateKey()
                result.success(key.byteArrayToHexString())
            } catch (e: Exception) {
                result.error("Yttrium.Sign.generateKey", e.message, null)
            }
        }

        fun pair(params: Any?, result: MethodChannel.Result) {
            check(::signClient.isInitialized) { "Initialize SignClient before using it." }

            val pairingUri = params as? String ?: return result.error("Yttrium.Sign.pair", "Invalid parameters: not a String", null)

            CoroutineScope(Dispatchers.IO).launch {
                try {
                    val response: SessionProposalFfi = signClient.pair(pairingUri);
                    result.success(sessionProposalFfiToJson(response))
                } catch (e: Exception) {
                    result.error("Yttrium.Sign.pair", e.message, null)
                }
            }
        }

        fun approve(params: Any?, result: MethodChannel.Result) {
            check(::signClient.isInitialized) { "Initialize SignClient before using it." }

            val dict = params as? Map<*, *> ?: return result.error("Yttrium.Sign.approve", "Invalid parameters: not a map", null)

            val proposal = dict["proposal"] as? String ?: return result.error("Yttrium.Sign.approve", "Invalid parameter proposal", null)
            val approvedNamespaces = dict["approvedNamespaces"] as? Map<*, *> ?: return result.error("Yttrium.Sign.approve", "Invalid parameter approvedNamespaces", null)
            val selfMetadata = dict["selfMetadata"] as? String ?: return result.error("Yttrium.Sign.approve", "Invalid parameter selfMetadata", null)

            CoroutineScope(Dispatchers.IO).launch {
                try {
                    val response: SessionFfi = signClient.approve(
                        proposal = sessionProposalFfiFromJson(proposal),
                        approvedNamespaces = approvedNamespaces.toApprovedNamespace(),
                        selfMetadata = metadataFromJson(selfMetadata),
                    )
                    result.success(sessionFfiToJson(response))
                } catch (e: Exception) {
                    result.error("Yttrium.Sign.approve", e.message, null)
                }
            }
        }
    }
}

class OnSessionRequest : SessionRequestListener, StreamHandler {
    private var eventChannelSink: EventChannel.EventSink? = null

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        // onListen is called when receiveBroadcastStream().listen(_onEvent) is called on Flutter side
        if (events != null && eventChannelSink == null) {
            eventChannelSink = events
            Log.d("🤖 Yttrium.Sign", "onListen: $eventChannelSink")
        }
    }

    override fun onCancel(arguments: Any?) {
        Log.d("🤖 Yttrium.Sign", "onCancel: $eventChannelSink")
        eventChannelSink = null;
    }

    override fun onSessionRequest(topic: String, sessionRequest: SessionRequestJsonRpcFfi) {
        android.os.Handler(android.os.Looper.getMainLooper()).post {  }
        android.os.Handler(android.os.Looper.getMainLooper()).postDelayed({
            Log.d("🤖 Yttrium.Sign", "onSessionRequest: $eventChannelSink")
            val sessionRequestEvent = mapOf(
                "topic" to topic,
                "sessionRequest" to sessionRequestJsonRpcFfiToJson(sessionRequest),
            )
            eventChannelSink?.success(sessionRequestEvent)
        }, 200)
    }
}
