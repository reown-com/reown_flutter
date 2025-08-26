// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rust_sign_client_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SessionProposal {

 int get id; String get pairingTopic; String get pairingSymKey;// hex encoded string
 String get proposerPublicKey;// hex encoded string
 List<Map<String, dynamic>> get relays; Map<String, Map<String, dynamic>> get requiredNamespaces; Map<String, Map<String, dynamic>>? get optionalNamespaces; Map<String, dynamic> get metadata; Map<String, String>? get sessionProperties; Map<String, String>? get scopedProperties; int? get expiry;
/// Create a copy of SessionProposal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionProposalCopyWith<SessionProposal> get copyWith => _$SessionProposalCopyWithImpl<SessionProposal>(this as SessionProposal, _$identity);

  /// Serializes this SessionProposal to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionProposal&&(identical(other.id, id) || other.id == id)&&(identical(other.pairingTopic, pairingTopic) || other.pairingTopic == pairingTopic)&&(identical(other.pairingSymKey, pairingSymKey) || other.pairingSymKey == pairingSymKey)&&(identical(other.proposerPublicKey, proposerPublicKey) || other.proposerPublicKey == proposerPublicKey)&&const DeepCollectionEquality().equals(other.relays, relays)&&const DeepCollectionEquality().equals(other.requiredNamespaces, requiredNamespaces)&&const DeepCollectionEquality().equals(other.optionalNamespaces, optionalNamespaces)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&const DeepCollectionEquality().equals(other.sessionProperties, sessionProperties)&&const DeepCollectionEquality().equals(other.scopedProperties, scopedProperties)&&(identical(other.expiry, expiry) || other.expiry == expiry));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,pairingTopic,pairingSymKey,proposerPublicKey,const DeepCollectionEquality().hash(relays),const DeepCollectionEquality().hash(requiredNamespaces),const DeepCollectionEquality().hash(optionalNamespaces),const DeepCollectionEquality().hash(metadata),const DeepCollectionEquality().hash(sessionProperties),const DeepCollectionEquality().hash(scopedProperties),expiry);

@override
String toString() {
  return 'SessionProposal(id: $id, pairingTopic: $pairingTopic, pairingSymKey: $pairingSymKey, proposerPublicKey: $proposerPublicKey, relays: $relays, requiredNamespaces: $requiredNamespaces, optionalNamespaces: $optionalNamespaces, metadata: $metadata, sessionProperties: $sessionProperties, scopedProperties: $scopedProperties, expiry: $expiry)';
}


}

/// @nodoc
abstract mixin class $SessionProposalCopyWith<$Res>  {
  factory $SessionProposalCopyWith(SessionProposal value, $Res Function(SessionProposal) _then) = _$SessionProposalCopyWithImpl;
@useResult
$Res call({
 int id, String pairingTopic, String pairingSymKey, String proposerPublicKey, List<Map<String, dynamic>> relays, Map<String, Map<String, dynamic>> requiredNamespaces, Map<String, Map<String, dynamic>>? optionalNamespaces, Map<String, dynamic> metadata, Map<String, String>? sessionProperties, Map<String, String>? scopedProperties, int? expiry
});




}
/// @nodoc
class _$SessionProposalCopyWithImpl<$Res>
    implements $SessionProposalCopyWith<$Res> {
  _$SessionProposalCopyWithImpl(this._self, this._then);

  final SessionProposal _self;
  final $Res Function(SessionProposal) _then;

/// Create a copy of SessionProposal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? pairingTopic = null,Object? pairingSymKey = null,Object? proposerPublicKey = null,Object? relays = null,Object? requiredNamespaces = null,Object? optionalNamespaces = freezed,Object? metadata = null,Object? sessionProperties = freezed,Object? scopedProperties = freezed,Object? expiry = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,pairingTopic: null == pairingTopic ? _self.pairingTopic : pairingTopic // ignore: cast_nullable_to_non_nullable
as String,pairingSymKey: null == pairingSymKey ? _self.pairingSymKey : pairingSymKey // ignore: cast_nullable_to_non_nullable
as String,proposerPublicKey: null == proposerPublicKey ? _self.proposerPublicKey : proposerPublicKey // ignore: cast_nullable_to_non_nullable
as String,relays: null == relays ? _self.relays : relays // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,requiredNamespaces: null == requiredNamespaces ? _self.requiredNamespaces : requiredNamespaces // ignore: cast_nullable_to_non_nullable
as Map<String, Map<String, dynamic>>,optionalNamespaces: freezed == optionalNamespaces ? _self.optionalNamespaces : optionalNamespaces // ignore: cast_nullable_to_non_nullable
as Map<String, Map<String, dynamic>>?,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,sessionProperties: freezed == sessionProperties ? _self.sessionProperties : sessionProperties // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,scopedProperties: freezed == scopedProperties ? _self.scopedProperties : scopedProperties // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,expiry: freezed == expiry ? _self.expiry : expiry // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [SessionProposal].
extension SessionProposalPatterns on SessionProposal {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionProposal value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionProposal() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionProposal value)  $default,){
final _that = this;
switch (_that) {
case _SessionProposal():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionProposal value)?  $default,){
final _that = this;
switch (_that) {
case _SessionProposal() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String pairingTopic,  String pairingSymKey,  String proposerPublicKey,  List<Map<String, dynamic>> relays,  Map<String, Map<String, dynamic>> requiredNamespaces,  Map<String, Map<String, dynamic>>? optionalNamespaces,  Map<String, dynamic> metadata,  Map<String, String>? sessionProperties,  Map<String, String>? scopedProperties,  int? expiry)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionProposal() when $default != null:
return $default(_that.id,_that.pairingTopic,_that.pairingSymKey,_that.proposerPublicKey,_that.relays,_that.requiredNamespaces,_that.optionalNamespaces,_that.metadata,_that.sessionProperties,_that.scopedProperties,_that.expiry);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String pairingTopic,  String pairingSymKey,  String proposerPublicKey,  List<Map<String, dynamic>> relays,  Map<String, Map<String, dynamic>> requiredNamespaces,  Map<String, Map<String, dynamic>>? optionalNamespaces,  Map<String, dynamic> metadata,  Map<String, String>? sessionProperties,  Map<String, String>? scopedProperties,  int? expiry)  $default,) {final _that = this;
switch (_that) {
case _SessionProposal():
return $default(_that.id,_that.pairingTopic,_that.pairingSymKey,_that.proposerPublicKey,_that.relays,_that.requiredNamespaces,_that.optionalNamespaces,_that.metadata,_that.sessionProperties,_that.scopedProperties,_that.expiry);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String pairingTopic,  String pairingSymKey,  String proposerPublicKey,  List<Map<String, dynamic>> relays,  Map<String, Map<String, dynamic>> requiredNamespaces,  Map<String, Map<String, dynamic>>? optionalNamespaces,  Map<String, dynamic> metadata,  Map<String, String>? sessionProperties,  Map<String, String>? scopedProperties,  int? expiry)?  $default,) {final _that = this;
switch (_that) {
case _SessionProposal() when $default != null:
return $default(_that.id,_that.pairingTopic,_that.pairingSymKey,_that.proposerPublicKey,_that.relays,_that.requiredNamespaces,_that.optionalNamespaces,_that.metadata,_that.sessionProperties,_that.scopedProperties,_that.expiry);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SessionProposal implements SessionProposal {
  const _SessionProposal({required this.id, required this.pairingTopic, required this.pairingSymKey, required this.proposerPublicKey, required final  List<Map<String, dynamic>> relays, required final  Map<String, Map<String, dynamic>> requiredNamespaces, final  Map<String, Map<String, dynamic>>? optionalNamespaces, required final  Map<String, dynamic> metadata, final  Map<String, String>? sessionProperties, final  Map<String, String>? scopedProperties, this.expiry}): _relays = relays,_requiredNamespaces = requiredNamespaces,_optionalNamespaces = optionalNamespaces,_metadata = metadata,_sessionProperties = sessionProperties,_scopedProperties = scopedProperties;
  factory _SessionProposal.fromJson(Map<String, dynamic> json) => _$SessionProposalFromJson(json);

@override final  int id;
@override final  String pairingTopic;
@override final  String pairingSymKey;
// hex encoded string
@override final  String proposerPublicKey;
// hex encoded string
 final  List<Map<String, dynamic>> _relays;
// hex encoded string
@override List<Map<String, dynamic>> get relays {
  if (_relays is EqualUnmodifiableListView) return _relays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_relays);
}

 final  Map<String, Map<String, dynamic>> _requiredNamespaces;
@override Map<String, Map<String, dynamic>> get requiredNamespaces {
  if (_requiredNamespaces is EqualUnmodifiableMapView) return _requiredNamespaces;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_requiredNamespaces);
}

 final  Map<String, Map<String, dynamic>>? _optionalNamespaces;
@override Map<String, Map<String, dynamic>>? get optionalNamespaces {
  final value = _optionalNamespaces;
  if (value == null) return null;
  if (_optionalNamespaces is EqualUnmodifiableMapView) return _optionalNamespaces;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, dynamic> _metadata;
@override Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}

 final  Map<String, String>? _sessionProperties;
@override Map<String, String>? get sessionProperties {
  final value = _sessionProperties;
  if (value == null) return null;
  if (_sessionProperties is EqualUnmodifiableMapView) return _sessionProperties;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, String>? _scopedProperties;
@override Map<String, String>? get scopedProperties {
  final value = _scopedProperties;
  if (value == null) return null;
  if (_scopedProperties is EqualUnmodifiableMapView) return _scopedProperties;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  int? expiry;

/// Create a copy of SessionProposal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionProposalCopyWith<_SessionProposal> get copyWith => __$SessionProposalCopyWithImpl<_SessionProposal>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SessionProposalToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionProposal&&(identical(other.id, id) || other.id == id)&&(identical(other.pairingTopic, pairingTopic) || other.pairingTopic == pairingTopic)&&(identical(other.pairingSymKey, pairingSymKey) || other.pairingSymKey == pairingSymKey)&&(identical(other.proposerPublicKey, proposerPublicKey) || other.proposerPublicKey == proposerPublicKey)&&const DeepCollectionEquality().equals(other._relays, _relays)&&const DeepCollectionEquality().equals(other._requiredNamespaces, _requiredNamespaces)&&const DeepCollectionEquality().equals(other._optionalNamespaces, _optionalNamespaces)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&const DeepCollectionEquality().equals(other._sessionProperties, _sessionProperties)&&const DeepCollectionEquality().equals(other._scopedProperties, _scopedProperties)&&(identical(other.expiry, expiry) || other.expiry == expiry));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,pairingTopic,pairingSymKey,proposerPublicKey,const DeepCollectionEquality().hash(_relays),const DeepCollectionEquality().hash(_requiredNamespaces),const DeepCollectionEquality().hash(_optionalNamespaces),const DeepCollectionEquality().hash(_metadata),const DeepCollectionEquality().hash(_sessionProperties),const DeepCollectionEquality().hash(_scopedProperties),expiry);

@override
String toString() {
  return 'SessionProposal(id: $id, pairingTopic: $pairingTopic, pairingSymKey: $pairingSymKey, proposerPublicKey: $proposerPublicKey, relays: $relays, requiredNamespaces: $requiredNamespaces, optionalNamespaces: $optionalNamespaces, metadata: $metadata, sessionProperties: $sessionProperties, scopedProperties: $scopedProperties, expiry: $expiry)';
}


}

/// @nodoc
abstract mixin class _$SessionProposalCopyWith<$Res> implements $SessionProposalCopyWith<$Res> {
  factory _$SessionProposalCopyWith(_SessionProposal value, $Res Function(_SessionProposal) _then) = __$SessionProposalCopyWithImpl;
@override @useResult
$Res call({
 int id, String pairingTopic, String pairingSymKey, String proposerPublicKey, List<Map<String, dynamic>> relays, Map<String, Map<String, dynamic>> requiredNamespaces, Map<String, Map<String, dynamic>>? optionalNamespaces, Map<String, dynamic> metadata, Map<String, String>? sessionProperties, Map<String, String>? scopedProperties, int? expiry
});




}
/// @nodoc
class __$SessionProposalCopyWithImpl<$Res>
    implements _$SessionProposalCopyWith<$Res> {
  __$SessionProposalCopyWithImpl(this._self, this._then);

  final _SessionProposal _self;
  final $Res Function(_SessionProposal) _then;

/// Create a copy of SessionProposal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? pairingTopic = null,Object? pairingSymKey = null,Object? proposerPublicKey = null,Object? relays = null,Object? requiredNamespaces = null,Object? optionalNamespaces = freezed,Object? metadata = null,Object? sessionProperties = freezed,Object? scopedProperties = freezed,Object? expiry = freezed,}) {
  return _then(_SessionProposal(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,pairingTopic: null == pairingTopic ? _self.pairingTopic : pairingTopic // ignore: cast_nullable_to_non_nullable
as String,pairingSymKey: null == pairingSymKey ? _self.pairingSymKey : pairingSymKey // ignore: cast_nullable_to_non_nullable
as String,proposerPublicKey: null == proposerPublicKey ? _self.proposerPublicKey : proposerPublicKey // ignore: cast_nullable_to_non_nullable
as String,relays: null == relays ? _self._relays : relays // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,requiredNamespaces: null == requiredNamespaces ? _self._requiredNamespaces : requiredNamespaces // ignore: cast_nullable_to_non_nullable
as Map<String, Map<String, dynamic>>,optionalNamespaces: freezed == optionalNamespaces ? _self._optionalNamespaces : optionalNamespaces // ignore: cast_nullable_to_non_nullable
as Map<String, Map<String, dynamic>>?,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,sessionProperties: freezed == sessionProperties ? _self._sessionProperties : sessionProperties // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,scopedProperties: freezed == scopedProperties ? _self._scopedProperties : scopedProperties // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,expiry: freezed == expiry ? _self.expiry : expiry // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$ApproveResult {

 String get sessionSymKey;// hex encoded string
 String get selfPublicKey;
/// Create a copy of ApproveResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApproveResultCopyWith<ApproveResult> get copyWith => _$ApproveResultCopyWithImpl<ApproveResult>(this as ApproveResult, _$identity);

  /// Serializes this ApproveResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApproveResult&&(identical(other.sessionSymKey, sessionSymKey) || other.sessionSymKey == sessionSymKey)&&(identical(other.selfPublicKey, selfPublicKey) || other.selfPublicKey == selfPublicKey));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sessionSymKey,selfPublicKey);

@override
String toString() {
  return 'ApproveResult(sessionSymKey: $sessionSymKey, selfPublicKey: $selfPublicKey)';
}


}

/// @nodoc
abstract mixin class $ApproveResultCopyWith<$Res>  {
  factory $ApproveResultCopyWith(ApproveResult value, $Res Function(ApproveResult) _then) = _$ApproveResultCopyWithImpl;
@useResult
$Res call({
 String sessionSymKey, String selfPublicKey
});




}
/// @nodoc
class _$ApproveResultCopyWithImpl<$Res>
    implements $ApproveResultCopyWith<$Res> {
  _$ApproveResultCopyWithImpl(this._self, this._then);

  final ApproveResult _self;
  final $Res Function(ApproveResult) _then;

/// Create a copy of ApproveResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionSymKey = null,Object? selfPublicKey = null,}) {
  return _then(_self.copyWith(
sessionSymKey: null == sessionSymKey ? _self.sessionSymKey : sessionSymKey // ignore: cast_nullable_to_non_nullable
as String,selfPublicKey: null == selfPublicKey ? _self.selfPublicKey : selfPublicKey // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ApproveResult].
extension ApproveResultPatterns on ApproveResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApproveResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApproveResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApproveResult value)  $default,){
final _that = this;
switch (_that) {
case _ApproveResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApproveResult value)?  $default,){
final _that = this;
switch (_that) {
case _ApproveResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sessionSymKey,  String selfPublicKey)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApproveResult() when $default != null:
return $default(_that.sessionSymKey,_that.selfPublicKey);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sessionSymKey,  String selfPublicKey)  $default,) {final _that = this;
switch (_that) {
case _ApproveResult():
return $default(_that.sessionSymKey,_that.selfPublicKey);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sessionSymKey,  String selfPublicKey)?  $default,) {final _that = this;
switch (_that) {
case _ApproveResult() when $default != null:
return $default(_that.sessionSymKey,_that.selfPublicKey);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable()
class _ApproveResult implements ApproveResult {
  const _ApproveResult({required this.sessionSymKey, required this.selfPublicKey});
  factory _ApproveResult.fromJson(Map<String, dynamic> json) => _$ApproveResultFromJson(json);

@override final  String sessionSymKey;
// hex encoded string
@override final  String selfPublicKey;

/// Create a copy of ApproveResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApproveResultCopyWith<_ApproveResult> get copyWith => __$ApproveResultCopyWithImpl<_ApproveResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ApproveResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApproveResult&&(identical(other.sessionSymKey, sessionSymKey) || other.sessionSymKey == sessionSymKey)&&(identical(other.selfPublicKey, selfPublicKey) || other.selfPublicKey == selfPublicKey));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sessionSymKey,selfPublicKey);

@override
String toString() {
  return 'ApproveResult(sessionSymKey: $sessionSymKey, selfPublicKey: $selfPublicKey)';
}


}

/// @nodoc
abstract mixin class _$ApproveResultCopyWith<$Res> implements $ApproveResultCopyWith<$Res> {
  factory _$ApproveResultCopyWith(_ApproveResult value, $Res Function(_ApproveResult) _then) = __$ApproveResultCopyWithImpl;
@override @useResult
$Res call({
 String sessionSymKey, String selfPublicKey
});




}
/// @nodoc
class __$ApproveResultCopyWithImpl<$Res>
    implements _$ApproveResultCopyWith<$Res> {
  __$ApproveResultCopyWithImpl(this._self, this._then);

  final _ApproveResult _self;
  final $Res Function(_ApproveResult) _then;

/// Create a copy of ApproveResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionSymKey = null,Object? selfPublicKey = null,}) {
  return _then(_ApproveResult(
sessionSymKey: null == sessionSymKey ? _self.sessionSymKey : sessionSymKey // ignore: cast_nullable_to_non_nullable
as String,selfPublicKey: null == selfPublicKey ? _self.selfPublicKey : selfPublicKey // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
