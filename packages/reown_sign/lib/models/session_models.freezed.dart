// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Namespace {

 List<String>? get chains; List<String> get accounts; List<String> get methods; List<String> get events;
/// Create a copy of Namespace
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NamespaceCopyWith<Namespace> get copyWith => _$NamespaceCopyWithImpl<Namespace>(this as Namespace, _$identity);

  /// Serializes this Namespace to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Namespace&&const DeepCollectionEquality().equals(other.chains, chains)&&const DeepCollectionEquality().equals(other.accounts, accounts)&&const DeepCollectionEquality().equals(other.methods, methods)&&const DeepCollectionEquality().equals(other.events, events));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(chains),const DeepCollectionEquality().hash(accounts),const DeepCollectionEquality().hash(methods),const DeepCollectionEquality().hash(events));

@override
String toString() {
  return 'Namespace(chains: $chains, accounts: $accounts, methods: $methods, events: $events)';
}


}

/// @nodoc
abstract mixin class $NamespaceCopyWith<$Res>  {
  factory $NamespaceCopyWith(Namespace value, $Res Function(Namespace) _then) = _$NamespaceCopyWithImpl;
@useResult
$Res call({
 List<String>? chains, List<String> accounts, List<String> methods, List<String> events
});




}
/// @nodoc
class _$NamespaceCopyWithImpl<$Res>
    implements $NamespaceCopyWith<$Res> {
  _$NamespaceCopyWithImpl(this._self, this._then);

  final Namespace _self;
  final $Res Function(Namespace) _then;

/// Create a copy of Namespace
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? chains = freezed,Object? accounts = null,Object? methods = null,Object? events = null,}) {
  return _then(_self.copyWith(
chains: freezed == chains ? _self.chains : chains // ignore: cast_nullable_to_non_nullable
as List<String>?,accounts: null == accounts ? _self.accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<String>,methods: null == methods ? _self.methods : methods // ignore: cast_nullable_to_non_nullable
as List<String>,events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [Namespace].
extension NamespacePatterns on Namespace {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Namespace value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Namespace() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Namespace value)  $default,){
final _that = this;
switch (_that) {
case _Namespace():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Namespace value)?  $default,){
final _that = this;
switch (_that) {
case _Namespace() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String>? chains,  List<String> accounts,  List<String> methods,  List<String> events)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Namespace() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String>? chains,  List<String> accounts,  List<String> methods,  List<String> events)  $default,) {final _that = this;
switch (_that) {
case _Namespace():
return $default(_that.chains,_that.accounts,_that.methods,_that.events);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String>? chains,  List<String> accounts,  List<String> methods,  List<String> events)?  $default,) {final _that = this;
switch (_that) {
case _Namespace() when $default != null:
return $default(_that.chains,_that.accounts,_that.methods,_that.events);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _Namespace implements Namespace {
  const _Namespace({final  List<String>? chains, required final  List<String> accounts, required final  List<String> methods, required final  List<String> events}): _chains = chains,_accounts = accounts,_methods = methods,_events = events;
  factory _Namespace.fromJson(Map<String, dynamic> json) => _$NamespaceFromJson(json);

 final  List<String>? _chains;
@override List<String>? get chains {
  final value = _chains;
  if (value == null) return null;
  if (_chains is EqualUnmodifiableListView) return _chains;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
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


/// Create a copy of Namespace
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NamespaceCopyWith<_Namespace> get copyWith => __$NamespaceCopyWithImpl<_Namespace>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NamespaceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Namespace&&const DeepCollectionEquality().equals(other._chains, _chains)&&const DeepCollectionEquality().equals(other._accounts, _accounts)&&const DeepCollectionEquality().equals(other._methods, _methods)&&const DeepCollectionEquality().equals(other._events, _events));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_chains),const DeepCollectionEquality().hash(_accounts),const DeepCollectionEquality().hash(_methods),const DeepCollectionEquality().hash(_events));

@override
String toString() {
  return 'Namespace(chains: $chains, accounts: $accounts, methods: $methods, events: $events)';
}


}

/// @nodoc
abstract mixin class _$NamespaceCopyWith<$Res> implements $NamespaceCopyWith<$Res> {
  factory _$NamespaceCopyWith(_Namespace value, $Res Function(_Namespace) _then) = __$NamespaceCopyWithImpl;
@override @useResult
$Res call({
 List<String>? chains, List<String> accounts, List<String> methods, List<String> events
});




}
/// @nodoc
class __$NamespaceCopyWithImpl<$Res>
    implements _$NamespaceCopyWith<$Res> {
  __$NamespaceCopyWithImpl(this._self, this._then);

  final _Namespace _self;
  final $Res Function(_Namespace) _then;

/// Create a copy of Namespace
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? chains = freezed,Object? accounts = null,Object? methods = null,Object? events = null,}) {
  return _then(_Namespace(
chains: freezed == chains ? _self._chains : chains // ignore: cast_nullable_to_non_nullable
as List<String>?,accounts: null == accounts ? _self._accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<String>,methods: null == methods ? _self._methods : methods // ignore: cast_nullable_to_non_nullable
as List<String>,events: null == events ? _self._events : events // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$SessionData {

 String get topic; String get pairingTopic; Relay get relay; int get expiry; bool get acknowledged; String get controller; Map<String, Namespace> get namespaces; ConnectionMetadata get self; ConnectionMetadata get peer; Map<String, RequiredNamespace>? get requiredNamespaces; Map<String, RequiredNamespace>? get optionalNamespaces; Map<String, String>? get sessionProperties; List<Cacao>? get authentication; TransportType get transportType;
/// Create a copy of SessionData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionDataCopyWith<SessionData> get copyWith => _$SessionDataCopyWithImpl<SessionData>(this as SessionData, _$identity);

  /// Serializes this SessionData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionData&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.pairingTopic, pairingTopic) || other.pairingTopic == pairingTopic)&&(identical(other.relay, relay) || other.relay == relay)&&(identical(other.expiry, expiry) || other.expiry == expiry)&&(identical(other.acknowledged, acknowledged) || other.acknowledged == acknowledged)&&(identical(other.controller, controller) || other.controller == controller)&&const DeepCollectionEquality().equals(other.namespaces, namespaces)&&(identical(other.self, self) || other.self == self)&&(identical(other.peer, peer) || other.peer == peer)&&const DeepCollectionEquality().equals(other.requiredNamespaces, requiredNamespaces)&&const DeepCollectionEquality().equals(other.optionalNamespaces, optionalNamespaces)&&const DeepCollectionEquality().equals(other.sessionProperties, sessionProperties)&&const DeepCollectionEquality().equals(other.authentication, authentication)&&(identical(other.transportType, transportType) || other.transportType == transportType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,topic,pairingTopic,relay,expiry,acknowledged,controller,const DeepCollectionEquality().hash(namespaces),self,peer,const DeepCollectionEquality().hash(requiredNamespaces),const DeepCollectionEquality().hash(optionalNamespaces),const DeepCollectionEquality().hash(sessionProperties),const DeepCollectionEquality().hash(authentication),transportType);

@override
String toString() {
  return 'SessionData(topic: $topic, pairingTopic: $pairingTopic, relay: $relay, expiry: $expiry, acknowledged: $acknowledged, controller: $controller, namespaces: $namespaces, self: $self, peer: $peer, requiredNamespaces: $requiredNamespaces, optionalNamespaces: $optionalNamespaces, sessionProperties: $sessionProperties, authentication: $authentication, transportType: $transportType)';
}


}

/// @nodoc
abstract mixin class $SessionDataCopyWith<$Res>  {
  factory $SessionDataCopyWith(SessionData value, $Res Function(SessionData) _then) = _$SessionDataCopyWithImpl;
@useResult
$Res call({
 String topic, String pairingTopic, Relay relay, int expiry, bool acknowledged, String controller, Map<String, Namespace> namespaces, ConnectionMetadata self, ConnectionMetadata peer, Map<String, RequiredNamespace>? requiredNamespaces, Map<String, RequiredNamespace>? optionalNamespaces, Map<String, String>? sessionProperties, List<Cacao>? authentication, TransportType transportType
});


$ConnectionMetadataCopyWith<$Res> get self;$ConnectionMetadataCopyWith<$Res> get peer;

}
/// @nodoc
class _$SessionDataCopyWithImpl<$Res>
    implements $SessionDataCopyWith<$Res> {
  _$SessionDataCopyWithImpl(this._self, this._then);

  final SessionData _self;
  final $Res Function(SessionData) _then;

/// Create a copy of SessionData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? topic = null,Object? pairingTopic = null,Object? relay = null,Object? expiry = null,Object? acknowledged = null,Object? controller = null,Object? namespaces = null,Object? self = null,Object? peer = null,Object? requiredNamespaces = freezed,Object? optionalNamespaces = freezed,Object? sessionProperties = freezed,Object? authentication = freezed,Object? transportType = null,}) {
  return _then(_self.copyWith(
topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,pairingTopic: null == pairingTopic ? _self.pairingTopic : pairingTopic // ignore: cast_nullable_to_non_nullable
as String,relay: null == relay ? _self.relay : relay // ignore: cast_nullable_to_non_nullable
as Relay,expiry: null == expiry ? _self.expiry : expiry // ignore: cast_nullable_to_non_nullable
as int,acknowledged: null == acknowledged ? _self.acknowledged : acknowledged // ignore: cast_nullable_to_non_nullable
as bool,controller: null == controller ? _self.controller : controller // ignore: cast_nullable_to_non_nullable
as String,namespaces: null == namespaces ? _self.namespaces : namespaces // ignore: cast_nullable_to_non_nullable
as Map<String, Namespace>,self: null == self ? _self.self : self // ignore: cast_nullable_to_non_nullable
as ConnectionMetadata,peer: null == peer ? _self.peer : peer // ignore: cast_nullable_to_non_nullable
as ConnectionMetadata,requiredNamespaces: freezed == requiredNamespaces ? _self.requiredNamespaces : requiredNamespaces // ignore: cast_nullable_to_non_nullable
as Map<String, RequiredNamespace>?,optionalNamespaces: freezed == optionalNamespaces ? _self.optionalNamespaces : optionalNamespaces // ignore: cast_nullable_to_non_nullable
as Map<String, RequiredNamespace>?,sessionProperties: freezed == sessionProperties ? _self.sessionProperties : sessionProperties // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,authentication: freezed == authentication ? _self.authentication : authentication // ignore: cast_nullable_to_non_nullable
as List<Cacao>?,transportType: null == transportType ? _self.transportType : transportType // ignore: cast_nullable_to_non_nullable
as TransportType,
  ));
}
/// Create a copy of SessionData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConnectionMetadataCopyWith<$Res> get self {
  
  return $ConnectionMetadataCopyWith<$Res>(_self.self, (value) {
    return _then(_self.copyWith(self: value));
  });
}/// Create a copy of SessionData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConnectionMetadataCopyWith<$Res> get peer {
  
  return $ConnectionMetadataCopyWith<$Res>(_self.peer, (value) {
    return _then(_self.copyWith(peer: value));
  });
}
}


/// Adds pattern-matching-related methods to [SessionData].
extension SessionDataPatterns on SessionData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionData value)  $default,){
final _that = this;
switch (_that) {
case _SessionData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionData value)?  $default,){
final _that = this;
switch (_that) {
case _SessionData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String topic,  String pairingTopic,  Relay relay,  int expiry,  bool acknowledged,  String controller,  Map<String, Namespace> namespaces,  ConnectionMetadata self,  ConnectionMetadata peer,  Map<String, RequiredNamespace>? requiredNamespaces,  Map<String, RequiredNamespace>? optionalNamespaces,  Map<String, String>? sessionProperties,  List<Cacao>? authentication,  TransportType transportType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionData() when $default != null:
return $default(_that.topic,_that.pairingTopic,_that.relay,_that.expiry,_that.acknowledged,_that.controller,_that.namespaces,_that.self,_that.peer,_that.requiredNamespaces,_that.optionalNamespaces,_that.sessionProperties,_that.authentication,_that.transportType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String topic,  String pairingTopic,  Relay relay,  int expiry,  bool acknowledged,  String controller,  Map<String, Namespace> namespaces,  ConnectionMetadata self,  ConnectionMetadata peer,  Map<String, RequiredNamespace>? requiredNamespaces,  Map<String, RequiredNamespace>? optionalNamespaces,  Map<String, String>? sessionProperties,  List<Cacao>? authentication,  TransportType transportType)  $default,) {final _that = this;
switch (_that) {
case _SessionData():
return $default(_that.topic,_that.pairingTopic,_that.relay,_that.expiry,_that.acknowledged,_that.controller,_that.namespaces,_that.self,_that.peer,_that.requiredNamespaces,_that.optionalNamespaces,_that.sessionProperties,_that.authentication,_that.transportType);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String topic,  String pairingTopic,  Relay relay,  int expiry,  bool acknowledged,  String controller,  Map<String, Namespace> namespaces,  ConnectionMetadata self,  ConnectionMetadata peer,  Map<String, RequiredNamespace>? requiredNamespaces,  Map<String, RequiredNamespace>? optionalNamespaces,  Map<String, String>? sessionProperties,  List<Cacao>? authentication,  TransportType transportType)?  $default,) {final _that = this;
switch (_that) {
case _SessionData() when $default != null:
return $default(_that.topic,_that.pairingTopic,_that.relay,_that.expiry,_that.acknowledged,_that.controller,_that.namespaces,_that.self,_that.peer,_that.requiredNamespaces,_that.optionalNamespaces,_that.sessionProperties,_that.authentication,_that.transportType);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _SessionData implements SessionData {
  const _SessionData({required this.topic, required this.pairingTopic, required this.relay, required this.expiry, required this.acknowledged, required this.controller, required final  Map<String, Namespace> namespaces, required this.self, required this.peer, final  Map<String, RequiredNamespace>? requiredNamespaces, final  Map<String, RequiredNamespace>? optionalNamespaces, final  Map<String, String>? sessionProperties, final  List<Cacao>? authentication, this.transportType = TransportType.relay}): _namespaces = namespaces,_requiredNamespaces = requiredNamespaces,_optionalNamespaces = optionalNamespaces,_sessionProperties = sessionProperties,_authentication = authentication;
  factory _SessionData.fromJson(Map<String, dynamic> json) => _$SessionDataFromJson(json);

@override final  String topic;
@override final  String pairingTopic;
@override final  Relay relay;
@override final  int expiry;
@override final  bool acknowledged;
@override final  String controller;
 final  Map<String, Namespace> _namespaces;
@override Map<String, Namespace> get namespaces {
  if (_namespaces is EqualUnmodifiableMapView) return _namespaces;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_namespaces);
}

@override final  ConnectionMetadata self;
@override final  ConnectionMetadata peer;
 final  Map<String, RequiredNamespace>? _requiredNamespaces;
@override Map<String, RequiredNamespace>? get requiredNamespaces {
  final value = _requiredNamespaces;
  if (value == null) return null;
  if (_requiredNamespaces is EqualUnmodifiableMapView) return _requiredNamespaces;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, RequiredNamespace>? _optionalNamespaces;
@override Map<String, RequiredNamespace>? get optionalNamespaces {
  final value = _optionalNamespaces;
  if (value == null) return null;
  if (_optionalNamespaces is EqualUnmodifiableMapView) return _optionalNamespaces;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, String>? _sessionProperties;
@override Map<String, String>? get sessionProperties {
  final value = _sessionProperties;
  if (value == null) return null;
  if (_sessionProperties is EqualUnmodifiableMapView) return _sessionProperties;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  List<Cacao>? _authentication;
@override List<Cacao>? get authentication {
  final value = _authentication;
  if (value == null) return null;
  if (_authentication is EqualUnmodifiableListView) return _authentication;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey() final  TransportType transportType;

/// Create a copy of SessionData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionDataCopyWith<_SessionData> get copyWith => __$SessionDataCopyWithImpl<_SessionData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SessionDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionData&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.pairingTopic, pairingTopic) || other.pairingTopic == pairingTopic)&&(identical(other.relay, relay) || other.relay == relay)&&(identical(other.expiry, expiry) || other.expiry == expiry)&&(identical(other.acknowledged, acknowledged) || other.acknowledged == acknowledged)&&(identical(other.controller, controller) || other.controller == controller)&&const DeepCollectionEquality().equals(other._namespaces, _namespaces)&&(identical(other.self, self) || other.self == self)&&(identical(other.peer, peer) || other.peer == peer)&&const DeepCollectionEquality().equals(other._requiredNamespaces, _requiredNamespaces)&&const DeepCollectionEquality().equals(other._optionalNamespaces, _optionalNamespaces)&&const DeepCollectionEquality().equals(other._sessionProperties, _sessionProperties)&&const DeepCollectionEquality().equals(other._authentication, _authentication)&&(identical(other.transportType, transportType) || other.transportType == transportType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,topic,pairingTopic,relay,expiry,acknowledged,controller,const DeepCollectionEquality().hash(_namespaces),self,peer,const DeepCollectionEquality().hash(_requiredNamespaces),const DeepCollectionEquality().hash(_optionalNamespaces),const DeepCollectionEquality().hash(_sessionProperties),const DeepCollectionEquality().hash(_authentication),transportType);

@override
String toString() {
  return 'SessionData(topic: $topic, pairingTopic: $pairingTopic, relay: $relay, expiry: $expiry, acknowledged: $acknowledged, controller: $controller, namespaces: $namespaces, self: $self, peer: $peer, requiredNamespaces: $requiredNamespaces, optionalNamespaces: $optionalNamespaces, sessionProperties: $sessionProperties, authentication: $authentication, transportType: $transportType)';
}


}

/// @nodoc
abstract mixin class _$SessionDataCopyWith<$Res> implements $SessionDataCopyWith<$Res> {
  factory _$SessionDataCopyWith(_SessionData value, $Res Function(_SessionData) _then) = __$SessionDataCopyWithImpl;
@override @useResult
$Res call({
 String topic, String pairingTopic, Relay relay, int expiry, bool acknowledged, String controller, Map<String, Namespace> namespaces, ConnectionMetadata self, ConnectionMetadata peer, Map<String, RequiredNamespace>? requiredNamespaces, Map<String, RequiredNamespace>? optionalNamespaces, Map<String, String>? sessionProperties, List<Cacao>? authentication, TransportType transportType
});


@override $ConnectionMetadataCopyWith<$Res> get self;@override $ConnectionMetadataCopyWith<$Res> get peer;

}
/// @nodoc
class __$SessionDataCopyWithImpl<$Res>
    implements _$SessionDataCopyWith<$Res> {
  __$SessionDataCopyWithImpl(this._self, this._then);

  final _SessionData _self;
  final $Res Function(_SessionData) _then;

/// Create a copy of SessionData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? topic = null,Object? pairingTopic = null,Object? relay = null,Object? expiry = null,Object? acknowledged = null,Object? controller = null,Object? namespaces = null,Object? self = null,Object? peer = null,Object? requiredNamespaces = freezed,Object? optionalNamespaces = freezed,Object? sessionProperties = freezed,Object? authentication = freezed,Object? transportType = null,}) {
  return _then(_SessionData(
topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,pairingTopic: null == pairingTopic ? _self.pairingTopic : pairingTopic // ignore: cast_nullable_to_non_nullable
as String,relay: null == relay ? _self.relay : relay // ignore: cast_nullable_to_non_nullable
as Relay,expiry: null == expiry ? _self.expiry : expiry // ignore: cast_nullable_to_non_nullable
as int,acknowledged: null == acknowledged ? _self.acknowledged : acknowledged // ignore: cast_nullable_to_non_nullable
as bool,controller: null == controller ? _self.controller : controller // ignore: cast_nullable_to_non_nullable
as String,namespaces: null == namespaces ? _self._namespaces : namespaces // ignore: cast_nullable_to_non_nullable
as Map<String, Namespace>,self: null == self ? _self.self : self // ignore: cast_nullable_to_non_nullable
as ConnectionMetadata,peer: null == peer ? _self.peer : peer // ignore: cast_nullable_to_non_nullable
as ConnectionMetadata,requiredNamespaces: freezed == requiredNamespaces ? _self._requiredNamespaces : requiredNamespaces // ignore: cast_nullable_to_non_nullable
as Map<String, RequiredNamespace>?,optionalNamespaces: freezed == optionalNamespaces ? _self._optionalNamespaces : optionalNamespaces // ignore: cast_nullable_to_non_nullable
as Map<String, RequiredNamespace>?,sessionProperties: freezed == sessionProperties ? _self._sessionProperties : sessionProperties // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,authentication: freezed == authentication ? _self._authentication : authentication // ignore: cast_nullable_to_non_nullable
as List<Cacao>?,transportType: null == transportType ? _self.transportType : transportType // ignore: cast_nullable_to_non_nullable
as TransportType,
  ));
}

/// Create a copy of SessionData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConnectionMetadataCopyWith<$Res> get self {
  
  return $ConnectionMetadataCopyWith<$Res>(_self.self, (value) {
    return _then(_self.copyWith(self: value));
  });
}/// Create a copy of SessionData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConnectionMetadataCopyWith<$Res> get peer {
  
  return $ConnectionMetadataCopyWith<$Res>(_self.peer, (value) {
    return _then(_self.copyWith(peer: value));
  });
}
}


/// @nodoc
mixin _$SessionRequest {

 int get id; String get topic; String get method; String get chainId; dynamic get params; VerifyContext get verifyContext; TransportType get transportType;
/// Create a copy of SessionRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionRequestCopyWith<SessionRequest> get copyWith => _$SessionRequestCopyWithImpl<SessionRequest>(this as SessionRequest, _$identity);

  /// Serializes this SessionRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.method, method) || other.method == method)&&(identical(other.chainId, chainId) || other.chainId == chainId)&&const DeepCollectionEquality().equals(other.params, params)&&(identical(other.verifyContext, verifyContext) || other.verifyContext == verifyContext)&&(identical(other.transportType, transportType) || other.transportType == transportType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,topic,method,chainId,const DeepCollectionEquality().hash(params),verifyContext,transportType);

@override
String toString() {
  return 'SessionRequest(id: $id, topic: $topic, method: $method, chainId: $chainId, params: $params, verifyContext: $verifyContext, transportType: $transportType)';
}


}

/// @nodoc
abstract mixin class $SessionRequestCopyWith<$Res>  {
  factory $SessionRequestCopyWith(SessionRequest value, $Res Function(SessionRequest) _then) = _$SessionRequestCopyWithImpl;
@useResult
$Res call({
 int id, String topic, String method, String chainId, dynamic params, VerifyContext verifyContext, TransportType transportType
});


$VerifyContextCopyWith<$Res> get verifyContext;

}
/// @nodoc
class _$SessionRequestCopyWithImpl<$Res>
    implements $SessionRequestCopyWith<$Res> {
  _$SessionRequestCopyWithImpl(this._self, this._then);

  final SessionRequest _self;
  final $Res Function(SessionRequest) _then;

/// Create a copy of SessionRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? topic = null,Object? method = null,Object? chainId = null,Object? params = freezed,Object? verifyContext = null,Object? transportType = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as String,params: freezed == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as dynamic,verifyContext: null == verifyContext ? _self.verifyContext : verifyContext // ignore: cast_nullable_to_non_nullable
as VerifyContext,transportType: null == transportType ? _self.transportType : transportType // ignore: cast_nullable_to_non_nullable
as TransportType,
  ));
}
/// Create a copy of SessionRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VerifyContextCopyWith<$Res> get verifyContext {
  
  return $VerifyContextCopyWith<$Res>(_self.verifyContext, (value) {
    return _then(_self.copyWith(verifyContext: value));
  });
}
}


/// Adds pattern-matching-related methods to [SessionRequest].
extension SessionRequestPatterns on SessionRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionRequest value)  $default,){
final _that = this;
switch (_that) {
case _SessionRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionRequest value)?  $default,){
final _that = this;
switch (_that) {
case _SessionRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String topic,  String method,  String chainId,  dynamic params,  VerifyContext verifyContext,  TransportType transportType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionRequest() when $default != null:
return $default(_that.id,_that.topic,_that.method,_that.chainId,_that.params,_that.verifyContext,_that.transportType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String topic,  String method,  String chainId,  dynamic params,  VerifyContext verifyContext,  TransportType transportType)  $default,) {final _that = this;
switch (_that) {
case _SessionRequest():
return $default(_that.id,_that.topic,_that.method,_that.chainId,_that.params,_that.verifyContext,_that.transportType);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String topic,  String method,  String chainId,  dynamic params,  VerifyContext verifyContext,  TransportType transportType)?  $default,) {final _that = this;
switch (_that) {
case _SessionRequest() when $default != null:
return $default(_that.id,_that.topic,_that.method,_that.chainId,_that.params,_that.verifyContext,_that.transportType);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable()
class _SessionRequest implements SessionRequest {
  const _SessionRequest({required this.id, required this.topic, required this.method, required this.chainId, required this.params, required this.verifyContext, this.transportType = TransportType.relay});
  factory _SessionRequest.fromJson(Map<String, dynamic> json) => _$SessionRequestFromJson(json);

@override final  int id;
@override final  String topic;
@override final  String method;
@override final  String chainId;
@override final  dynamic params;
@override final  VerifyContext verifyContext;
@override@JsonKey() final  TransportType transportType;

/// Create a copy of SessionRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionRequestCopyWith<_SessionRequest> get copyWith => __$SessionRequestCopyWithImpl<_SessionRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SessionRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.method, method) || other.method == method)&&(identical(other.chainId, chainId) || other.chainId == chainId)&&const DeepCollectionEquality().equals(other.params, params)&&(identical(other.verifyContext, verifyContext) || other.verifyContext == verifyContext)&&(identical(other.transportType, transportType) || other.transportType == transportType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,topic,method,chainId,const DeepCollectionEquality().hash(params),verifyContext,transportType);

@override
String toString() {
  return 'SessionRequest(id: $id, topic: $topic, method: $method, chainId: $chainId, params: $params, verifyContext: $verifyContext, transportType: $transportType)';
}


}

/// @nodoc
abstract mixin class _$SessionRequestCopyWith<$Res> implements $SessionRequestCopyWith<$Res> {
  factory _$SessionRequestCopyWith(_SessionRequest value, $Res Function(_SessionRequest) _then) = __$SessionRequestCopyWithImpl;
@override @useResult
$Res call({
 int id, String topic, String method, String chainId, dynamic params, VerifyContext verifyContext, TransportType transportType
});


@override $VerifyContextCopyWith<$Res> get verifyContext;

}
/// @nodoc
class __$SessionRequestCopyWithImpl<$Res>
    implements _$SessionRequestCopyWith<$Res> {
  __$SessionRequestCopyWithImpl(this._self, this._then);

  final _SessionRequest _self;
  final $Res Function(_SessionRequest) _then;

/// Create a copy of SessionRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? topic = null,Object? method = null,Object? chainId = null,Object? params = freezed,Object? verifyContext = null,Object? transportType = null,}) {
  return _then(_SessionRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as String,params: freezed == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as dynamic,verifyContext: null == verifyContext ? _self.verifyContext : verifyContext // ignore: cast_nullable_to_non_nullable
as VerifyContext,transportType: null == transportType ? _self.transportType : transportType // ignore: cast_nullable_to_non_nullable
as TransportType,
  ));
}

/// Create a copy of SessionRequest
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
