/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_buffer/buffer.dart';
import '../converters/codec.dart';
import '../converters/decoder.dart';
import '../converters/encoder.dart';
import '../mixins/codec_fixed_sized.dart';
import '../mixins/encoder_fixed_sized.dart';

/// Date Time Codec
/// ------------------------------------------------------------------------------------------------

/// A codec for date time data types.
class BorshDateTimeCodec extends BorshCodec<DateTime>
    with BorshCodecFixedSized {
  /// Creates a codec for date time data types.
  const BorshDateTimeCodec();

  @override
  int get byteLength => ByteLength.i64;

  @override
  BorshEncoder<DateTime> get encoder => const BorshDateTimeEncoder();

  @override
  BorshDecoder<DateTime> get decoder => const BorshDateTimeDecoder();

  @override
  int size(final DateTime input) => byteLength;
}

/// Date Time Encoder
/// ------------------------------------------------------------------------------------------------

/// An encoder for date time data types.
class BorshDateTimeEncoder extends BorshEncoder<DateTime>
    with BorshEncoderFixedSized {
  /// Creates an encoder for date time data types.
  const BorshDateTimeEncoder();

  @override
  int get byteLength => ByteLength.i64;

  @override
  void pack(final BufferWriter buffer, final DateTime input) =>
      buffer.setDateTime(input);
}

/// Date Time Decoder
/// ------------------------------------------------------------------------------------------------

/// A decoder for date time data types.
class BorshDateTimeDecoder extends BorshDecoder<DateTime> {
  /// Creates a decoder for date time data types.
  const BorshDateTimeDecoder();

  @override
  DateTime unpack(final BufferReader buffer) => buffer.getDateTime();
}
