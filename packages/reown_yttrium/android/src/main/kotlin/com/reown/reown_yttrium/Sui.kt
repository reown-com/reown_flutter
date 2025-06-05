package com.reown.reown_yttrium

import io.flutter.plugin.common.MethodChannel
import uniffi.yttrium.PulseMetadata
import uniffi.yttrium.SuiClient

class Sui {
    companion object {
        private lateinit var suiClient: SuiClient

        fun initialize(packageName: String?, params: Any?, result: MethodChannel.Result) {
            val dict = params as? Map<*, *> ?: return result.error("initialize", "Invalid parameters: not a map", null)

            val projectId = dict["projectId"] as? String ?: return errorMissing("projectId", params, result)
            val pulseMetadataDict = dict["pulseMetadata"] as? Map<*, *> ?: return errorMissing("pulseMetadata", params, result)

            val url = pulseMetadataDict["url"] as? String ?: return errorMissing("url", params, result)
            val packageName = packageName ?: pulseMetadataDict["packageName"] as? String ?: return errorMissing("packageName", params, result)
            val sdkVersion = pulseMetadataDict["sdkVersion"] as? String ?: return errorMissing("sdkVersion", params, result)
            val sdkPlatform = pulseMetadataDict["sdkPlatform"] as? String ?: return errorMissing("sdkPlatform", params, result)

            val pulseMetadata = PulseMetadata(url, packageName, sdkVersion, sdkPlatform)

            suiClient = SuiClient(projectId = projectId, pulseMetadata = pulseMetadata)

            result.success(true)
        }
    }
}