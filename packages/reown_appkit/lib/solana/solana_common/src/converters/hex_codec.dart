/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'dart:typed_data' show Uint8List;

import 'package:convert/convert.dart';
// import 'package:base_codecs/base_codecs.dart' show Base16Codec;

/// Hex (Base-16) Codec
/// ------------------------------------------------------------------------------------------------

// /// A hexadecimal codec.
// const hex = Base16Codec();

/// Encodes [input] to a hexadecimal string.
String hexEncode(final Uint8List input) => hex.encode(input);

/// Decodes a hexadecimal [encoded] string.
Uint8List hexDecode(final String encoded) =>
    Uint8List.fromList(hex.decode(encoded));
