// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_meta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountMeta _$AccountMetaFromJson(Map<String, dynamic> json) => AccountMeta(
  Pubkey.fromJson(json['pubkey'] as String),
  isSigner: json['isSigner'] as bool? ?? false,
  isWritable: json['isWritable'] as bool? ?? false,
);

Map<String, dynamic> _$AccountMetaToJson(AccountMeta instance) =>
    <String, dynamic>{
      'pubkey': instance.pubkey.toJson(),
      'isSigner': instance.isSigner,
      'isWritable': instance.isWritable,
    };
