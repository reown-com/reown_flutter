import 'dart:convert' show Codec, Converter, base64;
import 'package:reown_core/reown_core.dart';

/// Base-58 to Base-64 Codec
/// ------------------------------------------------------------------------------------------------

/// Converts a base-58 encoded string to/from a base-64 encoded string.
const base58To64 = Base58To64Codec();

/// Converts a base-58 encoded string to base-64.
String base58To64Encode(final String base58) => base58To64.encode(base58);

/// Converts a base-64 encoded string to base-58.
String base58To64Decode(final String base64) => base58To64.decode(base64);

/// Converts a base-58 encoded string to/from a base-64 encoded string.
class Base58To64Codec extends Codec<String, String> {
  /// Creates a codec to convert base-58 encoded strings to/from base-64 encoded strings.
  const Base58To64Codec();

  @override
  Converter<String, String> get decoder => const Base58To64Decoder();

  @override
  Converter<String, String> get encoder => const Base58To64Encoder();
}

/// Base-58 to Base-64 Encoder
/// ------------------------------------------------------------------------------------------------

/// Converts a base-58 encoded string to base-64.
class Base58To64Encoder extends Converter<String, String> {
  /// Creates an encoder to convert base-58 encoded strings to base-64.
  const Base58To64Encoder();

  @override
  String convert(final String input) => base64.encode(base58.decode(input));
}

/// Base-58 to Base-64 Decoder
/// ------------------------------------------------------------------------------------------------

/// Converts a base-64 encoded string to base-58.
class Base58To64Decoder extends Converter<String, String> {
  /// Creates an decoder to convert base-64 encoded strings to base-58.
  const Base58To64Decoder();

  @override
  String convert(final String input) => base58.encode(base64.decode(input));
}
