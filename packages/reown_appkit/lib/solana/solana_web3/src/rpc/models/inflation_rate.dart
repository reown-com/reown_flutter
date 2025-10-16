/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/models.dart';
import 'package:reown_appkit/solana/solana_common/types.dart' show f64, u64;

/// Inflation Rate
/// ------------------------------------------------------------------------------------------------

class InflationRate extends Serializable {
  /// Inflation Rate.
  const InflationRate({
    required this.total,
    required this.validator,
    required this.foundation,
    required this.epoch,
  });

  /// The total inflation.
  final f64 total;

  /// The inflation allocated to validators.
  final f64 validator;

  /// The inflation allocated to the foundation.
  final f64 foundation;

  /// The epoch for which these values are valid.
  final u64 epoch;

  /// {@macro solana_common.Serializable.fromJson}
  factory InflationRate.fromJson(final Map<String, dynamic> json) =>
      InflationRate(
        total: json['total'],
        validator: json['validator'],
        foundation: json['foundation'],
        epoch: json['epoch'],
      );

  /// {@macro solana_common.Serializable.tryFromJson}
  static InflationRate? tryFromJson(final Map<String, dynamic>? json) =>
      json != null ? InflationRate.fromJson(json) : null;

  @override
  Map<String, dynamic> toJson() => {
    'total': total,
    'validator': validator,
    'foundation': foundation,
    'epoch': epoch,
  };
}
