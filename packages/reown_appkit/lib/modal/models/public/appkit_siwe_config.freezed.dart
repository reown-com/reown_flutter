// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appkit_siwe_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SIWECreateMessageArgs {

 String get chainId; String get domain; String get nonce; String get uri; String get address; String get version; CacaoHeader? get type; String? get nbf; String? get exp; String? get statement; String? get requestId; List<String>? get resources; int? get expiry; String? get iat;
/// Create a copy of SIWECreateMessageArgs
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SIWECreateMessageArgsCopyWith<SIWECreateMessageArgs> get copyWith => _$SIWECreateMessageArgsCopyWithImpl<SIWECreateMessageArgs>(this as SIWECreateMessageArgs, _$identity);

  /// Serializes this SIWECreateMessageArgs to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SIWECreateMessageArgs&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.domain, domain) || other.domain == domain)&&(identical(other.nonce, nonce) || other.nonce == nonce)&&(identical(other.uri, uri) || other.uri == uri)&&(identical(other.address, address) || other.address == address)&&(identical(other.version, version) || other.version == version)&&(identical(other.type, type) || other.type == type)&&(identical(other.nbf, nbf) || other.nbf == nbf)&&(identical(other.exp, exp) || other.exp == exp)&&(identical(other.statement, statement) || other.statement == statement)&&(identical(other.requestId, requestId) || other.requestId == requestId)&&const DeepCollectionEquality().equals(other.resources, resources)&&(identical(other.expiry, expiry) || other.expiry == expiry)&&(identical(other.iat, iat) || other.iat == iat));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,chainId,domain,nonce,uri,address,version,type,nbf,exp,statement,requestId,const DeepCollectionEquality().hash(resources),expiry,iat);

@override
String toString() {
  return 'SIWECreateMessageArgs(chainId: $chainId, domain: $domain, nonce: $nonce, uri: $uri, address: $address, version: $version, type: $type, nbf: $nbf, exp: $exp, statement: $statement, requestId: $requestId, resources: $resources, expiry: $expiry, iat: $iat)';
}


}

/// @nodoc
abstract mixin class $SIWECreateMessageArgsCopyWith<$Res>  {
  factory $SIWECreateMessageArgsCopyWith(SIWECreateMessageArgs value, $Res Function(SIWECreateMessageArgs) _then) = _$SIWECreateMessageArgsCopyWithImpl;
@useResult
$Res call({
 String chainId, String domain, String nonce, String uri, String address, String version, CacaoHeader? type, String? nbf, String? exp, String? statement, String? requestId, List<String>? resources, int? expiry, String? iat
});


$CacaoHeaderCopyWith<$Res>? get type;

}
/// @nodoc
class _$SIWECreateMessageArgsCopyWithImpl<$Res>
    implements $SIWECreateMessageArgsCopyWith<$Res> {
  _$SIWECreateMessageArgsCopyWithImpl(this._self, this._then);

  final SIWECreateMessageArgs _self;
  final $Res Function(SIWECreateMessageArgs) _then;

/// Create a copy of SIWECreateMessageArgs
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? chainId = null,Object? domain = null,Object? nonce = null,Object? uri = null,Object? address = null,Object? version = null,Object? type = freezed,Object? nbf = freezed,Object? exp = freezed,Object? statement = freezed,Object? requestId = freezed,Object? resources = freezed,Object? expiry = freezed,Object? iat = freezed,}) {
  return _then(_self.copyWith(
chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as String,domain: null == domain ? _self.domain : domain // ignore: cast_nullable_to_non_nullable
as String,nonce: null == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as String,uri: null == uri ? _self.uri : uri // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CacaoHeader?,nbf: freezed == nbf ? _self.nbf : nbf // ignore: cast_nullable_to_non_nullable
as String?,exp: freezed == exp ? _self.exp : exp // ignore: cast_nullable_to_non_nullable
as String?,statement: freezed == statement ? _self.statement : statement // ignore: cast_nullable_to_non_nullable
as String?,requestId: freezed == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String?,resources: freezed == resources ? _self.resources : resources // ignore: cast_nullable_to_non_nullable
as List<String>?,expiry: freezed == expiry ? _self.expiry : expiry // ignore: cast_nullable_to_non_nullable
as int?,iat: freezed == iat ? _self.iat : iat // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of SIWECreateMessageArgs
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


/// Adds pattern-matching-related methods to [SIWECreateMessageArgs].
extension SIWECreateMessageArgsPatterns on SIWECreateMessageArgs {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SIWECreateMessageArgs value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SIWECreateMessageArgs() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SIWECreateMessageArgs value)  $default,){
final _that = this;
switch (_that) {
case _SIWECreateMessageArgs():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SIWECreateMessageArgs value)?  $default,){
final _that = this;
switch (_that) {
case _SIWECreateMessageArgs() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String chainId,  String domain,  String nonce,  String uri,  String address,  String version,  CacaoHeader? type,  String? nbf,  String? exp,  String? statement,  String? requestId,  List<String>? resources,  int? expiry,  String? iat)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SIWECreateMessageArgs() when $default != null:
return $default(_that.chainId,_that.domain,_that.nonce,_that.uri,_that.address,_that.version,_that.type,_that.nbf,_that.exp,_that.statement,_that.requestId,_that.resources,_that.expiry,_that.iat);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String chainId,  String domain,  String nonce,  String uri,  String address,  String version,  CacaoHeader? type,  String? nbf,  String? exp,  String? statement,  String? requestId,  List<String>? resources,  int? expiry,  String? iat)  $default,) {final _that = this;
switch (_that) {
case _SIWECreateMessageArgs():
return $default(_that.chainId,_that.domain,_that.nonce,_that.uri,_that.address,_that.version,_that.type,_that.nbf,_that.exp,_that.statement,_that.requestId,_that.resources,_that.expiry,_that.iat);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String chainId,  String domain,  String nonce,  String uri,  String address,  String version,  CacaoHeader? type,  String? nbf,  String? exp,  String? statement,  String? requestId,  List<String>? resources,  int? expiry,  String? iat)?  $default,) {final _that = this;
switch (_that) {
case _SIWECreateMessageArgs() when $default != null:
return $default(_that.chainId,_that.domain,_that.nonce,_that.uri,_that.address,_that.version,_that.type,_that.nbf,_that.exp,_that.statement,_that.requestId,_that.resources,_that.expiry,_that.iat);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SIWECreateMessageArgs implements SIWECreateMessageArgs {
  const _SIWECreateMessageArgs({required this.chainId, required this.domain, required this.nonce, required this.uri, required this.address, this.version = '1', this.type = const CacaoHeader(t: 'eip4361'), this.nbf, this.exp, this.statement, this.requestId, final  List<String>? resources, this.expiry, this.iat}): _resources = resources;
  factory _SIWECreateMessageArgs.fromJson(Map<String, dynamic> json) => _$SIWECreateMessageArgsFromJson(json);

@override final  String chainId;
@override final  String domain;
@override final  String nonce;
@override final  String uri;
@override final  String address;
@override@JsonKey() final  String version;
@override@JsonKey() final  CacaoHeader? type;
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

@override final  int? expiry;
@override final  String? iat;

/// Create a copy of SIWECreateMessageArgs
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SIWECreateMessageArgsCopyWith<_SIWECreateMessageArgs> get copyWith => __$SIWECreateMessageArgsCopyWithImpl<_SIWECreateMessageArgs>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SIWECreateMessageArgsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SIWECreateMessageArgs&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.domain, domain) || other.domain == domain)&&(identical(other.nonce, nonce) || other.nonce == nonce)&&(identical(other.uri, uri) || other.uri == uri)&&(identical(other.address, address) || other.address == address)&&(identical(other.version, version) || other.version == version)&&(identical(other.type, type) || other.type == type)&&(identical(other.nbf, nbf) || other.nbf == nbf)&&(identical(other.exp, exp) || other.exp == exp)&&(identical(other.statement, statement) || other.statement == statement)&&(identical(other.requestId, requestId) || other.requestId == requestId)&&const DeepCollectionEquality().equals(other._resources, _resources)&&(identical(other.expiry, expiry) || other.expiry == expiry)&&(identical(other.iat, iat) || other.iat == iat));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,chainId,domain,nonce,uri,address,version,type,nbf,exp,statement,requestId,const DeepCollectionEquality().hash(_resources),expiry,iat);

@override
String toString() {
  return 'SIWECreateMessageArgs(chainId: $chainId, domain: $domain, nonce: $nonce, uri: $uri, address: $address, version: $version, type: $type, nbf: $nbf, exp: $exp, statement: $statement, requestId: $requestId, resources: $resources, expiry: $expiry, iat: $iat)';
}


}

/// @nodoc
abstract mixin class _$SIWECreateMessageArgsCopyWith<$Res> implements $SIWECreateMessageArgsCopyWith<$Res> {
  factory _$SIWECreateMessageArgsCopyWith(_SIWECreateMessageArgs value, $Res Function(_SIWECreateMessageArgs) _then) = __$SIWECreateMessageArgsCopyWithImpl;
@override @useResult
$Res call({
 String chainId, String domain, String nonce, String uri, String address, String version, CacaoHeader? type, String? nbf, String? exp, String? statement, String? requestId, List<String>? resources, int? expiry, String? iat
});


@override $CacaoHeaderCopyWith<$Res>? get type;

}
/// @nodoc
class __$SIWECreateMessageArgsCopyWithImpl<$Res>
    implements _$SIWECreateMessageArgsCopyWith<$Res> {
  __$SIWECreateMessageArgsCopyWithImpl(this._self, this._then);

  final _SIWECreateMessageArgs _self;
  final $Res Function(_SIWECreateMessageArgs) _then;

/// Create a copy of SIWECreateMessageArgs
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? chainId = null,Object? domain = null,Object? nonce = null,Object? uri = null,Object? address = null,Object? version = null,Object? type = freezed,Object? nbf = freezed,Object? exp = freezed,Object? statement = freezed,Object? requestId = freezed,Object? resources = freezed,Object? expiry = freezed,Object? iat = freezed,}) {
  return _then(_SIWECreateMessageArgs(
chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as String,domain: null == domain ? _self.domain : domain // ignore: cast_nullable_to_non_nullable
as String,nonce: null == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as String,uri: null == uri ? _self.uri : uri // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CacaoHeader?,nbf: freezed == nbf ? _self.nbf : nbf // ignore: cast_nullable_to_non_nullable
as String?,exp: freezed == exp ? _self.exp : exp // ignore: cast_nullable_to_non_nullable
as String?,statement: freezed == statement ? _self.statement : statement // ignore: cast_nullable_to_non_nullable
as String?,requestId: freezed == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String?,resources: freezed == resources ? _self._resources : resources // ignore: cast_nullable_to_non_nullable
as List<String>?,expiry: freezed == expiry ? _self.expiry : expiry // ignore: cast_nullable_to_non_nullable
as int?,iat: freezed == iat ? _self.iat : iat // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of SIWECreateMessageArgs
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
mixin _$SIWEMessageArgs {

 String get domain; String get uri; CacaoHeader? get type; String? get nbf; String? get exp; String? get statement; String? get requestId; List<String>? get resources; int? get expiry; String? get iat; List<String>? get methods;
/// Create a copy of SIWEMessageArgs
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SIWEMessageArgsCopyWith<SIWEMessageArgs> get copyWith => _$SIWEMessageArgsCopyWithImpl<SIWEMessageArgs>(this as SIWEMessageArgs, _$identity);

  /// Serializes this SIWEMessageArgs to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SIWEMessageArgs&&(identical(other.domain, domain) || other.domain == domain)&&(identical(other.uri, uri) || other.uri == uri)&&(identical(other.type, type) || other.type == type)&&(identical(other.nbf, nbf) || other.nbf == nbf)&&(identical(other.exp, exp) || other.exp == exp)&&(identical(other.statement, statement) || other.statement == statement)&&(identical(other.requestId, requestId) || other.requestId == requestId)&&const DeepCollectionEquality().equals(other.resources, resources)&&(identical(other.expiry, expiry) || other.expiry == expiry)&&(identical(other.iat, iat) || other.iat == iat)&&const DeepCollectionEquality().equals(other.methods, methods));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,domain,uri,type,nbf,exp,statement,requestId,const DeepCollectionEquality().hash(resources),expiry,iat,const DeepCollectionEquality().hash(methods));

@override
String toString() {
  return 'SIWEMessageArgs(domain: $domain, uri: $uri, type: $type, nbf: $nbf, exp: $exp, statement: $statement, requestId: $requestId, resources: $resources, expiry: $expiry, iat: $iat, methods: $methods)';
}


}

/// @nodoc
abstract mixin class $SIWEMessageArgsCopyWith<$Res>  {
  factory $SIWEMessageArgsCopyWith(SIWEMessageArgs value, $Res Function(SIWEMessageArgs) _then) = _$SIWEMessageArgsCopyWithImpl;
@useResult
$Res call({
 String domain, String uri, CacaoHeader? type, String? nbf, String? exp, String? statement, String? requestId, List<String>? resources, int? expiry, String? iat, List<String>? methods
});


$CacaoHeaderCopyWith<$Res>? get type;

}
/// @nodoc
class _$SIWEMessageArgsCopyWithImpl<$Res>
    implements $SIWEMessageArgsCopyWith<$Res> {
  _$SIWEMessageArgsCopyWithImpl(this._self, this._then);

  final SIWEMessageArgs _self;
  final $Res Function(SIWEMessageArgs) _then;

/// Create a copy of SIWEMessageArgs
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? domain = null,Object? uri = null,Object? type = freezed,Object? nbf = freezed,Object? exp = freezed,Object? statement = freezed,Object? requestId = freezed,Object? resources = freezed,Object? expiry = freezed,Object? iat = freezed,Object? methods = freezed,}) {
  return _then(_self.copyWith(
domain: null == domain ? _self.domain : domain // ignore: cast_nullable_to_non_nullable
as String,uri: null == uri ? _self.uri : uri // ignore: cast_nullable_to_non_nullable
as String,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CacaoHeader?,nbf: freezed == nbf ? _self.nbf : nbf // ignore: cast_nullable_to_non_nullable
as String?,exp: freezed == exp ? _self.exp : exp // ignore: cast_nullable_to_non_nullable
as String?,statement: freezed == statement ? _self.statement : statement // ignore: cast_nullable_to_non_nullable
as String?,requestId: freezed == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String?,resources: freezed == resources ? _self.resources : resources // ignore: cast_nullable_to_non_nullable
as List<String>?,expiry: freezed == expiry ? _self.expiry : expiry // ignore: cast_nullable_to_non_nullable
as int?,iat: freezed == iat ? _self.iat : iat // ignore: cast_nullable_to_non_nullable
as String?,methods: freezed == methods ? _self.methods : methods // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}
/// Create a copy of SIWEMessageArgs
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


/// Adds pattern-matching-related methods to [SIWEMessageArgs].
extension SIWEMessageArgsPatterns on SIWEMessageArgs {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SIWEMessageArgs value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SIWEMessageArgs() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SIWEMessageArgs value)  $default,){
final _that = this;
switch (_that) {
case _SIWEMessageArgs():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SIWEMessageArgs value)?  $default,){
final _that = this;
switch (_that) {
case _SIWEMessageArgs() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String domain,  String uri,  CacaoHeader? type,  String? nbf,  String? exp,  String? statement,  String? requestId,  List<String>? resources,  int? expiry,  String? iat,  List<String>? methods)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SIWEMessageArgs() when $default != null:
return $default(_that.domain,_that.uri,_that.type,_that.nbf,_that.exp,_that.statement,_that.requestId,_that.resources,_that.expiry,_that.iat,_that.methods);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String domain,  String uri,  CacaoHeader? type,  String? nbf,  String? exp,  String? statement,  String? requestId,  List<String>? resources,  int? expiry,  String? iat,  List<String>? methods)  $default,) {final _that = this;
switch (_that) {
case _SIWEMessageArgs():
return $default(_that.domain,_that.uri,_that.type,_that.nbf,_that.exp,_that.statement,_that.requestId,_that.resources,_that.expiry,_that.iat,_that.methods);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String domain,  String uri,  CacaoHeader? type,  String? nbf,  String? exp,  String? statement,  String? requestId,  List<String>? resources,  int? expiry,  String? iat,  List<String>? methods)?  $default,) {final _that = this;
switch (_that) {
case _SIWEMessageArgs() when $default != null:
return $default(_that.domain,_that.uri,_that.type,_that.nbf,_that.exp,_that.statement,_that.requestId,_that.resources,_that.expiry,_that.iat,_that.methods);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SIWEMessageArgs implements SIWEMessageArgs {
  const _SIWEMessageArgs({required this.domain, required this.uri, this.type = const CacaoHeader(t: 'eip4361'), this.nbf, this.exp, this.statement, this.requestId, final  List<String>? resources, this.expiry, this.iat, final  List<String>? methods}): _resources = resources,_methods = methods;
  factory _SIWEMessageArgs.fromJson(Map<String, dynamic> json) => _$SIWEMessageArgsFromJson(json);

@override final  String domain;
@override final  String uri;
@override@JsonKey() final  CacaoHeader? type;
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

@override final  int? expiry;
@override final  String? iat;
 final  List<String>? _methods;
@override List<String>? get methods {
  final value = _methods;
  if (value == null) return null;
  if (_methods is EqualUnmodifiableListView) return _methods;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of SIWEMessageArgs
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SIWEMessageArgsCopyWith<_SIWEMessageArgs> get copyWith => __$SIWEMessageArgsCopyWithImpl<_SIWEMessageArgs>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SIWEMessageArgsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SIWEMessageArgs&&(identical(other.domain, domain) || other.domain == domain)&&(identical(other.uri, uri) || other.uri == uri)&&(identical(other.type, type) || other.type == type)&&(identical(other.nbf, nbf) || other.nbf == nbf)&&(identical(other.exp, exp) || other.exp == exp)&&(identical(other.statement, statement) || other.statement == statement)&&(identical(other.requestId, requestId) || other.requestId == requestId)&&const DeepCollectionEquality().equals(other._resources, _resources)&&(identical(other.expiry, expiry) || other.expiry == expiry)&&(identical(other.iat, iat) || other.iat == iat)&&const DeepCollectionEquality().equals(other._methods, _methods));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,domain,uri,type,nbf,exp,statement,requestId,const DeepCollectionEquality().hash(_resources),expiry,iat,const DeepCollectionEquality().hash(_methods));

@override
String toString() {
  return 'SIWEMessageArgs(domain: $domain, uri: $uri, type: $type, nbf: $nbf, exp: $exp, statement: $statement, requestId: $requestId, resources: $resources, expiry: $expiry, iat: $iat, methods: $methods)';
}


}

/// @nodoc
abstract mixin class _$SIWEMessageArgsCopyWith<$Res> implements $SIWEMessageArgsCopyWith<$Res> {
  factory _$SIWEMessageArgsCopyWith(_SIWEMessageArgs value, $Res Function(_SIWEMessageArgs) _then) = __$SIWEMessageArgsCopyWithImpl;
@override @useResult
$Res call({
 String domain, String uri, CacaoHeader? type, String? nbf, String? exp, String? statement, String? requestId, List<String>? resources, int? expiry, String? iat, List<String>? methods
});


@override $CacaoHeaderCopyWith<$Res>? get type;

}
/// @nodoc
class __$SIWEMessageArgsCopyWithImpl<$Res>
    implements _$SIWEMessageArgsCopyWith<$Res> {
  __$SIWEMessageArgsCopyWithImpl(this._self, this._then);

  final _SIWEMessageArgs _self;
  final $Res Function(_SIWEMessageArgs) _then;

/// Create a copy of SIWEMessageArgs
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? domain = null,Object? uri = null,Object? type = freezed,Object? nbf = freezed,Object? exp = freezed,Object? statement = freezed,Object? requestId = freezed,Object? resources = freezed,Object? expiry = freezed,Object? iat = freezed,Object? methods = freezed,}) {
  return _then(_SIWEMessageArgs(
domain: null == domain ? _self.domain : domain // ignore: cast_nullable_to_non_nullable
as String,uri: null == uri ? _self.uri : uri // ignore: cast_nullable_to_non_nullable
as String,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CacaoHeader?,nbf: freezed == nbf ? _self.nbf : nbf // ignore: cast_nullable_to_non_nullable
as String?,exp: freezed == exp ? _self.exp : exp // ignore: cast_nullable_to_non_nullable
as String?,statement: freezed == statement ? _self.statement : statement // ignore: cast_nullable_to_non_nullable
as String?,requestId: freezed == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String?,resources: freezed == resources ? _self._resources : resources // ignore: cast_nullable_to_non_nullable
as List<String>?,expiry: freezed == expiry ? _self.expiry : expiry // ignore: cast_nullable_to_non_nullable
as int?,iat: freezed == iat ? _self.iat : iat // ignore: cast_nullable_to_non_nullable
as String?,methods: freezed == methods ? _self._methods : methods // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

/// Create a copy of SIWEMessageArgs
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
mixin _$SIWEVerifyMessageArgs {

 String get message; String get signature; Cacao? get cacao;// for One-Click Auth
 String? get clientId;
/// Create a copy of SIWEVerifyMessageArgs
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SIWEVerifyMessageArgsCopyWith<SIWEVerifyMessageArgs> get copyWith => _$SIWEVerifyMessageArgsCopyWithImpl<SIWEVerifyMessageArgs>(this as SIWEVerifyMessageArgs, _$identity);

  /// Serializes this SIWEVerifyMessageArgs to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SIWEVerifyMessageArgs&&(identical(other.message, message) || other.message == message)&&(identical(other.signature, signature) || other.signature == signature)&&(identical(other.cacao, cacao) || other.cacao == cacao)&&(identical(other.clientId, clientId) || other.clientId == clientId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,signature,cacao,clientId);

@override
String toString() {
  return 'SIWEVerifyMessageArgs(message: $message, signature: $signature, cacao: $cacao, clientId: $clientId)';
}


}

/// @nodoc
abstract mixin class $SIWEVerifyMessageArgsCopyWith<$Res>  {
  factory $SIWEVerifyMessageArgsCopyWith(SIWEVerifyMessageArgs value, $Res Function(SIWEVerifyMessageArgs) _then) = _$SIWEVerifyMessageArgsCopyWithImpl;
@useResult
$Res call({
 String message, String signature, Cacao? cacao, String? clientId
});


$CacaoCopyWith<$Res>? get cacao;

}
/// @nodoc
class _$SIWEVerifyMessageArgsCopyWithImpl<$Res>
    implements $SIWEVerifyMessageArgsCopyWith<$Res> {
  _$SIWEVerifyMessageArgsCopyWithImpl(this._self, this._then);

  final SIWEVerifyMessageArgs _self;
  final $Res Function(SIWEVerifyMessageArgs) _then;

/// Create a copy of SIWEVerifyMessageArgs
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,Object? signature = null,Object? cacao = freezed,Object? clientId = freezed,}) {
  return _then(_self.copyWith(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,signature: null == signature ? _self.signature : signature // ignore: cast_nullable_to_non_nullable
as String,cacao: freezed == cacao ? _self.cacao : cacao // ignore: cast_nullable_to_non_nullable
as Cacao?,clientId: freezed == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of SIWEVerifyMessageArgs
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CacaoCopyWith<$Res>? get cacao {
    if (_self.cacao == null) {
    return null;
  }

  return $CacaoCopyWith<$Res>(_self.cacao!, (value) {
    return _then(_self.copyWith(cacao: value));
  });
}
}


/// Adds pattern-matching-related methods to [SIWEVerifyMessageArgs].
extension SIWEVerifyMessageArgsPatterns on SIWEVerifyMessageArgs {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SIWEVerifyMessageArgs value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SIWEVerifyMessageArgs() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SIWEVerifyMessageArgs value)  $default,){
final _that = this;
switch (_that) {
case _SIWEVerifyMessageArgs():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SIWEVerifyMessageArgs value)?  $default,){
final _that = this;
switch (_that) {
case _SIWEVerifyMessageArgs() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String message,  String signature,  Cacao? cacao,  String? clientId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SIWEVerifyMessageArgs() when $default != null:
return $default(_that.message,_that.signature,_that.cacao,_that.clientId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String message,  String signature,  Cacao? cacao,  String? clientId)  $default,) {final _that = this;
switch (_that) {
case _SIWEVerifyMessageArgs():
return $default(_that.message,_that.signature,_that.cacao,_that.clientId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String message,  String signature,  Cacao? cacao,  String? clientId)?  $default,) {final _that = this;
switch (_that) {
case _SIWEVerifyMessageArgs() when $default != null:
return $default(_that.message,_that.signature,_that.cacao,_that.clientId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SIWEVerifyMessageArgs implements SIWEVerifyMessageArgs {
  const _SIWEVerifyMessageArgs({required this.message, required this.signature, this.cacao, this.clientId});
  factory _SIWEVerifyMessageArgs.fromJson(Map<String, dynamic> json) => _$SIWEVerifyMessageArgsFromJson(json);

@override final  String message;
@override final  String signature;
@override final  Cacao? cacao;
// for One-Click Auth
@override final  String? clientId;

/// Create a copy of SIWEVerifyMessageArgs
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SIWEVerifyMessageArgsCopyWith<_SIWEVerifyMessageArgs> get copyWith => __$SIWEVerifyMessageArgsCopyWithImpl<_SIWEVerifyMessageArgs>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SIWEVerifyMessageArgsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SIWEVerifyMessageArgs&&(identical(other.message, message) || other.message == message)&&(identical(other.signature, signature) || other.signature == signature)&&(identical(other.cacao, cacao) || other.cacao == cacao)&&(identical(other.clientId, clientId) || other.clientId == clientId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,signature,cacao,clientId);

@override
String toString() {
  return 'SIWEVerifyMessageArgs(message: $message, signature: $signature, cacao: $cacao, clientId: $clientId)';
}


}

/// @nodoc
abstract mixin class _$SIWEVerifyMessageArgsCopyWith<$Res> implements $SIWEVerifyMessageArgsCopyWith<$Res> {
  factory _$SIWEVerifyMessageArgsCopyWith(_SIWEVerifyMessageArgs value, $Res Function(_SIWEVerifyMessageArgs) _then) = __$SIWEVerifyMessageArgsCopyWithImpl;
@override @useResult
$Res call({
 String message, String signature, Cacao? cacao, String? clientId
});


@override $CacaoCopyWith<$Res>? get cacao;

}
/// @nodoc
class __$SIWEVerifyMessageArgsCopyWithImpl<$Res>
    implements _$SIWEVerifyMessageArgsCopyWith<$Res> {
  __$SIWEVerifyMessageArgsCopyWithImpl(this._self, this._then);

  final _SIWEVerifyMessageArgs _self;
  final $Res Function(_SIWEVerifyMessageArgs) _then;

/// Create a copy of SIWEVerifyMessageArgs
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? signature = null,Object? cacao = freezed,Object? clientId = freezed,}) {
  return _then(_SIWEVerifyMessageArgs(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,signature: null == signature ? _self.signature : signature // ignore: cast_nullable_to_non_nullable
as String,cacao: freezed == cacao ? _self.cacao : cacao // ignore: cast_nullable_to_non_nullable
as Cacao?,clientId: freezed == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of SIWEVerifyMessageArgs
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CacaoCopyWith<$Res>? get cacao {
    if (_self.cacao == null) {
    return null;
  }

  return $CacaoCopyWith<$Res>(_self.cacao!, (value) {
    return _then(_self.copyWith(cacao: value));
  });
}
}


/// @nodoc
mixin _$SIWESession {

 String get address; List<String> get chains;
/// Create a copy of SIWESession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SIWESessionCopyWith<SIWESession> get copyWith => _$SIWESessionCopyWithImpl<SIWESession>(this as SIWESession, _$identity);

  /// Serializes this SIWESession to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SIWESession&&(identical(other.address, address) || other.address == address)&&const DeepCollectionEquality().equals(other.chains, chains));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,address,const DeepCollectionEquality().hash(chains));



}

/// @nodoc
abstract mixin class $SIWESessionCopyWith<$Res>  {
  factory $SIWESessionCopyWith(SIWESession value, $Res Function(SIWESession) _then) = _$SIWESessionCopyWithImpl;
@useResult
$Res call({
 String address, List<String> chains
});




}
/// @nodoc
class _$SIWESessionCopyWithImpl<$Res>
    implements $SIWESessionCopyWith<$Res> {
  _$SIWESessionCopyWithImpl(this._self, this._then);

  final SIWESession _self;
  final $Res Function(SIWESession) _then;

/// Create a copy of SIWESession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? address = null,Object? chains = null,}) {
  return _then(_self.copyWith(
address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,chains: null == chains ? _self.chains : chains // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [SIWESession].
extension SIWESessionPatterns on SIWESession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SIWESession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SIWESession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SIWESession value)  $default,){
final _that = this;
switch (_that) {
case _SIWESession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SIWESession value)?  $default,){
final _that = this;
switch (_that) {
case _SIWESession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String address,  List<String> chains)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SIWESession() when $default != null:
return $default(_that.address,_that.chains);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String address,  List<String> chains)  $default,) {final _that = this;
switch (_that) {
case _SIWESession():
return $default(_that.address,_that.chains);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String address,  List<String> chains)?  $default,) {final _that = this;
switch (_that) {
case _SIWESession() when $default != null:
return $default(_that.address,_that.chains);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SIWESession implements SIWESession {
  const _SIWESession({required this.address, required final  List<String> chains}): _chains = chains;
  factory _SIWESession.fromJson(Map<String, dynamic> json) => _$SIWESessionFromJson(json);

@override final  String address;
 final  List<String> _chains;
@override List<String> get chains {
  if (_chains is EqualUnmodifiableListView) return _chains;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_chains);
}


/// Create a copy of SIWESession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SIWESessionCopyWith<_SIWESession> get copyWith => __$SIWESessionCopyWithImpl<_SIWESession>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SIWESessionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SIWESession&&(identical(other.address, address) || other.address == address)&&const DeepCollectionEquality().equals(other._chains, _chains));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,address,const DeepCollectionEquality().hash(_chains));



}

/// @nodoc
abstract mixin class _$SIWESessionCopyWith<$Res> implements $SIWESessionCopyWith<$Res> {
  factory _$SIWESessionCopyWith(_SIWESession value, $Res Function(_SIWESession) _then) = __$SIWESessionCopyWithImpl;
@override @useResult
$Res call({
 String address, List<String> chains
});




}
/// @nodoc
class __$SIWESessionCopyWithImpl<$Res>
    implements _$SIWESessionCopyWith<$Res> {
  __$SIWESessionCopyWithImpl(this._self, this._then);

  final _SIWESession _self;
  final $Res Function(_SIWESession) _then;

/// Create a copy of SIWESession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? address = null,Object? chains = null,}) {
  return _then(_SIWESession(
address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,chains: null == chains ? _self._chains : chains // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
