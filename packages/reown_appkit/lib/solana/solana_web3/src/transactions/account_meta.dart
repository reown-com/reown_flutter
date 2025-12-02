/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:json_annotation/json_annotation.dart' show JsonSerializable;
import 'package:reown_appkit/solana/solana_common/models.dart';
import '../crypto/pubkey.dart';

part 'account_meta.g.dart';

/// Account Meta
/// ------------------------------------------------------------------------------------------------

@JsonSerializable(explicitToJson: true)
class AccountMeta extends Serializable {
  /// Account metadata used to define instruction accounts.
  const AccountMeta(
    this.pubkey, {
    this.isSigner = false,
    this.isWritable = false,
  });

  /// An account's public key.
  final Pubkey pubkey;

  /// True if an instruction requires a transaction signature matching `pubkey`.
  final bool isSigner;

  /// True if the `pubkey` can be loaded as a read-write account.
  final bool isWritable;

  /// Creates a signer account.
  factory AccountMeta.signer(
    final Pubkey pubkey, {
    final bool isWritable = false,
  }) => AccountMeta(pubkey, isSigner: true, isWritable: isWritable);

  /// Creates a writable account.
  factory AccountMeta.writable(
    final Pubkey pubkey, {
    final bool isSigner = false,
  }) => AccountMeta(pubkey, isSigner: isSigner, isWritable: true);

  /// Creates a signer and writable account.
  factory AccountMeta.signerAndWritable(final Pubkey pubkey) =>
      AccountMeta(pubkey, isSigner: true, isWritable: true);

  /// {@macro solana_common.Serializable.fromJson}
  factory AccountMeta.fromJson(final Map<String, dynamic> json) =>
      _$AccountMetaFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AccountMetaToJson(this);

  /// Creates a copy of this class applying the provided parameters to the new instance.
  AccountMeta copyWith({
    final Pubkey? pubkey,
    final bool? isSigner,
    final bool? isWritable,
  }) {
    return AccountMeta(
      pubkey ?? this.pubkey,
      isSigner: isSigner ?? this.isSigner,
      isWritable: isWritable ?? this.isWritable,
    );
  }
}
