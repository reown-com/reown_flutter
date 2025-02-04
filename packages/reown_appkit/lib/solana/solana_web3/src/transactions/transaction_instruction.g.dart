// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_instruction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionInstruction _$TransactionInstructionFromJson(
        Map<String, dynamic> json) =>
    TransactionInstruction(
      keys: (json['keys'] as List<dynamic>)
          .map((e) => AccountMeta.fromJson(e as Map<String, dynamic>))
          .toList(),
      programId: Pubkey.fromJson(json['programId'] as String),
      data: const Uint8ListJsonConverter().fromJson(json['data'] as List<int>),
    );

Map<String, dynamic> _$TransactionInstructionToJson(
        TransactionInstruction instance) =>
    <String, dynamic>{
      'keys': instance.keys.map((e) => e.toJson()).toList(),
      'programId': instance.programId.toJson(),
      'data': const Uint8ListJsonConverter().toJson(instance.data),
    };
