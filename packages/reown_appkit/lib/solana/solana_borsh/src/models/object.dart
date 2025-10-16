/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/models.dart'
    show SerializableMixin;
import '../../borsh.dart';
import '../codecs/struct_typed.dart';
import '../converters/codec.dart';
import '../utils/types.dart';

/// Borsh Object
/// ------------------------------------------------------------------------------------------------

abstract class BorshObject with BorshObjectMixin {
  /// Creates a class that can be serialised into a buffer.
  ///
  /// # Example
  /// ```
  /// class Struct extends BorshObject {
  ///
  /// const Struct({
  ///   required this.i8,
  ///   required this.u64,
  ///   required this.string,
  ///   required this.array,
  ///   required this.vec,
  ///   required this.map,
  ///   required this.option,
  /// });
  ///
  /// final int i8;
  /// final BigInt u64;
  /// final String string;
  /// final List<int> array;
  /// final List<BigInt> vec;
  /// final Map<String, String> map;
  /// final int? option;
  ///
  /// static final BorshStructCodec codec = borsh.struct({
  ///   'i8': borsh.i8,
  ///   'u64': borsh.u64,
  ///   'string': borsh.string,
  ///   'array': borsh.array(borsh.u32, 4),
  ///   'vec': borsh.vec(borsh.u64),
  ///   'map': borsh.map(borsh.string, borsh.string),
  ///   'option': borsh.u32.option(),
  /// });
  ///
  /// @override
  /// BorshSchema get schema => codec.schema;
  ///
  /// @override
  /// Map<String, dynamic> toJson() => {
  ///   'i8': i8,
  ///   'u64': u64,
  ///   'string': string,
  ///   'array': array,
  ///   'vec': vec,
  ///   'map': map,
  ///   'option': option,
  /// };
  /// ```
  const BorshObject();
}

/// Borsh Object
/// ------------------------------------------------------------------------------------------------

/// A [BorshObject] for fixed size data types.
abstract class BorshObjectSized extends BorshObject with BorshObjectSizedMixin {
  const BorshObjectSized();
}

/// Borsh Object Mixin
/// ------------------------------------------------------------------------------------------------

mixin BorshObjectMixin implements SerializableMixin {
  /// Creates an [UnimplementedError].
  static UnimplementedError _unimplementedError(final String method) =>
      UnimplementedError(
        'Derived classes of [BorshObjectMixin] must implement $method',
      );

  /// {@template solana_borsh.BorshObject.fromBorsh}
  /// Creates an instance of `this` class from a buffer.
  /// {@endtemplate}
  static T fromBorsh<T extends BorshObjectMixin>(final Iterable<int> buffer) =>
      throw _unimplementedError('fromBorsh');

  /// {@template solana_borsh.BorshObject.tryFromBorsh}
  /// Creates an instance of `this` class from a buffer.
  ///
  /// Returns `null` if [buffer] is omitted.
  /// {@endtemplate}
  static T? tryFromBorsh<T extends BorshObjectMixin>(
    final Iterable<int>? buffer,
  ) => throw _unimplementedError('tryFromBorsh');

  /// {@template solana_borsh.BorshObject.fromBorshBase64}
  /// Creates an instance of `this` class from a base-64 encoded string.
  /// {@endtemplate}
  static T fromBorshBase64<T extends BorshObjectMixin>(final String encoded) =>
      throw _unimplementedError('fromBorshBase64');

  /// {@template solana_borsh.BorshObject.tryFromBorshBase64}
  /// Creates an instance of `this` class from a base-64 encoded string.
  ///
  /// Returns `null` if [encoded] is omitted.
  /// {@endtemplate}
  static T? tryFromBorshBase64<T extends BorshObjectMixin>(
    final String? encoded,
  ) => throw _unimplementedError('tryFromBorshBase64');

  /// Serializes `this` instance into a buffer.
  Iterable<int> toBorsh() => borsh.serialize(this);

  /// {@template solana_borsh.BorshObject.borshCodec}
  /// The encoders/decoders of `this` class' properties.
  /// {@endtemplate}
  static BorshStructTypedCodec get borshCodec =>
      throw _unimplementedError('borshCodec');

  /// Maps `this` class' properties to codecs.
  BorshSchema get borshSchema;

  /// Returns the serialized byte length of `this` instance.
  ///
  /// # Example
  /// ```
  /// class Data extends BorshObject {
  ///
  ///   const Data(this.counter);
  ///
  ///   final BigInt? counter;
  ///
  ///   factory Data.deserialize(final Map<String, dynamic> json)
  ///     => Data(json['counter']);
  ///
  ///   static final BorshStructCodec borshCodec = BorshStructCodec({
  ///     'counter': borsh.u64.option(),
  ///   });
  ///
  ///   @override
  ///   BorshSchema get borshSchema => borshCodec.schema;
  ///
  ///   @override
  ///   Map<String, dynamic> toJson() => {
  ///     'counter': counter,
  ///   };
  /// }
  ///
  /// const Data data0 = Data(null);
  /// print('Optional type with `null` value:');            // Optional type with `null` value:
  /// print(' - Buffer length ${data0.toBorsh().length}');  //  - Buffer length 1
  /// print(' - Instance size ${data0.borshSize()}');       //  - Instance size 1
  ///
  /// final Data data1 = Data(BigInt.zero);
  /// print('Optional type with `set` value:');             // Optional type with `set` value:
  /// print(' - Buffer length ${data1.toBorsh().length}');  //  - Buffer length 9
  /// print(' - Instance size ${data1.borshSize()}');       //  - Instance size 9
  /// ```
  int borshSize() {
    int size = 0;
    final Map<String, dynamic> json = toJson();
    for (final MapEntry<String, BorshCodec> entry in borshSchema.entries) {
      final BorshCodec codec = entry.value;
      final dynamic value = json[entry.key];
      size += codec.size(value);
    }
    return size;
  }
}

/// Borsh Object Sized Mixin
/// ------------------------------------------------------------------------------------------------

/// A [BorshObjectMixin] for fixed size data types.
mixin BorshObjectSizedMixin implements BorshObjectMixin {
  @override
  BorshSchemaSized get borshSchema;

  /// The serialized byte length required to store any instance of this class (i.e. max size).
  ///
  /// # Example
  /// ```
  /// class Data extends BorshObjectSized {
  ///
  ///   const Data(this.counter);
  ///
  ///   final BigInt? counter;
  ///
  ///   factory Data.deserialize(final Map<String, dynamic> json)
  ///     => Data(json['counter']);
  ///
  ///   static final BorshStructSizedCodec borshCodec = BorshStructSizedCodec({
  ///     'counter': borsh.u64.option(),
  ///   });
  ///
  ///   @override
  ///   BorshSchemaSized get borshSchema => borshCodec.schema;
  ///
  ///   @override
  ///   Map<String, dynamic> toJson() => {
  ///     'counter': counter,
  ///   };
  /// }
  ///
  /// const Data data0 = Data(null);
  /// print('Optional type with `null` value:');      // Optional type with `null` value:
  /// print(' - Buffer length ${data0.borshSize()}'); //  - Buffer length 1
  /// print(' - Class size ${data0.borshSpace()}');   //  - Class size 9
  ///
  /// final Data data1 = Data(BigInt.zero);
  /// print('Optional type with `set` value:');       // Optional type with `set` value:
  /// print(' - Buffer length ${data1.borshSize()}'); //  - Buffer length 9
  /// print(' - Class size ${data1.borshSpace()}');   //  - Class size 9
  /// ```
  int borshSpace() =>
      borshSchema.values.fold(0, (total, codec) => codec.byteLength);
}
