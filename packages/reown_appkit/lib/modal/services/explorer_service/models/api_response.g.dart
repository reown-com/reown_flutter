// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GetWalletsResponse _$GetWalletsResponseFromJson(Map<String, dynamic> json) =>
    _GetWalletsResponse(
      count: (json['count'] as num).toInt(),
      nextPage: (json['nextPage'] as num?)?.toInt(),
      previousPage: (json['previousPage'] as num?)?.toInt(),
      data: (json['data'] as List<dynamic>)
          .map(
            (e) => AppKitModalWalletListing.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );

Map<String, dynamic> _$GetWalletsResponseToJson(_GetWalletsResponse instance) =>
    <String, dynamic>{
      'count': instance.count,
      'nextPage': instance.nextPage,
      'previousPage': instance.previousPage,
      'data': instance.data.map((e) => e.toJson()).toList(),
    };

_NativeDataResponse _$NativeDataResponseFromJson(Map<String, dynamic> json) =>
    _NativeDataResponse(
      count: (json['count'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map(NativeAppData.fromJson)
          .toList(),
    );

Map<String, dynamic> _$NativeDataResponseToJson(_NativeDataResponse instance) =>
    <String, dynamic>{
      'count': instance.count,
      'data': instance.data.map((e) => e.toJson()).toList(),
    };
