/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/types.dart' show i64, u64;
import 'transaction_data.dart';

/// Transaction Info
/// ------------------------------------------------------------------------------------------------

class TransactionInfo<T extends Object> extends TransactionData<T> {
  /// Confirmed Transaction Block.
  const TransactionInfo({
    required super.transaction,
    required super.meta,
    required super.version,
    required this.slot,
    required this.blockTime,
  });

  /// The slot this transaction was processed in.
  final u64 slot;

  /// The estimated production time, as Unix timestamp (seconds since the Unix epoch) of when the
  /// transaction was processed - null if not available.
  final i64? blockTime;

  /// Creates an instance of `this` class from the constructor parameters defined in the [json]
  /// object.
  ///
  /// ```
  /// TransactionInfo.parse({ '<parameter>': <value> });
  /// ```
  static TransactionInfo parse(final Map<String, dynamic> json) {
    final TransactionData data = TransactionData.parse(json);
    return TransactionInfo(
      transaction: data.transaction,
      meta: data.meta,
      version: data.version,
      slot: json['slot'],
      blockTime: json['blockTime'],
    );
  }

  /// Creates an instance of `this` class from the constructor parameters defined in the [json]
  /// object.
  ///
  /// Return `null` if [json] is omitted.
  ///
  /// ```
  /// TransactionInfo.tryParse({ '<parameter>': <value> });
  /// ```
  static TransactionInfo? tryParse(final Map<String, dynamic>? json) =>
      json != null ? parse(json) : null;

  /// {@macro solana_common.Serializable.fromJson}
  static TransactionInfo fromJson(final Map<String, dynamic> json) {
    final TransactionData data = TransactionData.fromJson(json);
    return TransactionInfo(
      transaction: data.transaction,
      meta: data.meta,
      version: data.version,
      slot: json['slot'],
      blockTime: json['blockTime'],
    );
  }

  @override
  Map<String, dynamic> toJson() => super.toJson()
    ..addAll({
      'slot': slot,
      'blockTime': blockTime,
    });
}
