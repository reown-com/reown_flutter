/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../converters/codec.dart';
import '../mixins/codec_fixed_sized.dart';

/// Types
/// ------------------------------------------------------------------------------------------------

/// A Rust tuple.
typedef Tuple = List;

/// Class property to codec mapping.
typedef BorshSchema = Map<String, BorshCodec>;

/// Class property to codec mapping for sized data types.
typedef BorshSchemaSized = Map<String, BorshCodecFixedSized>;
