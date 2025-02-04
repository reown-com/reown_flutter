/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'dart:convert' show base64;
import 'package:reown_appkit/solana/solana_borsh/codecs.dart';
import 'package:reown_appkit/solana/solana_borsh/models.dart';
import 'package:reown_appkit/solana/solana_borsh/borsh.dart';
import 'package:reown_appkit/solana/solana_borsh/types.dart';
import '../../programs/stake/state.dart';
import 'account_info.dart';
import 'stake_account_info.dart';

/// Stake Account
/// ------------------------------------------------------------------------------------------------

class StakeAccount extends BorshObject {
  /// Stake Account Information.
  const StakeAccount({
    required this.type,
    required this.info,
  });

  final StakeAccountType type;

  final StakeAccountInfo? info;

  @override
  BorshSchema get borshSchema => codec.schema;

  /// {@macro solana_borsh.BorshObject.borshCodec}
  static final BorshStructCodec codec = borsh.struct({
    'meta': borsh.enumeration(StakeAccountType.values),
    'info': StakeAccountInfo.codec.option(),
  });

  /// {@macro solana_borsh.BorshObject.fromBorsh}
  static StakeAccount fromBorsh(final Iterable<int> buffer) {
    return borsh.deserialize(codec.schema, buffer, StakeAccount.fromJson);
  }

  /// {@macro solana_borsh.BorshObject.tryFromBorsh}
  static StakeAccount? tryFromBorsh(final Iterable<int>? buffer) =>
      buffer != null ? StakeAccount.fromBorsh(buffer) : null;

  /// {@macro solana_borsh.BorshObject.fromBorshBase64}
  factory StakeAccount.fromBorshBase64(final String encoded) =>
      StakeAccount.fromBorsh(base64.decode(encoded));

  /// {@macro solana_borsh.BorshObject.tryFromBorshBase64}
  static StakeAccount? tryFromBorshBase64(final String? encoded) =>
      encoded != null ? StakeAccount.fromBorshBase64(encoded) : null;

  /// Creates an instance of `this` class from an account [info].
  ///
  /// ```
  /// StakeAccount.fromAccountInfo('AA==');
  /// ```
  factory StakeAccount.fromAccountInfo(final AccountInfo info) {
    return info.isJson
        ? StakeAccount.fromJson(info.jsonData)
        : StakeAccount.fromBorshBase64(info.binaryData);
  }

  /// Creates an instance of `this` class from an account [info].
  ///
  /// Returns `null` if [info] is omitted.
  ///
  /// ```
  /// StakeAccount.tryFromAccountInfo('AA==');
  /// ```
  static StakeAccount? tryFromAccountInfo(final AccountInfo? info) =>
      info != null ? StakeAccount.fromAccountInfo(info) : null;

  /// {@macro solana_common.Serializable.fromJson}
  factory StakeAccount.fromJson(final Map<String, dynamic> json) =>
      StakeAccount(
        type: json['type'],
        info: StakeAccountInfo.fromJson(json['stake']),
      );

  /// {@macro solana_common.Serializable.tryFromJson}
  static StakeAccount? tryFromJson(final Map<String, dynamic>? json) =>
      json != null ? StakeAccount.fromJson(json) : null;

  @override
  Map<String, dynamic> toJson() => {
        'type': type,
        'info': info?.toJson(),
      };
}
