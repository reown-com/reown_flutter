/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/models.dart';
import 'package:reown_appkit/solana/solana_common/types.dart' show u8;

/// Token Amount
/// ------------------------------------------------------------------------------------------------

class TokenAmount extends Serializable {
  /// The token balance of an SPL Token account.
  const TokenAmount({
    required this.amount,
    required this.decimals,
    required this.uiAmountString,
  });

  /// The raw balance without decimals, a u64.
  final BigInt amount;

  /// The number of base 10 digits to the right of the decimal place.
  final u8 decimals;

  /// The balance as a string, using mint-prescribed decimals.
  final String uiAmountString;

  /// {@macro solana_common.Serializable.fromJson}
  factory TokenAmount.fromJson(final Map<String, dynamic> json) => TokenAmount(
        amount: BigInt.parse(json['amount']),
        decimals: json['decimals'],
        uiAmountString: json['uiAmountString'],
      );

  /// {@macro solana_common.Serializable.tryFromJson}
  static TokenAmount? tryFromJson(final Map<String, dynamic>? json) {
    return json != null ? TokenAmount.fromJson(json) : null;
  }

  @override
  Map<String, dynamic> toJson() => {
        'amount': amount.toString(),
        'decimals': decimals,
        'uiAmountString': uiAmountString,
      };
}
