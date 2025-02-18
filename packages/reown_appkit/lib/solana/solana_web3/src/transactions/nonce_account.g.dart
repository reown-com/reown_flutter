// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nonce_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NonceAccount _$NonceAccountFromJson(Map<String, dynamic> json) => NonceAccount(
      version: (json['version'] as num).toInt(),
      state: (json['state'] as num).toInt(),
      authorizedPubkey: Pubkey.fromJson(json['authorizedPubkey'] as String),
      nonce: json['nonce'] as String,
      feeCalculator:
          FeeCalculator.fromJson(json['feeCalculator'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NonceAccountToJson(NonceAccount instance) =>
    <String, dynamic>{
      'version': instance.version,
      'state': instance.state,
      'authorizedPubkey': instance.authorizedPubkey.toJson(),
      'nonce': instance.nonce,
      'feeCalculator': instance.feeCalculator.toJson(),
    };
