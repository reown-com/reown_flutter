package com.reown.reown_yttrium

import io.flutter.plugin.common.MethodChannel
import uniffi.yttrium.DisplayData
import uniffi.yttrium.WalletPayAction
import uniffi.yttrium.WalletPayDisplayItem

fun errorMissing(key: String, originalParams: Any?, result: MethodChannel.Result): Nothing {
    throw IllegalArgumentException("Missing parameter: $key") // stops execution
}
