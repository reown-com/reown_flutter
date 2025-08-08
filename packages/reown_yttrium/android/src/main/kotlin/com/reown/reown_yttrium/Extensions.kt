package com.reown.reown_yttrium

import uniffi.uniffi_yttrium.Eip1559Estimation
import uniffi.yttrium.Amount
import uniffi.yttrium.BridgingError
import uniffi.yttrium.ExecuteDetails
import uniffi.yttrium.FeeEstimatedTransaction
import uniffi.yttrium.FundingMetadata
import uniffi.yttrium.InitialTransactionMetadata
import uniffi.yttrium.Metadata
import uniffi.yttrium.PrepareResponseAvailable
import uniffi.yttrium.PrepareResponseError
import uniffi.yttrium.PrepareResponseMetadata
import uniffi.yttrium.PrepareResponseNotRequired
import uniffi.yttrium.ProposalNamespace
import uniffi.yttrium.Redirect
import uniffi.yttrium.Relay
import uniffi.yttrium.Transaction
import uniffi.yttrium.TransactionFee
import uniffi.yttrium.TxnDetails
import uniffi.yttrium.SolanaTxnDetails
import uniffi.yttrium.UiFields
import uniffi.yttrium.Route
import uniffi.yttrium.SessionFfi
import uniffi.yttrium.SessionProposalFfi
import uniffi.yttrium.SettleNamespace
import uniffi.yttrium.SolanaTransaction
import uniffi.yttrium.Transactions
import kotlin.collections.get

fun Eip1559Estimation.toMap(): Map<String, Any> {
    return mapOf(
        "maxFeePerGas" to maxFeePerGas,
        "maxPriorityFeePerGas" to maxPriorityFeePerGas
    )
}

fun SolanaTransaction.toMap(): Map<String, Any> {
    return mapOf(
        "chainId" to chainId,
        "from" to from,
        "transaction" to transaction
    )
}

fun SolanaTxnDetails.toMap(): Map<String, Any> {
    return mapOf(
        "transaction" to transaction.toMap(), // SolanaTransaction does not have toMap() so it's done here
        "transactionHashToSign" to transactionHashToSign
    )
}

fun Route.toMap(): List<Map<String, Any>> = when (this) {
    is Route.Eip155 -> v1.map { it.toMap() } // List<TxnDetails>
    is Route.Solana -> v1.map { it.toMap() } // List<SolanaTxnDetails>
}

fun UiFields.toMap(): Map<String, Any> {
    val route = route.map { it.toMap() }.first() // Route does not have toMap() so it's done here
    return mapOf(
        "routeResponse" to routeResponse.toMap(),
        "route" to route,
        "localRouteTotal" to localRouteTotal.toMap(),
        "bridge" to bridge.map { it.toMap() },
        "localBridgeTotal" to localBridgeTotal.toMap(),
        "initial" to initial.toMap(),
        "localTotal" to localTotal.toMap()
    )
}

fun Transactions.toMap(): List<Map<String, Any>> = when (this) {
    is Transactions.Eip155 -> v1.map { it.toMap() } // List<Transaction>
    is Transactions.Solana -> v1.map { it.toMap() } // List<SolanaTransaction>, SolanaTransaction has toMap() defined here
}

fun PrepareResponseAvailable.toMap(): Map<String, Any> {
    val transactions =
        transactions.map { it.toMap() }.first() // Route does not have toMap() so it's done here
    return mapOf(
        "orchestrationId" to orchestrationId,
        "initialTransaction" to initialTransaction.toMap(),
        "transactions" to transactions,
        "metadata" to metadata.toMap()
    )
}

fun Transaction.toMap(): Map<String, Any> {
    return mapOf(
        "chainId" to chainId,
        "from" to from,
        "to" to to,
        "value" to value,
        "input" to input,
        "gasLimit" to gasLimit,
        "nonce" to nonce
    )
}

fun PrepareResponseMetadata.toMap(): Map<String, Any> {
    return mapOf(
        "fundingFrom" to fundingFrom.map { it.toMap() },
        "initialTransaction" to initialTransaction.toMap(),
        "checkIn" to checkIn.toString()
    )
}

fun FundingMetadata.toMap(): Map<String, Any> {
    return mapOf(
        "chainId" to chainId,
        "tokenContract" to tokenContract,
        "symbol" to symbol,
        "amount" to amount,
        "bridgingFee" to bridgingFee,
        "decimals" to decimals.toInt() // TODO UByte
    )
}

fun InitialTransactionMetadata.toMap(): Map<String, Any> {
    return mapOf(
        "transferTo" to transferTo,
        "amount" to amount,
        "tokenContract" to tokenContract,
        "symbol" to symbol,
        "decimals" to decimals.toInt() // TODO UByte
    )
}

fun TxnDetails.toMap(): Map<String, Any> {
    return mapOf(
        "transaction" to transaction.toMap(),
        "transactionHashToSign" to transactionHashToSign,
        "fee" to fee.toMap()
    )
}

fun FeeEstimatedTransaction.toMap(): Map<String, Any> {
    return mapOf(
        "chainId" to chainId,
        "from" to from,
        "to" to to,
        "value" to value,
        "input" to input,
        "gasLimit" to gasLimit,
        "nonce" to nonce,
        "maxFeePerGas" to maxFeePerGas,
        "maxPriorityFeePerGas" to maxPriorityFeePerGas
    )
}

fun TransactionFee.toMap(): Map<String, Any> {
    return mapOf(
        "fee" to fee.toMap(),
        "localFee" to localFee.toMap()
    )
}

fun PrepareResponseNotRequired.toMap(): Map<String, Any> {
    return mapOf(
        "initialTransaction" to initialTransaction.toMap(),
        "transactions" to transactions.map { it.toMap() }
    )
}

fun PrepareResponseError.toMap(): Map<String, Any> {
    return mapOf(
        "error" to error.toMap(),
        "reason" to reason
    )
}

fun BridgingError.toMap(): String = when (this) {
    BridgingError.ASSET_NOT_SUPPORTED -> "assetNotSupported"
    BridgingError.NO_ROUTES_AVAILABLE -> "noRoutesAvailable"
    BridgingError.INSUFFICIENT_FUNDS -> "insufficientFunds"
    BridgingError.INSUFFICIENT_GAS_FUNDS -> "insufficientGasFunds"
//    BridgingError.TRANSACTION_SIMULATION_FAILED -> "transactionSimulationFailed"
    else -> this.name.toString()
}

fun Amount.toMap(): Map<String, Any> {
    return mapOf(
        "symbol" to symbol,
        "amount" to amount,
        "unit" to unit.toInt(), // TODO UByte
        "formatted" to formatted,
        "formattedAlt" to formattedAlt
    )
}

fun ExecuteDetails.toMap(): Map<String, Any> {
    return mapOf(
        "initialTxnReceipt" to initialTxnReceipt,
        "initialTxnHash" to initialTxnHash
    )
}

fun ProposalNamespace.toMap(): Map<String, Any> {
    return mapOf(
        "chains" to chains,
        "methods" to methods,
        "events" to events,
    )
}

fun Map<String, ProposalNamespace>.toMap(): Map<String, Any> {
    return this.mapValues { it.value.toMap() }
}

fun Map<*, *>.toProposalNamespace(): ProposalNamespace {
    val chains = (this["chains"] as? List<*>)?.filterIsInstance<String>() ?: emptyList()
    val methods = (this["methods"] as? List<*>)?.filterIsInstance<String>() ?: emptyList()
    val events = (this["events"] as? List<*>)?.filterIsInstance<String>() ?: emptyList()

    return ProposalNamespace(chains, methods, events)
}

fun Map<*, *>.toRequestedNamespace(): Map<String, ProposalNamespace> {
    return this.mapNotNull { (key, value) ->
        val k = key as? String
        val v = (value as? Map<*, *>)?.toProposalNamespace()
        if (k != null && v != null) k to v else null
    }.toMap()
}

fun Map<*, *>.toSettleNamespace(): SettleNamespace {
    val accounts = (this["accounts"] as? List<*>)?.filterIsInstance<String>() ?: emptyList()
    val chains = (this["chains"] as? List<*>)?.filterIsInstance<String>() ?: emptyList()
    val methods = (this["methods"] as? List<*>)?.filterIsInstance<String>() ?: emptyList()
    val events = (this["events"] as? List<*>)?.filterIsInstance<String>() ?: emptyList()

    return SettleNamespace(
        accounts = accounts,
        chains = chains,
        methods = methods,
        events = events,
    )
}

fun Map<*, *>.toApprovedNamespace(): Map<String, SettleNamespace> {
    return this.mapNotNull { (key, value) ->
        val k = key as? String
        val v = (value as? Map<*, *>)?.toSettleNamespace()
        if (k != null && v != null) k to v else null
    }.toMap()
}

fun Map<*, *>?.toPropertiesMap(): Map<String, String>? {
    if (this == null) return null

    return this.mapNotNull { (key, value) ->
        val k = key as? String ?: return@mapNotNull null
        val v = value as? String ?: return@mapNotNull null
        k to v
    }.toMap()
}

fun List<*>.toRelayList(): List<Relay> {
    return this.mapNotNull { item ->
        val map = item as? Map<*, *> ?: return@mapNotNull null
        val protocol = map["protocol"] as? String ?: return@mapNotNull null
        Relay(protocol)
    }
}

fun Relay.toMap(): Map<*, *> {
    return mapOf(
        "protocol" to this.protocol,
    )
}

fun List<Relay>.toMap(): List<Map<*, *>> {
    return this.map { item -> item.toMap() }
}

fun Map<*, *>?.toMetadata(): Metadata {
    val thisValue = this!!
    val name = thisValue["name"] as String
    val description = thisValue["description"] as String
    val url = thisValue["url"] as String
    val icons = (thisValue["icons"] as? List<*>)?.mapNotNull { it as? String }
    val verifyUrl = thisValue["verifyUrl"] as? String
    val redirectMap = thisValue["redirect"] as? Map<*, *>

    val redirect = redirectMap?.toRedirect()

    return Metadata(
        name = name,
        description = description,
        url = url,
        icons = icons ?: listOf(""),
        verifyUrl = verifyUrl,
        redirect = redirect
    )
}

fun Metadata.toMap(): Map<*, *> {
    return mapOf(
        "description" to this.description,
        "icons" to this.icons,
        "name" to this.name,
        "redirect" to this.redirect?.toMap(),
        "url" to this.url,
        "verifyUrl" to this.verifyUrl,
    )
}

fun Map<*, *>?.toRedirect(): Redirect? {
    if (this == null) return null

    val native = this["native"] as? String
    val universal = this["universal"] as? String
    val linkMode = this["linkMode"] as? Boolean == true

    return Redirect(native = native, universal = universal, linkMode = linkMode)
}

fun Redirect.toMap(): Map<*, *> {
    return mapOf(
        "native" to this.native,
        "universal" to this.universal,
        "linkMode" to this.linkMode,
    )
}

fun Map<*, *>?.toSessionProposalFfi(): SessionProposalFfi {
    val thisValue = this!!

    val id = thisValue["id"] as String
    val topic = thisValue["topic"] as String
    val pairingSymKey = thisValue["pairingSymKey"] as String
    val proposerPublicKey = thisValue["proposerPublicKey"] as String
    val relays = thisValue["relays"] as List<*>
    val requiredNamespaces = thisValue["requiredNamespaces"] as Map<*, *>
    val optionalNamespaces = thisValue["optionalNamespaces"] as? Map<*, *>
    val metadata = thisValue["metadata"] as Map<*, *>
    val sessionProperties = thisValue["sessionProperties"] as? Map<*, *>
    val scopedProperties = thisValue["scopedProperties"] as? Map<*, *>
    val expiryTimestamp = thisValue["expiryTimestamp"] as? String

    return SessionProposalFfi(
        id = id,
        topic = topic,
        pairingSymKey = pairingSymKey.hexStringToByteArray(),
        proposerPublicKey = proposerPublicKey.hexStringToByteArray(),
        relays = relays.toRelayList(),
        requiredNamespaces = requiredNamespaces.toRequestedNamespace(),
        optionalNamespaces = optionalNamespaces?.toRequestedNamespace(),
        metadata = metadata.toMetadata(),
        sessionProperties = sessionProperties.toPropertiesMap(),
        scopedProperties = scopedProperties.toPropertiesMap(),
        expiryTimestamp = expiryTimestamp?.toULong(),
    )
}

fun SessionProposalFfi.toMap(): Map<*, *> {
    return mapOf(
        "id" to this.id,
        "topic" to this.topic,
        "pairingSymKey" to this.pairingSymKey.byteArrayToHexString(),
        "proposerPublicKey" to this.proposerPublicKey.byteArrayToHexString(),
        "requiredNamespaces" to this.requiredNamespaces.toMap(),
        "optionalNamespaces" to this.optionalNamespaces?.toMap(),
        "expiryTimestamp" to this.expiryTimestamp?.toString(),
        "metadata" to this.metadata.toMap(),
        "relays" to this.relays.toMap(),
        "sessionProperties" to this.sessionProperties,
        "scopedProperties" to this.scopedProperties,
    )
}

fun SessionFfi.toMap(): Map<*, *> {
    return mapOf(
        "sessionSymKey" to this.sessionSymKey.byteArrayToHexString(),
        "selfPublicKey" to this.selfPublicKey,
    )
}

fun String.hexStringToByteArray(): ByteArray {
    require(length % 2 == 0) { "Hex string must have an even length" }
    return chunked(2)
        .map { it.toInt(16).toByte() }
        .toByteArray()
}

fun ByteArray.byteArrayToHexString(): String =
    joinToString("") { "%02x".format(it) }