// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ton.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TonKeyPair _$TonKeyPairFromJson(Map<String, dynamic> json) =>
    _TonKeyPair(sk: json['sk'] as String, pk: json['pk'] as String);

Map<String, dynamic> _$TonKeyPairToJson(_TonKeyPair instance) =>
    <String, dynamic>{'sk': instance.sk, 'pk': instance.pk};

_TonIdentity _$TonIdentityFromJson(Map<String, dynamic> json) => _TonIdentity(
  friendlyEq: json['friendlyEq'] as String,
  rawHex: json['rawHex'] as String,
  workchain: json['workchain'] as String,
);

Map<String, dynamic> _$TonIdentityToJson(_TonIdentity instance) =>
    <String, dynamic>{
      'friendlyEq': instance.friendlyEq,
      'rawHex': instance.rawHex,
      'workchain': instance.workchain,
    };

_TonMessage _$TonMessageFromJson(Map<String, dynamic> json) => _TonMessage(
  address: json['address'] as String,
  amount: json['amount'] as String,
  payload: json['payload'] as String,
  stateInit: json['stateInit'] as String,
);

Map<String, dynamic> _$TonMessageToJson(_TonMessage instance) =>
    <String, dynamic>{
      'address': instance.address,
      'amount': instance.amount,
      'payload': instance.payload,
      'stateInit': instance.stateInit,
    };
