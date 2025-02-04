/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/extensions.dart';
import 'package:reown_appkit/solana/solana_common/models.dart';
import 'package:reown_appkit/solana/solana_common/types.dart' show i64, u64;
import '../configs/index.dart';
import 'reward.dart';
import 'transaction_data.dart';
import 'transaction_detail.dart';

/// Block
/// ------------------------------------------------------------------------------------------------

class Block extends Serializable {
  /// A confirmed transaction block.
  const Block({
    required this.blockhash,
    required this.previousBlockhash,
    required this.parentSlot,
    required this.transactions,
    required this.signatures,
    required this.rewards,
    required this.blockTime,
    required this.blockHeight,
  });

  /// The block's blockhash as a base-58 encoded string.
  final String blockhash;

  /// The parent block's blockhash as a base-58 encoded string or '11111111111111111111111111111111'
  /// if the parent block is not available due to ledger cleanup.
  final String previousBlockhash;

  /// The parent block's slot index.
  final u64 parentSlot;

  /// Transaction details (provided if [TransactionDetail.full] is requested).
  final List<TransactionData>? transactions;

  /// Transaction signatures (provided if [TransactionDetail.signatures] is requested).
  final List<String>? signatures;

  /// Rewards (provided if [GetBlockConfig.rewards] is `true`).
  final List<Reward> rewards;

  /// Estimated block production unix epoch time in seconds or `null` if not available.
  final i64? blockTime;

  /// The number of blocks beneath this block.
  final u64? blockHeight;

  /// Indicates if the parent block ([previousBlockhash]) is available.
  bool get isParentBlockAvailable =>
      previousBlockhash == '11111111111111111111111111111111';

  /// {@macro solana_common.Serializable.fromJson}
  factory Block.fromJson(final Map<String, dynamic> json) => Block(
        blockhash: json['blockhash'],
        previousBlockhash: json['previousBlockhash'],
        parentSlot: json['parentSlot'],
        transactions: IterableSerializable.tryFromJson(
            json['transactions'], TransactionData.parse),
        signatures: json['signatures']?.cast<String>(),
        rewards:
            IterableSerializable.fromJson(json['rewards'], Reward.fromJson),
        blockTime: json['blockTime'],
        blockHeight: json['blockHeight'],
      );

  /// {@macro solana_common.Serializable.tryFromJson}
  static Block? tryFromJson(final Map<String, dynamic>? json) {
    return json != null ? Block.fromJson(json) : null;
  }

  @override
  Map<String, dynamic> toJson() => {
        'blockhash': blockhash,
        'previousBlockhash': previousBlockhash,
        'parentSlot': parentSlot,
        'transactions': transactions?.toJson(),
        'signatures': signatures,
        'rewards': rewards.toJson(),
        'blockTime': blockTime,
        'blockHeight': blockHeight,
      };
}
