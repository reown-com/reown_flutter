package com.reown.reown_yttrium_utils

import kotlinx.serialization.json.*
import uniffi.uniffi_yttrium_utils.Eip1559Estimation
import uniffi.yttrium_utils.Amount
import uniffi.yttrium_utils.BridgingError
import uniffi.yttrium_utils.ExecuteDetails
import uniffi.yttrium_utils.FeeEstimatedTransaction
import uniffi.yttrium_utils.FundingMetadata
import uniffi.yttrium_utils.InitialTransactionMetadata
import uniffi.yttrium_utils.PrepareResponseAvailable
import uniffi.yttrium_utils.PrepareResponseError
import uniffi.yttrium_utils.PrepareResponseMetadata
import uniffi.yttrium_utils.PrepareResponseNotRequired
import uniffi.yttrium_utils.Transaction
import uniffi.yttrium_utils.TransactionFee
import uniffi.yttrium_utils.TxnDetails
import uniffi.yttrium_utils.SolanaTxnDetails
import uniffi.yttrium_utils.UiFields
import uniffi.yttrium_utils.Route
import uniffi.yttrium_utils.SendTxMessage
import uniffi.yttrium_utils.SolanaTransaction
import uniffi.yttrium_utils.Transactions

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
    val transactions = transactions.map { it.toMap() }.first() // Route does not have toMap() so it's done here
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

fun ExecuteDetails.toMap(): Map<String, *> {
    val json = Json.encodeToString(this)
    val elem = Json.parseToJsonElement(json)
    return (elem as JsonObject).mapValues { Json.encodeToString(it.value) }
}

fun Map<String, Any?>.toSendTxMessage(): SendTxMessage {
    val jsonString = mapToJsonString(this)
    return Json.decodeFromString<SendTxMessage>(jsonString)
}

fun List<*>.toSendTxMessageList(): List<SendTxMessage> {
    return this.mapNotNull { item ->
        (item as? Map<String, Any?>)?.toSendTxMessage()
    }
}

/** JSON string -> Map<String, Any?> (single function) */
fun jsonStringToMap(json: String): Map<String, Any?> {
    val root = Json.parseToJsonElement(json)
    require(root is JsonObject) { "Root JSON element must be an object" }
    fun elemToAny(e: JsonElement): Any? = when (e) {
        is JsonNull -> null
        is JsonPrimitive -> e.booleanOrNull ?: e.intOrNull ?: e.longOrNull ?: e.doubleOrNull ?: e.content
        is JsonObject -> e.mapValues { (_, v) -> elemToAny(v) }
        is JsonArray -> e.map { elemToAny(it) }
    }
    return root.mapValues { (_, v) -> elemToAny(v) }
}

/** Map<String, Any?> -> JSON string (single function) */
fun mapToJsonString(map: Map<String, Any?>): String {
    fun anyToElem(value: Any?): JsonElement = when (value) {
        null -> JsonNull
        is Boolean -> JsonPrimitive(value)
        is Number -> JsonPrimitive(value)
        is String -> JsonPrimitive(value)
        is Map<*, *> -> buildJsonObject { value.forEach { (k, v) -> put(k.toString(), anyToElem(v)) } }
        is Collection<*> -> buildJsonArray { value.forEach { add(anyToElem(it)) } }
        is Array<*> -> buildJsonArray { value.forEach { add(anyToElem(it)) } }
        else -> JsonPrimitive(value.toString())
    }
    return Json.encodeToString(anyToElem(map))
}