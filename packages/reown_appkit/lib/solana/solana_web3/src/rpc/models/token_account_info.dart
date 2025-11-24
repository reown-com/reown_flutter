/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'dart:convert' show base64;
import 'package:reown_appkit/solana/solana_borsh/borsh.dart';
import 'package:reown_appkit/solana/solana_borsh/codecs.dart';
import 'package:reown_appkit/solana/solana_borsh/models.dart';
import 'package:reown_appkit/solana/solana_borsh/types.dart';
import 'account_info.dart';
import 'account_state.dart';

/// Token Account Info
/// ------------------------------------------------------------------------------------------------

class TokenAccountInfo extends BorshObject {
  /// Token Account Information.
  const TokenAccountInfo({
    required this.mint,
    required this.owner,
    required this.amount,
    required this.delegate,
    required this.state,
    required this.isNative,
    required this.delegatedAmount,
    required this.closeAuthority,
  });

  /// The mint address (base-58) associated with this account.
  final String mint;

  /// The owner address (base-58) of this account.
  final String owner;

  /// The amount of tokens this account holds.
  final BigInt amount;

  /// If `delegate` is not-null then `delegatedAmount` represents the amount authorized by the
  /// delegate (base-58 address).
  final String? delegate;

  /// The account's state.
  final AccountState state;

  /// If not-null, this is a native token, and the value logs the rent-exempt reserve. An Account
  /// is required to be rent-exempt, so the value is used by the Processor to ensure that wrapped
  /// SOL accounts do not drop below this threshold.
  final BigInt? isNative;

  /// The amount delegated.
  final BigInt delegatedAmount;

  /// The authority address (base-58) to close the account.
  final String? closeAuthority;

  @override
  BorshSchema get borshSchema => codec.schema;

  /// {@macro solana_borsh.BorshObject.borshCodec}
  static final BorshStructCodec codec = borsh.struct({
    'mint': borsh.pubkey,
    'owner': borsh.pubkey,
    'amount': borsh.u64,
    'delegate': borsh.pubkey.cOption(),
    'state': borsh.enumeration(AccountState.values),
    'isNative': borsh.u64.cOption(),
    'delegatedAmount': borsh.u64,
    'closeAuthority': borsh.pubkey.cOption(),
  });

  /// {@macro solana_borsh.BorshObject.fromBorsh}
  static TokenAccountInfo fromBorsh(final Iterable<int> buffer) {
    return borsh.deserialize(codec.schema, buffer, TokenAccountInfo.fromJson);
  }

  /// {@macro solana_borsh.BorshObject.tryFromBorsh}
  static TokenAccountInfo? tryFromBorsh(final Iterable<int>? buffer) =>
      buffer != null ? TokenAccountInfo.fromBorsh(buffer) : null;

  /// {@macro solana_borsh.BorshObject.fromBorshBase64}
  factory TokenAccountInfo.fromBorshBase64(final String encoded) =>
      TokenAccountInfo.fromBorsh(base64.decode(encoded));

  /// {@macro solana_borsh.BorshObject.tryFromBorshBase64}
  static TokenAccountInfo? tryFromBorshBase64(final String? encoded) =>
      encoded != null && encoded.isNotEmpty
      ? TokenAccountInfo.fromBorshBase64(encoded)
      : null;

  /// Creates an instance of `this` class from an account [info].
  ///
  /// ```
  /// TokenAccountInfo.fromAccountInfo('AA==');
  /// ```
  factory TokenAccountInfo.fromAccountInfo(final AccountInfo info) {
    return info.isJson
        ? TokenAccountInfo.fromJson(info.jsonData)
        : TokenAccountInfo.fromBorshBase64(info.binaryData);
  }

  /// Creates an instance of `this` class from an account [info].
  ///
  /// Returns `null` if [info] is omitted.
  ///
  /// ```
  /// TokenAccountInfo.tryFromAccountInfo('AA==');
  /// ```
  static TokenAccountInfo? tryFromAccountInfo(final AccountInfo? info) =>
      info != null ? TokenAccountInfo.fromAccountInfo(info) : null;

  /// {@macro solana_common.Serializable.fromJson}
  factory TokenAccountInfo.fromJson(final Map<String, dynamic> json) =>
      TokenAccountInfo(
        mint: json['mint'],
        owner: json['owner'],
        amount: json['amount'],
        delegate: json['delegate'],
        state: json['state'],
        isNative: json['isNative'],
        delegatedAmount: json['delegatedAmount'],
        closeAuthority: json['closeAuthority'],
      );

  /// {@macro solana_common.Serializable.tryFromJson}
  static TokenAccountInfo? tryFromJson(final Map<String, dynamic>? json) =>
      json != null ? TokenAccountInfo.fromJson(json) : null;

  @override
  Map<String, dynamic> toJson() => {
    'mint': mint,
    'owner': owner,
    'amount': amount,
    'delegate': delegate,
    'state': state,
    'isNative': isNative,
    'delegatedAmount': delegatedAmount,
    'closeAuthority': closeAuthority,
  };
}
