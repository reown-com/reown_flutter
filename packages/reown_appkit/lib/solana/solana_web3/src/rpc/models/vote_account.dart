/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/models.dart';
import 'package:reown_appkit/solana/solana_common/types.dart' show u64;
import '../../crypto/pubkey.dart';

/// Vote Account
/// ------------------------------------------------------------------------------------------------

class VoteAccount extends Serializable {
  /// Account info and associated stake of a voting account.
  const VoteAccount({
    required this.votePubkey,
    required this.nodePubkey,
    required this.activatedStake,
    required this.epochVoteAccount,
    required this.commission,
    required this.lastVote,
    required this.epochCredits,
  });

  /// The vote account address.
  final Pubkey votePubkey;

  /// The validator identity.
  final Pubkey nodePubkey;

  /// The stake, in lamports, delegated to this vote account and active in this epoch.
  final u64 activatedStake;

  /// Whether the vote account is staked for this epoch.
  final bool epochVoteAccount;

  /// The percentage (0-100) of rewards payout owed to the vote account.
  final int commission;

  /// The most recent slot voted on by this vote account.
  final u64 lastVote;

  /// The history of how many credits earned by the end of each epoch, as an array of arrays
  /// containing: (epoch, credits, previousCredits).
  ///
  /// ```
  /// "epochCredits": [
  ///   [1, 64, 0],
  ///   [2, 192, 64]
  /// ]
  /// ```
  final List<List<int>> epochCredits;

  /// {@macro solana_common.Serializable.fromJson}
  factory VoteAccount.fromJson(final Map<String, dynamic> json) => VoteAccount(
        votePubkey: Pubkey.fromBase58(json['votePubkey']),
        nodePubkey: Pubkey.fromBase58(json['nodePubkey']),
        activatedStake: json['activatedStake'],
        epochVoteAccount: json['epochVoteAccount'],
        commission: json['commission'],
        lastVote: json['lastVote'],
        epochCredits: List<List>.from(json['epochCredits'])
            .map(List<int>.from)
            .toList(growable: false),
      );

  /// {@macro solana_common.Serializable.tryFromJson}
  static VoteAccount? tryFromJson(final Map<String, dynamic>? json) =>
      json != null ? VoteAccount.fromJson(json) : null;

  @override
  Map<String, dynamic> toJson() => {
        'votePubkey': votePubkey.toBase58(),
        'nodePubkey': nodePubkey.toBase58(),
        'activatedStake': activatedStake,
        'epochVoteAccount': epochVoteAccount,
        'commission': commission,
        'lastVote': lastVote,
        'epochCredits': epochCredits,
      };
}
