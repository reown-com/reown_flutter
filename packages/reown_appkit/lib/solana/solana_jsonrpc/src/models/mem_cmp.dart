/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:json_annotation/json_annotation.dart' show JsonSerializable;
import 'package:reown_appkit/solana/solana_common/types.dart' show usize;
import 'package:reown_appkit/solana/solana_jsonrpc/src/models/filter.dart';

part 'mem_cmp.g.dart';

/// Memory Comparison
/// ------------------------------------------------------------------------------------------------

/// Compares the provided series of [bytes] with the program account data at a particular [offset].
@JsonSerializable()
class MemCmp extends Filter {
  /// Creates a filter that compares the provided series of [bytes] with the program account data at
  /// a particular [offset].
  const MemCmp({required this.offset, required this.bytes});

  /// The offset into program account data to start comparison.
  final usize offset;

  /// The data to match as a base-58 encoded string and limited to less than `129 bytes`.
  final String bytes;

  /// The json object key.
  static String get memcmpKey => 'memcmp';

  /// {@macro solana_common.Serializable.fromJson}
  factory MemCmp.fromJson(final Map<String, dynamic> json) =>
      _$MemCmpFromJson(json[memcmpKey] ?? json);

  /// {@macro solana_common.Serializable.tryFromJson}
  static MemCmp? tryFromJson(final Map<String, dynamic>? json) =>
      json == null ? null : _$MemCmpFromJson(json);

  @override
  Map<String, dynamic> toJson() => {memcmpKey: _$MemCmpToJson(this)};
}
