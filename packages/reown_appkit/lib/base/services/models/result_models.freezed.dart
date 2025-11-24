// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'result_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Exchange {

 String get id; String get imageUrl; String get name;
/// Create a copy of Exchange
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExchangeCopyWith<Exchange> get copyWith => _$ExchangeCopyWithImpl<Exchange>(this as Exchange, _$identity);

  /// Serializes this Exchange to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Exchange&&(identical(other.id, id) || other.id == id)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,imageUrl,name);

@override
String toString() {
  return 'Exchange(id: $id, imageUrl: $imageUrl, name: $name)';
}


}

/// @nodoc
abstract mixin class $ExchangeCopyWith<$Res>  {
  factory $ExchangeCopyWith(Exchange value, $Res Function(Exchange) _then) = _$ExchangeCopyWithImpl;
@useResult
$Res call({
 String id, String imageUrl, String name
});




}
/// @nodoc
class _$ExchangeCopyWithImpl<$Res>
    implements $ExchangeCopyWith<$Res> {
  _$ExchangeCopyWithImpl(this._self, this._then);

  final Exchange _self;
  final $Res Function(Exchange) _then;

/// Create a copy of Exchange
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? imageUrl = null,Object? name = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Exchange].
extension ExchangePatterns on Exchange {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Exchange value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Exchange() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Exchange value)  $default,){
final _that = this;
switch (_that) {
case _Exchange():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Exchange value)?  $default,){
final _that = this;
switch (_that) {
case _Exchange() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String imageUrl,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Exchange() when $default != null:
return $default(_that.id,_that.imageUrl,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String imageUrl,  String name)  $default,) {final _that = this;
switch (_that) {
case _Exchange():
return $default(_that.id,_that.imageUrl,_that.name);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String imageUrl,  String name)?  $default,) {final _that = this;
switch (_that) {
case _Exchange() when $default != null:
return $default(_that.id,_that.imageUrl,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Exchange implements Exchange {
  const _Exchange({required this.id, required this.imageUrl, required this.name});
  factory _Exchange.fromJson(Map<String, dynamic> json) => _$ExchangeFromJson(json);

@override final  String id;
@override final  String imageUrl;
@override final  String name;

/// Create a copy of Exchange
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExchangeCopyWith<_Exchange> get copyWith => __$ExchangeCopyWithImpl<_Exchange>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExchangeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Exchange&&(identical(other.id, id) || other.id == id)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,imageUrl,name);

@override
String toString() {
  return 'Exchange(id: $id, imageUrl: $imageUrl, name: $name)';
}


}

/// @nodoc
abstract mixin class _$ExchangeCopyWith<$Res> implements $ExchangeCopyWith<$Res> {
  factory _$ExchangeCopyWith(_Exchange value, $Res Function(_Exchange) _then) = __$ExchangeCopyWithImpl;
@override @useResult
$Res call({
 String id, String imageUrl, String name
});




}
/// @nodoc
class __$ExchangeCopyWithImpl<$Res>
    implements _$ExchangeCopyWith<$Res> {
  __$ExchangeCopyWithImpl(this._self, this._then);

  final _Exchange _self;
  final $Res Function(_Exchange) _then;

/// Create a copy of Exchange
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? imageUrl = null,Object? name = null,}) {
  return _then(_Exchange(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$GetExchangesResult {

 List<Exchange> get exchanges; int get total;
/// Create a copy of GetExchangesResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetExchangesResultCopyWith<GetExchangesResult> get copyWith => _$GetExchangesResultCopyWithImpl<GetExchangesResult>(this as GetExchangesResult, _$identity);

  /// Serializes this GetExchangesResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetExchangesResult&&const DeepCollectionEquality().equals(other.exchanges, exchanges)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(exchanges),total);

@override
String toString() {
  return 'GetExchangesResult(exchanges: $exchanges, total: $total)';
}


}

/// @nodoc
abstract mixin class $GetExchangesResultCopyWith<$Res>  {
  factory $GetExchangesResultCopyWith(GetExchangesResult value, $Res Function(GetExchangesResult) _then) = _$GetExchangesResultCopyWithImpl;
@useResult
$Res call({
 List<Exchange> exchanges, int total
});




}
/// @nodoc
class _$GetExchangesResultCopyWithImpl<$Res>
    implements $GetExchangesResultCopyWith<$Res> {
  _$GetExchangesResultCopyWithImpl(this._self, this._then);

  final GetExchangesResult _self;
  final $Res Function(GetExchangesResult) _then;

/// Create a copy of GetExchangesResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? exchanges = null,Object? total = null,}) {
  return _then(_self.copyWith(
exchanges: null == exchanges ? _self.exchanges : exchanges // ignore: cast_nullable_to_non_nullable
as List<Exchange>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [GetExchangesResult].
extension GetExchangesResultPatterns on GetExchangesResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetExchangesResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetExchangesResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetExchangesResult value)  $default,){
final _that = this;
switch (_that) {
case _GetExchangesResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetExchangesResult value)?  $default,){
final _that = this;
switch (_that) {
case _GetExchangesResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Exchange> exchanges,  int total)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetExchangesResult() when $default != null:
return $default(_that.exchanges,_that.total);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Exchange> exchanges,  int total)  $default,) {final _that = this;
switch (_that) {
case _GetExchangesResult():
return $default(_that.exchanges,_that.total);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Exchange> exchanges,  int total)?  $default,) {final _that = this;
switch (_that) {
case _GetExchangesResult() when $default != null:
return $default(_that.exchanges,_that.total);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GetExchangesResult implements GetExchangesResult {
  const _GetExchangesResult({required final  List<Exchange> exchanges, required this.total}): _exchanges = exchanges;
  factory _GetExchangesResult.fromJson(Map<String, dynamic> json) => _$GetExchangesResultFromJson(json);

 final  List<Exchange> _exchanges;
@override List<Exchange> get exchanges {
  if (_exchanges is EqualUnmodifiableListView) return _exchanges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_exchanges);
}

@override final  int total;

/// Create a copy of GetExchangesResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetExchangesResultCopyWith<_GetExchangesResult> get copyWith => __$GetExchangesResultCopyWithImpl<_GetExchangesResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GetExchangesResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetExchangesResult&&const DeepCollectionEquality().equals(other._exchanges, _exchanges)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_exchanges),total);

@override
String toString() {
  return 'GetExchangesResult(exchanges: $exchanges, total: $total)';
}


}

/// @nodoc
abstract mixin class _$GetExchangesResultCopyWith<$Res> implements $GetExchangesResultCopyWith<$Res> {
  factory _$GetExchangesResultCopyWith(_GetExchangesResult value, $Res Function(_GetExchangesResult) _then) = __$GetExchangesResultCopyWithImpl;
@override @useResult
$Res call({
 List<Exchange> exchanges, int total
});




}
/// @nodoc
class __$GetExchangesResultCopyWithImpl<$Res>
    implements _$GetExchangesResultCopyWith<$Res> {
  __$GetExchangesResultCopyWithImpl(this._self, this._then);

  final _GetExchangesResult _self;
  final $Res Function(_GetExchangesResult) _then;

/// Create a copy of GetExchangesResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? exchanges = null,Object? total = null,}) {
  return _then(_GetExchangesResult(
exchanges: null == exchanges ? _self._exchanges : exchanges // ignore: cast_nullable_to_non_nullable
as List<Exchange>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$GetExchangeUrlResult {

 String get sessionId; String get url;
/// Create a copy of GetExchangeUrlResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetExchangeUrlResultCopyWith<GetExchangeUrlResult> get copyWith => _$GetExchangeUrlResultCopyWithImpl<GetExchangeUrlResult>(this as GetExchangeUrlResult, _$identity);

  /// Serializes this GetExchangeUrlResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetExchangeUrlResult&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sessionId,url);

@override
String toString() {
  return 'GetExchangeUrlResult(sessionId: $sessionId, url: $url)';
}


}

/// @nodoc
abstract mixin class $GetExchangeUrlResultCopyWith<$Res>  {
  factory $GetExchangeUrlResultCopyWith(GetExchangeUrlResult value, $Res Function(GetExchangeUrlResult) _then) = _$GetExchangeUrlResultCopyWithImpl;
@useResult
$Res call({
 String sessionId, String url
});




}
/// @nodoc
class _$GetExchangeUrlResultCopyWithImpl<$Res>
    implements $GetExchangeUrlResultCopyWith<$Res> {
  _$GetExchangeUrlResultCopyWithImpl(this._self, this._then);

  final GetExchangeUrlResult _self;
  final $Res Function(GetExchangeUrlResult) _then;

/// Create a copy of GetExchangeUrlResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionId = null,Object? url = null,}) {
  return _then(_self.copyWith(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GetExchangeUrlResult].
extension GetExchangeUrlResultPatterns on GetExchangeUrlResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetExchangeUrlResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetExchangeUrlResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetExchangeUrlResult value)  $default,){
final _that = this;
switch (_that) {
case _GetExchangeUrlResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetExchangeUrlResult value)?  $default,){
final _that = this;
switch (_that) {
case _GetExchangeUrlResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sessionId,  String url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetExchangeUrlResult() when $default != null:
return $default(_that.sessionId,_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sessionId,  String url)  $default,) {final _that = this;
switch (_that) {
case _GetExchangeUrlResult():
return $default(_that.sessionId,_that.url);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sessionId,  String url)?  $default,) {final _that = this;
switch (_that) {
case _GetExchangeUrlResult() when $default != null:
return $default(_that.sessionId,_that.url);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GetExchangeUrlResult implements GetExchangeUrlResult {
  const _GetExchangeUrlResult({required this.sessionId, required this.url});
  factory _GetExchangeUrlResult.fromJson(Map<String, dynamic> json) => _$GetExchangeUrlResultFromJson(json);

@override final  String sessionId;
@override final  String url;

/// Create a copy of GetExchangeUrlResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetExchangeUrlResultCopyWith<_GetExchangeUrlResult> get copyWith => __$GetExchangeUrlResultCopyWithImpl<_GetExchangeUrlResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GetExchangeUrlResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetExchangeUrlResult&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sessionId,url);

@override
String toString() {
  return 'GetExchangeUrlResult(sessionId: $sessionId, url: $url)';
}


}

/// @nodoc
abstract mixin class _$GetExchangeUrlResultCopyWith<$Res> implements $GetExchangeUrlResultCopyWith<$Res> {
  factory _$GetExchangeUrlResultCopyWith(_GetExchangeUrlResult value, $Res Function(_GetExchangeUrlResult) _then) = __$GetExchangeUrlResultCopyWithImpl;
@override @useResult
$Res call({
 String sessionId, String url
});




}
/// @nodoc
class __$GetExchangeUrlResultCopyWithImpl<$Res>
    implements _$GetExchangeUrlResultCopyWith<$Res> {
  __$GetExchangeUrlResultCopyWithImpl(this._self, this._then);

  final _GetExchangeUrlResult _self;
  final $Res Function(_GetExchangeUrlResult) _then;

/// Create a copy of GetExchangeUrlResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? url = null,}) {
  return _then(_GetExchangeUrlResult(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$GetExchangeDepositStatusResult {

 String get status; String? get txHash;
/// Create a copy of GetExchangeDepositStatusResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetExchangeDepositStatusResultCopyWith<GetExchangeDepositStatusResult> get copyWith => _$GetExchangeDepositStatusResultCopyWithImpl<GetExchangeDepositStatusResult>(this as GetExchangeDepositStatusResult, _$identity);

  /// Serializes this GetExchangeDepositStatusResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetExchangeDepositStatusResult&&(identical(other.status, status) || other.status == status)&&(identical(other.txHash, txHash) || other.txHash == txHash));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,txHash);

@override
String toString() {
  return 'GetExchangeDepositStatusResult(status: $status, txHash: $txHash)';
}


}

/// @nodoc
abstract mixin class $GetExchangeDepositStatusResultCopyWith<$Res>  {
  factory $GetExchangeDepositStatusResultCopyWith(GetExchangeDepositStatusResult value, $Res Function(GetExchangeDepositStatusResult) _then) = _$GetExchangeDepositStatusResultCopyWithImpl;
@useResult
$Res call({
 String status, String? txHash
});




}
/// @nodoc
class _$GetExchangeDepositStatusResultCopyWithImpl<$Res>
    implements $GetExchangeDepositStatusResultCopyWith<$Res> {
  _$GetExchangeDepositStatusResultCopyWithImpl(this._self, this._then);

  final GetExchangeDepositStatusResult _self;
  final $Res Function(GetExchangeDepositStatusResult) _then;

/// Create a copy of GetExchangeDepositStatusResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? txHash = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,txHash: freezed == txHash ? _self.txHash : txHash // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [GetExchangeDepositStatusResult].
extension GetExchangeDepositStatusResultPatterns on GetExchangeDepositStatusResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetExchangeDepositStatusResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetExchangeDepositStatusResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetExchangeDepositStatusResult value)  $default,){
final _that = this;
switch (_that) {
case _GetExchangeDepositStatusResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetExchangeDepositStatusResult value)?  $default,){
final _that = this;
switch (_that) {
case _GetExchangeDepositStatusResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String status,  String? txHash)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetExchangeDepositStatusResult() when $default != null:
return $default(_that.status,_that.txHash);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String status,  String? txHash)  $default,) {final _that = this;
switch (_that) {
case _GetExchangeDepositStatusResult():
return $default(_that.status,_that.txHash);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String status,  String? txHash)?  $default,) {final _that = this;
switch (_that) {
case _GetExchangeDepositStatusResult() when $default != null:
return $default(_that.status,_that.txHash);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GetExchangeDepositStatusResult implements GetExchangeDepositStatusResult {
  const _GetExchangeDepositStatusResult({required this.status, this.txHash});
  factory _GetExchangeDepositStatusResult.fromJson(Map<String, dynamic> json) => _$GetExchangeDepositStatusResultFromJson(json);

@override final  String status;
@override final  String? txHash;

/// Create a copy of GetExchangeDepositStatusResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetExchangeDepositStatusResultCopyWith<_GetExchangeDepositStatusResult> get copyWith => __$GetExchangeDepositStatusResultCopyWithImpl<_GetExchangeDepositStatusResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GetExchangeDepositStatusResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetExchangeDepositStatusResult&&(identical(other.status, status) || other.status == status)&&(identical(other.txHash, txHash) || other.txHash == txHash));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,txHash);

@override
String toString() {
  return 'GetExchangeDepositStatusResult(status: $status, txHash: $txHash)';
}


}

/// @nodoc
abstract mixin class _$GetExchangeDepositStatusResultCopyWith<$Res> implements $GetExchangeDepositStatusResultCopyWith<$Res> {
  factory _$GetExchangeDepositStatusResultCopyWith(_GetExchangeDepositStatusResult value, $Res Function(_GetExchangeDepositStatusResult) _then) = __$GetExchangeDepositStatusResultCopyWithImpl;
@override @useResult
$Res call({
 String status, String? txHash
});




}
/// @nodoc
class __$GetExchangeDepositStatusResultCopyWithImpl<$Res>
    implements _$GetExchangeDepositStatusResultCopyWith<$Res> {
  __$GetExchangeDepositStatusResultCopyWithImpl(this._self, this._then);

  final _GetExchangeDepositStatusResult _self;
  final $Res Function(_GetExchangeDepositStatusResult) _then;

/// Create a copy of GetExchangeDepositStatusResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? txHash = freezed,}) {
  return _then(_GetExchangeDepositStatusResult(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,txHash: freezed == txHash ? _self.txHash : txHash // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
