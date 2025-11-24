// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'query_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QueryParams {

 String get projectId; String get source; String get st; String get sv;
/// Create a copy of QueryParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QueryParamsCopyWith<QueryParams> get copyWith => _$QueryParamsCopyWithImpl<QueryParams>(this as QueryParams, _$identity);

  /// Serializes this QueryParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QueryParams&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.source, source) || other.source == source)&&(identical(other.st, st) || other.st == st)&&(identical(other.sv, sv) || other.sv == sv));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,projectId,source,st,sv);

@override
String toString() {
  return 'QueryParams(projectId: $projectId, source: $source, st: $st, sv: $sv)';
}


}

/// @nodoc
abstract mixin class $QueryParamsCopyWith<$Res>  {
  factory $QueryParamsCopyWith(QueryParams value, $Res Function(QueryParams) _then) = _$QueryParamsCopyWithImpl;
@useResult
$Res call({
 String projectId, String source, String st, String sv
});




}
/// @nodoc
class _$QueryParamsCopyWithImpl<$Res>
    implements $QueryParamsCopyWith<$Res> {
  _$QueryParamsCopyWithImpl(this._self, this._then);

  final QueryParams _self;
  final $Res Function(QueryParams) _then;

/// Create a copy of QueryParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? projectId = null,Object? source = null,Object? st = null,Object? sv = null,}) {
  return _then(_self.copyWith(
projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,st: null == st ? _self.st : st // ignore: cast_nullable_to_non_nullable
as String,sv: null == sv ? _self.sv : sv // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [QueryParams].
extension QueryParamsPatterns on QueryParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QueryParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QueryParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QueryParams value)  $default,){
final _that = this;
switch (_that) {
case _QueryParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QueryParams value)?  $default,){
final _that = this;
switch (_that) {
case _QueryParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String projectId,  String source,  String st,  String sv)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QueryParams() when $default != null:
return $default(_that.projectId,_that.source,_that.st,_that.sv);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String projectId,  String source,  String st,  String sv)  $default,) {final _that = this;
switch (_that) {
case _QueryParams():
return $default(_that.projectId,_that.source,_that.st,_that.sv);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String projectId,  String source,  String st,  String sv)?  $default,) {final _that = this;
switch (_that) {
case _QueryParams() when $default != null:
return $default(_that.projectId,_that.source,_that.st,_that.sv);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QueryParams implements QueryParams {
  const _QueryParams({required this.projectId, required this.source, required this.st, required this.sv});
  factory _QueryParams.fromJson(Map<String, dynamic> json) => _$QueryParamsFromJson(json);

@override final  String projectId;
@override final  String source;
@override final  String st;
@override final  String sv;

/// Create a copy of QueryParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QueryParamsCopyWith<_QueryParams> get copyWith => __$QueryParamsCopyWithImpl<_QueryParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QueryParamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QueryParams&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.source, source) || other.source == source)&&(identical(other.st, st) || other.st == st)&&(identical(other.sv, sv) || other.sv == sv));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,projectId,source,st,sv);

@override
String toString() {
  return 'QueryParams(projectId: $projectId, source: $source, st: $st, sv: $sv)';
}


}

/// @nodoc
abstract mixin class _$QueryParamsCopyWith<$Res> implements $QueryParamsCopyWith<$Res> {
  factory _$QueryParamsCopyWith(_QueryParams value, $Res Function(_QueryParams) _then) = __$QueryParamsCopyWithImpl;
@override @useResult
$Res call({
 String projectId, String source, String st, String sv
});




}
/// @nodoc
class __$QueryParamsCopyWithImpl<$Res>
    implements _$QueryParamsCopyWith<$Res> {
  __$QueryParamsCopyWithImpl(this._self, this._then);

  final _QueryParams _self;
  final $Res Function(_QueryParams) _then;

/// Create a copy of QueryParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? projectId = null,Object? source = null,Object? st = null,Object? sv = null,}) {
  return _then(_QueryParams(
projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,st: null == st ? _self.st : st // ignore: cast_nullable_to_non_nullable
as String,sv: null == sv ? _self.sv : sv // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$GetExchangesParams {

 int get page; ExchangeAsset? get asset;// CAIP-19 token address
 List<String>? get includeOnly;// list of exchangeIds
 List<String>? get exclude;
/// Create a copy of GetExchangesParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetExchangesParamsCopyWith<GetExchangesParams> get copyWith => _$GetExchangesParamsCopyWithImpl<GetExchangesParams>(this as GetExchangesParams, _$identity);

  /// Serializes this GetExchangesParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetExchangesParams&&(identical(other.page, page) || other.page == page)&&(identical(other.asset, asset) || other.asset == asset)&&const DeepCollectionEquality().equals(other.includeOnly, includeOnly)&&const DeepCollectionEquality().equals(other.exclude, exclude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,page,asset,const DeepCollectionEquality().hash(includeOnly),const DeepCollectionEquality().hash(exclude));

@override
String toString() {
  return 'GetExchangesParams(page: $page, asset: $asset, includeOnly: $includeOnly, exclude: $exclude)';
}


}

/// @nodoc
abstract mixin class $GetExchangesParamsCopyWith<$Res>  {
  factory $GetExchangesParamsCopyWith(GetExchangesParams value, $Res Function(GetExchangesParams) _then) = _$GetExchangesParamsCopyWithImpl;
@useResult
$Res call({
 int page, ExchangeAsset? asset, List<String>? includeOnly, List<String>? exclude
});


$ExchangeAssetCopyWith<$Res>? get asset;

}
/// @nodoc
class _$GetExchangesParamsCopyWithImpl<$Res>
    implements $GetExchangesParamsCopyWith<$Res> {
  _$GetExchangesParamsCopyWithImpl(this._self, this._then);

  final GetExchangesParams _self;
  final $Res Function(GetExchangesParams) _then;

/// Create a copy of GetExchangesParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? page = null,Object? asset = freezed,Object? includeOnly = freezed,Object? exclude = freezed,}) {
  return _then(_self.copyWith(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,asset: freezed == asset ? _self.asset : asset // ignore: cast_nullable_to_non_nullable
as ExchangeAsset?,includeOnly: freezed == includeOnly ? _self.includeOnly : includeOnly // ignore: cast_nullable_to_non_nullable
as List<String>?,exclude: freezed == exclude ? _self.exclude : exclude // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}
/// Create a copy of GetExchangesParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExchangeAssetCopyWith<$Res>? get asset {
    if (_self.asset == null) {
    return null;
  }

  return $ExchangeAssetCopyWith<$Res>(_self.asset!, (value) {
    return _then(_self.copyWith(asset: value));
  });
}
}


/// Adds pattern-matching-related methods to [GetExchangesParams].
extension GetExchangesParamsPatterns on GetExchangesParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetExchangesParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetExchangesParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetExchangesParams value)  $default,){
final _that = this;
switch (_that) {
case _GetExchangesParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetExchangesParams value)?  $default,){
final _that = this;
switch (_that) {
case _GetExchangesParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int page,  ExchangeAsset? asset,  List<String>? includeOnly,  List<String>? exclude)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetExchangesParams() when $default != null:
return $default(_that.page,_that.asset,_that.includeOnly,_that.exclude);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int page,  ExchangeAsset? asset,  List<String>? includeOnly,  List<String>? exclude)  $default,) {final _that = this;
switch (_that) {
case _GetExchangesParams():
return $default(_that.page,_that.asset,_that.includeOnly,_that.exclude);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int page,  ExchangeAsset? asset,  List<String>? includeOnly,  List<String>? exclude)?  $default,) {final _that = this;
switch (_that) {
case _GetExchangesParams() when $default != null:
return $default(_that.page,_that.asset,_that.includeOnly,_that.exclude);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _GetExchangesParams implements GetExchangesParams {
  const _GetExchangesParams({this.page = 1, this.asset, final  List<String>? includeOnly, final  List<String>? exclude}): _includeOnly = includeOnly,_exclude = exclude;
  factory _GetExchangesParams.fromJson(Map<String, dynamic> json) => _$GetExchangesParamsFromJson(json);

@override@JsonKey() final  int page;
@override final  ExchangeAsset? asset;
// CAIP-19 token address
 final  List<String>? _includeOnly;
// CAIP-19 token address
@override List<String>? get includeOnly {
  final value = _includeOnly;
  if (value == null) return null;
  if (_includeOnly is EqualUnmodifiableListView) return _includeOnly;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

// list of exchangeIds
 final  List<String>? _exclude;
// list of exchangeIds
@override List<String>? get exclude {
  final value = _exclude;
  if (value == null) return null;
  if (_exclude is EqualUnmodifiableListView) return _exclude;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of GetExchangesParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetExchangesParamsCopyWith<_GetExchangesParams> get copyWith => __$GetExchangesParamsCopyWithImpl<_GetExchangesParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GetExchangesParamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetExchangesParams&&(identical(other.page, page) || other.page == page)&&(identical(other.asset, asset) || other.asset == asset)&&const DeepCollectionEquality().equals(other._includeOnly, _includeOnly)&&const DeepCollectionEquality().equals(other._exclude, _exclude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,page,asset,const DeepCollectionEquality().hash(_includeOnly),const DeepCollectionEquality().hash(_exclude));

@override
String toString() {
  return 'GetExchangesParams(page: $page, asset: $asset, includeOnly: $includeOnly, exclude: $exclude)';
}


}

/// @nodoc
abstract mixin class _$GetExchangesParamsCopyWith<$Res> implements $GetExchangesParamsCopyWith<$Res> {
  factory _$GetExchangesParamsCopyWith(_GetExchangesParams value, $Res Function(_GetExchangesParams) _then) = __$GetExchangesParamsCopyWithImpl;
@override @useResult
$Res call({
 int page, ExchangeAsset? asset, List<String>? includeOnly, List<String>? exclude
});


@override $ExchangeAssetCopyWith<$Res>? get asset;

}
/// @nodoc
class __$GetExchangesParamsCopyWithImpl<$Res>
    implements _$GetExchangesParamsCopyWith<$Res> {
  __$GetExchangesParamsCopyWithImpl(this._self, this._then);

  final _GetExchangesParams _self;
  final $Res Function(_GetExchangesParams) _then;

/// Create a copy of GetExchangesParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? page = null,Object? asset = freezed,Object? includeOnly = freezed,Object? exclude = freezed,}) {
  return _then(_GetExchangesParams(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,asset: freezed == asset ? _self.asset : asset // ignore: cast_nullable_to_non_nullable
as ExchangeAsset?,includeOnly: freezed == includeOnly ? _self._includeOnly : includeOnly // ignore: cast_nullable_to_non_nullable
as List<String>?,exclude: freezed == exclude ? _self._exclude : exclude // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

/// Create a copy of GetExchangesParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExchangeAssetCopyWith<$Res>? get asset {
    if (_self.asset == null) {
    return null;
  }

  return $ExchangeAssetCopyWith<$Res>(_self.asset!, (value) {
    return _then(_self.copyWith(asset: value));
  });
}
}


/// @nodoc
mixin _$GetExchangeUrlParams {

 String get exchangeId; ExchangeAsset get asset;// CAIP-19 token address
 String get amount;// double as String
 String get recipient;
/// Create a copy of GetExchangeUrlParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetExchangeUrlParamsCopyWith<GetExchangeUrlParams> get copyWith => _$GetExchangeUrlParamsCopyWithImpl<GetExchangeUrlParams>(this as GetExchangeUrlParams, _$identity);

  /// Serializes this GetExchangeUrlParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetExchangeUrlParams&&(identical(other.exchangeId, exchangeId) || other.exchangeId == exchangeId)&&(identical(other.asset, asset) || other.asset == asset)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.recipient, recipient) || other.recipient == recipient));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,exchangeId,asset,amount,recipient);

@override
String toString() {
  return 'GetExchangeUrlParams(exchangeId: $exchangeId, asset: $asset, amount: $amount, recipient: $recipient)';
}


}

/// @nodoc
abstract mixin class $GetExchangeUrlParamsCopyWith<$Res>  {
  factory $GetExchangeUrlParamsCopyWith(GetExchangeUrlParams value, $Res Function(GetExchangeUrlParams) _then) = _$GetExchangeUrlParamsCopyWithImpl;
@useResult
$Res call({
 String exchangeId, ExchangeAsset asset, String amount, String recipient
});


$ExchangeAssetCopyWith<$Res> get asset;

}
/// @nodoc
class _$GetExchangeUrlParamsCopyWithImpl<$Res>
    implements $GetExchangeUrlParamsCopyWith<$Res> {
  _$GetExchangeUrlParamsCopyWithImpl(this._self, this._then);

  final GetExchangeUrlParams _self;
  final $Res Function(GetExchangeUrlParams) _then;

/// Create a copy of GetExchangeUrlParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? exchangeId = null,Object? asset = null,Object? amount = null,Object? recipient = null,}) {
  return _then(_self.copyWith(
exchangeId: null == exchangeId ? _self.exchangeId : exchangeId // ignore: cast_nullable_to_non_nullable
as String,asset: null == asset ? _self.asset : asset // ignore: cast_nullable_to_non_nullable
as ExchangeAsset,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,recipient: null == recipient ? _self.recipient : recipient // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of GetExchangeUrlParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExchangeAssetCopyWith<$Res> get asset {
  
  return $ExchangeAssetCopyWith<$Res>(_self.asset, (value) {
    return _then(_self.copyWith(asset: value));
  });
}
}


/// Adds pattern-matching-related methods to [GetExchangeUrlParams].
extension GetExchangeUrlParamsPatterns on GetExchangeUrlParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetExchangeUrlParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetExchangeUrlParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetExchangeUrlParams value)  $default,){
final _that = this;
switch (_that) {
case _GetExchangeUrlParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetExchangeUrlParams value)?  $default,){
final _that = this;
switch (_that) {
case _GetExchangeUrlParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String exchangeId,  ExchangeAsset asset,  String amount,  String recipient)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetExchangeUrlParams() when $default != null:
return $default(_that.exchangeId,_that.asset,_that.amount,_that.recipient);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String exchangeId,  ExchangeAsset asset,  String amount,  String recipient)  $default,) {final _that = this;
switch (_that) {
case _GetExchangeUrlParams():
return $default(_that.exchangeId,_that.asset,_that.amount,_that.recipient);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String exchangeId,  ExchangeAsset asset,  String amount,  String recipient)?  $default,) {final _that = this;
switch (_that) {
case _GetExchangeUrlParams() when $default != null:
return $default(_that.exchangeId,_that.asset,_that.amount,_that.recipient);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GetExchangeUrlParams implements GetExchangeUrlParams {
  const _GetExchangeUrlParams({required this.exchangeId, required this.asset, required this.amount, required this.recipient});
  factory _GetExchangeUrlParams.fromJson(Map<String, dynamic> json) => _$GetExchangeUrlParamsFromJson(json);

@override final  String exchangeId;
@override final  ExchangeAsset asset;
// CAIP-19 token address
@override final  String amount;
// double as String
@override final  String recipient;

/// Create a copy of GetExchangeUrlParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetExchangeUrlParamsCopyWith<_GetExchangeUrlParams> get copyWith => __$GetExchangeUrlParamsCopyWithImpl<_GetExchangeUrlParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GetExchangeUrlParamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetExchangeUrlParams&&(identical(other.exchangeId, exchangeId) || other.exchangeId == exchangeId)&&(identical(other.asset, asset) || other.asset == asset)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.recipient, recipient) || other.recipient == recipient));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,exchangeId,asset,amount,recipient);

@override
String toString() {
  return 'GetExchangeUrlParams(exchangeId: $exchangeId, asset: $asset, amount: $amount, recipient: $recipient)';
}


}

/// @nodoc
abstract mixin class _$GetExchangeUrlParamsCopyWith<$Res> implements $GetExchangeUrlParamsCopyWith<$Res> {
  factory _$GetExchangeUrlParamsCopyWith(_GetExchangeUrlParams value, $Res Function(_GetExchangeUrlParams) _then) = __$GetExchangeUrlParamsCopyWithImpl;
@override @useResult
$Res call({
 String exchangeId, ExchangeAsset asset, String amount, String recipient
});


@override $ExchangeAssetCopyWith<$Res> get asset;

}
/// @nodoc
class __$GetExchangeUrlParamsCopyWithImpl<$Res>
    implements _$GetExchangeUrlParamsCopyWith<$Res> {
  __$GetExchangeUrlParamsCopyWithImpl(this._self, this._then);

  final _GetExchangeUrlParams _self;
  final $Res Function(_GetExchangeUrlParams) _then;

/// Create a copy of GetExchangeUrlParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? exchangeId = null,Object? asset = null,Object? amount = null,Object? recipient = null,}) {
  return _then(_GetExchangeUrlParams(
exchangeId: null == exchangeId ? _self.exchangeId : exchangeId // ignore: cast_nullable_to_non_nullable
as String,asset: null == asset ? _self.asset : asset // ignore: cast_nullable_to_non_nullable
as ExchangeAsset,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,recipient: null == recipient ? _self.recipient : recipient // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of GetExchangeUrlParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExchangeAssetCopyWith<$Res> get asset {
  
  return $ExchangeAssetCopyWith<$Res>(_self.asset, (value) {
    return _then(_self.copyWith(asset: value));
  });
}
}


/// @nodoc
mixin _$GetExchangeDepositStatusParams {

 String get exchangeId; String get sessionId;
/// Create a copy of GetExchangeDepositStatusParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetExchangeDepositStatusParamsCopyWith<GetExchangeDepositStatusParams> get copyWith => _$GetExchangeDepositStatusParamsCopyWithImpl<GetExchangeDepositStatusParams>(this as GetExchangeDepositStatusParams, _$identity);

  /// Serializes this GetExchangeDepositStatusParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetExchangeDepositStatusParams&&(identical(other.exchangeId, exchangeId) || other.exchangeId == exchangeId)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,exchangeId,sessionId);

@override
String toString() {
  return 'GetExchangeDepositStatusParams(exchangeId: $exchangeId, sessionId: $sessionId)';
}


}

/// @nodoc
abstract mixin class $GetExchangeDepositStatusParamsCopyWith<$Res>  {
  factory $GetExchangeDepositStatusParamsCopyWith(GetExchangeDepositStatusParams value, $Res Function(GetExchangeDepositStatusParams) _then) = _$GetExchangeDepositStatusParamsCopyWithImpl;
@useResult
$Res call({
 String exchangeId, String sessionId
});




}
/// @nodoc
class _$GetExchangeDepositStatusParamsCopyWithImpl<$Res>
    implements $GetExchangeDepositStatusParamsCopyWith<$Res> {
  _$GetExchangeDepositStatusParamsCopyWithImpl(this._self, this._then);

  final GetExchangeDepositStatusParams _self;
  final $Res Function(GetExchangeDepositStatusParams) _then;

/// Create a copy of GetExchangeDepositStatusParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? exchangeId = null,Object? sessionId = null,}) {
  return _then(_self.copyWith(
exchangeId: null == exchangeId ? _self.exchangeId : exchangeId // ignore: cast_nullable_to_non_nullable
as String,sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GetExchangeDepositStatusParams].
extension GetExchangeDepositStatusParamsPatterns on GetExchangeDepositStatusParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetExchangeDepositStatusParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetExchangeDepositStatusParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetExchangeDepositStatusParams value)  $default,){
final _that = this;
switch (_that) {
case _GetExchangeDepositStatusParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetExchangeDepositStatusParams value)?  $default,){
final _that = this;
switch (_that) {
case _GetExchangeDepositStatusParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String exchangeId,  String sessionId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetExchangeDepositStatusParams() when $default != null:
return $default(_that.exchangeId,_that.sessionId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String exchangeId,  String sessionId)  $default,) {final _that = this;
switch (_that) {
case _GetExchangeDepositStatusParams():
return $default(_that.exchangeId,_that.sessionId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String exchangeId,  String sessionId)?  $default,) {final _that = this;
switch (_that) {
case _GetExchangeDepositStatusParams() when $default != null:
return $default(_that.exchangeId,_that.sessionId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GetExchangeDepositStatusParams implements GetExchangeDepositStatusParams {
  const _GetExchangeDepositStatusParams({required this.exchangeId, required this.sessionId});
  factory _GetExchangeDepositStatusParams.fromJson(Map<String, dynamic> json) => _$GetExchangeDepositStatusParamsFromJson(json);

@override final  String exchangeId;
@override final  String sessionId;

/// Create a copy of GetExchangeDepositStatusParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetExchangeDepositStatusParamsCopyWith<_GetExchangeDepositStatusParams> get copyWith => __$GetExchangeDepositStatusParamsCopyWithImpl<_GetExchangeDepositStatusParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GetExchangeDepositStatusParamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetExchangeDepositStatusParams&&(identical(other.exchangeId, exchangeId) || other.exchangeId == exchangeId)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,exchangeId,sessionId);

@override
String toString() {
  return 'GetExchangeDepositStatusParams(exchangeId: $exchangeId, sessionId: $sessionId)';
}


}

/// @nodoc
abstract mixin class _$GetExchangeDepositStatusParamsCopyWith<$Res> implements $GetExchangeDepositStatusParamsCopyWith<$Res> {
  factory _$GetExchangeDepositStatusParamsCopyWith(_GetExchangeDepositStatusParams value, $Res Function(_GetExchangeDepositStatusParams) _then) = __$GetExchangeDepositStatusParamsCopyWithImpl;
@override @useResult
$Res call({
 String exchangeId, String sessionId
});




}
/// @nodoc
class __$GetExchangeDepositStatusParamsCopyWithImpl<$Res>
    implements _$GetExchangeDepositStatusParamsCopyWith<$Res> {
  __$GetExchangeDepositStatusParamsCopyWithImpl(this._self, this._then);

  final _GetExchangeDepositStatusParams _self;
  final $Res Function(_GetExchangeDepositStatusParams) _then;

/// Create a copy of GetExchangeDepositStatusParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? exchangeId = null,Object? sessionId = null,}) {
  return _then(_GetExchangeDepositStatusParams(
exchangeId: null == exchangeId ? _self.exchangeId : exchangeId // ignore: cast_nullable_to_non_nullable
as String,sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
