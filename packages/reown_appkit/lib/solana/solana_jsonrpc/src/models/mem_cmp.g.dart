// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mem_cmp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemCmp _$MemCmpFromJson(Map<String, dynamic> json) => MemCmp(
  offset: (json['offset'] as num).toInt(),
  bytes: json['bytes'] as String,
);

Map<String, dynamic> _$MemCmpToJson(MemCmp instance) => <String, dynamic>{
  'offset': instance.offset,
  'bytes': instance.bytes,
};
