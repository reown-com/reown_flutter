/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'dart:convert' show base64;
import 'package:reown_appkit/solana/solana_borsh/borsh.dart';
import 'package:reown_appkit/solana/solana_borsh/codecs.dart';
import 'package:reown_appkit/solana/solana_borsh/models.dart';
import 'package:reown_appkit/solana/solana_borsh/types.dart';
import 'account_info.dart';

/// Mint Account Info
/// ------------------------------------------------------------------------------------------------

class MintAccountInfo extends BorshObject {
  /// Mint Account Information.
  const MintAccountInfo({
    required this.mintAuthority,
    required this.supply,
    required this.decimals,
    required this.isInitialized,
    required this.freezeAuthority,
  });

  /// Optional authority (base-58) used to mint new tokens. The mint authority may only be provided
  /// during mint creation. If no mint authority is present then the mint has a fixed supply and no
  /// further tokens may be minted.
  final String? mintAuthority;

  /// Total supply of tokens.
  final BigInt supply;

  /// Number of base 10 digits to the right of the decimal place.
  final int decimals;

  /// Is this mint initialized.
  final bool isInitialized;

  /// Optional authority (base-58) to freeze token accounts.
  final String? freezeAuthority;

  @override
  BorshSchema get borshSchema => codec.schema;

  /// {@macro solana_borsh.BorshObject.borshCodec}
  static final BorshStructCodec codec = borsh.struct({
    'mintAuthority': borsh.pubkey.cOption(),
    'supply': borsh.u64,
    'decimals': borsh.u8,
    'isInitialized': borsh.boolean,
    'isNative': borsh.u64.cOption(),
    'freezeAuthority': borsh.pubkey.cOption(),
  });

  /// {@macro solana_borsh.BorshObject.fromBorsh}
  static MintAccountInfo fromBorsh(final Iterable<int> buffer) {
    return borsh.deserialize(codec.schema, buffer, MintAccountInfo.fromJson);
  }

  /// {@macro solana_borsh.BorshObject.tryFromBorsh}
  static MintAccountInfo? tryFromBorsh(final Iterable<int>? buffer) =>
      buffer != null ? MintAccountInfo.fromBorsh(buffer) : null;

  /// {@macro solana_borsh.BorshObject.fromBorshBase64}
  factory MintAccountInfo.fromBorshBase64(final String encoded) =>
      MintAccountInfo.fromBorsh(base64.decode(encoded));

  /// {@macro solana_borsh.BorshObject.tryFromBorshBase64}
  static MintAccountInfo? tryFromBorshBase64(final String? encoded) =>
      encoded != null && encoded.isNotEmpty
      ? MintAccountInfo.fromBorshBase64(encoded)
      : null;

  /// Creates an instance of `this` class from an account [info].
  ///
  /// ```
  /// MintAccountInfo.fromAccountInfo('AA==');
  /// ```
  factory MintAccountInfo.fromAccountInfo(final AccountInfo info) {
    return info.isJson
        ? MintAccountInfo.fromJson(info.jsonData)
        : MintAccountInfo.fromBorshBase64(info.binaryData);
  }

  /// Creates an instance of `this` class from an account [info].
  ///
  /// Returns `null` if [info] is omitted.
  ///
  /// ```
  /// MintAccountInfo.tryFromAccountInfo('AA==');
  /// ```
  static MintAccountInfo? tryFromAccountInfo(final AccountInfo? info) =>
      info != null ? MintAccountInfo.fromAccountInfo(info) : null;

  /// {@macro solana_common.Serializable.fromJson}
  factory MintAccountInfo.fromJson(final Map<String, dynamic> json) =>
      MintAccountInfo(
        mintAuthority: json['mintAuthority'],
        supply: json['supply'],
        decimals: json['decimals'],
        isInitialized: json['isInitialized'],
        freezeAuthority: json['freezeAuthority'],
      );

  /// {@macro solana_common.Serializable.tryFromJson}
  static MintAccountInfo? tryFromJson(final Map<String, dynamic>? json) =>
      json != null ? MintAccountInfo.fromJson(json) : null;

  @override
  Map<String, dynamic> toJson() => {
    'mintAuthority': mintAuthority,
    'supply': supply,
    'decimals': decimals,
    'isInitialized': isInitialized,
    'freezeAuthority': freezeAuthority,
  };
}
