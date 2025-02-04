// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_header.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageHeader _$MessageHeaderFromJson(Map<String, dynamic> json) =>
    MessageHeader(
      numRequiredSignatures: (json['numRequiredSignatures'] as num).toInt(),
      numReadonlySignedAccounts:
          (json['numReadonlySignedAccounts'] as num).toInt(),
      numReadonlyUnsignedAccounts:
          (json['numReadonlyUnsignedAccounts'] as num).toInt(),
    );

Map<String, dynamic> _$MessageHeaderToJson(MessageHeader instance) =>
    <String, dynamic>{
      'numRequiredSignatures': instance.numRequiredSignatures,
      'numReadonlySignedAccounts': instance.numReadonlySignedAccounts,
      'numReadonlyUnsignedAccounts': instance.numReadonlyUnsignedAccounts,
    };
