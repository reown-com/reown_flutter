class BorshException implements Exception {
  /// A Borsh library exception
  const BorshException(this.message, {this.code});

  /// A short description of the error.
  final String message;

  /// The error type.
  final int? code;
}
