/// Import
/// ------------------------------------------------------------------------------------------------
library;

import '../codecs/option_sized.dart';
import '../converters/codec.dart';
import '../models/option_type.dart';

/// Codec Fixed Sized
/// ------------------------------------------------------------------------------------------------

/// Adds a [byteLength] property to [BorshCodec]s for data types with a known max size.
mixin BorshCodecFixedSized<T> on BorshCodec<T> {
  /// The number of bytes required to store `any` instance of [T] (i.e. max size).
  int get byteLength;

  /// Converts this codec to an option code of type [T].
  BorshOptionSizedCodec<T> option() =>
      BorshOptionSizedCodec<T>(this, BorshOptionType.rust);

  /// Converts this codec to an c-option code of type [T].
  BorshOptionSizedCodec<T> cOption() =>
      BorshOptionSizedCodec<T>(this, BorshOptionType.c);
}
