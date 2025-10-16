// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
  signatures: (json['signatures'] as List<dynamic>?)
      ?.map((e) => const Uint8ListJsonConverter().fromJson(e as List<int>))
      .toList(),
  message: Message.fromJson(json['message'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'signatures': instance.signatures
          .map(const Uint8ListJsonConverter().toJson)
          .toList(),
      'message': instance.message.toJson(),
    };
