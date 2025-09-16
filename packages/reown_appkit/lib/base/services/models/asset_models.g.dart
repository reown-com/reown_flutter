// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AssetMetadata _$AssetMetadataFromJson(Map<String, dynamic> json) =>
    _AssetMetadata(
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      decimals: (json['decimals'] as num).toInt(),
    );

Map<String, dynamic> _$AssetMetadataToJson(_AssetMetadata instance) =>
    <String, dynamic>{
      'name': instance.name,
      'symbol': instance.symbol,
      'decimals': instance.decimals,
    };

_ExchangeAsset _$ExchangeAssetFromJson(Map<String, dynamic> json) =>
    _ExchangeAsset(
      network: json['network'] as String,
      asset: json['asset'] as String,
      metadata: AssetMetadata.fromJson(
        json['metadata'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$ExchangeAssetToJson(_ExchangeAsset instance) =>
    <String, dynamic>{
      'network': instance.network,
      'asset': instance.asset,
      'metadata': instance.metadata.toJson(),
    };
