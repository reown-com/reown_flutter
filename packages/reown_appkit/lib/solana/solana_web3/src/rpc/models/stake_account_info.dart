/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'dart:convert' show base64;
import 'package:reown_appkit/solana/solana_borsh/borsh.dart';
import 'package:reown_appkit/solana/solana_borsh/codecs.dart';
import 'package:reown_appkit/solana/solana_borsh/models.dart';
import 'package:reown_appkit/solana/solana_borsh/types.dart';
import 'package:reown_appkit/solana/solana_buffer/buffer.dart';
import '../../programs/stake/state.dart';
import 'account_info.dart';

/// Stake Account Info
/// ------------------------------------------------------------------------------------------------

class StakeAccountInfo extends BorshObject {
  /// Stake Account Information.
  const StakeAccountInfo({
    required this.state,
    required this.meta,
    required this.stake,
  });

  /// Stake account type.
  final StakeState state;

  /// The mint address (base-58) associated with this account.
  final StakeMeta meta;

  /// The owner address (base-58) of this account.
  final Stake stake;

  @override
  BorshSchema get borshSchema => codec.schema;

  /// {@macro solana_borsh.BorshObject.borshCodec}
  static final BorshStructSizedCodec codec = borsh.structSized({
    'state': borsh.enumeration(StakeState.values, ByteLength.u32),
    'meta': StakeMeta.codec,
    'stake': Stake.codec,
  });

  /// {@macro solana_borsh.BorshObject.fromBorsh}
  static StakeAccountInfo fromBorsh(final Iterable<int> buffer) {
    return borsh.deserialize(codec.schema, buffer, StakeAccountInfo.fromJson);
  }

  /// {@macro solana_borsh.BorshObject.tryFromBorsh}
  static StakeAccountInfo? tryFromBorsh(final Iterable<int>? buffer) =>
      buffer != null ? StakeAccountInfo.fromBorsh(buffer) : null;

  /// {@macro solana_borsh.BorshObject.fromBorshBase64}
  factory StakeAccountInfo.fromBorshBase64(final String encoded) =>
      StakeAccountInfo.fromBorsh(base64.decode(encoded));

  /// {@macro solana_borsh.BorshObject.tryFromBorshBase64}
  static StakeAccountInfo? tryFromBorshBase64(final String? encoded) =>
      encoded != null ? StakeAccountInfo.fromBorshBase64(encoded) : null;

  /// Creates an instance of `this` class from an account [info].
  ///
  /// ```
  /// StakeAccountInfo.fromAccountInfo('AA==');
  /// ```
  factory StakeAccountInfo.fromAccountInfo(final AccountInfo info) {
    return info.isJson
        ? StakeAccountInfo.fromJson(info.jsonData)
        : StakeAccountInfo.fromBorshBase64(info.binaryData);
  }

  /// Creates an instance of `this` class from an account [info].
  ///
  /// Returns `null` if [info] is omitted.
  ///
  /// ```
  /// StakeAccountInfo.tryFromAccountInfo('AA==');
  /// ```
  static StakeAccountInfo? tryFromAccountInfo(final AccountInfo? info) =>
      info != null ? StakeAccountInfo.fromAccountInfo(info) : null;

  /// {@macro solana_common.Serializable.fromJson}
  factory StakeAccountInfo.fromJson(final Map<String, dynamic> json) =>
      StakeAccountInfo(
        state: json['state'],
        meta: StakeMeta.fromJson(json['meta']),
        stake: Stake.fromJson(json['stake']),
      );

  /// {@macro solana_common.Serializable.tryFromJson}
  static StakeAccountInfo? tryFromJson(final Map<String, dynamic>? json) =>
      json != null ? StakeAccountInfo.fromJson(json) : null;

  @override
  Map<String, dynamic> toJson() => {
    'state': state,
    '_state_padding_': const [0, 0, 0],
    'meta': meta.toJson(),
    'stake': stake.toJson(),
  };
}
