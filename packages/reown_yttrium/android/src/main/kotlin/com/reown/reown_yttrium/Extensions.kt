package com.reown.reown_yttrium

import uniffi.yttrium.DisplayData
import uniffi.yttrium.PaymentOption
import uniffi.yttrium.TransferConfirmation
import uniffi.yttrium.WalletPayAction
import uniffi.yttrium.WalletPayDisplayItem
import uniffi.yttrium.WalletPayResponseResultV1

fun Byte.toHexString(): String = "%02x".format(this)

// For a single display item
fun WalletPayDisplayItem.toMap(): Map<String, Any?> {
    return mapOf(
        "asset" to asset,
        "amount" to amount,
        "chain" to chain,   // nullable is fine, Flutter sees null
        "symbol" to symbol, // nullable is fine
    )
}

// For the container object
fun DisplayData.toMap(): Map<String, Any?> {
    return mapOf(
        "paymentOptions" to paymentOptions.map { it.toMap() }
    )
}

fun Map<*, *>.toPaymentOption(): PaymentOption {
    val asset = this["asset"] as? String
        ?: error("Missing or invalid 'asset' in PaymentOption map")
    val amount = this["amount"] as? String
        ?: error("Missing or invalid 'amount' in PaymentOption map")
    val recipient = this["recipient"] as? String
        ?: error("Missing or invalid 'recipient' in PaymentOption map")
    val types = (this["types"] as? List<*>)?.filterIsInstance<String>() ?: emptyList()

    return PaymentOption(
        asset = asset,
        amount = amount,
        recipient = recipient,
        types = types,
    )
}

fun WalletPayAction.toMap(): Map<String, Any?> {
    return mapOf(
        "method" to method,
        "data" to data,
        "hash" to hash,
    )
}

fun List<WalletPayAction>.toWalletPayActionMapList(): List<Map<String, Any?>> {
    return map { it.toMap() }
}

fun TransferConfirmation.toMap(): Map<String, Any?> {
    return mapOf(
        "type" to type,
        "hash" to hash,
        "data" to data,
    )
}

fun WalletPayResponseResultV1.toMap(): Map<String, Any?> {
    return mapOf(
        "transferConfirmation" to transferConfirmation.toMap(),
    )
}

fun List<WalletPayResponseResultV1>.toWalletPayResponseResultV1MapList(): List<Map<String, Any?>> {
    return map { it.toMap() }
}