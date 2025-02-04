/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'dart:typed_data' show Uint8List;
import 'package:json_annotation/json_annotation.dart' show JsonConverter;

/// Uint8 List Json Converter
/// ------------------------------------------------------------------------------------------------

class Uint8ListJsonConverter extends JsonConverter<Uint8List, List<int>> {
  /// JSON encodes [Uint8List]s.
  const Uint8ListJsonConverter();

  @override
  Uint8List fromJson(final List<int> json) => Uint8List.fromList(json);

  @override
  List<int> toJson(final Uint8List object) => object;
}
