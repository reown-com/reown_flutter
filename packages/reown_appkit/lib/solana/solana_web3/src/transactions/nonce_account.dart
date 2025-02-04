/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'dart:convert' show base64;
import 'package:json_annotation/json_annotation.dart' show JsonSerializable;
import 'package:reown_appkit/solana/solana_borsh/borsh.dart';
import 'package:reown_appkit/solana/solana_borsh/codecs.dart';
import 'package:reown_appkit/solana/solana_borsh/models.dart';
import 'package:reown_appkit/solana/solana_borsh/types.dart';
import 'package:reown_appkit/solana/solana_buffer/buffer.dart';
import '../programs/system/program.dart';
import '../crypto/pubkey.dart';
import '../rpc/models/account_info.dart';
import 'fee_calculator.dart';
import 'nonce_information.dart';

part 'nonce_account.g.dart';

/// Nonce Account
/// ------------------------------------------------------------------------------------------------

@JsonSerializable(explicitToJson: true)
class NonceAccount extends BorshObject {
  /// https://docs.solana.com/offline-signing/durable-nonce
  ///
  /// Durable transaction nonces are a mechanism for getting around the typical short lifetime of a
  /// transaction's recent_blockhash.
  ///
  /// Each transaction submitted on Solana must specify a recent blockhash that was generated within
  /// 2 minutes of the latest blockhash. If it takes longer than 2 minutes to get everybody’s
  /// signatures, then you have to use nonce accounts.
  ///
  /// For example, nonce accounts are used in cases when you need multiple people to sign a
  /// transaction, but they can’t all be available to sign it on the same computer within a short
  /// enough time period.
  const NonceAccount({
    required this.version,
    required this.state,
    required this.authorizedPubkey,
    required this.nonce,
    required this.feeCalculator,
  });

  /// Version.
  final int version;

  /// Account state.
  final int state;

  /// The authority of the nonce account.
  final Pubkey authorizedPubkey;

  /// Durable nonce (32 byte base-58 encoded string).
  final String nonce;

  /// Transaction fee calculator.
  // ignore: deprecated_member_use_from_same_package
  final FeeCalculator feeCalculator;

  /// Nonce account layout byte length.
  static int get length => codec.byteLength;

  /// {@macro solana_borsh.BorshObject.borshCodec}
  static BorshStructSizedCodec get codec {
    return borsh.structSized({
      'version': borsh.u32,
      'state': borsh.u32,
      'authorizedPubkey': borsh.pubkey,
      'nonce': borsh.stringSized(32, encoding: BufferEncoding.base58),
      // ignore: deprecated_member_use_from_same_package
      'feeCalculator': FeeCalculator.codec,
    });
  }

  @override
  BorshSchema get borshSchema => codec.schema;

  /// {@macro solana_common.Serializable.fromJson}
  factory NonceAccount.fromJson(final Map<String, dynamic> json) =>
      _$NonceAccountFromJson(json);

  /// {@macro solana_borsh.BorshObject.fromBorsh}
  static NonceAccount fromBorsh(final Iterable<int> buffer) =>
      borsh.deserialize(codec.schema, buffer, NonceAccount.fromJson);

  /// {@macro solana_borsh.BorshObject.tryFromBorsh}
  static NonceAccount? tryFromBorsh(final Iterable<int>? buffer) =>
      buffer != null ? NonceAccount.fromBorsh(buffer) : null;

  /// {@macro solana_borsh.BorshObject.fromBorshBase64}
  static NonceAccount fromBorshBase64(final String encoded) =>
      NonceAccount.fromBorsh(base64.decode(encoded));

  /// {@macro solana_borsh.BorshObject.tryFromBorshBase64}
  static NonceAccount? tryFromBorshBase64(final String? encoded) =>
      encoded != null ? NonceAccount.fromBorshBase64(encoded) : null;

  /// Creates an instance of `this` class from an account [info].
  ///
  /// ```
  /// NonceAccount.fromAccountInfo('AA==');
  /// ```
  factory NonceAccount.fromAccountInfo(final AccountInfo info) {
    return info.isBinary
        ? NonceAccount.fromBorshBase64(info.binaryData)
        : NonceAccount.fromJson(info.jsonData);
  }

  /// Creates an instance of `this` class from an account [info].
  ///
  /// Returns `null` if [info] is omitted.
  ///
  /// ```
  /// NonceAccount.tryFromAccountInfo('AA==');
  /// ```
  static NonceAccount? tryFromAccountInfo(final AccountInfo? info) =>
      info != null ? NonceAccount.fromAccountInfo(info) : null;

  @override
  Map<String, dynamic> toJson() => _$NonceAccountToJson(this);

  /// Creates a [NonceInformation] instance from the nonce account data.
  NonceInformation toNonceInformation(final Pubkey nonceAccount) =>
      NonceInformation(
        nonce: nonce,
        nonceInstruction: SystemProgram.nonceAdvance(
          noncePubkey: nonceAccount,
          authorizedPubkey: authorizedPubkey,
        ),
      );
}
