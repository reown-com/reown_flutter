// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'walletpay_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DisplayData {

 List<PaymentItem> get paymentOptions;
/// Create a copy of DisplayData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DisplayDataCopyWith<DisplayData> get copyWith => _$DisplayDataCopyWithImpl<DisplayData>(this as DisplayData, _$identity);

  /// Serializes this DisplayData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DisplayData&&const DeepCollectionEquality().equals(other.paymentOptions, paymentOptions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(paymentOptions));

@override
String toString() {
  return 'DisplayData(paymentOptions: $paymentOptions)';
}


}

/// @nodoc
abstract mixin class $DisplayDataCopyWith<$Res>  {
  factory $DisplayDataCopyWith(DisplayData value, $Res Function(DisplayData) _then) = _$DisplayDataCopyWithImpl;
@useResult
$Res call({
 List<PaymentItem> paymentOptions
});




}
/// @nodoc
class _$DisplayDataCopyWithImpl<$Res>
    implements $DisplayDataCopyWith<$Res> {
  _$DisplayDataCopyWithImpl(this._self, this._then);

  final DisplayData _self;
  final $Res Function(DisplayData) _then;

/// Create a copy of DisplayData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? paymentOptions = null,}) {
  return _then(_self.copyWith(
paymentOptions: null == paymentOptions ? _self.paymentOptions : paymentOptions // ignore: cast_nullable_to_non_nullable
as List<PaymentItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [DisplayData].
extension DisplayDataPatterns on DisplayData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DisplayData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DisplayData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DisplayData value)  $default,){
final _that = this;
switch (_that) {
case _DisplayData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DisplayData value)?  $default,){
final _that = this;
switch (_that) {
case _DisplayData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<PaymentItem> paymentOptions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DisplayData() when $default != null:
return $default(_that.paymentOptions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<PaymentItem> paymentOptions)  $default,) {final _that = this;
switch (_that) {
case _DisplayData():
return $default(_that.paymentOptions);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<PaymentItem> paymentOptions)?  $default,) {final _that = this;
switch (_that) {
case _DisplayData() when $default != null:
return $default(_that.paymentOptions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DisplayData implements DisplayData {
  const _DisplayData({required final  List<PaymentItem> paymentOptions}): _paymentOptions = paymentOptions;
  factory _DisplayData.fromJson(Map<String, dynamic> json) => _$DisplayDataFromJson(json);

 final  List<PaymentItem> _paymentOptions;
@override List<PaymentItem> get paymentOptions {
  if (_paymentOptions is EqualUnmodifiableListView) return _paymentOptions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_paymentOptions);
}


/// Create a copy of DisplayData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DisplayDataCopyWith<_DisplayData> get copyWith => __$DisplayDataCopyWithImpl<_DisplayData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DisplayDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DisplayData&&const DeepCollectionEquality().equals(other._paymentOptions, _paymentOptions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_paymentOptions));

@override
String toString() {
  return 'DisplayData(paymentOptions: $paymentOptions)';
}


}

/// @nodoc
abstract mixin class _$DisplayDataCopyWith<$Res> implements $DisplayDataCopyWith<$Res> {
  factory _$DisplayDataCopyWith(_DisplayData value, $Res Function(_DisplayData) _then) = __$DisplayDataCopyWithImpl;
@override @useResult
$Res call({
 List<PaymentItem> paymentOptions
});




}
/// @nodoc
class __$DisplayDataCopyWithImpl<$Res>
    implements _$DisplayDataCopyWith<$Res> {
  __$DisplayDataCopyWithImpl(this._self, this._then);

  final _DisplayData _self;
  final $Res Function(_DisplayData) _then;

/// Create a copy of DisplayData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? paymentOptions = null,}) {
  return _then(_DisplayData(
paymentOptions: null == paymentOptions ? _self._paymentOptions : paymentOptions // ignore: cast_nullable_to_non_nullable
as List<PaymentItem>,
  ));
}


}


/// @nodoc
mixin _$PaymentItem {

 String get asset;// hex string like "0x5F5E100"
 String get amount; String? get chain; String? get symbol; ParsedDataPaymentItem? get parsedData;
/// Create a copy of PaymentItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentItemCopyWith<PaymentItem> get copyWith => _$PaymentItemCopyWithImpl<PaymentItem>(this as PaymentItem, _$identity);

  /// Serializes this PaymentItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentItem&&(identical(other.asset, asset) || other.asset == asset)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.chain, chain) || other.chain == chain)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.parsedData, parsedData) || other.parsedData == parsedData));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,asset,amount,chain,symbol,parsedData);

@override
String toString() {
  return 'PaymentItem(asset: $asset, amount: $amount, chain: $chain, symbol: $symbol, parsedData: $parsedData)';
}


}

/// @nodoc
abstract mixin class $PaymentItemCopyWith<$Res>  {
  factory $PaymentItemCopyWith(PaymentItem value, $Res Function(PaymentItem) _then) = _$PaymentItemCopyWithImpl;
@useResult
$Res call({
 String asset, String amount, String? chain, String? symbol, ParsedDataPaymentItem? parsedData
});


$ParsedDataPaymentItemCopyWith<$Res>? get parsedData;

}
/// @nodoc
class _$PaymentItemCopyWithImpl<$Res>
    implements $PaymentItemCopyWith<$Res> {
  _$PaymentItemCopyWithImpl(this._self, this._then);

  final PaymentItem _self;
  final $Res Function(PaymentItem) _then;

/// Create a copy of PaymentItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? asset = null,Object? amount = null,Object? chain = freezed,Object? symbol = freezed,Object? parsedData = freezed,}) {
  return _then(_self.copyWith(
asset: null == asset ? _self.asset : asset // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,chain: freezed == chain ? _self.chain : chain // ignore: cast_nullable_to_non_nullable
as String?,symbol: freezed == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String?,parsedData: freezed == parsedData ? _self.parsedData : parsedData // ignore: cast_nullable_to_non_nullable
as ParsedDataPaymentItem?,
  ));
}
/// Create a copy of PaymentItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParsedDataPaymentItemCopyWith<$Res>? get parsedData {
    if (_self.parsedData == null) {
    return null;
  }

  return $ParsedDataPaymentItemCopyWith<$Res>(_self.parsedData!, (value) {
    return _then(_self.copyWith(parsedData: value));
  });
}
}


/// Adds pattern-matching-related methods to [PaymentItem].
extension PaymentItemPatterns on PaymentItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentItem value)  $default,){
final _that = this;
switch (_that) {
case _PaymentItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentItem value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String asset,  String amount,  String? chain,  String? symbol,  ParsedDataPaymentItem? parsedData)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentItem() when $default != null:
return $default(_that.asset,_that.amount,_that.chain,_that.symbol,_that.parsedData);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String asset,  String amount,  String? chain,  String? symbol,  ParsedDataPaymentItem? parsedData)  $default,) {final _that = this;
switch (_that) {
case _PaymentItem():
return $default(_that.asset,_that.amount,_that.chain,_that.symbol,_that.parsedData);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String asset,  String amount,  String? chain,  String? symbol,  ParsedDataPaymentItem? parsedData)?  $default,) {final _that = this;
switch (_that) {
case _PaymentItem() when $default != null:
return $default(_that.asset,_that.amount,_that.chain,_that.symbol,_that.parsedData);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentItem implements PaymentItem {
  const _PaymentItem({required this.asset, required this.amount, this.chain, this.symbol, this.parsedData});
  factory _PaymentItem.fromJson(Map<String, dynamic> json) => _$PaymentItemFromJson(json);

@override final  String asset;
// hex string like "0x5F5E100"
@override final  String amount;
@override final  String? chain;
@override final  String? symbol;
@override final  ParsedDataPaymentItem? parsedData;

/// Create a copy of PaymentItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentItemCopyWith<_PaymentItem> get copyWith => __$PaymentItemCopyWithImpl<_PaymentItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentItem&&(identical(other.asset, asset) || other.asset == asset)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.chain, chain) || other.chain == chain)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.parsedData, parsedData) || other.parsedData == parsedData));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,asset,amount,chain,symbol,parsedData);

@override
String toString() {
  return 'PaymentItem(asset: $asset, amount: $amount, chain: $chain, symbol: $symbol, parsedData: $parsedData)';
}


}

/// @nodoc
abstract mixin class _$PaymentItemCopyWith<$Res> implements $PaymentItemCopyWith<$Res> {
  factory _$PaymentItemCopyWith(_PaymentItem value, $Res Function(_PaymentItem) _then) = __$PaymentItemCopyWithImpl;
@override @useResult
$Res call({
 String asset, String amount, String? chain, String? symbol, ParsedDataPaymentItem? parsedData
});


@override $ParsedDataPaymentItemCopyWith<$Res>? get parsedData;

}
/// @nodoc
class __$PaymentItemCopyWithImpl<$Res>
    implements _$PaymentItemCopyWith<$Res> {
  __$PaymentItemCopyWithImpl(this._self, this._then);

  final _PaymentItem _self;
  final $Res Function(_PaymentItem) _then;

/// Create a copy of PaymentItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? asset = null,Object? amount = null,Object? chain = freezed,Object? symbol = freezed,Object? parsedData = freezed,}) {
  return _then(_PaymentItem(
asset: null == asset ? _self.asset : asset // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,chain: freezed == chain ? _self.chain : chain // ignore: cast_nullable_to_non_nullable
as String?,symbol: freezed == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String?,parsedData: freezed == parsedData ? _self.parsedData : parsedData // ignore: cast_nullable_to_non_nullable
as ParsedDataPaymentItem?,
  ));
}

/// Create a copy of PaymentItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParsedDataPaymentItemCopyWith<$Res>? get parsedData {
    if (_self.parsedData == null) {
    return null;
  }

  return $ParsedDataPaymentItemCopyWith<$Res>(_self.parsedData!, (value) {
    return _then(_self.copyWith(parsedData: value));
  });
}
}


/// @nodoc
mixin _$ParsedDataPaymentItem {

 String get assetName;// decimal or human readable amount like "100"
 String get amount; String get chain;
/// Create a copy of ParsedDataPaymentItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParsedDataPaymentItemCopyWith<ParsedDataPaymentItem> get copyWith => _$ParsedDataPaymentItemCopyWithImpl<ParsedDataPaymentItem>(this as ParsedDataPaymentItem, _$identity);

  /// Serializes this ParsedDataPaymentItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParsedDataPaymentItem&&(identical(other.assetName, assetName) || other.assetName == assetName)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.chain, chain) || other.chain == chain));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,assetName,amount,chain);

@override
String toString() {
  return 'ParsedDataPaymentItem(assetName: $assetName, amount: $amount, chain: $chain)';
}


}

/// @nodoc
abstract mixin class $ParsedDataPaymentItemCopyWith<$Res>  {
  factory $ParsedDataPaymentItemCopyWith(ParsedDataPaymentItem value, $Res Function(ParsedDataPaymentItem) _then) = _$ParsedDataPaymentItemCopyWithImpl;
@useResult
$Res call({
 String assetName, String amount, String chain
});




}
/// @nodoc
class _$ParsedDataPaymentItemCopyWithImpl<$Res>
    implements $ParsedDataPaymentItemCopyWith<$Res> {
  _$ParsedDataPaymentItemCopyWithImpl(this._self, this._then);

  final ParsedDataPaymentItem _self;
  final $Res Function(ParsedDataPaymentItem) _then;

/// Create a copy of ParsedDataPaymentItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? assetName = null,Object? amount = null,Object? chain = null,}) {
  return _then(_self.copyWith(
assetName: null == assetName ? _self.assetName : assetName // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,chain: null == chain ? _self.chain : chain // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ParsedDataPaymentItem].
extension ParsedDataPaymentItemPatterns on ParsedDataPaymentItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ParsedDataPaymentItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ParsedDataPaymentItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ParsedDataPaymentItem value)  $default,){
final _that = this;
switch (_that) {
case _ParsedDataPaymentItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ParsedDataPaymentItem value)?  $default,){
final _that = this;
switch (_that) {
case _ParsedDataPaymentItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String assetName,  String amount,  String chain)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ParsedDataPaymentItem() when $default != null:
return $default(_that.assetName,_that.amount,_that.chain);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String assetName,  String amount,  String chain)  $default,) {final _that = this;
switch (_that) {
case _ParsedDataPaymentItem():
return $default(_that.assetName,_that.amount,_that.chain);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String assetName,  String amount,  String chain)?  $default,) {final _that = this;
switch (_that) {
case _ParsedDataPaymentItem() when $default != null:
return $default(_that.assetName,_that.amount,_that.chain);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ParsedDataPaymentItem implements ParsedDataPaymentItem {
  const _ParsedDataPaymentItem({required this.assetName, required this.amount, required this.chain});
  factory _ParsedDataPaymentItem.fromJson(Map<String, dynamic> json) => _$ParsedDataPaymentItemFromJson(json);

@override final  String assetName;
// decimal or human readable amount like "100"
@override final  String amount;
@override final  String chain;

/// Create a copy of ParsedDataPaymentItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ParsedDataPaymentItemCopyWith<_ParsedDataPaymentItem> get copyWith => __$ParsedDataPaymentItemCopyWithImpl<_ParsedDataPaymentItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ParsedDataPaymentItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ParsedDataPaymentItem&&(identical(other.assetName, assetName) || other.assetName == assetName)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.chain, chain) || other.chain == chain));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,assetName,amount,chain);

@override
String toString() {
  return 'ParsedDataPaymentItem(assetName: $assetName, amount: $amount, chain: $chain)';
}


}

/// @nodoc
abstract mixin class _$ParsedDataPaymentItemCopyWith<$Res> implements $ParsedDataPaymentItemCopyWith<$Res> {
  factory _$ParsedDataPaymentItemCopyWith(_ParsedDataPaymentItem value, $Res Function(_ParsedDataPaymentItem) _then) = __$ParsedDataPaymentItemCopyWithImpl;
@override @useResult
$Res call({
 String assetName, String amount, String chain
});




}
/// @nodoc
class __$ParsedDataPaymentItemCopyWithImpl<$Res>
    implements _$ParsedDataPaymentItemCopyWith<$Res> {
  __$ParsedDataPaymentItemCopyWithImpl(this._self, this._then);

  final _ParsedDataPaymentItem _self;
  final $Res Function(_ParsedDataPaymentItem) _then;

/// Create a copy of ParsedDataPaymentItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? assetName = null,Object? amount = null,Object? chain = null,}) {
  return _then(_ParsedDataPaymentItem(
assetName: null == assetName ? _self.assetName : assetName // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,chain: null == chain ? _self.chain : chain // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$WalletPayAction {

 String get method; dynamic get data; String get hash;
/// Create a copy of WalletPayAction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WalletPayActionCopyWith<WalletPayAction> get copyWith => _$WalletPayActionCopyWithImpl<WalletPayAction>(this as WalletPayAction, _$identity);

  /// Serializes this WalletPayAction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WalletPayAction&&(identical(other.method, method) || other.method == method)&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.hash, hash) || other.hash == hash));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,method,const DeepCollectionEquality().hash(data),hash);

@override
String toString() {
  return 'WalletPayAction(method: $method, data: $data, hash: $hash)';
}


}

/// @nodoc
abstract mixin class $WalletPayActionCopyWith<$Res>  {
  factory $WalletPayActionCopyWith(WalletPayAction value, $Res Function(WalletPayAction) _then) = _$WalletPayActionCopyWithImpl;
@useResult
$Res call({
 String method, dynamic data, String hash
});




}
/// @nodoc
class _$WalletPayActionCopyWithImpl<$Res>
    implements $WalletPayActionCopyWith<$Res> {
  _$WalletPayActionCopyWithImpl(this._self, this._then);

  final WalletPayAction _self;
  final $Res Function(WalletPayAction) _then;

/// Create a copy of WalletPayAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? method = null,Object? data = freezed,Object? hash = null,}) {
  return _then(_self.copyWith(
method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as dynamic,hash: null == hash ? _self.hash : hash // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WalletPayAction].
extension WalletPayActionPatterns on WalletPayAction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WalletPayAction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WalletPayAction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WalletPayAction value)  $default,){
final _that = this;
switch (_that) {
case _WalletPayAction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WalletPayAction value)?  $default,){
final _that = this;
switch (_that) {
case _WalletPayAction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String method,  dynamic data,  String hash)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WalletPayAction() when $default != null:
return $default(_that.method,_that.data,_that.hash);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String method,  dynamic data,  String hash)  $default,) {final _that = this;
switch (_that) {
case _WalletPayAction():
return $default(_that.method,_that.data,_that.hash);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String method,  dynamic data,  String hash)?  $default,) {final _that = this;
switch (_that) {
case _WalletPayAction() when $default != null:
return $default(_that.method,_that.data,_that.hash);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WalletPayAction implements WalletPayAction {
  const _WalletPayAction({required this.method, required this.data, required this.hash});
  factory _WalletPayAction.fromJson(Map<String, dynamic> json) => _$WalletPayActionFromJson(json);

@override final  String method;
@override final  dynamic data;
@override final  String hash;

/// Create a copy of WalletPayAction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WalletPayActionCopyWith<_WalletPayAction> get copyWith => __$WalletPayActionCopyWithImpl<_WalletPayAction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WalletPayActionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WalletPayAction&&(identical(other.method, method) || other.method == method)&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.hash, hash) || other.hash == hash));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,method,const DeepCollectionEquality().hash(data),hash);

@override
String toString() {
  return 'WalletPayAction(method: $method, data: $data, hash: $hash)';
}


}

/// @nodoc
abstract mixin class _$WalletPayActionCopyWith<$Res> implements $WalletPayActionCopyWith<$Res> {
  factory _$WalletPayActionCopyWith(_WalletPayAction value, $Res Function(_WalletPayAction) _then) = __$WalletPayActionCopyWithImpl;
@override @useResult
$Res call({
 String method, dynamic data, String hash
});




}
/// @nodoc
class __$WalletPayActionCopyWithImpl<$Res>
    implements _$WalletPayActionCopyWith<$Res> {
  __$WalletPayActionCopyWithImpl(this._self, this._then);

  final _WalletPayAction _self;
  final $Res Function(_WalletPayAction) _then;

/// Create a copy of WalletPayAction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? method = null,Object? data = freezed,Object? hash = null,}) {
  return _then(_WalletPayAction(
method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as dynamic,hash: null == hash ? _self.hash : hash // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$TransferData {

 String? get from; String? get to;// human-readable or decimal value (kept as String to preserve formatting)
 String? get value;// "not before" unix timestamp (seconds)
 int? get nbf;// expiration unix timestamp (seconds)
 int? get exp;// hex nonce
 String? get nonce;
/// Create a copy of TransferData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransferDataCopyWith<TransferData> get copyWith => _$TransferDataCopyWithImpl<TransferData>(this as TransferData, _$identity);

  /// Serializes this TransferData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransferData&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.value, value) || other.value == value)&&(identical(other.nbf, nbf) || other.nbf == nbf)&&(identical(other.exp, exp) || other.exp == exp)&&(identical(other.nonce, nonce) || other.nonce == nonce));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,from,to,value,nbf,exp,nonce);

@override
String toString() {
  return 'TransferData(from: $from, to: $to, value: $value, nbf: $nbf, exp: $exp, nonce: $nonce)';
}


}

/// @nodoc
abstract mixin class $TransferDataCopyWith<$Res>  {
  factory $TransferDataCopyWith(TransferData value, $Res Function(TransferData) _then) = _$TransferDataCopyWithImpl;
@useResult
$Res call({
 String? from, String? to, String? value, int? nbf, int? exp, String? nonce
});




}
/// @nodoc
class _$TransferDataCopyWithImpl<$Res>
    implements $TransferDataCopyWith<$Res> {
  _$TransferDataCopyWithImpl(this._self, this._then);

  final TransferData _self;
  final $Res Function(TransferData) _then;

/// Create a copy of TransferData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? from = freezed,Object? to = freezed,Object? value = freezed,Object? nbf = freezed,Object? exp = freezed,Object? nonce = freezed,}) {
  return _then(_self.copyWith(
from: freezed == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String?,to: freezed == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String?,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String?,nbf: freezed == nbf ? _self.nbf : nbf // ignore: cast_nullable_to_non_nullable
as int?,exp: freezed == exp ? _self.exp : exp // ignore: cast_nullable_to_non_nullable
as int?,nonce: freezed == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TransferData].
extension TransferDataPatterns on TransferData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransferData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransferData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransferData value)  $default,){
final _that = this;
switch (_that) {
case _TransferData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransferData value)?  $default,){
final _that = this;
switch (_that) {
case _TransferData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? from,  String? to,  String? value,  int? nbf,  int? exp,  String? nonce)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransferData() when $default != null:
return $default(_that.from,_that.to,_that.value,_that.nbf,_that.exp,_that.nonce);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? from,  String? to,  String? value,  int? nbf,  int? exp,  String? nonce)  $default,) {final _that = this;
switch (_that) {
case _TransferData():
return $default(_that.from,_that.to,_that.value,_that.nbf,_that.exp,_that.nonce);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? from,  String? to,  String? value,  int? nbf,  int? exp,  String? nonce)?  $default,) {final _that = this;
switch (_that) {
case _TransferData() when $default != null:
return $default(_that.from,_that.to,_that.value,_that.nbf,_that.exp,_that.nonce);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TransferData implements TransferData {
  const _TransferData({this.from, this.to, this.value, this.nbf, this.exp, this.nonce});
  factory _TransferData.fromJson(Map<String, dynamic> json) => _$TransferDataFromJson(json);

@override final  String? from;
@override final  String? to;
// human-readable or decimal value (kept as String to preserve formatting)
@override final  String? value;
// "not before" unix timestamp (seconds)
@override final  int? nbf;
// expiration unix timestamp (seconds)
@override final  int? exp;
// hex nonce
@override final  String? nonce;

/// Create a copy of TransferData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransferDataCopyWith<_TransferData> get copyWith => __$TransferDataCopyWithImpl<_TransferData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransferDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransferData&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.value, value) || other.value == value)&&(identical(other.nbf, nbf) || other.nbf == nbf)&&(identical(other.exp, exp) || other.exp == exp)&&(identical(other.nonce, nonce) || other.nonce == nonce));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,from,to,value,nbf,exp,nonce);

@override
String toString() {
  return 'TransferData(from: $from, to: $to, value: $value, nbf: $nbf, exp: $exp, nonce: $nonce)';
}


}

/// @nodoc
abstract mixin class _$TransferDataCopyWith<$Res> implements $TransferDataCopyWith<$Res> {
  factory _$TransferDataCopyWith(_TransferData value, $Res Function(_TransferData) _then) = __$TransferDataCopyWithImpl;
@override @useResult
$Res call({
 String? from, String? to, String? value, int? nbf, int? exp, String? nonce
});




}
/// @nodoc
class __$TransferDataCopyWithImpl<$Res>
    implements _$TransferDataCopyWith<$Res> {
  __$TransferDataCopyWithImpl(this._self, this._then);

  final _TransferData _self;
  final $Res Function(_TransferData) _then;

/// Create a copy of TransferData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? from = freezed,Object? to = freezed,Object? value = freezed,Object? nbf = freezed,Object? exp = freezed,Object? nonce = freezed,}) {
  return _then(_TransferData(
from: freezed == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String?,to: freezed == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String?,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String?,nbf: freezed == nbf ? _self.nbf : nbf // ignore: cast_nullable_to_non_nullable
as int?,exp: freezed == exp ? _self.exp : exp // ignore: cast_nullable_to_non_nullable
as int?,nonce: freezed == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TransferConfirmation {

// e.g. "erc3009-authorization"
 String get type; String get data;// hex hash string
 String get hash;
/// Create a copy of TransferConfirmation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransferConfirmationCopyWith<TransferConfirmation> get copyWith => _$TransferConfirmationCopyWithImpl<TransferConfirmation>(this as TransferConfirmation, _$identity);

  /// Serializes this TransferConfirmation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransferConfirmation&&(identical(other.type, type) || other.type == type)&&(identical(other.data, data) || other.data == data)&&(identical(other.hash, hash) || other.hash == hash));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,data,hash);

@override
String toString() {
  return 'TransferConfirmation(type: $type, data: $data, hash: $hash)';
}


}

/// @nodoc
abstract mixin class $TransferConfirmationCopyWith<$Res>  {
  factory $TransferConfirmationCopyWith(TransferConfirmation value, $Res Function(TransferConfirmation) _then) = _$TransferConfirmationCopyWithImpl;
@useResult
$Res call({
 String type, String data, String hash
});




}
/// @nodoc
class _$TransferConfirmationCopyWithImpl<$Res>
    implements $TransferConfirmationCopyWith<$Res> {
  _$TransferConfirmationCopyWithImpl(this._self, this._then);

  final TransferConfirmation _self;
  final $Res Function(TransferConfirmation) _then;

/// Create a copy of TransferConfirmation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? data = null,Object? hash = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as String,hash: null == hash ? _self.hash : hash // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TransferConfirmation].
extension TransferConfirmationPatterns on TransferConfirmation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransferConfirmation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransferConfirmation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransferConfirmation value)  $default,){
final _that = this;
switch (_that) {
case _TransferConfirmation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransferConfirmation value)?  $default,){
final _that = this;
switch (_that) {
case _TransferConfirmation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  String data,  String hash)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransferConfirmation() when $default != null:
return $default(_that.type,_that.data,_that.hash);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  String data,  String hash)  $default,) {final _that = this;
switch (_that) {
case _TransferConfirmation():
return $default(_that.type,_that.data,_that.hash);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  String data,  String hash)?  $default,) {final _that = this;
switch (_that) {
case _TransferConfirmation() when $default != null:
return $default(_that.type,_that.data,_that.hash);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TransferConfirmation implements TransferConfirmation {
  const _TransferConfirmation({required this.type, required this.data, required this.hash});
  factory _TransferConfirmation.fromJson(Map<String, dynamic> json) => _$TransferConfirmationFromJson(json);

// e.g. "erc3009-authorization"
@override final  String type;
@override final  String data;
// hex hash string
@override final  String hash;

/// Create a copy of TransferConfirmation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransferConfirmationCopyWith<_TransferConfirmation> get copyWith => __$TransferConfirmationCopyWithImpl<_TransferConfirmation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransferConfirmationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransferConfirmation&&(identical(other.type, type) || other.type == type)&&(identical(other.data, data) || other.data == data)&&(identical(other.hash, hash) || other.hash == hash));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,data,hash);

@override
String toString() {
  return 'TransferConfirmation(type: $type, data: $data, hash: $hash)';
}


}

/// @nodoc
abstract mixin class _$TransferConfirmationCopyWith<$Res> implements $TransferConfirmationCopyWith<$Res> {
  factory _$TransferConfirmationCopyWith(_TransferConfirmation value, $Res Function(_TransferConfirmation) _then) = __$TransferConfirmationCopyWithImpl;
@override @useResult
$Res call({
 String type, String data, String hash
});




}
/// @nodoc
class __$TransferConfirmationCopyWithImpl<$Res>
    implements _$TransferConfirmationCopyWith<$Res> {
  __$TransferConfirmationCopyWithImpl(this._self, this._then);

  final _TransferConfirmation _self;
  final $Res Function(_TransferConfirmation) _then;

/// Create a copy of TransferConfirmation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? data = null,Object? hash = null,}) {
  return _then(_TransferConfirmation(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as String,hash: null == hash ? _self.hash : hash // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$WalletPayResponseResultV1 {

 TransferConfirmation get transferConfirmation;
/// Create a copy of WalletPayResponseResultV1
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WalletPayResponseResultV1CopyWith<WalletPayResponseResultV1> get copyWith => _$WalletPayResponseResultV1CopyWithImpl<WalletPayResponseResultV1>(this as WalletPayResponseResultV1, _$identity);

  /// Serializes this WalletPayResponseResultV1 to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WalletPayResponseResultV1&&(identical(other.transferConfirmation, transferConfirmation) || other.transferConfirmation == transferConfirmation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transferConfirmation);

@override
String toString() {
  return 'WalletPayResponseResultV1(transferConfirmation: $transferConfirmation)';
}


}

/// @nodoc
abstract mixin class $WalletPayResponseResultV1CopyWith<$Res>  {
  factory $WalletPayResponseResultV1CopyWith(WalletPayResponseResultV1 value, $Res Function(WalletPayResponseResultV1) _then) = _$WalletPayResponseResultV1CopyWithImpl;
@useResult
$Res call({
 TransferConfirmation transferConfirmation
});


$TransferConfirmationCopyWith<$Res> get transferConfirmation;

}
/// @nodoc
class _$WalletPayResponseResultV1CopyWithImpl<$Res>
    implements $WalletPayResponseResultV1CopyWith<$Res> {
  _$WalletPayResponseResultV1CopyWithImpl(this._self, this._then);

  final WalletPayResponseResultV1 _self;
  final $Res Function(WalletPayResponseResultV1) _then;

/// Create a copy of WalletPayResponseResultV1
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? transferConfirmation = null,}) {
  return _then(_self.copyWith(
transferConfirmation: null == transferConfirmation ? _self.transferConfirmation : transferConfirmation // ignore: cast_nullable_to_non_nullable
as TransferConfirmation,
  ));
}
/// Create a copy of WalletPayResponseResultV1
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransferConfirmationCopyWith<$Res> get transferConfirmation {
  
  return $TransferConfirmationCopyWith<$Res>(_self.transferConfirmation, (value) {
    return _then(_self.copyWith(transferConfirmation: value));
  });
}
}


/// Adds pattern-matching-related methods to [WalletPayResponseResultV1].
extension WalletPayResponseResultV1Patterns on WalletPayResponseResultV1 {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WalletPayResponseResultV1 value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WalletPayResponseResultV1() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WalletPayResponseResultV1 value)  $default,){
final _that = this;
switch (_that) {
case _WalletPayResponseResultV1():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WalletPayResponseResultV1 value)?  $default,){
final _that = this;
switch (_that) {
case _WalletPayResponseResultV1() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TransferConfirmation transferConfirmation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WalletPayResponseResultV1() when $default != null:
return $default(_that.transferConfirmation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TransferConfirmation transferConfirmation)  $default,) {final _that = this;
switch (_that) {
case _WalletPayResponseResultV1():
return $default(_that.transferConfirmation);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TransferConfirmation transferConfirmation)?  $default,) {final _that = this;
switch (_that) {
case _WalletPayResponseResultV1() when $default != null:
return $default(_that.transferConfirmation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WalletPayResponseResultV1 implements WalletPayResponseResultV1 {
  const _WalletPayResponseResultV1({required this.transferConfirmation});
  factory _WalletPayResponseResultV1.fromJson(Map<String, dynamic> json) => _$WalletPayResponseResultV1FromJson(json);

@override final  TransferConfirmation transferConfirmation;

/// Create a copy of WalletPayResponseResultV1
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WalletPayResponseResultV1CopyWith<_WalletPayResponseResultV1> get copyWith => __$WalletPayResponseResultV1CopyWithImpl<_WalletPayResponseResultV1>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WalletPayResponseResultV1ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WalletPayResponseResultV1&&(identical(other.transferConfirmation, transferConfirmation) || other.transferConfirmation == transferConfirmation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transferConfirmation);

@override
String toString() {
  return 'WalletPayResponseResultV1(transferConfirmation: $transferConfirmation)';
}


}

/// @nodoc
abstract mixin class _$WalletPayResponseResultV1CopyWith<$Res> implements $WalletPayResponseResultV1CopyWith<$Res> {
  factory _$WalletPayResponseResultV1CopyWith(_WalletPayResponseResultV1 value, $Res Function(_WalletPayResponseResultV1) _then) = __$WalletPayResponseResultV1CopyWithImpl;
@override @useResult
$Res call({
 TransferConfirmation transferConfirmation
});


@override $TransferConfirmationCopyWith<$Res> get transferConfirmation;

}
/// @nodoc
class __$WalletPayResponseResultV1CopyWithImpl<$Res>
    implements _$WalletPayResponseResultV1CopyWith<$Res> {
  __$WalletPayResponseResultV1CopyWithImpl(this._self, this._then);

  final _WalletPayResponseResultV1 _self;
  final $Res Function(_WalletPayResponseResultV1) _then;

/// Create a copy of WalletPayResponseResultV1
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? transferConfirmation = null,}) {
  return _then(_WalletPayResponseResultV1(
transferConfirmation: null == transferConfirmation ? _self.transferConfirmation : transferConfirmation // ignore: cast_nullable_to_non_nullable
as TransferConfirmation,
  ));
}

/// Create a copy of WalletPayResponseResultV1
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransferConfirmationCopyWith<$Res> get transferConfirmation {
  
  return $TransferConfirmationCopyWith<$Res>(_self.transferConfirmation, (value) {
    return _then(_self.copyWith(transferConfirmation: value));
  });
}
}

// dart format on
