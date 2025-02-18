// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_address_table_lookup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageAddressTableLookup _$MessageAddressTableLookupFromJson(
        Map<String, dynamic> json) =>
    MessageAddressTableLookup(
      accountKey: Pubkey.fromJson(json['accountKey'] as String),
      writableIndexes: (json['writableIndexes'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      readonlyIndexes: (json['readonlyIndexes'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$MessageAddressTableLookupToJson(
        MessageAddressTableLookup instance) =>
    <String, dynamic>{
      'accountKey': instance.accountKey.toJson(),
      'writableIndexes': instance.writableIndexes,
      'readonlyIndexes': instance.readonlyIndexes,
    };
