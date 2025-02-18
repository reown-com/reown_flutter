// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commitment_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommitmentConfig _$CommitmentConfigFromJson(Map<String, dynamic> json) =>
    CommitmentConfig(
      commitment: json['commitment'] == null
          ? null
          : Commitment.fromJson(json['commitment'] as String),
    );

Map<String, dynamic> _$CommitmentConfigToJson(CommitmentConfig instance) =>
    <String, dynamic>{
      'commitment': instance.commitment?.toJson(),
    };
