// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nonce_information.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NonceInformation _$NonceInformationFromJson(Map<String, dynamic> json) =>
    NonceInformation(
      nonce: json['nonce'] as String,
      nonceInstruction: TransactionInstruction.fromJson(
        json['nonceInstruction'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$NonceInformationToJson(NonceInformation instance) =>
    <String, dynamic>{
      'nonce': instance.nonce,
      'nonceInstruction': instance.nonceInstruction.toJson(),
    };
