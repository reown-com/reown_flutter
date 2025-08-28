// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pos_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PaymentIntent {

 String get token;// token address, 0x..... for EVM
 String get amount;// double as string
 String get chainId;// caip-2 chain id, i.e. `eip155:1`
 String get recipient;
/// Create a copy of PaymentIntent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentIntentCopyWith<PaymentIntent> get copyWith => _$PaymentIntentCopyWithImpl<PaymentIntent>(this as PaymentIntent, _$identity);

  /// Serializes this PaymentIntent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentIntent&&(identical(other.token, token) || other.token == token)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.recipient, recipient) || other.recipient == recipient));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token,amount,chainId,recipient);

@override
String toString() {
  return 'PaymentIntent(token: $token, amount: $amount, chainId: $chainId, recipient: $recipient)';
}


}

/// @nodoc
abstract mixin class $PaymentIntentCopyWith<$Res>  {
  factory $PaymentIntentCopyWith(PaymentIntent value, $Res Function(PaymentIntent) _then) = _$PaymentIntentCopyWithImpl;
@useResult
$Res call({
 String token, String amount, String chainId, String recipient
});




}
/// @nodoc
class _$PaymentIntentCopyWithImpl<$Res>
    implements $PaymentIntentCopyWith<$Res> {
  _$PaymentIntentCopyWithImpl(this._self, this._then);

  final PaymentIntent _self;
  final $Res Function(PaymentIntent) _then;

/// Create a copy of PaymentIntent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? token = null,Object? amount = null,Object? chainId = null,Object? recipient = null,}) {
  return _then(_self.copyWith(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as String,recipient: null == recipient ? _self.recipient : recipient // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentIntent].
extension PaymentIntentPatterns on PaymentIntent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentIntent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentIntent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentIntent value)  $default,){
final _that = this;
switch (_that) {
case _PaymentIntent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentIntent value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentIntent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String token,  String amount,  String chainId,  String recipient)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentIntent() when $default != null:
return $default(_that.token,_that.amount,_that.chainId,_that.recipient);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String token,  String amount,  String chainId,  String recipient)  $default,) {final _that = this;
switch (_that) {
case _PaymentIntent():
return $default(_that.token,_that.amount,_that.chainId,_that.recipient);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String token,  String amount,  String chainId,  String recipient)?  $default,) {final _that = this;
switch (_that) {
case _PaymentIntent() when $default != null:
return $default(_that.token,_that.amount,_that.chainId,_that.recipient);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentIntent implements PaymentIntent {
  const _PaymentIntent({required this.token, required this.amount, required this.chainId, required this.recipient});
  factory _PaymentIntent.fromJson(Map<String, dynamic> json) => _$PaymentIntentFromJson(json);

@override final  String token;
// token address, 0x..... for EVM
@override final  String amount;
// double as string
@override final  String chainId;
// caip-2 chain id, i.e. `eip155:1`
@override final  String recipient;

/// Create a copy of PaymentIntent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentIntentCopyWith<_PaymentIntent> get copyWith => __$PaymentIntentCopyWithImpl<_PaymentIntent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentIntentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentIntent&&(identical(other.token, token) || other.token == token)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.recipient, recipient) || other.recipient == recipient));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token,amount,chainId,recipient);

@override
String toString() {
  return 'PaymentIntent(token: $token, amount: $amount, chainId: $chainId, recipient: $recipient)';
}


}

/// @nodoc
abstract mixin class _$PaymentIntentCopyWith<$Res> implements $PaymentIntentCopyWith<$Res> {
  factory _$PaymentIntentCopyWith(_PaymentIntent value, $Res Function(_PaymentIntent) _then) = __$PaymentIntentCopyWithImpl;
@override @useResult
$Res call({
 String token, String amount, String chainId, String recipient
});




}
/// @nodoc
class __$PaymentIntentCopyWithImpl<$Res>
    implements _$PaymentIntentCopyWith<$Res> {
  __$PaymentIntentCopyWithImpl(this._self, this._then);

  final _PaymentIntent _self;
  final $Res Function(_PaymentIntent) _then;

/// Create a copy of PaymentIntent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? token = null,Object? amount = null,Object? chainId = null,Object? recipient = null,}) {
  return _then(_PaymentIntent(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as String,recipient: null == recipient ? _self.recipient : recipient // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$Metadata {

 String get merchantName; String get description; String get url; String get logoIcon;
/// Create a copy of Metadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MetadataCopyWith<Metadata> get copyWith => _$MetadataCopyWithImpl<Metadata>(this as Metadata, _$identity);

  /// Serializes this Metadata to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Metadata&&(identical(other.merchantName, merchantName) || other.merchantName == merchantName)&&(identical(other.description, description) || other.description == description)&&(identical(other.url, url) || other.url == url)&&(identical(other.logoIcon, logoIcon) || other.logoIcon == logoIcon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,merchantName,description,url,logoIcon);

@override
String toString() {
  return 'Metadata(merchantName: $merchantName, description: $description, url: $url, logoIcon: $logoIcon)';
}


}

/// @nodoc
abstract mixin class $MetadataCopyWith<$Res>  {
  factory $MetadataCopyWith(Metadata value, $Res Function(Metadata) _then) = _$MetadataCopyWithImpl;
@useResult
$Res call({
 String merchantName, String description, String url, String logoIcon
});




}
/// @nodoc
class _$MetadataCopyWithImpl<$Res>
    implements $MetadataCopyWith<$Res> {
  _$MetadataCopyWithImpl(this._self, this._then);

  final Metadata _self;
  final $Res Function(Metadata) _then;

/// Create a copy of Metadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? merchantName = null,Object? description = null,Object? url = null,Object? logoIcon = null,}) {
  return _then(_self.copyWith(
merchantName: null == merchantName ? _self.merchantName : merchantName // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,logoIcon: null == logoIcon ? _self.logoIcon : logoIcon // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Metadata].
extension MetadataPatterns on Metadata {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Metadata value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Metadata() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Metadata value)  $default,){
final _that = this;
switch (_that) {
case _Metadata():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Metadata value)?  $default,){
final _that = this;
switch (_that) {
case _Metadata() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String merchantName,  String description,  String url,  String logoIcon)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Metadata() when $default != null:
return $default(_that.merchantName,_that.description,_that.url,_that.logoIcon);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String merchantName,  String description,  String url,  String logoIcon)  $default,) {final _that = this;
switch (_that) {
case _Metadata():
return $default(_that.merchantName,_that.description,_that.url,_that.logoIcon);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String merchantName,  String description,  String url,  String logoIcon)?  $default,) {final _that = this;
switch (_that) {
case _Metadata() when $default != null:
return $default(_that.merchantName,_that.description,_that.url,_that.logoIcon);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Metadata implements Metadata {
  const _Metadata({required this.merchantName, required this.description, required this.url, required this.logoIcon});
  factory _Metadata.fromJson(Map<String, dynamic> json) => _$MetadataFromJson(json);

@override final  String merchantName;
@override final  String description;
@override final  String url;
@override final  String logoIcon;

/// Create a copy of Metadata
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MetadataCopyWith<_Metadata> get copyWith => __$MetadataCopyWithImpl<_Metadata>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MetadataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Metadata&&(identical(other.merchantName, merchantName) || other.merchantName == merchantName)&&(identical(other.description, description) || other.description == description)&&(identical(other.url, url) || other.url == url)&&(identical(other.logoIcon, logoIcon) || other.logoIcon == logoIcon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,merchantName,description,url,logoIcon);

@override
String toString() {
  return 'Metadata(merchantName: $merchantName, description: $description, url: $url, logoIcon: $logoIcon)';
}


}

/// @nodoc
abstract mixin class _$MetadataCopyWith<$Res> implements $MetadataCopyWith<$Res> {
  factory _$MetadataCopyWith(_Metadata value, $Res Function(_Metadata) _then) = __$MetadataCopyWithImpl;
@override @useResult
$Res call({
 String merchantName, String description, String url, String logoIcon
});




}
/// @nodoc
class __$MetadataCopyWithImpl<$Res>
    implements _$MetadataCopyWith<$Res> {
  __$MetadataCopyWithImpl(this._self, this._then);

  final _Metadata _self;
  final $Res Function(_Metadata) _then;

/// Create a copy of Metadata
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? merchantName = null,Object? description = null,Object? url = null,Object? logoIcon = null,}) {
  return _then(_Metadata(
merchantName: null == merchantName ? _self.merchantName : merchantName // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,logoIcon: null == logoIcon ? _self.logoIcon : logoIcon // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$PosNetworkData {

 String get name; String get currency; String get chainId;
/// Create a copy of PosNetworkData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PosNetworkDataCopyWith<PosNetworkData> get copyWith => _$PosNetworkDataCopyWithImpl<PosNetworkData>(this as PosNetworkData, _$identity);

  /// Serializes this PosNetworkData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PosNetworkData&&(identical(other.name, name) || other.name == name)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.chainId, chainId) || other.chainId == chainId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,currency,chainId);

@override
String toString() {
  return 'PosNetworkData(name: $name, currency: $currency, chainId: $chainId)';
}


}

/// @nodoc
abstract mixin class $PosNetworkDataCopyWith<$Res>  {
  factory $PosNetworkDataCopyWith(PosNetworkData value, $Res Function(PosNetworkData) _then) = _$PosNetworkDataCopyWithImpl;
@useResult
$Res call({
 String name, String currency, String chainId
});




}
/// @nodoc
class _$PosNetworkDataCopyWithImpl<$Res>
    implements $PosNetworkDataCopyWith<$Res> {
  _$PosNetworkDataCopyWithImpl(this._self, this._then);

  final PosNetworkData _self;
  final $Res Function(PosNetworkData) _then;

/// Create a copy of PosNetworkData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? currency = null,Object? chainId = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PosNetworkData].
extension PosNetworkDataPatterns on PosNetworkData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PosNetworkData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PosNetworkData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PosNetworkData value)  $default,){
final _that = this;
switch (_that) {
case _PosNetworkData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PosNetworkData value)?  $default,){
final _that = this;
switch (_that) {
case _PosNetworkData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String currency,  String chainId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PosNetworkData() when $default != null:
return $default(_that.name,_that.currency,_that.chainId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String currency,  String chainId)  $default,) {final _that = this;
switch (_that) {
case _PosNetworkData():
return $default(_that.name,_that.currency,_that.chainId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String currency,  String chainId)?  $default,) {final _that = this;
switch (_that) {
case _PosNetworkData() when $default != null:
return $default(_that.name,_that.currency,_that.chainId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PosNetworkData implements PosNetworkData {
  const _PosNetworkData({required this.name, required this.currency, required this.chainId});
  factory _PosNetworkData.fromJson(Map<String, dynamic> json) => _$PosNetworkDataFromJson(json);

@override final  String name;
@override final  String currency;
@override final  String chainId;

/// Create a copy of PosNetworkData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PosNetworkDataCopyWith<_PosNetworkData> get copyWith => __$PosNetworkDataCopyWithImpl<_PosNetworkData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PosNetworkDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PosNetworkData&&(identical(other.name, name) || other.name == name)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.chainId, chainId) || other.chainId == chainId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,currency,chainId);

@override
String toString() {
  return 'PosNetworkData(name: $name, currency: $currency, chainId: $chainId)';
}


}

/// @nodoc
abstract mixin class _$PosNetworkDataCopyWith<$Res> implements $PosNetworkDataCopyWith<$Res> {
  factory _$PosNetworkDataCopyWith(_PosNetworkData value, $Res Function(_PosNetworkData) _then) = __$PosNetworkDataCopyWithImpl;
@override @useResult
$Res call({
 String name, String currency, String chainId
});




}
/// @nodoc
class __$PosNetworkDataCopyWithImpl<$Res>
    implements _$PosNetworkDataCopyWith<$Res> {
  __$PosNetworkDataCopyWithImpl(this._self, this._then);

  final _PosNetworkData _self;
  final $Res Function(_PosNetworkData) _then;

/// Create a copy of PosNetworkData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? currency = null,Object? chainId = null,}) {
  return _then(_PosNetworkData(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$PosToken {

 PosNetwork get network; String get symbol; String get address;
/// Create a copy of PosToken
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PosTokenCopyWith<PosToken> get copyWith => _$PosTokenCopyWithImpl<PosToken>(this as PosToken, _$identity);

  /// Serializes this PosToken to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PosToken&&(identical(other.network, network) || other.network == network)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.address, address) || other.address == address));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,network,symbol,address);

@override
String toString() {
  return 'PosToken(network: $network, symbol: $symbol, address: $address)';
}


}

/// @nodoc
abstract mixin class $PosTokenCopyWith<$Res>  {
  factory $PosTokenCopyWith(PosToken value, $Res Function(PosToken) _then) = _$PosTokenCopyWithImpl;
@useResult
$Res call({
 PosNetwork network, String symbol, String address
});




}
/// @nodoc
class _$PosTokenCopyWithImpl<$Res>
    implements $PosTokenCopyWith<$Res> {
  _$PosTokenCopyWithImpl(this._self, this._then);

  final PosToken _self;
  final $Res Function(PosToken) _then;

/// Create a copy of PosToken
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? network = null,Object? symbol = null,Object? address = null,}) {
  return _then(_self.copyWith(
network: null == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as PosNetwork,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PosToken].
extension PosTokenPatterns on PosToken {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PosToken value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PosToken() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PosToken value)  $default,){
final _that = this;
switch (_that) {
case _PosToken():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PosToken value)?  $default,){
final _that = this;
switch (_that) {
case _PosToken() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PosNetwork network,  String symbol,  String address)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PosToken() when $default != null:
return $default(_that.network,_that.symbol,_that.address);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PosNetwork network,  String symbol,  String address)  $default,) {final _that = this;
switch (_that) {
case _PosToken():
return $default(_that.network,_that.symbol,_that.address);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PosNetwork network,  String symbol,  String address)?  $default,) {final _that = this;
switch (_that) {
case _PosToken() when $default != null:
return $default(_that.network,_that.symbol,_that.address);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PosToken implements PosToken {
  const _PosToken({required this.network, required this.symbol, required this.address});
  factory _PosToken.fromJson(Map<String, dynamic> json) => _$PosTokenFromJson(json);

@override final  PosNetwork network;
@override final  String symbol;
@override final  String address;

/// Create a copy of PosToken
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PosTokenCopyWith<_PosToken> get copyWith => __$PosTokenCopyWithImpl<_PosToken>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PosTokenToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PosToken&&(identical(other.network, network) || other.network == network)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.address, address) || other.address == address));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,network,symbol,address);

@override
String toString() {
  return 'PosToken(network: $network, symbol: $symbol, address: $address)';
}


}

/// @nodoc
abstract mixin class _$PosTokenCopyWith<$Res> implements $PosTokenCopyWith<$Res> {
  factory _$PosTokenCopyWith(_PosToken value, $Res Function(_PosToken) _then) = __$PosTokenCopyWithImpl;
@override @useResult
$Res call({
 PosNetwork network, String symbol, String address
});




}
/// @nodoc
class __$PosTokenCopyWithImpl<$Res>
    implements _$PosTokenCopyWith<$Res> {
  __$PosTokenCopyWithImpl(this._self, this._then);

  final _PosToken _self;
  final $Res Function(_PosToken) _then;

/// Create a copy of PosToken
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? network = null,Object? symbol = null,Object? address = null,}) {
  return _then(_PosToken(
network: null == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as PosNetwork,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
