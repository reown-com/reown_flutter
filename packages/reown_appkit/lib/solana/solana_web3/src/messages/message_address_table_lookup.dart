/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:json_annotation/json_annotation.dart' show JsonSerializable;
import 'package:reown_appkit/solana/solana_common/models.dart';
import '../crypto/pubkey.dart';

part 'message_address_table_lookup.g.dart';

/// Message Address Table Lookup
/// ------------------------------------------------------------------------------------------------

@JsonSerializable(explicitToJson: true)
class MessageAddressTableLookup extends Serializable {
  /// Used by a transaction to dynamically load addresses from on-chain address lookup tables.
  const MessageAddressTableLookup({
    required this.accountKey,
    required this.writableIndexes,
    required this.readonlyIndexes,
  });

  /// A base-58 encoded public key for an address lookup table account.
  final Pubkey accountKey;

  /// A List of indices used to load addresses of writable accounts from a lookup table.
  final List<int> writableIndexes;

  /// A list of indices used to load addresses of readonly accounts from a lookup table.
  final List<int> readonlyIndexes;

  /// {@macro solana_common.Serializable.fromJson}
  factory MessageAddressTableLookup.fromJson(final Map<String, dynamic> json) =>
      _$MessageAddressTableLookupFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MessageAddressTableLookupToJson(this);
}
