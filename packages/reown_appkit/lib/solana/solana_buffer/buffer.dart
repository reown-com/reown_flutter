/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'dart:convert' show base64, utf8;
import 'dart:math' show Random, min;
import 'dart:typed_data' show ByteData, Endian, Uint8List;
import 'package:convert/convert.dart';
import 'package:flutter/foundation.dart' show protected;
import 'package:reown_core/reown_core.dart';
import 'extensions.dart';

/// Buffer Encoding
/// ------------------------------------------------------------------------------------------------

enum BufferEncoding {
  base58,
  base64,
  hex,
  utf8,
  ;

  /// Returns the enum variant where [BufferEncoding.name] is equal to [name].
  ///
  /// Returns [BufferEncoding.utf8] if [name] does not match an existing variant.
  ///
  /// ```
  /// BufferEncoding.fromName('base58');
  /// ```
  factory BufferEncoding.fromJson(final String? name) {
    return values.firstWhere(
      (final BufferEncoding item) => item.name == name,
      orElse: () => BufferEncoding.utf8,
    );
  }
}

/// Byte Length
/// ------------------------------------------------------------------------------------------------

class ByteLength {
  // integers
  static const int i8 = 1;
  static const int u8 = i8;
  static const int i16 = 2;
  static const int u16 = i16;
  static const int i32 = 4;
  static const int u32 = i32;
  static const int i64 = 8;
  static const int u64 = i64;
  static const int i128 = 16;
  static const int u128 = i128;
  // floats
  static const int f32 = i32;
  static const int f64 = i64;
}

/// Buffer Reader
/// ------------------------------------------------------------------------------------------------

class BufferReader extends Iterable<int> {
  /// Creates a view over [buffer] that maintains its offset position while reading data from the
  /// buffer.
  ///
  /// ```
  /// final BufferReader reader = BufferReader.fromList([1, 2, 3, 4, 5, 6, 7, 8]);
  /// print(reader.get(2)); // [1, 2]
  /// print(reader.get(4)); // [3, 4, 5, 6]
  /// ```
  BufferReader(this.buffer);

  /// Creates a [BufferReader] from a list of [bytes].
  BufferReader.fromList(final Iterable<int> bytes)
      : buffer = Buffer.fromList(bytes);

  /// Creates a [BufferReader] from a [Uint8List]
  BufferReader.fromUint8List(final Uint8List bytes)
      : buffer = Buffer.fromUint8List(bytes);

  /// The buffer to traverse.
  @protected
  final Buffer buffer;

  /// The current offset.
  @protected
  int offset = 0;

  @override
  int get length => buffer.length;

  @override
  bool get isEmpty => offset >= buffer.length;

  /// Returns the byte at [index].
  int operator [](final int index) => buffer[index];

  /// Advance the current [offset] position by [steps].
  void advance(final int steps) => offset += steps;

  /// Creates a new [Buffer] from a region of [buffer] and advances the internal [offset] by
  /// [length].
  Buffer getBuffer([final int? length]) {
    final Buffer slice = buffer.slice(offset, length);
    offset += slice.length;
    return slice;
  }

  /// {@macro solana_common.Buffer.getString}
  String getString(final int length,
      [final BufferEncoding encoding = BufferEncoding.utf8]) {
    final String value = buffer.getString(encoding, offset, length);
    offset += length;
    return value;
  }

  /// {@macro solana_common.Buffer.getInt}
  int getInt(final int length) {
    final int value = buffer.getInt(offset, length);
    offset += length;
    return value;
  }

  /// {@macro solana_common.Buffer.getUint}
  int getUint(final int length) {
    final int value = buffer.getUint(offset, length);
    offset += length;
    return value;
  }

  /// {@macro solana_common.Buffer.getBigInt}
  BigInt getBigInt(final int length) {
    final BigInt value = buffer.getBigInt(offset, length);
    offset += length;
    return value;
  }

  /// {@macro solana_common.Buffer.getBigUint}
  BigInt getBigUint(final int length) {
    final BigInt value = buffer.getBigUint(offset, length);
    offset += length;
    return value;
  }

  /// {@macro solana_common.Buffer.getBool}
  bool getBool() {
    final bool value = buffer.getBool(offset);
    offset += ByteLength.u8;
    return value;
  }

  /// {@macro solana_common.Buffer.getInt8}
  int getInt8() => getInt(ByteLength.i8);

  /// {@macro solana_common.Buffer.getUint8}
  int getUint8() => getUint(ByteLength.u8);

  /// {@macro solana_common.Buffer.getInt16}
  int getInt16() => getInt(ByteLength.i16);

  /// {@macro solana_common.Buffer.getUint16}
  int getUint16() => getUint(ByteLength.u16);

  /// {@macro solana_common.Buffer.getInt32}
  int getInt32() => getInt(ByteLength.i32);

  /// {@macro solana_common.Buffer.getUint32}
  int getUint32() => getUint(ByteLength.u32);

  /// {@macro solana_common.Buffer.getInt64}
  int getInt64() => getInt(ByteLength.i64);

  /// {@macro solana_common.Buffer.getUint64}
  BigInt getUint64() => getBigUint(ByteLength.u64);

  /// {@macro solana_common.Buffer.getInt128}
  BigInt getInt128() => getBigInt(ByteLength.i128);

  /// {@macro solana_common.Buffer.getUint128}
  BigInt getUint128() => getBigUint(ByteLength.u128);

  /// {@macro solana_common.Buffer.getFloat32}
  double getFloat32() {
    final double value = buffer.getFloat32(offset);
    offset += ByteLength.f32;
    return value;
  }

  /// {@macro solana_common.Buffer.getFloat64}
  double getFloat64() {
    final double value = buffer.getFloat64(offset);
    offset += ByteLength.f64;
    return value;
  }

  /// {@macro solana_common.Buffer.getDateTime}
  DateTime getDateTime() {
    final DateTime value = buffer.getDateTime(offset);
    offset += ByteLength.i64;
    return value;
  }

  /// {@macro solana_common.Buffer.slice}
  ///
  /// If [slice] == true the returned buffer is resized to include only the remaining items.
  Buffer toBuffer({required final bool slice}) =>
      buffer.slice(slice ? offset : 0);

  @override
  String toString() => buffer.toString();

  @override
  Iterator<int> get iterator => BufferReaderIterator(buffer, offset);
}

/// Buffer Reader Iterator
/// ------------------------------------------------------------------------------------------------

class BufferReaderIterator implements Iterator<int> {
  BufferReaderIterator(this._buffer, this._offset);

  final Buffer _buffer;

  int _offset;

  @override
  int get current => _buffer[_offset - 1];

  @override
  bool moveNext() => (++_offset) <= _buffer.length;
}

/// Buffer Writer
/// ------------------------------------------------------------------------------------------------

class BufferWriter {
  /// Creates a `zero initialised` [buffer] of size [length] that maintains its offset position
  /// while writing data to the buffer.
  ///
  /// ```
  /// final BufferWriter writer = BufferWriter(8);
  /// writer.set([1, 2]);
  /// print(writer); // [1, 2, 0, 0, 0, 0, 0, 0]
  /// writer.set([3, 4, 5, 6]);
  /// print(writer); // [1, 2, 3, 4, 5, 6, 0, 0]
  /// ```
  BufferWriter(
    final int length, {
    this.growable = false,
  }) : buffer = Buffer(length);

  /// The buffer to write to.
  Buffer buffer;

  /// The current offset.
  @protected
  int offset = 0;

  /// If true, dynamically increase the size of the buffer as needed.
  @protected
  final bool growable;

  /// The capacity.
  int get length => buffer.length;

  /// The default length of a mutable buffer.
  static const int defaultMutableLength = 1024;

  /// Creates a resizable [BufferWriter] with an initial [length].
  factory BufferWriter.mutable([final int length = defaultMutableLength]) =>
      BufferWriter(length, growable: true);

  /// Writes a byte array to a region of [buffer] starting at [offset]. The internal [offset] is
  /// advanced by [value] `length`.
  void setBuffer(final Iterable<int> value) {
    _increaseCapacity(value.length);
    buffer._data.setAll(offset, value);
    offset += value.length;
  }

  /// {@macro solana_common.Buffer.setString}
  void setString(
    final String value, [
    final BufferEncoding encoding = BufferEncoding.utf8,
  ]) {
    final Iterable<int> bytes = Buffer.fromString(value, encoding);
    setBuffer(bytes);
  }

  /// {@macro solana_common.Buffer.setInt}
  void setInt(final int value, final int length) {
    _increaseCapacity(length);
    offset = buffer.setInt(value, offset, length);
  }

  /// {@macro solana_common.Buffer.setUint}
  void setUint(final int value, final int length) {
    _increaseCapacity(length);
    offset = buffer.setUint(value, offset, length);
  }

  /// {@macro solana_common.Buffer.setBigInt}
  void setBigInt(final BigInt value, final int length) {
    _increaseCapacity(length);
    offset = buffer.setBigInt(value, offset, length);
  }

  /// {@macro solana_common.Buffer.setBigUint}
  void setBigUint(final BigInt value, final int length) {
    _increaseCapacity(length);
    offset = buffer.setBigUint(value, offset, length);
  }

  /// {@macro solana_common.Buffer.setBool}
  void setBool(final bool value) {
    _increaseCapacity(ByteLength.u8);
    offset = buffer.setBool(value, offset);
  }

  /// {@macro solana_common.Buffer.setInt8}
  void setInt8(final int value) => setInt(value, ByteLength.i8);

  /// {@macro solana_common.Buffer.setUint8}
  void setUint8(final int value) => setUint(value, ByteLength.u8);

  /// {@macro solana_common.Buffer.setInt16}
  void setInt16(final int value) => setInt(value, ByteLength.i16);

  /// {@macro solana_common.Buffer.setUint16}
  void setUint16(final int value) => setUint(value, ByteLength.u16);

  /// {@macro solana_common.Buffer.setInt32}
  void setInt32(final int value) => setInt(value, ByteLength.i32);

  /// {@macro solana_common.Buffer.setUint32}
  void setUint32(final int value) => setUint(value, ByteLength.u32);

  /// {@macro solana_common.Buffer.setInt64}
  void setInt64(final int value) => setInt(value, ByteLength.i64);

  /// {@macro solana_common.Buffer.setUint64}
  void setUint64(final BigInt value) => setBigUint(value, ByteLength.u64);

  /// {@macro solana_common.Buffer.setInt128}
  void setInt128(final BigInt value) => setBigInt(value, ByteLength.i128);

  /// {@macro solana_common.Buffer.setUint128}
  void setUint128(final BigInt value) => setBigUint(value, ByteLength.u128);

  /// {@macro solana_common.Buffer.setFloat32}
  void setFloat32(final double value) {
    _increaseCapacity(ByteLength.f32);
    buffer.setFloat32(value, offset);
    offset += ByteLength.f32;
  }

  /// {@macro solana_common.Buffer.setFloat64}
  void setFloat64(final double value) {
    _increaseCapacity(ByteLength.f64);
    buffer.setFloat64(value, offset);
    offset += ByteLength.f64;
  }

  /// {@macro solana_common.Buffer.setDateTime}
  void setDateTime(final DateTime value) {
    _increaseCapacity(ByteLength.i64);
    buffer.setDateTime(value, offset);
    offset += ByteLength.i64;
  }

  /// Increase the buffer's capacity if [size] bytes cannot be written to the current buffer.
  void _increaseCapacity(final int size) {
    if (growable && (offset + size) > length) {
      buffer = Buffer.fromList(buffer, buffer.length + defaultMutableLength);
    }
  }

  /// {@macro solana_common.Buffer.slice}
  ///
  ///
  /// If [slice] == true the returned buffer is resized to the current [offset].
  Buffer toBuffer({required final bool slice}) =>
      buffer.slice(0, slice ? offset : null);

  @override
  String toString() => buffer.toString();
}

/// Buffer
/// ------------------------------------------------------------------------------------------------

class Buffer extends Iterable<int> {
  /// Creates a fixed [length] list of `8-bit` unsigned integers.
  ///
  /// Each item in the list is `zero` initialised.
  Buffer(final int length) : _data = Uint8List(length);

  /// Creates a [Buffer] from a [Uint8List].
  Buffer.fromUint8List(final Uint8List data) : _data = data;

  /// The buffer's underlying data structure.
  Uint8List _data;

  /// The bit length of a single item.
  static const int _bitLength = 8;

  /// The bit mask of a single item.
  static const int _maxUint8 = 255;

  /// Returns the byte at [index].
  int operator [](final int index) => _data[index];

  /// Sets the byte [value] at [index].
  void operator []=(final int index, final int value) => _data[index] = value;

  /// Creates a new [Buffer] by concatenating `this` and `[other]`.
  Buffer operator +(final Iterable<int> other) =>
      Buffer.fromList(_data + other.toList(growable: false));

  /// Creates a [Buffer] from an [bool] value.
  factory Buffer.fromBool(final bool value) =>
      Buffer(ByteLength.u8)..setBool(value, 0);

  /// Creates a [Buffer] from an `i8` value.
  factory Buffer.fromInt8(final int value) =>
      Buffer(ByteLength.i8)..setInt8(value, 0);

  /// Creates a [Buffer] from a `u8` value.
  factory Buffer.fromUint8(final int value) =>
      Buffer(ByteLength.u8)..setUint8(value, 0);

  /// Creates a [Buffer] from an `i16` value.
  factory Buffer.fromInt16(final int value) =>
      Buffer(ByteLength.i16)..setInt16(value, 0);

  /// Creates a [Buffer] from a `u16` value.
  factory Buffer.fromUint16(final int value) =>
      Buffer(ByteLength.u16)..setUint16(value, 0);

  /// Creates a [Buffer] from an `i32` value.
  factory Buffer.fromInt32(final int value) =>
      Buffer(ByteLength.i32)..setInt32(value, 0);

  /// Creates a [Buffer] from a `u32` value.
  factory Buffer.fromUint32(final int value) =>
      Buffer(ByteLength.u32)..setUint32(value, 0);

  /// Creates a [Buffer] from an `i64` value.
  factory Buffer.fromInt64(final int value) =>
      Buffer(ByteLength.i64)..setInt64(value, 0);

  /// Creates a [Buffer] from a `u64` value.
  factory Buffer.fromUint64(final BigInt value) =>
      Buffer(ByteLength.u64)..setUint64(value, 0);

  /// Creates a [Buffer] from an `i128` value.
  factory Buffer.fromInt128(final BigInt value) =>
      Buffer(ByteLength.i128)..setInt128(value, 0);

  /// Creates a [Buffer] from a `u128` value.
  factory Buffer.fromUint128(final BigInt value) =>
      Buffer(ByteLength.u128)..setUint128(value, 0);

  /// Creates a [Buffer] from an `f32` value.
  factory Buffer.fromFloat32(final double value) =>
      Buffer(ByteLength.f32)..setFloat32(value, 0);

  /// Creates a [Buffer] from a `f64` value.
  factory Buffer.fromFloat64(final double value) =>
      Buffer(ByteLength.f64)..setFloat64(value, 0);

  /// Creates a [Buffer] from a [DateTime].
  factory Buffer.fromDateTime(final DateTime dateTime) =>
      Buffer(ByteLength.i64)..setDateTime(dateTime, 0);

  /// Creates a [Buffer] from a list of [bytes].
  factory Buffer.fromList(final Iterable<int> bytes, [final int? length]) =>
      Buffer(length ?? bytes.length).._data.setAll(0, bytes);

  /// Creates a [Buffer] from an [encoded] string.
  ///
  /// ```
  /// const String hexString = '00FF';
  /// final Buffer buffer = Buffer.fromString(hexString, BufferEncoding.hex);
  /// print(buffer); // [0, 255]
  /// ```
  factory Buffer.fromString(
    final String encoded, [
    final BufferEncoding encoding = BufferEncoding.utf8,
  ]) =>
      Buffer.fromList(_decode(encoded, encoding));

  /// Creates a [Buffer] from a List of [Buffer]s.
  ///
  /// ```
  /// final Buffer buffer = Buffer.flatten(
  ///   Buffer.fromInt16(265), // [0, 1]
  ///   Buffer.fromInt16(512), // [0, 2]
  /// );
  /// print(buffer); // [0, 1, 0, 2]
  /// ```
  factory Buffer.flatten(final List<Iterable<int>> buffers) {
    return buffers.fold(Buffer(0), (buffer, item) => buffer + item);
  }

  /// Creates a [Buffer] of size [length], initialised to the values returned by calling [generator]
  /// for each index.
  ///
  /// ```
  /// final Buffer buffer = Buffer.generate(4, (final int index) => index * 2);
  /// print(buffer); // [0, 2, 4, 6]
  /// ```
  factory Buffer.generate(
    final int length,
    final int Function(int index) generator,
  ) {
    final Buffer buffer = Buffer(length);
    for (int i = 0; i < buffer.length; ++i) {
      buffer[i] = generator(i);
    }
    return buffer;
  }

  /// Creates a [Buffer] of size [length], initialised with random values in the range of
  /// `[0:maxUint8]`.
  ///
  /// The [random] number generator defaults to [Random.secure].
  ///
  /// ```
  /// final Buffer buffer = Buffer.random(4);
  /// print(buffer); // [47, 0, 255, 6]
  /// ```
  factory Buffer.random(
    final int length, [
    final Random? random,
  ]) {
    final Random rand = random ?? Random.secure();
    return Buffer.generate(length, (_) => rand.nextInt(_maxUint8 + 1));
  }

  /// The number of items in the buffer.
  @override
  int get length => _data.length;

  /// Returns a new [Iterator] to walk through the items in the buffer.
  @override
  Iterator<int> get iterator => _data.iterator;

  /// Returns an [Iterable] to walk through the items in reverse order.
  Iterable<int> get reversed => _data.reversed;

  /// Creates a new [BufferReader] to traverse `this` buffer.
  BufferReader get reader => BufferReader(this);

  /// Creates a new [BufferWriter] of size [length].
  BufferWriter get writer => BufferWriter(length);

  /// Creates a [Uint8List] view over the buffer.
  ///
  /// Changes made to the returned view will reflect in the buffer.
  Uint8List asUint8List() => _data;

  /// Creates a [ByteData] view over a region of the buffer.
  ///
  /// The view starts at the zero indexed [offset] and contains [length] items. If [length] is
  /// omitted, the range extends to the end of the buffer.
  ///
  /// Changes made to the returned view will reflect in the buffer.
  ///
  /// The range must satisy the relations `0` ≤ `offset` ≤ `offset+length` ≤ `this.length`.
  ByteData asByteData([final int offset = 0, final int? length]) {
    return _data.buffer.asByteData(offset, length);
  }

  /// {@template solana_common.Buffer.slice}
  /// Creates a new [Buffer] from a region of `this` buffer.
  /// {@endtemplate}
  ///
  /// Items are copied from the range `[offset : offset+length]`. If [length] is omitted, the range
  /// extends to the end of the buffer.
  ///
  /// The range must satisy the relations `0` ≤ `offset` ≤ `offset+length` ≤ `this.length`.
  ///
  /// ```
  /// final Buffer buffer = Buffer.fromList([1, 2, 3, 4, 5, 6, 7, 8]);
  /// final Buffer newBuffer = buffer.slice(4);
  /// print(buffer);    // [1, 2, 3, 4, 5, 6, 7, 8]
  /// print(newBuffer); // [5, 6, 7, 8]
  /// ```
  Buffer slice([final int offset = 0, final int? length]) {
    final int? end = length != null ? offset + length : null;
    return Buffer.fromList(_data.sublist(offset, end));
  }

  /// Copies items from `this` buffer to the destination ([dst]) buffer.
  ///
  /// Items are copied to [dst] starting at position [dstOffset].
  ///
  /// Items are copied from the range `[offset : offset+length]`. If [length] is omitted, the range
  /// extends to the end of `this` or `[dst]` (whichever has the minimum length).
  ///
  /// The range must satisy the relations `0` ≤ `offset` ≤ `offset+length` ≤ `this.length`.
  ///
  /// ```
  /// final Buffer src = Buffer.fromList([1, 2, 3, 4, 5, 6, 7, 8]);
  /// final Buffer dst = Buffer(4);
  /// src.copy(dst, 0, 2);
  /// print(src); // [1, 2, 3, 4, 5, 6, 7, 8]
  /// print(dst); // [3, 4, 5, 6]
  /// ```
  void copy(
    final Buffer dst, [
    final int dstOffset = 0,
    final int offset = 0,
    final int? length,
  ]) {
    final int rngLength =
        length ?? min(dst.length - dstOffset, this.length - offset);
    final Iterable<int> src = _data.getRange(offset, offset + rngLength);
    dst._data.setRange(dstOffset, dstOffset + rngLength, src);
  }

  /// Reads the buffer starting at [offset] into a `byte array`.
  ///
  /// The offset must satisy the relations `0` ≤ `offset` ≤ `this.length`.
  ///
  /// ```
  /// final Buffer buf = Buffer.fromList([1, 2, 3, 4, 5, 6, 7, 8]);
  /// print(buf);           // [1, 2, 3, 4, 5, 6, 7, 8]
  /// print(buf.getAll(2)); // [3, 4, 5, 6, 7, 8]
  /// print(buf.getAll(4)); // [5, 6, 7, 8]
  /// print(buf.getAll(8)); // []
  /// ```
  Iterable<int> getAll(
    final int offset,
  ) {
    return _data.getRange(offset, length);
  }

  /// Writes a `byte array` to a region of the buffer starting at [offset].
  ///
  /// If [offset] + [bytes] length exceeds [length], the range extends to the end of the buffer.
  ///
  /// The offset must satisy the relations `0` ≤ `offset` ≤ `this.length`.
  /// ```
  /// final Buffer buf = Buffer.fromList([0, 0, 0, 0, 0, 0, 0, 0]);
  /// print(buf); // [0, 0, 0, 0, 0, 0, 0, 0]
  ///
  /// buf.setAll(2, [1, 2, 3, 4]);
  /// print(buf); // [0, 0, 1, 2, 3, 4, 0, 0]
  ///
  /// buf.setAll(6, [5, 6, 7, 8]);
  /// print(buf); // [0, 0, 1, 2, 3, 4, 5, 6]
  /// ```
  void setAll(
    final int offset,
    final Iterable<int> bytes,
  ) {
    _data.setAll(offset, bytes);
  }

  /// {@template solana_common.Buffer.getString}
  /// Reads a region of the buffer as an `encoded string`.
  ///
  /// Items are read from the range `[offset : offset+length]`. If [length] is omitted, the range
  /// extends to the end of the buffer.
  ///
  /// The range must satisy the relations `0` ≤ `offset` ≤ `offset+length` ≤ `this.length`.
  /// {@endtemplate}
  ///
  /// ```
  /// final Buffer buffer = Buffer.fromList([72, 105, 32, 75, 97, 116, 101]);
  /// final String hex = buffer.getString(BufferEncoding.hex);
  /// print(hex); // '4869204B617465'
  /// ```
  String getString(final BufferEncoding encoding,
      [final int offset = 0, final int? length]) {
    final int end = length != null ? offset + length : this.length;
    final Iterable<int> bytes = _data.getRange(offset, end);
    return _encode(Uint8List.fromList(bytes.toList(growable: false)), encoding);
  }

  /// {@template solana_common.Buffer.setString}
  /// Writes an `encoded [value] to a region of the buffer.
  ///
  /// Returns the position of the last element written to the buffer ([offset] + decoded-length).
  ///
  /// The encoded [value] is written to the range `[offset : offset+length]`. If [length] is
  /// omitted, the range extends to the end of the buffer.
  ///
  /// The range must satisy the relations `0` ≤ `offset` ≤ `offset+length` ≤ `this.length`.
  /// {@endtemplate}
  ///
  /// ```
  /// final Buffer buffer = Buffer(7);
  /// const String value = '4869204B617465';
  /// buffer.setString(value, BufferEncoding.hex, 0, 2);
  /// print(buffer); // [72, 105, 0, 0, 0, 0, 0]
  /// buffer.setString(value, BufferEncoding.hex, 0);
  /// print(buffer); // [72, 105, 32, 75, 97, 116, 101]
  /// ```
  int setString(
    final String value,
    final BufferEncoding encoding, [
    final int offset = 0,
    final int? length,
  ]) {
    final Iterable<int> bytes = _decode(value, encoding);
    final int rngLength = length ?? min(this.length - offset, bytes.length);
    _data.setRange(offset, offset + rngLength, bytes);
    return offset + rngLength;
  }

  /// {@template solana_common.Buffer.getBool}
  /// Reads `1-byte` as a `boolean`.
  /// {@endtemplate}
  ///
  /// The [offset] must satisy the relations `0` ≤ `offset` ≤ `offset+1` ≤ `this.length`.
  ///
  /// ```
  /// final Buffer buffer = Buffer.fromList([1]);
  /// final bool value = buffer.getBool(0);
  /// print(value); // true
  /// ```
  bool getBool(final int offset) {
    return asByteData().getUint8(offset) != 0;
  }

  /// {@template solana_common.Buffer.setBool}
  /// Writes a `boolean` value to `1-byte`.
  /// {@endtemplate}
  ///
  /// The [offset] must satisy the relations `0` ≤ `offset` ≤ `offset+1` ≤ `this.length`.
  ///
  /// Returns the position of the last element written to the buffer (`[offset]+1`).
  ///
  /// ```
  /// final Buffer buffer = Buffer(1);
  /// buffer.setBool(true, 0);
  /// print(buffer); // [1]
  /// buffer.setBool(false, 0);
  /// print(buffer); // [0]
  /// ```
  int setBool(final bool value, final int offset) {
    asByteData().setUint8(offset, value ? 1 : 0);
    return offset + ByteLength.u8;
  }

  /// {@template solana_common.Buffer.getInt}
  /// Reads a region of the buffer as a `signed integer`.
  ///
  /// Items are read from the range `[offset : offset+length]`.
  ///
  /// The range must satisy the relations `0` ≤ `offset` ≤ `offset+length` ≤ `this.length`.
  /// {@endtemplate}
  ///
  /// ```
  /// final Buffer buffer = Buffer.fromList([83, 112, 62]);
  /// final int value = buffer.getInt(0, 3);
  /// print(value); // 4091987
  /// ```
  int getInt(final int offset, final int length,
      [final Endian endian = Endian.little]) {
    return getUint(offset, length, endian).toSigned(length * _bitLength);
  }

  /// {@template solana_common.Buffer.setInt}
  /// Writes a `signed integer` to a region of the buffer.
  ///
  /// The [value] is written to the range `[offset : offset+length]`.
  ///
  /// The range must satisy the relations `0` ≤ `offset` ≤ `offset+length` ≤ `this.length`.
  /// {@endtemplate}
  ///
  /// Returns the position of the last element written to the buffer (`[offset]+[length]`).
  ///
  /// ```
  /// final Buffer buffer = Buffer(3);
  /// buffer.setInt(4091987, 0, 3);
  /// print(buffer); // [83, 112, 62]
  /// ```
  int setInt(
    final int value,
    final int offset,
    final int length, [
    final Endian endian = Endian.little,
  ]) {
    return _setBytes(_toBytes(value, length), offset, endian);
  }

  /// {@template solana_common.Buffer.getBigInt}
  /// Reads a region of the buffer as a `signed big integer`.
  ///
  /// Items are read from the range `[offset : offset+length]`.
  ///
  /// The range must satisy the relations `0` ≤ `offset` ≤ `offset+length` ≤ `this.length`.
  /// {@endtemplate}
  ///
  /// ```
  /// final Buffer buffer = Buffer.fromList([255, 255, 31, 236, 95, 13, 82, 66, 20, 2]);
  /// final BigInt value = buffer.getBigInt(0, buffer.length);
  /// print(value); // 9818446744073709551615
  /// ```
  BigInt getBigInt(final int offset, final int length,
      [final Endian endian = Endian.little]) {
    return getBigUint(offset, length, endian).toSigned(length * _bitLength);
  }

  /// {@template solana_common.Buffer.setBigInt}
  /// Writes a `big signed integer` to a region of the buffer.
  ///
  /// The [value] is written to the range `[offset : offset+length]`. If [length] is omitted, the
  /// minimum number of bytes required to store this big integer value is used.
  ///
  /// The range must satisy the relations `0` ≤ `offset` ≤ `offset+length` ≤ `this.length`.
  /// {@endtemplate}
  ///
  /// Returns the position of the last element written to the buffer (`[offset]+[length]`).
  ///
  /// ```
  /// final Buffer buffer = Buffer(10);
  /// buffer.setBigInt(BigInt.parse('9818446744073709551615'), 0);
  /// print(buffer); // [255, 255, 31, 236, 95, 13, 82, 66, 20, 2]
  /// ```
  int setBigInt(
    final BigInt value,
    final int offset, [
    final int? length,
    final Endian endian = Endian.little,
  ]) {
    return _setBytes(_toBytesBigInt(value, length), offset, endian);
  }

  /// {@template solana_common.Buffer.getInt8}
  /// Reads `1-byte` as a `signed integer`.
  ///
  /// The [offset] must satisy the relations `0` ≤ `offset` ≤ `offset+1` ≤ `this.length`.
  /// {@endtemplate}
  ///
  /// ```
  /// final Buffer buffer = Buffer.fromList([-1]);
  /// final int value = buffer.getInt8(0);
  /// print(value); // -1
  /// ```
  int getInt8(final int offset) {
    return asByteData().getInt8(offset);
  }

  /// {@template solana_common.Buffer.setInt8}
  /// Writes a `signed integer` to `1-byte`.
  ///
  /// The [offset] must satisy the relations `0` ≤ `offset` ≤ `offset+1` ≤ `this.length`.
  /// {@endtemplate}
  ///
  /// ```
  /// final Buffer buffer = Buffer(1);
  /// buffer.setInt8(-1, 0);
  /// print(buffer); // [255]
  /// ```
  void setInt8(final int value, final int offset) {
    return asByteData().setInt8(offset, value);
  }

  /// {@template solana_common.Buffer.getInt16}
  /// Reads `2-bytes` as a `signed integer`.
  ///
  /// The [offset] must satisy the relations `0` ≤ `offset` ≤ `offset+2` ≤ `this.length`.
  /// {@endtemplate}
  ///
  /// ```
  /// final Buffer buffer = Buffer.fromList([8, 16]);
  /// final int value = buffer.getInt16(0);
  /// print(value); // 4104
  /// ```
  int getInt16(final int offset, [final Endian endian = Endian.little]) {
    return asByteData().getInt16(offset, endian);
  }

  /// {@template solana_common.Buffer.setInt16}
  /// Writes a `signed integer` to `2-bytes`.
  ///
  /// The [offset] must satisy the relations `0` ≤ `offset` ≤ `offset+2` ≤ `this.length`.
  /// {@endtemplate}
  ///
  /// ```
  /// final Buffer buffer = Buffer(2);
  /// buffer.setInt16(4104, 0);
  /// print(buffer); // [8, 16]
  /// ```
  void setInt16(final int value, final int offset,
      [final Endian endian = Endian.little]) {
    return asByteData().setInt16(offset, value, endian);
  }

  /// {@template solana_common.Buffer.getInt32}
  /// Reads `4-bytes` as a `signed integer`.
  ///
  /// The [offset] must satisy the relations `0` ≤ `offset` ≤ `offset+4` ≤ `this.length`.
  /// {@endtemplate}
  ///
  /// ```
  /// final Buffer buffer = Buffer.fromList([8, 16, 32, 64]);
  /// final int value = buffer.getInt32(0);
  /// print(value); // 1075843080
  /// ```
  int getInt32(final int offset, [final Endian endian = Endian.little]) {
    return asByteData().getInt32(offset, endian);
  }

  /// {@template solana_common.Buffer.setInt32}
  /// Writes a `signed integer` to `4-bytes`.
  ///
  /// The [offset] must satisy the relations `0` ≤ `offset` ≤ `offset+4` ≤ `this.length`.
  /// {@endtemplate}
  ///
  /// ```
  /// final Buffer buffer = Buffer(4);
  /// buffer.setInt32(1075843080, 0);
  /// print(buffer); // [8, 16, 32, 64]
  /// ```
  void setInt32(final int value, final int offset,
      [final Endian endian = Endian.little]) {
    return asByteData().setInt32(offset, value, endian);
  }

  /// {@template solana_common.Buffer.getInt64}
  /// Reads `8-bytes` as a `signed integer`.
  ///
  /// The [offset] must satisy the relations `0` ≤ `offset` ≤ `offset+8` ≤ `this.length`.
  /// {@endtemplate}
  ///
  /// ```
  /// final Buffer buffer = Buffer.fromList([8, 16, 32, 64, 128, 8, 16, 32]);
  /// final int value = buffer.getInt64(0);
  /// print(value); // 2310355955765743624
  /// ```
  int getInt64(final int offset, [final Endian endian = Endian.little]) {
    return asByteData().getInt64(offset, endian);
  }

  /// {@template solana_common.Buffer.setInt64}
  /// Writes a `signed integer` to `8-bytes`.
  ///
  /// The [offset] must satisy the relations `0` ≤ `offset` ≤ `offset+8` ≤ `this.length`.
  /// {@endtemplate}
  ///
  /// ```
  /// final Buffer buffer = Buffer(8);
  /// buffer.setInt64(2310355955765743624, 0);
  /// print(buffer); // [8, 16, 32, 64, 128, 8, 16, 32]
  /// ```
  void setInt64(final int value, final int offset,
      [final Endian endian = Endian.little]) {
    return asByteData().setInt64(offset, value, endian);
  }

  /// {@template solana_common.Buffer.getInt128}
  /// Reads `16-bytes` as a `signed integer`.
  ///
  /// The [offset] must satisy the relations `0` ≤ `offset` ≤ `offset+8` ≤ `this.length`.
  /// {@endtemplate}
  BigInt getInt128(final int offset, [final Endian endian = Endian.little]) {
    return getBigInt(offset, ByteLength.i128, endian);
  }

  /// {@template solana_common.Buffer.setInt128}
  /// Writes a `signed integer` to `16-bytes`.
  ///
  /// The [offset] must satisy the relations `0` ≤ `offset` ≤ `offset+8` ≤ `this.length`.
  /// {@endtemplate}
  void setInt128(final BigInt value, final int offset,
      [final Endian endian = Endian.little]) {
    setBigInt(value, offset, ByteLength.i128, endian);
  }

  /// Reads a region of the buffer as a `big endian unsigned integer`.
  int _getUintBE(final Iterable<int> bytes) {
    return bytes.fold(
        0, (final int value, final int byte) => value << _bitLength | byte);
  }

  /// Reads a region of the buffer as a `little endian unsigned integer`.
  int _getUintLE(final Iterable<int> bytes) {
    int i = 0;
    return bytes.fold(
        0,
        (final int value, final int byte) =>
            byte << (i++ * _bitLength) | value);
  }

  /// {@template solana_common.Buffer.getUint}
  /// Reads a region of the buffer as an `unsigned integer`.
  ///
  /// Items are read from the range `[offset : offset+length]`.
  ///
  /// The range must satisy the relations `0` ≤ `offset` ≤ `offset+length` ≤ `this.length`.
  /// {@endtemplate}
  ///
  /// ```
  /// final Buffer buffer = Buffer.fromList([56, 138, 75]);
  /// final int value = buffer.getUint(0, 3);
  /// print(value); // 4950584
  /// ```
  int getUint(final int offset, final int length,
      [final Endian endian = Endian.little]) {
    final Iterable<int> values = _data.getRange(offset, offset + length);
    return endian == Endian.big ? _getUintBE(values) : _getUintLE(values);
  }

  /// {@template solana_common.Buffer.setUint}
  /// Writes an `unsigned integer` to a region of the buffer.
  ///
  /// The [value] is written to the range `[offset : offset+length]`.
  ///
  /// The range must satisy the relations `0` ≤ `offset` ≤ `offset+length` ≤ `this.length`.
  /// {@endtemplate}
  ///
  /// Returns the position of the last element written to the buffer (`[offset]+[length]`).
  ///
  /// ```
  /// final Buffer buffer = Buffer(3);
  /// buffer.setUint(4950584, 0, 3);
  /// print(buffer); // [56, 138, 75]
  /// ```
  int setUint(
    final int value,
    final int offset,
    final int length, [
    final Endian endian = Endian.little,
  ]) {
    assert(value >= 0, 'The [int] value $value must be a positive integer.');
    return setInt(value, offset, length, endian);
  }

  /// Reads a region of the buffer as a `big unsigned integer` in `big endian`.
  BigInt _getBigUintBE(final Iterable<int> bytes) {
    return bytes.fold(
      BigInt.zero,
      (final BigInt value, final int byte) =>
          value << _bitLength | BigInt.from(byte),
    );
  }

  /// Reads a region of the buffer as a `big unsigned integer` in `little endian`.
  BigInt _getBigUintLE(final Iterable<int> bytes) {
    int i = 0;
    return bytes.fold(
      BigInt.zero,
      (final BigInt value, final int byte) =>
          BigInt.from(byte) << (i++ * _bitLength) | value,
    );
  }

  /// {@template solana_common.Buffer.getBigUint}
  /// Reads a region of the buffer as an `unsigned big integer`.
  ///
  /// Items are read from the range `[offset : offset+length]`.
  ///
  /// The range must satisy the relations `0` ≤ `offset` ≤ `offset+length` ≤ `this.length`.
  /// {@endtemplate}
  ///
  /// ```
  /// final Buffer buffer = Buffer.fromList([255, 255, 255, 255, 255, 255, 255, 255]);
  /// final BigInt value = buffer.getBigUint(0, buffer.length);
  /// print(value); // 18446744073709551615
  /// ```
  BigInt getBigUint(final int offset, final int length,
      [final Endian endian = Endian.little]) {
    final Iterable<int> bytes = _data.getRange(offset, offset + length);
    return endian == Endian.big ? _getBigUintBE(bytes) : _getBigUintLE(bytes);
  }

  /// {@template solana_common.Buffer.setBigUint}
  /// Writes a `big unsigned integer` to a region of the buffer.
  ///
  /// The [value] is written to the range `[offset : offset+length]`. If [length] is omitted, it
  /// defaults to the [value]'s byte length.
  ///
  /// The range must satisy the relations `0` ≤ `offset` ≤ `offset+length` ≤ `this.length`.
  /// {@endtemplate}
  ///
  /// Returns the position of the last element written to the buffer (`[offset]+[length]`).
  ///
  /// ```
  /// final Buffer buffer = Buffer(8);
  /// buffer.setBigUint(BigInt.parse('18446744073709551615'), 0);
  /// print(buffer); // [255, 255, 255, 255, 255, 255, 255, 255]
  /// ```
  int setBigUint(
    final BigInt value,
    final int offset, [
    final int? length,
    final Endian endian = Endian.little,
  ]) {
    assert(value >= BigInt.zero,
        'The [BigInt] value $value must be a positive integer.');
    return setBigInt(value, offset, length, endian);
  }

  /// {@template solana_common.Buffer.getUint8}
  /// Reads `1-byte` as an `unsigned integer`.
  /// {@endtemplate}
  ///
  /// The [offset] must satisy the relations `0` ≤ `offset` ≤ `offset+1` ≤ `this.length`.
  ///
  /// ```
  /// final Buffer buffer = Buffer.fromList([128]);
  /// final int value = buffer.getUint8(0);
  /// print(value); // 128
  /// ```
  int getUint8(final int offset) {
    return asByteData().getUint8(offset);
  }

  /// {@template solana_common.Buffer.setUint8}
  /// Writes an `unsigned integer` to `1-byte`.
  /// {@endtemplate}
  ///
  /// If [value] falls outside the range `0 : 255` (inclusive), the integer is overflow (e.g.
  /// `-2 -> [254]`, `-1 -> [255]`, ..., `256 -> [0]` and `257 -> [1]`).
  ///
  /// The [offset] must satisy the relations `0` ≤ `offset` ≤ `offset+1` ≤ `this.length`.
  ///
  /// ```
  /// final Buffer buffer = Buffer(1);
  /// buffer.setUint8(128, 0);
  /// print(buffer); // [128]
  /// ```
  void setUint8(final int value, final int offset) {
    return asByteData().setUint8(offset, value);
  }

  /// {@template solana_common.Buffer.getUint16}
  /// Reads `2-bytes` as an `unsigned integer`.
  /// {@endtemplate}
  ///
  /// The [offset] must satisy the relations `0` ≤ `offset` ≤ `offset+2` ≤ `this.length`.
  ///
  /// ```
  /// final Buffer buffer = Buffer.fromList([95, 106]);
  /// final int value = buffer.getUint16(0);
  /// print(value); // 27231
  /// ```
  int getUint16(final int offset, [final Endian endian = Endian.little]) {
    return asByteData().getUint16(offset, endian);
  }

  /// {@template solana_common.Buffer.setUint16}
  /// Writes an `unsigned integer` to `2-bytes`.
  /// {@endtemplate}
  ///
  /// The [offset] must satisy the relations `0` ≤ `offset` ≤ `offset+2` ≤ `this.length`.
  ///
  /// ```
  /// final Buffer buffer = Buffer(2);
  /// buffer.setUint16(27231, 0);
  /// print(buffer); // [95, 106]
  /// ```
  void setUint16(final int value, final int offset,
      [final Endian endian = Endian.little]) {
    return asByteData().setUint16(offset, value, endian);
  }

  /// {@template solana_common.Buffer.getUint32}
  /// Reads `4-bytes` as an `unsigned integer`.
  /// {@endtemplate}
  ///
  /// The [offset] must satisy the relations `0` ≤ `offset` ≤ `offset+4` ≤ `this.length`.
  ///
  /// ```
  /// final Buffer buffer = Buffer.fromList([24, 64, 16, 8]);
  /// final int value = buffer.getUint32(0);
  /// print(value); // 135282712
  /// ```
  int getUint32(final int offset, [final Endian endian = Endian.little]) {
    return asByteData().getUint32(offset, endian);
  }

  /// {@template solana_common.Buffer.setUint32}
  /// Writes an `unsigned integer` to `4-bytes`.
  /// {@endtemplate}
  ///
  /// The [offset] must satisy the relations `0` ≤ `offset` ≤ `offset+4` ≤ `this.length`.
  ///
  /// ```
  /// final Buffer buffer = Buffer(4);
  /// buffer.setUint32(135282712, 0);
  /// print(buffer); // [24, 64, 16, 8]
  /// ```
  void setUint32(final int value, final int offset,
      [final Endian endian = Endian.little]) {
    return asByteData().setUint32(offset, value, endian);
  }

  /// {@template solana_common.Buffer.getUint64}
  /// Reads `8-bytes` as an `unsigned integer`.
  ///
  /// The [offset] must satisy the relations `0` ≤ `offset` ≤ `offset+8` ≤ `this.length`.
  /// {@endtemplate}
  ///
  /// ```
  /// final Buffer buffer = Buffer.fromList([4, 54, 85, 120, 116, 23, 87, 94]);
  /// final int value = buffer.getUint64(0);
  /// print(value); // 6797927951541548548
  /// ```
  BigInt getUint64(final int offset, [final Endian endian = Endian.little]) {
    return getBigUint(offset, ByteLength.u64, endian);
  }

  /// {@template solana_common.Buffer.setUint64}
  /// Writes an `unsigned integer` to `8-bytes`.
  /// {@endtemplate}
  ///
  /// The [offset] must satisy the relations `0` ≤ `offset` ≤ `offset+8` ≤ `this.length`.
  ///
  /// ```
  /// final Buffer buffer = Buffer(8);
  /// buffer.setInt64(6797927951541548548, 0);
  /// print(buffer); // [4, 54, 85, 120, 116, 23, 87, 94]
  /// ```
  void setUint64(final BigInt value, final int offset,
      [final Endian endian = Endian.little]) {
    setBigUint(value, offset, ByteLength.u64, endian);
  }

  /// {@template solana_common.Buffer.getUint128}
  /// Reads `16-bytes` as an `unsigned integer`.
  ///
  /// The [offset] must satisy the relations `0` ≤ `offset` ≤ `offset+8` ≤ `this.length`.
  /// {@endtemplate}
  BigInt getUint128(final int offset, [final Endian endian = Endian.little]) {
    return getBigUint(offset, ByteLength.u128, endian);
  }

  /// {@template solana_common.Buffer.setUint128}
  /// Writes an `unsigned integer` to `16-bytes`.
  ///
  /// The [offset] must satisy the relations `0` ≤ `offset` ≤ `offset+8` ≤ `this.length`.
  /// {@endtemplate}
  void setUint128(final BigInt value, final int offset,
      [final Endian endian = Endian.little]) {
    setBigUint(value, offset, ByteLength.u128, endian);
  }

  /// {@template solana_common.Buffer.getFloat32}
  /// Reads `4-bytes` as a `floating point` value.
  ///
  /// The [offset] must satisy the relations `0` ≤ `offset` ≤ `offset+4` ≤ `this.length`.
  /// {@endtemplate}
  ///
  /// ```
  /// final Buffer buffer = Buffer.fromList([251, 33, 9, 64]);
  /// final double value = buffer.getFloat32(0);
  /// print(value); // 2.1426990032196045
  /// ```
  double getFloat32(final int offset, [final Endian endian = Endian.little]) {
    return asByteData().getFloat32(offset, endian);
  }

  /// {@template solana_common.Buffer.setFloat32}
  /// Writes a `floating point` [value] to `4-bytes`.
  ///
  /// The [offset] must satisy the relations `0` ≤ `offset` ≤ `offset+4` ≤ `this.length`.
  /// {@endtemplate}
  ///
  /// ```
  /// final Buffer buffer = Buffer(4);
  /// buffer.setFloat32(2.1426990032196045, 0);
  /// print(buffer); // [251, 33, 9, 64]
  /// ```
  void setFloat32(final double value, final int offset,
      [final Endian endian = Endian.little]) {
    return asByteData().setFloat32(offset, value, endian);
  }

  /// {@template solana_common.Buffer.getFloat64}
  /// Reads `8-bytes` as a `double precision floating point` value.
  ///
  /// The [offset] must satisy the relations `0` ≤ `offset` ≤ `offset+8` ≤ `this.length`.
  /// {@endtemplate}
  ///
  /// ```
  /// final Buffer buffer = Buffer.fromList([234, 46, 68, 84, 251, 33, 9, 64]);
  /// final double value = buffer.getFloat64(0);
  /// print(value); // 3.14159265359
  /// ```
  double getFloat64(final int offset, [final Endian endian = Endian.little]) {
    return asByteData().getFloat64(offset, endian);
  }

  /// {@template solana_common.Buffer.setFloat64}
  /// Writes a `double precision floating point` [value] to `8-bytes`.
  ///
  /// The [offset] must satisy the relations `0` ≤ `offset` ≤ `offset+8` ≤ `this.length`.
  /// {@endtemplate}
  ///
  /// ```
  /// final Buffer buffer = Buffer(8);
  /// buffer.setFloat64(3.14159265359, 0);
  /// print(buffer); // [234, 46, 68, 84, 251, 33, 9, 64]
  /// ```
  void setFloat64(final double value, final int offset,
      [final Endian endian = Endian.little]) {
    return asByteData().setFloat64(offset, value, endian);
  }

  /// {@template solana_common.Buffer.getDateTime}
  /// Reads an `i64` from the buffer as an epoch timestamp.
  ///
  /// The [offset] must satisy the relations `0` ≤ `offset` ≤ `offset+8` ≤ `this.length`.
  /// {@endtemplate}
  DateTime getDateTime(final int offset,
      [final Endian endian = Endian.little]) {
    return DateTime.fromMicrosecondsSinceEpoch(getInt64(offset, endian));
  }

  /// {@template solana_common.Buffer.setDateTime}
  /// Writes a [DateTime] to the buffer as an `i64`.
  ///
  /// The [offset] must satisy the relations `0` ≤ `offset` ≤ `offset+8` ≤ `this.length`.
  /// {@endtemplate}
  void setDateTime(final DateTime value, final int offset,
      [final Endian endian = Endian.little]) {
    return setInt64(value.microsecondsSinceEpoch, offset, endian);
  }

  /// Writes a `byte array` to the buffer.
  ///
  /// Returns the position of the last element written to the buffer (`[offset]+[bytes.length]`).
  ///
  /// The [bytes] array is written to the range `[offset : offset+bytes.length]`.
  ///
  /// The range must satisy the relations `0` ≤ `offset` ≤ `offset+bytes.length` ≤ `this.length`.
  int _setBytes(
    final Uint8List bytes,
    final int offset, [
    final Endian endian = Endian.little,
  ]) {
    _data.setAll(offset, endian == Endian.big ? bytes.reversed : bytes);
    return offset + bytes.length;
  }

  /// Converts an integer [value] to a byte array of size [length].
  ///
  /// ```
  /// _toBytes(256, 4);       // [0, 1, 0, 0]
  /// _toBytes(-1, 4);        // [255, 255, 255, 255]
  /// ```
  Uint8List _toBytes(final int value, final int length) {
    int remaining = value;
    final Uint8List bytes = Uint8List(length);
    for (int i = 0; i < bytes.length && remaining != 0; ++i) {
      bytes[i] = remaining & _maxUint8;
      remaining >>= _bitLength;
    }
    assert(remaining <= 0,
        'The [int] value $value overflows ${bytes.length} byte(s).');
    return bytes;
  }

  /// Converts a big integer [value] to a byte array of size [length].
  ///
  /// ```
  /// final BigInt input = BigInt.parse('-9818446744073709551615');
  /// final Uint8List bytes = _toBytesBigInt(input);
  /// print(bytes); // [1, 0, 224, 19, 160, 242, 173, 189, 235, 253]
  ///
  /// final BigInt output = BigIntExtension.fromUint8List(bytes);
  /// print(output.asSigned()); // '-9818446744073709551615'
  /// ```
  Uint8List _toBytesBigInt(final BigInt value, [final int? length]) {
    BigInt remaining = value;
    final BigInt mask = BigInt.from(Buffer._maxUint8);
    final Uint8List bytes = Uint8List(length ?? remaining.byteLength);
    for (int i = 0; i < bytes.length && remaining != BigInt.zero; ++i) {
      bytes[i] = (remaining & mask).toInt();
      remaining >>= _bitLength;
    }
    assert(remaining <= BigInt.zero,
        'The [BigInt] value $value overflows ${bytes.length} byte(s).');
    return bytes;
  }

  /// Converts an array of [bytes] to an encoded string.
  static String _encode(final Uint8List bytes, final BufferEncoding encoding) {
    switch (encoding) {
      case BufferEncoding.base58:
        return base58.encode(bytes);
      case BufferEncoding.base64:
        return base64.encode(bytes);
      case BufferEncoding.hex:
        return hex.encode(bytes);
      case BufferEncoding.utf8:
        return utf8.decode(bytes);
    }
  }

  /// Converts an [encoded] string to an array of bytes.
  static Iterable<int> _decode(
      final String encoded, final BufferEncoding encoding) {
    switch (encoding) {
      case BufferEncoding.base58:
        return base58.decode(encoded);
      case BufferEncoding.base64:
        return base64.decode(encoded);
      case BufferEncoding.hex:
        return hex.decode(encoded);
      case BufferEncoding.utf8:
        return utf8.encode(encoded);
    }
  }
}
