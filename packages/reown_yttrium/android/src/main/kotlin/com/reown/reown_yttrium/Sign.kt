package com.reown.reown_yttrium

import android.util.Log
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.StreamHandler
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import uniffi.yttrium.PairingFfi
import uniffi.yttrium.SessionFfi
import uniffi.yttrium.SessionProposalFfi
import uniffi.yttrium.SessionRequestJsonRpcFfi
import uniffi.yttrium.SessionRequestJsonRpcResponseFfi
import uniffi.yttrium.SettleNamespace
import uniffi.yttrium.SignClient
import uniffi.yttrium.SignListener
import uniffi.yttrium.StorageFfi
import uniffi.yttrium.Topic
import uniffi.yttrium.metadataFromJson
import uniffi.yttrium.rejectReasonFromJson
import uniffi.yttrium.sessionFfiToJson
import uniffi.yttrium.sessionProposalFfiFromJson
import uniffi.yttrium.sessionProposalFfiToJson
import uniffi.yttrium.sessionRequestJsonRpcErrorResponseFfiFromJson
import uniffi.yttrium.sessionRequestJsonRpcFfiToJson
import uniffi.yttrium.sessionRequestJsonRpcResultResponseFfiFromJson
import kotlin.collections.get

class Sign {
    companion object {
        private lateinit var signClient: SignClient
        private lateinit var eventChannel: EventChannel
        private var signListenerHandler = SignListenerHandler()

        // Called during plugin registration
        fun setEventChannel(messenger: BinaryMessenger) {
            eventChannel = EventChannel(messenger, "reown_yttrium/session_requests")
            eventChannel.setStreamHandler(signListenerHandler)
        }

        fun initialize(params: Any?, result: MethodChannel.Result) {
            val dict = params as? Map<*, *> ?: return result.error("Yttrium.Sign.initialize", "Invalid parameters: not a map", null)
            val projectId = dict["projectId"] as? String ?: return result.error("Yttrium.Sign.initialize", "Invalid projectId", null)
            val key = dict["key"] as? String ?: return result.error("Yttrium.Sign.initialize", "Invalid key", null)

            CoroutineScope(Dispatchers.IO).launch {
                try {
                    signClient = SignClient(
                        projectId = projectId,
                        key = key.hexStringToByteArray(),
                        sessionStore = SignStorage(), // TODO
                    )
                    signClient.start()
                    signClient.registerSignListener(signListenerHandler)
                    Log.d("🤖 Yttrium.Sign", "initialize success")
                    result.success(true)
                } catch (e: Exception) {
                    result.error("Yttrium.Sign.initialize", e.message, null)
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

        fun reject(params: Any?, result: MethodChannel.Result) {
            check(::signClient.isInitialized) { "Initialize SignClient before using it." }

            val dict = params as? Map<*, *> ?: return result.error("Yttrium.Sign.reject", "Invalid parameters: not a map", null)

            val proposal = dict["proposal"] as? String ?: return result.error("Yttrium.Sign.reject", "Invalid parameter proposal", null)
            val reason = dict["reason"] as? String ?: return result.error("Yttrium.Sign.reject", "Invalid parameter reason", null)

            CoroutineScope(Dispatchers.IO).launch {
                try {
                    signClient.reject(
                        proposal = sessionProposalFfiFromJson(proposal),
                        reason = rejectReasonFromJson(reason),
                        );
                    result.success(true)
                } catch (e: Exception) {
                    result.error("Yttrium.Sign.reject", e.message, null)
                }
            }
        }

        fun respond(params: Any?, result: MethodChannel.Result) {
            check(::signClient.isInitialized) { "Initialize SignClient before using it." }

            val dict = params as? Map<*, *> ?: return result.error("Yttrium.Sign.respond", "Invalid parameters: not a map", null)

            val topic = dict["topic"] as? String ?: return result.error("Yttrium.Sign.respond", "Invalid parameter topic", null)
            val responseResult = dict["result"] as? String
            val responseError = dict["error"] as? String

            CoroutineScope(Dispatchers.IO).launch {
                try {
                    lateinit var response: SessionRequestJsonRpcResponseFfi
                    if (responseResult != null) {
                        response = SessionRequestJsonRpcResponseFfi.Result(
                            v1 = sessionRequestJsonRpcResultResponseFfiFromJson(
                                json = responseResult
                            )
                        );
                    } else {
                        response = SessionRequestJsonRpcResponseFfi.Error(
                            v1 = sessionRequestJsonRpcErrorResponseFfiFromJson(
                                json = responseError!!
                            )
                        );
                    }
                    val topic = signClient.respond(
                        topic = topic,
                        response = response,
                    );
                    result.success(topic)
                } catch (e: Exception) {
                    result.error("Yttrium.Sign.respond", e.message, null)
                }
            }
        }

//        fun respondError(params: Any?, result: MethodChannel.Result) {
//            check(::signClient.isInitialized) { "Initialize SignClient before using it." }
//
//            val dict = params as? Map<*, *> ?: return result.error("Yttrium.Sign.respond", "Invalid parameters: not a map", null)
//
//            val topic = dict["topic"] as? String ?: return result.error("Yttrium.Sign.respond", "Invalid parameter topic", null)
//            val response = dict["response"] as? String ?: return result.error("Yttrium.Sign.respond", "Invalid parameter response", null)
//
//            CoroutineScope(Dispatchers.IO).launch {
//                try {
//                    val topic = signClient.respond(
//                        topic = topic,
//                        response = SessionRequestJsonRpcResponseFfi.Error(
//                            v1 = sessionRequestJsonRpcErrorResponseFfiFromJson(
//                                response
//                            )
//                        )
//                    );
//                    result.success(topic)
//                } catch (e: Exception) {
//                    result.error("Yttrium.Sign.respond", e.message, null)
//                }
//            }
//        }
    }
}

class SignListenerHandler : SignListener, StreamHandler {
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
        Log.d("🤖 Yttrium.Sign", "onSessionRequest: $eventChannelSink")
        val sessionRequestEvent = mapOf(
            "topic" to topic,
            "sessionRequest" to sessionRequestJsonRpcFfiToJson(sessionRequest),
        )
        eventChannelSink?.success(sessionRequestEvent)
    }

    override fun onSessionConnect(id: ULong, topic: String) {
        Log.d("🤖 Yttrium.Sign", "onSessionConnect: $id, $topic")
    }

    override fun onSessionDisconnect(id: ULong, topic: String) {
        Log.d("🤖 Yttrium.Sign", "onSessionDisconnect: $id, $topic")
    }

    override fun onSessionEvent(topic: String, name: String, data: String, chainId: String) {
        Log.d("🤖 Yttrium.Sign", "onSessionEvent: $topic, $name, $data, $chainId")
    }

    override fun onSessionExtend(id: ULong, topic: String) {
        Log.d("🤖 Yttrium.Sign", "onSessionExtend: $id, $topic")
    }

    override fun onSessionReject(id: ULong, topic: String) {
        Log.d("🤖 Yttrium.Sign", "onSessionReject: $id, $topic")
    }

    override fun onSessionRequestResponse(id: ULong, topic: String, response: SessionRequestJsonRpcResponseFfi) {
        Log.d("🤖 Yttrium.Sign", "onSessionRequestResponse: $id, $topic, $response")
    }

    override fun onSessionUpdate(id: ULong, topic: String, namespaces: Map<String, SettleNamespace>) {
        Log.d("🤖 Yttrium.Sign", "onSessionUpdate: $id, $topic, $namespaces")
    }
}

internal class SignStorage : StorageFfi {
    override fun addSession(session: SessionFfi) {
        Log.d("🤖 Yttrium.Sign", "addSession: $session")
    }

    override fun deleteSession(topic: String) {
        Log.d("🤖 Yttrium.Sign", "deleteSession: $topic")
    }

    override fun getAllSessions(): List<SessionFfi> {
        Log.d("🤖 Yttrium.Sign", "getAllSessions")
        return arrayListOf()
    }

    override fun getAllTopics(): List<Topic> {
        Log.d("🤖 Yttrium.Sign", "getAllTopics")
        return arrayListOf()
    }

    override fun getDecryptionKeyForTopic(topic: String): ByteArray? {
        Log.d("🤖 Yttrium.Sign", "getDecryptionKeyForTopic: $topic")
        return null
    }

    override fun getPairing(topic: String, rpcId: ULong): PairingFfi? {
        Log.d("🤖 Yttrium.Sign", "getPairing: $topic, $rpcId")
        return null
    }

    override fun getSession(topic: String): SessionFfi? {
        Log.d("🤖 Yttrium.Sign", "getSession: $topic")
        return null
    }

    override fun savePairing(topic: String, rpcId: ULong, symKey: ByteArray, selfKey: ByteArray) {
        Log.d("🤖 Yttrium.Sign", "savePairing: $topic, $rpcId, $symKey, $selfKey")
    }

    override fun savePartialSession(topic: String, symKey: ByteArray) {
        Log.d("🤖 Yttrium.Sign", "savePartialSession: $topic, $symKey")
    }
}
