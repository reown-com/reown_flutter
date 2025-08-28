// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pos_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PaymentIntent _$PaymentIntentFromJson(Map<String, dynamic> json) =>
    _PaymentIntent(
      token: json['token'] as String,
      amount: json['amount'] as String,
      chainId: json['chainId'] as String,
      recipient: json['recipient'] as String,
    );

Map<String, dynamic> _$PaymentIntentToJson(_PaymentIntent instance) =>
    <String, dynamic>{
      'token': instance.token,
      'amount': instance.amount,
      'chainId': instance.chainId,
      'recipient': instance.recipient,
    };

_Metadata _$MetadataFromJson(Map<String, dynamic> json) => _Metadata(
  merchantName: json['merchantName'] as String,
  description: json['description'] as String,
  url: json['url'] as String,
  logoIcon: json['logoIcon'] as String,
);

Map<String, dynamic> _$MetadataToJson(_Metadata instance) => <String, dynamic>{
  'merchantName': instance.merchantName,
  'description': instance.description,
  'url': instance.url,
  'logoIcon': instance.logoIcon,
};

_PosNetworkData _$PosNetworkDataFromJson(Map<String, dynamic> json) =>
    _PosNetworkData(
      name: json['name'] as String,
      currency: json['currency'] as String,
      chainId: json['chainId'] as String,
    );

Map<String, dynamic> _$PosNetworkDataToJson(_PosNetworkData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'currency': instance.currency,
      'chainId': instance.chainId,
    };

_PosToken _$PosTokenFromJson(Map<String, dynamic> json) => _PosToken(
  network: $enumDecode(_$PosNetworkEnumMap, json['network']),
  symbol: json['symbol'] as String,
  address: json['address'] as String,
);

Map<String, dynamic> _$PosTokenToJson(_PosToken instance) => <String, dynamic>{
  'network': _$PosNetworkEnumMap[instance.network]!,
  'symbol': instance.symbol,
  'address': instance.address,
};

const _$PosNetworkEnumMap = {
  PosNetwork.ethereum: 'ethereum',
  PosNetwork.polygon: 'polygon',
  PosNetwork.binanceSmartChain: 'binanceSmartChain',
  PosNetwork.avalanche: 'avalanche',
  PosNetwork.arbitrum: 'arbitrum',
  PosNetwork.optimism: 'optimism',
  PosNetwork.base: 'base',
  PosNetwork.fantom: 'fantom',
  PosNetwork.cronos: 'cronos',
  PosNetwork.polygonZkEVM: 'polygonZkEVM',
  PosNetwork.sepolia: 'sepolia',
};
