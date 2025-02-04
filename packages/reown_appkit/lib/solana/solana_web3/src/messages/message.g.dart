// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      version: (json['version'] as num?)?.toInt(),
      header: MessageHeader.fromJson(json['header'] as Map<String, dynamic>),
      accountKeys: (json['accountKeys'] as List<dynamic>)
          .map((e) => Pubkey.fromJson(e as String))
          .toList(),
      recentBlockhash: json['recentBlockhash'] as String,
      instructions: (json['instructions'] as List<dynamic>)
          .map((e) => MessageInstruction.fromJson(e as Map<String, dynamic>)),
      addressTableLookups: (json['addressTableLookups'] as List<dynamic>?)
          ?.map((e) =>
              MessageAddressTableLookup.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'version': instance.version,
      'header': instance.header.toJson(),
      'accountKeys': instance.accountKeys.map((e) => e.toJson()).toList(),
      'recentBlockhash': instance.recentBlockhash,
      'instructions': instance.instructions.map((e) => e.toJson()).toList(),
      'addressTableLookups':
          instance.addressTableLookups.map((e) => e.toJson()).toList(),
    };
