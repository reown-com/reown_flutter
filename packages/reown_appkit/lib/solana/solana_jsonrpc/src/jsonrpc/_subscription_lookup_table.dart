// /// Imports
// /// ------------------------------------------------------------------------------------------------

// import 'dart:math' as math show min;
// import 'package:flutter/foundation.dart' show listEquals;

// /// Multi Key
// /// ------------------------------------------------------------------------------------------------

// /// A list of keys that can be used to associate many keys with a single value.
// class MultiKey<K> extends Iterable<K> {

//   /// Creates a list to store multiple keys associated with a single value.
//   MultiKey(
//     final Iterable<K> keys,
//   ):  assert(keys.length > 1, '[MultiKey] invalid `keys` length, must be greater than 1.'),
//       _keys = List.unmodifiable(keys);

//   /// The keys.
//   final List<K> _keys;

//   /// The number of keys.
//   @override
//   int get length => _keys.length;

//   /// Returns the key at [index].
//   K? operator [](final int index) => _keys[index];

//   /// Returns true if [key] exists in the [MultiKey].
//   ///
//   /// ```
//   /// final multiKey = MultiKey([1, 2, 3]);
//   /// print(multiKey.contains(1));              // true;
//   /// print(multiKey.contains(4));              // false;
//   /// ```
//   @override
//   bool contains(final dynamic key) => _keys.contains(key);

//   /// Returns true if [key] matched the key and [index] in the [MultiKey].
//   ///
//   /// ```
//   /// final multiKey = MultiKey([1, 2, 3]);
//   /// print(multiKey.containsAt(1, index: 0));  // true;
//   /// print(multiKey.containsAt(1, index: 1));  // false;
//   /// ```
//   bool containsAt(final dynamic key, { required final int index }) => _keys[index] == key;

//   /// Returns true if [key] contains a duplicate value at the same index.
//   ///
//   /// ```
//   /// final multiKey1 = MultiKey([1, 2, 3]);
//   /// final multiKey2 = MultiKey([2, 3, 1]);
//   /// final multiKey3 = MultiKey([3, 1, 2]);
//   /// final multiKey4 = MultiKey([0, 0, 3]);
//   ///
//   /// print(multiKey1.duplicate(multiKey2));    // false;
//   /// print(multiKey3.duplicate(multiKey4));    // false;
//   /// print(multiKey1.duplicate(multiKey4));    // true;
//   /// ```
//   bool duplicate(final MultiKey key) {
//     final int length = math.min(key.length, this.length);
//     for (int i = 0; i < length; ++i) {
//       if (key[i] == _keys[i]) {
//         return true;
//       }
//     }
//     return false;
//   }

//   @override
//   int get hashCode => _keys.hashCode;

//   @override
//   bool operator ==(final dynamic other)
//     => other is MultiKey && listEquals(other._keys, _keys);

//   @override
//   Iterator<K> get iterator => _keys.iterator;

//   @override
//   String toString() => _keys.toString();
// }

// /// Json Rpc Subscription Lookup Table
// /// ------------------------------------------------------------------------------------------------

// /// Creates a lookup table that associates many keys with a single value of type T.
// ///
// /// ```
// /// final lookup = JsonRpcSubscriptionLookupTable();
// /// lookup[MultiKey([1, 'four'])] = 'Test';   // Map the keys 1 and 'four' to the value 'Test'.
// /// print(lookup[1]);                         // 'Test'
// /// print(lookup['four']);                    // 'Test'
// /// ```
// class JsonRpcSubscriptionLookupTable<K extends MultiKey, V> {

//   /// The lookup table.
//   final Map<K, V> _table = {};

//   /// Returns `true` if the lookup table contains no entries.
//   bool get isEmpty => _table.isEmpty;

//   /// Returns `true` if the lookup table contains at least one entry.
//   bool get isNotEmpty => _table.isNotEmpty;

//   /// Returns the first entry that satisfies the given [predicate] or `null`.
//   MapEntry<K, V>? _find<T>(final bool Function(K) predicate) {
//     for (final MapEntry<K, V> entry in _table.entries.toList(growable: false)) {
//       if (predicate(entry.key)) {
//         return entry;
//       }
//     }
//     return null;
//   }

//   /// The number of key/value pairs in the lookup table.
//   int get length => _table.length;

//   /// The keys.
//   Iterable<K> get keys => _table.keys;

//   /// The values.
//   Iterable<V> get values => _table.values;

//   /// Remove all entries in the lookup table.
//   void clear() => _table.clear();

//   /// Returns the value associated with [key].
//   ///
//   /// ```
//   /// final lookup = JsonRpcSubscriptionLookupTable();
//   ///
//   /// final key = MultiKey(['a', 'b', 'c']);
//   /// lookup[key] = 1000;
//   ///
//   /// print(lookup['a']);                       // 1000
//   /// print(lookup['b']);                       // 1000
//   /// print(lookup['d']);                       // null
//   /// ```
//   V? operator [](final dynamic key) {
//     predicate(final K multiKey) => multiKey.contains(key);
//     return _find(predicate)?.value;
//   }

//   /// Returns the value associated with [key] at the column [index].
//   ///
//   /// ```
//   /// final lookup = JsonRpcSubscriptionLookupTable();
//   ///
//   /// final key = MultiKey(['a', 'b', 'c']);
//   /// lookup[key] = 1000;
//   ///
//   /// print(lookup['a']);                       // 1000
//   /// print(lookup['b']);                       // 1000
//   /// print(lookup['e']);                       // null
//   /// ```
//   V? at(final dynamic key, { required final int index }) {
//     predicate(final K multiKey) => multiKey.containsAt(key, index: index);
//     return _find(predicate)?.value;
//   }

//   /// Associates the [key] with [value].
//   ///
//   /// ```
//   /// final lookup = JsonRpcSubscriptionLookupTable();
//   ///
//   /// final key = MultiKey(['a', 'b', 'c']);
//   /// lookup[key] = 1000;
//   ///
//   /// print(lookup['a']);                       // 1000
//   /// print(lookup['b']);                       // 1000
//   /// print(lookup['c']);                       // 1000
//   /// ```
//   void operator []=(final K key, final V value) {
//     predicate(final K multiKey) => multiKey.duplicate(key);
//     final K? tableKey = _find(predicate)?.key;
//     assert(tableKey == null || tableKey == key, 'The [MultiKey] $key overlaps with an existing key.');
//     _table[tableKey ?? key] = value;
//   }

//   /// Removes a [MultiKey] and its associated value from the lookup table.
//   ///
//   /// Returns the value associated with [key] before it was removed.
//   ///
//   /// Returns null if [key] was not in the lookup table.
//   ///
//   /// ```
//   /// final lookup = JsonRpcSubscriptionLookupTable();
//   ///
//   /// final key = MultiKey(['a', 'b', 'c']);
//   /// lookup[key] = 1000;
//   ///
//   /// print(lookup.remove('a'));                // 1000
//   /// print(lookup.remove('b'));                // null
//   /// print(lookup.remove('c'));                // null
//   /// ```
//   V? remove(final dynamic key) {
//     predicate(final K multiKey) => multiKey.contains(key);
//     return _table.remove(_find(predicate)?.key);
//   }

//   /// Removes a [MultiKey] and its associated value from the lookup table. The lookup is performed
//   /// on the column [index] only.
//   ///
//   /// Returns the value associated with [key] at column [index], before it was removed.
//   ///
//   /// Returns null if [key] at columns [index] was not in the lookup table.
//   ///
//   /// ```
//   /// final lookup = JsonRpcSubscriptionLookupTable();  //   0    1    2
//   /// lookup[MultiKey(['a', 'b', 'c'])] = 1000; // ['a', 'b', 'c'] => 1000
//   /// lookup[MultiKey(['x', 'y', 'z'])] = 2000; // ['x', 'y', 'z'] => 2000
//   ///
//   /// print(lookup.removeAt('c', index: 0));    // null
//   /// print(lookup.removeAt('c', index: 1));    // null
//   /// print(lookup.removeAt('c', index: 2));    // 1000
//   /// ```
//   V? removeAt(final dynamic key, { required final int index }) {
//     predicate(final K multiKey) => multiKey[index] == key;
//     return _table.remove(_find(predicate)?.key);
//   }

//   /// Removes all entries from the lookup table and returns the associated values in the order of
//   /// their corresponding keys.
//   ///
//   /// ```
//   /// final lookup = JsonRpcSubscriptionLookupTable();
//   /// lookup[MultiKey(['a', 'b', 'c'])] = 1000;
//   /// lookup[MultiKey(['x', 'y', 'z'])] = 2000;
//   ///
//   /// print(lookup.removeAll());  // [1000, 2000]
//   /// print(lookup);              // {}
//   /// ```
//   List<V> removeAll() {
//     final List<V> values = _table.values.toList(growable: false);
//     _table.clear();
//     return values;
//   }

//   @override
//   String toString() => _table.toString();
// }
