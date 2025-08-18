package com.reown.reown_yttrium

import android.annotation.SuppressLint
import android.util.Log
import com.reown.reown_yttrium.Sign.Companion.sessionRequestListener
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.StreamHandler
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import uniffi.yttrium.SessionRequestJsonRpcFfi
import uniffi.yttrium.SessionRequestListener
import uniffi.yttrium.SignClient
import kotlin.collections.get

class Sign {
    companion object {
        private lateinit var signClient: SignClient
        private var sessionRequestListener: OnSessionRequest? = null
//        private var listenerRegistered = false
//        private val retainedListeners = mutableListOf<SessionRequestListener>()

        // Called during plugin registration
        fun setupEventChannel(messenger: BinaryMessenger) {
            val channel = EventChannel(messenger, "reown_yttrium/session_requests")
//            channel.setStreamHandler(SessionRequestEventChannel())
        }

        fun initialize(params: Any?, result: MethodChannel.Result) {
            val dict = params as? Map<*, *> ?: return result.error("Yttrium.Sign.initialize", "Invalid parameters: not a map", null)
            val projectId = dict["projectId"] as? String ?: return result.error("Yttrium.Sign.initialize", "Invalid projectId", null)

            CoroutineScope(Dispatchers.IO).launch {
                try {
                    signClient = SignClient(projectId = projectId)
//                    registerSessionRequestListener(null)
                    signClient.registerSessionRequestListener(OnSessionRequest())
                    Log.d("🤖 Yttrium.Sign", "initialize success")
                    result.success(true)
                } catch (e: Exception) {
                    result.error("Yttrium.Sign.initialize", e.message, null)
                }
            }
        }

//        @SuppressLint("LongLogTag")
//        fun registerSessionRequestListener(events: EventChannel.EventSink?) {
//            CoroutineScope(Dispatchers.IO).launch {
//                try {
//                    if (events == null) {
//                        sessionRequestListener = OnSessionRequest()
//                        val result = signClient.registerSessionRequestListener(sessionRequestListener!!)
////                        listenerRegistered = true
//                        Log.d("Yttrium.Sign.registerListener", "Listener registered: $result")
//                    } else {
//                        sessionRequestListener?.updateSink(events)
//                        Log.d("Yttrium.Sign.registerListener", "Listener already registered; sink updated")
//                    }
//                } catch (e: Exception) {
//                    Log.e("Yttrium.Sign.registerListener", "Failed to register listener", e)
//                }
//            }
//        }

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
                    val response: String = signClient.pairJson(pairingUri);
                    result.success(response)
                } catch (e: Exception) {
                    result.error("Yttrium.Sign.pair", e.message, null)
                }
            }
        }

        fun approve(params: Any?, result: MethodChannel.Result) {
            check(::signClient.isInitialized) { "Initialize SignClient before using it." }

            val dict = params as? Map<*, *> ?: return result.error("Yttrium.Sign.approve", "Invalid parameters: not a map", null)

            val proposal = dict["proposal"] as? String ?: return result.error("Yttrium.Sign.approve", "Invalid parameter proposal", null)
            val approvedNamespaces = dict["approvedNamespaces"] as? String ?: return result.error("Yttrium.Sign.approve", "Invalid parameter approvedNamespaces", null)
            val selfMetadata = dict["selfMetadata"] as? String ?: return result.error("Yttrium.Sign.approve", "Invalid parameter selfMetadata", null)

            CoroutineScope(Dispatchers.IO).launch {
                try {
                    val response: String = signClient.approveJson(
                        proposal = proposal,
                        approvedNamespaces = approvedNamespaces,
                        selfMetadata = selfMetadata,
                    )
                    result.success(response)
                } catch (e: Exception) {
                    result.error("Yttrium.Sign.approve", e.message, null)
                }
            }
        }
    }
}

//class SessionRequestEventChannel : StreamHandler {
//    @SuppressLint("LongLogTag")
//    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
//        // onListen is called when receiveBroadcastStream().listen(_onEvent) is called on Flutter side
//        Log.d("Yttrium.Sign.onListen", "$events")
//        Sign.registerSessionRequestListener(events)
//    }
//
//    @SuppressLint("LongLogTag")
//    override fun onCancel(arguments: Any?) {
//        Log.d("Yttrium.Sign.onCancel", "$arguments")
////        Sign.registerSessionRequestListener(null)
//    }
//}

class OnSessionRequest : SessionRequestListener {
//    private var eventChannelSink: EventChannel.EventSink? = null
//
//    fun updateSink(sink: EventChannel.EventSink?) {
//        eventChannelSink = sink
//    }

    override fun onSessionRequest(topic: String, sessionRequest: SessionRequestJsonRpcFfi) {
        Log.d("🤖 Yttrium.Sign", "onSessionRequest: $topic: $sessionRequest")
    }

    override fun onSessionRequestJson(topic: String, sessionRequest: String) {
        Log.d("🤖 Yttrium.Sign", "onSessionRequestJson: $topic: $sessionRequest")
//        val eventReceived = mapOf(
//            "topic" to topic,
//            "sessionRequest" to sessionRequest,
//        )
//        android.os.Handler(android.os.Looper.getMainLooper()).postDelayed({
//            eventChannelSink?.success(eventReceived)
//        }, 100)
    }
}
