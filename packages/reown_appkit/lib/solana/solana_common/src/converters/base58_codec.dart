/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'dart:typed_data' show Uint8List;

import 'package:reown_core/reown_core.dart';
// import 'package:base_codecs/base_codecs.dart' show Base58CodecBitcoin;

/// Base-58 Codec
/// ------------------------------------------------------------------------------------------------

// /// A base-58 codec.
// const base58 = Base58CodecBitcoin();

/// Encodes [input] to a base-58 string.
String base58Encode(final Uint8List input) => base58.encode(input);

/// Decodes a base-58 [encoded] string.
Uint8List base58Decode(final String encoded) => base58.decode(encoded);
