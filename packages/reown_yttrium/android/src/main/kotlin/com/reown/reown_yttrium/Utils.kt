package com.reown.reown_yttrium

import io.flutter.plugin.common.MethodChannel

fun errorMissing(key: String, originalParams: Any?, result: MethodChannel.Result): Nothing {
    result.error("prepareDetailed", "Missing or invalid parameter: $key in $originalParams", null)
    throw IllegalArgumentException("Missing parameter: $key") // stops execution
}