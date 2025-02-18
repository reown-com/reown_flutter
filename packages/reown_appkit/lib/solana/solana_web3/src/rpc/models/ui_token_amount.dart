/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/models.dart';

/// UI Token Amount
/// ------------------------------------------------------------------------------------------------

class UITokenAmount extends Serializable {
  /// Token amount.
  const UITokenAmount({
    required this.amount,
    required this.decimals,
    required this.uiAmountString,
  });

  /// The raw amount of tokens as a string, ignoring decimals.
  final String amount;

  /// The number of decimals configured for token's mint.
  final num decimals;

  /// The token amount as a string (including decimals).
  final String uiAmountString;

  /// {@macro solana_common.Serializable.fromJson}
  factory UITokenAmount.fromJson(final Map<String, dynamic> json) =>
      UITokenAmount(
        amount: json['amount'],
        decimals: json['decimals'],
        uiAmountString: json['uiAmountString'],
      );

  @override
  Map<String, dynamic> toJson() => {
        'amount': amount,
        'decimals': decimals,
        'uiAmountString': uiAmountString,
      };
}
