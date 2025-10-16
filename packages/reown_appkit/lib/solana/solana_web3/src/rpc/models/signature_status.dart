/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/models.dart';
import 'package:reown_appkit/solana/solana_common/types.dart' show u64, usize;
import 'package:reown_appkit/solana/solana_jsonrpc/jsonrpc.dart';

/// Signature Status
/// ------------------------------------------------------------------------------------------------

class SignatureStatus extends Serializable {
  /// Signature Status.
  const SignatureStatus({
    required this.slot,
    required this.confirmations,
    required this.err,
    required this.confirmationStatus,
  });

  /// The slot the transaction was processed.
  final u64 slot;

  /// The number of blocks since signature confirmation, null if rooted, as well as finalized by a
  /// supermajority of the cluster.
  final usize? confirmations;

  /// An error if transaction failed, null if transaction succeeded.
  ///
  /// TODO: Change type to match https://github.com/solana-labs/solana/blob/c0c60386544ec9a9ec7119229f37386d9f070523/sdk/src/transaction/error.rs#L13
  final Map<String, dynamic>? err;

  /// The confirmationStatus associated with the transaction, null if no confirmationStatus is present.
  final Commitment? confirmationStatus;

  /// {@macro solana_common.Serializable.fromJson}
  factory SignatureStatus.fromJson(final Map<String, dynamic> json) =>
      SignatureStatus(
        slot: json['slot'],
        confirmations: json['confirmations'],
        err: json['err'],
        confirmationStatus: Commitment.tryFromJson(json['confirmationStatus']),
      );

  /// {@macro solana_common.Serializable.tryFromJson}
  static SignatureStatus? tryFromJson(final Map<String, dynamic>? json) =>
      json != null ? SignatureStatus.fromJson(json) : null;

  @override
  Map<String, dynamic> toJson() => {
    'slot': slot,
    'confirmations': confirmations,
    'err': err,
    'confirmationStatus': confirmationStatus?.name,
  };
}
