/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/models.dart';

/// Version
/// ------------------------------------------------------------------------------------------------

class Version extends Serializable {
  /// The solana version running on a node.
  const Version({
    required this.solanaCore,
    required this.featureSet,
  });

  /// The software version of solana-core.
  final String solanaCore;

  /// The unique identifier of the current software's feature set.
  final int? featureSet;

  /// {@macro solana_common.Serializable.fromJson}
  factory Version.fromJson(final Map<String, dynamic> json) => Version(
        solanaCore: json['solana-core'],
        featureSet: json['feature-set'],
      );

  /// {@macro solana_common.Serializable.tryFromJson}
  static Version? tryFromJson(final Map<String, dynamic>? json) {
    return json != null ? Version.fromJson(json) : null;
  }

  @override
  Map<String, dynamic> toJson() => {
        'solana-core': solanaCore,
        'feature-set': featureSet,
      };
}
