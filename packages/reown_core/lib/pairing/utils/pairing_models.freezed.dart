// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pairing_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PairingInfo {

 String get topic; int get expiry; Relay get relay; bool get active; List<String>? get methods; PairingMetadata? get peerMetadata;
/// Create a copy of PairingInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PairingInfoCopyWith<PairingInfo> get copyWith => _$PairingInfoCopyWithImpl<PairingInfo>(this as PairingInfo, _$identity);

  /// Serializes this PairingInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PairingInfo&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.expiry, expiry) || other.expiry == expiry)&&(identical(other.relay, relay) || other.relay == relay)&&(identical(other.active, active) || other.active == active)&&const DeepCollectionEquality().equals(other.methods, methods)&&(identical(other.peerMetadata, peerMetadata) || other.peerMetadata == peerMetadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,topic,expiry,relay,active,const DeepCollectionEquality().hash(methods),peerMetadata);

@override
String toString() {
  return 'PairingInfo(topic: $topic, expiry: $expiry, relay: $relay, active: $active, methods: $methods, peerMetadata: $peerMetadata)';
}


}

/// @nodoc
abstract mixin class $PairingInfoCopyWith<$Res>  {
  factory $PairingInfoCopyWith(PairingInfo value, $Res Function(PairingInfo) _then) = _$PairingInfoCopyWithImpl;
@useResult
$Res call({
 String topic, int expiry, Relay relay, bool active, List<String>? methods, PairingMetadata? peerMetadata
});


$PairingMetadataCopyWith<$Res>? get peerMetadata;

}
/// @nodoc
class _$PairingInfoCopyWithImpl<$Res>
    implements $PairingInfoCopyWith<$Res> {
  _$PairingInfoCopyWithImpl(this._self, this._then);

  final PairingInfo _self;
  final $Res Function(PairingInfo) _then;

/// Create a copy of PairingInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? topic = null,Object? expiry = null,Object? relay = null,Object? active = null,Object? methods = freezed,Object? peerMetadata = freezed,}) {
  return _then(_self.copyWith(
topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,expiry: null == expiry ? _self.expiry : expiry // ignore: cast_nullable_to_non_nullable
as int,relay: null == relay ? _self.relay : relay // ignore: cast_nullable_to_non_nullable
as Relay,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,methods: freezed == methods ? _self.methods : methods // ignore: cast_nullable_to_non_nullable
as List<String>?,peerMetadata: freezed == peerMetadata ? _self.peerMetadata : peerMetadata // ignore: cast_nullable_to_non_nullable
as PairingMetadata?,
  ));
}
/// Create a copy of PairingInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PairingMetadataCopyWith<$Res>? get peerMetadata {
    if (_self.peerMetadata == null) {
    return null;
  }

  return $PairingMetadataCopyWith<$Res>(_self.peerMetadata!, (value) {
    return _then(_self.copyWith(peerMetadata: value));
  });
}
}


/// Adds pattern-matching-related methods to [PairingInfo].
extension PairingInfoPatterns on PairingInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PairingInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PairingInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PairingInfo value)  $default,){
final _that = this;
switch (_that) {
case _PairingInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PairingInfo value)?  $default,){
final _that = this;
switch (_that) {
case _PairingInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String topic,  int expiry,  Relay relay,  bool active,  List<String>? methods,  PairingMetadata? peerMetadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PairingInfo() when $default != null:
return $default(_that.topic,_that.expiry,_that.relay,_that.active,_that.methods,_that.peerMetadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String topic,  int expiry,  Relay relay,  bool active,  List<String>? methods,  PairingMetadata? peerMetadata)  $default,) {final _that = this;
switch (_that) {
case _PairingInfo():
return $default(_that.topic,_that.expiry,_that.relay,_that.active,_that.methods,_that.peerMetadata);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String topic,  int expiry,  Relay relay,  bool active,  List<String>? methods,  PairingMetadata? peerMetadata)?  $default,) {final _that = this;
switch (_that) {
case _PairingInfo() when $default != null:
return $default(_that.topic,_that.expiry,_that.relay,_that.active,_that.methods,_that.peerMetadata);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable()
class _PairingInfo implements PairingInfo {
  const _PairingInfo({required this.topic, required this.expiry, required this.relay, required this.active, final  List<String>? methods, this.peerMetadata}): _methods = methods;
  factory _PairingInfo.fromJson(Map<String, dynamic> json) => _$PairingInfoFromJson(json);

@override final  String topic;
@override final  int expiry;
@override final  Relay relay;
@override final  bool active;
 final  List<String>? _methods;
@override List<String>? get methods {
  final value = _methods;
  if (value == null) return null;
  if (_methods is EqualUnmodifiableListView) return _methods;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  PairingMetadata? peerMetadata;

/// Create a copy of PairingInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PairingInfoCopyWith<_PairingInfo> get copyWith => __$PairingInfoCopyWithImpl<_PairingInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PairingInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PairingInfo&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.expiry, expiry) || other.expiry == expiry)&&(identical(other.relay, relay) || other.relay == relay)&&(identical(other.active, active) || other.active == active)&&const DeepCollectionEquality().equals(other._methods, _methods)&&(identical(other.peerMetadata, peerMetadata) || other.peerMetadata == peerMetadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,topic,expiry,relay,active,const DeepCollectionEquality().hash(_methods),peerMetadata);

@override
String toString() {
  return 'PairingInfo(topic: $topic, expiry: $expiry, relay: $relay, active: $active, methods: $methods, peerMetadata: $peerMetadata)';
}


}

/// @nodoc
abstract mixin class _$PairingInfoCopyWith<$Res> implements $PairingInfoCopyWith<$Res> {
  factory _$PairingInfoCopyWith(_PairingInfo value, $Res Function(_PairingInfo) _then) = __$PairingInfoCopyWithImpl;
@override @useResult
$Res call({
 String topic, int expiry, Relay relay, bool active, List<String>? methods, PairingMetadata? peerMetadata
});


@override $PairingMetadataCopyWith<$Res>? get peerMetadata;

}
/// @nodoc
class __$PairingInfoCopyWithImpl<$Res>
    implements _$PairingInfoCopyWith<$Res> {
  __$PairingInfoCopyWithImpl(this._self, this._then);

  final _PairingInfo _self;
  final $Res Function(_PairingInfo) _then;

/// Create a copy of PairingInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? topic = null,Object? expiry = null,Object? relay = null,Object? active = null,Object? methods = freezed,Object? peerMetadata = freezed,}) {
  return _then(_PairingInfo(
topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,expiry: null == expiry ? _self.expiry : expiry // ignore: cast_nullable_to_non_nullable
as int,relay: null == relay ? _self.relay : relay // ignore: cast_nullable_to_non_nullable
as Relay,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,methods: freezed == methods ? _self._methods : methods // ignore: cast_nullable_to_non_nullable
as List<String>?,peerMetadata: freezed == peerMetadata ? _self.peerMetadata : peerMetadata // ignore: cast_nullable_to_non_nullable
as PairingMetadata?,
  ));
}

/// Create a copy of PairingInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PairingMetadataCopyWith<$Res>? get peerMetadata {
    if (_self.peerMetadata == null) {
    return null;
  }

  return $PairingMetadataCopyWith<$Res>(_self.peerMetadata!, (value) {
    return _then(_self.copyWith(peerMetadata: value));
  });
}
}


/// @nodoc
mixin _$PairingMetadata {

 String get name; String get description; String get url; List<String> get icons; String? get verifyUrl; Redirect? get redirect;
/// Create a copy of PairingMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PairingMetadataCopyWith<PairingMetadata> get copyWith => _$PairingMetadataCopyWithImpl<PairingMetadata>(this as PairingMetadata, _$identity);

  /// Serializes this PairingMetadata to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PairingMetadata&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other.icons, icons)&&(identical(other.verifyUrl, verifyUrl) || other.verifyUrl == verifyUrl)&&(identical(other.redirect, redirect) || other.redirect == redirect));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,description,url,const DeepCollectionEquality().hash(icons),verifyUrl,redirect);

@override
String toString() {
  return 'PairingMetadata(name: $name, description: $description, url: $url, icons: $icons, verifyUrl: $verifyUrl, redirect: $redirect)';
}


}

/// @nodoc
abstract mixin class $PairingMetadataCopyWith<$Res>  {
  factory $PairingMetadataCopyWith(PairingMetadata value, $Res Function(PairingMetadata) _then) = _$PairingMetadataCopyWithImpl;
@useResult
$Res call({
 String name, String description, String url, List<String> icons, String? verifyUrl, Redirect? redirect
});


$RedirectCopyWith<$Res>? get redirect;

}
/// @nodoc
class _$PairingMetadataCopyWithImpl<$Res>
    implements $PairingMetadataCopyWith<$Res> {
  _$PairingMetadataCopyWithImpl(this._self, this._then);

  final PairingMetadata _self;
  final $Res Function(PairingMetadata) _then;

/// Create a copy of PairingMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? description = null,Object? url = null,Object? icons = null,Object? verifyUrl = freezed,Object? redirect = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,icons: null == icons ? _self.icons : icons // ignore: cast_nullable_to_non_nullable
as List<String>,verifyUrl: freezed == verifyUrl ? _self.verifyUrl : verifyUrl // ignore: cast_nullable_to_non_nullable
as String?,redirect: freezed == redirect ? _self.redirect : redirect // ignore: cast_nullable_to_non_nullable
as Redirect?,
  ));
}
/// Create a copy of PairingMetadata
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RedirectCopyWith<$Res>? get redirect {
    if (_self.redirect == null) {
    return null;
  }

  return $RedirectCopyWith<$Res>(_self.redirect!, (value) {
    return _then(_self.copyWith(redirect: value));
  });
}
}


/// Adds pattern-matching-related methods to [PairingMetadata].
extension PairingMetadataPatterns on PairingMetadata {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PairingMetadata value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PairingMetadata() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PairingMetadata value)  $default,){
final _that = this;
switch (_that) {
case _PairingMetadata():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PairingMetadata value)?  $default,){
final _that = this;
switch (_that) {
case _PairingMetadata() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String description,  String url,  List<String> icons,  String? verifyUrl,  Redirect? redirect)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PairingMetadata() when $default != null:
return $default(_that.name,_that.description,_that.url,_that.icons,_that.verifyUrl,_that.redirect);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String description,  String url,  List<String> icons,  String? verifyUrl,  Redirect? redirect)  $default,) {final _that = this;
switch (_that) {
case _PairingMetadata():
return $default(_that.name,_that.description,_that.url,_that.icons,_that.verifyUrl,_that.redirect);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String description,  String url,  List<String> icons,  String? verifyUrl,  Redirect? redirect)?  $default,) {final _that = this;
switch (_that) {
case _PairingMetadata() when $default != null:
return $default(_that.name,_that.description,_that.url,_that.icons,_that.verifyUrl,_that.redirect);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _PairingMetadata implements PairingMetadata {
  const _PairingMetadata({required this.name, required this.description, this.url = '', final  List<String> icons = const <String>[], this.verifyUrl, this.redirect}): _icons = icons;
  factory _PairingMetadata.fromJson(Map<String, dynamic> json) => _$PairingMetadataFromJson(json);

@override final  String name;
@override final  String description;
@override@JsonKey() final  String url;
 final  List<String> _icons;
@override@JsonKey() List<String> get icons {
  if (_icons is EqualUnmodifiableListView) return _icons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_icons);
}

@override final  String? verifyUrl;
@override final  Redirect? redirect;

/// Create a copy of PairingMetadata
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PairingMetadataCopyWith<_PairingMetadata> get copyWith => __$PairingMetadataCopyWithImpl<_PairingMetadata>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PairingMetadataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PairingMetadata&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other._icons, _icons)&&(identical(other.verifyUrl, verifyUrl) || other.verifyUrl == verifyUrl)&&(identical(other.redirect, redirect) || other.redirect == redirect));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,description,url,const DeepCollectionEquality().hash(_icons),verifyUrl,redirect);

@override
String toString() {
  return 'PairingMetadata(name: $name, description: $description, url: $url, icons: $icons, verifyUrl: $verifyUrl, redirect: $redirect)';
}


}

/// @nodoc
abstract mixin class _$PairingMetadataCopyWith<$Res> implements $PairingMetadataCopyWith<$Res> {
  factory _$PairingMetadataCopyWith(_PairingMetadata value, $Res Function(_PairingMetadata) _then) = __$PairingMetadataCopyWithImpl;
@override @useResult
$Res call({
 String name, String description, String url, List<String> icons, String? verifyUrl, Redirect? redirect
});


@override $RedirectCopyWith<$Res>? get redirect;

}
/// @nodoc
class __$PairingMetadataCopyWithImpl<$Res>
    implements _$PairingMetadataCopyWith<$Res> {
  __$PairingMetadataCopyWithImpl(this._self, this._then);

  final _PairingMetadata _self;
  final $Res Function(_PairingMetadata) _then;

/// Create a copy of PairingMetadata
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? description = null,Object? url = null,Object? icons = null,Object? verifyUrl = freezed,Object? redirect = freezed,}) {
  return _then(_PairingMetadata(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,icons: null == icons ? _self._icons : icons // ignore: cast_nullable_to_non_nullable
as List<String>,verifyUrl: freezed == verifyUrl ? _self.verifyUrl : verifyUrl // ignore: cast_nullable_to_non_nullable
as String?,redirect: freezed == redirect ? _self.redirect : redirect // ignore: cast_nullable_to_non_nullable
as Redirect?,
  ));
}

/// Create a copy of PairingMetadata
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RedirectCopyWith<$Res>? get redirect {
    if (_self.redirect == null) {
    return null;
  }

  return $RedirectCopyWith<$Res>(_self.redirect!, (value) {
    return _then(_self.copyWith(redirect: value));
  });
}
}


/// @nodoc
mixin _$Redirect {

 String? get native; String? get universal; bool get linkMode;
/// Create a copy of Redirect
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RedirectCopyWith<Redirect> get copyWith => _$RedirectCopyWithImpl<Redirect>(this as Redirect, _$identity);

  /// Serializes this Redirect to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Redirect&&(identical(other.native, native) || other.native == native)&&(identical(other.universal, universal) || other.universal == universal)&&(identical(other.linkMode, linkMode) || other.linkMode == linkMode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,native,universal,linkMode);

@override
String toString() {
  return 'Redirect(native: $native, universal: $universal, linkMode: $linkMode)';
}


}

/// @nodoc
abstract mixin class $RedirectCopyWith<$Res>  {
  factory $RedirectCopyWith(Redirect value, $Res Function(Redirect) _then) = _$RedirectCopyWithImpl;
@useResult
$Res call({
 String? native, String? universal, bool linkMode
});




}
/// @nodoc
class _$RedirectCopyWithImpl<$Res>
    implements $RedirectCopyWith<$Res> {
  _$RedirectCopyWithImpl(this._self, this._then);

  final Redirect _self;
  final $Res Function(Redirect) _then;

/// Create a copy of Redirect
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? native = freezed,Object? universal = freezed,Object? linkMode = null,}) {
  return _then(_self.copyWith(
native: freezed == native ? _self.native : native // ignore: cast_nullable_to_non_nullable
as String?,universal: freezed == universal ? _self.universal : universal // ignore: cast_nullable_to_non_nullable
as String?,linkMode: null == linkMode ? _self.linkMode : linkMode // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Redirect].
extension RedirectPatterns on Redirect {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Redirect value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Redirect() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Redirect value)  $default,){
final _that = this;
switch (_that) {
case _Redirect():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Redirect value)?  $default,){
final _that = this;
switch (_that) {
case _Redirect() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? native,  String? universal,  bool linkMode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Redirect() when $default != null:
return $default(_that.native,_that.universal,_that.linkMode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? native,  String? universal,  bool linkMode)  $default,) {final _that = this;
switch (_that) {
case _Redirect():
return $default(_that.native,_that.universal,_that.linkMode);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? native,  String? universal,  bool linkMode)?  $default,) {final _that = this;
switch (_that) {
case _Redirect() when $default != null:
return $default(_that.native,_that.universal,_that.linkMode);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable()
class _Redirect implements Redirect {
  const _Redirect({this.native, this.universal, this.linkMode = false});
  factory _Redirect.fromJson(Map<String, dynamic> json) => _$RedirectFromJson(json);

@override final  String? native;
@override final  String? universal;
@override@JsonKey() final  bool linkMode;

/// Create a copy of Redirect
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RedirectCopyWith<_Redirect> get copyWith => __$RedirectCopyWithImpl<_Redirect>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RedirectToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Redirect&&(identical(other.native, native) || other.native == native)&&(identical(other.universal, universal) || other.universal == universal)&&(identical(other.linkMode, linkMode) || other.linkMode == linkMode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,native,universal,linkMode);

@override
String toString() {
  return 'Redirect(native: $native, universal: $universal, linkMode: $linkMode)';
}


}

/// @nodoc
abstract mixin class _$RedirectCopyWith<$Res> implements $RedirectCopyWith<$Res> {
  factory _$RedirectCopyWith(_Redirect value, $Res Function(_Redirect) _then) = __$RedirectCopyWithImpl;
@override @useResult
$Res call({
 String? native, String? universal, bool linkMode
});




}
/// @nodoc
class __$RedirectCopyWithImpl<$Res>
    implements _$RedirectCopyWith<$Res> {
  __$RedirectCopyWithImpl(this._self, this._then);

  final _Redirect _self;
  final $Res Function(_Redirect) _then;

/// Create a copy of Redirect
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? native = freezed,Object? universal = freezed,Object? linkMode = null,}) {
  return _then(_Redirect(
native: freezed == native ? _self.native : native // ignore: cast_nullable_to_non_nullable
as String?,universal: freezed == universal ? _self.universal : universal // ignore: cast_nullable_to_non_nullable
as String?,linkMode: null == linkMode ? _self.linkMode : linkMode // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$JsonRpcRecord {

 int get id; String get topic; String get method; dynamic get params; String? get chainId; int? get expiry; dynamic get response;
/// Create a copy of JsonRpcRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JsonRpcRecordCopyWith<JsonRpcRecord> get copyWith => _$JsonRpcRecordCopyWithImpl<JsonRpcRecord>(this as JsonRpcRecord, _$identity);

  /// Serializes this JsonRpcRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JsonRpcRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.method, method) || other.method == method)&&const DeepCollectionEquality().equals(other.params, params)&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.expiry, expiry) || other.expiry == expiry)&&const DeepCollectionEquality().equals(other.response, response));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,topic,method,const DeepCollectionEquality().hash(params),chainId,expiry,const DeepCollectionEquality().hash(response));

@override
String toString() {
  return 'JsonRpcRecord(id: $id, topic: $topic, method: $method, params: $params, chainId: $chainId, expiry: $expiry, response: $response)';
}


}

/// @nodoc
abstract mixin class $JsonRpcRecordCopyWith<$Res>  {
  factory $JsonRpcRecordCopyWith(JsonRpcRecord value, $Res Function(JsonRpcRecord) _then) = _$JsonRpcRecordCopyWithImpl;
@useResult
$Res call({
 int id, String topic, String method, dynamic params, String? chainId, int? expiry, dynamic response
});




}
/// @nodoc
class _$JsonRpcRecordCopyWithImpl<$Res>
    implements $JsonRpcRecordCopyWith<$Res> {
  _$JsonRpcRecordCopyWithImpl(this._self, this._then);

  final JsonRpcRecord _self;
  final $Res Function(JsonRpcRecord) _then;

/// Create a copy of JsonRpcRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? topic = null,Object? method = null,Object? params = freezed,Object? chainId = freezed,Object? expiry = freezed,Object? response = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,params: freezed == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as dynamic,chainId: freezed == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as String?,expiry: freezed == expiry ? _self.expiry : expiry // ignore: cast_nullable_to_non_nullable
as int?,response: freezed == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

}


/// Adds pattern-matching-related methods to [JsonRpcRecord].
extension JsonRpcRecordPatterns on JsonRpcRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JsonRpcRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JsonRpcRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JsonRpcRecord value)  $default,){
final _that = this;
switch (_that) {
case _JsonRpcRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JsonRpcRecord value)?  $default,){
final _that = this;
switch (_that) {
case _JsonRpcRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String topic,  String method,  dynamic params,  String? chainId,  int? expiry,  dynamic response)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JsonRpcRecord() when $default != null:
return $default(_that.id,_that.topic,_that.method,_that.params,_that.chainId,_that.expiry,_that.response);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String topic,  String method,  dynamic params,  String? chainId,  int? expiry,  dynamic response)  $default,) {final _that = this;
switch (_that) {
case _JsonRpcRecord():
return $default(_that.id,_that.topic,_that.method,_that.params,_that.chainId,_that.expiry,_that.response);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String topic,  String method,  dynamic params,  String? chainId,  int? expiry,  dynamic response)?  $default,) {final _that = this;
switch (_that) {
case _JsonRpcRecord() when $default != null:
return $default(_that.id,_that.topic,_that.method,_that.params,_that.chainId,_that.expiry,_that.response);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _JsonRpcRecord implements JsonRpcRecord {
  const _JsonRpcRecord({required this.id, required this.topic, required this.method, required this.params, this.chainId, this.expiry, this.response});
  factory _JsonRpcRecord.fromJson(Map<String, dynamic> json) => _$JsonRpcRecordFromJson(json);

@override final  int id;
@override final  String topic;
@override final  String method;
@override final  dynamic params;
@override final  String? chainId;
@override final  int? expiry;
@override final  dynamic response;

/// Create a copy of JsonRpcRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JsonRpcRecordCopyWith<_JsonRpcRecord> get copyWith => __$JsonRpcRecordCopyWithImpl<_JsonRpcRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JsonRpcRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JsonRpcRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.method, method) || other.method == method)&&const DeepCollectionEquality().equals(other.params, params)&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.expiry, expiry) || other.expiry == expiry)&&const DeepCollectionEquality().equals(other.response, response));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,topic,method,const DeepCollectionEquality().hash(params),chainId,expiry,const DeepCollectionEquality().hash(response));

@override
String toString() {
  return 'JsonRpcRecord(id: $id, topic: $topic, method: $method, params: $params, chainId: $chainId, expiry: $expiry, response: $response)';
}


}

/// @nodoc
abstract mixin class _$JsonRpcRecordCopyWith<$Res> implements $JsonRpcRecordCopyWith<$Res> {
  factory _$JsonRpcRecordCopyWith(_JsonRpcRecord value, $Res Function(_JsonRpcRecord) _then) = __$JsonRpcRecordCopyWithImpl;
@override @useResult
$Res call({
 int id, String topic, String method, dynamic params, String? chainId, int? expiry, dynamic response
});




}
/// @nodoc
class __$JsonRpcRecordCopyWithImpl<$Res>
    implements _$JsonRpcRecordCopyWith<$Res> {
  __$JsonRpcRecordCopyWithImpl(this._self, this._then);

  final _JsonRpcRecord _self;
  final $Res Function(_JsonRpcRecord) _then;

/// Create a copy of JsonRpcRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? topic = null,Object? method = null,Object? params = freezed,Object? chainId = freezed,Object? expiry = freezed,Object? response = freezed,}) {
  return _then(_JsonRpcRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,params: freezed == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as dynamic,chainId: freezed == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as String?,expiry: freezed == expiry ? _self.expiry : expiry // ignore: cast_nullable_to_non_nullable
as int?,response: freezed == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}


/// @nodoc
mixin _$ReceiverPublicKey {

 String get topic; String get publicKey; int get expiry;
/// Create a copy of ReceiverPublicKey
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReceiverPublicKeyCopyWith<ReceiverPublicKey> get copyWith => _$ReceiverPublicKeyCopyWithImpl<ReceiverPublicKey>(this as ReceiverPublicKey, _$identity);

  /// Serializes this ReceiverPublicKey to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReceiverPublicKey&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.publicKey, publicKey) || other.publicKey == publicKey)&&(identical(other.expiry, expiry) || other.expiry == expiry));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,topic,publicKey,expiry);

@override
String toString() {
  return 'ReceiverPublicKey(topic: $topic, publicKey: $publicKey, expiry: $expiry)';
}


}

/// @nodoc
abstract mixin class $ReceiverPublicKeyCopyWith<$Res>  {
  factory $ReceiverPublicKeyCopyWith(ReceiverPublicKey value, $Res Function(ReceiverPublicKey) _then) = _$ReceiverPublicKeyCopyWithImpl;
@useResult
$Res call({
 String topic, String publicKey, int expiry
});




}
/// @nodoc
class _$ReceiverPublicKeyCopyWithImpl<$Res>
    implements $ReceiverPublicKeyCopyWith<$Res> {
  _$ReceiverPublicKeyCopyWithImpl(this._self, this._then);

  final ReceiverPublicKey _self;
  final $Res Function(ReceiverPublicKey) _then;

/// Create a copy of ReceiverPublicKey
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? topic = null,Object? publicKey = null,Object? expiry = null,}) {
  return _then(_self.copyWith(
topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,publicKey: null == publicKey ? _self.publicKey : publicKey // ignore: cast_nullable_to_non_nullable
as String,expiry: null == expiry ? _self.expiry : expiry // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ReceiverPublicKey].
extension ReceiverPublicKeyPatterns on ReceiverPublicKey {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReceiverPublicKey value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReceiverPublicKey() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReceiverPublicKey value)  $default,){
final _that = this;
switch (_that) {
case _ReceiverPublicKey():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReceiverPublicKey value)?  $default,){
final _that = this;
switch (_that) {
case _ReceiverPublicKey() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String topic,  String publicKey,  int expiry)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReceiverPublicKey() when $default != null:
return $default(_that.topic,_that.publicKey,_that.expiry);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String topic,  String publicKey,  int expiry)  $default,) {final _that = this;
switch (_that) {
case _ReceiverPublicKey():
return $default(_that.topic,_that.publicKey,_that.expiry);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String topic,  String publicKey,  int expiry)?  $default,) {final _that = this;
switch (_that) {
case _ReceiverPublicKey() when $default != null:
return $default(_that.topic,_that.publicKey,_that.expiry);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _ReceiverPublicKey implements ReceiverPublicKey {
  const _ReceiverPublicKey({required this.topic, required this.publicKey, required this.expiry});
  factory _ReceiverPublicKey.fromJson(Map<String, dynamic> json) => _$ReceiverPublicKeyFromJson(json);

@override final  String topic;
@override final  String publicKey;
@override final  int expiry;

/// Create a copy of ReceiverPublicKey
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReceiverPublicKeyCopyWith<_ReceiverPublicKey> get copyWith => __$ReceiverPublicKeyCopyWithImpl<_ReceiverPublicKey>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReceiverPublicKeyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReceiverPublicKey&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.publicKey, publicKey) || other.publicKey == publicKey)&&(identical(other.expiry, expiry) || other.expiry == expiry));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,topic,publicKey,expiry);

@override
String toString() {
  return 'ReceiverPublicKey(topic: $topic, publicKey: $publicKey, expiry: $expiry)';
}


}

/// @nodoc
abstract mixin class _$ReceiverPublicKeyCopyWith<$Res> implements $ReceiverPublicKeyCopyWith<$Res> {
  factory _$ReceiverPublicKeyCopyWith(_ReceiverPublicKey value, $Res Function(_ReceiverPublicKey) _then) = __$ReceiverPublicKeyCopyWithImpl;
@override @useResult
$Res call({
 String topic, String publicKey, int expiry
});




}
/// @nodoc
class __$ReceiverPublicKeyCopyWithImpl<$Res>
    implements _$ReceiverPublicKeyCopyWith<$Res> {
  __$ReceiverPublicKeyCopyWithImpl(this._self, this._then);

  final _ReceiverPublicKey _self;
  final $Res Function(_ReceiverPublicKey) _then;

/// Create a copy of ReceiverPublicKey
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? topic = null,Object? publicKey = null,Object? expiry = null,}) {
  return _then(_ReceiverPublicKey(
topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,publicKey: null == publicKey ? _self.publicKey : publicKey // ignore: cast_nullable_to_non_nullable
as String,expiry: null == expiry ? _self.expiry : expiry // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
