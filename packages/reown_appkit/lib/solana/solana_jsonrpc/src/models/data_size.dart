/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:json_annotation/json_annotation.dart' show JsonSerializable;
import 'package:reown_appkit/solana/solana_common/types.dart' show u64;
import 'package:reown_appkit/solana/solana_jsonrpc/src/models/filter.dart';

part 'data_size.g.dart';

/// Data Size
/// ------------------------------------------------------------------------------------------------

/// Compares the program account data length with the provided data size.
@JsonSerializable()
class DataSize extends Filter {
  /// Creates a filter that compares the program account data length with the provided data size.
  const DataSize({required this.dataSize});

  /// Compares the program account data length with the provided data size.
  final u64 dataSize;

  /// {@macro solana_common.Serializable.fromJson}
  factory DataSize.fromJson(final Map<String, dynamic> json) =>
      _$DataSizeFromJson(json);

  /// {@macro solana_common.Serializable.tryFromJson}
  static DataSize? tryFromJson(final Map<String, dynamic>? json) =>
      json == null ? null : _$DataSizeFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DataSizeToJson(this);
}
