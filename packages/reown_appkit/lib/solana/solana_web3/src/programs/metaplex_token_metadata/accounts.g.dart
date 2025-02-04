// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MasterEditionAccount _$MasterEditionAccountFromJson(
        Map<String, dynamic> json) =>
    MasterEditionAccount(
      key: (json['key'] as num).toInt(),
      supply: BigInt.parse(json['supply'] as String),
      maxSupply: json['maxSupply'] == null
          ? null
          : BigInt.parse(json['maxSupply'] as String),
    );

Map<String, dynamic> _$MasterEditionAccountToJson(
        MasterEditionAccount instance) =>
    <String, dynamic>{
      'key': instance.key,
      'supply': instance.supply.toString(),
      'maxSupply': instance.maxSupply?.toString(),
    };

MetadataAccount _$MetadataAccountFromJson(Map<String, dynamic> json) =>
    MetadataAccount(
      key: (json['key'] as num).toInt(),
      updateAuthority: json['updateAuthority'] as String,
      mint: json['mint'] as String,
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      uri: json['uri'] as String,
      sellerFeeBasisPoints: (json['sellerFeeBasisPoints'] as num).toInt(),
      creators: (json['creators'] as List<dynamic>?)
          ?.map((e) => MetadataCreator.fromJson(e as Map<String, dynamic>))
          .toList(),
      primarySaleHappened: json['primarySaleHappened'] as bool,
      isMutable: json['isMutable'] as bool,
      editionNonce: (json['editionNonce'] as num?)?.toInt(),
      tokenStandard:
          $enumDecodeNullable(_$TokenStandardEnumMap, json['tokenStandard']),
      collection: json['collection'] == null
          ? null
          : MetadataCollection.fromJson(
              json['collection'] as Map<String, dynamic>),
      uses: json['uses'] == null
          ? null
          : MetadataUses.fromJson(json['uses'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MetadataAccountToJson(MetadataAccount instance) =>
    <String, dynamic>{
      'key': instance.key,
      'updateAuthority': instance.updateAuthority,
      'mint': instance.mint,
      'name': instance.name,
      'symbol': instance.symbol,
      'uri': instance.uri,
      'sellerFeeBasisPoints': instance.sellerFeeBasisPoints,
      'creators': instance.creators?.map((e) => e.toJson()).toList(),
      'primarySaleHappened': instance.primarySaleHappened,
      'isMutable': instance.isMutable,
      'editionNonce': instance.editionNonce,
      'tokenStandard': _$TokenStandardEnumMap[instance.tokenStandard],
      'collection': instance.collection?.toJson(),
      'uses': instance.uses?.toJson(),
    };

const _$TokenStandardEnumMap = {
  TokenStandard.nonFungible: 0,
  TokenStandard.fungibleAsset: 1,
  TokenStandard.fungible: 2,
  TokenStandard.nonFungibleEdition: 3,
  TokenStandard.programmableNonFungible: 4,
};
