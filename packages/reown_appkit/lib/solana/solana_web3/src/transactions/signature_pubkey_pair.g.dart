// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signature_pubkey_pair.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignaturePubkeyPair _$SignaturePubkeyPairFromJson(Map<String, dynamic> json) =>
    SignaturePubkeyPair(
      signature: _$JsonConverterFromJson<List<int>, Uint8List>(
          json['signature'], const Uint8ListJsonConverter().fromJson),
      pubkey: Pubkey.fromJson(json['pubkey'] as String),
    );

Map<String, dynamic> _$SignaturePubkeyPairToJson(
        SignaturePubkeyPair instance) =>
    <String, dynamic>{
      'signature': _$JsonConverterToJson<List<int>, Uint8List>(
          instance.signature, const Uint8ListJsonConverter().toJson),
      'pubkey': instance.pubkey.toJson(),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
