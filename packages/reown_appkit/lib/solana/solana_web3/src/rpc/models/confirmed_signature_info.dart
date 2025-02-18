/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/models.dart';
import 'package:reown_appkit/solana/solana_common/types.dart' show i64, u64;

/// Confirmed Signature Info
/// ------------------------------------------------------------------------------------------------

class ConfirmedSignatureInfo extends Serializable {
  /// Confirmed signature info.
  const ConfirmedSignatureInfo({
    required this.signature,
    required this.slot,
    required this.err,
    required this.memo,
    required this.blockTime,
  });

  /// The transaction signature as base-58 encoded string.
  final String signature;

  /// The slot that contains the block with the transaction.
  final u64 slot;

  /// An error if transaction failed, null if transaction succeeded.
  ///
  /// TODO: Change type to match https://github.com/solana-labs/solana/blob/c0c60386544ec9a9ec7119229f37386d9f070523/sdk/src/transaction/error.rs#L13
  final Map<String, dynamic>? err;

  /// The memo associated with the transaction, null if no memo is present.
  final String? memo;

  /// The estimated production time, as a Unix timestamp (seconds since the Unix epoch) of when the
  /// transaction was processed - null if not available.
  final i64 blockTime;

  /// {@macro solana_common.Serializable.fromJson}
  factory ConfirmedSignatureInfo.fromJson(final Map<String, dynamic> json) =>
      ConfirmedSignatureInfo(
        signature: json['signature'],
        slot: json['slot'],
        err: json['err'],
        memo: json['memo'],
        blockTime: json['blockTime'],
      );

  /// {@macro solana_common.Serializable.tryFromJson}
  static ConfirmedSignatureInfo? tryFromJson(
          final Map<String, dynamic>? json) =>
      json != null ? ConfirmedSignatureInfo.fromJson(json) : null;

  @override
  Map<String, dynamic> toJson() => {
        'signature': signature,
        'slot': slot,
        'err': err,
        'memo': memo,
        'blockTime': blockTime,
      };
}
