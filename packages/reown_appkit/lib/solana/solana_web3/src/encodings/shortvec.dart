/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_buffer/buffer.dart'
    show BufferReader;

/// Shortvec Encoding (Compact-u16 Format)
/// ------------------------------------------------------------------------------------------------

/// Returns the short-vec encoded length.
int decodeLength(final BufferReader reader) {
  int len = 0;
  int size = 0;
  for (final int byte in reader) {
    len |= (byte & 0x7f) << (size * 7);
    size += 1;
    if ((byte & 0x80) == 0) {
      break;
    }
  }
  reader.advance(size);
  return len;
}

/// Encodes [length] into a byte array.
List<int> encodeLength(final int length) {
  assert(length >= 0);
  final List<int> bytes = [];
  int remainingLength = length;
  for (;;) {
    int elem = remainingLength & 0x7f;
    remainingLength >>= 7;
    if (remainingLength == 0) {
      bytes.add(elem);
      break;
    } else {
      elem |= 0x80;
      bytes.add(elem);
    }
  }
  return bytes;
}
