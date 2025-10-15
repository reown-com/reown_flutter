/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:json_annotation/json_annotation.dart' show JsonSerializable;
import 'package:reown_appkit/solana/solana_common/exceptions.dart';

part 'program_exception.g.dart';

/// Program Exception
/// ------------------------------------------------------------------------------------------------

@JsonSerializable(createToJson: false)
class ProgramException extends SolanaException {
  /// Creates an exception for a program error.
  const ProgramException(super.message, {super.code});

  /// {@macro solana_common.Serializable.fromJson}
  factory ProgramException.fromJson(final Map<String, dynamic> json) =>
      _$ProgramExceptionFromJson(json);
}
