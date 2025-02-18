/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/models.dart';

/// Data Slice
/// ------------------------------------------------------------------------------------------------

class DataSlice extends Serializable {
  /// Defines a range to query a subset of account data.
  const DataSlice({
    required this.offset,
    required this.length,
  }) : assert(offset >= 0 && length >= 0);

  /// The start position.
  final int offset;

  /// The data length.
  final int length;

  /// Creates an instance of `this` class with an [offset] and [length] value of `0`.
  factory DataSlice.zero() => const DataSlice(
        offset: 0,
        length: 0,
      );

  /// {@macro solana_common.Serializable.fromJson}
  factory DataSlice.fromJson(final Map<String, dynamic> json) => DataSlice(
        offset: json['offset'],
        length: json['length'],
      );

  /// {@macro solana_common.Serializable.tryFromJson}
  static DataSlice? tryFromJson(final Map<String, dynamic>? json) =>
      json == null ? null : DataSlice.fromJson(json);

  @override
  Map<String, dynamic> toJson() => {
        'offset': offset,
        'length': length,
      };
}
