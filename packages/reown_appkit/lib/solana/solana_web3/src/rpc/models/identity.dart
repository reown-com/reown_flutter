/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/models.dart';
import '../../crypto/pubkey.dart';

/// Identity
/// ------------------------------------------------------------------------------------------------

class Identity extends Serializable {
  /// The identity public key for a node.
  const Identity({required this.identity});

  /// The identity public key of a node.
  final Pubkey identity;

  /// {@macro solana_common.Serializable.fromJson}
  factory Identity.fromJson(final Map<String, dynamic> json) =>
      Identity(identity: Pubkey.fromBase58(json['identity']));

  /// {@macro solana_common.Serializable.tryFromJson}
  static Identity? tryFromJson(final Map<String, dynamic>? json) =>
      json != null ? Identity.fromJson(json) : null;

  @override
  Map<String, dynamic> toJson() => {'identity': identity.toBase58()};
}
