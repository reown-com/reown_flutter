/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'dart:convert' show base64;
import 'package:reown_appkit/solana/solana_borsh/borsh.dart';
import 'package:reown_appkit/solana/solana_borsh/codecs.dart';
import 'package:reown_appkit/solana/solana_borsh/models.dart';
import 'package:reown_appkit/solana/solana_borsh/types.dart';
import 'package:reown_appkit/solana/solana_common/types.dart' show u64;

/// Epoch Info
/// ------------------------------------------------------------------------------------------------

class EpochInfo extends BorshObject {
  /// Information about an epoch.
  const EpochInfo({
    required this.absoluteSlot,
    required this.blockHeight,
    required this.epoch,
    required this.slotIndex,
    required this.slotsInEpoch,
    required this.transactionCount,
  });

  /// The epoch slot.
  final u64 absoluteSlot;

  /// The epoch block height.
  final u64 blockHeight;

  /// The epoch.
  final u64 epoch;

  /// The slot relative to the start of [epoch].
  final u64 slotIndex;

  /// The number of slots in [epoch].
  final u64 slotsInEpoch;

  /// The total number of transactions processed without error since genesis up to [epoch].
  final u64? transactionCount;

  @override
  BorshSchema get borshSchema => codec.schema;

  /// {@macro solana_borsh.BorshObject.borshCodec}
  static final BorshStructCodec codec = borsh.struct({
    'absoluteSlot': borsh.i64,
    'blockHeight': borsh.i64,
    'epoch': borsh.i64,
    'slotIndex': borsh.i64,
    'slotsInEpoch': borsh.i64,
    'transactionCount': borsh.i64,
  });

  /// {@macro solana_borsh.BorshObject.fromBorsh}
  static EpochInfo fromBorsh(final Iterable<int> buffer) {
    return borsh.deserialize(codec.schema, buffer, EpochInfo.fromJson);
  }

  /// {@macro solana_borsh.BorshObject.tryFromBorsh}
  static EpochInfo? tryFromBorsh(final Iterable<int>? buffer) =>
      buffer != null ? EpochInfo.fromBorsh(buffer) : null;

  /// {@macro solana_borsh.BorshObject.fromBorshBase64}
  factory EpochInfo.fromBorshBase64(final String encoded) =>
      EpochInfo.fromBorsh(base64.decode(encoded));

  /// {@macro solana_borsh.BorshObject.tryFromBorshBase64}
  static EpochInfo? tryFromBorshBase64(final String? encoded) =>
      encoded != null ? EpochInfo.fromBorshBase64(encoded) : null;

  /// {@macro solana_common.Serializable.fromJson}
  factory EpochInfo.fromJson(final Map<String, dynamic> json) => EpochInfo(
        absoluteSlot: json['absoluteSlot'],
        blockHeight: json['blockHeight'],
        epoch: json['epoch'],
        slotIndex: json['slotIndex'],
        slotsInEpoch: json['slotsInEpoch'],
        transactionCount: json['transactionCount'],
      );

  /// {@macro solana_common.Serializable.tryFromJson}
  static EpochInfo? tryFromJson(final Map<String, dynamic>? json) =>
      json != null ? EpochInfo.fromJson(json) : null;

  @override
  Map<String, dynamic> toJson() => {
        'absoluteSlot': absoluteSlot,
        'blockHeight': blockHeight,
        'epoch': epoch,
        'slotIndex': slotIndex,
        'slotsInEpoch': slotsInEpoch,
        'transactionCount': transactionCount,
      };
}
