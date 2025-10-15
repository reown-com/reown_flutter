/// Serializable
/// ------------------------------------------------------------------------------------------------
library;

/// A JSON serializable object.
abstract class Serializable with SerializableMixin {
  /// Creates a class that can be serialised into a JSON object.
  const Serializable();
}

/// Serializable Mixin
/// ------------------------------------------------------------------------------------------------

/// A JSON serializable object mixin.
mixin SerializableMixin {
  /// Creates an [UnimplementedError] for missing [method] implementations.
  static UnimplementedError _unimplementedError(final String method) =>
      UnimplementedError(
        'Derived classes of [SerializableMixin] must implement [$method].',
      );

  /// {@template solana_common.Serializable.fromJson}
  /// Creates an instance of `this` class from the constructor parameters defined in the [json]
  /// object.
  ///
  /// # Example
  /// ```
  /// class Item extends Serializable {
  ///   const(this.name, this.count);
  ///   final String name;
  ///   final int? count;
  /// }
  ///
  /// final Item x = Item.fromJson({
  ///   'name': 'apple',
  ///   'count': 10,
  /// });
  /// ```
  /// {@endtemplate}
  static Object fromJson(final dynamic json) =>
      throw _unimplementedError('fromJson');

  /// {@template solana_common.Serializable.tryFromJson}
  /// Creates an instance of `this` class from the constructor parameters defined in the [json]
  /// object.
  ///
  /// Returns `null` if [json] is omitted.
  ///
  /// # Example
  /// ```
  /// class Item extends Serializable {
  ///   const(this.name, this.count);
  ///   final String name;
  ///   final int? count;
  /// }
  ///
  /// final Item x = Item.tryFromJson({
  ///   'name': 'apple',
  ///   'count': 10,
  /// });
  /// ```
  /// {@endtemplate}
  static Object? tryFromJson(final dynamic json) =>
      _unimplementedError('tryFromJson');

  /// {@template solana_common.Serializable.toJson}
  /// Serialises `this` class into a JSON object.
  ///
  /// ```
  /// class Item extends Serializable {
  ///   const(this.name, this.count);
  ///   final String name;
  ///   final int? count;
  /// }
  ///
  /// final Item x = Item('apple', 10);
  /// print(x.toJson()); // { 'name': 'apple', 'count': 10 }
  /// ```
  /// {@endtemplate}
  dynamic toJson();
}
