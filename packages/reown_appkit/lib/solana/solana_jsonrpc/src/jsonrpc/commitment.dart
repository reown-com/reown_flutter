/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:json_annotation/json_annotation.dart' show JsonEnum;

/// Commitments
/// ------------------------------------------------------------------------------------------------

/// The commitment describes how finalised a block is at that point in time. When querying the
/// ledger state, it's recommended to use lower levels of commitment to report progress and higher
/// levels to ensure the state will not be rolled back.
///
/// For processing many dependent transactions in series, it's recommended to use `confirmed`
/// commitment, which balances speed with rollback safety. For total safety, it's recommended to
/// use `finalized` commitment.
///
/// The default commitment is `finalized`.
///
/// Only methods that query bank state accept the commitment parameter.
///
/// The commitment parameter should be included within the last element in the params array:
///
/// ```
/// curl localhost:8899 -X POST -H "Content-Type: application/json" -d '
///   {
///     "jsonrpc": "2.0",
///     "id": 1,
///     "method": "getBalance",
///     "params": [
///       "83astBRguLMdt2h5U1Tpdq5tjFoJ6noeGwaY3mDLVcri",
///       {
///         "commitment": "finalized"
///       }
///     ]
///   }
///   '
/// ```
@JsonEnum()
enum Commitment {
  /*************************************************************************************************
   * KEEP VARIANTS ORDERED BY BLOCK FINALITY (LEAST TO MOST)
  *************************************************************************************************/

  /// The node will query its most recent block. Note that the block may still be skipped by the
  /// cluster.
  processed,

  /// The node will query the most recent block that has been voted on by supermajority of the
  /// cluster. It incorporates votes from gossip and replay.
  ///
  /// - It incorporates votes from gossip and replay.
  /// - It does not count votes on descendants of a block, only direct votes on that block.
  /// - It also upholds "optimistic confirmation" guarantees in release 1.3 and onwards.
  confirmed,

  /// The node will query the most recent block confirmed by supermajority of the cluster as having
  /// reached maximum lockout, meaning the cluster has recognised this block as finalised.
  finalized,
  ;

  /// Compares `this` to `other`.
  ///
  /// Returns a negative number if this is less than other, zero if they are equal, and a positive
  /// number if this is greater than other.
  ///
  /// Examples:
  /// ```
  /// print(Commitment.finalized.compareTo(Commitment.processed));  // => 2
  /// print(Commitment.finalized.compareTo(Commitment.confirmed));  // => 1
  /// print(Commitment.finalized.compareTo(Commitment.finalized));  // => 0
  /// print(Commitment.processed.compareTo(Commitment.processed));  // => 0
  /// print(Commitment.processed.compareTo(Commitment.confirmed));  // => -1
  /// print(Commitment.processed.compareTo(Commitment.finalized));  // => -2
  /// ```
  int compareTo(final Commitment? other) => index - (other?.index ?? -1);

  /// Creates an instance of this enum from the provided [json] data.
  ///
  /// Throws an [ArgumentError] if [json] cannot be matched to an existing variant.
  ///
  /// ```
  /// Commitment.fromJson('processed');
  /// ```
  factory Commitment.fromJson(final String json) => values.byName(json);

  /// Creates an instance of this enum from the provided [json] data.
  ///
  /// Returns `null` if [json] is omitted.
  ///
  /// Throws an [ArgumentError] if [json] cannot be matched to an existing variant.
  ///
  /// ```
  /// Commitment.tryFromJson('processed');
  /// ```
  static Commitment? tryFromJson(final String? json) =>
      json != null ? Commitment.fromJson(json) : null;

  /// {@macro solana_common.Serializable.toJson}
  String toJson() => name;
}
