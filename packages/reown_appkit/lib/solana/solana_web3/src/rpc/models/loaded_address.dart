/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/models.dart';

/// Loaded Address
/// ------------------------------------------------------------------------------------------------

class LoadedAddress extends Serializable {
  /// Transaction addresses loaded from the address lookup tables.
  const LoadedAddress({required this.writable, required this.readonly});

  /// An ordered list of base-58 encoded addresses for writable loaded accounts.
  final List<String> writable;

  /// An ordered list of base-58 encoded addresses for readonly loaded accounts.
  final List<String> readonly;

  /// {@macro solana_common.Serializable.fromJson}
  factory LoadedAddress.fromJson(final Map<String, dynamic> json) =>
      LoadedAddress(
        writable: List.castFrom(json['writable']),
        readonly: List.castFrom(json['readonly']),
      );

  /// {@macro solana_common.Serializable.tryFromJson}
  static LoadedAddress? tryFromJson(final Map<String, dynamic>? json) {
    return json != null ? LoadedAddress.fromJson(json) : null;
  }

  @override
  Map<String, dynamic> toJson() => {'writable': writable, 'readonly': readonly};
}
