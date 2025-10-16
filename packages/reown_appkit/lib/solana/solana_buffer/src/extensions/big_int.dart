/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'dart:typed_data' show Endian, Uint8List;
import '../../buffer.dart';

/// Big Int Extension
/// ------------------------------------------------------------------------------------------------

extension BufferSerializable on BigInt {
  /// The minimum number of bytes required to store this big integer.
  int get byteLength => (bitLength + 7) >> 3;

  /// Returns the value as a signed big integer.
  BigInt asSigned() => toSigned(byteLength * 8);

  /// Converts this [BigInt] into an 8-byte [Uint8List].
  Uint8List toUint64Buffer() => toUint8List(8);

  /// Converts this [BigInt] into a [Uint8List] of size [length].
  ///
  /// If [length] is omitted, the minimum number of bytes required to store this big integer value
  /// is used.
  Uint8List toUint8List([final int? length]) {
    final int byteLength = length ?? this.byteLength;
    assert(
      length == null || length >= byteLength,
      'The value $this overflows $byteLength byte(s)',
    );
    return (Buffer(byteLength)..setBigInt(this, 0, byteLength)).asUint8List();
  }

  /// Creates a [BigInt] from an array of [bytes].
  ///
  /// ```
  /// final BigInt value = BigIntExtension.fromUint8List([255, 255, 255, 255, 255, 255, 255, 255]);
  /// print(value); // 18446744073709551615
  /// ```
  static BigInt fromUint8List(
    final Iterable<int> bytes, [
    final Endian endian = Endian.little,
  ]) {
    return Buffer.fromList(bytes).getBigUint(0, bytes.length, endian);
  }

  /// Creates a [BigInt] from an existing [BigInt] or [int] value.
  ///
  /// ```
  /// final BigInt value0 = BigIntExtension.normalize(BigInt.zero);
  /// print(value0); // 0
  ///
  /// final BigInt value1 = BigIntExtension.normalize(1);
  /// print(value1); // 1
  ///
  /// final BigInt value2 = BigIntExtension.normalize(2.9);
  /// print(value2); // 2
  /// ```
  static BigInt from(final Object value) {
    assert(value is BigInt || value is String || value is num);
    if (value is BigInt) return value;
    return value is String ? BigInt.parse(value) : BigInt.from(value as num);
  }
}
