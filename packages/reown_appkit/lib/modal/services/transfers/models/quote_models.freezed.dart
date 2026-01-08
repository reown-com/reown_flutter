// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quote_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QuoteFee {

 String get id; String get label; String get amount; ExchangeAsset get currency;
/// Create a copy of QuoteFee
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuoteFeeCopyWith<QuoteFee> get copyWith => _$QuoteFeeCopyWithImpl<QuoteFee>(this as QuoteFee, _$identity);

  /// Serializes this QuoteFee to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuoteFee&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,amount,currency);

@override
String toString() {
  return 'QuoteFee(id: $id, label: $label, amount: $amount, currency: $currency)';
}


}

/// @nodoc
abstract mixin class $QuoteFeeCopyWith<$Res>  {
  factory $QuoteFeeCopyWith(QuoteFee value, $Res Function(QuoteFee) _then) = _$QuoteFeeCopyWithImpl;
@useResult
$Res call({
 String id, String label, String amount, ExchangeAsset currency
});


$ExchangeAssetCopyWith<$Res> get currency;

}
/// @nodoc
class _$QuoteFeeCopyWithImpl<$Res>
    implements $QuoteFeeCopyWith<$Res> {
  _$QuoteFeeCopyWithImpl(this._self, this._then);

  final QuoteFee _self;
  final $Res Function(QuoteFee) _then;

/// Create a copy of QuoteFee
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = null,Object? amount = null,Object? currency = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as ExchangeAsset,
  ));
}
/// Create a copy of QuoteFee
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExchangeAssetCopyWith<$Res> get currency {
  
  return $ExchangeAssetCopyWith<$Res>(_self.currency, (value) {
    return _then(_self.copyWith(currency: value));
  });
}
}


/// Adds pattern-matching-related methods to [QuoteFee].
extension QuoteFeePatterns on QuoteFee {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuoteFee value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuoteFee() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuoteFee value)  $default,){
final _that = this;
switch (_that) {
case _QuoteFee():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuoteFee value)?  $default,){
final _that = this;
switch (_that) {
case _QuoteFee() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String label,  String amount,  ExchangeAsset currency)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuoteFee() when $default != null:
return $default(_that.id,_that.label,_that.amount,_that.currency);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String label,  String amount,  ExchangeAsset currency)  $default,) {final _that = this;
switch (_that) {
case _QuoteFee():
return $default(_that.id,_that.label,_that.amount,_that.currency);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String label,  String amount,  ExchangeAsset currency)?  $default,) {final _that = this;
switch (_that) {
case _QuoteFee() when $default != null:
return $default(_that.id,_that.label,_that.amount,_that.currency);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuoteFee implements QuoteFee {
  const _QuoteFee({required this.id, required this.label, required this.amount, required this.currency});
  factory _QuoteFee.fromJson(Map<String, dynamic> json) => _$QuoteFeeFromJson(json);

@override final  String id;
@override final  String label;
@override final  String amount;
@override final  ExchangeAsset currency;

/// Create a copy of QuoteFee
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuoteFeeCopyWith<_QuoteFee> get copyWith => __$QuoteFeeCopyWithImpl<_QuoteFee>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuoteFeeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuoteFee&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,amount,currency);

@override
String toString() {
  return 'QuoteFee(id: $id, label: $label, amount: $amount, currency: $currency)';
}


}

/// @nodoc
abstract mixin class _$QuoteFeeCopyWith<$Res> implements $QuoteFeeCopyWith<$Res> {
  factory _$QuoteFeeCopyWith(_QuoteFee value, $Res Function(_QuoteFee) _then) = __$QuoteFeeCopyWithImpl;
@override @useResult
$Res call({
 String id, String label, String amount, ExchangeAsset currency
});


@override $ExchangeAssetCopyWith<$Res> get currency;

}
/// @nodoc
class __$QuoteFeeCopyWithImpl<$Res>
    implements _$QuoteFeeCopyWith<$Res> {
  __$QuoteFeeCopyWithImpl(this._self, this._then);

  final _QuoteFee _self;
  final $Res Function(_QuoteFee) _then;

/// Create a copy of QuoteFee
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? amount = null,Object? currency = null,}) {
  return _then(_QuoteFee(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as ExchangeAsset,
  ));
}

/// Create a copy of QuoteFee
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExchangeAssetCopyWith<$Res> get currency {
  
  return $ExchangeAssetCopyWith<$Res>(_self.currency, (value) {
    return _then(_self.copyWith(currency: value));
  });
}
}


/// @nodoc
mixin _$QuoteAmount {

 String get amount; ExchangeAsset get currency;
/// Create a copy of QuoteAmount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuoteAmountCopyWith<QuoteAmount> get copyWith => _$QuoteAmountCopyWithImpl<QuoteAmount>(this as QuoteAmount, _$identity);

  /// Serializes this QuoteAmount to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuoteAmount&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,currency);

@override
String toString() {
  return 'QuoteAmount(amount: $amount, currency: $currency)';
}


}

/// @nodoc
abstract mixin class $QuoteAmountCopyWith<$Res>  {
  factory $QuoteAmountCopyWith(QuoteAmount value, $Res Function(QuoteAmount) _then) = _$QuoteAmountCopyWithImpl;
@useResult
$Res call({
 String amount, ExchangeAsset currency
});


$ExchangeAssetCopyWith<$Res> get currency;

}
/// @nodoc
class _$QuoteAmountCopyWithImpl<$Res>
    implements $QuoteAmountCopyWith<$Res> {
  _$QuoteAmountCopyWithImpl(this._self, this._then);

  final QuoteAmount _self;
  final $Res Function(QuoteAmount) _then;

/// Create a copy of QuoteAmount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? amount = null,Object? currency = null,}) {
  return _then(_self.copyWith(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as ExchangeAsset,
  ));
}
/// Create a copy of QuoteAmount
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExchangeAssetCopyWith<$Res> get currency {
  
  return $ExchangeAssetCopyWith<$Res>(_self.currency, (value) {
    return _then(_self.copyWith(currency: value));
  });
}
}


/// Adds pattern-matching-related methods to [QuoteAmount].
extension QuoteAmountPatterns on QuoteAmount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuoteAmount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuoteAmount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuoteAmount value)  $default,){
final _that = this;
switch (_that) {
case _QuoteAmount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuoteAmount value)?  $default,){
final _that = this;
switch (_that) {
case _QuoteAmount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String amount,  ExchangeAsset currency)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuoteAmount() when $default != null:
return $default(_that.amount,_that.currency);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String amount,  ExchangeAsset currency)  $default,) {final _that = this;
switch (_that) {
case _QuoteAmount():
return $default(_that.amount,_that.currency);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String amount,  ExchangeAsset currency)?  $default,) {final _that = this;
switch (_that) {
case _QuoteAmount() when $default != null:
return $default(_that.amount,_that.currency);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuoteAmount implements QuoteAmount {
  const _QuoteAmount({required this.amount, required this.currency});
  factory _QuoteAmount.fromJson(Map<String, dynamic> json) => _$QuoteAmountFromJson(json);

@override final  String amount;
@override final  ExchangeAsset currency;

/// Create a copy of QuoteAmount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuoteAmountCopyWith<_QuoteAmount> get copyWith => __$QuoteAmountCopyWithImpl<_QuoteAmount>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuoteAmountToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuoteAmount&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,currency);

@override
String toString() {
  return 'QuoteAmount(amount: $amount, currency: $currency)';
}


}

/// @nodoc
abstract mixin class _$QuoteAmountCopyWith<$Res> implements $QuoteAmountCopyWith<$Res> {
  factory _$QuoteAmountCopyWith(_QuoteAmount value, $Res Function(_QuoteAmount) _then) = __$QuoteAmountCopyWithImpl;
@override @useResult
$Res call({
 String amount, ExchangeAsset currency
});


@override $ExchangeAssetCopyWith<$Res> get currency;

}
/// @nodoc
class __$QuoteAmountCopyWithImpl<$Res>
    implements _$QuoteAmountCopyWith<$Res> {
  __$QuoteAmountCopyWithImpl(this._self, this._then);

  final _QuoteAmount _self;
  final $Res Function(_QuoteAmount) _then;

/// Create a copy of QuoteAmount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? amount = null,Object? currency = null,}) {
  return _then(_QuoteAmount(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as ExchangeAsset,
  ));
}

/// Create a copy of QuoteAmount
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExchangeAssetCopyWith<$Res> get currency {
  
  return $ExchangeAssetCopyWith<$Res>(_self.currency, (value) {
    return _then(_self.copyWith(currency: value));
  });
}
}


/// @nodoc
mixin _$QuoteDeposit {

 String get amount; String get currency; String get receiver;
/// Create a copy of QuoteDeposit
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuoteDepositCopyWith<QuoteDeposit> get copyWith => _$QuoteDepositCopyWithImpl<QuoteDeposit>(this as QuoteDeposit, _$identity);

  /// Serializes this QuoteDeposit to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuoteDeposit&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.receiver, receiver) || other.receiver == receiver));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,currency,receiver);

@override
String toString() {
  return 'QuoteDeposit(amount: $amount, currency: $currency, receiver: $receiver)';
}


}

/// @nodoc
abstract mixin class $QuoteDepositCopyWith<$Res>  {
  factory $QuoteDepositCopyWith(QuoteDeposit value, $Res Function(QuoteDeposit) _then) = _$QuoteDepositCopyWithImpl;
@useResult
$Res call({
 String amount, String currency, String receiver
});




}
/// @nodoc
class _$QuoteDepositCopyWithImpl<$Res>
    implements $QuoteDepositCopyWith<$Res> {
  _$QuoteDepositCopyWithImpl(this._self, this._then);

  final QuoteDeposit _self;
  final $Res Function(QuoteDeposit) _then;

/// Create a copy of QuoteDeposit
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? amount = null,Object? currency = null,Object? receiver = null,}) {
  return _then(_self.copyWith(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,receiver: null == receiver ? _self.receiver : receiver // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [QuoteDeposit].
extension QuoteDepositPatterns on QuoteDeposit {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuoteDeposit value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuoteDeposit() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuoteDeposit value)  $default,){
final _that = this;
switch (_that) {
case _QuoteDeposit():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuoteDeposit value)?  $default,){
final _that = this;
switch (_that) {
case _QuoteDeposit() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String amount,  String currency,  String receiver)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuoteDeposit() when $default != null:
return $default(_that.amount,_that.currency,_that.receiver);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String amount,  String currency,  String receiver)  $default,) {final _that = this;
switch (_that) {
case _QuoteDeposit():
return $default(_that.amount,_that.currency,_that.receiver);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String amount,  String currency,  String receiver)?  $default,) {final _that = this;
switch (_that) {
case _QuoteDeposit() when $default != null:
return $default(_that.amount,_that.currency,_that.receiver);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuoteDeposit implements QuoteDeposit {
  const _QuoteDeposit({required this.amount, required this.currency, required this.receiver});
  factory _QuoteDeposit.fromJson(Map<String, dynamic> json) => _$QuoteDepositFromJson(json);

@override final  String amount;
@override final  String currency;
@override final  String receiver;

/// Create a copy of QuoteDeposit
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuoteDepositCopyWith<_QuoteDeposit> get copyWith => __$QuoteDepositCopyWithImpl<_QuoteDeposit>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuoteDepositToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuoteDeposit&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.receiver, receiver) || other.receiver == receiver));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,currency,receiver);

@override
String toString() {
  return 'QuoteDeposit(amount: $amount, currency: $currency, receiver: $receiver)';
}


}

/// @nodoc
abstract mixin class _$QuoteDepositCopyWith<$Res> implements $QuoteDepositCopyWith<$Res> {
  factory _$QuoteDepositCopyWith(_QuoteDeposit value, $Res Function(_QuoteDeposit) _then) = __$QuoteDepositCopyWithImpl;
@override @useResult
$Res call({
 String amount, String currency, String receiver
});




}
/// @nodoc
class __$QuoteDepositCopyWithImpl<$Res>
    implements _$QuoteDepositCopyWith<$Res> {
  __$QuoteDepositCopyWithImpl(this._self, this._then);

  final _QuoteDeposit _self;
  final $Res Function(_QuoteDeposit) _then;

/// Create a copy of QuoteDeposit
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? amount = null,Object? currency = null,Object? receiver = null,}) {
  return _then(_QuoteDeposit(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,receiver: null == receiver ? _self.receiver : receiver // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

QuoteStep _$QuoteStepFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'deposit':
          return QuoteStepDeposit.fromJson(
            json
          );
                case 'transaction':
          return QuoteStepTransaction.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'QuoteStep',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$QuoteStep {

 String get requestId;
/// Create a copy of QuoteStep
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuoteStepCopyWith<QuoteStep> get copyWith => _$QuoteStepCopyWithImpl<QuoteStep>(this as QuoteStep, _$identity);

  /// Serializes this QuoteStep to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuoteStep&&(identical(other.requestId, requestId) || other.requestId == requestId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,requestId);

@override
String toString() {
  return 'QuoteStep(requestId: $requestId)';
}


}

/// @nodoc
abstract mixin class $QuoteStepCopyWith<$Res>  {
  factory $QuoteStepCopyWith(QuoteStep value, $Res Function(QuoteStep) _then) = _$QuoteStepCopyWithImpl;
@useResult
$Res call({
 String requestId
});




}
/// @nodoc
class _$QuoteStepCopyWithImpl<$Res>
    implements $QuoteStepCopyWith<$Res> {
  _$QuoteStepCopyWithImpl(this._self, this._then);

  final QuoteStep _self;
  final $Res Function(QuoteStep) _then;

/// Create a copy of QuoteStep
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? requestId = null,}) {
  return _then(_self.copyWith(
requestId: null == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [QuoteStep].
extension QuoteStepPatterns on QuoteStep {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( QuoteStepDeposit value)?  deposit,TResult Function( QuoteStepTransaction value)?  transaction,required TResult orElse(),}){
final _that = this;
switch (_that) {
case QuoteStepDeposit() when deposit != null:
return deposit(_that);case QuoteStepTransaction() when transaction != null:
return transaction(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( QuoteStepDeposit value)  deposit,required TResult Function( QuoteStepTransaction value)  transaction,}){
final _that = this;
switch (_that) {
case QuoteStepDeposit():
return deposit(_that);case QuoteStepTransaction():
return transaction(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( QuoteStepDeposit value)?  deposit,TResult? Function( QuoteStepTransaction value)?  transaction,}){
final _that = this;
switch (_that) {
case QuoteStepDeposit() when deposit != null:
return deposit(_that);case QuoteStepTransaction() when transaction != null:
return transaction(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String requestId,  QuoteDeposit deposit)?  deposit,TResult Function( String requestId,  dynamic transaction)?  transaction,required TResult orElse(),}) {final _that = this;
switch (_that) {
case QuoteStepDeposit() when deposit != null:
return deposit(_that.requestId,_that.deposit);case QuoteStepTransaction() when transaction != null:
return transaction(_that.requestId,_that.transaction);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String requestId,  QuoteDeposit deposit)  deposit,required TResult Function( String requestId,  dynamic transaction)  transaction,}) {final _that = this;
switch (_that) {
case QuoteStepDeposit():
return deposit(_that.requestId,_that.deposit);case QuoteStepTransaction():
return transaction(_that.requestId,_that.transaction);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String requestId,  QuoteDeposit deposit)?  deposit,TResult? Function( String requestId,  dynamic transaction)?  transaction,}) {final _that = this;
switch (_that) {
case QuoteStepDeposit() when deposit != null:
return deposit(_that.requestId,_that.deposit);case QuoteStepTransaction() when transaction != null:
return transaction(_that.requestId,_that.transaction);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class QuoteStepDeposit implements QuoteStep {
  const QuoteStepDeposit({required this.requestId, required this.deposit, final  String? $type}): $type = $type ?? 'deposit';
  factory QuoteStepDeposit.fromJson(Map<String, dynamic> json) => _$QuoteStepDepositFromJson(json);

@override final  String requestId;
 final  QuoteDeposit deposit;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of QuoteStep
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuoteStepDepositCopyWith<QuoteStepDeposit> get copyWith => _$QuoteStepDepositCopyWithImpl<QuoteStepDeposit>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuoteStepDepositToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuoteStepDeposit&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.deposit, deposit) || other.deposit == deposit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,requestId,deposit);

@override
String toString() {
  return 'QuoteStep.deposit(requestId: $requestId, deposit: $deposit)';
}


}

/// @nodoc
abstract mixin class $QuoteStepDepositCopyWith<$Res> implements $QuoteStepCopyWith<$Res> {
  factory $QuoteStepDepositCopyWith(QuoteStepDeposit value, $Res Function(QuoteStepDeposit) _then) = _$QuoteStepDepositCopyWithImpl;
@override @useResult
$Res call({
 String requestId, QuoteDeposit deposit
});


$QuoteDepositCopyWith<$Res> get deposit;

}
/// @nodoc
class _$QuoteStepDepositCopyWithImpl<$Res>
    implements $QuoteStepDepositCopyWith<$Res> {
  _$QuoteStepDepositCopyWithImpl(this._self, this._then);

  final QuoteStepDeposit _self;
  final $Res Function(QuoteStepDeposit) _then;

/// Create a copy of QuoteStep
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? requestId = null,Object? deposit = null,}) {
  return _then(QuoteStepDeposit(
requestId: null == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String,deposit: null == deposit ? _self.deposit : deposit // ignore: cast_nullable_to_non_nullable
as QuoteDeposit,
  ));
}

/// Create a copy of QuoteStep
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuoteDepositCopyWith<$Res> get deposit {
  
  return $QuoteDepositCopyWith<$Res>(_self.deposit, (value) {
    return _then(_self.copyWith(deposit: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class QuoteStepTransaction implements QuoteStep {
  const QuoteStepTransaction({required this.requestId, required this.transaction, final  String? $type}): $type = $type ?? 'transaction';
  factory QuoteStepTransaction.fromJson(Map<String, dynamic> json) => _$QuoteStepTransactionFromJson(json);

@override final  String requestId;
 final  dynamic transaction;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of QuoteStep
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuoteStepTransactionCopyWith<QuoteStepTransaction> get copyWith => _$QuoteStepTransactionCopyWithImpl<QuoteStepTransaction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuoteStepTransactionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuoteStepTransaction&&(identical(other.requestId, requestId) || other.requestId == requestId)&&const DeepCollectionEquality().equals(other.transaction, transaction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,requestId,const DeepCollectionEquality().hash(transaction));

@override
String toString() {
  return 'QuoteStep.transaction(requestId: $requestId, transaction: $transaction)';
}


}

/// @nodoc
abstract mixin class $QuoteStepTransactionCopyWith<$Res> implements $QuoteStepCopyWith<$Res> {
  factory $QuoteStepTransactionCopyWith(QuoteStepTransaction value, $Res Function(QuoteStepTransaction) _then) = _$QuoteStepTransactionCopyWithImpl;
@override @useResult
$Res call({
 String requestId, dynamic transaction
});




}
/// @nodoc
class _$QuoteStepTransactionCopyWithImpl<$Res>
    implements $QuoteStepTransactionCopyWith<$Res> {
  _$QuoteStepTransactionCopyWithImpl(this._self, this._then);

  final QuoteStepTransaction _self;
  final $Res Function(QuoteStepTransaction) _then;

/// Create a copy of QuoteStep
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? requestId = null,Object? transaction = freezed,}) {
  return _then(QuoteStepTransaction(
requestId: null == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String,transaction: freezed == transaction ? _self.transaction : transaction // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}


/// @nodoc
mixin _$Quote {

@JsonKey(includeIfNull: false) QuoteType? get type; QuoteAmount get origin; QuoteAmount get destination; List<QuoteStep> get steps; List<QuoteFee> get fees; int get timeInSeconds;
/// Create a copy of Quote
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuoteCopyWith<Quote> get copyWith => _$QuoteCopyWithImpl<Quote>(this as Quote, _$identity);

  /// Serializes this Quote to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Quote&&(identical(other.type, type) || other.type == type)&&(identical(other.origin, origin) || other.origin == origin)&&(identical(other.destination, destination) || other.destination == destination)&&const DeepCollectionEquality().equals(other.steps, steps)&&const DeepCollectionEquality().equals(other.fees, fees)&&(identical(other.timeInSeconds, timeInSeconds) || other.timeInSeconds == timeInSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,origin,destination,const DeepCollectionEquality().hash(steps),const DeepCollectionEquality().hash(fees),timeInSeconds);

@override
String toString() {
  return 'Quote(type: $type, origin: $origin, destination: $destination, steps: $steps, fees: $fees, timeInSeconds: $timeInSeconds)';
}


}

/// @nodoc
abstract mixin class $QuoteCopyWith<$Res>  {
  factory $QuoteCopyWith(Quote value, $Res Function(Quote) _then) = _$QuoteCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeIfNull: false) QuoteType? type, QuoteAmount origin, QuoteAmount destination, List<QuoteStep> steps, List<QuoteFee> fees, int timeInSeconds
});


$QuoteAmountCopyWith<$Res> get origin;$QuoteAmountCopyWith<$Res> get destination;

}
/// @nodoc
class _$QuoteCopyWithImpl<$Res>
    implements $QuoteCopyWith<$Res> {
  _$QuoteCopyWithImpl(this._self, this._then);

  final Quote _self;
  final $Res Function(Quote) _then;

/// Create a copy of Quote
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = freezed,Object? origin = null,Object? destination = null,Object? steps = null,Object? fees = null,Object? timeInSeconds = null,}) {
  return _then(_self.copyWith(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as QuoteType?,origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as QuoteAmount,destination: null == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as QuoteAmount,steps: null == steps ? _self.steps : steps // ignore: cast_nullable_to_non_nullable
as List<QuoteStep>,fees: null == fees ? _self.fees : fees // ignore: cast_nullable_to_non_nullable
as List<QuoteFee>,timeInSeconds: null == timeInSeconds ? _self.timeInSeconds : timeInSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of Quote
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuoteAmountCopyWith<$Res> get origin {
  
  return $QuoteAmountCopyWith<$Res>(_self.origin, (value) {
    return _then(_self.copyWith(origin: value));
  });
}/// Create a copy of Quote
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuoteAmountCopyWith<$Res> get destination {
  
  return $QuoteAmountCopyWith<$Res>(_self.destination, (value) {
    return _then(_self.copyWith(destination: value));
  });
}
}


/// Adds pattern-matching-related methods to [Quote].
extension QuotePatterns on Quote {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Quote value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Quote() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Quote value)  $default,){
final _that = this;
switch (_that) {
case _Quote():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Quote value)?  $default,){
final _that = this;
switch (_that) {
case _Quote() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  QuoteType? type,  QuoteAmount origin,  QuoteAmount destination,  List<QuoteStep> steps,  List<QuoteFee> fees,  int timeInSeconds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Quote() when $default != null:
return $default(_that.type,_that.origin,_that.destination,_that.steps,_that.fees,_that.timeInSeconds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  QuoteType? type,  QuoteAmount origin,  QuoteAmount destination,  List<QuoteStep> steps,  List<QuoteFee> fees,  int timeInSeconds)  $default,) {final _that = this;
switch (_that) {
case _Quote():
return $default(_that.type,_that.origin,_that.destination,_that.steps,_that.fees,_that.timeInSeconds);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeIfNull: false)  QuoteType? type,  QuoteAmount origin,  QuoteAmount destination,  List<QuoteStep> steps,  List<QuoteFee> fees,  int timeInSeconds)?  $default,) {final _that = this;
switch (_that) {
case _Quote() when $default != null:
return $default(_that.type,_that.origin,_that.destination,_that.steps,_that.fees,_that.timeInSeconds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Quote implements Quote {
  const _Quote({@JsonKey(includeIfNull: false) this.type, required this.origin, required this.destination, required final  List<QuoteStep> steps, required final  List<QuoteFee> fees, required this.timeInSeconds}): _steps = steps,_fees = fees;
  factory _Quote.fromJson(Map<String, dynamic> json) => _$QuoteFromJson(json);

@override@JsonKey(includeIfNull: false) final  QuoteType? type;
@override final  QuoteAmount origin;
@override final  QuoteAmount destination;
 final  List<QuoteStep> _steps;
@override List<QuoteStep> get steps {
  if (_steps is EqualUnmodifiableListView) return _steps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_steps);
}

 final  List<QuoteFee> _fees;
@override List<QuoteFee> get fees {
  if (_fees is EqualUnmodifiableListView) return _fees;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fees);
}

@override final  int timeInSeconds;

/// Create a copy of Quote
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuoteCopyWith<_Quote> get copyWith => __$QuoteCopyWithImpl<_Quote>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuoteToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Quote&&(identical(other.type, type) || other.type == type)&&(identical(other.origin, origin) || other.origin == origin)&&(identical(other.destination, destination) || other.destination == destination)&&const DeepCollectionEquality().equals(other._steps, _steps)&&const DeepCollectionEquality().equals(other._fees, _fees)&&(identical(other.timeInSeconds, timeInSeconds) || other.timeInSeconds == timeInSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,origin,destination,const DeepCollectionEquality().hash(_steps),const DeepCollectionEquality().hash(_fees),timeInSeconds);

@override
String toString() {
  return 'Quote(type: $type, origin: $origin, destination: $destination, steps: $steps, fees: $fees, timeInSeconds: $timeInSeconds)';
}


}

/// @nodoc
abstract mixin class _$QuoteCopyWith<$Res> implements $QuoteCopyWith<$Res> {
  factory _$QuoteCopyWith(_Quote value, $Res Function(_Quote) _then) = __$QuoteCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeIfNull: false) QuoteType? type, QuoteAmount origin, QuoteAmount destination, List<QuoteStep> steps, List<QuoteFee> fees, int timeInSeconds
});


@override $QuoteAmountCopyWith<$Res> get origin;@override $QuoteAmountCopyWith<$Res> get destination;

}
/// @nodoc
class __$QuoteCopyWithImpl<$Res>
    implements _$QuoteCopyWith<$Res> {
  __$QuoteCopyWithImpl(this._self, this._then);

  final _Quote _self;
  final $Res Function(_Quote) _then;

/// Create a copy of Quote
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = freezed,Object? origin = null,Object? destination = null,Object? steps = null,Object? fees = null,Object? timeInSeconds = null,}) {
  return _then(_Quote(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as QuoteType?,origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as QuoteAmount,destination: null == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as QuoteAmount,steps: null == steps ? _self._steps : steps // ignore: cast_nullable_to_non_nullable
as List<QuoteStep>,fees: null == fees ? _self._fees : fees // ignore: cast_nullable_to_non_nullable
as List<QuoteFee>,timeInSeconds: null == timeInSeconds ? _self.timeInSeconds : timeInSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of Quote
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuoteAmountCopyWith<$Res> get origin {
  
  return $QuoteAmountCopyWith<$Res>(_self.origin, (value) {
    return _then(_self.copyWith(origin: value));
  });
}/// Create a copy of Quote
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuoteAmountCopyWith<$Res> get destination {
  
  return $QuoteAmountCopyWith<$Res>(_self.destination, (value) {
    return _then(_self.copyWith(destination: value));
  });
}
}

// dart format on
