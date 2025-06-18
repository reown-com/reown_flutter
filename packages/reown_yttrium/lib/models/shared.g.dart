// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PulseMetadataCompatImpl _$$PulseMetadataCompatImplFromJson(
        Map<String, dynamic> json) =>
    _$PulseMetadataCompatImpl(
      url: json['url'] as String?,
      bundleId: json['bundleId'] as String?,
      packageName: json['packageName'] as String?,
      sdkVersion: json['sdkVersion'] as String,
      sdkPlatform: json['sdkPlatform'] as String,
    );

Map<String, dynamic> _$$PulseMetadataCompatImplToJson(
        _$PulseMetadataCompatImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'bundleId': instance.bundleId,
      'packageName': instance.packageName,
      'sdkVersion': instance.sdkVersion,
      'sdkPlatform': instance.sdkPlatform,
    };
