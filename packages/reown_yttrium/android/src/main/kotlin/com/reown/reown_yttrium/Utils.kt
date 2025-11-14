package com.reown.reown_yttrium

import io.flutter.plugin.common.MethodChannel

fun errorMissing(key: String, originalParams: Any?, result: MethodChannel.Result): Nothing {
    throw IllegalArgumentException("Missing parameter: $key") // stops execution
}

fun Byte.toHexString(): String = "%02x".format(this)