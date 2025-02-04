/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/extensions.dart';
import 'package:reown_appkit/solana/solana_common/models.dart';
import 'package:reown_appkit/solana/solana_common/types.dart';
import '../models/inner_instruction.dart';
import '../models/loaded_address.dart';
import '../models/token_balance.dart';

/// Meta
/// ------------------------------------------------------------------------------------------------

class Meta extends Serializable {
  /// Transaction status metadata.
  const Meta({
    this.err,
    required this.fee,
    required this.preBalances,
    required this.postBalances,
    this.innerInstructions,
    this.preTokenBalances,
    this.postTokenBalances,
    this.logMessages,
    this.loadedAddresses,
  });

  /// The error if the transaction failed or `null` if it succeeded.
  final Map<String, dynamic>? err;

  /// The fee this transaction was charged, as a u64 integer.
  final u64 fee;

  /// The account balances before the transaction was processed.
  final List<u64> preBalances;

  /// The account balances after the transaction was processed.
  final List<u64> postBalances;

  /// The cross-program invocation instruction or `null` if inner instruction recording was not
  /// enabled.
  final List<InnerInstruction>? innerInstructions;

  /// The token balance before the transaction was processed or `null` if token balance recording
  /// was not enabled during the transaction.
  final List<TokenBalance>? preTokenBalances;

  /// The token balance after the transaction processed or `null` if token balance recording was
  /// not enabled during the transaction.
  final List<TokenBalance>? postTokenBalances;

  /// The log messages or `null` if log message recording was not enabled during the transaction.
  final List<String>? logMessages;

  /// The transaction addresses loaded from the address lookup tables or `null` if
  /// [GetBlockConfig.maxSupportedTransactionVersion] was not set in the request params.
  final LoadedAddress? loadedAddresses;

  /// {@macro solana_common.Serializable.fromJson}
  factory Meta.fromJson(final Map<String, dynamic> json) => Meta(
        err: json['err'],
        fee: json['fee'],
        preBalances: json['preBalances'].cast<u64>(),
        postBalances: json['postBalances'].cast<u64>(),
        innerInstructions: IterableSerializable.tryFromJson(
            json['innerInstructions'], InnerInstruction.fromJson),
        preTokenBalances: IterableSerializable.tryFromJson(
            json['preTokenBalances'], TokenBalance.fromJson),
        postTokenBalances: IterableSerializable.tryFromJson(
            json['postTokenBalances'], TokenBalance.fromJson),
        logMessages: json['logMessages']?.cast<String>(),
        loadedAddresses: LoadedAddress.tryFromJson(json['loadedAddresses']),
      );

  /// Creates an instance of `this` class from the constructor parameters defined in the [json]
  /// object.
  ///
  /// Returns `null` if [json] is omitted.
  ///
  /// ```
  /// Meta.tryFromJson({ '<parameter>': <value> }, (U) => T);
  /// ```
  static Meta? tryFromJson(final Map<String, dynamic>? json) =>
      json != null ? Meta.fromJson(json) : null;

  @override
  Map<String, dynamic> toJson() => {
        'err': err,
        'fee': fee,
        'preBalances': preBalances,
        'postBalances': postBalances,
        'innerInstructions': innerInstructions?.toJson(),
        'preTokenBalances': preTokenBalances?.toJson(),
        'postTokenBalances': postTokenBalances?.toJson(),
        'logMessages': logMessages,
        'loadedAddresses': loadedAddresses?.toJson(),
      };
}
