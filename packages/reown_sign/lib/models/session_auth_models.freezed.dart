// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_auth_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SessionAuthRequestParams {

 String get domain; List<String> get chains; String get nonce; String get uri;//
 CacaoHeader? get type; String? get exp; String? get nbf; String? get statement; String? get requestId; List<String>? get resources; int? get expiry; Map<String, List<String>>? get signatureTypes;@Deprecated('`methods` will be deprecated soon. Please use `connect` with `authentication` param') List<String>? get methods;
/// Create a copy of SessionAuthRequestParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionAuthRequestParamsCopyWith<SessionAuthRequestParams> get copyWith => _$SessionAuthRequestParamsCopyWithImpl<SessionAuthRequestParams>(this as SessionAuthRequestParams, _$identity);

  /// Serializes this SessionAuthRequestParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionAuthRequestParams&&(identical(other.domain, domain) || other.domain == domain)&&const DeepCollectionEquality().equals(other.chains, chains)&&(identical(other.nonce, nonce) || other.nonce == nonce)&&(identical(other.uri, uri) || other.uri == uri)&&(identical(other.type, type) || other.type == type)&&(identical(other.exp, exp) || other.exp == exp)&&(identical(other.nbf, nbf) || other.nbf == nbf)&&(identical(other.statement, statement) || other.statement == statement)&&(identical(other.requestId, requestId) || other.requestId == requestId)&&const DeepCollectionEquality().equals(other.resources, resources)&&(identical(other.expiry, expiry) || other.expiry == expiry)&&const DeepCollectionEquality().equals(other.signatureTypes, signatureTypes)&&const DeepCollectionEquality().equals(other.methods, methods));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,domain,const DeepCollectionEquality().hash(chains),nonce,uri,type,exp,nbf,statement,requestId,const DeepCollectionEquality().hash(resources),expiry,const DeepCollectionEquality().hash(signatureTypes),const DeepCollectionEquality().hash(methods));

@override
String toString() {
  return 'SessionAuthRequestParams(domain: $domain, chains: $chains, nonce: $nonce, uri: $uri, type: $type, exp: $exp, nbf: $nbf, statement: $statement, requestId: $requestId, resources: $resources, expiry: $expiry, signatureTypes: $signatureTypes, methods: $methods)';
}


}

/// @nodoc
abstract mixin class $SessionAuthRequestParamsCopyWith<$Res>  {
  factory $SessionAuthRequestParamsCopyWith(SessionAuthRequestParams value, $Res Function(SessionAuthRequestParams) _then) = _$SessionAuthRequestParamsCopyWithImpl;
@useResult
$Res call({
 String domain, List<String> chains, String nonce, String uri, CacaoHeader? type, String? exp, String? nbf, String? statement, String? requestId, List<String>? resources, int? expiry, Map<String, List<String>>? signatureTypes,@Deprecated('`methods` will be deprecated soon. Please use `connect` with `authentication` param') List<String>? methods
});


$CacaoHeaderCopyWith<$Res>? get type;

}
/// @nodoc
class _$SessionAuthRequestParamsCopyWithImpl<$Res>
    implements $SessionAuthRequestParamsCopyWith<$Res> {
  _$SessionAuthRequestParamsCopyWithImpl(this._self, this._then);

  final SessionAuthRequestParams _self;
  final $Res Function(SessionAuthRequestParams) _then;

/// Create a copy of SessionAuthRequestParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? domain = null,Object? chains = null,Object? nonce = null,Object? uri = null,Object? type = freezed,Object? exp = freezed,Object? nbf = freezed,Object? statement = freezed,Object? requestId = freezed,Object? resources = freezed,Object? expiry = freezed,Object? signatureTypes = freezed,Object? methods = freezed,}) {
  return _then(_self.copyWith(
domain: null == domain ? _self.domain : domain // ignore: cast_nullable_to_non_nullable
as String,chains: null == chains ? _self.chains : chains // ignore: cast_nullable_to_non_nullable
as List<String>,nonce: null == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as String,uri: null == uri ? _self.uri : uri // ignore: cast_nullable_to_non_nullable
as String,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CacaoHeader?,exp: freezed == exp ? _self.exp : exp // ignore: cast_nullable_to_non_nullable
as String?,nbf: freezed == nbf ? _self.nbf : nbf // ignore: cast_nullable_to_non_nullable
as String?,statement: freezed == statement ? _self.statement : statement // ignore: cast_nullable_to_non_nullable
as String?,requestId: freezed == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String?,resources: freezed == resources ? _self.resources : resources // ignore: cast_nullable_to_non_nullable
as List<String>?,expiry: freezed == expiry ? _self.expiry : expiry // ignore: cast_nullable_to_non_nullable
as int?,signatureTypes: freezed == signatureTypes ? _self.signatureTypes : signatureTypes // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>?,methods: freezed == methods ? _self.methods : methods // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}
/// Create a copy of SessionAuthRequestParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CacaoHeaderCopyWith<$Res>? get type {
    if (_self.type == null) {
    return null;
  }

  return $CacaoHeaderCopyWith<$Res>(_self.type!, (value) {
    return _then(_self.copyWith(type: value));
  });
}
}


/// Adds pattern-matching-related methods to [SessionAuthRequestParams].
extension SessionAuthRequestParamsPatterns on SessionAuthRequestParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionAuthRequestParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionAuthRequestParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionAuthRequestParams value)  $default,){
final _that = this;
switch (_that) {
case _SessionAuthRequestParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionAuthRequestParams value)?  $default,){
final _that = this;
switch (_that) {
case _SessionAuthRequestParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String domain,  List<String> chains,  String nonce,  String uri,  CacaoHeader? type,  String? exp,  String? nbf,  String? statement,  String? requestId,  List<String>? resources,  int? expiry,  Map<String, List<String>>? signatureTypes, @Deprecated('`methods` will be deprecated soon. Please use `connect` with `authentication` param')  List<String>? methods)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionAuthRequestParams() when $default != null:
return $default(_that.domain,_that.chains,_that.nonce,_that.uri,_that.type,_that.exp,_that.nbf,_that.statement,_that.requestId,_that.resources,_that.expiry,_that.signatureTypes,_that.methods);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String domain,  List<String> chains,  String nonce,  String uri,  CacaoHeader? type,  String? exp,  String? nbf,  String? statement,  String? requestId,  List<String>? resources,  int? expiry,  Map<String, List<String>>? signatureTypes, @Deprecated('`methods` will be deprecated soon. Please use `connect` with `authentication` param')  List<String>? methods)  $default,) {final _that = this;
switch (_that) {
case _SessionAuthRequestParams():
return $default(_that.domain,_that.chains,_that.nonce,_that.uri,_that.type,_that.exp,_that.nbf,_that.statement,_that.requestId,_that.resources,_that.expiry,_that.signatureTypes,_that.methods);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String domain,  List<String> chains,  String nonce,  String uri,  CacaoHeader? type,  String? exp,  String? nbf,  String? statement,  String? requestId,  List<String>? resources,  int? expiry,  Map<String, List<String>>? signatureTypes, @Deprecated('`methods` will be deprecated soon. Please use `connect` with `authentication` param')  List<String>? methods)?  $default,) {final _that = this;
switch (_that) {
case _SessionAuthRequestParams() when $default != null:
return $default(_that.domain,_that.chains,_that.nonce,_that.uri,_that.type,_that.exp,_that.nbf,_that.statement,_that.requestId,_that.resources,_that.expiry,_that.signatureTypes,_that.methods);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _SessionAuthRequestParams implements SessionAuthRequestParams {
  const _SessionAuthRequestParams({required this.domain, required final  List<String> chains, required this.nonce, required this.uri, this.type, this.exp, this.nbf, this.statement, this.requestId, final  List<String>? resources, this.expiry, final  Map<String, List<String>>? signatureTypes, @Deprecated('`methods` will be deprecated soon. Please use `connect` with `authentication` param') final  List<String>? methods}): _chains = chains,_resources = resources,_signatureTypes = signatureTypes,_methods = methods;
  factory _SessionAuthRequestParams.fromJson(Map<String, dynamic> json) => _$SessionAuthRequestParamsFromJson(json);

@override final  String domain;
 final  List<String> _chains;
@override List<String> get chains {
  if (_chains is EqualUnmodifiableListView) return _chains;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_chains);
}

@override final  String nonce;
@override final  String uri;
//
@override final  CacaoHeader? type;
@override final  String? exp;
@override final  String? nbf;
@override final  String? statement;
@override final  String? requestId;
 final  List<String>? _resources;
@override List<String>? get resources {
  final value = _resources;
  if (value == null) return null;
  if (_resources is EqualUnmodifiableListView) return _resources;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  int? expiry;
 final  Map<String, List<String>>? _signatureTypes;
@override Map<String, List<String>>? get signatureTypes {
  final value = _signatureTypes;
  if (value == null) return null;
  if (_signatureTypes is EqualUnmodifiableMapView) return _signatureTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  List<String>? _methods;
@override@Deprecated('`methods` will be deprecated soon. Please use `connect` with `authentication` param') List<String>? get methods {
  final value = _methods;
  if (value == null) return null;
  if (_methods is EqualUnmodifiableListView) return _methods;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of SessionAuthRequestParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionAuthRequestParamsCopyWith<_SessionAuthRequestParams> get copyWith => __$SessionAuthRequestParamsCopyWithImpl<_SessionAuthRequestParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SessionAuthRequestParamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionAuthRequestParams&&(identical(other.domain, domain) || other.domain == domain)&&const DeepCollectionEquality().equals(other._chains, _chains)&&(identical(other.nonce, nonce) || other.nonce == nonce)&&(identical(other.uri, uri) || other.uri == uri)&&(identical(other.type, type) || other.type == type)&&(identical(other.exp, exp) || other.exp == exp)&&(identical(other.nbf, nbf) || other.nbf == nbf)&&(identical(other.statement, statement) || other.statement == statement)&&(identical(other.requestId, requestId) || other.requestId == requestId)&&const DeepCollectionEquality().equals(other._resources, _resources)&&(identical(other.expiry, expiry) || other.expiry == expiry)&&const DeepCollectionEquality().equals(other._signatureTypes, _signatureTypes)&&const DeepCollectionEquality().equals(other._methods, _methods));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,domain,const DeepCollectionEquality().hash(_chains),nonce,uri,type,exp,nbf,statement,requestId,const DeepCollectionEquality().hash(_resources),expiry,const DeepCollectionEquality().hash(_signatureTypes),const DeepCollectionEquality().hash(_methods));

@override
String toString() {
  return 'SessionAuthRequestParams(domain: $domain, chains: $chains, nonce: $nonce, uri: $uri, type: $type, exp: $exp, nbf: $nbf, statement: $statement, requestId: $requestId, resources: $resources, expiry: $expiry, signatureTypes: $signatureTypes, methods: $methods)';
}


}

/// @nodoc
abstract mixin class _$SessionAuthRequestParamsCopyWith<$Res> implements $SessionAuthRequestParamsCopyWith<$Res> {
  factory _$SessionAuthRequestParamsCopyWith(_SessionAuthRequestParams value, $Res Function(_SessionAuthRequestParams) _then) = __$SessionAuthRequestParamsCopyWithImpl;
@override @useResult
$Res call({
 String domain, List<String> chains, String nonce, String uri, CacaoHeader? type, String? exp, String? nbf, String? statement, String? requestId, List<String>? resources, int? expiry, Map<String, List<String>>? signatureTypes,@Deprecated('`methods` will be deprecated soon. Please use `connect` with `authentication` param') List<String>? methods
});


@override $CacaoHeaderCopyWith<$Res>? get type;

}
/// @nodoc
class __$SessionAuthRequestParamsCopyWithImpl<$Res>
    implements _$SessionAuthRequestParamsCopyWith<$Res> {
  __$SessionAuthRequestParamsCopyWithImpl(this._self, this._then);

  final _SessionAuthRequestParams _self;
  final $Res Function(_SessionAuthRequestParams) _then;

/// Create a copy of SessionAuthRequestParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? domain = null,Object? chains = null,Object? nonce = null,Object? uri = null,Object? type = freezed,Object? exp = freezed,Object? nbf = freezed,Object? statement = freezed,Object? requestId = freezed,Object? resources = freezed,Object? expiry = freezed,Object? signatureTypes = freezed,Object? methods = freezed,}) {
  return _then(_SessionAuthRequestParams(
domain: null == domain ? _self.domain : domain // ignore: cast_nullable_to_non_nullable
as String,chains: null == chains ? _self._chains : chains // ignore: cast_nullable_to_non_nullable
as List<String>,nonce: null == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as String,uri: null == uri ? _self.uri : uri // ignore: cast_nullable_to_non_nullable
as String,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CacaoHeader?,exp: freezed == exp ? _self.exp : exp // ignore: cast_nullable_to_non_nullable
as String?,nbf: freezed == nbf ? _self.nbf : nbf // ignore: cast_nullable_to_non_nullable
as String?,statement: freezed == statement ? _self.statement : statement // ignore: cast_nullable_to_non_nullable
as String?,requestId: freezed == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String?,resources: freezed == resources ? _self._resources : resources // ignore: cast_nullable_to_non_nullable
as List<String>?,expiry: freezed == expiry ? _self.expiry : expiry // ignore: cast_nullable_to_non_nullable
as int?,signatureTypes: freezed == signatureTypes ? _self._signatureTypes : signatureTypes // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>?,methods: freezed == methods ? _self._methods : methods // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

/// Create a copy of SessionAuthRequestParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CacaoHeaderCopyWith<$Res>? get type {
    if (_self.type == null) {
    return null;
  }

  return $CacaoHeaderCopyWith<$Res>(_self.type!, (value) {
    return _then(_self.copyWith(type: value));
  });
}
}


/// @nodoc
mixin _$SessionAuthPayload {

 String get domain; List<String> get chains; String get nonce; String get aud; String get type;//
 String get version; String get iat;//
 String? get nbf; String? get exp; String? get statement; String? get requestId; List<String>? get resources;
/// Create a copy of SessionAuthPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionAuthPayloadCopyWith<SessionAuthPayload> get copyWith => _$SessionAuthPayloadCopyWithImpl<SessionAuthPayload>(this as SessionAuthPayload, _$identity);

  /// Serializes this SessionAuthPayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionAuthPayload&&(identical(other.domain, domain) || other.domain == domain)&&const DeepCollectionEquality().equals(other.chains, chains)&&(identical(other.nonce, nonce) || other.nonce == nonce)&&(identical(other.aud, aud) || other.aud == aud)&&(identical(other.type, type) || other.type == type)&&(identical(other.version, version) || other.version == version)&&(identical(other.iat, iat) || other.iat == iat)&&(identical(other.nbf, nbf) || other.nbf == nbf)&&(identical(other.exp, exp) || other.exp == exp)&&(identical(other.statement, statement) || other.statement == statement)&&(identical(other.requestId, requestId) || other.requestId == requestId)&&const DeepCollectionEquality().equals(other.resources, resources));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,domain,const DeepCollectionEquality().hash(chains),nonce,aud,type,version,iat,nbf,exp,statement,requestId,const DeepCollectionEquality().hash(resources));

@override
String toString() {
  return 'SessionAuthPayload(domain: $domain, chains: $chains, nonce: $nonce, aud: $aud, type: $type, version: $version, iat: $iat, nbf: $nbf, exp: $exp, statement: $statement, requestId: $requestId, resources: $resources)';
}


}

/// @nodoc
abstract mixin class $SessionAuthPayloadCopyWith<$Res>  {
  factory $SessionAuthPayloadCopyWith(SessionAuthPayload value, $Res Function(SessionAuthPayload) _then) = _$SessionAuthPayloadCopyWithImpl;
@useResult
$Res call({
 String domain, List<String> chains, String nonce, String aud, String type, String version, String iat, String? nbf, String? exp, String? statement, String? requestId, List<String>? resources
});




}
/// @nodoc
class _$SessionAuthPayloadCopyWithImpl<$Res>
    implements $SessionAuthPayloadCopyWith<$Res> {
  _$SessionAuthPayloadCopyWithImpl(this._self, this._then);

  final SessionAuthPayload _self;
  final $Res Function(SessionAuthPayload) _then;

/// Create a copy of SessionAuthPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? domain = null,Object? chains = null,Object? nonce = null,Object? aud = null,Object? type = null,Object? version = null,Object? iat = null,Object? nbf = freezed,Object? exp = freezed,Object? statement = freezed,Object? requestId = freezed,Object? resources = freezed,}) {
  return _then(_self.copyWith(
domain: null == domain ? _self.domain : domain // ignore: cast_nullable_to_non_nullable
as String,chains: null == chains ? _self.chains : chains // ignore: cast_nullable_to_non_nullable
as List<String>,nonce: null == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as String,aud: null == aud ? _self.aud : aud // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,iat: null == iat ? _self.iat : iat // ignore: cast_nullable_to_non_nullable
as String,nbf: freezed == nbf ? _self.nbf : nbf // ignore: cast_nullable_to_non_nullable
as String?,exp: freezed == exp ? _self.exp : exp // ignore: cast_nullable_to_non_nullable
as String?,statement: freezed == statement ? _self.statement : statement // ignore: cast_nullable_to_non_nullable
as String?,requestId: freezed == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String?,resources: freezed == resources ? _self.resources : resources // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [SessionAuthPayload].
extension SessionAuthPayloadPatterns on SessionAuthPayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionAuthPayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionAuthPayload() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionAuthPayload value)  $default,){
final _that = this;
switch (_that) {
case _SessionAuthPayload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionAuthPayload value)?  $default,){
final _that = this;
switch (_that) {
case _SessionAuthPayload() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String domain,  List<String> chains,  String nonce,  String aud,  String type,  String version,  String iat,  String? nbf,  String? exp,  String? statement,  String? requestId,  List<String>? resources)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionAuthPayload() when $default != null:
return $default(_that.domain,_that.chains,_that.nonce,_that.aud,_that.type,_that.version,_that.iat,_that.nbf,_that.exp,_that.statement,_that.requestId,_that.resources);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String domain,  List<String> chains,  String nonce,  String aud,  String type,  String version,  String iat,  String? nbf,  String? exp,  String? statement,  String? requestId,  List<String>? resources)  $default,) {final _that = this;
switch (_that) {
case _SessionAuthPayload():
return $default(_that.domain,_that.chains,_that.nonce,_that.aud,_that.type,_that.version,_that.iat,_that.nbf,_that.exp,_that.statement,_that.requestId,_that.resources);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String domain,  List<String> chains,  String nonce,  String aud,  String type,  String version,  String iat,  String? nbf,  String? exp,  String? statement,  String? requestId,  List<String>? resources)?  $default,) {final _that = this;
switch (_that) {
case _SessionAuthPayload() when $default != null:
return $default(_that.domain,_that.chains,_that.nonce,_that.aud,_that.type,_that.version,_that.iat,_that.nbf,_that.exp,_that.statement,_that.requestId,_that.resources);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _SessionAuthPayload implements SessionAuthPayload {
  const _SessionAuthPayload({required this.domain, required final  List<String> chains, required this.nonce, required this.aud, required this.type, required this.version, required this.iat, this.nbf, this.exp, this.statement, this.requestId, final  List<String>? resources}): _chains = chains,_resources = resources;
  factory _SessionAuthPayload.fromJson(Map<String, dynamic> json) => _$SessionAuthPayloadFromJson(json);

@override final  String domain;
 final  List<String> _chains;
@override List<String> get chains {
  if (_chains is EqualUnmodifiableListView) return _chains;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_chains);
}

@override final  String nonce;
@override final  String aud;
@override final  String type;
//
@override final  String version;
@override final  String iat;
//
@override final  String? nbf;
@override final  String? exp;
@override final  String? statement;
@override final  String? requestId;
 final  List<String>? _resources;
@override List<String>? get resources {
  final value = _resources;
  if (value == null) return null;
  if (_resources is EqualUnmodifiableListView) return _resources;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of SessionAuthPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionAuthPayloadCopyWith<_SessionAuthPayload> get copyWith => __$SessionAuthPayloadCopyWithImpl<_SessionAuthPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SessionAuthPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionAuthPayload&&(identical(other.domain, domain) || other.domain == domain)&&const DeepCollectionEquality().equals(other._chains, _chains)&&(identical(other.nonce, nonce) || other.nonce == nonce)&&(identical(other.aud, aud) || other.aud == aud)&&(identical(other.type, type) || other.type == type)&&(identical(other.version, version) || other.version == version)&&(identical(other.iat, iat) || other.iat == iat)&&(identical(other.nbf, nbf) || other.nbf == nbf)&&(identical(other.exp, exp) || other.exp == exp)&&(identical(other.statement, statement) || other.statement == statement)&&(identical(other.requestId, requestId) || other.requestId == requestId)&&const DeepCollectionEquality().equals(other._resources, _resources));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,domain,const DeepCollectionEquality().hash(_chains),nonce,aud,type,version,iat,nbf,exp,statement,requestId,const DeepCollectionEquality().hash(_resources));

@override
String toString() {
  return 'SessionAuthPayload(domain: $domain, chains: $chains, nonce: $nonce, aud: $aud, type: $type, version: $version, iat: $iat, nbf: $nbf, exp: $exp, statement: $statement, requestId: $requestId, resources: $resources)';
}


}

/// @nodoc
abstract mixin class _$SessionAuthPayloadCopyWith<$Res> implements $SessionAuthPayloadCopyWith<$Res> {
  factory _$SessionAuthPayloadCopyWith(_SessionAuthPayload value, $Res Function(_SessionAuthPayload) _then) = __$SessionAuthPayloadCopyWithImpl;
@override @useResult
$Res call({
 String domain, List<String> chains, String nonce, String aud, String type, String version, String iat, String? nbf, String? exp, String? statement, String? requestId, List<String>? resources
});




}
/// @nodoc
class __$SessionAuthPayloadCopyWithImpl<$Res>
    implements _$SessionAuthPayloadCopyWith<$Res> {
  __$SessionAuthPayloadCopyWithImpl(this._self, this._then);

  final _SessionAuthPayload _self;
  final $Res Function(_SessionAuthPayload) _then;

/// Create a copy of SessionAuthPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? domain = null,Object? chains = null,Object? nonce = null,Object? aud = null,Object? type = null,Object? version = null,Object? iat = null,Object? nbf = freezed,Object? exp = freezed,Object? statement = freezed,Object? requestId = freezed,Object? resources = freezed,}) {
  return _then(_SessionAuthPayload(
domain: null == domain ? _self.domain : domain // ignore: cast_nullable_to_non_nullable
as String,chains: null == chains ? _self._chains : chains // ignore: cast_nullable_to_non_nullable
as List<String>,nonce: null == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as String,aud: null == aud ? _self.aud : aud // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,iat: null == iat ? _self.iat : iat // ignore: cast_nullable_to_non_nullable
as String,nbf: freezed == nbf ? _self.nbf : nbf // ignore: cast_nullable_to_non_nullable
as String?,exp: freezed == exp ? _self.exp : exp // ignore: cast_nullable_to_non_nullable
as String?,statement: freezed == statement ? _self.statement : statement // ignore: cast_nullable_to_non_nullable
as String?,requestId: freezed == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String?,resources: freezed == resources ? _self._resources : resources // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}


/// @nodoc
mixin _$PendingSessionAuthRequest {

 int get id; String get pairingTopic; ConnectionMetadata get requester; int get expiryTimestamp; CacaoRequestPayload get authPayload; VerifyContext get verifyContext; TransportType get transportType;
/// Create a copy of PendingSessionAuthRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PendingSessionAuthRequestCopyWith<PendingSessionAuthRequest> get copyWith => _$PendingSessionAuthRequestCopyWithImpl<PendingSessionAuthRequest>(this as PendingSessionAuthRequest, _$identity);

  /// Serializes this PendingSessionAuthRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PendingSessionAuthRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.pairingTopic, pairingTopic) || other.pairingTopic == pairingTopic)&&(identical(other.requester, requester) || other.requester == requester)&&(identical(other.expiryTimestamp, expiryTimestamp) || other.expiryTimestamp == expiryTimestamp)&&(identical(other.authPayload, authPayload) || other.authPayload == authPayload)&&(identical(other.verifyContext, verifyContext) || other.verifyContext == verifyContext)&&(identical(other.transportType, transportType) || other.transportType == transportType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,pairingTopic,requester,expiryTimestamp,authPayload,verifyContext,transportType);

@override
String toString() {
  return 'PendingSessionAuthRequest(id: $id, pairingTopic: $pairingTopic, requester: $requester, expiryTimestamp: $expiryTimestamp, authPayload: $authPayload, verifyContext: $verifyContext, transportType: $transportType)';
}


}

/// @nodoc
abstract mixin class $PendingSessionAuthRequestCopyWith<$Res>  {
  factory $PendingSessionAuthRequestCopyWith(PendingSessionAuthRequest value, $Res Function(PendingSessionAuthRequest) _then) = _$PendingSessionAuthRequestCopyWithImpl;
@useResult
$Res call({
 int id, String pairingTopic, ConnectionMetadata requester, int expiryTimestamp, CacaoRequestPayload authPayload, VerifyContext verifyContext, TransportType transportType
});


$ConnectionMetadataCopyWith<$Res> get requester;$CacaoRequestPayloadCopyWith<$Res> get authPayload;$VerifyContextCopyWith<$Res> get verifyContext;

}
/// @nodoc
class _$PendingSessionAuthRequestCopyWithImpl<$Res>
    implements $PendingSessionAuthRequestCopyWith<$Res> {
  _$PendingSessionAuthRequestCopyWithImpl(this._self, this._then);

  final PendingSessionAuthRequest _self;
  final $Res Function(PendingSessionAuthRequest) _then;

/// Create a copy of PendingSessionAuthRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? pairingTopic = null,Object? requester = null,Object? expiryTimestamp = null,Object? authPayload = null,Object? verifyContext = null,Object? transportType = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,pairingTopic: null == pairingTopic ? _self.pairingTopic : pairingTopic // ignore: cast_nullable_to_non_nullable
as String,requester: null == requester ? _self.requester : requester // ignore: cast_nullable_to_non_nullable
as ConnectionMetadata,expiryTimestamp: null == expiryTimestamp ? _self.expiryTimestamp : expiryTimestamp // ignore: cast_nullable_to_non_nullable
as int,authPayload: null == authPayload ? _self.authPayload : authPayload // ignore: cast_nullable_to_non_nullable
as CacaoRequestPayload,verifyContext: null == verifyContext ? _self.verifyContext : verifyContext // ignore: cast_nullable_to_non_nullable
as VerifyContext,transportType: null == transportType ? _self.transportType : transportType // ignore: cast_nullable_to_non_nullable
as TransportType,
  ));
}
/// Create a copy of PendingSessionAuthRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConnectionMetadataCopyWith<$Res> get requester {
  
  return $ConnectionMetadataCopyWith<$Res>(_self.requester, (value) {
    return _then(_self.copyWith(requester: value));
  });
}/// Create a copy of PendingSessionAuthRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CacaoRequestPayloadCopyWith<$Res> get authPayload {
  
  return $CacaoRequestPayloadCopyWith<$Res>(_self.authPayload, (value) {
    return _then(_self.copyWith(authPayload: value));
  });
}/// Create a copy of PendingSessionAuthRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VerifyContextCopyWith<$Res> get verifyContext {
  
  return $VerifyContextCopyWith<$Res>(_self.verifyContext, (value) {
    return _then(_self.copyWith(verifyContext: value));
  });
}
}


/// Adds pattern-matching-related methods to [PendingSessionAuthRequest].
extension PendingSessionAuthRequestPatterns on PendingSessionAuthRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PendingSessionAuthRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PendingSessionAuthRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PendingSessionAuthRequest value)  $default,){
final _that = this;
switch (_that) {
case _PendingSessionAuthRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PendingSessionAuthRequest value)?  $default,){
final _that = this;
switch (_that) {
case _PendingSessionAuthRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String pairingTopic,  ConnectionMetadata requester,  int expiryTimestamp,  CacaoRequestPayload authPayload,  VerifyContext verifyContext,  TransportType transportType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PendingSessionAuthRequest() when $default != null:
return $default(_that.id,_that.pairingTopic,_that.requester,_that.expiryTimestamp,_that.authPayload,_that.verifyContext,_that.transportType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String pairingTopic,  ConnectionMetadata requester,  int expiryTimestamp,  CacaoRequestPayload authPayload,  VerifyContext verifyContext,  TransportType transportType)  $default,) {final _that = this;
switch (_that) {
case _PendingSessionAuthRequest():
return $default(_that.id,_that.pairingTopic,_that.requester,_that.expiryTimestamp,_that.authPayload,_that.verifyContext,_that.transportType);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String pairingTopic,  ConnectionMetadata requester,  int expiryTimestamp,  CacaoRequestPayload authPayload,  VerifyContext verifyContext,  TransportType transportType)?  $default,) {final _that = this;
switch (_that) {
case _PendingSessionAuthRequest() when $default != null:
return $default(_that.id,_that.pairingTopic,_that.requester,_that.expiryTimestamp,_that.authPayload,_that.verifyContext,_that.transportType);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _PendingSessionAuthRequest implements PendingSessionAuthRequest {
  const _PendingSessionAuthRequest({required this.id, required this.pairingTopic, required this.requester, required this.expiryTimestamp, required this.authPayload, required this.verifyContext, this.transportType = TransportType.relay});
  factory _PendingSessionAuthRequest.fromJson(Map<String, dynamic> json) => _$PendingSessionAuthRequestFromJson(json);

@override final  int id;
@override final  String pairingTopic;
@override final  ConnectionMetadata requester;
@override final  int expiryTimestamp;
@override final  CacaoRequestPayload authPayload;
@override final  VerifyContext verifyContext;
@override@JsonKey() final  TransportType transportType;

/// Create a copy of PendingSessionAuthRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PendingSessionAuthRequestCopyWith<_PendingSessionAuthRequest> get copyWith => __$PendingSessionAuthRequestCopyWithImpl<_PendingSessionAuthRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PendingSessionAuthRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PendingSessionAuthRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.pairingTopic, pairingTopic) || other.pairingTopic == pairingTopic)&&(identical(other.requester, requester) || other.requester == requester)&&(identical(other.expiryTimestamp, expiryTimestamp) || other.expiryTimestamp == expiryTimestamp)&&(identical(other.authPayload, authPayload) || other.authPayload == authPayload)&&(identical(other.verifyContext, verifyContext) || other.verifyContext == verifyContext)&&(identical(other.transportType, transportType) || other.transportType == transportType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,pairingTopic,requester,expiryTimestamp,authPayload,verifyContext,transportType);

@override
String toString() {
  return 'PendingSessionAuthRequest(id: $id, pairingTopic: $pairingTopic, requester: $requester, expiryTimestamp: $expiryTimestamp, authPayload: $authPayload, verifyContext: $verifyContext, transportType: $transportType)';
}


}

/// @nodoc
abstract mixin class _$PendingSessionAuthRequestCopyWith<$Res> implements $PendingSessionAuthRequestCopyWith<$Res> {
  factory _$PendingSessionAuthRequestCopyWith(_PendingSessionAuthRequest value, $Res Function(_PendingSessionAuthRequest) _then) = __$PendingSessionAuthRequestCopyWithImpl;
@override @useResult
$Res call({
 int id, String pairingTopic, ConnectionMetadata requester, int expiryTimestamp, CacaoRequestPayload authPayload, VerifyContext verifyContext, TransportType transportType
});


@override $ConnectionMetadataCopyWith<$Res> get requester;@override $CacaoRequestPayloadCopyWith<$Res> get authPayload;@override $VerifyContextCopyWith<$Res> get verifyContext;

}
/// @nodoc
class __$PendingSessionAuthRequestCopyWithImpl<$Res>
    implements _$PendingSessionAuthRequestCopyWith<$Res> {
  __$PendingSessionAuthRequestCopyWithImpl(this._self, this._then);

  final _PendingSessionAuthRequest _self;
  final $Res Function(_PendingSessionAuthRequest) _then;

/// Create a copy of PendingSessionAuthRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? pairingTopic = null,Object? requester = null,Object? expiryTimestamp = null,Object? authPayload = null,Object? verifyContext = null,Object? transportType = null,}) {
  return _then(_PendingSessionAuthRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,pairingTopic: null == pairingTopic ? _self.pairingTopic : pairingTopic // ignore: cast_nullable_to_non_nullable
as String,requester: null == requester ? _self.requester : requester // ignore: cast_nullable_to_non_nullable
as ConnectionMetadata,expiryTimestamp: null == expiryTimestamp ? _self.expiryTimestamp : expiryTimestamp // ignore: cast_nullable_to_non_nullable
as int,authPayload: null == authPayload ? _self.authPayload : authPayload // ignore: cast_nullable_to_non_nullable
as CacaoRequestPayload,verifyContext: null == verifyContext ? _self.verifyContext : verifyContext // ignore: cast_nullable_to_non_nullable
as VerifyContext,transportType: null == transportType ? _self.transportType : transportType // ignore: cast_nullable_to_non_nullable
as TransportType,
  ));
}

/// Create a copy of PendingSessionAuthRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConnectionMetadataCopyWith<$Res> get requester {
  
  return $ConnectionMetadataCopyWith<$Res>(_self.requester, (value) {
    return _then(_self.copyWith(requester: value));
  });
}/// Create a copy of PendingSessionAuthRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CacaoRequestPayloadCopyWith<$Res> get authPayload {
  
  return $CacaoRequestPayloadCopyWith<$Res>(_self.authPayload, (value) {
    return _then(_self.copyWith(authPayload: value));
  });
}/// Create a copy of PendingSessionAuthRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VerifyContextCopyWith<$Res> get verifyContext {
  
  return $VerifyContextCopyWith<$Res>(_self.verifyContext, (value) {
    return _then(_self.copyWith(verifyContext: value));
  });
}
}

// dart format on
