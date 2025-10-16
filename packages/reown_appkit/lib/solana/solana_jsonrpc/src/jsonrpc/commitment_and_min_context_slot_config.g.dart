// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commitment_and_min_context_slot_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommitmentAndMinContextSlotConfig _$CommitmentAndMinContextSlotConfigFromJson(
  Map<String, dynamic> json,
) => CommitmentAndMinContextSlotConfig(
  commitment: json['commitment'] == null
      ? null
      : Commitment.fromJson(json['commitment'] as String),
  minContextSlot: (json['minContextSlot'] as num?)?.toInt(),
);

Map<String, dynamic> _$CommitmentAndMinContextSlotConfigToJson(
  CommitmentAndMinContextSlotConfig instance,
) => <String, dynamic>{
  'commitment': instance.commitment?.toJson(),
  'minContextSlot': instance.minContextSlot,
};
