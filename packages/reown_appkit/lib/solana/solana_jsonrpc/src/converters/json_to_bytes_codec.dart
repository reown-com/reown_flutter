/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'dart:convert' show Codec, Converter, json, utf8;

/// JSON to Bytes Codec
/// ------------------------------------------------------------------------------------------------

/// A codec that converts between `JSON objects` and `byte data`.
///
/// ```
/// const codec = JsonToBytesCodec();
/// final jsonData = { 'a': 0 };
/// final byteData = codec.encode(jsonData);
/// print(codec.decode(byteData)); // { 'a': 0 };
/// ```
class JsonToBytesCodec extends Codec<Object, List<int>> {
  /// Creates a codec to convert between JSON objects and byte data.
  const JsonToBytesCodec();

  @override
  Converter<List<int>, Object> get decoder => const JsonToBytesDecoder();

  @override
  Converter<Object, List<int>> get encoder => const JsonToBytesEncoder();
}

/// JSON to Bytes Encoder
/// ------------------------------------------------------------------------------------------------

/// An encoder that converts `JSON objects` to `byte data`.
///
/// ```
/// const encoder = JsonToBytesEncoder();
/// final jsonData = { 'a': 0 };
/// final byteData = encoder.convert(jsonData);
/// print(byteData); // [123, 34, 97, 34, 58, 48, 125]
/// ```
class JsonToBytesEncoder extends Converter<Object, List<int>> {
  /// Creates an encoder to convert JSON objects to byte data.
  const JsonToBytesEncoder();

  @override
  List<int> convert(final Object input) => utf8.encode(json.encode(input));
}

/// JSON to Bytes Decoder
/// ------------------------------------------------------------------------------------------------

/// An decoder that converts `byte data` to `JSON objects`.
///
/// ```
/// const decoder = JsonToBytesDecoder();
/// final byteData = [123, 34, 97, 34, 58, 48, 125];
/// final jsonData = decoder.convert(byteData);
/// print(jsonData); // { 'a': 0 }
/// ```
class JsonToBytesDecoder extends Converter<List<int>, Object> {
  /// Creates a decoder to convert byte data to JSON objects.
  const JsonToBytesDecoder();

  @override
  Object convert(final List<int> input) => json.decode(utf8.decode(input));
}
