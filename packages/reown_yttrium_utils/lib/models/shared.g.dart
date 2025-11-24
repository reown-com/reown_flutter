// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PulseMetadataCompat _$PulseMetadataCompatFromJson(Map<String, dynamic> json) =>
    _PulseMetadataCompat(
      sdkVersion: json['sdkVersion'] as String,
      sdkPlatform: json['sdkPlatform'] as String,
      bundleId: json['bundleId'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$PulseMetadataCompatToJson(
  _PulseMetadataCompat instance,
) => <String, dynamic>{
  'sdkVersion': instance.sdkVersion,
  'sdkPlatform': instance.sdkPlatform,
  'bundleId': instance.bundleId,
  'url': instance.url,
};
