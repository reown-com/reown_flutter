/// Custom exception for TON validation errors
class TonValidationError implements Exception {
  final String message;
  TonValidationError(this.message);

  @override
  String toString() => 'TonValidationError: $message';
}

/// Threshold for detecting milliseconds vs seconds timestamps.
/// 10 billion seconds = ~Sep 2286, so any timestamp above this is likely milliseconds.
const _kMillisecondsThreshold = 10000000000;

/// Normalizes valid_until to seconds if it appears to be in milliseconds.
/// TON uses 32-bit timestamps (seconds), but some dApps send milliseconds.
int normalizeValidUntil(int validUntil) {
  if (validUntil > _kMillisecondsThreshold) {
    return validUntil ~/ 1000;
  }
  return validUntil;
}
