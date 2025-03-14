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
import uniffi.yttrium.PrepareResponseNotRequired
import uniffi.yttrium.Transaction
import uniffi.yttrium.TransactionFee
import uniffi.yttrium.TxnDetails
import uniffi.yttrium.UiFields

fun Eip1559Estimation.toMap(): Map<String, Any> {
    return mapOf(
        "maxFeePerGas" to maxFeePerGas,
        "maxPriorityFeePerGas" to maxPriorityFeePerGas
    )
}

fun UiFields.toMap(): Map<String, Any> {
    return mapOf(
        "routeResponse" to routeResponse.toMap(),
        "route" to route.map { it.toMap() },
        "localRouteTotal" to localRouteTotal.toMap(),
        "bridge" to bridge.map { it.toMap() },
        "localBridgeTotal" to localBridgeTotal.toMap(),
        "initial" to initial.toMap(),
        "localTotal" to localTotal.toMap()
    )
}

fun PrepareResponseAvailable.toMap(): Map<String, Any> {
    return mapOf(
        "orchestrationId" to orchestrationId,
        "initialTransaction" to initialTransaction.toMap(),
        "transactions" to transactions.map { it.toMap() },
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

fun Metadata.toMap(): Map<String, Any> {
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
    return mapOf("error" to error.toMap())
}

fun BridgingError.toMap(): Map<String, Any> {
    return mapOf("error" to when (this) {
        BridgingError.NO_ROUTES_AVAILABLE -> "noRoutesAvailable"
        BridgingError.INSUFFICIENT_FUNDS -> "insufficientFunds"
        BridgingError.INSUFFICIENT_GAS_FUNDS -> "insufficientGasFunds"
    })
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
