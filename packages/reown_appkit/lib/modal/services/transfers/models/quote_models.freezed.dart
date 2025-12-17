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

 String get id; String get label; String get amount; String get amountFormatted; String get chainId; String get amountUsd; ExchangeAsset get currency;
/// Create a copy of QuoteFee
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuoteFeeCopyWith<QuoteFee> get copyWith => _$QuoteFeeCopyWithImpl<QuoteFee>(this as QuoteFee, _$identity);

  /// Serializes this QuoteFee to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuoteFee&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.amountFormatted, amountFormatted) || other.amountFormatted == amountFormatted)&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.amountUsd, amountUsd) || other.amountUsd == amountUsd)&&(identical(other.currency, currency) || other.currency == currency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,amount,amountFormatted,chainId,amountUsd,currency);

@override
String toString() {
  return 'QuoteFee(id: $id, label: $label, amount: $amount, amountFormatted: $amountFormatted, chainId: $chainId, amountUsd: $amountUsd, currency: $currency)';
}


}

/// @nodoc
abstract mixin class $QuoteFeeCopyWith<$Res>  {
  factory $QuoteFeeCopyWith(QuoteFee value, $Res Function(QuoteFee) _then) = _$QuoteFeeCopyWithImpl;
@useResult
$Res call({
 String id, String label, String amount, String amountFormatted, String chainId, String amountUsd, ExchangeAsset currency
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = null,Object? amount = null,Object? amountFormatted = null,Object? chainId = null,Object? amountUsd = null,Object? currency = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,amountFormatted: null == amountFormatted ? _self.amountFormatted : amountFormatted // ignore: cast_nullable_to_non_nullable
as String,chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as String,amountUsd: null == amountUsd ? _self.amountUsd : amountUsd // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String label,  String amount,  String amountFormatted,  String chainId,  String amountUsd,  ExchangeAsset currency)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuoteFee() when $default != null:
return $default(_that.id,_that.label,_that.amount,_that.amountFormatted,_that.chainId,_that.amountUsd,_that.currency);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String label,  String amount,  String amountFormatted,  String chainId,  String amountUsd,  ExchangeAsset currency)  $default,) {final _that = this;
switch (_that) {
case _QuoteFee():
return $default(_that.id,_that.label,_that.amount,_that.amountFormatted,_that.chainId,_that.amountUsd,_that.currency);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String label,  String amount,  String amountFormatted,  String chainId,  String amountUsd,  ExchangeAsset currency)?  $default,) {final _that = this;
switch (_that) {
case _QuoteFee() when $default != null:
return $default(_that.id,_that.label,_that.amount,_that.amountFormatted,_that.chainId,_that.amountUsd,_that.currency);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuoteFee implements QuoteFee {
  const _QuoteFee({required this.id, required this.label, required this.amount, required this.amountFormatted, required this.chainId, required this.amountUsd, required this.currency});
  factory _QuoteFee.fromJson(Map<String, dynamic> json) => _$QuoteFeeFromJson(json);

@override final  String id;
@override final  String label;
@override final  String amount;
@override final  String amountFormatted;
@override final  String chainId;
@override final  String amountUsd;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuoteFee&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.amountFormatted, amountFormatted) || other.amountFormatted == amountFormatted)&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.amountUsd, amountUsd) || other.amountUsd == amountUsd)&&(identical(other.currency, currency) || other.currency == currency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,amount,amountFormatted,chainId,amountUsd,currency);

@override
String toString() {
  return 'QuoteFee(id: $id, label: $label, amount: $amount, amountFormatted: $amountFormatted, chainId: $chainId, amountUsd: $amountUsd, currency: $currency)';
}


}

/// @nodoc
abstract mixin class _$QuoteFeeCopyWith<$Res> implements $QuoteFeeCopyWith<$Res> {
  factory _$QuoteFeeCopyWith(_QuoteFee value, $Res Function(_QuoteFee) _then) = __$QuoteFeeCopyWithImpl;
@override @useResult
$Res call({
 String id, String label, String amount, String amountFormatted, String chainId, String amountUsd, ExchangeAsset currency
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? amount = null,Object? amountFormatted = null,Object? chainId = null,Object? amountUsd = null,Object? currency = null,}) {
  return _then(_QuoteFee(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,amountFormatted: null == amountFormatted ? _self.amountFormatted : amountFormatted // ignore: cast_nullable_to_non_nullable
as String,chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as String,amountUsd: null == amountUsd ? _self.amountUsd : amountUsd // ignore: cast_nullable_to_non_nullable
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
mixin _$QuoteCurrency {

 String get amount; String get amountFormatted; String get chainId; String? get symbol; int? get decimals;
/// Create a copy of QuoteCurrency
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuoteCurrencyCopyWith<QuoteCurrency> get copyWith => _$QuoteCurrencyCopyWithImpl<QuoteCurrency>(this as QuoteCurrency, _$identity);

  /// Serializes this QuoteCurrency to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuoteCurrency&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.amountFormatted, amountFormatted) || other.amountFormatted == amountFormatted)&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.decimals, decimals) || other.decimals == decimals));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,amountFormatted,chainId,symbol,decimals);

@override
String toString() {
  return 'QuoteCurrency(amount: $amount, amountFormatted: $amountFormatted, chainId: $chainId, symbol: $symbol, decimals: $decimals)';
}


}

/// @nodoc
abstract mixin class $QuoteCurrencyCopyWith<$Res>  {
  factory $QuoteCurrencyCopyWith(QuoteCurrency value, $Res Function(QuoteCurrency) _then) = _$QuoteCurrencyCopyWithImpl;
@useResult
$Res call({
 String amount, String amountFormatted, String chainId, String? symbol, int? decimals
});




}
/// @nodoc
class _$QuoteCurrencyCopyWithImpl<$Res>
    implements $QuoteCurrencyCopyWith<$Res> {
  _$QuoteCurrencyCopyWithImpl(this._self, this._then);

  final QuoteCurrency _self;
  final $Res Function(QuoteCurrency) _then;

/// Create a copy of QuoteCurrency
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? amount = null,Object? amountFormatted = null,Object? chainId = null,Object? symbol = freezed,Object? decimals = freezed,}) {
  return _then(_self.copyWith(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,amountFormatted: null == amountFormatted ? _self.amountFormatted : amountFormatted // ignore: cast_nullable_to_non_nullable
as String,chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as String,symbol: freezed == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String?,decimals: freezed == decimals ? _self.decimals : decimals // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [QuoteCurrency].
extension QuoteCurrencyPatterns on QuoteCurrency {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuoteCurrency value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuoteCurrency() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuoteCurrency value)  $default,){
final _that = this;
switch (_that) {
case _QuoteCurrency():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuoteCurrency value)?  $default,){
final _that = this;
switch (_that) {
case _QuoteCurrency() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String amount,  String amountFormatted,  String chainId,  String? symbol,  int? decimals)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuoteCurrency() when $default != null:
return $default(_that.amount,_that.amountFormatted,_that.chainId,_that.symbol,_that.decimals);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String amount,  String amountFormatted,  String chainId,  String? symbol,  int? decimals)  $default,) {final _that = this;
switch (_that) {
case _QuoteCurrency():
return $default(_that.amount,_that.amountFormatted,_that.chainId,_that.symbol,_that.decimals);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String amount,  String amountFormatted,  String chainId,  String? symbol,  int? decimals)?  $default,) {final _that = this;
switch (_that) {
case _QuoteCurrency() when $default != null:
return $default(_that.amount,_that.amountFormatted,_that.chainId,_that.symbol,_that.decimals);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuoteCurrency implements QuoteCurrency {
  const _QuoteCurrency({required this.amount, required this.amountFormatted, required this.chainId, this.symbol, this.decimals});
  factory _QuoteCurrency.fromJson(Map<String, dynamic> json) => _$QuoteCurrencyFromJson(json);

@override final  String amount;
@override final  String amountFormatted;
@override final  String chainId;
@override final  String? symbol;
@override final  int? decimals;

/// Create a copy of QuoteCurrency
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuoteCurrencyCopyWith<_QuoteCurrency> get copyWith => __$QuoteCurrencyCopyWithImpl<_QuoteCurrency>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuoteCurrencyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuoteCurrency&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.amountFormatted, amountFormatted) || other.amountFormatted == amountFormatted)&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.decimals, decimals) || other.decimals == decimals));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,amountFormatted,chainId,symbol,decimals);

@override
String toString() {
  return 'QuoteCurrency(amount: $amount, amountFormatted: $amountFormatted, chainId: $chainId, symbol: $symbol, decimals: $decimals)';
}


}

/// @nodoc
abstract mixin class _$QuoteCurrencyCopyWith<$Res> implements $QuoteCurrencyCopyWith<$Res> {
  factory _$QuoteCurrencyCopyWith(_QuoteCurrency value, $Res Function(_QuoteCurrency) _then) = __$QuoteCurrencyCopyWithImpl;
@override @useResult
$Res call({
 String amount, String amountFormatted, String chainId, String? symbol, int? decimals
});




}
/// @nodoc
class __$QuoteCurrencyCopyWithImpl<$Res>
    implements _$QuoteCurrencyCopyWith<$Res> {
  __$QuoteCurrencyCopyWithImpl(this._self, this._then);

  final _QuoteCurrency _self;
  final $Res Function(_QuoteCurrency) _then;

/// Create a copy of QuoteCurrency
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? amount = null,Object? amountFormatted = null,Object? chainId = null,Object? symbol = freezed,Object? decimals = freezed,}) {
  return _then(_QuoteCurrency(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,amountFormatted: null == amountFormatted ? _self.amountFormatted : amountFormatted // ignore: cast_nullable_to_non_nullable
as String,chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as String,symbol: freezed == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String?,decimals: freezed == decimals ? _self.decimals : decimals // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$Quote {

 QuoteType get type; QuoteCurrency get origin; QuoteCurrency get destination; List<QuoteFee> get fees; String get requestId; String get depositAddress; int get timeEstimate;
/// Create a copy of Quote
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuoteCopyWith<Quote> get copyWith => _$QuoteCopyWithImpl<Quote>(this as Quote, _$identity);

  /// Serializes this Quote to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Quote&&(identical(other.type, type) || other.type == type)&&(identical(other.origin, origin) || other.origin == origin)&&(identical(other.destination, destination) || other.destination == destination)&&const DeepCollectionEquality().equals(other.fees, fees)&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.depositAddress, depositAddress) || other.depositAddress == depositAddress)&&(identical(other.timeEstimate, timeEstimate) || other.timeEstimate == timeEstimate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,origin,destination,const DeepCollectionEquality().hash(fees),requestId,depositAddress,timeEstimate);

@override
String toString() {
  return 'Quote(type: $type, origin: $origin, destination: $destination, fees: $fees, requestId: $requestId, depositAddress: $depositAddress, timeEstimate: $timeEstimate)';
}


}

/// @nodoc
abstract mixin class $QuoteCopyWith<$Res>  {
  factory $QuoteCopyWith(Quote value, $Res Function(Quote) _then) = _$QuoteCopyWithImpl;
@useResult
$Res call({
 QuoteType type, QuoteCurrency origin, QuoteCurrency destination, List<QuoteFee> fees, String requestId, String depositAddress, int timeEstimate
});


$QuoteCurrencyCopyWith<$Res> get origin;$QuoteCurrencyCopyWith<$Res> get destination;

}
/// @nodoc
class _$QuoteCopyWithImpl<$Res>
    implements $QuoteCopyWith<$Res> {
  _$QuoteCopyWithImpl(this._self, this._then);

  final Quote _self;
  final $Res Function(Quote) _then;

/// Create a copy of Quote
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? origin = null,Object? destination = null,Object? fees = null,Object? requestId = null,Object? depositAddress = null,Object? timeEstimate = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as QuoteType,origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as QuoteCurrency,destination: null == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as QuoteCurrency,fees: null == fees ? _self.fees : fees // ignore: cast_nullable_to_non_nullable
as List<QuoteFee>,requestId: null == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String,depositAddress: null == depositAddress ? _self.depositAddress : depositAddress // ignore: cast_nullable_to_non_nullable
as String,timeEstimate: null == timeEstimate ? _self.timeEstimate : timeEstimate // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of Quote
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuoteCurrencyCopyWith<$Res> get origin {
  
  return $QuoteCurrencyCopyWith<$Res>(_self.origin, (value) {
    return _then(_self.copyWith(origin: value));
  });
}/// Create a copy of Quote
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuoteCurrencyCopyWith<$Res> get destination {
  
  return $QuoteCurrencyCopyWith<$Res>(_self.destination, (value) {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( QuoteType type,  QuoteCurrency origin,  QuoteCurrency destination,  List<QuoteFee> fees,  String requestId,  String depositAddress,  int timeEstimate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Quote() when $default != null:
return $default(_that.type,_that.origin,_that.destination,_that.fees,_that.requestId,_that.depositAddress,_that.timeEstimate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( QuoteType type,  QuoteCurrency origin,  QuoteCurrency destination,  List<QuoteFee> fees,  String requestId,  String depositAddress,  int timeEstimate)  $default,) {final _that = this;
switch (_that) {
case _Quote():
return $default(_that.type,_that.origin,_that.destination,_that.fees,_that.requestId,_that.depositAddress,_that.timeEstimate);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( QuoteType type,  QuoteCurrency origin,  QuoteCurrency destination,  List<QuoteFee> fees,  String requestId,  String depositAddress,  int timeEstimate)?  $default,) {final _that = this;
switch (_that) {
case _Quote() when $default != null:
return $default(_that.type,_that.origin,_that.destination,_that.fees,_that.requestId,_that.depositAddress,_that.timeEstimate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Quote implements Quote {
  const _Quote({required this.type, required this.origin, required this.destination, required final  List<QuoteFee> fees, required this.requestId, required this.depositAddress, required this.timeEstimate}): _fees = fees;
  factory _Quote.fromJson(Map<String, dynamic> json) => _$QuoteFromJson(json);

@override final  QuoteType type;
@override final  QuoteCurrency origin;
@override final  QuoteCurrency destination;
 final  List<QuoteFee> _fees;
@override List<QuoteFee> get fees {
  if (_fees is EqualUnmodifiableListView) return _fees;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fees);
}

@override final  String requestId;
@override final  String depositAddress;
@override final  int timeEstimate;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Quote&&(identical(other.type, type) || other.type == type)&&(identical(other.origin, origin) || other.origin == origin)&&(identical(other.destination, destination) || other.destination == destination)&&const DeepCollectionEquality().equals(other._fees, _fees)&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.depositAddress, depositAddress) || other.depositAddress == depositAddress)&&(identical(other.timeEstimate, timeEstimate) || other.timeEstimate == timeEstimate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,origin,destination,const DeepCollectionEquality().hash(_fees),requestId,depositAddress,timeEstimate);

@override
String toString() {
  return 'Quote(type: $type, origin: $origin, destination: $destination, fees: $fees, requestId: $requestId, depositAddress: $depositAddress, timeEstimate: $timeEstimate)';
}


}

/// @nodoc
abstract mixin class _$QuoteCopyWith<$Res> implements $QuoteCopyWith<$Res> {
  factory _$QuoteCopyWith(_Quote value, $Res Function(_Quote) _then) = __$QuoteCopyWithImpl;
@override @useResult
$Res call({
 QuoteType type, QuoteCurrency origin, QuoteCurrency destination, List<QuoteFee> fees, String requestId, String depositAddress, int timeEstimate
});


@override $QuoteCurrencyCopyWith<$Res> get origin;@override $QuoteCurrencyCopyWith<$Res> get destination;

}
/// @nodoc
class __$QuoteCopyWithImpl<$Res>
    implements _$QuoteCopyWith<$Res> {
  __$QuoteCopyWithImpl(this._self, this._then);

  final _Quote _self;
  final $Res Function(_Quote) _then;

/// Create a copy of Quote
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? origin = null,Object? destination = null,Object? fees = null,Object? requestId = null,Object? depositAddress = null,Object? timeEstimate = null,}) {
  return _then(_Quote(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as QuoteType,origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as QuoteCurrency,destination: null == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as QuoteCurrency,fees: null == fees ? _self._fees : fees // ignore: cast_nullable_to_non_nullable
as List<QuoteFee>,requestId: null == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String,depositAddress: null == depositAddress ? _self.depositAddress : depositAddress // ignore: cast_nullable_to_non_nullable
as String,timeEstimate: null == timeEstimate ? _self.timeEstimate : timeEstimate // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of Quote
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuoteCurrencyCopyWith<$Res> get origin {
  
  return $QuoteCurrencyCopyWith<$Res>(_self.origin, (value) {
    return _then(_self.copyWith(origin: value));
  });
}/// Create a copy of Quote
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuoteCurrencyCopyWith<$Res> get destination {
  
  return $QuoteCurrencyCopyWith<$Res>(_self.destination, (value) {
    return _then(_self.copyWith(destination: value));
  });
}
}

// dart format on
