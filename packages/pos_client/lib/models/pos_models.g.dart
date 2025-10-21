// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pos_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PaymentIntent _$PaymentIntentFromJson(Map<String, dynamic> json) =>
    _PaymentIntent(
      token: PosToken.fromJson(json['token'] as Map<String, dynamic>),
      amount: json['amount'] as String,
      recipient: json['recipient'] as String,
    );

Map<String, dynamic> _$PaymentIntentToJson(_PaymentIntent instance) =>
    <String, dynamic>{
      'token': instance.token,
      'amount': instance.amount,
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

_PosNetwork _$PosNetworkFromJson(Map<String, dynamic> json) => _PosNetwork(
      name: json['name'] as String,
      chainId: json['chainId'] as String,
    );

Map<String, dynamic> _$PosNetworkToJson(_PosNetwork instance) =>
    <String, dynamic>{'name': instance.name, 'chainId': instance.chainId};

_PosToken _$PosTokenFromJson(Map<String, dynamic> json) => _PosToken(
      network: PosNetwork.fromJson(json['network'] as Map<String, dynamic>),
      symbol: json['symbol'] as String,
      standard: json['standard'] as String,
      address: json['address'] as String,
    );

Map<String, dynamic> _$PosTokenToJson(_PosToken instance) => <String, dynamic>{
      'network': instance.network,
      'symbol': instance.symbol,
      'standard': instance.standard,
      'address': instance.address,
    };
