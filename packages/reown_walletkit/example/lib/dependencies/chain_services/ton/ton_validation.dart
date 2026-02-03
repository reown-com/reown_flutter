/// Custom exception for TON validation errors
class TonValidationError implements Exception {
  final String message;
  TonValidationError(this.message);

  @override
  String toString() => 'TonValidationError: $message';
}

/// Normalizes valid_until to seconds if it appears to be in milliseconds.
/// TON uses 32-bit timestamps (seconds), but some dApps send milliseconds.
int normalizeValidUntil(int validUntil) {
  // If value > 10 billion, it's likely milliseconds (year 2286+ in seconds)
  if (validUntil > 10000000000) {
    return validUntil ~/ 1000;
  }
  return validUntil;
}
