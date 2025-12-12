package com.reown.reown_yttrium

import kotlinx.serialization.json.*

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