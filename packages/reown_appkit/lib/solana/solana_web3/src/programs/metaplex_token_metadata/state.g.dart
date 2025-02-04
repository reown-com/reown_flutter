// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MetadataCreator _$MetadataCreatorFromJson(Map<String, dynamic> json) =>
    MetadataCreator(
      address: Pubkey.fromJson(json['address'] as String),
      verified: json['verified'] as bool,
      share: (json['share'] as num).toInt(),
    );

Map<String, dynamic> _$MetadataCreatorToJson(MetadataCreator instance) =>
    <String, dynamic>{
      'address': instance.address.toJson(),
      'verified': instance.verified,
      'share': instance.share,
    };

MetadataCollection _$MetadataCollectionFromJson(Map<String, dynamic> json) =>
    MetadataCollection(
      verified: json['verified'] as bool,
      key: Pubkey.fromJson(json['key'] as String),
    );

Map<String, dynamic> _$MetadataCollectionToJson(MetadataCollection instance) =>
    <String, dynamic>{
      'verified': instance.verified,
      'key': instance.key.toJson(),
    };

MetadataUses _$MetadataUsesFromJson(Map<String, dynamic> json) => MetadataUses(
      useMethod: $enumDecode(_$MetadataUseMethodEnumMap, json['useMethod']),
      remaining: (json['remaining'] as num).toInt(),
      total: (json['total'] as num).toInt(),
    );

Map<String, dynamic> _$MetadataUsesToJson(MetadataUses instance) =>
    <String, dynamic>{
      'useMethod': _$MetadataUseMethodEnumMap[instance.useMethod]!,
      'remaining': instance.remaining,
      'total': instance.total,
    };

const _$MetadataUseMethodEnumMap = {
  MetadataUseMethod.burn: 0,
  MetadataUseMethod.multiple: 1,
  MetadataUseMethod.single: 2,
};

MetadataCollectionDetailsV1 _$MetadataCollectionDetailsV1FromJson(
        Map<String, dynamic> json) =>
    MetadataCollectionDetailsV1(
      size: (json['size'] as num).toInt(),
    );

Map<String, dynamic> _$MetadataCollectionDetailsV1ToJson(
        MetadataCollectionDetailsV1 instance) =>
    <String, dynamic>{
      'size': instance.size,
    };
