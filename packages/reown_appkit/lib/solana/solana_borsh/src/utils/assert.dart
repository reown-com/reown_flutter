/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_buffer/buffer.dart';

/// Assert
/// ------------------------------------------------------------------------------------------------

/// Asserts that [length] is equal to [expected].
void assertLength(final int length, final int expected) {
  assert(length == expected, 'Expected length $expected, found $length');
}

/// Asserts that [length] is less than or equal to [max].
void assertMaxLength(final int length, final int max) {
  assert(length <= max, 'The length $length is greater than $max');
}

/// Asserts that the encoded byte length of [value] is equal to [expected].
void assertEncodedLength(
    final String value, final BufferEncoding encoding, final int expected) {
  assertLength(Buffer.fromString(value, encoding).length, expected);
}

/// Asserts that the encoded byte length of [value] is less than or equal to [max].
void assertEncodedMaxLength(
    final String value, final BufferEncoding encoding, final int max) {
  assertMaxLength(Buffer.fromString(value, encoding).length, max);
}
