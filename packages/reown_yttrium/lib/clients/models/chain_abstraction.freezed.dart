// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chain_abstraction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AmountCompat {

 String get symbol; String get amount; int get unit; String get formatted; String get formattedAlt;
/// Create a copy of AmountCompat
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AmountCompatCopyWith<AmountCompat> get copyWith => _$AmountCompatCopyWithImpl<AmountCompat>(this as AmountCompat, _$identity);

  /// Serializes this AmountCompat to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AmountCompat&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.formatted, formatted) || other.formatted == formatted)&&(identical(other.formattedAlt, formattedAlt) || other.formattedAlt == formattedAlt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,amount,unit,formatted,formattedAlt);

@override
String toString() {
  return 'AmountCompat(symbol: $symbol, amount: $amount, unit: $unit, formatted: $formatted, formattedAlt: $formattedAlt)';
}


}

/// @nodoc
abstract mixin class $AmountCompatCopyWith<$Res>  {
  factory $AmountCompatCopyWith(AmountCompat value, $Res Function(AmountCompat) _then) = _$AmountCompatCopyWithImpl;
@useResult
$Res call({
 String symbol, String amount, int unit, String formatted, String formattedAlt
});




}
/// @nodoc
class _$AmountCompatCopyWithImpl<$Res>
    implements $AmountCompatCopyWith<$Res> {
  _$AmountCompatCopyWithImpl(this._self, this._then);

  final AmountCompat _self;
  final $Res Function(AmountCompat) _then;

/// Create a copy of AmountCompat
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? symbol = null,Object? amount = null,Object? unit = null,Object? formatted = null,Object? formattedAlt = null,}) {
  return _then(_self.copyWith(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as int,formatted: null == formatted ? _self.formatted : formatted // ignore: cast_nullable_to_non_nullable
as String,formattedAlt: null == formattedAlt ? _self.formattedAlt : formattedAlt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AmountCompat].
extension AmountCompatPatterns on AmountCompat {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AmountCompat value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AmountCompat() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AmountCompat value)  $default,){
final _that = this;
switch (_that) {
case _AmountCompat():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AmountCompat value)?  $default,){
final _that = this;
switch (_that) {
case _AmountCompat() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String symbol,  String amount,  int unit,  String formatted,  String formattedAlt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AmountCompat() when $default != null:
return $default(_that.symbol,_that.amount,_that.unit,_that.formatted,_that.formattedAlt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String symbol,  String amount,  int unit,  String formatted,  String formattedAlt)  $default,) {final _that = this;
switch (_that) {
case _AmountCompat():
return $default(_that.symbol,_that.amount,_that.unit,_that.formatted,_that.formattedAlt);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String symbol,  String amount,  int unit,  String formatted,  String formattedAlt)?  $default,) {final _that = this;
switch (_that) {
case _AmountCompat() when $default != null:
return $default(_that.symbol,_that.amount,_that.unit,_that.formatted,_that.formattedAlt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AmountCompat implements AmountCompat {
  const _AmountCompat({required this.symbol, required this.amount, required this.unit, required this.formatted, required this.formattedAlt});
  factory _AmountCompat.fromJson(Map<String, dynamic> json) => _$AmountCompatFromJson(json);

@override final  String symbol;
@override final  String amount;
@override final  int unit;
@override final  String formatted;
@override final  String formattedAlt;

/// Create a copy of AmountCompat
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AmountCompatCopyWith<_AmountCompat> get copyWith => __$AmountCompatCopyWithImpl<_AmountCompat>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AmountCompatToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AmountCompat&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.formatted, formatted) || other.formatted == formatted)&&(identical(other.formattedAlt, formattedAlt) || other.formattedAlt == formattedAlt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,symbol,amount,unit,formatted,formattedAlt);

@override
String toString() {
  return 'AmountCompat(symbol: $symbol, amount: $amount, unit: $unit, formatted: $formatted, formattedAlt: $formattedAlt)';
}


}

/// @nodoc
abstract mixin class _$AmountCompatCopyWith<$Res> implements $AmountCompatCopyWith<$Res> {
  factory _$AmountCompatCopyWith(_AmountCompat value, $Res Function(_AmountCompat) _then) = __$AmountCompatCopyWithImpl;
@override @useResult
$Res call({
 String symbol, String amount, int unit, String formatted, String formattedAlt
});




}
/// @nodoc
class __$AmountCompatCopyWithImpl<$Res>
    implements _$AmountCompatCopyWith<$Res> {
  __$AmountCompatCopyWithImpl(this._self, this._then);

  final _AmountCompat _self;
  final $Res Function(_AmountCompat) _then;

/// Create a copy of AmountCompat
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? symbol = null,Object? amount = null,Object? unit = null,Object? formatted = null,Object? formattedAlt = null,}) {
  return _then(_AmountCompat(
symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as int,formatted: null == formatted ? _self.formatted : formatted // ignore: cast_nullable_to_non_nullable
as String,formattedAlt: null == formattedAlt ? _self.formattedAlt : formattedAlt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$CallCompat {

 String get to; String get input; BigInt? get value;
/// Create a copy of CallCompat
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallCompatCopyWith<CallCompat> get copyWith => _$CallCompatCopyWithImpl<CallCompat>(this as CallCompat, _$identity);

  /// Serializes this CallCompat to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallCompat&&(identical(other.to, to) || other.to == to)&&(identical(other.input, input) || other.input == input)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,to,input,value);

@override
String toString() {
  return 'CallCompat(to: $to, input: $input, value: $value)';
}


}

/// @nodoc
abstract mixin class $CallCompatCopyWith<$Res>  {
  factory $CallCompatCopyWith(CallCompat value, $Res Function(CallCompat) _then) = _$CallCompatCopyWithImpl;
@useResult
$Res call({
 String to, String input, BigInt? value
});




}
/// @nodoc
class _$CallCompatCopyWithImpl<$Res>
    implements $CallCompatCopyWith<$Res> {
  _$CallCompatCopyWithImpl(this._self, this._then);

  final CallCompat _self;
  final $Res Function(CallCompat) _then;

/// Create a copy of CallCompat
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? to = null,Object? input = null,Object? value = freezed,}) {
  return _then(_self.copyWith(
to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String,input: null == input ? _self.input : input // ignore: cast_nullable_to_non_nullable
as String,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as BigInt?,
  ));
}

}


/// Adds pattern-matching-related methods to [CallCompat].
extension CallCompatPatterns on CallCompat {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CallCompat value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CallCompat() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CallCompat value)  $default,){
final _that = this;
switch (_that) {
case _CallCompat():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CallCompat value)?  $default,){
final _that = this;
switch (_that) {
case _CallCompat() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String to,  String input,  BigInt? value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CallCompat() when $default != null:
return $default(_that.to,_that.input,_that.value);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String to,  String input,  BigInt? value)  $default,) {final _that = this;
switch (_that) {
case _CallCompat():
return $default(_that.to,_that.input,_that.value);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String to,  String input,  BigInt? value)?  $default,) {final _that = this;
switch (_that) {
case _CallCompat() when $default != null:
return $default(_that.to,_that.input,_that.value);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CallCompat implements CallCompat {
  const _CallCompat({required this.to, required this.input, this.value});
  factory _CallCompat.fromJson(Map<String, dynamic> json) => _$CallCompatFromJson(json);

@override final  String to;
@override final  String input;
@override final  BigInt? value;

/// Create a copy of CallCompat
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CallCompatCopyWith<_CallCompat> get copyWith => __$CallCompatCopyWithImpl<_CallCompat>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CallCompatToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CallCompat&&(identical(other.to, to) || other.to == to)&&(identical(other.input, input) || other.input == input)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,to,input,value);

@override
String toString() {
  return 'CallCompat(to: $to, input: $input, value: $value)';
}


}

/// @nodoc
abstract mixin class _$CallCompatCopyWith<$Res> implements $CallCompatCopyWith<$Res> {
  factory _$CallCompatCopyWith(_CallCompat value, $Res Function(_CallCompat) _then) = __$CallCompatCopyWithImpl;
@override @useResult
$Res call({
 String to, String input, BigInt? value
});




}
/// @nodoc
class __$CallCompatCopyWithImpl<$Res>
    implements _$CallCompatCopyWith<$Res> {
  __$CallCompatCopyWithImpl(this._self, this._then);

  final _CallCompat _self;
  final $Res Function(_CallCompat) _then;

/// Create a copy of CallCompat
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? to = null,Object? input = null,Object? value = freezed,}) {
  return _then(_CallCompat(
to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String,input: null == input ? _self.input : input // ignore: cast_nullable_to_non_nullable
as String,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as BigInt?,
  ));
}


}


/// @nodoc
mixin _$Eip1559EstimationCompat {

 String get maxFeePerGas; String get maxPriorityFeePerGas;
/// Create a copy of Eip1559EstimationCompat
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Eip1559EstimationCompatCopyWith<Eip1559EstimationCompat> get copyWith => _$Eip1559EstimationCompatCopyWithImpl<Eip1559EstimationCompat>(this as Eip1559EstimationCompat, _$identity);

  /// Serializes this Eip1559EstimationCompat to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Eip1559EstimationCompat&&(identical(other.maxFeePerGas, maxFeePerGas) || other.maxFeePerGas == maxFeePerGas)&&(identical(other.maxPriorityFeePerGas, maxPriorityFeePerGas) || other.maxPriorityFeePerGas == maxPriorityFeePerGas));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxFeePerGas,maxPriorityFeePerGas);

@override
String toString() {
  return 'Eip1559EstimationCompat(maxFeePerGas: $maxFeePerGas, maxPriorityFeePerGas: $maxPriorityFeePerGas)';
}


}

/// @nodoc
abstract mixin class $Eip1559EstimationCompatCopyWith<$Res>  {
  factory $Eip1559EstimationCompatCopyWith(Eip1559EstimationCompat value, $Res Function(Eip1559EstimationCompat) _then) = _$Eip1559EstimationCompatCopyWithImpl;
@useResult
$Res call({
 String maxFeePerGas, String maxPriorityFeePerGas
});




}
/// @nodoc
class _$Eip1559EstimationCompatCopyWithImpl<$Res>
    implements $Eip1559EstimationCompatCopyWith<$Res> {
  _$Eip1559EstimationCompatCopyWithImpl(this._self, this._then);

  final Eip1559EstimationCompat _self;
  final $Res Function(Eip1559EstimationCompat) _then;

/// Create a copy of Eip1559EstimationCompat
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? maxFeePerGas = null,Object? maxPriorityFeePerGas = null,}) {
  return _then(_self.copyWith(
maxFeePerGas: null == maxFeePerGas ? _self.maxFeePerGas : maxFeePerGas // ignore: cast_nullable_to_non_nullable
as String,maxPriorityFeePerGas: null == maxPriorityFeePerGas ? _self.maxPriorityFeePerGas : maxPriorityFeePerGas // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Eip1559EstimationCompat].
extension Eip1559EstimationCompatPatterns on Eip1559EstimationCompat {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Eip1559EstimationCompat value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Eip1559EstimationCompat() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Eip1559EstimationCompat value)  $default,){
final _that = this;
switch (_that) {
case _Eip1559EstimationCompat():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Eip1559EstimationCompat value)?  $default,){
final _that = this;
switch (_that) {
case _Eip1559EstimationCompat() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String maxFeePerGas,  String maxPriorityFeePerGas)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Eip1559EstimationCompat() when $default != null:
return $default(_that.maxFeePerGas,_that.maxPriorityFeePerGas);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String maxFeePerGas,  String maxPriorityFeePerGas)  $default,) {final _that = this;
switch (_that) {
case _Eip1559EstimationCompat():
return $default(_that.maxFeePerGas,_that.maxPriorityFeePerGas);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String maxFeePerGas,  String maxPriorityFeePerGas)?  $default,) {final _that = this;
switch (_that) {
case _Eip1559EstimationCompat() when $default != null:
return $default(_that.maxFeePerGas,_that.maxPriorityFeePerGas);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Eip1559EstimationCompat implements Eip1559EstimationCompat {
  const _Eip1559EstimationCompat({required this.maxFeePerGas, required this.maxPriorityFeePerGas});
  factory _Eip1559EstimationCompat.fromJson(Map<String, dynamic> json) => _$Eip1559EstimationCompatFromJson(json);

@override final  String maxFeePerGas;
@override final  String maxPriorityFeePerGas;

/// Create a copy of Eip1559EstimationCompat
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$Eip1559EstimationCompatCopyWith<_Eip1559EstimationCompat> get copyWith => __$Eip1559EstimationCompatCopyWithImpl<_Eip1559EstimationCompat>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$Eip1559EstimationCompatToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Eip1559EstimationCompat&&(identical(other.maxFeePerGas, maxFeePerGas) || other.maxFeePerGas == maxFeePerGas)&&(identical(other.maxPriorityFeePerGas, maxPriorityFeePerGas) || other.maxPriorityFeePerGas == maxPriorityFeePerGas));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxFeePerGas,maxPriorityFeePerGas);

@override
String toString() {
  return 'Eip1559EstimationCompat(maxFeePerGas: $maxFeePerGas, maxPriorityFeePerGas: $maxPriorityFeePerGas)';
}


}

/// @nodoc
abstract mixin class _$Eip1559EstimationCompatCopyWith<$Res> implements $Eip1559EstimationCompatCopyWith<$Res> {
  factory _$Eip1559EstimationCompatCopyWith(_Eip1559EstimationCompat value, $Res Function(_Eip1559EstimationCompat) _then) = __$Eip1559EstimationCompatCopyWithImpl;
@override @useResult
$Res call({
 String maxFeePerGas, String maxPriorityFeePerGas
});




}
/// @nodoc
class __$Eip1559EstimationCompatCopyWithImpl<$Res>
    implements _$Eip1559EstimationCompatCopyWith<$Res> {
  __$Eip1559EstimationCompatCopyWithImpl(this._self, this._then);

  final _Eip1559EstimationCompat _self;
  final $Res Function(_Eip1559EstimationCompat) _then;

/// Create a copy of Eip1559EstimationCompat
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? maxFeePerGas = null,Object? maxPriorityFeePerGas = null,}) {
  return _then(_Eip1559EstimationCompat(
maxFeePerGas: null == maxFeePerGas ? _self.maxFeePerGas : maxFeePerGas // ignore: cast_nullable_to_non_nullable
as String,maxPriorityFeePerGas: null == maxPriorityFeePerGas ? _self.maxPriorityFeePerGas : maxPriorityFeePerGas // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$ErrorCompat {

 String get message;
/// Create a copy of ErrorCompat
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorCompatCopyWith<ErrorCompat> get copyWith => _$ErrorCompatCopyWithImpl<ErrorCompat>(this as ErrorCompat, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ErrorCompat&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ErrorCompat(message: $message)';
}


}

/// @nodoc
abstract mixin class $ErrorCompatCopyWith<$Res>  {
  factory $ErrorCompatCopyWith(ErrorCompat value, $Res Function(ErrorCompat) _then) = _$ErrorCompatCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ErrorCompatCopyWithImpl<$Res>
    implements $ErrorCompatCopyWith<$Res> {
  _$ErrorCompatCopyWithImpl(this._self, this._then);

  final ErrorCompat _self;
  final $Res Function(ErrorCompat) _then;

/// Create a copy of ErrorCompat
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,}) {
  return _then(_self.copyWith(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ErrorCompat].
extension ErrorCompatPatterns on ErrorCompat {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ErrorCompat_General value)?  general,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ErrorCompat_General() when general != null:
return general(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ErrorCompat_General value)  general,}){
final _that = this;
switch (_that) {
case ErrorCompat_General():
return general(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ErrorCompat_General value)?  general,}){
final _that = this;
switch (_that) {
case ErrorCompat_General() when general != null:
return general(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String message)?  general,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ErrorCompat_General() when general != null:
return general(_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String message)  general,}) {final _that = this;
switch (_that) {
case ErrorCompat_General():
return general(_that.message);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String message)?  general,}) {final _that = this;
switch (_that) {
case ErrorCompat_General() when general != null:
return general(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ErrorCompat_General extends ErrorCompat {
  const ErrorCompat_General({required this.message}): super._();
  

@override final  String message;

/// Create a copy of ErrorCompat
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorCompat_GeneralCopyWith<ErrorCompat_General> get copyWith => _$ErrorCompat_GeneralCopyWithImpl<ErrorCompat_General>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ErrorCompat_General&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ErrorCompat.general(message: $message)';
}


}

/// @nodoc
abstract mixin class $ErrorCompat_GeneralCopyWith<$Res> implements $ErrorCompatCopyWith<$Res> {
  factory $ErrorCompat_GeneralCopyWith(ErrorCompat_General value, $Res Function(ErrorCompat_General) _then) = _$ErrorCompat_GeneralCopyWithImpl;
@override @useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ErrorCompat_GeneralCopyWithImpl<$Res>
    implements $ErrorCompat_GeneralCopyWith<$Res> {
  _$ErrorCompat_GeneralCopyWithImpl(this._self, this._then);

  final ErrorCompat_General _self;
  final $Res Function(ErrorCompat_General) _then;

/// Create a copy of ErrorCompat
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ErrorCompat_General(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ExecuteDetailsCompat {

// required TransactionReceiptCompat initialTxnReceipt,
 String get initialTxnReceipt; String get initialTxnHash;
/// Create a copy of ExecuteDetailsCompat
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExecuteDetailsCompatCopyWith<ExecuteDetailsCompat> get copyWith => _$ExecuteDetailsCompatCopyWithImpl<ExecuteDetailsCompat>(this as ExecuteDetailsCompat, _$identity);

  /// Serializes this ExecuteDetailsCompat to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExecuteDetailsCompat&&(identical(other.initialTxnReceipt, initialTxnReceipt) || other.initialTxnReceipt == initialTxnReceipt)&&(identical(other.initialTxnHash, initialTxnHash) || other.initialTxnHash == initialTxnHash));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,initialTxnReceipt,initialTxnHash);

@override
String toString() {
  return 'ExecuteDetailsCompat(initialTxnReceipt: $initialTxnReceipt, initialTxnHash: $initialTxnHash)';
}


}

/// @nodoc
abstract mixin class $ExecuteDetailsCompatCopyWith<$Res>  {
  factory $ExecuteDetailsCompatCopyWith(ExecuteDetailsCompat value, $Res Function(ExecuteDetailsCompat) _then) = _$ExecuteDetailsCompatCopyWithImpl;
@useResult
$Res call({
 String initialTxnReceipt, String initialTxnHash
});




}
/// @nodoc
class _$ExecuteDetailsCompatCopyWithImpl<$Res>
    implements $ExecuteDetailsCompatCopyWith<$Res> {
  _$ExecuteDetailsCompatCopyWithImpl(this._self, this._then);

  final ExecuteDetailsCompat _self;
  final $Res Function(ExecuteDetailsCompat) _then;

/// Create a copy of ExecuteDetailsCompat
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? initialTxnReceipt = null,Object? initialTxnHash = null,}) {
  return _then(_self.copyWith(
initialTxnReceipt: null == initialTxnReceipt ? _self.initialTxnReceipt : initialTxnReceipt // ignore: cast_nullable_to_non_nullable
as String,initialTxnHash: null == initialTxnHash ? _self.initialTxnHash : initialTxnHash // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ExecuteDetailsCompat].
extension ExecuteDetailsCompatPatterns on ExecuteDetailsCompat {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExecuteDetailsCompat value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExecuteDetailsCompat() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExecuteDetailsCompat value)  $default,){
final _that = this;
switch (_that) {
case _ExecuteDetailsCompat():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExecuteDetailsCompat value)?  $default,){
final _that = this;
switch (_that) {
case _ExecuteDetailsCompat() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String initialTxnReceipt,  String initialTxnHash)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExecuteDetailsCompat() when $default != null:
return $default(_that.initialTxnReceipt,_that.initialTxnHash);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String initialTxnReceipt,  String initialTxnHash)  $default,) {final _that = this;
switch (_that) {
case _ExecuteDetailsCompat():
return $default(_that.initialTxnReceipt,_that.initialTxnHash);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String initialTxnReceipt,  String initialTxnHash)?  $default,) {final _that = this;
switch (_that) {
case _ExecuteDetailsCompat() when $default != null:
return $default(_that.initialTxnReceipt,_that.initialTxnHash);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExecuteDetailsCompat implements ExecuteDetailsCompat {
  const _ExecuteDetailsCompat({required this.initialTxnReceipt, required this.initialTxnHash});
  factory _ExecuteDetailsCompat.fromJson(Map<String, dynamic> json) => _$ExecuteDetailsCompatFromJson(json);

// required TransactionReceiptCompat initialTxnReceipt,
@override final  String initialTxnReceipt;
@override final  String initialTxnHash;

/// Create a copy of ExecuteDetailsCompat
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExecuteDetailsCompatCopyWith<_ExecuteDetailsCompat> get copyWith => __$ExecuteDetailsCompatCopyWithImpl<_ExecuteDetailsCompat>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExecuteDetailsCompatToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExecuteDetailsCompat&&(identical(other.initialTxnReceipt, initialTxnReceipt) || other.initialTxnReceipt == initialTxnReceipt)&&(identical(other.initialTxnHash, initialTxnHash) || other.initialTxnHash == initialTxnHash));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,initialTxnReceipt,initialTxnHash);

@override
String toString() {
  return 'ExecuteDetailsCompat(initialTxnReceipt: $initialTxnReceipt, initialTxnHash: $initialTxnHash)';
}


}

/// @nodoc
abstract mixin class _$ExecuteDetailsCompatCopyWith<$Res> implements $ExecuteDetailsCompatCopyWith<$Res> {
  factory _$ExecuteDetailsCompatCopyWith(_ExecuteDetailsCompat value, $Res Function(_ExecuteDetailsCompat) _then) = __$ExecuteDetailsCompatCopyWithImpl;
@override @useResult
$Res call({
 String initialTxnReceipt, String initialTxnHash
});




}
/// @nodoc
class __$ExecuteDetailsCompatCopyWithImpl<$Res>
    implements _$ExecuteDetailsCompatCopyWith<$Res> {
  __$ExecuteDetailsCompatCopyWithImpl(this._self, this._then);

  final _ExecuteDetailsCompat _self;
  final $Res Function(_ExecuteDetailsCompat) _then;

/// Create a copy of ExecuteDetailsCompat
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? initialTxnReceipt = null,Object? initialTxnHash = null,}) {
  return _then(_ExecuteDetailsCompat(
initialTxnReceipt: null == initialTxnReceipt ? _self.initialTxnReceipt : initialTxnReceipt // ignore: cast_nullable_to_non_nullable
as String,initialTxnHash: null == initialTxnHash ? _self.initialTxnHash : initialTxnHash // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$FeeEstimatedTransactionCompat {

 String get chainId; String get from; String get to; String get value; String get input; String get gasLimit; String get nonce; String get maxFeePerGas; String get maxPriorityFeePerGas;
/// Create a copy of FeeEstimatedTransactionCompat
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeeEstimatedTransactionCompatCopyWith<FeeEstimatedTransactionCompat> get copyWith => _$FeeEstimatedTransactionCompatCopyWithImpl<FeeEstimatedTransactionCompat>(this as FeeEstimatedTransactionCompat, _$identity);

  /// Serializes this FeeEstimatedTransactionCompat to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeeEstimatedTransactionCompat&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.value, value) || other.value == value)&&(identical(other.input, input) || other.input == input)&&(identical(other.gasLimit, gasLimit) || other.gasLimit == gasLimit)&&(identical(other.nonce, nonce) || other.nonce == nonce)&&(identical(other.maxFeePerGas, maxFeePerGas) || other.maxFeePerGas == maxFeePerGas)&&(identical(other.maxPriorityFeePerGas, maxPriorityFeePerGas) || other.maxPriorityFeePerGas == maxPriorityFeePerGas));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,chainId,from,to,value,input,gasLimit,nonce,maxFeePerGas,maxPriorityFeePerGas);

@override
String toString() {
  return 'FeeEstimatedTransactionCompat(chainId: $chainId, from: $from, to: $to, value: $value, input: $input, gasLimit: $gasLimit, nonce: $nonce, maxFeePerGas: $maxFeePerGas, maxPriorityFeePerGas: $maxPriorityFeePerGas)';
}


}

/// @nodoc
abstract mixin class $FeeEstimatedTransactionCompatCopyWith<$Res>  {
  factory $FeeEstimatedTransactionCompatCopyWith(FeeEstimatedTransactionCompat value, $Res Function(FeeEstimatedTransactionCompat) _then) = _$FeeEstimatedTransactionCompatCopyWithImpl;
@useResult
$Res call({
 String chainId, String from, String to, String value, String input, String gasLimit, String nonce, String maxFeePerGas, String maxPriorityFeePerGas
});




}
/// @nodoc
class _$FeeEstimatedTransactionCompatCopyWithImpl<$Res>
    implements $FeeEstimatedTransactionCompatCopyWith<$Res> {
  _$FeeEstimatedTransactionCompatCopyWithImpl(this._self, this._then);

  final FeeEstimatedTransactionCompat _self;
  final $Res Function(FeeEstimatedTransactionCompat) _then;

/// Create a copy of FeeEstimatedTransactionCompat
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? chainId = null,Object? from = null,Object? to = null,Object? value = null,Object? input = null,Object? gasLimit = null,Object? nonce = null,Object? maxFeePerGas = null,Object? maxPriorityFeePerGas = null,}) {
  return _then(_self.copyWith(
chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as String,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,input: null == input ? _self.input : input // ignore: cast_nullable_to_non_nullable
as String,gasLimit: null == gasLimit ? _self.gasLimit : gasLimit // ignore: cast_nullable_to_non_nullable
as String,nonce: null == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as String,maxFeePerGas: null == maxFeePerGas ? _self.maxFeePerGas : maxFeePerGas // ignore: cast_nullable_to_non_nullable
as String,maxPriorityFeePerGas: null == maxPriorityFeePerGas ? _self.maxPriorityFeePerGas : maxPriorityFeePerGas // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FeeEstimatedTransactionCompat].
extension FeeEstimatedTransactionCompatPatterns on FeeEstimatedTransactionCompat {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeeEstimatedTransactionCompat value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeeEstimatedTransactionCompat() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeeEstimatedTransactionCompat value)  $default,){
final _that = this;
switch (_that) {
case _FeeEstimatedTransactionCompat():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeeEstimatedTransactionCompat value)?  $default,){
final _that = this;
switch (_that) {
case _FeeEstimatedTransactionCompat() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String chainId,  String from,  String to,  String value,  String input,  String gasLimit,  String nonce,  String maxFeePerGas,  String maxPriorityFeePerGas)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeeEstimatedTransactionCompat() when $default != null:
return $default(_that.chainId,_that.from,_that.to,_that.value,_that.input,_that.gasLimit,_that.nonce,_that.maxFeePerGas,_that.maxPriorityFeePerGas);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String chainId,  String from,  String to,  String value,  String input,  String gasLimit,  String nonce,  String maxFeePerGas,  String maxPriorityFeePerGas)  $default,) {final _that = this;
switch (_that) {
case _FeeEstimatedTransactionCompat():
return $default(_that.chainId,_that.from,_that.to,_that.value,_that.input,_that.gasLimit,_that.nonce,_that.maxFeePerGas,_that.maxPriorityFeePerGas);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String chainId,  String from,  String to,  String value,  String input,  String gasLimit,  String nonce,  String maxFeePerGas,  String maxPriorityFeePerGas)?  $default,) {final _that = this;
switch (_that) {
case _FeeEstimatedTransactionCompat() when $default != null:
return $default(_that.chainId,_that.from,_that.to,_that.value,_that.input,_that.gasLimit,_that.nonce,_that.maxFeePerGas,_that.maxPriorityFeePerGas);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeeEstimatedTransactionCompat implements FeeEstimatedTransactionCompat {
  const _FeeEstimatedTransactionCompat({required this.chainId, required this.from, required this.to, required this.value, required this.input, required this.gasLimit, required this.nonce, required this.maxFeePerGas, required this.maxPriorityFeePerGas});
  factory _FeeEstimatedTransactionCompat.fromJson(Map<String, dynamic> json) => _$FeeEstimatedTransactionCompatFromJson(json);

@override final  String chainId;
@override final  String from;
@override final  String to;
@override final  String value;
@override final  String input;
@override final  String gasLimit;
@override final  String nonce;
@override final  String maxFeePerGas;
@override final  String maxPriorityFeePerGas;

/// Create a copy of FeeEstimatedTransactionCompat
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeeEstimatedTransactionCompatCopyWith<_FeeEstimatedTransactionCompat> get copyWith => __$FeeEstimatedTransactionCompatCopyWithImpl<_FeeEstimatedTransactionCompat>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeeEstimatedTransactionCompatToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeeEstimatedTransactionCompat&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.value, value) || other.value == value)&&(identical(other.input, input) || other.input == input)&&(identical(other.gasLimit, gasLimit) || other.gasLimit == gasLimit)&&(identical(other.nonce, nonce) || other.nonce == nonce)&&(identical(other.maxFeePerGas, maxFeePerGas) || other.maxFeePerGas == maxFeePerGas)&&(identical(other.maxPriorityFeePerGas, maxPriorityFeePerGas) || other.maxPriorityFeePerGas == maxPriorityFeePerGas));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,chainId,from,to,value,input,gasLimit,nonce,maxFeePerGas,maxPriorityFeePerGas);

@override
String toString() {
  return 'FeeEstimatedTransactionCompat(chainId: $chainId, from: $from, to: $to, value: $value, input: $input, gasLimit: $gasLimit, nonce: $nonce, maxFeePerGas: $maxFeePerGas, maxPriorityFeePerGas: $maxPriorityFeePerGas)';
}


}

/// @nodoc
abstract mixin class _$FeeEstimatedTransactionCompatCopyWith<$Res> implements $FeeEstimatedTransactionCompatCopyWith<$Res> {
  factory _$FeeEstimatedTransactionCompatCopyWith(_FeeEstimatedTransactionCompat value, $Res Function(_FeeEstimatedTransactionCompat) _then) = __$FeeEstimatedTransactionCompatCopyWithImpl;
@override @useResult
$Res call({
 String chainId, String from, String to, String value, String input, String gasLimit, String nonce, String maxFeePerGas, String maxPriorityFeePerGas
});




}
/// @nodoc
class __$FeeEstimatedTransactionCompatCopyWithImpl<$Res>
    implements _$FeeEstimatedTransactionCompatCopyWith<$Res> {
  __$FeeEstimatedTransactionCompatCopyWithImpl(this._self, this._then);

  final _FeeEstimatedTransactionCompat _self;
  final $Res Function(_FeeEstimatedTransactionCompat) _then;

/// Create a copy of FeeEstimatedTransactionCompat
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? chainId = null,Object? from = null,Object? to = null,Object? value = null,Object? input = null,Object? gasLimit = null,Object? nonce = null,Object? maxFeePerGas = null,Object? maxPriorityFeePerGas = null,}) {
  return _then(_FeeEstimatedTransactionCompat(
chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as String,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,input: null == input ? _self.input : input // ignore: cast_nullable_to_non_nullable
as String,gasLimit: null == gasLimit ? _self.gasLimit : gasLimit // ignore: cast_nullable_to_non_nullable
as String,nonce: null == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as String,maxFeePerGas: null == maxFeePerGas ? _self.maxFeePerGas : maxFeePerGas // ignore: cast_nullable_to_non_nullable
as String,maxPriorityFeePerGas: null == maxPriorityFeePerGas ? _self.maxPriorityFeePerGas : maxPriorityFeePerGas // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$FundingMetadataCompat {

 String get chainId; String get tokenContract; String get symbol; String get amount; String get bridgingFee; int get decimals;
/// Create a copy of FundingMetadataCompat
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FundingMetadataCompatCopyWith<FundingMetadataCompat> get copyWith => _$FundingMetadataCompatCopyWithImpl<FundingMetadataCompat>(this as FundingMetadataCompat, _$identity);

  /// Serializes this FundingMetadataCompat to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FundingMetadataCompat&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.tokenContract, tokenContract) || other.tokenContract == tokenContract)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.bridgingFee, bridgingFee) || other.bridgingFee == bridgingFee)&&(identical(other.decimals, decimals) || other.decimals == decimals));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,chainId,tokenContract,symbol,amount,bridgingFee,decimals);

@override
String toString() {
  return 'FundingMetadataCompat(chainId: $chainId, tokenContract: $tokenContract, symbol: $symbol, amount: $amount, bridgingFee: $bridgingFee, decimals: $decimals)';
}


}

/// @nodoc
abstract mixin class $FundingMetadataCompatCopyWith<$Res>  {
  factory $FundingMetadataCompatCopyWith(FundingMetadataCompat value, $Res Function(FundingMetadataCompat) _then) = _$FundingMetadataCompatCopyWithImpl;
@useResult
$Res call({
 String chainId, String tokenContract, String symbol, String amount, String bridgingFee, int decimals
});




}
/// @nodoc
class _$FundingMetadataCompatCopyWithImpl<$Res>
    implements $FundingMetadataCompatCopyWith<$Res> {
  _$FundingMetadataCompatCopyWithImpl(this._self, this._then);

  final FundingMetadataCompat _self;
  final $Res Function(FundingMetadataCompat) _then;

/// Create a copy of FundingMetadataCompat
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? chainId = null,Object? tokenContract = null,Object? symbol = null,Object? amount = null,Object? bridgingFee = null,Object? decimals = null,}) {
  return _then(_self.copyWith(
chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as String,tokenContract: null == tokenContract ? _self.tokenContract : tokenContract // ignore: cast_nullable_to_non_nullable
as String,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,bridgingFee: null == bridgingFee ? _self.bridgingFee : bridgingFee // ignore: cast_nullable_to_non_nullable
as String,decimals: null == decimals ? _self.decimals : decimals // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [FundingMetadataCompat].
extension FundingMetadataCompatPatterns on FundingMetadataCompat {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FundingMetadataCompat value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FundingMetadataCompat() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FundingMetadataCompat value)  $default,){
final _that = this;
switch (_that) {
case _FundingMetadataCompat():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FundingMetadataCompat value)?  $default,){
final _that = this;
switch (_that) {
case _FundingMetadataCompat() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String chainId,  String tokenContract,  String symbol,  String amount,  String bridgingFee,  int decimals)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FundingMetadataCompat() when $default != null:
return $default(_that.chainId,_that.tokenContract,_that.symbol,_that.amount,_that.bridgingFee,_that.decimals);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String chainId,  String tokenContract,  String symbol,  String amount,  String bridgingFee,  int decimals)  $default,) {final _that = this;
switch (_that) {
case _FundingMetadataCompat():
return $default(_that.chainId,_that.tokenContract,_that.symbol,_that.amount,_that.bridgingFee,_that.decimals);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String chainId,  String tokenContract,  String symbol,  String amount,  String bridgingFee,  int decimals)?  $default,) {final _that = this;
switch (_that) {
case _FundingMetadataCompat() when $default != null:
return $default(_that.chainId,_that.tokenContract,_that.symbol,_that.amount,_that.bridgingFee,_that.decimals);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FundingMetadataCompat implements FundingMetadataCompat {
  const _FundingMetadataCompat({required this.chainId, required this.tokenContract, required this.symbol, required this.amount, required this.bridgingFee, required this.decimals});
  factory _FundingMetadataCompat.fromJson(Map<String, dynamic> json) => _$FundingMetadataCompatFromJson(json);

@override final  String chainId;
@override final  String tokenContract;
@override final  String symbol;
@override final  String amount;
@override final  String bridgingFee;
@override final  int decimals;

/// Create a copy of FundingMetadataCompat
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FundingMetadataCompatCopyWith<_FundingMetadataCompat> get copyWith => __$FundingMetadataCompatCopyWithImpl<_FundingMetadataCompat>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FundingMetadataCompatToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FundingMetadataCompat&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.tokenContract, tokenContract) || other.tokenContract == tokenContract)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.bridgingFee, bridgingFee) || other.bridgingFee == bridgingFee)&&(identical(other.decimals, decimals) || other.decimals == decimals));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,chainId,tokenContract,symbol,amount,bridgingFee,decimals);

@override
String toString() {
  return 'FundingMetadataCompat(chainId: $chainId, tokenContract: $tokenContract, symbol: $symbol, amount: $amount, bridgingFee: $bridgingFee, decimals: $decimals)';
}


}

/// @nodoc
abstract mixin class _$FundingMetadataCompatCopyWith<$Res> implements $FundingMetadataCompatCopyWith<$Res> {
  factory _$FundingMetadataCompatCopyWith(_FundingMetadataCompat value, $Res Function(_FundingMetadataCompat) _then) = __$FundingMetadataCompatCopyWithImpl;
@override @useResult
$Res call({
 String chainId, String tokenContract, String symbol, String amount, String bridgingFee, int decimals
});




}
/// @nodoc
class __$FundingMetadataCompatCopyWithImpl<$Res>
    implements _$FundingMetadataCompatCopyWith<$Res> {
  __$FundingMetadataCompatCopyWithImpl(this._self, this._then);

  final _FundingMetadataCompat _self;
  final $Res Function(_FundingMetadataCompat) _then;

/// Create a copy of FundingMetadataCompat
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? chainId = null,Object? tokenContract = null,Object? symbol = null,Object? amount = null,Object? bridgingFee = null,Object? decimals = null,}) {
  return _then(_FundingMetadataCompat(
chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as String,tokenContract: null == tokenContract ? _self.tokenContract : tokenContract // ignore: cast_nullable_to_non_nullable
as String,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,bridgingFee: null == bridgingFee ? _self.bridgingFee : bridgingFee // ignore: cast_nullable_to_non_nullable
as String,decimals: null == decimals ? _self.decimals : decimals // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$InitialTransactionMetadataCompat {

 String get transferTo; String get amount; String get tokenContract; String get symbol; int get decimals;
/// Create a copy of InitialTransactionMetadataCompat
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InitialTransactionMetadataCompatCopyWith<InitialTransactionMetadataCompat> get copyWith => _$InitialTransactionMetadataCompatCopyWithImpl<InitialTransactionMetadataCompat>(this as InitialTransactionMetadataCompat, _$identity);

  /// Serializes this InitialTransactionMetadataCompat to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitialTransactionMetadataCompat&&(identical(other.transferTo, transferTo) || other.transferTo == transferTo)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.tokenContract, tokenContract) || other.tokenContract == tokenContract)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.decimals, decimals) || other.decimals == decimals));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transferTo,amount,tokenContract,symbol,decimals);

@override
String toString() {
  return 'InitialTransactionMetadataCompat(transferTo: $transferTo, amount: $amount, tokenContract: $tokenContract, symbol: $symbol, decimals: $decimals)';
}


}

/// @nodoc
abstract mixin class $InitialTransactionMetadataCompatCopyWith<$Res>  {
  factory $InitialTransactionMetadataCompatCopyWith(InitialTransactionMetadataCompat value, $Res Function(InitialTransactionMetadataCompat) _then) = _$InitialTransactionMetadataCompatCopyWithImpl;
@useResult
$Res call({
 String transferTo, String amount, String tokenContract, String symbol, int decimals
});




}
/// @nodoc
class _$InitialTransactionMetadataCompatCopyWithImpl<$Res>
    implements $InitialTransactionMetadataCompatCopyWith<$Res> {
  _$InitialTransactionMetadataCompatCopyWithImpl(this._self, this._then);

  final InitialTransactionMetadataCompat _self;
  final $Res Function(InitialTransactionMetadataCompat) _then;

/// Create a copy of InitialTransactionMetadataCompat
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? transferTo = null,Object? amount = null,Object? tokenContract = null,Object? symbol = null,Object? decimals = null,}) {
  return _then(_self.copyWith(
transferTo: null == transferTo ? _self.transferTo : transferTo // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,tokenContract: null == tokenContract ? _self.tokenContract : tokenContract // ignore: cast_nullable_to_non_nullable
as String,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,decimals: null == decimals ? _self.decimals : decimals // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [InitialTransactionMetadataCompat].
extension InitialTransactionMetadataCompatPatterns on InitialTransactionMetadataCompat {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InitialTransactionMetadataCompat value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InitialTransactionMetadataCompat() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InitialTransactionMetadataCompat value)  $default,){
final _that = this;
switch (_that) {
case _InitialTransactionMetadataCompat():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InitialTransactionMetadataCompat value)?  $default,){
final _that = this;
switch (_that) {
case _InitialTransactionMetadataCompat() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String transferTo,  String amount,  String tokenContract,  String symbol,  int decimals)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InitialTransactionMetadataCompat() when $default != null:
return $default(_that.transferTo,_that.amount,_that.tokenContract,_that.symbol,_that.decimals);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String transferTo,  String amount,  String tokenContract,  String symbol,  int decimals)  $default,) {final _that = this;
switch (_that) {
case _InitialTransactionMetadataCompat():
return $default(_that.transferTo,_that.amount,_that.tokenContract,_that.symbol,_that.decimals);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String transferTo,  String amount,  String tokenContract,  String symbol,  int decimals)?  $default,) {final _that = this;
switch (_that) {
case _InitialTransactionMetadataCompat() when $default != null:
return $default(_that.transferTo,_that.amount,_that.tokenContract,_that.symbol,_that.decimals);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InitialTransactionMetadataCompat implements InitialTransactionMetadataCompat {
  const _InitialTransactionMetadataCompat({required this.transferTo, required this.amount, required this.tokenContract, required this.symbol, required this.decimals});
  factory _InitialTransactionMetadataCompat.fromJson(Map<String, dynamic> json) => _$InitialTransactionMetadataCompatFromJson(json);

@override final  String transferTo;
@override final  String amount;
@override final  String tokenContract;
@override final  String symbol;
@override final  int decimals;

/// Create a copy of InitialTransactionMetadataCompat
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InitialTransactionMetadataCompatCopyWith<_InitialTransactionMetadataCompat> get copyWith => __$InitialTransactionMetadataCompatCopyWithImpl<_InitialTransactionMetadataCompat>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InitialTransactionMetadataCompatToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InitialTransactionMetadataCompat&&(identical(other.transferTo, transferTo) || other.transferTo == transferTo)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.tokenContract, tokenContract) || other.tokenContract == tokenContract)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.decimals, decimals) || other.decimals == decimals));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transferTo,amount,tokenContract,symbol,decimals);

@override
String toString() {
  return 'InitialTransactionMetadataCompat(transferTo: $transferTo, amount: $amount, tokenContract: $tokenContract, symbol: $symbol, decimals: $decimals)';
}


}

/// @nodoc
abstract mixin class _$InitialTransactionMetadataCompatCopyWith<$Res> implements $InitialTransactionMetadataCompatCopyWith<$Res> {
  factory _$InitialTransactionMetadataCompatCopyWith(_InitialTransactionMetadataCompat value, $Res Function(_InitialTransactionMetadataCompat) _then) = __$InitialTransactionMetadataCompatCopyWithImpl;
@override @useResult
$Res call({
 String transferTo, String amount, String tokenContract, String symbol, int decimals
});




}
/// @nodoc
class __$InitialTransactionMetadataCompatCopyWithImpl<$Res>
    implements _$InitialTransactionMetadataCompatCopyWith<$Res> {
  __$InitialTransactionMetadataCompatCopyWithImpl(this._self, this._then);

  final _InitialTransactionMetadataCompat _self;
  final $Res Function(_InitialTransactionMetadataCompat) _then;

/// Create a copy of InitialTransactionMetadataCompat
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? transferTo = null,Object? amount = null,Object? tokenContract = null,Object? symbol = null,Object? decimals = null,}) {
  return _then(_InitialTransactionMetadataCompat(
transferTo: null == transferTo ? _self.transferTo : transferTo // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,tokenContract: null == tokenContract ? _self.tokenContract : tokenContract // ignore: cast_nullable_to_non_nullable
as String,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,decimals: null == decimals ? _self.decimals : decimals // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$MetadataCompat {

 List<FundingMetadataCompat> get fundingFrom; InitialTransactionMetadataCompat get initialTransaction; BigInt get checkIn;
/// Create a copy of MetadataCompat
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MetadataCompatCopyWith<MetadataCompat> get copyWith => _$MetadataCompatCopyWithImpl<MetadataCompat>(this as MetadataCompat, _$identity);

  /// Serializes this MetadataCompat to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MetadataCompat&&const DeepCollectionEquality().equals(other.fundingFrom, fundingFrom)&&(identical(other.initialTransaction, initialTransaction) || other.initialTransaction == initialTransaction)&&(identical(other.checkIn, checkIn) || other.checkIn == checkIn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(fundingFrom),initialTransaction,checkIn);

@override
String toString() {
  return 'MetadataCompat(fundingFrom: $fundingFrom, initialTransaction: $initialTransaction, checkIn: $checkIn)';
}


}

/// @nodoc
abstract mixin class $MetadataCompatCopyWith<$Res>  {
  factory $MetadataCompatCopyWith(MetadataCompat value, $Res Function(MetadataCompat) _then) = _$MetadataCompatCopyWithImpl;
@useResult
$Res call({
 List<FundingMetadataCompat> fundingFrom, InitialTransactionMetadataCompat initialTransaction, BigInt checkIn
});


$InitialTransactionMetadataCompatCopyWith<$Res> get initialTransaction;

}
/// @nodoc
class _$MetadataCompatCopyWithImpl<$Res>
    implements $MetadataCompatCopyWith<$Res> {
  _$MetadataCompatCopyWithImpl(this._self, this._then);

  final MetadataCompat _self;
  final $Res Function(MetadataCompat) _then;

/// Create a copy of MetadataCompat
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fundingFrom = null,Object? initialTransaction = null,Object? checkIn = null,}) {
  return _then(_self.copyWith(
fundingFrom: null == fundingFrom ? _self.fundingFrom : fundingFrom // ignore: cast_nullable_to_non_nullable
as List<FundingMetadataCompat>,initialTransaction: null == initialTransaction ? _self.initialTransaction : initialTransaction // ignore: cast_nullable_to_non_nullable
as InitialTransactionMetadataCompat,checkIn: null == checkIn ? _self.checkIn : checkIn // ignore: cast_nullable_to_non_nullable
as BigInt,
  ));
}
/// Create a copy of MetadataCompat
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InitialTransactionMetadataCompatCopyWith<$Res> get initialTransaction {
  
  return $InitialTransactionMetadataCompatCopyWith<$Res>(_self.initialTransaction, (value) {
    return _then(_self.copyWith(initialTransaction: value));
  });
}
}


/// Adds pattern-matching-related methods to [MetadataCompat].
extension MetadataCompatPatterns on MetadataCompat {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MetadataCompat value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MetadataCompat() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MetadataCompat value)  $default,){
final _that = this;
switch (_that) {
case _MetadataCompat():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MetadataCompat value)?  $default,){
final _that = this;
switch (_that) {
case _MetadataCompat() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<FundingMetadataCompat> fundingFrom,  InitialTransactionMetadataCompat initialTransaction,  BigInt checkIn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MetadataCompat() when $default != null:
return $default(_that.fundingFrom,_that.initialTransaction,_that.checkIn);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<FundingMetadataCompat> fundingFrom,  InitialTransactionMetadataCompat initialTransaction,  BigInt checkIn)  $default,) {final _that = this;
switch (_that) {
case _MetadataCompat():
return $default(_that.fundingFrom,_that.initialTransaction,_that.checkIn);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<FundingMetadataCompat> fundingFrom,  InitialTransactionMetadataCompat initialTransaction,  BigInt checkIn)?  $default,) {final _that = this;
switch (_that) {
case _MetadataCompat() when $default != null:
return $default(_that.fundingFrom,_that.initialTransaction,_that.checkIn);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MetadataCompat implements MetadataCompat {
  const _MetadataCompat({required final  List<FundingMetadataCompat> fundingFrom, required this.initialTransaction, required this.checkIn}): _fundingFrom = fundingFrom;
  factory _MetadataCompat.fromJson(Map<String, dynamic> json) => _$MetadataCompatFromJson(json);

 final  List<FundingMetadataCompat> _fundingFrom;
@override List<FundingMetadataCompat> get fundingFrom {
  if (_fundingFrom is EqualUnmodifiableListView) return _fundingFrom;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fundingFrom);
}

@override final  InitialTransactionMetadataCompat initialTransaction;
@override final  BigInt checkIn;

/// Create a copy of MetadataCompat
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MetadataCompatCopyWith<_MetadataCompat> get copyWith => __$MetadataCompatCopyWithImpl<_MetadataCompat>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MetadataCompatToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MetadataCompat&&const DeepCollectionEquality().equals(other._fundingFrom, _fundingFrom)&&(identical(other.initialTransaction, initialTransaction) || other.initialTransaction == initialTransaction)&&(identical(other.checkIn, checkIn) || other.checkIn == checkIn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_fundingFrom),initialTransaction,checkIn);

@override
String toString() {
  return 'MetadataCompat(fundingFrom: $fundingFrom, initialTransaction: $initialTransaction, checkIn: $checkIn)';
}


}

/// @nodoc
abstract mixin class _$MetadataCompatCopyWith<$Res> implements $MetadataCompatCopyWith<$Res> {
  factory _$MetadataCompatCopyWith(_MetadataCompat value, $Res Function(_MetadataCompat) _then) = __$MetadataCompatCopyWithImpl;
@override @useResult
$Res call({
 List<FundingMetadataCompat> fundingFrom, InitialTransactionMetadataCompat initialTransaction, BigInt checkIn
});


@override $InitialTransactionMetadataCompatCopyWith<$Res> get initialTransaction;

}
/// @nodoc
class __$MetadataCompatCopyWithImpl<$Res>
    implements _$MetadataCompatCopyWith<$Res> {
  __$MetadataCompatCopyWithImpl(this._self, this._then);

  final _MetadataCompat _self;
  final $Res Function(_MetadataCompat) _then;

/// Create a copy of MetadataCompat
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fundingFrom = null,Object? initialTransaction = null,Object? checkIn = null,}) {
  return _then(_MetadataCompat(
fundingFrom: null == fundingFrom ? _self._fundingFrom : fundingFrom // ignore: cast_nullable_to_non_nullable
as List<FundingMetadataCompat>,initialTransaction: null == initialTransaction ? _self.initialTransaction : initialTransaction // ignore: cast_nullable_to_non_nullable
as InitialTransactionMetadataCompat,checkIn: null == checkIn ? _self.checkIn : checkIn // ignore: cast_nullable_to_non_nullable
as BigInt,
  ));
}

/// Create a copy of MetadataCompat
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InitialTransactionMetadataCompatCopyWith<$Res> get initialTransaction {
  
  return $InitialTransactionMetadataCompatCopyWith<$Res>(_self.initialTransaction, (value) {
    return _then(_self.copyWith(initialTransaction: value));
  });
}
}

/// @nodoc
mixin _$PrepareDetailedResponseCompat {

 Object get value;



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrepareDetailedResponseCompat&&const DeepCollectionEquality().equals(other.value, value));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(value));

@override
String toString() {
  return 'PrepareDetailedResponseCompat(value: $value)';
}


}

/// @nodoc
class $PrepareDetailedResponseCompatCopyWith<$Res>  {
$PrepareDetailedResponseCompatCopyWith(PrepareDetailedResponseCompat _, $Res Function(PrepareDetailedResponseCompat) __);
}


/// Adds pattern-matching-related methods to [PrepareDetailedResponseCompat].
extension PrepareDetailedResponseCompatPatterns on PrepareDetailedResponseCompat {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PrepareDetailedResponseCompat_Success value)?  success,TResult Function( PrepareDetailedResponseCompat_Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PrepareDetailedResponseCompat_Success() when success != null:
return success(_that);case PrepareDetailedResponseCompat_Error() when error != null:
return error(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PrepareDetailedResponseCompat_Success value)  success,required TResult Function( PrepareDetailedResponseCompat_Error value)  error,}){
final _that = this;
switch (_that) {
case PrepareDetailedResponseCompat_Success():
return success(_that);case PrepareDetailedResponseCompat_Error():
return error(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PrepareDetailedResponseCompat_Success value)?  success,TResult? Function( PrepareDetailedResponseCompat_Error value)?  error,}){
final _that = this;
switch (_that) {
case PrepareDetailedResponseCompat_Success() when success != null:
return success(_that);case PrepareDetailedResponseCompat_Error() when error != null:
return error(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( PrepareDetailedResponseSuccessCompat value)?  success,TResult Function( PrepareDetailedResponseError value)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PrepareDetailedResponseCompat_Success() when success != null:
return success(_that.value);case PrepareDetailedResponseCompat_Error() when error != null:
return error(_that.value);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( PrepareDetailedResponseSuccessCompat value)  success,required TResult Function( PrepareDetailedResponseError value)  error,}) {final _that = this;
switch (_that) {
case PrepareDetailedResponseCompat_Success():
return success(_that.value);case PrepareDetailedResponseCompat_Error():
return error(_that.value);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( PrepareDetailedResponseSuccessCompat value)?  success,TResult? Function( PrepareDetailedResponseError value)?  error,}) {final _that = this;
switch (_that) {
case PrepareDetailedResponseCompat_Success() when success != null:
return success(_that.value);case PrepareDetailedResponseCompat_Error() when error != null:
return error(_that.value);case _:
  return null;

}
}

}

/// @nodoc


class PrepareDetailedResponseCompat_Success extends PrepareDetailedResponseCompat {
  const PrepareDetailedResponseCompat_Success({required this.value}): super._();
  

@override final  PrepareDetailedResponseSuccessCompat value;

/// Create a copy of PrepareDetailedResponseCompat
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrepareDetailedResponseCompat_SuccessCopyWith<PrepareDetailedResponseCompat_Success> get copyWith => _$PrepareDetailedResponseCompat_SuccessCopyWithImpl<PrepareDetailedResponseCompat_Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrepareDetailedResponseCompat_Success&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'PrepareDetailedResponseCompat.success(value: $value)';
}


}

/// @nodoc
abstract mixin class $PrepareDetailedResponseCompat_SuccessCopyWith<$Res> implements $PrepareDetailedResponseCompatCopyWith<$Res> {
  factory $PrepareDetailedResponseCompat_SuccessCopyWith(PrepareDetailedResponseCompat_Success value, $Res Function(PrepareDetailedResponseCompat_Success) _then) = _$PrepareDetailedResponseCompat_SuccessCopyWithImpl;
@useResult
$Res call({
 PrepareDetailedResponseSuccessCompat value
});


$PrepareDetailedResponseSuccessCompatCopyWith<$Res> get value;

}
/// @nodoc
class _$PrepareDetailedResponseCompat_SuccessCopyWithImpl<$Res>
    implements $PrepareDetailedResponseCompat_SuccessCopyWith<$Res> {
  _$PrepareDetailedResponseCompat_SuccessCopyWithImpl(this._self, this._then);

  final PrepareDetailedResponseCompat_Success _self;
  final $Res Function(PrepareDetailedResponseCompat_Success) _then;

/// Create a copy of PrepareDetailedResponseCompat
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(PrepareDetailedResponseCompat_Success(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as PrepareDetailedResponseSuccessCompat,
  ));
}

/// Create a copy of PrepareDetailedResponseCompat
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PrepareDetailedResponseSuccessCompatCopyWith<$Res> get value {
  
  return $PrepareDetailedResponseSuccessCompatCopyWith<$Res>(_self.value, (value) {
    return _then(_self.copyWith(value: value));
  });
}
}

/// @nodoc


class PrepareDetailedResponseCompat_Error extends PrepareDetailedResponseCompat {
  const PrepareDetailedResponseCompat_Error({required this.value}): super._();
  

@override final  PrepareDetailedResponseError value;

/// Create a copy of PrepareDetailedResponseCompat
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrepareDetailedResponseCompat_ErrorCopyWith<PrepareDetailedResponseCompat_Error> get copyWith => _$PrepareDetailedResponseCompat_ErrorCopyWithImpl<PrepareDetailedResponseCompat_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrepareDetailedResponseCompat_Error&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'PrepareDetailedResponseCompat.error(value: $value)';
}


}

/// @nodoc
abstract mixin class $PrepareDetailedResponseCompat_ErrorCopyWith<$Res> implements $PrepareDetailedResponseCompatCopyWith<$Res> {
  factory $PrepareDetailedResponseCompat_ErrorCopyWith(PrepareDetailedResponseCompat_Error value, $Res Function(PrepareDetailedResponseCompat_Error) _then) = _$PrepareDetailedResponseCompat_ErrorCopyWithImpl;
@useResult
$Res call({
 PrepareDetailedResponseError value
});




}
/// @nodoc
class _$PrepareDetailedResponseCompat_ErrorCopyWithImpl<$Res>
    implements $PrepareDetailedResponseCompat_ErrorCopyWith<$Res> {
  _$PrepareDetailedResponseCompat_ErrorCopyWithImpl(this._self, this._then);

  final PrepareDetailedResponseCompat_Error _self;
  final $Res Function(PrepareDetailedResponseCompat_Error) _then;

/// Create a copy of PrepareDetailedResponseCompat
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(PrepareDetailedResponseCompat_Error(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as PrepareDetailedResponseError,
  ));
}


}

PrepareDetailedResponseSuccessCompat _$PrepareDetailedResponseSuccessCompatFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'available':
          return PrepareDetailedResponseSuccessCompat_Available.fromJson(
            json
          );
                case 'notRequired':
          return PrepareDetailedResponseSuccessCompat_NotRequired.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'PrepareDetailedResponseSuccessCompat',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$PrepareDetailedResponseSuccessCompat {

 Object get value;

  /// Serializes this PrepareDetailedResponseSuccessCompat to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrepareDetailedResponseSuccessCompat&&const DeepCollectionEquality().equals(other.value, value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(value));

@override
String toString() {
  return 'PrepareDetailedResponseSuccessCompat(value: $value)';
}


}

/// @nodoc
class $PrepareDetailedResponseSuccessCompatCopyWith<$Res>  {
$PrepareDetailedResponseSuccessCompatCopyWith(PrepareDetailedResponseSuccessCompat _, $Res Function(PrepareDetailedResponseSuccessCompat) __);
}


/// Adds pattern-matching-related methods to [PrepareDetailedResponseSuccessCompat].
extension PrepareDetailedResponseSuccessCompatPatterns on PrepareDetailedResponseSuccessCompat {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PrepareDetailedResponseSuccessCompat_Available value)?  available,TResult Function( PrepareDetailedResponseSuccessCompat_NotRequired value)?  notRequired,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PrepareDetailedResponseSuccessCompat_Available() when available != null:
return available(_that);case PrepareDetailedResponseSuccessCompat_NotRequired() when notRequired != null:
return notRequired(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PrepareDetailedResponseSuccessCompat_Available value)  available,required TResult Function( PrepareDetailedResponseSuccessCompat_NotRequired value)  notRequired,}){
final _that = this;
switch (_that) {
case PrepareDetailedResponseSuccessCompat_Available():
return available(_that);case PrepareDetailedResponseSuccessCompat_NotRequired():
return notRequired(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PrepareDetailedResponseSuccessCompat_Available value)?  available,TResult? Function( PrepareDetailedResponseSuccessCompat_NotRequired value)?  notRequired,}){
final _that = this;
switch (_that) {
case PrepareDetailedResponseSuccessCompat_Available() when available != null:
return available(_that);case PrepareDetailedResponseSuccessCompat_NotRequired() when notRequired != null:
return notRequired(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( UiFieldsCompat value)?  available,TResult Function( PrepareResponseNotRequiredCompat value)?  notRequired,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PrepareDetailedResponseSuccessCompat_Available() when available != null:
return available(_that.value);case PrepareDetailedResponseSuccessCompat_NotRequired() when notRequired != null:
return notRequired(_that.value);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( UiFieldsCompat value)  available,required TResult Function( PrepareResponseNotRequiredCompat value)  notRequired,}) {final _that = this;
switch (_that) {
case PrepareDetailedResponseSuccessCompat_Available():
return available(_that.value);case PrepareDetailedResponseSuccessCompat_NotRequired():
return notRequired(_that.value);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( UiFieldsCompat value)?  available,TResult? Function( PrepareResponseNotRequiredCompat value)?  notRequired,}) {final _that = this;
switch (_that) {
case PrepareDetailedResponseSuccessCompat_Available() when available != null:
return available(_that.value);case PrepareDetailedResponseSuccessCompat_NotRequired() when notRequired != null:
return notRequired(_that.value);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class PrepareDetailedResponseSuccessCompat_Available extends PrepareDetailedResponseSuccessCompat {
  const PrepareDetailedResponseSuccessCompat_Available({required this.value, final  String? $type}): $type = $type ?? 'available',super._();
  factory PrepareDetailedResponseSuccessCompat_Available.fromJson(Map<String, dynamic> json) => _$PrepareDetailedResponseSuccessCompat_AvailableFromJson(json);

@override final  UiFieldsCompat value;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of PrepareDetailedResponseSuccessCompat
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrepareDetailedResponseSuccessCompat_AvailableCopyWith<PrepareDetailedResponseSuccessCompat_Available> get copyWith => _$PrepareDetailedResponseSuccessCompat_AvailableCopyWithImpl<PrepareDetailedResponseSuccessCompat_Available>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PrepareDetailedResponseSuccessCompat_AvailableToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrepareDetailedResponseSuccessCompat_Available&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'PrepareDetailedResponseSuccessCompat.available(value: $value)';
}


}

/// @nodoc
abstract mixin class $PrepareDetailedResponseSuccessCompat_AvailableCopyWith<$Res> implements $PrepareDetailedResponseSuccessCompatCopyWith<$Res> {
  factory $PrepareDetailedResponseSuccessCompat_AvailableCopyWith(PrepareDetailedResponseSuccessCompat_Available value, $Res Function(PrepareDetailedResponseSuccessCompat_Available) _then) = _$PrepareDetailedResponseSuccessCompat_AvailableCopyWithImpl;
@useResult
$Res call({
 UiFieldsCompat value
});


$UiFieldsCompatCopyWith<$Res> get value;

}
/// @nodoc
class _$PrepareDetailedResponseSuccessCompat_AvailableCopyWithImpl<$Res>
    implements $PrepareDetailedResponseSuccessCompat_AvailableCopyWith<$Res> {
  _$PrepareDetailedResponseSuccessCompat_AvailableCopyWithImpl(this._self, this._then);

  final PrepareDetailedResponseSuccessCompat_Available _self;
  final $Res Function(PrepareDetailedResponseSuccessCompat_Available) _then;

/// Create a copy of PrepareDetailedResponseSuccessCompat
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(PrepareDetailedResponseSuccessCompat_Available(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as UiFieldsCompat,
  ));
}

/// Create a copy of PrepareDetailedResponseSuccessCompat
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UiFieldsCompatCopyWith<$Res> get value {
  
  return $UiFieldsCompatCopyWith<$Res>(_self.value, (value) {
    return _then(_self.copyWith(value: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class PrepareDetailedResponseSuccessCompat_NotRequired extends PrepareDetailedResponseSuccessCompat {
  const PrepareDetailedResponseSuccessCompat_NotRequired({required this.value, final  String? $type}): $type = $type ?? 'notRequired',super._();
  factory PrepareDetailedResponseSuccessCompat_NotRequired.fromJson(Map<String, dynamic> json) => _$PrepareDetailedResponseSuccessCompat_NotRequiredFromJson(json);

@override final  PrepareResponseNotRequiredCompat value;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of PrepareDetailedResponseSuccessCompat
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrepareDetailedResponseSuccessCompat_NotRequiredCopyWith<PrepareDetailedResponseSuccessCompat_NotRequired> get copyWith => _$PrepareDetailedResponseSuccessCompat_NotRequiredCopyWithImpl<PrepareDetailedResponseSuccessCompat_NotRequired>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PrepareDetailedResponseSuccessCompat_NotRequiredToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrepareDetailedResponseSuccessCompat_NotRequired&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'PrepareDetailedResponseSuccessCompat.notRequired(value: $value)';
}


}

/// @nodoc
abstract mixin class $PrepareDetailedResponseSuccessCompat_NotRequiredCopyWith<$Res> implements $PrepareDetailedResponseSuccessCompatCopyWith<$Res> {
  factory $PrepareDetailedResponseSuccessCompat_NotRequiredCopyWith(PrepareDetailedResponseSuccessCompat_NotRequired value, $Res Function(PrepareDetailedResponseSuccessCompat_NotRequired) _then) = _$PrepareDetailedResponseSuccessCompat_NotRequiredCopyWithImpl;
@useResult
$Res call({
 PrepareResponseNotRequiredCompat value
});


$PrepareResponseNotRequiredCompatCopyWith<$Res> get value;

}
/// @nodoc
class _$PrepareDetailedResponseSuccessCompat_NotRequiredCopyWithImpl<$Res>
    implements $PrepareDetailedResponseSuccessCompat_NotRequiredCopyWith<$Res> {
  _$PrepareDetailedResponseSuccessCompat_NotRequiredCopyWithImpl(this._self, this._then);

  final PrepareDetailedResponseSuccessCompat_NotRequired _self;
  final $Res Function(PrepareDetailedResponseSuccessCompat_NotRequired) _then;

/// Create a copy of PrepareDetailedResponseSuccessCompat
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(PrepareDetailedResponseSuccessCompat_NotRequired(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as PrepareResponseNotRequiredCompat,
  ));
}

/// Create a copy of PrepareDetailedResponseSuccessCompat
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PrepareResponseNotRequiredCompatCopyWith<$Res> get value {
  
  return $PrepareResponseNotRequiredCompatCopyWith<$Res>(_self.value, (value) {
    return _then(_self.copyWith(value: value));
  });
}
}


/// @nodoc
mixin _$PrepareResponseAvailableCompat {

 String get orchestrationId; TransactionCompat get initialTransaction; List<TransactionCompat> get transactions; MetadataCompat get metadata;
/// Create a copy of PrepareResponseAvailableCompat
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrepareResponseAvailableCompatCopyWith<PrepareResponseAvailableCompat> get copyWith => _$PrepareResponseAvailableCompatCopyWithImpl<PrepareResponseAvailableCompat>(this as PrepareResponseAvailableCompat, _$identity);

  /// Serializes this PrepareResponseAvailableCompat to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrepareResponseAvailableCompat&&(identical(other.orchestrationId, orchestrationId) || other.orchestrationId == orchestrationId)&&(identical(other.initialTransaction, initialTransaction) || other.initialTransaction == initialTransaction)&&const DeepCollectionEquality().equals(other.transactions, transactions)&&(identical(other.metadata, metadata) || other.metadata == metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,orchestrationId,initialTransaction,const DeepCollectionEquality().hash(transactions),metadata);

@override
String toString() {
  return 'PrepareResponseAvailableCompat(orchestrationId: $orchestrationId, initialTransaction: $initialTransaction, transactions: $transactions, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $PrepareResponseAvailableCompatCopyWith<$Res>  {
  factory $PrepareResponseAvailableCompatCopyWith(PrepareResponseAvailableCompat value, $Res Function(PrepareResponseAvailableCompat) _then) = _$PrepareResponseAvailableCompatCopyWithImpl;
@useResult
$Res call({
 String orchestrationId, TransactionCompat initialTransaction, List<TransactionCompat> transactions, MetadataCompat metadata
});


$TransactionCompatCopyWith<$Res> get initialTransaction;$MetadataCompatCopyWith<$Res> get metadata;

}
/// @nodoc
class _$PrepareResponseAvailableCompatCopyWithImpl<$Res>
    implements $PrepareResponseAvailableCompatCopyWith<$Res> {
  _$PrepareResponseAvailableCompatCopyWithImpl(this._self, this._then);

  final PrepareResponseAvailableCompat _self;
  final $Res Function(PrepareResponseAvailableCompat) _then;

/// Create a copy of PrepareResponseAvailableCompat
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? orchestrationId = null,Object? initialTransaction = null,Object? transactions = null,Object? metadata = null,}) {
  return _then(_self.copyWith(
orchestrationId: null == orchestrationId ? _self.orchestrationId : orchestrationId // ignore: cast_nullable_to_non_nullable
as String,initialTransaction: null == initialTransaction ? _self.initialTransaction : initialTransaction // ignore: cast_nullable_to_non_nullable
as TransactionCompat,transactions: null == transactions ? _self.transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<TransactionCompat>,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as MetadataCompat,
  ));
}
/// Create a copy of PrepareResponseAvailableCompat
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransactionCompatCopyWith<$Res> get initialTransaction {
  
  return $TransactionCompatCopyWith<$Res>(_self.initialTransaction, (value) {
    return _then(_self.copyWith(initialTransaction: value));
  });
}/// Create a copy of PrepareResponseAvailableCompat
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MetadataCompatCopyWith<$Res> get metadata {
  
  return $MetadataCompatCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}
}


/// Adds pattern-matching-related methods to [PrepareResponseAvailableCompat].
extension PrepareResponseAvailableCompatPatterns on PrepareResponseAvailableCompat {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PrepareResponseAvailableCompat value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PrepareResponseAvailableCompat() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PrepareResponseAvailableCompat value)  $default,){
final _that = this;
switch (_that) {
case _PrepareResponseAvailableCompat():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PrepareResponseAvailableCompat value)?  $default,){
final _that = this;
switch (_that) {
case _PrepareResponseAvailableCompat() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String orchestrationId,  TransactionCompat initialTransaction,  List<TransactionCompat> transactions,  MetadataCompat metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PrepareResponseAvailableCompat() when $default != null:
return $default(_that.orchestrationId,_that.initialTransaction,_that.transactions,_that.metadata);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String orchestrationId,  TransactionCompat initialTransaction,  List<TransactionCompat> transactions,  MetadataCompat metadata)  $default,) {final _that = this;
switch (_that) {
case _PrepareResponseAvailableCompat():
return $default(_that.orchestrationId,_that.initialTransaction,_that.transactions,_that.metadata);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String orchestrationId,  TransactionCompat initialTransaction,  List<TransactionCompat> transactions,  MetadataCompat metadata)?  $default,) {final _that = this;
switch (_that) {
case _PrepareResponseAvailableCompat() when $default != null:
return $default(_that.orchestrationId,_that.initialTransaction,_that.transactions,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PrepareResponseAvailableCompat implements PrepareResponseAvailableCompat {
  const _PrepareResponseAvailableCompat({required this.orchestrationId, required this.initialTransaction, required final  List<TransactionCompat> transactions, required this.metadata}): _transactions = transactions;
  factory _PrepareResponseAvailableCompat.fromJson(Map<String, dynamic> json) => _$PrepareResponseAvailableCompatFromJson(json);

@override final  String orchestrationId;
@override final  TransactionCompat initialTransaction;
 final  List<TransactionCompat> _transactions;
@override List<TransactionCompat> get transactions {
  if (_transactions is EqualUnmodifiableListView) return _transactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_transactions);
}

@override final  MetadataCompat metadata;

/// Create a copy of PrepareResponseAvailableCompat
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrepareResponseAvailableCompatCopyWith<_PrepareResponseAvailableCompat> get copyWith => __$PrepareResponseAvailableCompatCopyWithImpl<_PrepareResponseAvailableCompat>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PrepareResponseAvailableCompatToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrepareResponseAvailableCompat&&(identical(other.orchestrationId, orchestrationId) || other.orchestrationId == orchestrationId)&&(identical(other.initialTransaction, initialTransaction) || other.initialTransaction == initialTransaction)&&const DeepCollectionEquality().equals(other._transactions, _transactions)&&(identical(other.metadata, metadata) || other.metadata == metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,orchestrationId,initialTransaction,const DeepCollectionEquality().hash(_transactions),metadata);

@override
String toString() {
  return 'PrepareResponseAvailableCompat(orchestrationId: $orchestrationId, initialTransaction: $initialTransaction, transactions: $transactions, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$PrepareResponseAvailableCompatCopyWith<$Res> implements $PrepareResponseAvailableCompatCopyWith<$Res> {
  factory _$PrepareResponseAvailableCompatCopyWith(_PrepareResponseAvailableCompat value, $Res Function(_PrepareResponseAvailableCompat) _then) = __$PrepareResponseAvailableCompatCopyWithImpl;
@override @useResult
$Res call({
 String orchestrationId, TransactionCompat initialTransaction, List<TransactionCompat> transactions, MetadataCompat metadata
});


@override $TransactionCompatCopyWith<$Res> get initialTransaction;@override $MetadataCompatCopyWith<$Res> get metadata;

}
/// @nodoc
class __$PrepareResponseAvailableCompatCopyWithImpl<$Res>
    implements _$PrepareResponseAvailableCompatCopyWith<$Res> {
  __$PrepareResponseAvailableCompatCopyWithImpl(this._self, this._then);

  final _PrepareResponseAvailableCompat _self;
  final $Res Function(_PrepareResponseAvailableCompat) _then;

/// Create a copy of PrepareResponseAvailableCompat
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? orchestrationId = null,Object? initialTransaction = null,Object? transactions = null,Object? metadata = null,}) {
  return _then(_PrepareResponseAvailableCompat(
orchestrationId: null == orchestrationId ? _self.orchestrationId : orchestrationId // ignore: cast_nullable_to_non_nullable
as String,initialTransaction: null == initialTransaction ? _self.initialTransaction : initialTransaction // ignore: cast_nullable_to_non_nullable
as TransactionCompat,transactions: null == transactions ? _self._transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<TransactionCompat>,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as MetadataCompat,
  ));
}

/// Create a copy of PrepareResponseAvailableCompat
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransactionCompatCopyWith<$Res> get initialTransaction {
  
  return $TransactionCompatCopyWith<$Res>(_self.initialTransaction, (value) {
    return _then(_self.copyWith(initialTransaction: value));
  });
}/// Create a copy of PrepareResponseAvailableCompat
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MetadataCompatCopyWith<$Res> get metadata {
  
  return $MetadataCompatCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}
}


/// @nodoc
mixin _$PrepareResponseNotRequiredCompat {

 TransactionCompat get initialTransaction; List<TransactionCompat> get transactions;
/// Create a copy of PrepareResponseNotRequiredCompat
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrepareResponseNotRequiredCompatCopyWith<PrepareResponseNotRequiredCompat> get copyWith => _$PrepareResponseNotRequiredCompatCopyWithImpl<PrepareResponseNotRequiredCompat>(this as PrepareResponseNotRequiredCompat, _$identity);

  /// Serializes this PrepareResponseNotRequiredCompat to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrepareResponseNotRequiredCompat&&(identical(other.initialTransaction, initialTransaction) || other.initialTransaction == initialTransaction)&&const DeepCollectionEquality().equals(other.transactions, transactions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,initialTransaction,const DeepCollectionEquality().hash(transactions));

@override
String toString() {
  return 'PrepareResponseNotRequiredCompat(initialTransaction: $initialTransaction, transactions: $transactions)';
}


}

/// @nodoc
abstract mixin class $PrepareResponseNotRequiredCompatCopyWith<$Res>  {
  factory $PrepareResponseNotRequiredCompatCopyWith(PrepareResponseNotRequiredCompat value, $Res Function(PrepareResponseNotRequiredCompat) _then) = _$PrepareResponseNotRequiredCompatCopyWithImpl;
@useResult
$Res call({
 TransactionCompat initialTransaction, List<TransactionCompat> transactions
});


$TransactionCompatCopyWith<$Res> get initialTransaction;

}
/// @nodoc
class _$PrepareResponseNotRequiredCompatCopyWithImpl<$Res>
    implements $PrepareResponseNotRequiredCompatCopyWith<$Res> {
  _$PrepareResponseNotRequiredCompatCopyWithImpl(this._self, this._then);

  final PrepareResponseNotRequiredCompat _self;
  final $Res Function(PrepareResponseNotRequiredCompat) _then;

/// Create a copy of PrepareResponseNotRequiredCompat
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? initialTransaction = null,Object? transactions = null,}) {
  return _then(_self.copyWith(
initialTransaction: null == initialTransaction ? _self.initialTransaction : initialTransaction // ignore: cast_nullable_to_non_nullable
as TransactionCompat,transactions: null == transactions ? _self.transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<TransactionCompat>,
  ));
}
/// Create a copy of PrepareResponseNotRequiredCompat
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransactionCompatCopyWith<$Res> get initialTransaction {
  
  return $TransactionCompatCopyWith<$Res>(_self.initialTransaction, (value) {
    return _then(_self.copyWith(initialTransaction: value));
  });
}
}


/// Adds pattern-matching-related methods to [PrepareResponseNotRequiredCompat].
extension PrepareResponseNotRequiredCompatPatterns on PrepareResponseNotRequiredCompat {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PrepareResponseNotRequiredCompat value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PrepareResponseNotRequiredCompat() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PrepareResponseNotRequiredCompat value)  $default,){
final _that = this;
switch (_that) {
case _PrepareResponseNotRequiredCompat():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PrepareResponseNotRequiredCompat value)?  $default,){
final _that = this;
switch (_that) {
case _PrepareResponseNotRequiredCompat() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TransactionCompat initialTransaction,  List<TransactionCompat> transactions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PrepareResponseNotRequiredCompat() when $default != null:
return $default(_that.initialTransaction,_that.transactions);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TransactionCompat initialTransaction,  List<TransactionCompat> transactions)  $default,) {final _that = this;
switch (_that) {
case _PrepareResponseNotRequiredCompat():
return $default(_that.initialTransaction,_that.transactions);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TransactionCompat initialTransaction,  List<TransactionCompat> transactions)?  $default,) {final _that = this;
switch (_that) {
case _PrepareResponseNotRequiredCompat() when $default != null:
return $default(_that.initialTransaction,_that.transactions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PrepareResponseNotRequiredCompat implements PrepareResponseNotRequiredCompat {
  const _PrepareResponseNotRequiredCompat({required this.initialTransaction, required final  List<TransactionCompat> transactions}): _transactions = transactions;
  factory _PrepareResponseNotRequiredCompat.fromJson(Map<String, dynamic> json) => _$PrepareResponseNotRequiredCompatFromJson(json);

@override final  TransactionCompat initialTransaction;
 final  List<TransactionCompat> _transactions;
@override List<TransactionCompat> get transactions {
  if (_transactions is EqualUnmodifiableListView) return _transactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_transactions);
}


/// Create a copy of PrepareResponseNotRequiredCompat
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrepareResponseNotRequiredCompatCopyWith<_PrepareResponseNotRequiredCompat> get copyWith => __$PrepareResponseNotRequiredCompatCopyWithImpl<_PrepareResponseNotRequiredCompat>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PrepareResponseNotRequiredCompatToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrepareResponseNotRequiredCompat&&(identical(other.initialTransaction, initialTransaction) || other.initialTransaction == initialTransaction)&&const DeepCollectionEquality().equals(other._transactions, _transactions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,initialTransaction,const DeepCollectionEquality().hash(_transactions));

@override
String toString() {
  return 'PrepareResponseNotRequiredCompat(initialTransaction: $initialTransaction, transactions: $transactions)';
}


}

/// @nodoc
abstract mixin class _$PrepareResponseNotRequiredCompatCopyWith<$Res> implements $PrepareResponseNotRequiredCompatCopyWith<$Res> {
  factory _$PrepareResponseNotRequiredCompatCopyWith(_PrepareResponseNotRequiredCompat value, $Res Function(_PrepareResponseNotRequiredCompat) _then) = __$PrepareResponseNotRequiredCompatCopyWithImpl;
@override @useResult
$Res call({
 TransactionCompat initialTransaction, List<TransactionCompat> transactions
});


@override $TransactionCompatCopyWith<$Res> get initialTransaction;

}
/// @nodoc
class __$PrepareResponseNotRequiredCompatCopyWithImpl<$Res>
    implements _$PrepareResponseNotRequiredCompatCopyWith<$Res> {
  __$PrepareResponseNotRequiredCompatCopyWithImpl(this._self, this._then);

  final _PrepareResponseNotRequiredCompat _self;
  final $Res Function(_PrepareResponseNotRequiredCompat) _then;

/// Create a copy of PrepareResponseNotRequiredCompat
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? initialTransaction = null,Object? transactions = null,}) {
  return _then(_PrepareResponseNotRequiredCompat(
initialTransaction: null == initialTransaction ? _self.initialTransaction : initialTransaction // ignore: cast_nullable_to_non_nullable
as TransactionCompat,transactions: null == transactions ? _self._transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<TransactionCompat>,
  ));
}

/// Create a copy of PrepareResponseNotRequiredCompat
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransactionCompatCopyWith<$Res> get initialTransaction {
  
  return $TransactionCompatCopyWith<$Res>(_self.initialTransaction, (value) {
    return _then(_self.copyWith(initialTransaction: value));
  });
}
}


/// @nodoc
mixin _$TransactionCompat {

 String get chainId; String get from; String get to; String get value; String get input; BigInt get gasLimit; BigInt get nonce;
/// Create a copy of TransactionCompat
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionCompatCopyWith<TransactionCompat> get copyWith => _$TransactionCompatCopyWithImpl<TransactionCompat>(this as TransactionCompat, _$identity);

  /// Serializes this TransactionCompat to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionCompat&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.value, value) || other.value == value)&&(identical(other.input, input) || other.input == input)&&(identical(other.gasLimit, gasLimit) || other.gasLimit == gasLimit)&&(identical(other.nonce, nonce) || other.nonce == nonce));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,chainId,from,to,value,input,gasLimit,nonce);

@override
String toString() {
  return 'TransactionCompat(chainId: $chainId, from: $from, to: $to, value: $value, input: $input, gasLimit: $gasLimit, nonce: $nonce)';
}


}

/// @nodoc
abstract mixin class $TransactionCompatCopyWith<$Res>  {
  factory $TransactionCompatCopyWith(TransactionCompat value, $Res Function(TransactionCompat) _then) = _$TransactionCompatCopyWithImpl;
@useResult
$Res call({
 String chainId, String from, String to, String value, String input, BigInt gasLimit, BigInt nonce
});




}
/// @nodoc
class _$TransactionCompatCopyWithImpl<$Res>
    implements $TransactionCompatCopyWith<$Res> {
  _$TransactionCompatCopyWithImpl(this._self, this._then);

  final TransactionCompat _self;
  final $Res Function(TransactionCompat) _then;

/// Create a copy of TransactionCompat
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? chainId = null,Object? from = null,Object? to = null,Object? value = null,Object? input = null,Object? gasLimit = null,Object? nonce = null,}) {
  return _then(_self.copyWith(
chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as String,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,input: null == input ? _self.input : input // ignore: cast_nullable_to_non_nullable
as String,gasLimit: null == gasLimit ? _self.gasLimit : gasLimit // ignore: cast_nullable_to_non_nullable
as BigInt,nonce: null == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as BigInt,
  ));
}

}


/// Adds pattern-matching-related methods to [TransactionCompat].
extension TransactionCompatPatterns on TransactionCompat {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransactionCompat value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransactionCompat() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransactionCompat value)  $default,){
final _that = this;
switch (_that) {
case _TransactionCompat():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransactionCompat value)?  $default,){
final _that = this;
switch (_that) {
case _TransactionCompat() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String chainId,  String from,  String to,  String value,  String input,  BigInt gasLimit,  BigInt nonce)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransactionCompat() when $default != null:
return $default(_that.chainId,_that.from,_that.to,_that.value,_that.input,_that.gasLimit,_that.nonce);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String chainId,  String from,  String to,  String value,  String input,  BigInt gasLimit,  BigInt nonce)  $default,) {final _that = this;
switch (_that) {
case _TransactionCompat():
return $default(_that.chainId,_that.from,_that.to,_that.value,_that.input,_that.gasLimit,_that.nonce);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String chainId,  String from,  String to,  String value,  String input,  BigInt gasLimit,  BigInt nonce)?  $default,) {final _that = this;
switch (_that) {
case _TransactionCompat() when $default != null:
return $default(_that.chainId,_that.from,_that.to,_that.value,_that.input,_that.gasLimit,_that.nonce);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TransactionCompat implements TransactionCompat {
  const _TransactionCompat({required this.chainId, required this.from, required this.to, required this.value, required this.input, required this.gasLimit, required this.nonce});
  factory _TransactionCompat.fromJson(Map<String, dynamic> json) => _$TransactionCompatFromJson(json);

@override final  String chainId;
@override final  String from;
@override final  String to;
@override final  String value;
@override final  String input;
@override final  BigInt gasLimit;
@override final  BigInt nonce;

/// Create a copy of TransactionCompat
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionCompatCopyWith<_TransactionCompat> get copyWith => __$TransactionCompatCopyWithImpl<_TransactionCompat>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransactionCompatToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionCompat&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.value, value) || other.value == value)&&(identical(other.input, input) || other.input == input)&&(identical(other.gasLimit, gasLimit) || other.gasLimit == gasLimit)&&(identical(other.nonce, nonce) || other.nonce == nonce));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,chainId,from,to,value,input,gasLimit,nonce);

@override
String toString() {
  return 'TransactionCompat(chainId: $chainId, from: $from, to: $to, value: $value, input: $input, gasLimit: $gasLimit, nonce: $nonce)';
}


}

/// @nodoc
abstract mixin class _$TransactionCompatCopyWith<$Res> implements $TransactionCompatCopyWith<$Res> {
  factory _$TransactionCompatCopyWith(_TransactionCompat value, $Res Function(_TransactionCompat) _then) = __$TransactionCompatCopyWithImpl;
@override @useResult
$Res call({
 String chainId, String from, String to, String value, String input, BigInt gasLimit, BigInt nonce
});




}
/// @nodoc
class __$TransactionCompatCopyWithImpl<$Res>
    implements _$TransactionCompatCopyWith<$Res> {
  __$TransactionCompatCopyWithImpl(this._self, this._then);

  final _TransactionCompat _self;
  final $Res Function(_TransactionCompat) _then;

/// Create a copy of TransactionCompat
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? chainId = null,Object? from = null,Object? to = null,Object? value = null,Object? input = null,Object? gasLimit = null,Object? nonce = null,}) {
  return _then(_TransactionCompat(
chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as String,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,input: null == input ? _self.input : input // ignore: cast_nullable_to_non_nullable
as String,gasLimit: null == gasLimit ? _self.gasLimit : gasLimit // ignore: cast_nullable_to_non_nullable
as BigInt,nonce: null == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as BigInt,
  ));
}


}


/// @nodoc
mixin _$TransactionFeeCompat {

 AmountCompat get fee; AmountCompat get localFee;
/// Create a copy of TransactionFeeCompat
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionFeeCompatCopyWith<TransactionFeeCompat> get copyWith => _$TransactionFeeCompatCopyWithImpl<TransactionFeeCompat>(this as TransactionFeeCompat, _$identity);

  /// Serializes this TransactionFeeCompat to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionFeeCompat&&(identical(other.fee, fee) || other.fee == fee)&&(identical(other.localFee, localFee) || other.localFee == localFee));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fee,localFee);

@override
String toString() {
  return 'TransactionFeeCompat(fee: $fee, localFee: $localFee)';
}


}

/// @nodoc
abstract mixin class $TransactionFeeCompatCopyWith<$Res>  {
  factory $TransactionFeeCompatCopyWith(TransactionFeeCompat value, $Res Function(TransactionFeeCompat) _then) = _$TransactionFeeCompatCopyWithImpl;
@useResult
$Res call({
 AmountCompat fee, AmountCompat localFee
});


$AmountCompatCopyWith<$Res> get fee;$AmountCompatCopyWith<$Res> get localFee;

}
/// @nodoc
class _$TransactionFeeCompatCopyWithImpl<$Res>
    implements $TransactionFeeCompatCopyWith<$Res> {
  _$TransactionFeeCompatCopyWithImpl(this._self, this._then);

  final TransactionFeeCompat _self;
  final $Res Function(TransactionFeeCompat) _then;

/// Create a copy of TransactionFeeCompat
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fee = null,Object? localFee = null,}) {
  return _then(_self.copyWith(
fee: null == fee ? _self.fee : fee // ignore: cast_nullable_to_non_nullable
as AmountCompat,localFee: null == localFee ? _self.localFee : localFee // ignore: cast_nullable_to_non_nullable
as AmountCompat,
  ));
}
/// Create a copy of TransactionFeeCompat
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AmountCompatCopyWith<$Res> get fee {
  
  return $AmountCompatCopyWith<$Res>(_self.fee, (value) {
    return _then(_self.copyWith(fee: value));
  });
}/// Create a copy of TransactionFeeCompat
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AmountCompatCopyWith<$Res> get localFee {
  
  return $AmountCompatCopyWith<$Res>(_self.localFee, (value) {
    return _then(_self.copyWith(localFee: value));
  });
}
}


/// Adds pattern-matching-related methods to [TransactionFeeCompat].
extension TransactionFeeCompatPatterns on TransactionFeeCompat {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransactionFeeCompat value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransactionFeeCompat() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransactionFeeCompat value)  $default,){
final _that = this;
switch (_that) {
case _TransactionFeeCompat():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransactionFeeCompat value)?  $default,){
final _that = this;
switch (_that) {
case _TransactionFeeCompat() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AmountCompat fee,  AmountCompat localFee)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransactionFeeCompat() when $default != null:
return $default(_that.fee,_that.localFee);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AmountCompat fee,  AmountCompat localFee)  $default,) {final _that = this;
switch (_that) {
case _TransactionFeeCompat():
return $default(_that.fee,_that.localFee);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AmountCompat fee,  AmountCompat localFee)?  $default,) {final _that = this;
switch (_that) {
case _TransactionFeeCompat() when $default != null:
return $default(_that.fee,_that.localFee);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TransactionFeeCompat implements TransactionFeeCompat {
  const _TransactionFeeCompat({required this.fee, required this.localFee});
  factory _TransactionFeeCompat.fromJson(Map<String, dynamic> json) => _$TransactionFeeCompatFromJson(json);

@override final  AmountCompat fee;
@override final  AmountCompat localFee;

/// Create a copy of TransactionFeeCompat
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionFeeCompatCopyWith<_TransactionFeeCompat> get copyWith => __$TransactionFeeCompatCopyWithImpl<_TransactionFeeCompat>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransactionFeeCompatToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionFeeCompat&&(identical(other.fee, fee) || other.fee == fee)&&(identical(other.localFee, localFee) || other.localFee == localFee));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fee,localFee);

@override
String toString() {
  return 'TransactionFeeCompat(fee: $fee, localFee: $localFee)';
}


}

/// @nodoc
abstract mixin class _$TransactionFeeCompatCopyWith<$Res> implements $TransactionFeeCompatCopyWith<$Res> {
  factory _$TransactionFeeCompatCopyWith(_TransactionFeeCompat value, $Res Function(_TransactionFeeCompat) _then) = __$TransactionFeeCompatCopyWithImpl;
@override @useResult
$Res call({
 AmountCompat fee, AmountCompat localFee
});


@override $AmountCompatCopyWith<$Res> get fee;@override $AmountCompatCopyWith<$Res> get localFee;

}
/// @nodoc
class __$TransactionFeeCompatCopyWithImpl<$Res>
    implements _$TransactionFeeCompatCopyWith<$Res> {
  __$TransactionFeeCompatCopyWithImpl(this._self, this._then);

  final _TransactionFeeCompat _self;
  final $Res Function(_TransactionFeeCompat) _then;

/// Create a copy of TransactionFeeCompat
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fee = null,Object? localFee = null,}) {
  return _then(_TransactionFeeCompat(
fee: null == fee ? _self.fee : fee // ignore: cast_nullable_to_non_nullable
as AmountCompat,localFee: null == localFee ? _self.localFee : localFee // ignore: cast_nullable_to_non_nullable
as AmountCompat,
  ));
}

/// Create a copy of TransactionFeeCompat
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AmountCompatCopyWith<$Res> get fee {
  
  return $AmountCompatCopyWith<$Res>(_self.fee, (value) {
    return _then(_self.copyWith(fee: value));
  });
}/// Create a copy of TransactionFeeCompat
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AmountCompatCopyWith<$Res> get localFee {
  
  return $AmountCompatCopyWith<$Res>(_self.localFee, (value) {
    return _then(_self.copyWith(localFee: value));
  });
}
}


/// @nodoc
mixin _$TransactionReceiptCompat {

 String get transactionHash; BigInt? get transactionIndex; String? get blockHash; BigInt? get blockNumber; BigInt get gasUsed; String get effectiveGasPrice; BigInt? get blobGasUsed; String? get blobGasPrice; String get from; String? get to; String? get contractAddress;
/// Create a copy of TransactionReceiptCompat
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionReceiptCompatCopyWith<TransactionReceiptCompat> get copyWith => _$TransactionReceiptCompatCopyWithImpl<TransactionReceiptCompat>(this as TransactionReceiptCompat, _$identity);

  /// Serializes this TransactionReceiptCompat to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionReceiptCompat&&(identical(other.transactionHash, transactionHash) || other.transactionHash == transactionHash)&&(identical(other.transactionIndex, transactionIndex) || other.transactionIndex == transactionIndex)&&(identical(other.blockHash, blockHash) || other.blockHash == blockHash)&&(identical(other.blockNumber, blockNumber) || other.blockNumber == blockNumber)&&(identical(other.gasUsed, gasUsed) || other.gasUsed == gasUsed)&&(identical(other.effectiveGasPrice, effectiveGasPrice) || other.effectiveGasPrice == effectiveGasPrice)&&(identical(other.blobGasUsed, blobGasUsed) || other.blobGasUsed == blobGasUsed)&&(identical(other.blobGasPrice, blobGasPrice) || other.blobGasPrice == blobGasPrice)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.contractAddress, contractAddress) || other.contractAddress == contractAddress));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transactionHash,transactionIndex,blockHash,blockNumber,gasUsed,effectiveGasPrice,blobGasUsed,blobGasPrice,from,to,contractAddress);

@override
String toString() {
  return 'TransactionReceiptCompat(transactionHash: $transactionHash, transactionIndex: $transactionIndex, blockHash: $blockHash, blockNumber: $blockNumber, gasUsed: $gasUsed, effectiveGasPrice: $effectiveGasPrice, blobGasUsed: $blobGasUsed, blobGasPrice: $blobGasPrice, from: $from, to: $to, contractAddress: $contractAddress)';
}


}

/// @nodoc
abstract mixin class $TransactionReceiptCompatCopyWith<$Res>  {
  factory $TransactionReceiptCompatCopyWith(TransactionReceiptCompat value, $Res Function(TransactionReceiptCompat) _then) = _$TransactionReceiptCompatCopyWithImpl;
@useResult
$Res call({
 String transactionHash, BigInt? transactionIndex, String? blockHash, BigInt? blockNumber, BigInt gasUsed, String effectiveGasPrice, BigInt? blobGasUsed, String? blobGasPrice, String from, String? to, String? contractAddress
});




}
/// @nodoc
class _$TransactionReceiptCompatCopyWithImpl<$Res>
    implements $TransactionReceiptCompatCopyWith<$Res> {
  _$TransactionReceiptCompatCopyWithImpl(this._self, this._then);

  final TransactionReceiptCompat _self;
  final $Res Function(TransactionReceiptCompat) _then;

/// Create a copy of TransactionReceiptCompat
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? transactionHash = null,Object? transactionIndex = freezed,Object? blockHash = freezed,Object? blockNumber = freezed,Object? gasUsed = null,Object? effectiveGasPrice = null,Object? blobGasUsed = freezed,Object? blobGasPrice = freezed,Object? from = null,Object? to = freezed,Object? contractAddress = freezed,}) {
  return _then(_self.copyWith(
transactionHash: null == transactionHash ? _self.transactionHash : transactionHash // ignore: cast_nullable_to_non_nullable
as String,transactionIndex: freezed == transactionIndex ? _self.transactionIndex : transactionIndex // ignore: cast_nullable_to_non_nullable
as BigInt?,blockHash: freezed == blockHash ? _self.blockHash : blockHash // ignore: cast_nullable_to_non_nullable
as String?,blockNumber: freezed == blockNumber ? _self.blockNumber : blockNumber // ignore: cast_nullable_to_non_nullable
as BigInt?,gasUsed: null == gasUsed ? _self.gasUsed : gasUsed // ignore: cast_nullable_to_non_nullable
as BigInt,effectiveGasPrice: null == effectiveGasPrice ? _self.effectiveGasPrice : effectiveGasPrice // ignore: cast_nullable_to_non_nullable
as String,blobGasUsed: freezed == blobGasUsed ? _self.blobGasUsed : blobGasUsed // ignore: cast_nullable_to_non_nullable
as BigInt?,blobGasPrice: freezed == blobGasPrice ? _self.blobGasPrice : blobGasPrice // ignore: cast_nullable_to_non_nullable
as String?,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,to: freezed == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String?,contractAddress: freezed == contractAddress ? _self.contractAddress : contractAddress // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TransactionReceiptCompat].
extension TransactionReceiptCompatPatterns on TransactionReceiptCompat {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransactionReceiptCompat value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransactionReceiptCompat() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransactionReceiptCompat value)  $default,){
final _that = this;
switch (_that) {
case _TransactionReceiptCompat():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransactionReceiptCompat value)?  $default,){
final _that = this;
switch (_that) {
case _TransactionReceiptCompat() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String transactionHash,  BigInt? transactionIndex,  String? blockHash,  BigInt? blockNumber,  BigInt gasUsed,  String effectiveGasPrice,  BigInt? blobGasUsed,  String? blobGasPrice,  String from,  String? to,  String? contractAddress)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransactionReceiptCompat() when $default != null:
return $default(_that.transactionHash,_that.transactionIndex,_that.blockHash,_that.blockNumber,_that.gasUsed,_that.effectiveGasPrice,_that.blobGasUsed,_that.blobGasPrice,_that.from,_that.to,_that.contractAddress);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String transactionHash,  BigInt? transactionIndex,  String? blockHash,  BigInt? blockNumber,  BigInt gasUsed,  String effectiveGasPrice,  BigInt? blobGasUsed,  String? blobGasPrice,  String from,  String? to,  String? contractAddress)  $default,) {final _that = this;
switch (_that) {
case _TransactionReceiptCompat():
return $default(_that.transactionHash,_that.transactionIndex,_that.blockHash,_that.blockNumber,_that.gasUsed,_that.effectiveGasPrice,_that.blobGasUsed,_that.blobGasPrice,_that.from,_that.to,_that.contractAddress);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String transactionHash,  BigInt? transactionIndex,  String? blockHash,  BigInt? blockNumber,  BigInt gasUsed,  String effectiveGasPrice,  BigInt? blobGasUsed,  String? blobGasPrice,  String from,  String? to,  String? contractAddress)?  $default,) {final _that = this;
switch (_that) {
case _TransactionReceiptCompat() when $default != null:
return $default(_that.transactionHash,_that.transactionIndex,_that.blockHash,_that.blockNumber,_that.gasUsed,_that.effectiveGasPrice,_that.blobGasUsed,_that.blobGasPrice,_that.from,_that.to,_that.contractAddress);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TransactionReceiptCompat implements TransactionReceiptCompat {
  const _TransactionReceiptCompat({required this.transactionHash, this.transactionIndex, this.blockHash, this.blockNumber, required this.gasUsed, required this.effectiveGasPrice, this.blobGasUsed, this.blobGasPrice, required this.from, this.to, this.contractAddress});
  factory _TransactionReceiptCompat.fromJson(Map<String, dynamic> json) => _$TransactionReceiptCompatFromJson(json);

@override final  String transactionHash;
@override final  BigInt? transactionIndex;
@override final  String? blockHash;
@override final  BigInt? blockNumber;
@override final  BigInt gasUsed;
@override final  String effectiveGasPrice;
@override final  BigInt? blobGasUsed;
@override final  String? blobGasPrice;
@override final  String from;
@override final  String? to;
@override final  String? contractAddress;

/// Create a copy of TransactionReceiptCompat
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionReceiptCompatCopyWith<_TransactionReceiptCompat> get copyWith => __$TransactionReceiptCompatCopyWithImpl<_TransactionReceiptCompat>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransactionReceiptCompatToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionReceiptCompat&&(identical(other.transactionHash, transactionHash) || other.transactionHash == transactionHash)&&(identical(other.transactionIndex, transactionIndex) || other.transactionIndex == transactionIndex)&&(identical(other.blockHash, blockHash) || other.blockHash == blockHash)&&(identical(other.blockNumber, blockNumber) || other.blockNumber == blockNumber)&&(identical(other.gasUsed, gasUsed) || other.gasUsed == gasUsed)&&(identical(other.effectiveGasPrice, effectiveGasPrice) || other.effectiveGasPrice == effectiveGasPrice)&&(identical(other.blobGasUsed, blobGasUsed) || other.blobGasUsed == blobGasUsed)&&(identical(other.blobGasPrice, blobGasPrice) || other.blobGasPrice == blobGasPrice)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.contractAddress, contractAddress) || other.contractAddress == contractAddress));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transactionHash,transactionIndex,blockHash,blockNumber,gasUsed,effectiveGasPrice,blobGasUsed,blobGasPrice,from,to,contractAddress);

@override
String toString() {
  return 'TransactionReceiptCompat(transactionHash: $transactionHash, transactionIndex: $transactionIndex, blockHash: $blockHash, blockNumber: $blockNumber, gasUsed: $gasUsed, effectiveGasPrice: $effectiveGasPrice, blobGasUsed: $blobGasUsed, blobGasPrice: $blobGasPrice, from: $from, to: $to, contractAddress: $contractAddress)';
}


}

/// @nodoc
abstract mixin class _$TransactionReceiptCompatCopyWith<$Res> implements $TransactionReceiptCompatCopyWith<$Res> {
  factory _$TransactionReceiptCompatCopyWith(_TransactionReceiptCompat value, $Res Function(_TransactionReceiptCompat) _then) = __$TransactionReceiptCompatCopyWithImpl;
@override @useResult
$Res call({
 String transactionHash, BigInt? transactionIndex, String? blockHash, BigInt? blockNumber, BigInt gasUsed, String effectiveGasPrice, BigInt? blobGasUsed, String? blobGasPrice, String from, String? to, String? contractAddress
});




}
/// @nodoc
class __$TransactionReceiptCompatCopyWithImpl<$Res>
    implements _$TransactionReceiptCompatCopyWith<$Res> {
  __$TransactionReceiptCompatCopyWithImpl(this._self, this._then);

  final _TransactionReceiptCompat _self;
  final $Res Function(_TransactionReceiptCompat) _then;

/// Create a copy of TransactionReceiptCompat
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? transactionHash = null,Object? transactionIndex = freezed,Object? blockHash = freezed,Object? blockNumber = freezed,Object? gasUsed = null,Object? effectiveGasPrice = null,Object? blobGasUsed = freezed,Object? blobGasPrice = freezed,Object? from = null,Object? to = freezed,Object? contractAddress = freezed,}) {
  return _then(_TransactionReceiptCompat(
transactionHash: null == transactionHash ? _self.transactionHash : transactionHash // ignore: cast_nullable_to_non_nullable
as String,transactionIndex: freezed == transactionIndex ? _self.transactionIndex : transactionIndex // ignore: cast_nullable_to_non_nullable
as BigInt?,blockHash: freezed == blockHash ? _self.blockHash : blockHash // ignore: cast_nullable_to_non_nullable
as String?,blockNumber: freezed == blockNumber ? _self.blockNumber : blockNumber // ignore: cast_nullable_to_non_nullable
as BigInt?,gasUsed: null == gasUsed ? _self.gasUsed : gasUsed // ignore: cast_nullable_to_non_nullable
as BigInt,effectiveGasPrice: null == effectiveGasPrice ? _self.effectiveGasPrice : effectiveGasPrice // ignore: cast_nullable_to_non_nullable
as String,blobGasUsed: freezed == blobGasUsed ? _self.blobGasUsed : blobGasUsed // ignore: cast_nullable_to_non_nullable
as BigInt?,blobGasPrice: freezed == blobGasPrice ? _self.blobGasPrice : blobGasPrice // ignore: cast_nullable_to_non_nullable
as String?,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,to: freezed == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String?,contractAddress: freezed == contractAddress ? _self.contractAddress : contractAddress // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TxnDetailsCompat {

 FeeEstimatedTransactionCompat get transaction; String get transactionHashToSign; TransactionFeeCompat get fee;
/// Create a copy of TxnDetailsCompat
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TxnDetailsCompatCopyWith<TxnDetailsCompat> get copyWith => _$TxnDetailsCompatCopyWithImpl<TxnDetailsCompat>(this as TxnDetailsCompat, _$identity);

  /// Serializes this TxnDetailsCompat to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TxnDetailsCompat&&(identical(other.transaction, transaction) || other.transaction == transaction)&&(identical(other.transactionHashToSign, transactionHashToSign) || other.transactionHashToSign == transactionHashToSign)&&(identical(other.fee, fee) || other.fee == fee));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transaction,transactionHashToSign,fee);

@override
String toString() {
  return 'TxnDetailsCompat(transaction: $transaction, transactionHashToSign: $transactionHashToSign, fee: $fee)';
}


}

/// @nodoc
abstract mixin class $TxnDetailsCompatCopyWith<$Res>  {
  factory $TxnDetailsCompatCopyWith(TxnDetailsCompat value, $Res Function(TxnDetailsCompat) _then) = _$TxnDetailsCompatCopyWithImpl;
@useResult
$Res call({
 FeeEstimatedTransactionCompat transaction, String transactionHashToSign, TransactionFeeCompat fee
});


$FeeEstimatedTransactionCompatCopyWith<$Res> get transaction;$TransactionFeeCompatCopyWith<$Res> get fee;

}
/// @nodoc
class _$TxnDetailsCompatCopyWithImpl<$Res>
    implements $TxnDetailsCompatCopyWith<$Res> {
  _$TxnDetailsCompatCopyWithImpl(this._self, this._then);

  final TxnDetailsCompat _self;
  final $Res Function(TxnDetailsCompat) _then;

/// Create a copy of TxnDetailsCompat
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? transaction = null,Object? transactionHashToSign = null,Object? fee = null,}) {
  return _then(_self.copyWith(
transaction: null == transaction ? _self.transaction : transaction // ignore: cast_nullable_to_non_nullable
as FeeEstimatedTransactionCompat,transactionHashToSign: null == transactionHashToSign ? _self.transactionHashToSign : transactionHashToSign // ignore: cast_nullable_to_non_nullable
as String,fee: null == fee ? _self.fee : fee // ignore: cast_nullable_to_non_nullable
as TransactionFeeCompat,
  ));
}
/// Create a copy of TxnDetailsCompat
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FeeEstimatedTransactionCompatCopyWith<$Res> get transaction {
  
  return $FeeEstimatedTransactionCompatCopyWith<$Res>(_self.transaction, (value) {
    return _then(_self.copyWith(transaction: value));
  });
}/// Create a copy of TxnDetailsCompat
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransactionFeeCompatCopyWith<$Res> get fee {
  
  return $TransactionFeeCompatCopyWith<$Res>(_self.fee, (value) {
    return _then(_self.copyWith(fee: value));
  });
}
}


/// Adds pattern-matching-related methods to [TxnDetailsCompat].
extension TxnDetailsCompatPatterns on TxnDetailsCompat {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TxnDetailsCompat value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TxnDetailsCompat() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TxnDetailsCompat value)  $default,){
final _that = this;
switch (_that) {
case _TxnDetailsCompat():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TxnDetailsCompat value)?  $default,){
final _that = this;
switch (_that) {
case _TxnDetailsCompat() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( FeeEstimatedTransactionCompat transaction,  String transactionHashToSign,  TransactionFeeCompat fee)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TxnDetailsCompat() when $default != null:
return $default(_that.transaction,_that.transactionHashToSign,_that.fee);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( FeeEstimatedTransactionCompat transaction,  String transactionHashToSign,  TransactionFeeCompat fee)  $default,) {final _that = this;
switch (_that) {
case _TxnDetailsCompat():
return $default(_that.transaction,_that.transactionHashToSign,_that.fee);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( FeeEstimatedTransactionCompat transaction,  String transactionHashToSign,  TransactionFeeCompat fee)?  $default,) {final _that = this;
switch (_that) {
case _TxnDetailsCompat() when $default != null:
return $default(_that.transaction,_that.transactionHashToSign,_that.fee);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TxnDetailsCompat implements TxnDetailsCompat {
  const _TxnDetailsCompat({required this.transaction, required this.transactionHashToSign, required this.fee});
  factory _TxnDetailsCompat.fromJson(Map<String, dynamic> json) => _$TxnDetailsCompatFromJson(json);

@override final  FeeEstimatedTransactionCompat transaction;
@override final  String transactionHashToSign;
@override final  TransactionFeeCompat fee;

/// Create a copy of TxnDetailsCompat
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TxnDetailsCompatCopyWith<_TxnDetailsCompat> get copyWith => __$TxnDetailsCompatCopyWithImpl<_TxnDetailsCompat>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TxnDetailsCompatToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TxnDetailsCompat&&(identical(other.transaction, transaction) || other.transaction == transaction)&&(identical(other.transactionHashToSign, transactionHashToSign) || other.transactionHashToSign == transactionHashToSign)&&(identical(other.fee, fee) || other.fee == fee));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transaction,transactionHashToSign,fee);

@override
String toString() {
  return 'TxnDetailsCompat(transaction: $transaction, transactionHashToSign: $transactionHashToSign, fee: $fee)';
}


}

/// @nodoc
abstract mixin class _$TxnDetailsCompatCopyWith<$Res> implements $TxnDetailsCompatCopyWith<$Res> {
  factory _$TxnDetailsCompatCopyWith(_TxnDetailsCompat value, $Res Function(_TxnDetailsCompat) _then) = __$TxnDetailsCompatCopyWithImpl;
@override @useResult
$Res call({
 FeeEstimatedTransactionCompat transaction, String transactionHashToSign, TransactionFeeCompat fee
});


@override $FeeEstimatedTransactionCompatCopyWith<$Res> get transaction;@override $TransactionFeeCompatCopyWith<$Res> get fee;

}
/// @nodoc
class __$TxnDetailsCompatCopyWithImpl<$Res>
    implements _$TxnDetailsCompatCopyWith<$Res> {
  __$TxnDetailsCompatCopyWithImpl(this._self, this._then);

  final _TxnDetailsCompat _self;
  final $Res Function(_TxnDetailsCompat) _then;

/// Create a copy of TxnDetailsCompat
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? transaction = null,Object? transactionHashToSign = null,Object? fee = null,}) {
  return _then(_TxnDetailsCompat(
transaction: null == transaction ? _self.transaction : transaction // ignore: cast_nullable_to_non_nullable
as FeeEstimatedTransactionCompat,transactionHashToSign: null == transactionHashToSign ? _self.transactionHashToSign : transactionHashToSign // ignore: cast_nullable_to_non_nullable
as String,fee: null == fee ? _self.fee : fee // ignore: cast_nullable_to_non_nullable
as TransactionFeeCompat,
  ));
}

/// Create a copy of TxnDetailsCompat
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FeeEstimatedTransactionCompatCopyWith<$Res> get transaction {
  
  return $FeeEstimatedTransactionCompatCopyWith<$Res>(_self.transaction, (value) {
    return _then(_self.copyWith(transaction: value));
  });
}/// Create a copy of TxnDetailsCompat
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransactionFeeCompatCopyWith<$Res> get fee {
  
  return $TransactionFeeCompatCopyWith<$Res>(_self.fee, (value) {
    return _then(_self.copyWith(fee: value));
  });
}
}


/// @nodoc
mixin _$UiFieldsCompat {

 PrepareResponseAvailableCompat get routeResponse; List<TxnDetailsCompat> get route; AmountCompat get localRouteTotal; List<TransactionFeeCompat> get bridge; AmountCompat get localBridgeTotal; TxnDetailsCompat get initial; AmountCompat get localTotal;
/// Create a copy of UiFieldsCompat
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UiFieldsCompatCopyWith<UiFieldsCompat> get copyWith => _$UiFieldsCompatCopyWithImpl<UiFieldsCompat>(this as UiFieldsCompat, _$identity);

  /// Serializes this UiFieldsCompat to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UiFieldsCompat&&(identical(other.routeResponse, routeResponse) || other.routeResponse == routeResponse)&&const DeepCollectionEquality().equals(other.route, route)&&(identical(other.localRouteTotal, localRouteTotal) || other.localRouteTotal == localRouteTotal)&&const DeepCollectionEquality().equals(other.bridge, bridge)&&(identical(other.localBridgeTotal, localBridgeTotal) || other.localBridgeTotal == localBridgeTotal)&&(identical(other.initial, initial) || other.initial == initial)&&(identical(other.localTotal, localTotal) || other.localTotal == localTotal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,routeResponse,const DeepCollectionEquality().hash(route),localRouteTotal,const DeepCollectionEquality().hash(bridge),localBridgeTotal,initial,localTotal);

@override
String toString() {
  return 'UiFieldsCompat(routeResponse: $routeResponse, route: $route, localRouteTotal: $localRouteTotal, bridge: $bridge, localBridgeTotal: $localBridgeTotal, initial: $initial, localTotal: $localTotal)';
}


}

/// @nodoc
abstract mixin class $UiFieldsCompatCopyWith<$Res>  {
  factory $UiFieldsCompatCopyWith(UiFieldsCompat value, $Res Function(UiFieldsCompat) _then) = _$UiFieldsCompatCopyWithImpl;
@useResult
$Res call({
 PrepareResponseAvailableCompat routeResponse, List<TxnDetailsCompat> route, AmountCompat localRouteTotal, List<TransactionFeeCompat> bridge, AmountCompat localBridgeTotal, TxnDetailsCompat initial, AmountCompat localTotal
});


$PrepareResponseAvailableCompatCopyWith<$Res> get routeResponse;$AmountCompatCopyWith<$Res> get localRouteTotal;$AmountCompatCopyWith<$Res> get localBridgeTotal;$TxnDetailsCompatCopyWith<$Res> get initial;$AmountCompatCopyWith<$Res> get localTotal;

}
/// @nodoc
class _$UiFieldsCompatCopyWithImpl<$Res>
    implements $UiFieldsCompatCopyWith<$Res> {
  _$UiFieldsCompatCopyWithImpl(this._self, this._then);

  final UiFieldsCompat _self;
  final $Res Function(UiFieldsCompat) _then;

/// Create a copy of UiFieldsCompat
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? routeResponse = null,Object? route = null,Object? localRouteTotal = null,Object? bridge = null,Object? localBridgeTotal = null,Object? initial = null,Object? localTotal = null,}) {
  return _then(_self.copyWith(
routeResponse: null == routeResponse ? _self.routeResponse : routeResponse // ignore: cast_nullable_to_non_nullable
as PrepareResponseAvailableCompat,route: null == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as List<TxnDetailsCompat>,localRouteTotal: null == localRouteTotal ? _self.localRouteTotal : localRouteTotal // ignore: cast_nullable_to_non_nullable
as AmountCompat,bridge: null == bridge ? _self.bridge : bridge // ignore: cast_nullable_to_non_nullable
as List<TransactionFeeCompat>,localBridgeTotal: null == localBridgeTotal ? _self.localBridgeTotal : localBridgeTotal // ignore: cast_nullable_to_non_nullable
as AmountCompat,initial: null == initial ? _self.initial : initial // ignore: cast_nullable_to_non_nullable
as TxnDetailsCompat,localTotal: null == localTotal ? _self.localTotal : localTotal // ignore: cast_nullable_to_non_nullable
as AmountCompat,
  ));
}
/// Create a copy of UiFieldsCompat
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PrepareResponseAvailableCompatCopyWith<$Res> get routeResponse {
  
  return $PrepareResponseAvailableCompatCopyWith<$Res>(_self.routeResponse, (value) {
    return _then(_self.copyWith(routeResponse: value));
  });
}/// Create a copy of UiFieldsCompat
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AmountCompatCopyWith<$Res> get localRouteTotal {
  
  return $AmountCompatCopyWith<$Res>(_self.localRouteTotal, (value) {
    return _then(_self.copyWith(localRouteTotal: value));
  });
}/// Create a copy of UiFieldsCompat
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AmountCompatCopyWith<$Res> get localBridgeTotal {
  
  return $AmountCompatCopyWith<$Res>(_self.localBridgeTotal, (value) {
    return _then(_self.copyWith(localBridgeTotal: value));
  });
}/// Create a copy of UiFieldsCompat
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TxnDetailsCompatCopyWith<$Res> get initial {
  
  return $TxnDetailsCompatCopyWith<$Res>(_self.initial, (value) {
    return _then(_self.copyWith(initial: value));
  });
}/// Create a copy of UiFieldsCompat
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AmountCompatCopyWith<$Res> get localTotal {
  
  return $AmountCompatCopyWith<$Res>(_self.localTotal, (value) {
    return _then(_self.copyWith(localTotal: value));
  });
}
}


/// Adds pattern-matching-related methods to [UiFieldsCompat].
extension UiFieldsCompatPatterns on UiFieldsCompat {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UiFieldsCompat value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UiFieldsCompat() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UiFieldsCompat value)  $default,){
final _that = this;
switch (_that) {
case _UiFieldsCompat():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UiFieldsCompat value)?  $default,){
final _that = this;
switch (_that) {
case _UiFieldsCompat() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PrepareResponseAvailableCompat routeResponse,  List<TxnDetailsCompat> route,  AmountCompat localRouteTotal,  List<TransactionFeeCompat> bridge,  AmountCompat localBridgeTotal,  TxnDetailsCompat initial,  AmountCompat localTotal)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UiFieldsCompat() when $default != null:
return $default(_that.routeResponse,_that.route,_that.localRouteTotal,_that.bridge,_that.localBridgeTotal,_that.initial,_that.localTotal);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PrepareResponseAvailableCompat routeResponse,  List<TxnDetailsCompat> route,  AmountCompat localRouteTotal,  List<TransactionFeeCompat> bridge,  AmountCompat localBridgeTotal,  TxnDetailsCompat initial,  AmountCompat localTotal)  $default,) {final _that = this;
switch (_that) {
case _UiFieldsCompat():
return $default(_that.routeResponse,_that.route,_that.localRouteTotal,_that.bridge,_that.localBridgeTotal,_that.initial,_that.localTotal);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PrepareResponseAvailableCompat routeResponse,  List<TxnDetailsCompat> route,  AmountCompat localRouteTotal,  List<TransactionFeeCompat> bridge,  AmountCompat localBridgeTotal,  TxnDetailsCompat initial,  AmountCompat localTotal)?  $default,) {final _that = this;
switch (_that) {
case _UiFieldsCompat() when $default != null:
return $default(_that.routeResponse,_that.route,_that.localRouteTotal,_that.bridge,_that.localBridgeTotal,_that.initial,_that.localTotal);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UiFieldsCompat implements UiFieldsCompat {
  const _UiFieldsCompat({required this.routeResponse, required final  List<TxnDetailsCompat> route, required this.localRouteTotal, required final  List<TransactionFeeCompat> bridge, required this.localBridgeTotal, required this.initial, required this.localTotal}): _route = route,_bridge = bridge;
  factory _UiFieldsCompat.fromJson(Map<String, dynamic> json) => _$UiFieldsCompatFromJson(json);

@override final  PrepareResponseAvailableCompat routeResponse;
 final  List<TxnDetailsCompat> _route;
@override List<TxnDetailsCompat> get route {
  if (_route is EqualUnmodifiableListView) return _route;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_route);
}

@override final  AmountCompat localRouteTotal;
 final  List<TransactionFeeCompat> _bridge;
@override List<TransactionFeeCompat> get bridge {
  if (_bridge is EqualUnmodifiableListView) return _bridge;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bridge);
}

@override final  AmountCompat localBridgeTotal;
@override final  TxnDetailsCompat initial;
@override final  AmountCompat localTotal;

/// Create a copy of UiFieldsCompat
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UiFieldsCompatCopyWith<_UiFieldsCompat> get copyWith => __$UiFieldsCompatCopyWithImpl<_UiFieldsCompat>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UiFieldsCompatToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UiFieldsCompat&&(identical(other.routeResponse, routeResponse) || other.routeResponse == routeResponse)&&const DeepCollectionEquality().equals(other._route, _route)&&(identical(other.localRouteTotal, localRouteTotal) || other.localRouteTotal == localRouteTotal)&&const DeepCollectionEquality().equals(other._bridge, _bridge)&&(identical(other.localBridgeTotal, localBridgeTotal) || other.localBridgeTotal == localBridgeTotal)&&(identical(other.initial, initial) || other.initial == initial)&&(identical(other.localTotal, localTotal) || other.localTotal == localTotal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,routeResponse,const DeepCollectionEquality().hash(_route),localRouteTotal,const DeepCollectionEquality().hash(_bridge),localBridgeTotal,initial,localTotal);

@override
String toString() {
  return 'UiFieldsCompat(routeResponse: $routeResponse, route: $route, localRouteTotal: $localRouteTotal, bridge: $bridge, localBridgeTotal: $localBridgeTotal, initial: $initial, localTotal: $localTotal)';
}


}

/// @nodoc
abstract mixin class _$UiFieldsCompatCopyWith<$Res> implements $UiFieldsCompatCopyWith<$Res> {
  factory _$UiFieldsCompatCopyWith(_UiFieldsCompat value, $Res Function(_UiFieldsCompat) _then) = __$UiFieldsCompatCopyWithImpl;
@override @useResult
$Res call({
 PrepareResponseAvailableCompat routeResponse, List<TxnDetailsCompat> route, AmountCompat localRouteTotal, List<TransactionFeeCompat> bridge, AmountCompat localBridgeTotal, TxnDetailsCompat initial, AmountCompat localTotal
});


@override $PrepareResponseAvailableCompatCopyWith<$Res> get routeResponse;@override $AmountCompatCopyWith<$Res> get localRouteTotal;@override $AmountCompatCopyWith<$Res> get localBridgeTotal;@override $TxnDetailsCompatCopyWith<$Res> get initial;@override $AmountCompatCopyWith<$Res> get localTotal;

}
/// @nodoc
class __$UiFieldsCompatCopyWithImpl<$Res>
    implements _$UiFieldsCompatCopyWith<$Res> {
  __$UiFieldsCompatCopyWithImpl(this._self, this._then);

  final _UiFieldsCompat _self;
  final $Res Function(_UiFieldsCompat) _then;

/// Create a copy of UiFieldsCompat
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? routeResponse = null,Object? route = null,Object? localRouteTotal = null,Object? bridge = null,Object? localBridgeTotal = null,Object? initial = null,Object? localTotal = null,}) {
  return _then(_UiFieldsCompat(
routeResponse: null == routeResponse ? _self.routeResponse : routeResponse // ignore: cast_nullable_to_non_nullable
as PrepareResponseAvailableCompat,route: null == route ? _self._route : route // ignore: cast_nullable_to_non_nullable
as List<TxnDetailsCompat>,localRouteTotal: null == localRouteTotal ? _self.localRouteTotal : localRouteTotal // ignore: cast_nullable_to_non_nullable
as AmountCompat,bridge: null == bridge ? _self._bridge : bridge // ignore: cast_nullable_to_non_nullable
as List<TransactionFeeCompat>,localBridgeTotal: null == localBridgeTotal ? _self.localBridgeTotal : localBridgeTotal // ignore: cast_nullable_to_non_nullable
as AmountCompat,initial: null == initial ? _self.initial : initial // ignore: cast_nullable_to_non_nullable
as TxnDetailsCompat,localTotal: null == localTotal ? _self.localTotal : localTotal // ignore: cast_nullable_to_non_nullable
as AmountCompat,
  ));
}

/// Create a copy of UiFieldsCompat
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PrepareResponseAvailableCompatCopyWith<$Res> get routeResponse {
  
  return $PrepareResponseAvailableCompatCopyWith<$Res>(_self.routeResponse, (value) {
    return _then(_self.copyWith(routeResponse: value));
  });
}/// Create a copy of UiFieldsCompat
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AmountCompatCopyWith<$Res> get localRouteTotal {
  
  return $AmountCompatCopyWith<$Res>(_self.localRouteTotal, (value) {
    return _then(_self.copyWith(localRouteTotal: value));
  });
}/// Create a copy of UiFieldsCompat
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AmountCompatCopyWith<$Res> get localBridgeTotal {
  
  return $AmountCompatCopyWith<$Res>(_self.localBridgeTotal, (value) {
    return _then(_self.copyWith(localBridgeTotal: value));
  });
}/// Create a copy of UiFieldsCompat
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TxnDetailsCompatCopyWith<$Res> get initial {
  
  return $TxnDetailsCompatCopyWith<$Res>(_self.initial, (value) {
    return _then(_self.copyWith(initial: value));
  });
}/// Create a copy of UiFieldsCompat
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AmountCompatCopyWith<$Res> get localTotal {
  
  return $AmountCompatCopyWith<$Res>(_self.localTotal, (value) {
    return _then(_self.copyWith(localTotal: value));
  });
}
}

// dart format on
