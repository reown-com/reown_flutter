/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../models/serializable.dart';

/// Iterable Serializable Extension
/// ------------------------------------------------------------------------------------------------

extension IterableSerializable on Iterable<SerializableMixin> {
  /// Creates a list of [Serializable] objects from [json].
  static List<T> fromJson<T extends SerializableMixin, U>(
    final Iterable json,
    T Function(U) decode,
  ) =>
      json.cast<U>().map(decode).toList(growable: true);

  /// Creates a list of [Serializable] objects from [json].
  ///
  /// Returns null if [json] is ommited.
  static List<T>? tryFromJson<T extends SerializableMixin, U>(
    final Iterable? json,
    T Function(U) decode,
  ) =>
      json != null ? fromJson(json, decode) : null;

  /// Serializes this lists into a list of JSON data.
  List<T> toJson<T>() =>
      map<T>((final SerializableMixin object) => object.toJson())
          .toList(growable: false);
}
