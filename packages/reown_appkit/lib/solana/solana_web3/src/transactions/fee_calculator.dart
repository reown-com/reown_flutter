/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'dart:convert' show base64;
import 'package:json_annotation/json_annotation.dart' show JsonSerializable;
import 'package:reown_appkit/solana/solana_borsh/borsh.dart';
import 'package:reown_appkit/solana/solana_borsh/codecs.dart';
import 'package:reown_appkit/solana/solana_borsh/models.dart';
import 'package:reown_appkit/solana/solana_borsh/types.dart';

part 'fee_calculator.g.dart';

/// Fee Calculator
/// ------------------------------------------------------------------------------------------------

@JsonSerializable()
@Deprecated('Deprecated since Solana v1.8.0')
class FeeCalculator extends BorshObject {
  // Transaction fee calculator.
  const FeeCalculator(this.lamportsPerSignature);

  /// The cost in `lamports` to validate a `signature`.
  final BigInt lamportsPerSignature;

  /// {@macro solana_borsh.BorshObject.borshCodec}
  static BorshStructSizedCodec get codec {
    return borsh.structSized({
      'lamportsPerSignature': borsh.u64.string(),
    });
  }

  /// {@macro solana_common.Serializable.fromJson}
  factory FeeCalculator.fromJson(final Map<String, dynamic> json) =>
      _$FeeCalculatorFromJson(json);

  /// {@macro solana_borsh.BorshObject.fromBorsh}
  static FeeCalculator fromBorsh(final Iterable<int> buffer) =>
      borsh.deserialize(codec.schema, buffer, FeeCalculator.fromJson);

  /// {@macro solana_borsh.BorshObject.tryFromBorsh}
  static FeeCalculator? tryFromBorsh(final Iterable<int>? buffer) =>
      buffer != null ? FeeCalculator.fromBorsh(buffer) : null;

  /// {@macro solana_borsh.BorshObject.fromBorshBase64}
  static FeeCalculator fromBorshBase64(final String encoded) =>
      FeeCalculator.fromBorsh(base64.decode(encoded));

  /// {@macro solana_borsh.BorshObject.tryFromBorshBase64}
  static FeeCalculator? tryFromBorshBase64(final String? encoded) =>
      encoded != null ? FeeCalculator.fromBorshBase64(encoded) : null;

  @override
  BorshSchema get borshSchema => codec.schema;

  @override
  Map<String, dynamic> toJson() => _$FeeCalculatorToJson(this);
}
