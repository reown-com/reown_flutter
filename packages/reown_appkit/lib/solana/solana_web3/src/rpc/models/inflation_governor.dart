/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/models.dart';
import 'package:reown_appkit/solana/solana_common/types.dart' show f64;

/// Inflation Governor
/// ------------------------------------------------------------------------------------------------

class InflationGovernor extends Serializable {
  /// Inflation governor.
  const InflationGovernor({
    required this.initial,
    required this.terminal,
    required this.taper,
    required this.foundation,
    required this.foundationTerm,
  });

  /// The initial inflation percentage from time 0.
  final f64 initial;

  /// The terminal inflation percentage.
  final f64 terminal;

  /// The rate per year at which inflation is lowered. Rate reduction is derived using the target
  /// slot time in the genesis config.
  final f64 taper;

  /// The percentage of total inflation allocated to the foundation.
  final f64 foundation;

  /// The duration of foundation pool inflation in years.
  final f64? foundationTerm;

  /// {@macro solana_common.Serializable.fromJson}
  factory InflationGovernor.fromJson(final Map<String, dynamic> json) =>
      InflationGovernor(
        initial: json['initial'],
        terminal: json['terminal'],
        taper: json['taper'],
        foundation: json['foundation'],
        foundationTerm: json['foundationTerm'],
      );

  /// {@macro solana_common.Serializable.tryFromJson}
  static InflationGovernor? tryFromJson(final Map<String, dynamic>? json) {
    return json != null ? InflationGovernor.fromJson(json) : null;
  }

  @override
  Map<String, dynamic> toJson() => {
    'initial': initial,
    'terminal': terminal,
    'taper': taper,
    'foundation': foundation,
    'foundationTerm': foundationTerm,
  };
}
