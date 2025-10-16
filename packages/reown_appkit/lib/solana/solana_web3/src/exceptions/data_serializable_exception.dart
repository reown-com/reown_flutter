/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:json_annotation/json_annotation.dart' show JsonSerializable;
import 'package:reown_appkit/solana/solana_common/exceptions.dart';
import '../rpc/mixins/data_serializable_mixin.dart';

part 'data_serializable_exception.g.dart';

/// Data Serializable Exception
/// ------------------------------------------------------------------------------------------------

@JsonSerializable(createToJson: false)
class DataSerializableException extends SolanaException {
  /// Creates an exception for invalid [DataSerializableMixin] objects.
  const DataSerializableException(super.message, {super.code});

  /// {@macro solana_common.Serializable.fromJson}
  factory DataSerializableException.fromJson(final Map<String, dynamic> json) =>
      _$DataSerializableExceptionFromJson(json);
}
