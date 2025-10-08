// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'platform_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlatformSessionProposal {

 String get pairingTopic; String get name; String get description; String get url; List<String> get icons; String get redirect; Map<String, RequiredNamespace> get requiredNamespaces; Map<String, RequiredNamespace> get optionalNamespaces; String get proposerPublicKey; String get relayProtocol; dynamic get relayData; dynamic get scopedProperties; dynamic get properties;
/// Create a copy of PlatformSessionProposal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlatformSessionProposalCopyWith<PlatformSessionProposal> get copyWith => _$PlatformSessionProposalCopyWithImpl<PlatformSessionProposal>(this as PlatformSessionProposal, _$identity);

  /// Serializes this PlatformSessionProposal to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlatformSessionProposal&&(identical(other.pairingTopic, pairingTopic) || other.pairingTopic == pairingTopic)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other.icons, icons)&&(identical(other.redirect, redirect) || other.redirect == redirect)&&const DeepCollectionEquality().equals(other.requiredNamespaces, requiredNamespaces)&&const DeepCollectionEquality().equals(other.optionalNamespaces, optionalNamespaces)&&(identical(other.proposerPublicKey, proposerPublicKey) || other.proposerPublicKey == proposerPublicKey)&&(identical(other.relayProtocol, relayProtocol) || other.relayProtocol == relayProtocol)&&const DeepCollectionEquality().equals(other.relayData, relayData)&&const DeepCollectionEquality().equals(other.scopedProperties, scopedProperties)&&const DeepCollectionEquality().equals(other.properties, properties));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pairingTopic,name,description,url,const DeepCollectionEquality().hash(icons),redirect,const DeepCollectionEquality().hash(requiredNamespaces),const DeepCollectionEquality().hash(optionalNamespaces),proposerPublicKey,relayProtocol,const DeepCollectionEquality().hash(relayData),const DeepCollectionEquality().hash(scopedProperties),const DeepCollectionEquality().hash(properties));

@override
String toString() {
  return 'PlatformSessionProposal(pairingTopic: $pairingTopic, name: $name, description: $description, url: $url, icons: $icons, redirect: $redirect, requiredNamespaces: $requiredNamespaces, optionalNamespaces: $optionalNamespaces, proposerPublicKey: $proposerPublicKey, relayProtocol: $relayProtocol, relayData: $relayData, scopedProperties: $scopedProperties, properties: $properties)';
}


}

/// @nodoc
abstract mixin class $PlatformSessionProposalCopyWith<$Res>  {
  factory $PlatformSessionProposalCopyWith(PlatformSessionProposal value, $Res Function(PlatformSessionProposal) _then) = _$PlatformSessionProposalCopyWithImpl;
@useResult
$Res call({
 String pairingTopic, String name, String description, String url, List<String> icons, String redirect, Map<String, RequiredNamespace> requiredNamespaces, Map<String, RequiredNamespace> optionalNamespaces, String proposerPublicKey, String relayProtocol, dynamic relayData, dynamic scopedProperties, dynamic properties
});




}
/// @nodoc
class _$PlatformSessionProposalCopyWithImpl<$Res>
    implements $PlatformSessionProposalCopyWith<$Res> {
  _$PlatformSessionProposalCopyWithImpl(this._self, this._then);

  final PlatformSessionProposal _self;
  final $Res Function(PlatformSessionProposal) _then;

/// Create a copy of PlatformSessionProposal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pairingTopic = null,Object? name = null,Object? description = null,Object? url = null,Object? icons = null,Object? redirect = null,Object? requiredNamespaces = null,Object? optionalNamespaces = null,Object? proposerPublicKey = null,Object? relayProtocol = null,Object? relayData = freezed,Object? scopedProperties = freezed,Object? properties = freezed,}) {
  return _then(_self.copyWith(
pairingTopic: null == pairingTopic ? _self.pairingTopic : pairingTopic // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,icons: null == icons ? _self.icons : icons // ignore: cast_nullable_to_non_nullable
as List<String>,redirect: null == redirect ? _self.redirect : redirect // ignore: cast_nullable_to_non_nullable
as String,requiredNamespaces: null == requiredNamespaces ? _self.requiredNamespaces : requiredNamespaces // ignore: cast_nullable_to_non_nullable
as Map<String, RequiredNamespace>,optionalNamespaces: null == optionalNamespaces ? _self.optionalNamespaces : optionalNamespaces // ignore: cast_nullable_to_non_nullable
as Map<String, RequiredNamespace>,proposerPublicKey: null == proposerPublicKey ? _self.proposerPublicKey : proposerPublicKey // ignore: cast_nullable_to_non_nullable
as String,relayProtocol: null == relayProtocol ? _self.relayProtocol : relayProtocol // ignore: cast_nullable_to_non_nullable
as String,relayData: freezed == relayData ? _self.relayData : relayData // ignore: cast_nullable_to_non_nullable
as dynamic,scopedProperties: freezed == scopedProperties ? _self.scopedProperties : scopedProperties // ignore: cast_nullable_to_non_nullable
as dynamic,properties: freezed == properties ? _self.properties : properties // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

}


/// Adds pattern-matching-related methods to [PlatformSessionProposal].
extension PlatformSessionProposalPatterns on PlatformSessionProposal {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlatformSessionProposal value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlatformSessionProposal() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlatformSessionProposal value)  $default,){
final _that = this;
switch (_that) {
case _PlatformSessionProposal():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlatformSessionProposal value)?  $default,){
final _that = this;
switch (_that) {
case _PlatformSessionProposal() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String pairingTopic,  String name,  String description,  String url,  List<String> icons,  String redirect,  Map<String, RequiredNamespace> requiredNamespaces,  Map<String, RequiredNamespace> optionalNamespaces,  String proposerPublicKey,  String relayProtocol,  dynamic relayData,  dynamic scopedProperties,  dynamic properties)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlatformSessionProposal() when $default != null:
return $default(_that.pairingTopic,_that.name,_that.description,_that.url,_that.icons,_that.redirect,_that.requiredNamespaces,_that.optionalNamespaces,_that.proposerPublicKey,_that.relayProtocol,_that.relayData,_that.scopedProperties,_that.properties);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String pairingTopic,  String name,  String description,  String url,  List<String> icons,  String redirect,  Map<String, RequiredNamespace> requiredNamespaces,  Map<String, RequiredNamespace> optionalNamespaces,  String proposerPublicKey,  String relayProtocol,  dynamic relayData,  dynamic scopedProperties,  dynamic properties)  $default,) {final _that = this;
switch (_that) {
case _PlatformSessionProposal():
return $default(_that.pairingTopic,_that.name,_that.description,_that.url,_that.icons,_that.redirect,_that.requiredNamespaces,_that.optionalNamespaces,_that.proposerPublicKey,_that.relayProtocol,_that.relayData,_that.scopedProperties,_that.properties);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String pairingTopic,  String name,  String description,  String url,  List<String> icons,  String redirect,  Map<String, RequiredNamespace> requiredNamespaces,  Map<String, RequiredNamespace> optionalNamespaces,  String proposerPublicKey,  String relayProtocol,  dynamic relayData,  dynamic scopedProperties,  dynamic properties)?  $default,) {final _that = this;
switch (_that) {
case _PlatformSessionProposal() when $default != null:
return $default(_that.pairingTopic,_that.name,_that.description,_that.url,_that.icons,_that.redirect,_that.requiredNamespaces,_that.optionalNamespaces,_that.proposerPublicKey,_that.relayProtocol,_that.relayData,_that.scopedProperties,_that.properties);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlatformSessionProposal implements PlatformSessionProposal {
  const _PlatformSessionProposal({required this.pairingTopic, required this.name, required this.description, required this.url, required final  List<String> icons, required this.redirect, required final  Map<String, RequiredNamespace> requiredNamespaces, required final  Map<String, RequiredNamespace> optionalNamespaces, required this.proposerPublicKey, required this.relayProtocol, this.relayData, this.scopedProperties, this.properties}): _icons = icons,_requiredNamespaces = requiredNamespaces,_optionalNamespaces = optionalNamespaces;
  factory _PlatformSessionProposal.fromJson(Map<String, dynamic> json) => _$PlatformSessionProposalFromJson(json);

@override final  String pairingTopic;
@override final  String name;
@override final  String description;
@override final  String url;
 final  List<String> _icons;
@override List<String> get icons {
  if (_icons is EqualUnmodifiableListView) return _icons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_icons);
}

@override final  String redirect;
 final  Map<String, RequiredNamespace> _requiredNamespaces;
@override Map<String, RequiredNamespace> get requiredNamespaces {
  if (_requiredNamespaces is EqualUnmodifiableMapView) return _requiredNamespaces;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_requiredNamespaces);
}

 final  Map<String, RequiredNamespace> _optionalNamespaces;
@override Map<String, RequiredNamespace> get optionalNamespaces {
  if (_optionalNamespaces is EqualUnmodifiableMapView) return _optionalNamespaces;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_optionalNamespaces);
}

@override final  String proposerPublicKey;
@override final  String relayProtocol;
@override final  dynamic relayData;
@override final  dynamic scopedProperties;
@override final  dynamic properties;

/// Create a copy of PlatformSessionProposal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlatformSessionProposalCopyWith<_PlatformSessionProposal> get copyWith => __$PlatformSessionProposalCopyWithImpl<_PlatformSessionProposal>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlatformSessionProposalToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlatformSessionProposal&&(identical(other.pairingTopic, pairingTopic) || other.pairingTopic == pairingTopic)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other._icons, _icons)&&(identical(other.redirect, redirect) || other.redirect == redirect)&&const DeepCollectionEquality().equals(other._requiredNamespaces, _requiredNamespaces)&&const DeepCollectionEquality().equals(other._optionalNamespaces, _optionalNamespaces)&&(identical(other.proposerPublicKey, proposerPublicKey) || other.proposerPublicKey == proposerPublicKey)&&(identical(other.relayProtocol, relayProtocol) || other.relayProtocol == relayProtocol)&&const DeepCollectionEquality().equals(other.relayData, relayData)&&const DeepCollectionEquality().equals(other.scopedProperties, scopedProperties)&&const DeepCollectionEquality().equals(other.properties, properties));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pairingTopic,name,description,url,const DeepCollectionEquality().hash(_icons),redirect,const DeepCollectionEquality().hash(_requiredNamespaces),const DeepCollectionEquality().hash(_optionalNamespaces),proposerPublicKey,relayProtocol,const DeepCollectionEquality().hash(relayData),const DeepCollectionEquality().hash(scopedProperties),const DeepCollectionEquality().hash(properties));

@override
String toString() {
  return 'PlatformSessionProposal(pairingTopic: $pairingTopic, name: $name, description: $description, url: $url, icons: $icons, redirect: $redirect, requiredNamespaces: $requiredNamespaces, optionalNamespaces: $optionalNamespaces, proposerPublicKey: $proposerPublicKey, relayProtocol: $relayProtocol, relayData: $relayData, scopedProperties: $scopedProperties, properties: $properties)';
}


}

/// @nodoc
abstract mixin class _$PlatformSessionProposalCopyWith<$Res> implements $PlatformSessionProposalCopyWith<$Res> {
  factory _$PlatformSessionProposalCopyWith(_PlatformSessionProposal value, $Res Function(_PlatformSessionProposal) _then) = __$PlatformSessionProposalCopyWithImpl;
@override @useResult
$Res call({
 String pairingTopic, String name, String description, String url, List<String> icons, String redirect, Map<String, RequiredNamespace> requiredNamespaces, Map<String, RequiredNamespace> optionalNamespaces, String proposerPublicKey, String relayProtocol, dynamic relayData, dynamic scopedProperties, dynamic properties
});




}
/// @nodoc
class __$PlatformSessionProposalCopyWithImpl<$Res>
    implements _$PlatformSessionProposalCopyWith<$Res> {
  __$PlatformSessionProposalCopyWithImpl(this._self, this._then);

  final _PlatformSessionProposal _self;
  final $Res Function(_PlatformSessionProposal) _then;

/// Create a copy of PlatformSessionProposal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pairingTopic = null,Object? name = null,Object? description = null,Object? url = null,Object? icons = null,Object? redirect = null,Object? requiredNamespaces = null,Object? optionalNamespaces = null,Object? proposerPublicKey = null,Object? relayProtocol = null,Object? relayData = freezed,Object? scopedProperties = freezed,Object? properties = freezed,}) {
  return _then(_PlatformSessionProposal(
pairingTopic: null == pairingTopic ? _self.pairingTopic : pairingTopic // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,icons: null == icons ? _self._icons : icons // ignore: cast_nullable_to_non_nullable
as List<String>,redirect: null == redirect ? _self.redirect : redirect // ignore: cast_nullable_to_non_nullable
as String,requiredNamespaces: null == requiredNamespaces ? _self._requiredNamespaces : requiredNamespaces // ignore: cast_nullable_to_non_nullable
as Map<String, RequiredNamespace>,optionalNamespaces: null == optionalNamespaces ? _self._optionalNamespaces : optionalNamespaces // ignore: cast_nullable_to_non_nullable
as Map<String, RequiredNamespace>,proposerPublicKey: null == proposerPublicKey ? _self.proposerPublicKey : proposerPublicKey // ignore: cast_nullable_to_non_nullable
as String,relayProtocol: null == relayProtocol ? _self.relayProtocol : relayProtocol // ignore: cast_nullable_to_non_nullable
as String,relayData: freezed == relayData ? _self.relayData : relayData // ignore: cast_nullable_to_non_nullable
as dynamic,scopedProperties: freezed == scopedProperties ? _self.scopedProperties : scopedProperties // ignore: cast_nullable_to_non_nullable
as dynamic,properties: freezed == properties ? _self.properties : properties // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}


/// @nodoc
mixin _$PlatformSessionSettle {

 String get type; PlatformSession get session;
/// Create a copy of PlatformSessionSettle
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlatformSessionSettleCopyWith<PlatformSessionSettle> get copyWith => _$PlatformSessionSettleCopyWithImpl<PlatformSessionSettle>(this as PlatformSessionSettle, _$identity);

  /// Serializes this PlatformSessionSettle to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlatformSessionSettle&&(identical(other.type, type) || other.type == type)&&(identical(other.session, session) || other.session == session));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,session);

@override
String toString() {
  return 'PlatformSessionSettle(type: $type, session: $session)';
}


}

/// @nodoc
abstract mixin class $PlatformSessionSettleCopyWith<$Res>  {
  factory $PlatformSessionSettleCopyWith(PlatformSessionSettle value, $Res Function(PlatformSessionSettle) _then) = _$PlatformSessionSettleCopyWithImpl;
@useResult
$Res call({
 String type, PlatformSession session
});


$PlatformSessionCopyWith<$Res> get session;

}
/// @nodoc
class _$PlatformSessionSettleCopyWithImpl<$Res>
    implements $PlatformSessionSettleCopyWith<$Res> {
  _$PlatformSessionSettleCopyWithImpl(this._self, this._then);

  final PlatformSessionSettle _self;
  final $Res Function(PlatformSessionSettle) _then;

/// Create a copy of PlatformSessionSettle
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? session = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as PlatformSession,
  ));
}
/// Create a copy of PlatformSessionSettle
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlatformSessionCopyWith<$Res> get session {
  
  return $PlatformSessionCopyWith<$Res>(_self.session, (value) {
    return _then(_self.copyWith(session: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlatformSessionSettle].
extension PlatformSessionSettlePatterns on PlatformSessionSettle {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlatformSessionSettle value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlatformSessionSettle() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlatformSessionSettle value)  $default,){
final _that = this;
switch (_that) {
case _PlatformSessionSettle():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlatformSessionSettle value)?  $default,){
final _that = this;
switch (_that) {
case _PlatformSessionSettle() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  PlatformSession session)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlatformSessionSettle() when $default != null:
return $default(_that.type,_that.session);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  PlatformSession session)  $default,) {final _that = this;
switch (_that) {
case _PlatformSessionSettle():
return $default(_that.type,_that.session);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  PlatformSession session)?  $default,) {final _that = this;
switch (_that) {
case _PlatformSessionSettle() when $default != null:
return $default(_that.type,_that.session);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlatformSessionSettle implements PlatformSessionSettle {
  const _PlatformSessionSettle({required this.type, required this.session});
  factory _PlatformSessionSettle.fromJson(Map<String, dynamic> json) => _$PlatformSessionSettleFromJson(json);

@override final  String type;
@override final  PlatformSession session;

/// Create a copy of PlatformSessionSettle
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlatformSessionSettleCopyWith<_PlatformSessionSettle> get copyWith => __$PlatformSessionSettleCopyWithImpl<_PlatformSessionSettle>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlatformSessionSettleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlatformSessionSettle&&(identical(other.type, type) || other.type == type)&&(identical(other.session, session) || other.session == session));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,session);

@override
String toString() {
  return 'PlatformSessionSettle(type: $type, session: $session)';
}


}

/// @nodoc
abstract mixin class _$PlatformSessionSettleCopyWith<$Res> implements $PlatformSessionSettleCopyWith<$Res> {
  factory _$PlatformSessionSettleCopyWith(_PlatformSessionSettle value, $Res Function(_PlatformSessionSettle) _then) = __$PlatformSessionSettleCopyWithImpl;
@override @useResult
$Res call({
 String type, PlatformSession session
});


@override $PlatformSessionCopyWith<$Res> get session;

}
/// @nodoc
class __$PlatformSessionSettleCopyWithImpl<$Res>
    implements _$PlatformSessionSettleCopyWith<$Res> {
  __$PlatformSessionSettleCopyWithImpl(this._self, this._then);

  final _PlatformSessionSettle _self;
  final $Res Function(_PlatformSessionSettle) _then;

/// Create a copy of PlatformSessionSettle
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? session = null,}) {
  return _then(_PlatformSessionSettle(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,session: null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as PlatformSession,
  ));
}

/// Create a copy of PlatformSessionSettle
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlatformSessionCopyWith<$Res> get session {
  
  return $PlatformSessionCopyWith<$Res>(_self.session, (value) {
    return _then(_self.copyWith(session: value));
  });
}
}


/// @nodoc
mixin _$PlatformSession {

 String get pairingTopic; String get topic; int get expiry; Map<String, dynamic> get requiredNamespaces; Map<String, PlatformNamespace> get optionalNamespaces; Map<String, PlatformNamespaceWithAccounts> get namespaces; PlatformMetaData get metaData; String get redirect;
/// Create a copy of PlatformSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlatformSessionCopyWith<PlatformSession> get copyWith => _$PlatformSessionCopyWithImpl<PlatformSession>(this as PlatformSession, _$identity);

  /// Serializes this PlatformSession to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlatformSession&&(identical(other.pairingTopic, pairingTopic) || other.pairingTopic == pairingTopic)&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.expiry, expiry) || other.expiry == expiry)&&const DeepCollectionEquality().equals(other.requiredNamespaces, requiredNamespaces)&&const DeepCollectionEquality().equals(other.optionalNamespaces, optionalNamespaces)&&const DeepCollectionEquality().equals(other.namespaces, namespaces)&&(identical(other.metaData, metaData) || other.metaData == metaData)&&(identical(other.redirect, redirect) || other.redirect == redirect));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pairingTopic,topic,expiry,const DeepCollectionEquality().hash(requiredNamespaces),const DeepCollectionEquality().hash(optionalNamespaces),const DeepCollectionEquality().hash(namespaces),metaData,redirect);

@override
String toString() {
  return 'PlatformSession(pairingTopic: $pairingTopic, topic: $topic, expiry: $expiry, requiredNamespaces: $requiredNamespaces, optionalNamespaces: $optionalNamespaces, namespaces: $namespaces, metaData: $metaData, redirect: $redirect)';
}


}

/// @nodoc
abstract mixin class $PlatformSessionCopyWith<$Res>  {
  factory $PlatformSessionCopyWith(PlatformSession value, $Res Function(PlatformSession) _then) = _$PlatformSessionCopyWithImpl;
@useResult
$Res call({
 String pairingTopic, String topic, int expiry, Map<String, dynamic> requiredNamespaces, Map<String, PlatformNamespace> optionalNamespaces, Map<String, PlatformNamespaceWithAccounts> namespaces, PlatformMetaData metaData, String redirect
});


$PlatformMetaDataCopyWith<$Res> get metaData;

}
/// @nodoc
class _$PlatformSessionCopyWithImpl<$Res>
    implements $PlatformSessionCopyWith<$Res> {
  _$PlatformSessionCopyWithImpl(this._self, this._then);

  final PlatformSession _self;
  final $Res Function(PlatformSession) _then;

/// Create a copy of PlatformSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pairingTopic = null,Object? topic = null,Object? expiry = null,Object? requiredNamespaces = null,Object? optionalNamespaces = null,Object? namespaces = null,Object? metaData = null,Object? redirect = null,}) {
  return _then(_self.copyWith(
pairingTopic: null == pairingTopic ? _self.pairingTopic : pairingTopic // ignore: cast_nullable_to_non_nullable
as String,topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,expiry: null == expiry ? _self.expiry : expiry // ignore: cast_nullable_to_non_nullable
as int,requiredNamespaces: null == requiredNamespaces ? _self.requiredNamespaces : requiredNamespaces // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,optionalNamespaces: null == optionalNamespaces ? _self.optionalNamespaces : optionalNamespaces // ignore: cast_nullable_to_non_nullable
as Map<String, PlatformNamespace>,namespaces: null == namespaces ? _self.namespaces : namespaces // ignore: cast_nullable_to_non_nullable
as Map<String, PlatformNamespaceWithAccounts>,metaData: null == metaData ? _self.metaData : metaData // ignore: cast_nullable_to_non_nullable
as PlatformMetaData,redirect: null == redirect ? _self.redirect : redirect // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of PlatformSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlatformMetaDataCopyWith<$Res> get metaData {
  
  return $PlatformMetaDataCopyWith<$Res>(_self.metaData, (value) {
    return _then(_self.copyWith(metaData: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlatformSession].
extension PlatformSessionPatterns on PlatformSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlatformSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlatformSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlatformSession value)  $default,){
final _that = this;
switch (_that) {
case _PlatformSession():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlatformSession value)?  $default,){
final _that = this;
switch (_that) {
case _PlatformSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String pairingTopic,  String topic,  int expiry,  Map<String, dynamic> requiredNamespaces,  Map<String, PlatformNamespace> optionalNamespaces,  Map<String, PlatformNamespaceWithAccounts> namespaces,  PlatformMetaData metaData,  String redirect)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlatformSession() when $default != null:
return $default(_that.pairingTopic,_that.topic,_that.expiry,_that.requiredNamespaces,_that.optionalNamespaces,_that.namespaces,_that.metaData,_that.redirect);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String pairingTopic,  String topic,  int expiry,  Map<String, dynamic> requiredNamespaces,  Map<String, PlatformNamespace> optionalNamespaces,  Map<String, PlatformNamespaceWithAccounts> namespaces,  PlatformMetaData metaData,  String redirect)  $default,) {final _that = this;
switch (_that) {
case _PlatformSession():
return $default(_that.pairingTopic,_that.topic,_that.expiry,_that.requiredNamespaces,_that.optionalNamespaces,_that.namespaces,_that.metaData,_that.redirect);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String pairingTopic,  String topic,  int expiry,  Map<String, dynamic> requiredNamespaces,  Map<String, PlatformNamespace> optionalNamespaces,  Map<String, PlatformNamespaceWithAccounts> namespaces,  PlatformMetaData metaData,  String redirect)?  $default,) {final _that = this;
switch (_that) {
case _PlatformSession() when $default != null:
return $default(_that.pairingTopic,_that.topic,_that.expiry,_that.requiredNamespaces,_that.optionalNamespaces,_that.namespaces,_that.metaData,_that.redirect);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlatformSession implements PlatformSession {
  const _PlatformSession({required this.pairingTopic, required this.topic, required this.expiry, required final  Map<String, dynamic> requiredNamespaces, required final  Map<String, PlatformNamespace> optionalNamespaces, required final  Map<String, PlatformNamespaceWithAccounts> namespaces, required this.metaData, required this.redirect}): _requiredNamespaces = requiredNamespaces,_optionalNamespaces = optionalNamespaces,_namespaces = namespaces;
  factory _PlatformSession.fromJson(Map<String, dynamic> json) => _$PlatformSessionFromJson(json);

@override final  String pairingTopic;
@override final  String topic;
@override final  int expiry;
 final  Map<String, dynamic> _requiredNamespaces;
@override Map<String, dynamic> get requiredNamespaces {
  if (_requiredNamespaces is EqualUnmodifiableMapView) return _requiredNamespaces;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_requiredNamespaces);
}

 final  Map<String, PlatformNamespace> _optionalNamespaces;
@override Map<String, PlatformNamespace> get optionalNamespaces {
  if (_optionalNamespaces is EqualUnmodifiableMapView) return _optionalNamespaces;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_optionalNamespaces);
}

 final  Map<String, PlatformNamespaceWithAccounts> _namespaces;
@override Map<String, PlatformNamespaceWithAccounts> get namespaces {
  if (_namespaces is EqualUnmodifiableMapView) return _namespaces;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_namespaces);
}

@override final  PlatformMetaData metaData;
@override final  String redirect;

/// Create a copy of PlatformSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlatformSessionCopyWith<_PlatformSession> get copyWith => __$PlatformSessionCopyWithImpl<_PlatformSession>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlatformSessionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlatformSession&&(identical(other.pairingTopic, pairingTopic) || other.pairingTopic == pairingTopic)&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.expiry, expiry) || other.expiry == expiry)&&const DeepCollectionEquality().equals(other._requiredNamespaces, _requiredNamespaces)&&const DeepCollectionEquality().equals(other._optionalNamespaces, _optionalNamespaces)&&const DeepCollectionEquality().equals(other._namespaces, _namespaces)&&(identical(other.metaData, metaData) || other.metaData == metaData)&&(identical(other.redirect, redirect) || other.redirect == redirect));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pairingTopic,topic,expiry,const DeepCollectionEquality().hash(_requiredNamespaces),const DeepCollectionEquality().hash(_optionalNamespaces),const DeepCollectionEquality().hash(_namespaces),metaData,redirect);

@override
String toString() {
  return 'PlatformSession(pairingTopic: $pairingTopic, topic: $topic, expiry: $expiry, requiredNamespaces: $requiredNamespaces, optionalNamespaces: $optionalNamespaces, namespaces: $namespaces, metaData: $metaData, redirect: $redirect)';
}


}

/// @nodoc
abstract mixin class _$PlatformSessionCopyWith<$Res> implements $PlatformSessionCopyWith<$Res> {
  factory _$PlatformSessionCopyWith(_PlatformSession value, $Res Function(_PlatformSession) _then) = __$PlatformSessionCopyWithImpl;
@override @useResult
$Res call({
 String pairingTopic, String topic, int expiry, Map<String, dynamic> requiredNamespaces, Map<String, PlatformNamespace> optionalNamespaces, Map<String, PlatformNamespaceWithAccounts> namespaces, PlatformMetaData metaData, String redirect
});


@override $PlatformMetaDataCopyWith<$Res> get metaData;

}
/// @nodoc
class __$PlatformSessionCopyWithImpl<$Res>
    implements _$PlatformSessionCopyWith<$Res> {
  __$PlatformSessionCopyWithImpl(this._self, this._then);

  final _PlatformSession _self;
  final $Res Function(_PlatformSession) _then;

/// Create a copy of PlatformSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pairingTopic = null,Object? topic = null,Object? expiry = null,Object? requiredNamespaces = null,Object? optionalNamespaces = null,Object? namespaces = null,Object? metaData = null,Object? redirect = null,}) {
  return _then(_PlatformSession(
pairingTopic: null == pairingTopic ? _self.pairingTopic : pairingTopic // ignore: cast_nullable_to_non_nullable
as String,topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,expiry: null == expiry ? _self.expiry : expiry // ignore: cast_nullable_to_non_nullable
as int,requiredNamespaces: null == requiredNamespaces ? _self._requiredNamespaces : requiredNamespaces // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,optionalNamespaces: null == optionalNamespaces ? _self._optionalNamespaces : optionalNamespaces // ignore: cast_nullable_to_non_nullable
as Map<String, PlatformNamespace>,namespaces: null == namespaces ? _self._namespaces : namespaces // ignore: cast_nullable_to_non_nullable
as Map<String, PlatformNamespaceWithAccounts>,metaData: null == metaData ? _self.metaData : metaData // ignore: cast_nullable_to_non_nullable
as PlatformMetaData,redirect: null == redirect ? _self.redirect : redirect // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of PlatformSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlatformMetaDataCopyWith<$Res> get metaData {
  
  return $PlatformMetaDataCopyWith<$Res>(_self.metaData, (value) {
    return _then(_self.copyWith(metaData: value));
  });
}
}


/// @nodoc
mixin _$PlatformNamespace {

 List<String> get chains; List<String> get methods; List<String> get events;
/// Create a copy of PlatformNamespace
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlatformNamespaceCopyWith<PlatformNamespace> get copyWith => _$PlatformNamespaceCopyWithImpl<PlatformNamespace>(this as PlatformNamespace, _$identity);

  /// Serializes this PlatformNamespace to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlatformNamespace&&const DeepCollectionEquality().equals(other.chains, chains)&&const DeepCollectionEquality().equals(other.methods, methods)&&const DeepCollectionEquality().equals(other.events, events));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(chains),const DeepCollectionEquality().hash(methods),const DeepCollectionEquality().hash(events));

@override
String toString() {
  return 'PlatformNamespace(chains: $chains, methods: $methods, events: $events)';
}


}

/// @nodoc
abstract mixin class $PlatformNamespaceCopyWith<$Res>  {
  factory $PlatformNamespaceCopyWith(PlatformNamespace value, $Res Function(PlatformNamespace) _then) = _$PlatformNamespaceCopyWithImpl;
@useResult
$Res call({
 List<String> chains, List<String> methods, List<String> events
});




}
/// @nodoc
class _$PlatformNamespaceCopyWithImpl<$Res>
    implements $PlatformNamespaceCopyWith<$Res> {
  _$PlatformNamespaceCopyWithImpl(this._self, this._then);

  final PlatformNamespace _self;
  final $Res Function(PlatformNamespace) _then;

/// Create a copy of PlatformNamespace
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? chains = null,Object? methods = null,Object? events = null,}) {
  return _then(_self.copyWith(
chains: null == chains ? _self.chains : chains // ignore: cast_nullable_to_non_nullable
as List<String>,methods: null == methods ? _self.methods : methods // ignore: cast_nullable_to_non_nullable
as List<String>,events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [PlatformNamespace].
extension PlatformNamespacePatterns on PlatformNamespace {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlatformNamespace value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlatformNamespace() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlatformNamespace value)  $default,){
final _that = this;
switch (_that) {
case _PlatformNamespace():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlatformNamespace value)?  $default,){
final _that = this;
switch (_that) {
case _PlatformNamespace() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> chains,  List<String> methods,  List<String> events)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlatformNamespace() when $default != null:
return $default(_that.chains,_that.methods,_that.events);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> chains,  List<String> methods,  List<String> events)  $default,) {final _that = this;
switch (_that) {
case _PlatformNamespace():
return $default(_that.chains,_that.methods,_that.events);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> chains,  List<String> methods,  List<String> events)?  $default,) {final _that = this;
switch (_that) {
case _PlatformNamespace() when $default != null:
return $default(_that.chains,_that.methods,_that.events);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlatformNamespace implements PlatformNamespace {
  const _PlatformNamespace({required final  List<String> chains, required final  List<String> methods, required final  List<String> events}): _chains = chains,_methods = methods,_events = events;
  factory _PlatformNamespace.fromJson(Map<String, dynamic> json) => _$PlatformNamespaceFromJson(json);

 final  List<String> _chains;
@override List<String> get chains {
  if (_chains is EqualUnmodifiableListView) return _chains;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_chains);
}

 final  List<String> _methods;
@override List<String> get methods {
  if (_methods is EqualUnmodifiableListView) return _methods;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_methods);
}

 final  List<String> _events;
@override List<String> get events {
  if (_events is EqualUnmodifiableListView) return _events;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_events);
}


/// Create a copy of PlatformNamespace
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlatformNamespaceCopyWith<_PlatformNamespace> get copyWith => __$PlatformNamespaceCopyWithImpl<_PlatformNamespace>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlatformNamespaceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlatformNamespace&&const DeepCollectionEquality().equals(other._chains, _chains)&&const DeepCollectionEquality().equals(other._methods, _methods)&&const DeepCollectionEquality().equals(other._events, _events));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_chains),const DeepCollectionEquality().hash(_methods),const DeepCollectionEquality().hash(_events));

@override
String toString() {
  return 'PlatformNamespace(chains: $chains, methods: $methods, events: $events)';
}


}

/// @nodoc
abstract mixin class _$PlatformNamespaceCopyWith<$Res> implements $PlatformNamespaceCopyWith<$Res> {
  factory _$PlatformNamespaceCopyWith(_PlatformNamespace value, $Res Function(_PlatformNamespace) _then) = __$PlatformNamespaceCopyWithImpl;
@override @useResult
$Res call({
 List<String> chains, List<String> methods, List<String> events
});




}
/// @nodoc
class __$PlatformNamespaceCopyWithImpl<$Res>
    implements _$PlatformNamespaceCopyWith<$Res> {
  __$PlatformNamespaceCopyWithImpl(this._self, this._then);

  final _PlatformNamespace _self;
  final $Res Function(_PlatformNamespace) _then;

/// Create a copy of PlatformNamespace
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? chains = null,Object? methods = null,Object? events = null,}) {
  return _then(_PlatformNamespace(
chains: null == chains ? _self._chains : chains // ignore: cast_nullable_to_non_nullable
as List<String>,methods: null == methods ? _self._methods : methods // ignore: cast_nullable_to_non_nullable
as List<String>,events: null == events ? _self._events : events // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$PlatformNamespaceWithAccounts {

 List<String> get chains; List<String> get accounts; List<String> get methods; List<String> get events;
/// Create a copy of PlatformNamespaceWithAccounts
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlatformNamespaceWithAccountsCopyWith<PlatformNamespaceWithAccounts> get copyWith => _$PlatformNamespaceWithAccountsCopyWithImpl<PlatformNamespaceWithAccounts>(this as PlatformNamespaceWithAccounts, _$identity);

  /// Serializes this PlatformNamespaceWithAccounts to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlatformNamespaceWithAccounts&&const DeepCollectionEquality().equals(other.chains, chains)&&const DeepCollectionEquality().equals(other.accounts, accounts)&&const DeepCollectionEquality().equals(other.methods, methods)&&const DeepCollectionEquality().equals(other.events, events));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(chains),const DeepCollectionEquality().hash(accounts),const DeepCollectionEquality().hash(methods),const DeepCollectionEquality().hash(events));

@override
String toString() {
  return 'PlatformNamespaceWithAccounts(chains: $chains, accounts: $accounts, methods: $methods, events: $events)';
}


}

/// @nodoc
abstract mixin class $PlatformNamespaceWithAccountsCopyWith<$Res>  {
  factory $PlatformNamespaceWithAccountsCopyWith(PlatformNamespaceWithAccounts value, $Res Function(PlatformNamespaceWithAccounts) _then) = _$PlatformNamespaceWithAccountsCopyWithImpl;
@useResult
$Res call({
 List<String> chains, List<String> accounts, List<String> methods, List<String> events
});




}
/// @nodoc
class _$PlatformNamespaceWithAccountsCopyWithImpl<$Res>
    implements $PlatformNamespaceWithAccountsCopyWith<$Res> {
  _$PlatformNamespaceWithAccountsCopyWithImpl(this._self, this._then);

  final PlatformNamespaceWithAccounts _self;
  final $Res Function(PlatformNamespaceWithAccounts) _then;

/// Create a copy of PlatformNamespaceWithAccounts
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? chains = null,Object? accounts = null,Object? methods = null,Object? events = null,}) {
  return _then(_self.copyWith(
chains: null == chains ? _self.chains : chains // ignore: cast_nullable_to_non_nullable
as List<String>,accounts: null == accounts ? _self.accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<String>,methods: null == methods ? _self.methods : methods // ignore: cast_nullable_to_non_nullable
as List<String>,events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [PlatformNamespaceWithAccounts].
extension PlatformNamespaceWithAccountsPatterns on PlatformNamespaceWithAccounts {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlatformNamespaceWithAccounts value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlatformNamespaceWithAccounts() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlatformNamespaceWithAccounts value)  $default,){
final _that = this;
switch (_that) {
case _PlatformNamespaceWithAccounts():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlatformNamespaceWithAccounts value)?  $default,){
final _that = this;
switch (_that) {
case _PlatformNamespaceWithAccounts() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> chains,  List<String> accounts,  List<String> methods,  List<String> events)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlatformNamespaceWithAccounts() when $default != null:
return $default(_that.chains,_that.accounts,_that.methods,_that.events);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> chains,  List<String> accounts,  List<String> methods,  List<String> events)  $default,) {final _that = this;
switch (_that) {
case _PlatformNamespaceWithAccounts():
return $default(_that.chains,_that.accounts,_that.methods,_that.events);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> chains,  List<String> accounts,  List<String> methods,  List<String> events)?  $default,) {final _that = this;
switch (_that) {
case _PlatformNamespaceWithAccounts() when $default != null:
return $default(_that.chains,_that.accounts,_that.methods,_that.events);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlatformNamespaceWithAccounts implements PlatformNamespaceWithAccounts {
  const _PlatformNamespaceWithAccounts({required final  List<String> chains, required final  List<String> accounts, required final  List<String> methods, required final  List<String> events}): _chains = chains,_accounts = accounts,_methods = methods,_events = events;
  factory _PlatformNamespaceWithAccounts.fromJson(Map<String, dynamic> json) => _$PlatformNamespaceWithAccountsFromJson(json);

 final  List<String> _chains;
@override List<String> get chains {
  if (_chains is EqualUnmodifiableListView) return _chains;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_chains);
}

 final  List<String> _accounts;
@override List<String> get accounts {
  if (_accounts is EqualUnmodifiableListView) return _accounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_accounts);
}

 final  List<String> _methods;
@override List<String> get methods {
  if (_methods is EqualUnmodifiableListView) return _methods;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_methods);
}

 final  List<String> _events;
@override List<String> get events {
  if (_events is EqualUnmodifiableListView) return _events;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_events);
}


/// Create a copy of PlatformNamespaceWithAccounts
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlatformNamespaceWithAccountsCopyWith<_PlatformNamespaceWithAccounts> get copyWith => __$PlatformNamespaceWithAccountsCopyWithImpl<_PlatformNamespaceWithAccounts>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlatformNamespaceWithAccountsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlatformNamespaceWithAccounts&&const DeepCollectionEquality().equals(other._chains, _chains)&&const DeepCollectionEquality().equals(other._accounts, _accounts)&&const DeepCollectionEquality().equals(other._methods, _methods)&&const DeepCollectionEquality().equals(other._events, _events));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_chains),const DeepCollectionEquality().hash(_accounts),const DeepCollectionEquality().hash(_methods),const DeepCollectionEquality().hash(_events));

@override
String toString() {
  return 'PlatformNamespaceWithAccounts(chains: $chains, accounts: $accounts, methods: $methods, events: $events)';
}


}

/// @nodoc
abstract mixin class _$PlatformNamespaceWithAccountsCopyWith<$Res> implements $PlatformNamespaceWithAccountsCopyWith<$Res> {
  factory _$PlatformNamespaceWithAccountsCopyWith(_PlatformNamespaceWithAccounts value, $Res Function(_PlatformNamespaceWithAccounts) _then) = __$PlatformNamespaceWithAccountsCopyWithImpl;
@override @useResult
$Res call({
 List<String> chains, List<String> accounts, List<String> methods, List<String> events
});




}
/// @nodoc
class __$PlatformNamespaceWithAccountsCopyWithImpl<$Res>
    implements _$PlatformNamespaceWithAccountsCopyWith<$Res> {
  __$PlatformNamespaceWithAccountsCopyWithImpl(this._self, this._then);

  final _PlatformNamespaceWithAccounts _self;
  final $Res Function(_PlatformNamespaceWithAccounts) _then;

/// Create a copy of PlatformNamespaceWithAccounts
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? chains = null,Object? accounts = null,Object? methods = null,Object? events = null,}) {
  return _then(_PlatformNamespaceWithAccounts(
chains: null == chains ? _self._chains : chains // ignore: cast_nullable_to_non_nullable
as List<String>,accounts: null == accounts ? _self._accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<String>,methods: null == methods ? _self._methods : methods // ignore: cast_nullable_to_non_nullable
as List<String>,events: null == events ? _self._events : events // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$PlatformMetaData {

 String get name; String get description; String get url; List<String> get icons; String get redirect;
/// Create a copy of PlatformMetaData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlatformMetaDataCopyWith<PlatformMetaData> get copyWith => _$PlatformMetaDataCopyWithImpl<PlatformMetaData>(this as PlatformMetaData, _$identity);

  /// Serializes this PlatformMetaData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlatformMetaData&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other.icons, icons)&&(identical(other.redirect, redirect) || other.redirect == redirect));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,description,url,const DeepCollectionEquality().hash(icons),redirect);

@override
String toString() {
  return 'PlatformMetaData(name: $name, description: $description, url: $url, icons: $icons, redirect: $redirect)';
}


}

/// @nodoc
abstract mixin class $PlatformMetaDataCopyWith<$Res>  {
  factory $PlatformMetaDataCopyWith(PlatformMetaData value, $Res Function(PlatformMetaData) _then) = _$PlatformMetaDataCopyWithImpl;
@useResult
$Res call({
 String name, String description, String url, List<String> icons, String redirect
});




}
/// @nodoc
class _$PlatformMetaDataCopyWithImpl<$Res>
    implements $PlatformMetaDataCopyWith<$Res> {
  _$PlatformMetaDataCopyWithImpl(this._self, this._then);

  final PlatformMetaData _self;
  final $Res Function(PlatformMetaData) _then;

/// Create a copy of PlatformMetaData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? description = null,Object? url = null,Object? icons = null,Object? redirect = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,icons: null == icons ? _self.icons : icons // ignore: cast_nullable_to_non_nullable
as List<String>,redirect: null == redirect ? _self.redirect : redirect // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PlatformMetaData].
extension PlatformMetaDataPatterns on PlatformMetaData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlatformMetaData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlatformMetaData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlatformMetaData value)  $default,){
final _that = this;
switch (_that) {
case _PlatformMetaData():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlatformMetaData value)?  $default,){
final _that = this;
switch (_that) {
case _PlatformMetaData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String description,  String url,  List<String> icons,  String redirect)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlatformMetaData() when $default != null:
return $default(_that.name,_that.description,_that.url,_that.icons,_that.redirect);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String description,  String url,  List<String> icons,  String redirect)  $default,) {final _that = this;
switch (_that) {
case _PlatformMetaData():
return $default(_that.name,_that.description,_that.url,_that.icons,_that.redirect);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String description,  String url,  List<String> icons,  String redirect)?  $default,) {final _that = this;
switch (_that) {
case _PlatformMetaData() when $default != null:
return $default(_that.name,_that.description,_that.url,_that.icons,_that.redirect);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlatformMetaData implements PlatformMetaData {
  const _PlatformMetaData({required this.name, required this.description, required this.url, required final  List<String> icons, required this.redirect}): _icons = icons;
  factory _PlatformMetaData.fromJson(Map<String, dynamic> json) => _$PlatformMetaDataFromJson(json);

@override final  String name;
@override final  String description;
@override final  String url;
 final  List<String> _icons;
@override List<String> get icons {
  if (_icons is EqualUnmodifiableListView) return _icons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_icons);
}

@override final  String redirect;

/// Create a copy of PlatformMetaData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlatformMetaDataCopyWith<_PlatformMetaData> get copyWith => __$PlatformMetaDataCopyWithImpl<_PlatformMetaData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlatformMetaDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlatformMetaData&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other._icons, _icons)&&(identical(other.redirect, redirect) || other.redirect == redirect));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,description,url,const DeepCollectionEquality().hash(_icons),redirect);

@override
String toString() {
  return 'PlatformMetaData(name: $name, description: $description, url: $url, icons: $icons, redirect: $redirect)';
}


}

/// @nodoc
abstract mixin class _$PlatformMetaDataCopyWith<$Res> implements $PlatformMetaDataCopyWith<$Res> {
  factory _$PlatformMetaDataCopyWith(_PlatformMetaData value, $Res Function(_PlatformMetaData) _then) = __$PlatformMetaDataCopyWithImpl;
@override @useResult
$Res call({
 String name, String description, String url, List<String> icons, String redirect
});




}
/// @nodoc
class __$PlatformMetaDataCopyWithImpl<$Res>
    implements _$PlatformMetaDataCopyWith<$Res> {
  __$PlatformMetaDataCopyWithImpl(this._self, this._then);

  final _PlatformMetaData _self;
  final $Res Function(_PlatformMetaData) _then;

/// Create a copy of PlatformMetaData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? description = null,Object? url = null,Object? icons = null,Object? redirect = null,}) {
  return _then(_PlatformMetaData(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,icons: null == icons ? _self._icons : icons // ignore: cast_nullable_to_non_nullable
as List<String>,redirect: null == redirect ? _self.redirect : redirect // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
