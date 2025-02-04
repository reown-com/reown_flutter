/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/models.dart';
import 'package:reown_appkit/solana/solana_common/types.dart' show u64;

/// Supply
/// ------------------------------------------------------------------------------------------------

class Supply extends Serializable {
  /// Information about the current supply.
  const Supply({
    required this.total,
    required this.circulating,
    required this.nonCirculating,
    required this.nonCirculatingAccounts,
  });

  /// The total supply in lamports.
  final u64 total;

  /// The circulating supply in lamports.
  final u64 circulating;

  /// The non-circulating supply in lamports.
  final u64 nonCirculating;

  /// An array of account addresses of non-circulating accounts, as strings. If
  /// [GetSupplyConfig.excludeNonCirculatingAccountsList] is enabled, the returned array will be
  /// empty.
  final List<String> nonCirculatingAccounts;

  /// {@macro solana_common.Serializable.fromJson}
  factory Supply.fromJson(final Map<String, dynamic> json) => Supply(
        total: json['total'],
        circulating: json['circulating'],
        nonCirculating: json['nonCirculating'],
        nonCirculatingAccounts: List.from(json['nonCirculatingAccounts']),
      );

  /// {@macro solana_common.Serializable.tryFromJson}
  static Supply? tryFromJson(final Map<String, dynamic>? json) =>
      json != null ? Supply.fromJson(json) : null;

  @override
  Map<String, dynamic> toJson() => {
        'total': total,
        'circulating': circulating,
        'nonCirculating': nonCirculating,
        'nonCirculatingAccounts': nonCirculatingAccounts,
      };
}
