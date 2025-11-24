import '../models/serializable.dart';

/// Solana Exception
/// ------------------------------------------------------------------------------------------------

/// An exception thrown by a Solana library.
class SolanaException extends Serializable implements Exception {
  /// Creates a `Solana` library exception with a short descriptive [message] of the error and an
  /// optional error [code].
  const SolanaException(this.message, {this.code});

  /// A short description of the error.
  final String message;

  /// The error type.
  final int? code;

  /// {@macro solana_common.Serializable.fromJson}
  factory SolanaException.fromJson(final Map<String, dynamic> json) =>
      SolanaException(json['message'], code: json['code']);

  @override
  Map<String, dynamic> toJson() => {'message': message, 'code': code};

  @override
  String toString() =>
      '[$runtimeType] ${code != null ? '$code : ' : ''}$message';
}
