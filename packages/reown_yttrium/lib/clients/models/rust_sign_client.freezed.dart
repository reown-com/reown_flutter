// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rust_sign_client.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SessionProposalFfi {

 String get id; String get topic; List<int> get pairingSymKey; List<int> get proposerPublicKey; List<Map<String, dynamic>> get relays; Map<String, Map<String, dynamic>> get requiredNamespaces; Map<String, Map<String, dynamic>>? get optionalNamespaces; Map<String, dynamic> get metadata; Map<String, String>? get sessionProperties; Map<String, String>? get scopedProperties; int? get expiryTimestamp;
/// Create a copy of SessionProposalFfi
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionProposalFfiCopyWith<SessionProposalFfi> get copyWith => _$SessionProposalFfiCopyWithImpl<SessionProposalFfi>(this as SessionProposalFfi, _$identity);

  /// Serializes this SessionProposalFfi to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionProposalFfi&&(identical(other.id, id) || other.id == id)&&(identical(other.topic, topic) || other.topic == topic)&&const DeepCollectionEquality().equals(other.pairingSymKey, pairingSymKey)&&const DeepCollectionEquality().equals(other.proposerPublicKey, proposerPublicKey)&&const DeepCollectionEquality().equals(other.relays, relays)&&const DeepCollectionEquality().equals(other.requiredNamespaces, requiredNamespaces)&&const DeepCollectionEquality().equals(other.optionalNamespaces, optionalNamespaces)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&const DeepCollectionEquality().equals(other.sessionProperties, sessionProperties)&&const DeepCollectionEquality().equals(other.scopedProperties, scopedProperties)&&(identical(other.expiryTimestamp, expiryTimestamp) || other.expiryTimestamp == expiryTimestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,topic,const DeepCollectionEquality().hash(pairingSymKey),const DeepCollectionEquality().hash(proposerPublicKey),const DeepCollectionEquality().hash(relays),const DeepCollectionEquality().hash(requiredNamespaces),const DeepCollectionEquality().hash(optionalNamespaces),const DeepCollectionEquality().hash(metadata),const DeepCollectionEquality().hash(sessionProperties),const DeepCollectionEquality().hash(scopedProperties),expiryTimestamp);

@override
String toString() {
  return 'SessionProposalFfi(id: $id, topic: $topic, pairingSymKey: $pairingSymKey, proposerPublicKey: $proposerPublicKey, relays: $relays, requiredNamespaces: $requiredNamespaces, optionalNamespaces: $optionalNamespaces, metadata: $metadata, sessionProperties: $sessionProperties, scopedProperties: $scopedProperties, expiryTimestamp: $expiryTimestamp)';
}


}

/// @nodoc
abstract mixin class $SessionProposalFfiCopyWith<$Res>  {
  factory $SessionProposalFfiCopyWith(SessionProposalFfi value, $Res Function(SessionProposalFfi) _then) = _$SessionProposalFfiCopyWithImpl;
@useResult
$Res call({
 String id, String topic, List<int> pairingSymKey, List<int> proposerPublicKey, List<Map<String, dynamic>> relays, Map<String, Map<String, dynamic>> requiredNamespaces, Map<String, Map<String, dynamic>>? optionalNamespaces, Map<String, dynamic> metadata, Map<String, String>? sessionProperties, Map<String, String>? scopedProperties, int? expiryTimestamp
});




}
/// @nodoc
class _$SessionProposalFfiCopyWithImpl<$Res>
    implements $SessionProposalFfiCopyWith<$Res> {
  _$SessionProposalFfiCopyWithImpl(this._self, this._then);

  final SessionProposalFfi _self;
  final $Res Function(SessionProposalFfi) _then;

/// Create a copy of SessionProposalFfi
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? topic = null,Object? pairingSymKey = null,Object? proposerPublicKey = null,Object? relays = null,Object? requiredNamespaces = null,Object? optionalNamespaces = freezed,Object? metadata = null,Object? sessionProperties = freezed,Object? scopedProperties = freezed,Object? expiryTimestamp = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,pairingSymKey: null == pairingSymKey ? _self.pairingSymKey : pairingSymKey // ignore: cast_nullable_to_non_nullable
as List<int>,proposerPublicKey: null == proposerPublicKey ? _self.proposerPublicKey : proposerPublicKey // ignore: cast_nullable_to_non_nullable
as List<int>,relays: null == relays ? _self.relays : relays // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,requiredNamespaces: null == requiredNamespaces ? _self.requiredNamespaces : requiredNamespaces // ignore: cast_nullable_to_non_nullable
as Map<String, Map<String, dynamic>>,optionalNamespaces: freezed == optionalNamespaces ? _self.optionalNamespaces : optionalNamespaces // ignore: cast_nullable_to_non_nullable
as Map<String, Map<String, dynamic>>?,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,sessionProperties: freezed == sessionProperties ? _self.sessionProperties : sessionProperties // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,scopedProperties: freezed == scopedProperties ? _self.scopedProperties : scopedProperties // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,expiryTimestamp: freezed == expiryTimestamp ? _self.expiryTimestamp : expiryTimestamp // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [SessionProposalFfi].
extension SessionProposalFfiPatterns on SessionProposalFfi {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionProposalFfi value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionProposalFfi() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionProposalFfi value)  $default,){
final _that = this;
switch (_that) {
case _SessionProposalFfi():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionProposalFfi value)?  $default,){
final _that = this;
switch (_that) {
case _SessionProposalFfi() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String topic,  List<int> pairingSymKey,  List<int> proposerPublicKey,  List<Map<String, dynamic>> relays,  Map<String, Map<String, dynamic>> requiredNamespaces,  Map<String, Map<String, dynamic>>? optionalNamespaces,  Map<String, dynamic> metadata,  Map<String, String>? sessionProperties,  Map<String, String>? scopedProperties,  int? expiryTimestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionProposalFfi() when $default != null:
return $default(_that.id,_that.topic,_that.pairingSymKey,_that.proposerPublicKey,_that.relays,_that.requiredNamespaces,_that.optionalNamespaces,_that.metadata,_that.sessionProperties,_that.scopedProperties,_that.expiryTimestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String topic,  List<int> pairingSymKey,  List<int> proposerPublicKey,  List<Map<String, dynamic>> relays,  Map<String, Map<String, dynamic>> requiredNamespaces,  Map<String, Map<String, dynamic>>? optionalNamespaces,  Map<String, dynamic> metadata,  Map<String, String>? sessionProperties,  Map<String, String>? scopedProperties,  int? expiryTimestamp)  $default,) {final _that = this;
switch (_that) {
case _SessionProposalFfi():
return $default(_that.id,_that.topic,_that.pairingSymKey,_that.proposerPublicKey,_that.relays,_that.requiredNamespaces,_that.optionalNamespaces,_that.metadata,_that.sessionProperties,_that.scopedProperties,_that.expiryTimestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String topic,  List<int> pairingSymKey,  List<int> proposerPublicKey,  List<Map<String, dynamic>> relays,  Map<String, Map<String, dynamic>> requiredNamespaces,  Map<String, Map<String, dynamic>>? optionalNamespaces,  Map<String, dynamic> metadata,  Map<String, String>? sessionProperties,  Map<String, String>? scopedProperties,  int? expiryTimestamp)?  $default,) {final _that = this;
switch (_that) {
case _SessionProposalFfi() when $default != null:
return $default(_that.id,_that.topic,_that.pairingSymKey,_that.proposerPublicKey,_that.relays,_that.requiredNamespaces,_that.optionalNamespaces,_that.metadata,_that.sessionProperties,_that.scopedProperties,_that.expiryTimestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SessionProposalFfi implements SessionProposalFfi {
  const _SessionProposalFfi({required this.id, required this.topic, required final  List<int> pairingSymKey, required final  List<int> proposerPublicKey, required final  List<Map<String, dynamic>> relays, required final  Map<String, Map<String, dynamic>> requiredNamespaces, final  Map<String, Map<String, dynamic>>? optionalNamespaces, required final  Map<String, dynamic> metadata, final  Map<String, String>? sessionProperties, final  Map<String, String>? scopedProperties, this.expiryTimestamp}): _pairingSymKey = pairingSymKey,_proposerPublicKey = proposerPublicKey,_relays = relays,_requiredNamespaces = requiredNamespaces,_optionalNamespaces = optionalNamespaces,_metadata = metadata,_sessionProperties = sessionProperties,_scopedProperties = scopedProperties;
  factory _SessionProposalFfi.fromJson(Map<String, dynamic> json) => _$SessionProposalFfiFromJson(json);

@override final  String id;
@override final  String topic;
 final  List<int> _pairingSymKey;
@override List<int> get pairingSymKey {
  if (_pairingSymKey is EqualUnmodifiableListView) return _pairingSymKey;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pairingSymKey);
}

 final  List<int> _proposerPublicKey;
@override List<int> get proposerPublicKey {
  if (_proposerPublicKey is EqualUnmodifiableListView) return _proposerPublicKey;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_proposerPublicKey);
}

 final  List<Map<String, dynamic>> _relays;
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

@override final  int? expiryTimestamp;

/// Create a copy of SessionProposalFfi
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionProposalFfiCopyWith<_SessionProposalFfi> get copyWith => __$SessionProposalFfiCopyWithImpl<_SessionProposalFfi>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SessionProposalFfiToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionProposalFfi&&(identical(other.id, id) || other.id == id)&&(identical(other.topic, topic) || other.topic == topic)&&const DeepCollectionEquality().equals(other._pairingSymKey, _pairingSymKey)&&const DeepCollectionEquality().equals(other._proposerPublicKey, _proposerPublicKey)&&const DeepCollectionEquality().equals(other._relays, _relays)&&const DeepCollectionEquality().equals(other._requiredNamespaces, _requiredNamespaces)&&const DeepCollectionEquality().equals(other._optionalNamespaces, _optionalNamespaces)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&const DeepCollectionEquality().equals(other._sessionProperties, _sessionProperties)&&const DeepCollectionEquality().equals(other._scopedProperties, _scopedProperties)&&(identical(other.expiryTimestamp, expiryTimestamp) || other.expiryTimestamp == expiryTimestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,topic,const DeepCollectionEquality().hash(_pairingSymKey),const DeepCollectionEquality().hash(_proposerPublicKey),const DeepCollectionEquality().hash(_relays),const DeepCollectionEquality().hash(_requiredNamespaces),const DeepCollectionEquality().hash(_optionalNamespaces),const DeepCollectionEquality().hash(_metadata),const DeepCollectionEquality().hash(_sessionProperties),const DeepCollectionEquality().hash(_scopedProperties),expiryTimestamp);

@override
String toString() {
  return 'SessionProposalFfi(id: $id, topic: $topic, pairingSymKey: $pairingSymKey, proposerPublicKey: $proposerPublicKey, relays: $relays, requiredNamespaces: $requiredNamespaces, optionalNamespaces: $optionalNamespaces, metadata: $metadata, sessionProperties: $sessionProperties, scopedProperties: $scopedProperties, expiryTimestamp: $expiryTimestamp)';
}


}

/// @nodoc
abstract mixin class _$SessionProposalFfiCopyWith<$Res> implements $SessionProposalFfiCopyWith<$Res> {
  factory _$SessionProposalFfiCopyWith(_SessionProposalFfi value, $Res Function(_SessionProposalFfi) _then) = __$SessionProposalFfiCopyWithImpl;
@override @useResult
$Res call({
 String id, String topic, List<int> pairingSymKey, List<int> proposerPublicKey, List<Map<String, dynamic>> relays, Map<String, Map<String, dynamic>> requiredNamespaces, Map<String, Map<String, dynamic>>? optionalNamespaces, Map<String, dynamic> metadata, Map<String, String>? sessionProperties, Map<String, String>? scopedProperties, int? expiryTimestamp
});




}
/// @nodoc
class __$SessionProposalFfiCopyWithImpl<$Res>
    implements _$SessionProposalFfiCopyWith<$Res> {
  __$SessionProposalFfiCopyWithImpl(this._self, this._then);

  final _SessionProposalFfi _self;
  final $Res Function(_SessionProposalFfi) _then;

/// Create a copy of SessionProposalFfi
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? topic = null,Object? pairingSymKey = null,Object? proposerPublicKey = null,Object? relays = null,Object? requiredNamespaces = null,Object? optionalNamespaces = freezed,Object? metadata = null,Object? sessionProperties = freezed,Object? scopedProperties = freezed,Object? expiryTimestamp = freezed,}) {
  return _then(_SessionProposalFfi(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,pairingSymKey: null == pairingSymKey ? _self._pairingSymKey : pairingSymKey // ignore: cast_nullable_to_non_nullable
as List<int>,proposerPublicKey: null == proposerPublicKey ? _self._proposerPublicKey : proposerPublicKey // ignore: cast_nullable_to_non_nullable
as List<int>,relays: null == relays ? _self._relays : relays // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,requiredNamespaces: null == requiredNamespaces ? _self._requiredNamespaces : requiredNamespaces // ignore: cast_nullable_to_non_nullable
as Map<String, Map<String, dynamic>>,optionalNamespaces: freezed == optionalNamespaces ? _self._optionalNamespaces : optionalNamespaces // ignore: cast_nullable_to_non_nullable
as Map<String, Map<String, dynamic>>?,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,sessionProperties: freezed == sessionProperties ? _self._sessionProperties : sessionProperties // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,scopedProperties: freezed == scopedProperties ? _self._scopedProperties : scopedProperties // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,expiryTimestamp: freezed == expiryTimestamp ? _self.expiryTimestamp : expiryTimestamp // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$SettleNamespaceFfi {

 List<String> get accounts; List<String> get methods; List<String> get events; List<String> get chains;
/// Create a copy of SettleNamespaceFfi
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettleNamespaceFfiCopyWith<SettleNamespaceFfi> get copyWith => _$SettleNamespaceFfiCopyWithImpl<SettleNamespaceFfi>(this as SettleNamespaceFfi, _$identity);

  /// Serializes this SettleNamespaceFfi to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettleNamespaceFfi&&const DeepCollectionEquality().equals(other.accounts, accounts)&&const DeepCollectionEquality().equals(other.methods, methods)&&const DeepCollectionEquality().equals(other.events, events)&&const DeepCollectionEquality().equals(other.chains, chains));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(accounts),const DeepCollectionEquality().hash(methods),const DeepCollectionEquality().hash(events),const DeepCollectionEquality().hash(chains));

@override
String toString() {
  return 'SettleNamespaceFfi(accounts: $accounts, methods: $methods, events: $events, chains: $chains)';
}


}

/// @nodoc
abstract mixin class $SettleNamespaceFfiCopyWith<$Res>  {
  factory $SettleNamespaceFfiCopyWith(SettleNamespaceFfi value, $Res Function(SettleNamespaceFfi) _then) = _$SettleNamespaceFfiCopyWithImpl;
@useResult
$Res call({
 List<String> accounts, List<String> methods, List<String> events, List<String> chains
});




}
/// @nodoc
class _$SettleNamespaceFfiCopyWithImpl<$Res>
    implements $SettleNamespaceFfiCopyWith<$Res> {
  _$SettleNamespaceFfiCopyWithImpl(this._self, this._then);

  final SettleNamespaceFfi _self;
  final $Res Function(SettleNamespaceFfi) _then;

/// Create a copy of SettleNamespaceFfi
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accounts = null,Object? methods = null,Object? events = null,Object? chains = null,}) {
  return _then(_self.copyWith(
accounts: null == accounts ? _self.accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<String>,methods: null == methods ? _self.methods : methods // ignore: cast_nullable_to_non_nullable
as List<String>,events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as List<String>,chains: null == chains ? _self.chains : chains // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [SettleNamespaceFfi].
extension SettleNamespaceFfiPatterns on SettleNamespaceFfi {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SettleNamespaceFfi value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SettleNamespaceFfi() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SettleNamespaceFfi value)  $default,){
final _that = this;
switch (_that) {
case _SettleNamespaceFfi():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SettleNamespaceFfi value)?  $default,){
final _that = this;
switch (_that) {
case _SettleNamespaceFfi() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> accounts,  List<String> methods,  List<String> events,  List<String> chains)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SettleNamespaceFfi() when $default != null:
return $default(_that.accounts,_that.methods,_that.events,_that.chains);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> accounts,  List<String> methods,  List<String> events,  List<String> chains)  $default,) {final _that = this;
switch (_that) {
case _SettleNamespaceFfi():
return $default(_that.accounts,_that.methods,_that.events,_that.chains);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> accounts,  List<String> methods,  List<String> events,  List<String> chains)?  $default,) {final _that = this;
switch (_that) {
case _SettleNamespaceFfi() when $default != null:
return $default(_that.accounts,_that.methods,_that.events,_that.chains);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SettleNamespaceFfi implements SettleNamespaceFfi {
  const _SettleNamespaceFfi({required final  List<String> accounts, required final  List<String> methods, required final  List<String> events, required final  List<String> chains}): _accounts = accounts,_methods = methods,_events = events,_chains = chains;
  factory _SettleNamespaceFfi.fromJson(Map<String, dynamic> json) => _$SettleNamespaceFfiFromJson(json);

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

 final  List<String> _chains;
@override List<String> get chains {
  if (_chains is EqualUnmodifiableListView) return _chains;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_chains);
}


/// Create a copy of SettleNamespaceFfi
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettleNamespaceFfiCopyWith<_SettleNamespaceFfi> get copyWith => __$SettleNamespaceFfiCopyWithImpl<_SettleNamespaceFfi>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SettleNamespaceFfiToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettleNamespaceFfi&&const DeepCollectionEquality().equals(other._accounts, _accounts)&&const DeepCollectionEquality().equals(other._methods, _methods)&&const DeepCollectionEquality().equals(other._events, _events)&&const DeepCollectionEquality().equals(other._chains, _chains));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_accounts),const DeepCollectionEquality().hash(_methods),const DeepCollectionEquality().hash(_events),const DeepCollectionEquality().hash(_chains));

@override
String toString() {
  return 'SettleNamespaceFfi(accounts: $accounts, methods: $methods, events: $events, chains: $chains)';
}


}

/// @nodoc
abstract mixin class _$SettleNamespaceFfiCopyWith<$Res> implements $SettleNamespaceFfiCopyWith<$Res> {
  factory _$SettleNamespaceFfiCopyWith(_SettleNamespaceFfi value, $Res Function(_SettleNamespaceFfi) _then) = __$SettleNamespaceFfiCopyWithImpl;
@override @useResult
$Res call({
 List<String> accounts, List<String> methods, List<String> events, List<String> chains
});




}
/// @nodoc
class __$SettleNamespaceFfiCopyWithImpl<$Res>
    implements _$SettleNamespaceFfiCopyWith<$Res> {
  __$SettleNamespaceFfiCopyWithImpl(this._self, this._then);

  final _SettleNamespaceFfi _self;
  final $Res Function(_SettleNamespaceFfi) _then;

/// Create a copy of SettleNamespaceFfi
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accounts = null,Object? methods = null,Object? events = null,Object? chains = null,}) {
  return _then(_SettleNamespaceFfi(
accounts: null == accounts ? _self._accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<String>,methods: null == methods ? _self._methods : methods // ignore: cast_nullable_to_non_nullable
as List<String>,events: null == events ? _self._events : events // ignore: cast_nullable_to_non_nullable
as List<String>,chains: null == chains ? _self._chains : chains // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$MetadataFfi {

 String get name; String get description; String get url; List<String> get icons; String? get verifyUrl; RedirectFfi? get redirect;
/// Create a copy of MetadataFfi
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MetadataFfiCopyWith<MetadataFfi> get copyWith => _$MetadataFfiCopyWithImpl<MetadataFfi>(this as MetadataFfi, _$identity);

  /// Serializes this MetadataFfi to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MetadataFfi&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other.icons, icons)&&(identical(other.verifyUrl, verifyUrl) || other.verifyUrl == verifyUrl)&&(identical(other.redirect, redirect) || other.redirect == redirect));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,description,url,const DeepCollectionEquality().hash(icons),verifyUrl,redirect);

@override
String toString() {
  return 'MetadataFfi(name: $name, description: $description, url: $url, icons: $icons, verifyUrl: $verifyUrl, redirect: $redirect)';
}


}

/// @nodoc
abstract mixin class $MetadataFfiCopyWith<$Res>  {
  factory $MetadataFfiCopyWith(MetadataFfi value, $Res Function(MetadataFfi) _then) = _$MetadataFfiCopyWithImpl;
@useResult
$Res call({
 String name, String description, String url, List<String> icons, String? verifyUrl, RedirectFfi? redirect
});


$RedirectFfiCopyWith<$Res>? get redirect;

}
/// @nodoc
class _$MetadataFfiCopyWithImpl<$Res>
    implements $MetadataFfiCopyWith<$Res> {
  _$MetadataFfiCopyWithImpl(this._self, this._then);

  final MetadataFfi _self;
  final $Res Function(MetadataFfi) _then;

/// Create a copy of MetadataFfi
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? description = null,Object? url = null,Object? icons = null,Object? verifyUrl = freezed,Object? redirect = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,icons: null == icons ? _self.icons : icons // ignore: cast_nullable_to_non_nullable
as List<String>,verifyUrl: freezed == verifyUrl ? _self.verifyUrl : verifyUrl // ignore: cast_nullable_to_non_nullable
as String?,redirect: freezed == redirect ? _self.redirect : redirect // ignore: cast_nullable_to_non_nullable
as RedirectFfi?,
  ));
}
/// Create a copy of MetadataFfi
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RedirectFfiCopyWith<$Res>? get redirect {
    if (_self.redirect == null) {
    return null;
  }

  return $RedirectFfiCopyWith<$Res>(_self.redirect!, (value) {
    return _then(_self.copyWith(redirect: value));
  });
}
}


/// Adds pattern-matching-related methods to [MetadataFfi].
extension MetadataFfiPatterns on MetadataFfi {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MetadataFfi value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MetadataFfi() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MetadataFfi value)  $default,){
final _that = this;
switch (_that) {
case _MetadataFfi():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MetadataFfi value)?  $default,){
final _that = this;
switch (_that) {
case _MetadataFfi() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String description,  String url,  List<String> icons,  String? verifyUrl,  RedirectFfi? redirect)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MetadataFfi() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String description,  String url,  List<String> icons,  String? verifyUrl,  RedirectFfi? redirect)  $default,) {final _that = this;
switch (_that) {
case _MetadataFfi():
return $default(_that.name,_that.description,_that.url,_that.icons,_that.verifyUrl,_that.redirect);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String description,  String url,  List<String> icons,  String? verifyUrl,  RedirectFfi? redirect)?  $default,) {final _that = this;
switch (_that) {
case _MetadataFfi() when $default != null:
return $default(_that.name,_that.description,_that.url,_that.icons,_that.verifyUrl,_that.redirect);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _MetadataFfi implements MetadataFfi {
  const _MetadataFfi({required this.name, required this.description, this.url = '', final  List<String> icons = const <String>[], this.verifyUrl, this.redirect}): _icons = icons;
  factory _MetadataFfi.fromJson(Map<String, dynamic> json) => _$MetadataFfiFromJson(json);

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
@override final  RedirectFfi? redirect;

/// Create a copy of MetadataFfi
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MetadataFfiCopyWith<_MetadataFfi> get copyWith => __$MetadataFfiCopyWithImpl<_MetadataFfi>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MetadataFfiToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MetadataFfi&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other._icons, _icons)&&(identical(other.verifyUrl, verifyUrl) || other.verifyUrl == verifyUrl)&&(identical(other.redirect, redirect) || other.redirect == redirect));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,description,url,const DeepCollectionEquality().hash(_icons),verifyUrl,redirect);

@override
String toString() {
  return 'MetadataFfi(name: $name, description: $description, url: $url, icons: $icons, verifyUrl: $verifyUrl, redirect: $redirect)';
}


}

/// @nodoc
abstract mixin class _$MetadataFfiCopyWith<$Res> implements $MetadataFfiCopyWith<$Res> {
  factory _$MetadataFfiCopyWith(_MetadataFfi value, $Res Function(_MetadataFfi) _then) = __$MetadataFfiCopyWithImpl;
@override @useResult
$Res call({
 String name, String description, String url, List<String> icons, String? verifyUrl, RedirectFfi? redirect
});


@override $RedirectFfiCopyWith<$Res>? get redirect;

}
/// @nodoc
class __$MetadataFfiCopyWithImpl<$Res>
    implements _$MetadataFfiCopyWith<$Res> {
  __$MetadataFfiCopyWithImpl(this._self, this._then);

  final _MetadataFfi _self;
  final $Res Function(_MetadataFfi) _then;

/// Create a copy of MetadataFfi
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? description = null,Object? url = null,Object? icons = null,Object? verifyUrl = freezed,Object? redirect = freezed,}) {
  return _then(_MetadataFfi(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,icons: null == icons ? _self._icons : icons // ignore: cast_nullable_to_non_nullable
as List<String>,verifyUrl: freezed == verifyUrl ? _self.verifyUrl : verifyUrl // ignore: cast_nullable_to_non_nullable
as String?,redirect: freezed == redirect ? _self.redirect : redirect // ignore: cast_nullable_to_non_nullable
as RedirectFfi?,
  ));
}

/// Create a copy of MetadataFfi
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RedirectFfiCopyWith<$Res>? get redirect {
    if (_self.redirect == null) {
    return null;
  }

  return $RedirectFfiCopyWith<$Res>(_self.redirect!, (value) {
    return _then(_self.copyWith(redirect: value));
  });
}
}


/// @nodoc
mixin _$RedirectFfi {

 String? get native; String? get universal; bool get linkMode;
/// Create a copy of RedirectFfi
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RedirectFfiCopyWith<RedirectFfi> get copyWith => _$RedirectFfiCopyWithImpl<RedirectFfi>(this as RedirectFfi, _$identity);

  /// Serializes this RedirectFfi to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RedirectFfi&&(identical(other.native, native) || other.native == native)&&(identical(other.universal, universal) || other.universal == universal)&&(identical(other.linkMode, linkMode) || other.linkMode == linkMode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,native,universal,linkMode);

@override
String toString() {
  return 'RedirectFfi(native: $native, universal: $universal, linkMode: $linkMode)';
}


}

/// @nodoc
abstract mixin class $RedirectFfiCopyWith<$Res>  {
  factory $RedirectFfiCopyWith(RedirectFfi value, $Res Function(RedirectFfi) _then) = _$RedirectFfiCopyWithImpl;
@useResult
$Res call({
 String? native, String? universal, bool linkMode
});




}
/// @nodoc
class _$RedirectFfiCopyWithImpl<$Res>
    implements $RedirectFfiCopyWith<$Res> {
  _$RedirectFfiCopyWithImpl(this._self, this._then);

  final RedirectFfi _self;
  final $Res Function(RedirectFfi) _then;

/// Create a copy of RedirectFfi
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


/// Adds pattern-matching-related methods to [RedirectFfi].
extension RedirectFfiPatterns on RedirectFfi {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RedirectFfi value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RedirectFfi() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RedirectFfi value)  $default,){
final _that = this;
switch (_that) {
case _RedirectFfi():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RedirectFfi value)?  $default,){
final _that = this;
switch (_that) {
case _RedirectFfi() when $default != null:
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
case _RedirectFfi() when $default != null:
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
case _RedirectFfi():
return $default(_that.native,_that.universal,_that.linkMode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? native,  String? universal,  bool linkMode)?  $default,) {final _that = this;
switch (_that) {
case _RedirectFfi() when $default != null:
return $default(_that.native,_that.universal,_that.linkMode);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable()
class _RedirectFfi implements RedirectFfi {
  const _RedirectFfi({this.native, this.universal, this.linkMode = false});
  factory _RedirectFfi.fromJson(Map<String, dynamic> json) => _$RedirectFfiFromJson(json);

@override final  String? native;
@override final  String? universal;
@override@JsonKey() final  bool linkMode;

/// Create a copy of RedirectFfi
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RedirectFfiCopyWith<_RedirectFfi> get copyWith => __$RedirectFfiCopyWithImpl<_RedirectFfi>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RedirectFfiToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RedirectFfi&&(identical(other.native, native) || other.native == native)&&(identical(other.universal, universal) || other.universal == universal)&&(identical(other.linkMode, linkMode) || other.linkMode == linkMode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,native,universal,linkMode);

@override
String toString() {
  return 'RedirectFfi(native: $native, universal: $universal, linkMode: $linkMode)';
}


}

/// @nodoc
abstract mixin class _$RedirectFfiCopyWith<$Res> implements $RedirectFfiCopyWith<$Res> {
  factory _$RedirectFfiCopyWith(_RedirectFfi value, $Res Function(_RedirectFfi) _then) = __$RedirectFfiCopyWithImpl;
@override @useResult
$Res call({
 String? native, String? universal, bool linkMode
});




}
/// @nodoc
class __$RedirectFfiCopyWithImpl<$Res>
    implements _$RedirectFfiCopyWith<$Res> {
  __$RedirectFfiCopyWithImpl(this._self, this._then);

  final _RedirectFfi _self;
  final $Res Function(_RedirectFfi) _then;

/// Create a copy of RedirectFfi
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? native = freezed,Object? universal = freezed,Object? linkMode = null,}) {
  return _then(_RedirectFfi(
native: freezed == native ? _self.native : native // ignore: cast_nullable_to_non_nullable
as String?,universal: freezed == universal ? _self.universal : universal // ignore: cast_nullable_to_non_nullable
as String?,linkMode: null == linkMode ? _self.linkMode : linkMode // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$ApproveResultFfi {

 List<int> get sessionSymKey; List<int> get selfPublicKey;
/// Create a copy of ApproveResultFfi
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApproveResultFfiCopyWith<ApproveResultFfi> get copyWith => _$ApproveResultFfiCopyWithImpl<ApproveResultFfi>(this as ApproveResultFfi, _$identity);

  /// Serializes this ApproveResultFfi to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApproveResultFfi&&const DeepCollectionEquality().equals(other.sessionSymKey, sessionSymKey)&&const DeepCollectionEquality().equals(other.selfPublicKey, selfPublicKey));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(sessionSymKey),const DeepCollectionEquality().hash(selfPublicKey));

@override
String toString() {
  return 'ApproveResultFfi(sessionSymKey: $sessionSymKey, selfPublicKey: $selfPublicKey)';
}


}

/// @nodoc
abstract mixin class $ApproveResultFfiCopyWith<$Res>  {
  factory $ApproveResultFfiCopyWith(ApproveResultFfi value, $Res Function(ApproveResultFfi) _then) = _$ApproveResultFfiCopyWithImpl;
@useResult
$Res call({
 List<int> sessionSymKey, List<int> selfPublicKey
});




}
/// @nodoc
class _$ApproveResultFfiCopyWithImpl<$Res>
    implements $ApproveResultFfiCopyWith<$Res> {
  _$ApproveResultFfiCopyWithImpl(this._self, this._then);

  final ApproveResultFfi _self;
  final $Res Function(ApproveResultFfi) _then;

/// Create a copy of ApproveResultFfi
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionSymKey = null,Object? selfPublicKey = null,}) {
  return _then(_self.copyWith(
sessionSymKey: null == sessionSymKey ? _self.sessionSymKey : sessionSymKey // ignore: cast_nullable_to_non_nullable
as List<int>,selfPublicKey: null == selfPublicKey ? _self.selfPublicKey : selfPublicKey // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [ApproveResultFfi].
extension ApproveResultFfiPatterns on ApproveResultFfi {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApproveResultFfi value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApproveResultFfi() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApproveResultFfi value)  $default,){
final _that = this;
switch (_that) {
case _ApproveResultFfi():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApproveResultFfi value)?  $default,){
final _that = this;
switch (_that) {
case _ApproveResultFfi() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<int> sessionSymKey,  List<int> selfPublicKey)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApproveResultFfi() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<int> sessionSymKey,  List<int> selfPublicKey)  $default,) {final _that = this;
switch (_that) {
case _ApproveResultFfi():
return $default(_that.sessionSymKey,_that.selfPublicKey);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<int> sessionSymKey,  List<int> selfPublicKey)?  $default,) {final _that = this;
switch (_that) {
case _ApproveResultFfi() when $default != null:
return $default(_that.sessionSymKey,_that.selfPublicKey);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable()
class _ApproveResultFfi implements ApproveResultFfi {
  const _ApproveResultFfi({required final  List<int> sessionSymKey, required final  List<int> selfPublicKey}): _sessionSymKey = sessionSymKey,_selfPublicKey = selfPublicKey;
  factory _ApproveResultFfi.fromJson(Map<String, dynamic> json) => _$ApproveResultFfiFromJson(json);

 final  List<int> _sessionSymKey;
@override List<int> get sessionSymKey {
  if (_sessionSymKey is EqualUnmodifiableListView) return _sessionSymKey;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sessionSymKey);
}

 final  List<int> _selfPublicKey;
@override List<int> get selfPublicKey {
  if (_selfPublicKey is EqualUnmodifiableListView) return _selfPublicKey;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selfPublicKey);
}


/// Create a copy of ApproveResultFfi
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApproveResultFfiCopyWith<_ApproveResultFfi> get copyWith => __$ApproveResultFfiCopyWithImpl<_ApproveResultFfi>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ApproveResultFfiToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApproveResultFfi&&const DeepCollectionEquality().equals(other._sessionSymKey, _sessionSymKey)&&const DeepCollectionEquality().equals(other._selfPublicKey, _selfPublicKey));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_sessionSymKey),const DeepCollectionEquality().hash(_selfPublicKey));

@override
String toString() {
  return 'ApproveResultFfi(sessionSymKey: $sessionSymKey, selfPublicKey: $selfPublicKey)';
}


}

/// @nodoc
abstract mixin class _$ApproveResultFfiCopyWith<$Res> implements $ApproveResultFfiCopyWith<$Res> {
  factory _$ApproveResultFfiCopyWith(_ApproveResultFfi value, $Res Function(_ApproveResultFfi) _then) = __$ApproveResultFfiCopyWithImpl;
@override @useResult
$Res call({
 List<int> sessionSymKey, List<int> selfPublicKey
});




}
/// @nodoc
class __$ApproveResultFfiCopyWithImpl<$Res>
    implements _$ApproveResultFfiCopyWith<$Res> {
  __$ApproveResultFfiCopyWithImpl(this._self, this._then);

  final _ApproveResultFfi _self;
  final $Res Function(_ApproveResultFfi) _then;

/// Create a copy of ApproveResultFfi
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionSymKey = null,Object? selfPublicKey = null,}) {
  return _then(_ApproveResultFfi(
sessionSymKey: null == sessionSymKey ? _self._sessionSymKey : sessionSymKey // ignore: cast_nullable_to_non_nullable
as List<int>,selfPublicKey: null == selfPublicKey ? _self._selfPublicKey : selfPublicKey // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}


/// @nodoc
mixin _$SessionRequestRequestFfi {

 String get method; String get params;// JSON string
 int? get expiry;
/// Create a copy of SessionRequestRequestFfi
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionRequestRequestFfiCopyWith<SessionRequestRequestFfi> get copyWith => _$SessionRequestRequestFfiCopyWithImpl<SessionRequestRequestFfi>(this as SessionRequestRequestFfi, _$identity);

  /// Serializes this SessionRequestRequestFfi to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionRequestRequestFfi&&(identical(other.method, method) || other.method == method)&&(identical(other.params, params) || other.params == params)&&(identical(other.expiry, expiry) || other.expiry == expiry));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,method,params,expiry);

@override
String toString() {
  return 'SessionRequestRequestFfi(method: $method, params: $params, expiry: $expiry)';
}


}

/// @nodoc
abstract mixin class $SessionRequestRequestFfiCopyWith<$Res>  {
  factory $SessionRequestRequestFfiCopyWith(SessionRequestRequestFfi value, $Res Function(SessionRequestRequestFfi) _then) = _$SessionRequestRequestFfiCopyWithImpl;
@useResult
$Res call({
 String method, String params, int? expiry
});




}
/// @nodoc
class _$SessionRequestRequestFfiCopyWithImpl<$Res>
    implements $SessionRequestRequestFfiCopyWith<$Res> {
  _$SessionRequestRequestFfiCopyWithImpl(this._self, this._then);

  final SessionRequestRequestFfi _self;
  final $Res Function(SessionRequestRequestFfi) _then;

/// Create a copy of SessionRequestRequestFfi
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? method = null,Object? params = null,Object? expiry = freezed,}) {
  return _then(_self.copyWith(
method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,params: null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as String,expiry: freezed == expiry ? _self.expiry : expiry // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [SessionRequestRequestFfi].
extension SessionRequestRequestFfiPatterns on SessionRequestRequestFfi {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionRequestRequestFfi value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionRequestRequestFfi() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionRequestRequestFfi value)  $default,){
final _that = this;
switch (_that) {
case _SessionRequestRequestFfi():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionRequestRequestFfi value)?  $default,){
final _that = this;
switch (_that) {
case _SessionRequestRequestFfi() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String method,  String params,  int? expiry)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionRequestRequestFfi() when $default != null:
return $default(_that.method,_that.params,_that.expiry);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String method,  String params,  int? expiry)  $default,) {final _that = this;
switch (_that) {
case _SessionRequestRequestFfi():
return $default(_that.method,_that.params,_that.expiry);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String method,  String params,  int? expiry)?  $default,) {final _that = this;
switch (_that) {
case _SessionRequestRequestFfi() when $default != null:
return $default(_that.method,_that.params,_that.expiry);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SessionRequestRequestFfi implements SessionRequestRequestFfi {
  const _SessionRequestRequestFfi({required this.method, required this.params, this.expiry});
  factory _SessionRequestRequestFfi.fromJson(Map<String, dynamic> json) => _$SessionRequestRequestFfiFromJson(json);

@override final  String method;
@override final  String params;
// JSON string
@override final  int? expiry;

/// Create a copy of SessionRequestRequestFfi
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionRequestRequestFfiCopyWith<_SessionRequestRequestFfi> get copyWith => __$SessionRequestRequestFfiCopyWithImpl<_SessionRequestRequestFfi>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SessionRequestRequestFfiToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionRequestRequestFfi&&(identical(other.method, method) || other.method == method)&&(identical(other.params, params) || other.params == params)&&(identical(other.expiry, expiry) || other.expiry == expiry));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,method,params,expiry);

@override
String toString() {
  return 'SessionRequestRequestFfi(method: $method, params: $params, expiry: $expiry)';
}


}

/// @nodoc
abstract mixin class _$SessionRequestRequestFfiCopyWith<$Res> implements $SessionRequestRequestFfiCopyWith<$Res> {
  factory _$SessionRequestRequestFfiCopyWith(_SessionRequestRequestFfi value, $Res Function(_SessionRequestRequestFfi) _then) = __$SessionRequestRequestFfiCopyWithImpl;
@override @useResult
$Res call({
 String method, String params, int? expiry
});




}
/// @nodoc
class __$SessionRequestRequestFfiCopyWithImpl<$Res>
    implements _$SessionRequestRequestFfiCopyWith<$Res> {
  __$SessionRequestRequestFfiCopyWithImpl(this._self, this._then);

  final _SessionRequestRequestFfi _self;
  final $Res Function(_SessionRequestRequestFfi) _then;

/// Create a copy of SessionRequestRequestFfi
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? method = null,Object? params = null,Object? expiry = freezed,}) {
  return _then(_SessionRequestRequestFfi(
method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,params: null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as String,expiry: freezed == expiry ? _self.expiry : expiry // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$SessionRequestFfi {

 String get chainId; SessionRequestRequestFfi get request;
/// Create a copy of SessionRequestFfi
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionRequestFfiCopyWith<SessionRequestFfi> get copyWith => _$SessionRequestFfiCopyWithImpl<SessionRequestFfi>(this as SessionRequestFfi, _$identity);

  /// Serializes this SessionRequestFfi to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionRequestFfi&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.request, request) || other.request == request));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,chainId,request);

@override
String toString() {
  return 'SessionRequestFfi(chainId: $chainId, request: $request)';
}


}

/// @nodoc
abstract mixin class $SessionRequestFfiCopyWith<$Res>  {
  factory $SessionRequestFfiCopyWith(SessionRequestFfi value, $Res Function(SessionRequestFfi) _then) = _$SessionRequestFfiCopyWithImpl;
@useResult
$Res call({
 String chainId, SessionRequestRequestFfi request
});


$SessionRequestRequestFfiCopyWith<$Res> get request;

}
/// @nodoc
class _$SessionRequestFfiCopyWithImpl<$Res>
    implements $SessionRequestFfiCopyWith<$Res> {
  _$SessionRequestFfiCopyWithImpl(this._self, this._then);

  final SessionRequestFfi _self;
  final $Res Function(SessionRequestFfi) _then;

/// Create a copy of SessionRequestFfi
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? chainId = null,Object? request = null,}) {
  return _then(_self.copyWith(
chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as String,request: null == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as SessionRequestRequestFfi,
  ));
}
/// Create a copy of SessionRequestFfi
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionRequestRequestFfiCopyWith<$Res> get request {
  
  return $SessionRequestRequestFfiCopyWith<$Res>(_self.request, (value) {
    return _then(_self.copyWith(request: value));
  });
}
}


/// Adds pattern-matching-related methods to [SessionRequestFfi].
extension SessionRequestFfiPatterns on SessionRequestFfi {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionRequestFfi value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionRequestFfi() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionRequestFfi value)  $default,){
final _that = this;
switch (_that) {
case _SessionRequestFfi():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionRequestFfi value)?  $default,){
final _that = this;
switch (_that) {
case _SessionRequestFfi() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String chainId,  SessionRequestRequestFfi request)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionRequestFfi() when $default != null:
return $default(_that.chainId,_that.request);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String chainId,  SessionRequestRequestFfi request)  $default,) {final _that = this;
switch (_that) {
case _SessionRequestFfi():
return $default(_that.chainId,_that.request);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String chainId,  SessionRequestRequestFfi request)?  $default,) {final _that = this;
switch (_that) {
case _SessionRequestFfi() when $default != null:
return $default(_that.chainId,_that.request);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SessionRequestFfi implements SessionRequestFfi {
  const _SessionRequestFfi({required this.chainId, required this.request});
  factory _SessionRequestFfi.fromJson(Map<String, dynamic> json) => _$SessionRequestFfiFromJson(json);

@override final  String chainId;
@override final  SessionRequestRequestFfi request;

/// Create a copy of SessionRequestFfi
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionRequestFfiCopyWith<_SessionRequestFfi> get copyWith => __$SessionRequestFfiCopyWithImpl<_SessionRequestFfi>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SessionRequestFfiToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionRequestFfi&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.request, request) || other.request == request));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,chainId,request);

@override
String toString() {
  return 'SessionRequestFfi(chainId: $chainId, request: $request)';
}


}

/// @nodoc
abstract mixin class _$SessionRequestFfiCopyWith<$Res> implements $SessionRequestFfiCopyWith<$Res> {
  factory _$SessionRequestFfiCopyWith(_SessionRequestFfi value, $Res Function(_SessionRequestFfi) _then) = __$SessionRequestFfiCopyWithImpl;
@override @useResult
$Res call({
 String chainId, SessionRequestRequestFfi request
});


@override $SessionRequestRequestFfiCopyWith<$Res> get request;

}
/// @nodoc
class __$SessionRequestFfiCopyWithImpl<$Res>
    implements _$SessionRequestFfiCopyWith<$Res> {
  __$SessionRequestFfiCopyWithImpl(this._self, this._then);

  final _SessionRequestFfi _self;
  final $Res Function(_SessionRequestFfi) _then;

/// Create a copy of SessionRequestFfi
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? chainId = null,Object? request = null,}) {
  return _then(_SessionRequestFfi(
chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as String,request: null == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as SessionRequestRequestFfi,
  ));
}

/// Create a copy of SessionRequestFfi
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionRequestRequestFfiCopyWith<$Res> get request {
  
  return $SessionRequestRequestFfiCopyWith<$Res>(_self.request, (value) {
    return _then(_self.copyWith(request: value));
  });
}
}


/// @nodoc
mixin _$SessionRequestJsonRpcFfi {

 int get id; String get method; SessionRequestFfi get params;
/// Create a copy of SessionRequestJsonRpcFfi
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionRequestJsonRpcFfiCopyWith<SessionRequestJsonRpcFfi> get copyWith => _$SessionRequestJsonRpcFfiCopyWithImpl<SessionRequestJsonRpcFfi>(this as SessionRequestJsonRpcFfi, _$identity);

  /// Serializes this SessionRequestJsonRpcFfi to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionRequestJsonRpcFfi&&(identical(other.id, id) || other.id == id)&&(identical(other.method, method) || other.method == method)&&(identical(other.params, params) || other.params == params));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,method,params);

@override
String toString() {
  return 'SessionRequestJsonRpcFfi(id: $id, method: $method, params: $params)';
}


}

/// @nodoc
abstract mixin class $SessionRequestJsonRpcFfiCopyWith<$Res>  {
  factory $SessionRequestJsonRpcFfiCopyWith(SessionRequestJsonRpcFfi value, $Res Function(SessionRequestJsonRpcFfi) _then) = _$SessionRequestJsonRpcFfiCopyWithImpl;
@useResult
$Res call({
 int id, String method, SessionRequestFfi params
});


$SessionRequestFfiCopyWith<$Res> get params;

}
/// @nodoc
class _$SessionRequestJsonRpcFfiCopyWithImpl<$Res>
    implements $SessionRequestJsonRpcFfiCopyWith<$Res> {
  _$SessionRequestJsonRpcFfiCopyWithImpl(this._self, this._then);

  final SessionRequestJsonRpcFfi _self;
  final $Res Function(SessionRequestJsonRpcFfi) _then;

/// Create a copy of SessionRequestJsonRpcFfi
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? method = null,Object? params = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,params: null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as SessionRequestFfi,
  ));
}
/// Create a copy of SessionRequestJsonRpcFfi
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionRequestFfiCopyWith<$Res> get params {
  
  return $SessionRequestFfiCopyWith<$Res>(_self.params, (value) {
    return _then(_self.copyWith(params: value));
  });
}
}


/// Adds pattern-matching-related methods to [SessionRequestJsonRpcFfi].
extension SessionRequestJsonRpcFfiPatterns on SessionRequestJsonRpcFfi {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionRequestJsonRpcFfi value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionRequestJsonRpcFfi() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionRequestJsonRpcFfi value)  $default,){
final _that = this;
switch (_that) {
case _SessionRequestJsonRpcFfi():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionRequestJsonRpcFfi value)?  $default,){
final _that = this;
switch (_that) {
case _SessionRequestJsonRpcFfi() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String method,  SessionRequestFfi params)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionRequestJsonRpcFfi() when $default != null:
return $default(_that.id,_that.method,_that.params);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String method,  SessionRequestFfi params)  $default,) {final _that = this;
switch (_that) {
case _SessionRequestJsonRpcFfi():
return $default(_that.id,_that.method,_that.params);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String method,  SessionRequestFfi params)?  $default,) {final _that = this;
switch (_that) {
case _SessionRequestJsonRpcFfi() when $default != null:
return $default(_that.id,_that.method,_that.params);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SessionRequestJsonRpcFfi implements SessionRequestJsonRpcFfi {
  const _SessionRequestJsonRpcFfi({required this.id, required this.method, required this.params});
  factory _SessionRequestJsonRpcFfi.fromJson(Map<String, dynamic> json) => _$SessionRequestJsonRpcFfiFromJson(json);

@override final  int id;
@override final  String method;
@override final  SessionRequestFfi params;

/// Create a copy of SessionRequestJsonRpcFfi
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionRequestJsonRpcFfiCopyWith<_SessionRequestJsonRpcFfi> get copyWith => __$SessionRequestJsonRpcFfiCopyWithImpl<_SessionRequestJsonRpcFfi>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SessionRequestJsonRpcFfiToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionRequestJsonRpcFfi&&(identical(other.id, id) || other.id == id)&&(identical(other.method, method) || other.method == method)&&(identical(other.params, params) || other.params == params));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,method,params);

@override
String toString() {
  return 'SessionRequestJsonRpcFfi(id: $id, method: $method, params: $params)';
}


}

/// @nodoc
abstract mixin class _$SessionRequestJsonRpcFfiCopyWith<$Res> implements $SessionRequestJsonRpcFfiCopyWith<$Res> {
  factory _$SessionRequestJsonRpcFfiCopyWith(_SessionRequestJsonRpcFfi value, $Res Function(_SessionRequestJsonRpcFfi) _then) = __$SessionRequestJsonRpcFfiCopyWithImpl;
@override @useResult
$Res call({
 int id, String method, SessionRequestFfi params
});


@override $SessionRequestFfiCopyWith<$Res> get params;

}
/// @nodoc
class __$SessionRequestJsonRpcFfiCopyWithImpl<$Res>
    implements _$SessionRequestJsonRpcFfiCopyWith<$Res> {
  __$SessionRequestJsonRpcFfiCopyWithImpl(this._self, this._then);

  final _SessionRequestJsonRpcFfi _self;
  final $Res Function(_SessionRequestJsonRpcFfi) _then;

/// Create a copy of SessionRequestJsonRpcFfi
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? method = null,Object? params = null,}) {
  return _then(_SessionRequestJsonRpcFfi(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,params: null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as SessionRequestFfi,
  ));
}

/// Create a copy of SessionRequestJsonRpcFfi
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionRequestFfiCopyWith<$Res> get params {
  
  return $SessionRequestFfiCopyWith<$Res>(_self.params, (value) {
    return _then(_self.copyWith(params: value));
  });
}
}


/// @nodoc
mixin _$SessionRequestNativeEvent {

 String get topic;// JSON String. Should be transformed into SessionRequestJsonRpcFfi
 String get sessionRequest;
/// Create a copy of SessionRequestNativeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionRequestNativeEventCopyWith<SessionRequestNativeEvent> get copyWith => _$SessionRequestNativeEventCopyWithImpl<SessionRequestNativeEvent>(this as SessionRequestNativeEvent, _$identity);

  /// Serializes this SessionRequestNativeEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionRequestNativeEvent&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.sessionRequest, sessionRequest) || other.sessionRequest == sessionRequest));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,topic,sessionRequest);

@override
String toString() {
  return 'SessionRequestNativeEvent(topic: $topic, sessionRequest: $sessionRequest)';
}


}

/// @nodoc
abstract mixin class $SessionRequestNativeEventCopyWith<$Res>  {
  factory $SessionRequestNativeEventCopyWith(SessionRequestNativeEvent value, $Res Function(SessionRequestNativeEvent) _then) = _$SessionRequestNativeEventCopyWithImpl;
@useResult
$Res call({
 String topic, String sessionRequest
});




}
/// @nodoc
class _$SessionRequestNativeEventCopyWithImpl<$Res>
    implements $SessionRequestNativeEventCopyWith<$Res> {
  _$SessionRequestNativeEventCopyWithImpl(this._self, this._then);

  final SessionRequestNativeEvent _self;
  final $Res Function(SessionRequestNativeEvent) _then;

/// Create a copy of SessionRequestNativeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? topic = null,Object? sessionRequest = null,}) {
  return _then(_self.copyWith(
topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,sessionRequest: null == sessionRequest ? _self.sessionRequest : sessionRequest // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SessionRequestNativeEvent].
extension SessionRequestNativeEventPatterns on SessionRequestNativeEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionRequestNativeEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionRequestNativeEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionRequestNativeEvent value)  $default,){
final _that = this;
switch (_that) {
case _SessionRequestNativeEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionRequestNativeEvent value)?  $default,){
final _that = this;
switch (_that) {
case _SessionRequestNativeEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String topic,  String sessionRequest)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionRequestNativeEvent() when $default != null:
return $default(_that.topic,_that.sessionRequest);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String topic,  String sessionRequest)  $default,) {final _that = this;
switch (_that) {
case _SessionRequestNativeEvent():
return $default(_that.topic,_that.sessionRequest);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String topic,  String sessionRequest)?  $default,) {final _that = this;
switch (_that) {
case _SessionRequestNativeEvent() when $default != null:
return $default(_that.topic,_that.sessionRequest);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SessionRequestNativeEvent implements SessionRequestNativeEvent {
  const _SessionRequestNativeEvent({required this.topic, required this.sessionRequest});
  factory _SessionRequestNativeEvent.fromJson(Map<String, dynamic> json) => _$SessionRequestNativeEventFromJson(json);

@override final  String topic;
// JSON String. Should be transformed into SessionRequestJsonRpcFfi
@override final  String sessionRequest;

/// Create a copy of SessionRequestNativeEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionRequestNativeEventCopyWith<_SessionRequestNativeEvent> get copyWith => __$SessionRequestNativeEventCopyWithImpl<_SessionRequestNativeEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SessionRequestNativeEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionRequestNativeEvent&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.sessionRequest, sessionRequest) || other.sessionRequest == sessionRequest));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,topic,sessionRequest);

@override
String toString() {
  return 'SessionRequestNativeEvent(topic: $topic, sessionRequest: $sessionRequest)';
}


}

/// @nodoc
abstract mixin class _$SessionRequestNativeEventCopyWith<$Res> implements $SessionRequestNativeEventCopyWith<$Res> {
  factory _$SessionRequestNativeEventCopyWith(_SessionRequestNativeEvent value, $Res Function(_SessionRequestNativeEvent) _then) = __$SessionRequestNativeEventCopyWithImpl;
@override @useResult
$Res call({
 String topic, String sessionRequest
});




}
/// @nodoc
class __$SessionRequestNativeEventCopyWithImpl<$Res>
    implements _$SessionRequestNativeEventCopyWith<$Res> {
  __$SessionRequestNativeEventCopyWithImpl(this._self, this._then);

  final _SessionRequestNativeEvent _self;
  final $Res Function(_SessionRequestNativeEvent) _then;

/// Create a copy of SessionRequestNativeEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? topic = null,Object? sessionRequest = null,}) {
  return _then(_SessionRequestNativeEvent(
topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,sessionRequest: null == sessionRequest ? _self.sessionRequest : sessionRequest // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

SessionRequestJsonRpcResponseFfi _$SessionRequestJsonRpcResponseFfiFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'result':
          return Result.fromJson(
            json
          );
                case 'error':
          return Error.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'SessionRequestJsonRpcResponseFfi',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$SessionRequestJsonRpcResponseFfi {

 int get id; String get jsonrpc;
/// Create a copy of SessionRequestJsonRpcResponseFfi
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionRequestJsonRpcResponseFfiCopyWith<SessionRequestJsonRpcResponseFfi> get copyWith => _$SessionRequestJsonRpcResponseFfiCopyWithImpl<SessionRequestJsonRpcResponseFfi>(this as SessionRequestJsonRpcResponseFfi, _$identity);

  /// Serializes this SessionRequestJsonRpcResponseFfi to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionRequestJsonRpcResponseFfi&&(identical(other.id, id) || other.id == id)&&(identical(other.jsonrpc, jsonrpc) || other.jsonrpc == jsonrpc));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,jsonrpc);

@override
String toString() {
  return 'SessionRequestJsonRpcResponseFfi(id: $id, jsonrpc: $jsonrpc)';
}


}

/// @nodoc
abstract mixin class $SessionRequestJsonRpcResponseFfiCopyWith<$Res>  {
  factory $SessionRequestJsonRpcResponseFfiCopyWith(SessionRequestJsonRpcResponseFfi value, $Res Function(SessionRequestJsonRpcResponseFfi) _then) = _$SessionRequestJsonRpcResponseFfiCopyWithImpl;
@useResult
$Res call({
 int id, String jsonrpc
});




}
/// @nodoc
class _$SessionRequestJsonRpcResponseFfiCopyWithImpl<$Res>
    implements $SessionRequestJsonRpcResponseFfiCopyWith<$Res> {
  _$SessionRequestJsonRpcResponseFfiCopyWithImpl(this._self, this._then);

  final SessionRequestJsonRpcResponseFfi _self;
  final $Res Function(SessionRequestJsonRpcResponseFfi) _then;

/// Create a copy of SessionRequestJsonRpcResponseFfi
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? jsonrpc = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,jsonrpc: null == jsonrpc ? _self.jsonrpc : jsonrpc // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SessionRequestJsonRpcResponseFfi].
extension SessionRequestJsonRpcResponseFfiPatterns on SessionRequestJsonRpcResponseFfi {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Result value)?  result,TResult Function( Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Result() when result != null:
return result(_that);case Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Result value)  result,required TResult Function( Error value)  error,}){
final _that = this;
switch (_that) {
case Result():
return result(_that);case Error():
return error(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Result value)?  result,TResult? Function( Error value)?  error,}){
final _that = this;
switch (_that) {
case Result() when result != null:
return result(_that);case Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int id,  String jsonrpc,  String result)?  result,TResult Function( int id,  String jsonrpc,  String error)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Result() when result != null:
return result(_that.id,_that.jsonrpc,_that.result);case Error() when error != null:
return error(_that.id,_that.jsonrpc,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int id,  String jsonrpc,  String result)  result,required TResult Function( int id,  String jsonrpc,  String error)  error,}) {final _that = this;
switch (_that) {
case Result():
return result(_that.id,_that.jsonrpc,_that.result);case Error():
return error(_that.id,_that.jsonrpc,_that.error);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int id,  String jsonrpc,  String result)?  result,TResult? Function( int id,  String jsonrpc,  String error)?  error,}) {final _that = this;
switch (_that) {
case Result() when result != null:
return result(_that.id,_that.jsonrpc,_that.result);case Error() when error != null:
return error(_that.id,_that.jsonrpc,_that.error);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class Result implements SessionRequestJsonRpcResponseFfi {
  const Result({required this.id, this.jsonrpc = '2.0', required this.result, final  String? $type}): $type = $type ?? 'result';
  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

@override final  int id;
@override@JsonKey() final  String jsonrpc;
 final  String result;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of SessionRequestJsonRpcResponseFfi
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResultCopyWith<Result> get copyWith => _$ResultCopyWithImpl<Result>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Result&&(identical(other.id, id) || other.id == id)&&(identical(other.jsonrpc, jsonrpc) || other.jsonrpc == jsonrpc)&&(identical(other.result, result) || other.result == result));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,jsonrpc,result);

@override
String toString() {
  return 'SessionRequestJsonRpcResponseFfi.result(id: $id, jsonrpc: $jsonrpc, result: $result)';
}


}

/// @nodoc
abstract mixin class $ResultCopyWith<$Res> implements $SessionRequestJsonRpcResponseFfiCopyWith<$Res> {
  factory $ResultCopyWith(Result value, $Res Function(Result) _then) = _$ResultCopyWithImpl;
@override @useResult
$Res call({
 int id, String jsonrpc, String result
});




}
/// @nodoc
class _$ResultCopyWithImpl<$Res>
    implements $ResultCopyWith<$Res> {
  _$ResultCopyWithImpl(this._self, this._then);

  final Result _self;
  final $Res Function(Result) _then;

/// Create a copy of SessionRequestJsonRpcResponseFfi
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? jsonrpc = null,Object? result = null,}) {
  return _then(Result(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,jsonrpc: null == jsonrpc ? _self.jsonrpc : jsonrpc // ignore: cast_nullable_to_non_nullable
as String,result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class Error implements SessionRequestJsonRpcResponseFfi {
  const Error({required this.id, this.jsonrpc = '2.0', required this.error, final  String? $type}): $type = $type ?? 'error';
  factory Error.fromJson(Map<String, dynamic> json) => _$ErrorFromJson(json);

@override final  int id;
@override@JsonKey() final  String jsonrpc;
 final  String error;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of SessionRequestJsonRpcResponseFfi
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorCopyWith<Error> get copyWith => _$ErrorCopyWithImpl<Error>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ErrorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Error&&(identical(other.id, id) || other.id == id)&&(identical(other.jsonrpc, jsonrpc) || other.jsonrpc == jsonrpc)&&(identical(other.error, error) || other.error == error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,jsonrpc,error);

@override
String toString() {
  return 'SessionRequestJsonRpcResponseFfi.error(id: $id, jsonrpc: $jsonrpc, error: $error)';
}


}

/// @nodoc
abstract mixin class $ErrorCopyWith<$Res> implements $SessionRequestJsonRpcResponseFfiCopyWith<$Res> {
  factory $ErrorCopyWith(Error value, $Res Function(Error) _then) = _$ErrorCopyWithImpl;
@override @useResult
$Res call({
 int id, String jsonrpc, String error
});




}
/// @nodoc
class _$ErrorCopyWithImpl<$Res>
    implements $ErrorCopyWith<$Res> {
  _$ErrorCopyWithImpl(this._self, this._then);

  final Error _self;
  final $Res Function(Error) _then;

/// Create a copy of SessionRequestJsonRpcResponseFfi
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? jsonrpc = null,Object? error = null,}) {
  return _then(Error(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,jsonrpc: null == jsonrpc ? _self.jsonrpc : jsonrpc // ignore: cast_nullable_to_non_nullable
as String,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ErrorDataFfi {

 int get code; String get message; String? get data;
/// Create a copy of ErrorDataFfi
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrorDataFfiCopyWith<ErrorDataFfi> get copyWith => _$ErrorDataFfiCopyWithImpl<ErrorDataFfi>(this as ErrorDataFfi, _$identity);

  /// Serializes this ErrorDataFfi to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ErrorDataFfi&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message,data);

@override
String toString() {
  return 'ErrorDataFfi(code: $code, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class $ErrorDataFfiCopyWith<$Res>  {
  factory $ErrorDataFfiCopyWith(ErrorDataFfi value, $Res Function(ErrorDataFfi) _then) = _$ErrorDataFfiCopyWithImpl;
@useResult
$Res call({
 int code, String message, String? data
});




}
/// @nodoc
class _$ErrorDataFfiCopyWithImpl<$Res>
    implements $ErrorDataFfiCopyWith<$Res> {
  _$ErrorDataFfiCopyWithImpl(this._self, this._then);

  final ErrorDataFfi _self;
  final $Res Function(ErrorDataFfi) _then;

/// Create a copy of ErrorDataFfi
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? message = null,Object? data = freezed,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ErrorDataFfi].
extension ErrorDataFfiPatterns on ErrorDataFfi {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ErrorDataFfi value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ErrorDataFfi() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ErrorDataFfi value)  $default,){
final _that = this;
switch (_that) {
case _ErrorDataFfi():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ErrorDataFfi value)?  $default,){
final _that = this;
switch (_that) {
case _ErrorDataFfi() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int code,  String message,  String? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ErrorDataFfi() when $default != null:
return $default(_that.code,_that.message,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int code,  String message,  String? data)  $default,) {final _that = this;
switch (_that) {
case _ErrorDataFfi():
return $default(_that.code,_that.message,_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int code,  String message,  String? data)?  $default,) {final _that = this;
switch (_that) {
case _ErrorDataFfi() when $default != null:
return $default(_that.code,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ErrorDataFfi implements ErrorDataFfi {
  const _ErrorDataFfi({required this.code, required this.message, this.data});
  factory _ErrorDataFfi.fromJson(Map<String, dynamic> json) => _$ErrorDataFfiFromJson(json);

@override final  int code;
@override final  String message;
@override final  String? data;

/// Create a copy of ErrorDataFfi
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorDataFfiCopyWith<_ErrorDataFfi> get copyWith => __$ErrorDataFfiCopyWithImpl<_ErrorDataFfi>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ErrorDataFfiToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ErrorDataFfi&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message,data);

@override
String toString() {
  return 'ErrorDataFfi(code: $code, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$ErrorDataFfiCopyWith<$Res> implements $ErrorDataFfiCopyWith<$Res> {
  factory _$ErrorDataFfiCopyWith(_ErrorDataFfi value, $Res Function(_ErrorDataFfi) _then) = __$ErrorDataFfiCopyWithImpl;
@override @useResult
$Res call({
 int code, String message, String? data
});




}
/// @nodoc
class __$ErrorDataFfiCopyWithImpl<$Res>
    implements _$ErrorDataFfiCopyWith<$Res> {
  __$ErrorDataFfiCopyWithImpl(this._self, this._then);

  final _ErrorDataFfi _self;
  final $Res Function(_ErrorDataFfi) _then;

/// Create a copy of ErrorDataFfi
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? message = null,Object? data = freezed,}) {
  return _then(_ErrorDataFfi(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
