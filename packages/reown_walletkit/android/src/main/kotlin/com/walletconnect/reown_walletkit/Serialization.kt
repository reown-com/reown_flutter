package com.walletconnect.reown_walletkit

import androidx.core.net.toUri
import com.reown.walletkit.client.Wallet.Model
import com.reown.walletkit.client.Wallet.Model.PayloadAuthRequestParams

fun Map<*, *>?.toStringMap(): Map<String, String> {
    return this?.mapNotNull { (key, value) ->
        val k = key as? String ?: return@mapNotNull null
        val v = value as? String ?: return@mapNotNull null
        k to v
    }?.toMap().orEmpty()
}

fun Map<*, *>.toSessionNamespaceMap(): Map<String, Model.Namespace.Session> {
    return this.mapNotNull { (key, value) ->
        val k = key as? String ?: return@mapNotNull null
        val v = value as? Map<*, *> ?: return@mapNotNull null

        val chains = (v["chains"] as? List<*>)?.filterIsInstance<String>()
        val accounts = (v["accounts"] as? List<*>)?.filterIsInstance<String>() ?: emptyList()
        val methods = (v["methods"] as? List<*>)?.filterIsInstance<String>() ?: emptyList()
        val events = (v["events"] as? List<*>)?.filterIsInstance<String>() ?: emptyList()

        k to Model.Namespace.Session(
            chains = chains,
            accounts = accounts,
            methods = methods,
            events = events
        )
    }.toMap()
}

fun List<*>.toCacaoList(): List<Model.Cacao> {
    return this.mapNotNull { item ->
        val map = item as? Map<*, *> ?: return@mapNotNull null

        // Header
        val headerMap = map["header"] as? Map<*, *> ?: return@mapNotNull null
        val header = Model.Cacao.Header(
            t = headerMap["t"] as? String ?: return@mapNotNull null
        )

        // Payload
        val payloadMap = map["payload"] as? Map<*, *> ?: return@mapNotNull null
        val payload = Model.Cacao.Payload(
            iss = payloadMap["iss"] as? String ?: return@mapNotNull null,
            domain = payloadMap["domain"] as? String ?: return@mapNotNull null,
            aud = payloadMap["aud"] as? String ?: return@mapNotNull null,
            version = payloadMap["version"] as? String ?: return@mapNotNull null,
            nonce = payloadMap["nonce"] as? String ?: return@mapNotNull null,
            iat = payloadMap["iat"] as? String ?: return@mapNotNull null,
            nbf = payloadMap["nbf"] as? String?,
            exp = payloadMap["exp"] as? String?,
            statement = payloadMap["statement"] as? String?,
            requestId = payloadMap["requestId"] as? String?,
            resources = (payloadMap["resources"] as? List<*>)?.filterIsInstance<String>()
        )

        // Signature
        val signatureMap = map["signature"] as? Map<*, *> ?: return@mapNotNull null
        val signature = Model.Cacao.Signature(
            t = signatureMap["t"] as? String ?: return@mapNotNull null,
            s = signatureMap["s"] as? String ?: return@mapNotNull null,
            m = signatureMap["m"] as? String?
        )

        Model.Cacao(
            header = header,
            payload = payload,
            signature = signature
        )
    }
}

fun Map<*, *>.toPayloadAuthRequestParams(): PayloadAuthRequestParams {
    val chains = (this["chains"] as? List<*>)?.filterIsInstance<String>()
        ?: error("Missing or invalid 'chains'")
    val domain = this["domain"] as? String ?: error("Missing or invalid 'domain'")
    val nonce = this["nonce"] as? String ?: error("Missing or invalid 'nonce'")
    val aud = this["aud"] as? String ?: error("Missing or invalid 'aud'")
    val type = this["type"] as? String
    val iat = this["iat"] as? String ?: error("Missing or invalid 'iat'")
    val nbf = this["nbf"] as? String
    val exp = this["exp"] as? String
    val statement = this["statement"] as? String
    val requestId = this["requestId"] as? String
    val resources = (this["resources"] as? List<*>)?.filterIsInstance<String>()

    return PayloadAuthRequestParams(
        chains = chains,
        domain = domain,
        nonce = nonce,
        aud = aud,
        type = type,
        iat = iat,
        nbf = nbf,
        exp = exp,
        statement = statement,
        requestId = requestId,
        resources = resources
    )
}

fun Model.SessionRequest.toMap(): Map<String, Any?> {
    return mapOf(
        "topic" to topic,
        "chainId" to chainId,
        "peerMetaData" to peerMetaData?.let { meta ->
            mapOf(
                "name" to meta.name,
                "description" to meta.description,
                "url" to meta.url,
                "icons" to meta.icons,
                "redirect" to meta.redirect
            )
        },
        "request" to mapOf(
            "id" to request.id,
            "method" to request.method,
            "params" to request.params
        )
    )
}

fun List<Model.SessionRequest>.toSessionRequestMapList(): List<Map<String, Any?>> {
    return this.map { it.toMap() }
}

fun Model.SessionProposal.toMap(): Map<String, Any?> {
    return mapOf(
        "pairingTopic" to pairingTopic,
        "name" to name,
        "description" to description,
        "url" to url,
        "icons" to icons.map { it.toString() },
        "redirect" to redirect,
        "requiredNamespaces" to requiredNamespaces.mapValues { (_, ns) ->
            mapOf(
                "chains" to ns.chains,
                "methods" to ns.methods,
                "events" to ns.events
            )
        },
        "optionalNamespaces" to optionalNamespaces.mapValues { (_, ns) ->
            mapOf(
                "chains" to ns.chains,
                "methods" to ns.methods,
                "events" to ns.events
            )
        },
        "properties" to properties,
        "proposerPublicKey" to proposerPublicKey,
        "relayProtocol" to relayProtocol,
        "relayData" to relayData,
        "scopedProperties" to scopedProperties
    )
}

fun List<Model.SessionProposal>.toSessionProposalMapList(): List<Map<String, Any?>> {
    return this.map { it.toMap() }
}

fun Model.Session.toMap(): Map<String, Any?> {
    return mapOf(
        "pairingTopic" to pairingTopic,
        "topic" to topic,
        "expiry" to expiry,
        "requiredNamespaces" to requiredNamespaces.mapValues { (_, ns) ->
            mapOf(
                "chains" to ns.chains,
                "methods" to ns.methods,
                "events" to ns.events
            )
        },
        "optionalNamespaces" to optionalNamespaces?.mapValues { (_, ns) ->
            mapOf(
                "chains" to ns.chains,
                "methods" to ns.methods,
                "events" to ns.events
            )
        },
        "namespaces" to namespaces.mapValues { (_, ns) ->
            mapOf(
                "chains" to ns.chains,
                "accounts" to ns.accounts,
                "methods" to ns.methods,
                "events" to ns.events
            )
        },
        "metaData" to metaData?.let { meta ->
            mapOf(
                "name" to meta.name,
                "description" to meta.description,
                "url" to meta.url,
                "icons" to meta.icons,
                "redirect" to meta.redirect
            )
        },
        "redirect" to redirect
    )
}

fun List<Model.Session>.toSessionMapList(): List<Map<String, Any?>> {
    return this.map { it.toMap() }
}

fun Model.VerifyContext.toMap(): Map<String, Any?> {
    return mapOf(
        "id" to id,
        "origin" to origin,
        "validation" to validation.name.toString(),
        "verifyUrl" to verifyUrl,
        "isScam" to isScam
    )
}

fun List<Model.VerifyContext>.toVerifyContextMapList(): List<Map<String, Any?>> {
    return this.map { it.toMap() }
}

fun Model.SettledSessionResponse.toMap(): Map<String, Any?> {
    return when (this) {
        is Model.SettledSessionResponse.Result -> mapOf(
            "type" to "result",
            "session" to session.toMap()
        )
        is Model.SettledSessionResponse.Error -> mapOf(
            "type" to "error",
            "errorMessage" to errorMessage
        )
    }
}

fun List<Model.SettledSessionResponse>.toSettledSessionResponseMapList(): List<Map<String, Any?>> {
    return this.map { it.toMap() }
}

fun Model.ConnectionState.toMap(): Map<String, Any?> {
    return mapOf(
        "isAvailable" to isAvailable,
        "reason" to reason?.let {
            when (it) {
                is Model.ConnectionState.Reason.ConnectionClosed -> mapOf(
                    "type" to "ConnectionClosed",
                    "message" to it.message
                )
                is Model.ConnectionState.Reason.ConnectionFailed -> mapOf(
                    "type" to "ConnectionFailed",
                    "throwable" to it.throwable.toString()
                )
            }
        }
    )
}

fun List<Model.ConnectionState>.toConnectionStateMapList(): List<Map<String, Any?>> {
    return this.map { it.toMap() }
}

fun Model.SessionUpdateResponse.toMap(): Map<String, Any?> {
    return when (this) {
        is Model.SessionUpdateResponse.Result -> mapOf(
            "type" to "result",
            "topic" to topic,
            "namespaces" to namespaces.mapValues { (_, ns) ->
                mapOf(
                    "chains" to ns.chains,
                    "accounts" to ns.accounts,
                    "methods" to ns.methods,
                    "events" to ns.events
                )
            }
        )
        is Model.SessionUpdateResponse.Error -> mapOf(
            "type" to "error",
            "errorMessage" to errorMessage
        )
    }
}

fun List<Model.SessionUpdateResponse>.toSessionUpdateResponseMapList(): List<Map<String, Any?>> {
    return this.map { it.toMap() }
}

fun Model.SessionDelete.toMap(): Map<String, Any?> {
    return when (this) {
        is Model.SessionDelete.Success -> mapOf(
            "type" to "success",
            "topic" to topic,
            "reason" to reason
        )
        is Model.SessionDelete.Error -> mapOf(
            "type" to "error",
            "error" to mapOf(
                "message" to error.message,
                "class" to error::class.java.name,
                "stackTrace" to error.stackTraceToString()
            )
        )
    }
}

fun List<Model.SessionDelete>.toSessionDeleteMapList(): List<Map<String, Any?>> {
    return this.map { it.toMap() }
}

fun Model.Error.toMap(): Map<String, Any?> {
    return mapOf(
        "type" to "Error",
        "throwable" to mapOf(
            "message" to throwable.message,
            "class" to throwable::class.java.name,
            "stackTrace" to throwable.stackTraceToString()
        )
    )
}

fun List<Model.Error>.toErrorMapList(): List<Map<String, Any?>> {
    return this.map { it.toMap() }
}

fun String.queryParams(): Map<String, String> {
    val uri = this.toUri()
    val params = mutableMapOf<String, String>()

    for (paramName in uri.queryParameterNames) {
        uri.getQueryParameter(paramName)?.let { paramValue ->
            params[paramName] = paramValue
        }
    }
    return params
}
