/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:json_annotation/json_annotation.dart' show JsonSerializable;
import 'package:reown_appkit/solana/solana_common/exceptions.dart';

part 'exception.g.dart';

/// JSON RPC Exception Codes
/// ------------------------------------------------------------------------------------------------

class JsonRpcExceptionCode {
  // Server error codes
  static int get serverErrorBlockCleanedUp => -32001;
  static int get serverErrorSendTransactionPreflightFailure => -32002;
  static int get serverErrorTransactionSignatureVerifcationFailure => -32003;
  static int get serverErrorBlockNotAvailable => -32004;
  static int get serverErrorNodeUnhealthy => -32005;
  static int get serverErrorTransactionPrecompileVerificationFailure => -32006;
  static int get serverErrorSlotSkipped => -32007;
  static int get serverErrorNoSnapshot => -32008;
  static int get serverErrorLongTermStorageSlotSkipped => -32009;
  static int get serverErrorKeyExcludedFromSecondaryIndex => -32010;
  static int get serverErrorTransactionHistoryNotAvailable => -32011;
  static int get scanError => -32012;
  static int get serverErrorTransactionSignatureLenMismatch => -32013;
  static int get serverErrorBlockStatusNotAvailableYet => -32014;
  static int get serverErrorUnsupportedTransactionVersion => -32015;
  static int get serverErrorMinContextSlotNotReached => -32016;
  // Method error codes
  static int get methodNotFound => -32601;
  static int get invalidParams => -32602;
}

/// JSON RPC Exception
/// ------------------------------------------------------------------------------------------------

/// A JSON RPC exception.
@JsonSerializable()
class JsonRpcException extends SolanaException {
  /// Creates an exception for a failed JSON RPC request.
  const JsonRpcException(
    super.message, {
    super.code,
    this.data,
  });

  /// Additional information about the error, defined by the server.
  final dynamic data;

  // /// Creates an `unknown` exception for a failed JSON RPC request.
  // factory JsonRpcException.unknown()
  //   => const JsonRpcException('JSON RPC Unknown Exception.');

  // /// Returns true if [error] is a [JsonRpcException] for the provided error [code].
  // static bool isType(final Object? error, final JsonRpcExceptionCode? code)
  //   => error is JsonRpcException && (code == null || error.code == code.value);

  // /// Creates a [JsonRpcException] from [error].
  // static JsonRpcException? tryParse(final dynamic error) {
  //   return error is Map && error.containsKey('message')
  //     ? JsonRpcException.fromJson(Map.from(error))
  //     : null;
  // }

  /// {@macro solana_common.Serializable.fromJson}
  factory JsonRpcException.fromJson(final Map<String, dynamic> json) =>
      _$JsonRpcExceptionFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$JsonRpcExceptionToJson(this);
}
