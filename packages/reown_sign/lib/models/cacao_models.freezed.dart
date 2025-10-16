// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cacao_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CacaoRequestPayload {

 String get domain; String get aud; String get version; String get nonce; String get iat; String? get nbf; String? get exp; String? get statement; String? get requestId; List<String>? get resources;
/// Create a copy of CacaoRequestPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CacaoRequestPayloadCopyWith<CacaoRequestPayload> get copyWith => _$CacaoRequestPayloadCopyWithImpl<CacaoRequestPayload>(this as CacaoRequestPayload, _$identity);

  /// Serializes this CacaoRequestPayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CacaoRequestPayload&&(identical(other.domain, domain) || other.domain == domain)&&(identical(other.aud, aud) || other.aud == aud)&&(identical(other.version, version) || other.version == version)&&(identical(other.nonce, nonce) || other.nonce == nonce)&&(identical(other.iat, iat) || other.iat == iat)&&(identical(other.nbf, nbf) || other.nbf == nbf)&&(identical(other.exp, exp) || other.exp == exp)&&(identical(other.statement, statement) || other.statement == statement)&&(identical(other.requestId, requestId) || other.requestId == requestId)&&const DeepCollectionEquality().equals(other.resources, resources));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,domain,aud,version,nonce,iat,nbf,exp,statement,requestId,const DeepCollectionEquality().hash(resources));

@override
String toString() {
  return 'CacaoRequestPayload(domain: $domain, aud: $aud, version: $version, nonce: $nonce, iat: $iat, nbf: $nbf, exp: $exp, statement: $statement, requestId: $requestId, resources: $resources)';
}


}

/// @nodoc
abstract mixin class $CacaoRequestPayloadCopyWith<$Res>  {
  factory $CacaoRequestPayloadCopyWith(CacaoRequestPayload value, $Res Function(CacaoRequestPayload) _then) = _$CacaoRequestPayloadCopyWithImpl;
@useResult
$Res call({
 String domain, String aud, String version, String nonce, String iat, String? nbf, String? exp, String? statement, String? requestId, List<String>? resources
});




}
/// @nodoc
class _$CacaoRequestPayloadCopyWithImpl<$Res>
    implements $CacaoRequestPayloadCopyWith<$Res> {
  _$CacaoRequestPayloadCopyWithImpl(this._self, this._then);

  final CacaoRequestPayload _self;
  final $Res Function(CacaoRequestPayload) _then;

/// Create a copy of CacaoRequestPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? domain = null,Object? aud = null,Object? version = null,Object? nonce = null,Object? iat = null,Object? nbf = freezed,Object? exp = freezed,Object? statement = freezed,Object? requestId = freezed,Object? resources = freezed,}) {
  return _then(_self.copyWith(
domain: null == domain ? _self.domain : domain // ignore: cast_nullable_to_non_nullable
as String,aud: null == aud ? _self.aud : aud // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,nonce: null == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
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


/// Adds pattern-matching-related methods to [CacaoRequestPayload].
extension CacaoRequestPayloadPatterns on CacaoRequestPayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CacaoRequestPayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CacaoRequestPayload() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CacaoRequestPayload value)  $default,){
final _that = this;
switch (_that) {
case _CacaoRequestPayload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CacaoRequestPayload value)?  $default,){
final _that = this;
switch (_that) {
case _CacaoRequestPayload() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String domain,  String aud,  String version,  String nonce,  String iat,  String? nbf,  String? exp,  String? statement,  String? requestId,  List<String>? resources)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CacaoRequestPayload() when $default != null:
return $default(_that.domain,_that.aud,_that.version,_that.nonce,_that.iat,_that.nbf,_that.exp,_that.statement,_that.requestId,_that.resources);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String domain,  String aud,  String version,  String nonce,  String iat,  String? nbf,  String? exp,  String? statement,  String? requestId,  List<String>? resources)  $default,) {final _that = this;
switch (_that) {
case _CacaoRequestPayload():
return $default(_that.domain,_that.aud,_that.version,_that.nonce,_that.iat,_that.nbf,_that.exp,_that.statement,_that.requestId,_that.resources);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String domain,  String aud,  String version,  String nonce,  String iat,  String? nbf,  String? exp,  String? statement,  String? requestId,  List<String>? resources)?  $default,) {final _that = this;
switch (_that) {
case _CacaoRequestPayload() when $default != null:
return $default(_that.domain,_that.aud,_that.version,_that.nonce,_that.iat,_that.nbf,_that.exp,_that.statement,_that.requestId,_that.resources);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _CacaoRequestPayload implements CacaoRequestPayload {
  const _CacaoRequestPayload({required this.domain, required this.aud, required this.version, required this.nonce, required this.iat, this.nbf, this.exp, this.statement, this.requestId, final  List<String>? resources}): _resources = resources;
  factory _CacaoRequestPayload.fromJson(Map<String, dynamic> json) => _$CacaoRequestPayloadFromJson(json);

@override final  String domain;
@override final  String aud;
@override final  String version;
@override final  String nonce;
@override final  String iat;
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


/// Create a copy of CacaoRequestPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CacaoRequestPayloadCopyWith<_CacaoRequestPayload> get copyWith => __$CacaoRequestPayloadCopyWithImpl<_CacaoRequestPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CacaoRequestPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CacaoRequestPayload&&(identical(other.domain, domain) || other.domain == domain)&&(identical(other.aud, aud) || other.aud == aud)&&(identical(other.version, version) || other.version == version)&&(identical(other.nonce, nonce) || other.nonce == nonce)&&(identical(other.iat, iat) || other.iat == iat)&&(identical(other.nbf, nbf) || other.nbf == nbf)&&(identical(other.exp, exp) || other.exp == exp)&&(identical(other.statement, statement) || other.statement == statement)&&(identical(other.requestId, requestId) || other.requestId == requestId)&&const DeepCollectionEquality().equals(other._resources, _resources));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,domain,aud,version,nonce,iat,nbf,exp,statement,requestId,const DeepCollectionEquality().hash(_resources));

@override
String toString() {
  return 'CacaoRequestPayload(domain: $domain, aud: $aud, version: $version, nonce: $nonce, iat: $iat, nbf: $nbf, exp: $exp, statement: $statement, requestId: $requestId, resources: $resources)';
}


}

/// @nodoc
abstract mixin class _$CacaoRequestPayloadCopyWith<$Res> implements $CacaoRequestPayloadCopyWith<$Res> {
  factory _$CacaoRequestPayloadCopyWith(_CacaoRequestPayload value, $Res Function(_CacaoRequestPayload) _then) = __$CacaoRequestPayloadCopyWithImpl;
@override @useResult
$Res call({
 String domain, String aud, String version, String nonce, String iat, String? nbf, String? exp, String? statement, String? requestId, List<String>? resources
});




}
/// @nodoc
class __$CacaoRequestPayloadCopyWithImpl<$Res>
    implements _$CacaoRequestPayloadCopyWith<$Res> {
  __$CacaoRequestPayloadCopyWithImpl(this._self, this._then);

  final _CacaoRequestPayload _self;
  final $Res Function(_CacaoRequestPayload) _then;

/// Create a copy of CacaoRequestPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? domain = null,Object? aud = null,Object? version = null,Object? nonce = null,Object? iat = null,Object? nbf = freezed,Object? exp = freezed,Object? statement = freezed,Object? requestId = freezed,Object? resources = freezed,}) {
  return _then(_CacaoRequestPayload(
domain: null == domain ? _self.domain : domain // ignore: cast_nullable_to_non_nullable
as String,aud: null == aud ? _self.aud : aud // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,nonce: null == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
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
mixin _$CacaoPayload {

 String get iss; String get domain; String get aud; String get version; String get nonce; String get iat; String? get nbf; String? get exp; String? get statement; String? get requestId; List<String>? get resources;
/// Create a copy of CacaoPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CacaoPayloadCopyWith<CacaoPayload> get copyWith => _$CacaoPayloadCopyWithImpl<CacaoPayload>(this as CacaoPayload, _$identity);

  /// Serializes this CacaoPayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CacaoPayload&&(identical(other.iss, iss) || other.iss == iss)&&(identical(other.domain, domain) || other.domain == domain)&&(identical(other.aud, aud) || other.aud == aud)&&(identical(other.version, version) || other.version == version)&&(identical(other.nonce, nonce) || other.nonce == nonce)&&(identical(other.iat, iat) || other.iat == iat)&&(identical(other.nbf, nbf) || other.nbf == nbf)&&(identical(other.exp, exp) || other.exp == exp)&&(identical(other.statement, statement) || other.statement == statement)&&(identical(other.requestId, requestId) || other.requestId == requestId)&&const DeepCollectionEquality().equals(other.resources, resources));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,iss,domain,aud,version,nonce,iat,nbf,exp,statement,requestId,const DeepCollectionEquality().hash(resources));

@override
String toString() {
  return 'CacaoPayload(iss: $iss, domain: $domain, aud: $aud, version: $version, nonce: $nonce, iat: $iat, nbf: $nbf, exp: $exp, statement: $statement, requestId: $requestId, resources: $resources)';
}


}

/// @nodoc
abstract mixin class $CacaoPayloadCopyWith<$Res>  {
  factory $CacaoPayloadCopyWith(CacaoPayload value, $Res Function(CacaoPayload) _then) = _$CacaoPayloadCopyWithImpl;
@useResult
$Res call({
 String iss, String domain, String aud, String version, String nonce, String iat, String? nbf, String? exp, String? statement, String? requestId, List<String>? resources
});




}
/// @nodoc
class _$CacaoPayloadCopyWithImpl<$Res>
    implements $CacaoPayloadCopyWith<$Res> {
  _$CacaoPayloadCopyWithImpl(this._self, this._then);

  final CacaoPayload _self;
  final $Res Function(CacaoPayload) _then;

/// Create a copy of CacaoPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? iss = null,Object? domain = null,Object? aud = null,Object? version = null,Object? nonce = null,Object? iat = null,Object? nbf = freezed,Object? exp = freezed,Object? statement = freezed,Object? requestId = freezed,Object? resources = freezed,}) {
  return _then(_self.copyWith(
iss: null == iss ? _self.iss : iss // ignore: cast_nullable_to_non_nullable
as String,domain: null == domain ? _self.domain : domain // ignore: cast_nullable_to_non_nullable
as String,aud: null == aud ? _self.aud : aud // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,nonce: null == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
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


/// Adds pattern-matching-related methods to [CacaoPayload].
extension CacaoPayloadPatterns on CacaoPayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CacaoPayload value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CacaoPayload() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CacaoPayload value)  $default,){
final _that = this;
switch (_that) {
case _CacaoPayload():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CacaoPayload value)?  $default,){
final _that = this;
switch (_that) {
case _CacaoPayload() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String iss,  String domain,  String aud,  String version,  String nonce,  String iat,  String? nbf,  String? exp,  String? statement,  String? requestId,  List<String>? resources)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CacaoPayload() when $default != null:
return $default(_that.iss,_that.domain,_that.aud,_that.version,_that.nonce,_that.iat,_that.nbf,_that.exp,_that.statement,_that.requestId,_that.resources);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String iss,  String domain,  String aud,  String version,  String nonce,  String iat,  String? nbf,  String? exp,  String? statement,  String? requestId,  List<String>? resources)  $default,) {final _that = this;
switch (_that) {
case _CacaoPayload():
return $default(_that.iss,_that.domain,_that.aud,_that.version,_that.nonce,_that.iat,_that.nbf,_that.exp,_that.statement,_that.requestId,_that.resources);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String iss,  String domain,  String aud,  String version,  String nonce,  String iat,  String? nbf,  String? exp,  String? statement,  String? requestId,  List<String>? resources)?  $default,) {final _that = this;
switch (_that) {
case _CacaoPayload() when $default != null:
return $default(_that.iss,_that.domain,_that.aud,_that.version,_that.nonce,_that.iat,_that.nbf,_that.exp,_that.statement,_that.requestId,_that.resources);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _CacaoPayload implements CacaoPayload {
  const _CacaoPayload({required this.iss, required this.domain, required this.aud, required this.version, required this.nonce, required this.iat, this.nbf, this.exp, this.statement, this.requestId, final  List<String>? resources}): _resources = resources;
  factory _CacaoPayload.fromJson(Map<String, dynamic> json) => _$CacaoPayloadFromJson(json);

@override final  String iss;
@override final  String domain;
@override final  String aud;
@override final  String version;
@override final  String nonce;
@override final  String iat;
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


/// Create a copy of CacaoPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CacaoPayloadCopyWith<_CacaoPayload> get copyWith => __$CacaoPayloadCopyWithImpl<_CacaoPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CacaoPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CacaoPayload&&(identical(other.iss, iss) || other.iss == iss)&&(identical(other.domain, domain) || other.domain == domain)&&(identical(other.aud, aud) || other.aud == aud)&&(identical(other.version, version) || other.version == version)&&(identical(other.nonce, nonce) || other.nonce == nonce)&&(identical(other.iat, iat) || other.iat == iat)&&(identical(other.nbf, nbf) || other.nbf == nbf)&&(identical(other.exp, exp) || other.exp == exp)&&(identical(other.statement, statement) || other.statement == statement)&&(identical(other.requestId, requestId) || other.requestId == requestId)&&const DeepCollectionEquality().equals(other._resources, _resources));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,iss,domain,aud,version,nonce,iat,nbf,exp,statement,requestId,const DeepCollectionEquality().hash(_resources));

@override
String toString() {
  return 'CacaoPayload(iss: $iss, domain: $domain, aud: $aud, version: $version, nonce: $nonce, iat: $iat, nbf: $nbf, exp: $exp, statement: $statement, requestId: $requestId, resources: $resources)';
}


}

/// @nodoc
abstract mixin class _$CacaoPayloadCopyWith<$Res> implements $CacaoPayloadCopyWith<$Res> {
  factory _$CacaoPayloadCopyWith(_CacaoPayload value, $Res Function(_CacaoPayload) _then) = __$CacaoPayloadCopyWithImpl;
@override @useResult
$Res call({
 String iss, String domain, String aud, String version, String nonce, String iat, String? nbf, String? exp, String? statement, String? requestId, List<String>? resources
});




}
/// @nodoc
class __$CacaoPayloadCopyWithImpl<$Res>
    implements _$CacaoPayloadCopyWith<$Res> {
  __$CacaoPayloadCopyWithImpl(this._self, this._then);

  final _CacaoPayload _self;
  final $Res Function(_CacaoPayload) _then;

/// Create a copy of CacaoPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? iss = null,Object? domain = null,Object? aud = null,Object? version = null,Object? nonce = null,Object? iat = null,Object? nbf = freezed,Object? exp = freezed,Object? statement = freezed,Object? requestId = freezed,Object? resources = freezed,}) {
  return _then(_CacaoPayload(
iss: null == iss ? _self.iss : iss // ignore: cast_nullable_to_non_nullable
as String,domain: null == domain ? _self.domain : domain // ignore: cast_nullable_to_non_nullable
as String,aud: null == aud ? _self.aud : aud // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,nonce: null == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
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
mixin _$CacaoHeader {

 String get t;
/// Create a copy of CacaoHeader
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CacaoHeaderCopyWith<CacaoHeader> get copyWith => _$CacaoHeaderCopyWithImpl<CacaoHeader>(this as CacaoHeader, _$identity);

  /// Serializes this CacaoHeader to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CacaoHeader&&(identical(other.t, t) || other.t == t));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,t);

@override
String toString() {
  return 'CacaoHeader(t: $t)';
}


}

/// @nodoc
abstract mixin class $CacaoHeaderCopyWith<$Res>  {
  factory $CacaoHeaderCopyWith(CacaoHeader value, $Res Function(CacaoHeader) _then) = _$CacaoHeaderCopyWithImpl;
@useResult
$Res call({
 String t
});




}
/// @nodoc
class _$CacaoHeaderCopyWithImpl<$Res>
    implements $CacaoHeaderCopyWith<$Res> {
  _$CacaoHeaderCopyWithImpl(this._self, this._then);

  final CacaoHeader _self;
  final $Res Function(CacaoHeader) _then;

/// Create a copy of CacaoHeader
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? t = null,}) {
  return _then(_self.copyWith(
t: null == t ? _self.t : t // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CacaoHeader].
extension CacaoHeaderPatterns on CacaoHeader {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CacaoHeader value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CacaoHeader() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CacaoHeader value)  $default,){
final _that = this;
switch (_that) {
case _CacaoHeader():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CacaoHeader value)?  $default,){
final _that = this;
switch (_that) {
case _CacaoHeader() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String t)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CacaoHeader() when $default != null:
return $default(_that.t);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String t)  $default,) {final _that = this;
switch (_that) {
case _CacaoHeader():
return $default(_that.t);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String t)?  $default,) {final _that = this;
switch (_that) {
case _CacaoHeader() when $default != null:
return $default(_that.t);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _CacaoHeader implements CacaoHeader {
  const _CacaoHeader({this.t = 'eip4361'});
  factory _CacaoHeader.fromJson(Map<String, dynamic> json) => _$CacaoHeaderFromJson(json);

@override@JsonKey() final  String t;

/// Create a copy of CacaoHeader
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CacaoHeaderCopyWith<_CacaoHeader> get copyWith => __$CacaoHeaderCopyWithImpl<_CacaoHeader>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CacaoHeaderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CacaoHeader&&(identical(other.t, t) || other.t == t));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,t);

@override
String toString() {
  return 'CacaoHeader(t: $t)';
}


}

/// @nodoc
abstract mixin class _$CacaoHeaderCopyWith<$Res> implements $CacaoHeaderCopyWith<$Res> {
  factory _$CacaoHeaderCopyWith(_CacaoHeader value, $Res Function(_CacaoHeader) _then) = __$CacaoHeaderCopyWithImpl;
@override @useResult
$Res call({
 String t
});




}
/// @nodoc
class __$CacaoHeaderCopyWithImpl<$Res>
    implements _$CacaoHeaderCopyWith<$Res> {
  __$CacaoHeaderCopyWithImpl(this._self, this._then);

  final _CacaoHeader _self;
  final $Res Function(_CacaoHeader) _then;

/// Create a copy of CacaoHeader
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? t = null,}) {
  return _then(_CacaoHeader(
t: null == t ? _self.t : t // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$CacaoSignature {

 String get t; String get s; String? get m;
/// Create a copy of CacaoSignature
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CacaoSignatureCopyWith<CacaoSignature> get copyWith => _$CacaoSignatureCopyWithImpl<CacaoSignature>(this as CacaoSignature, _$identity);

  /// Serializes this CacaoSignature to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CacaoSignature&&(identical(other.t, t) || other.t == t)&&(identical(other.s, s) || other.s == s)&&(identical(other.m, m) || other.m == m));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,t,s,m);

@override
String toString() {
  return 'CacaoSignature(t: $t, s: $s, m: $m)';
}


}

/// @nodoc
abstract mixin class $CacaoSignatureCopyWith<$Res>  {
  factory $CacaoSignatureCopyWith(CacaoSignature value, $Res Function(CacaoSignature) _then) = _$CacaoSignatureCopyWithImpl;
@useResult
$Res call({
 String t, String s, String? m
});




}
/// @nodoc
class _$CacaoSignatureCopyWithImpl<$Res>
    implements $CacaoSignatureCopyWith<$Res> {
  _$CacaoSignatureCopyWithImpl(this._self, this._then);

  final CacaoSignature _self;
  final $Res Function(CacaoSignature) _then;

/// Create a copy of CacaoSignature
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? t = null,Object? s = null,Object? m = freezed,}) {
  return _then(_self.copyWith(
t: null == t ? _self.t : t // ignore: cast_nullable_to_non_nullable
as String,s: null == s ? _self.s : s // ignore: cast_nullable_to_non_nullable
as String,m: freezed == m ? _self.m : m // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CacaoSignature].
extension CacaoSignaturePatterns on CacaoSignature {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CacaoSignature value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CacaoSignature() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CacaoSignature value)  $default,){
final _that = this;
switch (_that) {
case _CacaoSignature():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CacaoSignature value)?  $default,){
final _that = this;
switch (_that) {
case _CacaoSignature() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String t,  String s,  String? m)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CacaoSignature() when $default != null:
return $default(_that.t,_that.s,_that.m);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String t,  String s,  String? m)  $default,) {final _that = this;
switch (_that) {
case _CacaoSignature():
return $default(_that.t,_that.s,_that.m);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String t,  String s,  String? m)?  $default,) {final _that = this;
switch (_that) {
case _CacaoSignature() when $default != null:
return $default(_that.t,_that.s,_that.m);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _CacaoSignature implements CacaoSignature {
  const _CacaoSignature({required this.t, required this.s, this.m});
  factory _CacaoSignature.fromJson(Map<String, dynamic> json) => _$CacaoSignatureFromJson(json);

@override final  String t;
@override final  String s;
@override final  String? m;

/// Create a copy of CacaoSignature
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CacaoSignatureCopyWith<_CacaoSignature> get copyWith => __$CacaoSignatureCopyWithImpl<_CacaoSignature>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CacaoSignatureToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CacaoSignature&&(identical(other.t, t) || other.t == t)&&(identical(other.s, s) || other.s == s)&&(identical(other.m, m) || other.m == m));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,t,s,m);

@override
String toString() {
  return 'CacaoSignature(t: $t, s: $s, m: $m)';
}


}

/// @nodoc
abstract mixin class _$CacaoSignatureCopyWith<$Res> implements $CacaoSignatureCopyWith<$Res> {
  factory _$CacaoSignatureCopyWith(_CacaoSignature value, $Res Function(_CacaoSignature) _then) = __$CacaoSignatureCopyWithImpl;
@override @useResult
$Res call({
 String t, String s, String? m
});




}
/// @nodoc
class __$CacaoSignatureCopyWithImpl<$Res>
    implements _$CacaoSignatureCopyWith<$Res> {
  __$CacaoSignatureCopyWithImpl(this._self, this._then);

  final _CacaoSignature _self;
  final $Res Function(_CacaoSignature) _then;

/// Create a copy of CacaoSignature
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? t = null,Object? s = null,Object? m = freezed,}) {
  return _then(_CacaoSignature(
t: null == t ? _self.t : t // ignore: cast_nullable_to_non_nullable
as String,s: null == s ? _self.s : s // ignore: cast_nullable_to_non_nullable
as String,m: freezed == m ? _self.m : m // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$Cacao {

 CacaoHeader get h; CacaoPayload get p; CacaoSignature get s;
/// Create a copy of Cacao
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CacaoCopyWith<Cacao> get copyWith => _$CacaoCopyWithImpl<Cacao>(this as Cacao, _$identity);

  /// Serializes this Cacao to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Cacao&&(identical(other.h, h) || other.h == h)&&(identical(other.p, p) || other.p == p)&&(identical(other.s, s) || other.s == s));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,h,p,s);

@override
String toString() {
  return 'Cacao(h: $h, p: $p, s: $s)';
}


}

/// @nodoc
abstract mixin class $CacaoCopyWith<$Res>  {
  factory $CacaoCopyWith(Cacao value, $Res Function(Cacao) _then) = _$CacaoCopyWithImpl;
@useResult
$Res call({
 CacaoHeader h, CacaoPayload p, CacaoSignature s
});


$CacaoHeaderCopyWith<$Res> get h;$CacaoPayloadCopyWith<$Res> get p;$CacaoSignatureCopyWith<$Res> get s;

}
/// @nodoc
class _$CacaoCopyWithImpl<$Res>
    implements $CacaoCopyWith<$Res> {
  _$CacaoCopyWithImpl(this._self, this._then);

  final Cacao _self;
  final $Res Function(Cacao) _then;

/// Create a copy of Cacao
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? h = null,Object? p = null,Object? s = null,}) {
  return _then(_self.copyWith(
h: null == h ? _self.h : h // ignore: cast_nullable_to_non_nullable
as CacaoHeader,p: null == p ? _self.p : p // ignore: cast_nullable_to_non_nullable
as CacaoPayload,s: null == s ? _self.s : s // ignore: cast_nullable_to_non_nullable
as CacaoSignature,
  ));
}
/// Create a copy of Cacao
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CacaoHeaderCopyWith<$Res> get h {
  
  return $CacaoHeaderCopyWith<$Res>(_self.h, (value) {
    return _then(_self.copyWith(h: value));
  });
}/// Create a copy of Cacao
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CacaoPayloadCopyWith<$Res> get p {
  
  return $CacaoPayloadCopyWith<$Res>(_self.p, (value) {
    return _then(_self.copyWith(p: value));
  });
}/// Create a copy of Cacao
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CacaoSignatureCopyWith<$Res> get s {
  
  return $CacaoSignatureCopyWith<$Res>(_self.s, (value) {
    return _then(_self.copyWith(s: value));
  });
}
}


/// Adds pattern-matching-related methods to [Cacao].
extension CacaoPatterns on Cacao {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Cacao value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Cacao() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Cacao value)  $default,){
final _that = this;
switch (_that) {
case _Cacao():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Cacao value)?  $default,){
final _that = this;
switch (_that) {
case _Cacao() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CacaoHeader h,  CacaoPayload p,  CacaoSignature s)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Cacao() when $default != null:
return $default(_that.h,_that.p,_that.s);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CacaoHeader h,  CacaoPayload p,  CacaoSignature s)  $default,) {final _that = this;
switch (_that) {
case _Cacao():
return $default(_that.h,_that.p,_that.s);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CacaoHeader h,  CacaoPayload p,  CacaoSignature s)?  $default,) {final _that = this;
switch (_that) {
case _Cacao() when $default != null:
return $default(_that.h,_that.p,_that.s);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _Cacao implements Cacao {
  const _Cacao({required this.h, required this.p, required this.s});
  factory _Cacao.fromJson(Map<String, dynamic> json) => _$CacaoFromJson(json);

@override final  CacaoHeader h;
@override final  CacaoPayload p;
@override final  CacaoSignature s;

/// Create a copy of Cacao
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CacaoCopyWith<_Cacao> get copyWith => __$CacaoCopyWithImpl<_Cacao>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CacaoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Cacao&&(identical(other.h, h) || other.h == h)&&(identical(other.p, p) || other.p == p)&&(identical(other.s, s) || other.s == s));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,h,p,s);

@override
String toString() {
  return 'Cacao(h: $h, p: $p, s: $s)';
}


}

/// @nodoc
abstract mixin class _$CacaoCopyWith<$Res> implements $CacaoCopyWith<$Res> {
  factory _$CacaoCopyWith(_Cacao value, $Res Function(_Cacao) _then) = __$CacaoCopyWithImpl;
@override @useResult
$Res call({
 CacaoHeader h, CacaoPayload p, CacaoSignature s
});


@override $CacaoHeaderCopyWith<$Res> get h;@override $CacaoPayloadCopyWith<$Res> get p;@override $CacaoSignatureCopyWith<$Res> get s;

}
/// @nodoc
class __$CacaoCopyWithImpl<$Res>
    implements _$CacaoCopyWith<$Res> {
  __$CacaoCopyWithImpl(this._self, this._then);

  final _Cacao _self;
  final $Res Function(_Cacao) _then;

/// Create a copy of Cacao
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? h = null,Object? p = null,Object? s = null,}) {
  return _then(_Cacao(
h: null == h ? _self.h : h // ignore: cast_nullable_to_non_nullable
as CacaoHeader,p: null == p ? _self.p : p // ignore: cast_nullable_to_non_nullable
as CacaoPayload,s: null == s ? _self.s : s // ignore: cast_nullable_to_non_nullable
as CacaoSignature,
  ));
}

/// Create a copy of Cacao
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CacaoHeaderCopyWith<$Res> get h {
  
  return $CacaoHeaderCopyWith<$Res>(_self.h, (value) {
    return _then(_self.copyWith(h: value));
  });
}/// Create a copy of Cacao
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CacaoPayloadCopyWith<$Res> get p {
  
  return $CacaoPayloadCopyWith<$Res>(_self.p, (value) {
    return _then(_self.copyWith(p: value));
  });
}/// Create a copy of Cacao
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CacaoSignatureCopyWith<$Res> get s {
  
  return $CacaoSignatureCopyWith<$Res>(_self.s, (value) {
    return _then(_self.copyWith(s: value));
  });
}
}


/// @nodoc
mixin _$StoredCacao {

 int get id; String get pairingTopic; CacaoHeader get h; CacaoPayload get p; CacaoSignature get s;
/// Create a copy of StoredCacao
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoredCacaoCopyWith<StoredCacao> get copyWith => _$StoredCacaoCopyWithImpl<StoredCacao>(this as StoredCacao, _$identity);

  /// Serializes this StoredCacao to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StoredCacao&&(identical(other.id, id) || other.id == id)&&(identical(other.pairingTopic, pairingTopic) || other.pairingTopic == pairingTopic)&&(identical(other.h, h) || other.h == h)&&(identical(other.p, p) || other.p == p)&&(identical(other.s, s) || other.s == s));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,pairingTopic,h,p,s);

@override
String toString() {
  return 'StoredCacao(id: $id, pairingTopic: $pairingTopic, h: $h, p: $p, s: $s)';
}


}

/// @nodoc
abstract mixin class $StoredCacaoCopyWith<$Res>  {
  factory $StoredCacaoCopyWith(StoredCacao value, $Res Function(StoredCacao) _then) = _$StoredCacaoCopyWithImpl;
@useResult
$Res call({
 int id, String pairingTopic, CacaoHeader h, CacaoPayload p, CacaoSignature s
});


$CacaoHeaderCopyWith<$Res> get h;$CacaoPayloadCopyWith<$Res> get p;$CacaoSignatureCopyWith<$Res> get s;

}
/// @nodoc
class _$StoredCacaoCopyWithImpl<$Res>
    implements $StoredCacaoCopyWith<$Res> {
  _$StoredCacaoCopyWithImpl(this._self, this._then);

  final StoredCacao _self;
  final $Res Function(StoredCacao) _then;

/// Create a copy of StoredCacao
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? pairingTopic = null,Object? h = null,Object? p = null,Object? s = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,pairingTopic: null == pairingTopic ? _self.pairingTopic : pairingTopic // ignore: cast_nullable_to_non_nullable
as String,h: null == h ? _self.h : h // ignore: cast_nullable_to_non_nullable
as CacaoHeader,p: null == p ? _self.p : p // ignore: cast_nullable_to_non_nullable
as CacaoPayload,s: null == s ? _self.s : s // ignore: cast_nullable_to_non_nullable
as CacaoSignature,
  ));
}
/// Create a copy of StoredCacao
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CacaoHeaderCopyWith<$Res> get h {
  
  return $CacaoHeaderCopyWith<$Res>(_self.h, (value) {
    return _then(_self.copyWith(h: value));
  });
}/// Create a copy of StoredCacao
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CacaoPayloadCopyWith<$Res> get p {
  
  return $CacaoPayloadCopyWith<$Res>(_self.p, (value) {
    return _then(_self.copyWith(p: value));
  });
}/// Create a copy of StoredCacao
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CacaoSignatureCopyWith<$Res> get s {
  
  return $CacaoSignatureCopyWith<$Res>(_self.s, (value) {
    return _then(_self.copyWith(s: value));
  });
}
}


/// Adds pattern-matching-related methods to [StoredCacao].
extension StoredCacaoPatterns on StoredCacao {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StoredCacao value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StoredCacao() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StoredCacao value)  $default,){
final _that = this;
switch (_that) {
case _StoredCacao():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StoredCacao value)?  $default,){
final _that = this;
switch (_that) {
case _StoredCacao() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String pairingTopic,  CacaoHeader h,  CacaoPayload p,  CacaoSignature s)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StoredCacao() when $default != null:
return $default(_that.id,_that.pairingTopic,_that.h,_that.p,_that.s);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String pairingTopic,  CacaoHeader h,  CacaoPayload p,  CacaoSignature s)  $default,) {final _that = this;
switch (_that) {
case _StoredCacao():
return $default(_that.id,_that.pairingTopic,_that.h,_that.p,_that.s);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String pairingTopic,  CacaoHeader h,  CacaoPayload p,  CacaoSignature s)?  $default,) {final _that = this;
switch (_that) {
case _StoredCacao() when $default != null:
return $default(_that.id,_that.pairingTopic,_that.h,_that.p,_that.s);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _StoredCacao implements StoredCacao {
  const _StoredCacao({required this.id, required this.pairingTopic, required this.h, required this.p, required this.s});
  factory _StoredCacao.fromJson(Map<String, dynamic> json) => _$StoredCacaoFromJson(json);

@override final  int id;
@override final  String pairingTopic;
@override final  CacaoHeader h;
@override final  CacaoPayload p;
@override final  CacaoSignature s;

/// Create a copy of StoredCacao
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StoredCacaoCopyWith<_StoredCacao> get copyWith => __$StoredCacaoCopyWithImpl<_StoredCacao>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StoredCacaoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StoredCacao&&(identical(other.id, id) || other.id == id)&&(identical(other.pairingTopic, pairingTopic) || other.pairingTopic == pairingTopic)&&(identical(other.h, h) || other.h == h)&&(identical(other.p, p) || other.p == p)&&(identical(other.s, s) || other.s == s));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,pairingTopic,h,p,s);

@override
String toString() {
  return 'StoredCacao(id: $id, pairingTopic: $pairingTopic, h: $h, p: $p, s: $s)';
}


}

/// @nodoc
abstract mixin class _$StoredCacaoCopyWith<$Res> implements $StoredCacaoCopyWith<$Res> {
  factory _$StoredCacaoCopyWith(_StoredCacao value, $Res Function(_StoredCacao) _then) = __$StoredCacaoCopyWithImpl;
@override @useResult
$Res call({
 int id, String pairingTopic, CacaoHeader h, CacaoPayload p, CacaoSignature s
});


@override $CacaoHeaderCopyWith<$Res> get h;@override $CacaoPayloadCopyWith<$Res> get p;@override $CacaoSignatureCopyWith<$Res> get s;

}
/// @nodoc
class __$StoredCacaoCopyWithImpl<$Res>
    implements _$StoredCacaoCopyWith<$Res> {
  __$StoredCacaoCopyWithImpl(this._self, this._then);

  final _StoredCacao _self;
  final $Res Function(_StoredCacao) _then;

/// Create a copy of StoredCacao
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? pairingTopic = null,Object? h = null,Object? p = null,Object? s = null,}) {
  return _then(_StoredCacao(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,pairingTopic: null == pairingTopic ? _self.pairingTopic : pairingTopic // ignore: cast_nullable_to_non_nullable
as String,h: null == h ? _self.h : h // ignore: cast_nullable_to_non_nullable
as CacaoHeader,p: null == p ? _self.p : p // ignore: cast_nullable_to_non_nullable
as CacaoPayload,s: null == s ? _self.s : s // ignore: cast_nullable_to_non_nullable
as CacaoSignature,
  ));
}

/// Create a copy of StoredCacao
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CacaoHeaderCopyWith<$Res> get h {
  
  return $CacaoHeaderCopyWith<$Res>(_self.h, (value) {
    return _then(_self.copyWith(h: value));
  });
}/// Create a copy of StoredCacao
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CacaoPayloadCopyWith<$Res> get p {
  
  return $CacaoPayloadCopyWith<$Res>(_self.p, (value) {
    return _then(_self.copyWith(p: value));
  });
}/// Create a copy of StoredCacao
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CacaoSignatureCopyWith<$Res> get s {
  
  return $CacaoSignatureCopyWith<$Res>(_self.s, (value) {
    return _then(_self.copyWith(s: value));
  });
}
}

// dart format on
