/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../annotations/annotation.dart';

/// Map
/// ------------------------------------------------------------------------------------------------

/// An annotation for map data types.
///
/// ```
/// @BorshMap(BorshString(), BorshInt64())
/// final Map<String, int> property;
/// ```
class BorshMap<K, V> extends BorshAnnotation<Map<K, V>> {
  /// Creates an annotation for a map data type.
  const BorshMap(this.keySubtype, this.valueSubtype);

  /// The key data type's annotation.
  final BorshAnnotation<K> keySubtype;

  /// The value data type's annotation.
  final BorshAnnotation<V> valueSubtype;
}
