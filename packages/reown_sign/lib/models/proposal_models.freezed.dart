// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'proposal_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RequiredNamespace {

 List<String>? get chains; List<String> get methods; List<String> get events;
/// Create a copy of RequiredNamespace
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RequiredNamespaceCopyWith<RequiredNamespace> get copyWith => _$RequiredNamespaceCopyWithImpl<RequiredNamespace>(this as RequiredNamespace, _$identity);

  /// Serializes this RequiredNamespace to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequiredNamespace&&const DeepCollectionEquality().equals(other.chains, chains)&&const DeepCollectionEquality().equals(other.methods, methods)&&const DeepCollectionEquality().equals(other.events, events));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(chains),const DeepCollectionEquality().hash(methods),const DeepCollectionEquality().hash(events));

@override
String toString() {
  return 'RequiredNamespace(chains: $chains, methods: $methods, events: $events)';
}


}

/// @nodoc
abstract mixin class $RequiredNamespaceCopyWith<$Res>  {
  factory $RequiredNamespaceCopyWith(RequiredNamespace value, $Res Function(RequiredNamespace) _then) = _$RequiredNamespaceCopyWithImpl;
@useResult
$Res call({
 List<String>? chains, List<String> methods, List<String> events
});




}
/// @nodoc
class _$RequiredNamespaceCopyWithImpl<$Res>
    implements $RequiredNamespaceCopyWith<$Res> {
  _$RequiredNamespaceCopyWithImpl(this._self, this._then);

  final RequiredNamespace _self;
  final $Res Function(RequiredNamespace) _then;

/// Create a copy of RequiredNamespace
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? chains = freezed,Object? methods = null,Object? events = null,}) {
  return _then(_self.copyWith(
chains: freezed == chains ? _self.chains : chains // ignore: cast_nullable_to_non_nullable
as List<String>?,methods: null == methods ? _self.methods : methods // ignore: cast_nullable_to_non_nullable
as List<String>,events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [RequiredNamespace].
extension RequiredNamespacePatterns on RequiredNamespace {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RequiredNamespace value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RequiredNamespace() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RequiredNamespace value)  $default,){
final _that = this;
switch (_that) {
case _RequiredNamespace():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RequiredNamespace value)?  $default,){
final _that = this;
switch (_that) {
case _RequiredNamespace() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String>? chains,  List<String> methods,  List<String> events)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RequiredNamespace() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String>? chains,  List<String> methods,  List<String> events)  $default,) {final _that = this;
switch (_that) {
case _RequiredNamespace():
return $default(_that.chains,_that.methods,_that.events);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String>? chains,  List<String> methods,  List<String> events)?  $default,) {final _that = this;
switch (_that) {
case _RequiredNamespace() when $default != null:
return $default(_that.chains,_that.methods,_that.events);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _RequiredNamespace implements RequiredNamespace {
  const _RequiredNamespace({final  List<String>? chains, required final  List<String> methods, required final  List<String> events}): _chains = chains,_methods = methods,_events = events;
  factory _RequiredNamespace.fromJson(Map<String, dynamic> json) => _$RequiredNamespaceFromJson(json);

 final  List<String>? _chains;
@override List<String>? get chains {
  final value = _chains;
  if (value == null) return null;
  if (_chains is EqualUnmodifiableListView) return _chains;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
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


/// Create a copy of RequiredNamespace
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RequiredNamespaceCopyWith<_RequiredNamespace> get copyWith => __$RequiredNamespaceCopyWithImpl<_RequiredNamespace>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RequiredNamespaceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RequiredNamespace&&const DeepCollectionEquality().equals(other._chains, _chains)&&const DeepCollectionEquality().equals(other._methods, _methods)&&const DeepCollectionEquality().equals(other._events, _events));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_chains),const DeepCollectionEquality().hash(_methods),const DeepCollectionEquality().hash(_events));

@override
String toString() {
  return 'RequiredNamespace(chains: $chains, methods: $methods, events: $events)';
}


}

/// @nodoc
abstract mixin class _$RequiredNamespaceCopyWith<$Res> implements $RequiredNamespaceCopyWith<$Res> {
  factory _$RequiredNamespaceCopyWith(_RequiredNamespace value, $Res Function(_RequiredNamespace) _then) = __$RequiredNamespaceCopyWithImpl;
@override @useResult
$Res call({
 List<String>? chains, List<String> methods, List<String> events
});




}
/// @nodoc
class __$RequiredNamespaceCopyWithImpl<$Res>
    implements _$RequiredNamespaceCopyWith<$Res> {
  __$RequiredNamespaceCopyWithImpl(this._self, this._then);

  final _RequiredNamespace _self;
  final $Res Function(_RequiredNamespace) _then;

/// Create a copy of RequiredNamespace
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? chains = freezed,Object? methods = null,Object? events = null,}) {
  return _then(_RequiredNamespace(
chains: freezed == chains ? _self._chains : chains // ignore: cast_nullable_to_non_nullable
as List<String>?,methods: null == methods ? _self._methods : methods // ignore: cast_nullable_to_non_nullable
as List<String>,events: null == events ? _self._events : events // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$SessionProposal {

 int get id; ProposalData get params;
/// Create a copy of SessionProposal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionProposalCopyWith<SessionProposal> get copyWith => _$SessionProposalCopyWithImpl<SessionProposal>(this as SessionProposal, _$identity);

  /// Serializes this SessionProposal to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionProposal&&(identical(other.id, id) || other.id == id)&&(identical(other.params, params) || other.params == params));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,params);

@override
String toString() {
  return 'SessionProposal(id: $id, params: $params)';
}


}

/// @nodoc
abstract mixin class $SessionProposalCopyWith<$Res>  {
  factory $SessionProposalCopyWith(SessionProposal value, $Res Function(SessionProposal) _then) = _$SessionProposalCopyWithImpl;
@useResult
$Res call({
 int id, ProposalData params
});


$ProposalDataCopyWith<$Res> get params;

}
/// @nodoc
class _$SessionProposalCopyWithImpl<$Res>
    implements $SessionProposalCopyWith<$Res> {
  _$SessionProposalCopyWithImpl(this._self, this._then);

  final SessionProposal _self;
  final $Res Function(SessionProposal) _then;

/// Create a copy of SessionProposal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? params = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,params: null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as ProposalData,
  ));
}
/// Create a copy of SessionProposal
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProposalDataCopyWith<$Res> get params {
  
  return $ProposalDataCopyWith<$Res>(_self.params, (value) {
    return _then(_self.copyWith(params: value));
  });
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  ProposalData params)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionProposal() when $default != null:
return $default(_that.id,_that.params);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  ProposalData params)  $default,) {final _that = this;
switch (_that) {
case _SessionProposal():
return $default(_that.id,_that.params);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  ProposalData params)?  $default,) {final _that = this;
switch (_that) {
case _SessionProposal() when $default != null:
return $default(_that.id,_that.params);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable()
class _SessionProposal implements SessionProposal {
  const _SessionProposal({required this.id, required this.params});
  factory _SessionProposal.fromJson(Map<String, dynamic> json) => _$SessionProposalFromJson(json);

@override final  int id;
@override final  ProposalData params;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionProposal&&(identical(other.id, id) || other.id == id)&&(identical(other.params, params) || other.params == params));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,params);

@override
String toString() {
  return 'SessionProposal(id: $id, params: $params)';
}


}

/// @nodoc
abstract mixin class _$SessionProposalCopyWith<$Res> implements $SessionProposalCopyWith<$Res> {
  factory _$SessionProposalCopyWith(_SessionProposal value, $Res Function(_SessionProposal) _then) = __$SessionProposalCopyWithImpl;
@override @useResult
$Res call({
 int id, ProposalData params
});


@override $ProposalDataCopyWith<$Res> get params;

}
/// @nodoc
class __$SessionProposalCopyWithImpl<$Res>
    implements _$SessionProposalCopyWith<$Res> {
  __$SessionProposalCopyWithImpl(this._self, this._then);

  final _SessionProposal _self;
  final $Res Function(_SessionProposal) _then;

/// Create a copy of SessionProposal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? params = null,}) {
  return _then(_SessionProposal(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,params: null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as ProposalData,
  ));
}

/// Create a copy of SessionProposal
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProposalDataCopyWith<$Res> get params {
  
  return $ProposalDataCopyWith<$Res>(_self.params, (value) {
    return _then(_self.copyWith(params: value));
  });
}
}


/// @nodoc
mixin _$ProposalData {

 int get id; int get expiry; List<Relay> get relays; ConnectionMetadata get proposer; Map<String, RequiredNamespace> get requiredNamespaces; Map<String, RequiredNamespace> get optionalNamespaces; String get pairingTopic; Map<String, String>? get sessionProperties; Map<String, Namespace>? get generatedNamespaces;
/// Create a copy of ProposalData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProposalDataCopyWith<ProposalData> get copyWith => _$ProposalDataCopyWithImpl<ProposalData>(this as ProposalData, _$identity);

  /// Serializes this ProposalData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProposalData&&(identical(other.id, id) || other.id == id)&&(identical(other.expiry, expiry) || other.expiry == expiry)&&const DeepCollectionEquality().equals(other.relays, relays)&&(identical(other.proposer, proposer) || other.proposer == proposer)&&const DeepCollectionEquality().equals(other.requiredNamespaces, requiredNamespaces)&&const DeepCollectionEquality().equals(other.optionalNamespaces, optionalNamespaces)&&(identical(other.pairingTopic, pairingTopic) || other.pairingTopic == pairingTopic)&&const DeepCollectionEquality().equals(other.sessionProperties, sessionProperties)&&const DeepCollectionEquality().equals(other.generatedNamespaces, generatedNamespaces));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,expiry,const DeepCollectionEquality().hash(relays),proposer,const DeepCollectionEquality().hash(requiredNamespaces),const DeepCollectionEquality().hash(optionalNamespaces),pairingTopic,const DeepCollectionEquality().hash(sessionProperties),const DeepCollectionEquality().hash(generatedNamespaces));

@override
String toString() {
  return 'ProposalData(id: $id, expiry: $expiry, relays: $relays, proposer: $proposer, requiredNamespaces: $requiredNamespaces, optionalNamespaces: $optionalNamespaces, pairingTopic: $pairingTopic, sessionProperties: $sessionProperties, generatedNamespaces: $generatedNamespaces)';
}


}

/// @nodoc
abstract mixin class $ProposalDataCopyWith<$Res>  {
  factory $ProposalDataCopyWith(ProposalData value, $Res Function(ProposalData) _then) = _$ProposalDataCopyWithImpl;
@useResult
$Res call({
 int id, int expiry, List<Relay> relays, ConnectionMetadata proposer, Map<String, RequiredNamespace> requiredNamespaces, Map<String, RequiredNamespace> optionalNamespaces, String pairingTopic, Map<String, String>? sessionProperties, Map<String, Namespace>? generatedNamespaces
});


$ConnectionMetadataCopyWith<$Res> get proposer;

}
/// @nodoc
class _$ProposalDataCopyWithImpl<$Res>
    implements $ProposalDataCopyWith<$Res> {
  _$ProposalDataCopyWithImpl(this._self, this._then);

  final ProposalData _self;
  final $Res Function(ProposalData) _then;

/// Create a copy of ProposalData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? expiry = null,Object? relays = null,Object? proposer = null,Object? requiredNamespaces = null,Object? optionalNamespaces = null,Object? pairingTopic = null,Object? sessionProperties = freezed,Object? generatedNamespaces = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,expiry: null == expiry ? _self.expiry : expiry // ignore: cast_nullable_to_non_nullable
as int,relays: null == relays ? _self.relays : relays // ignore: cast_nullable_to_non_nullable
as List<Relay>,proposer: null == proposer ? _self.proposer : proposer // ignore: cast_nullable_to_non_nullable
as ConnectionMetadata,requiredNamespaces: null == requiredNamespaces ? _self.requiredNamespaces : requiredNamespaces // ignore: cast_nullable_to_non_nullable
as Map<String, RequiredNamespace>,optionalNamespaces: null == optionalNamespaces ? _self.optionalNamespaces : optionalNamespaces // ignore: cast_nullable_to_non_nullable
as Map<String, RequiredNamespace>,pairingTopic: null == pairingTopic ? _self.pairingTopic : pairingTopic // ignore: cast_nullable_to_non_nullable
as String,sessionProperties: freezed == sessionProperties ? _self.sessionProperties : sessionProperties // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,generatedNamespaces: freezed == generatedNamespaces ? _self.generatedNamespaces : generatedNamespaces // ignore: cast_nullable_to_non_nullable
as Map<String, Namespace>?,
  ));
}
/// Create a copy of ProposalData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConnectionMetadataCopyWith<$Res> get proposer {
  
  return $ConnectionMetadataCopyWith<$Res>(_self.proposer, (value) {
    return _then(_self.copyWith(proposer: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProposalData].
extension ProposalDataPatterns on ProposalData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProposalData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProposalData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProposalData value)  $default,){
final _that = this;
switch (_that) {
case _ProposalData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProposalData value)?  $default,){
final _that = this;
switch (_that) {
case _ProposalData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int expiry,  List<Relay> relays,  ConnectionMetadata proposer,  Map<String, RequiredNamespace> requiredNamespaces,  Map<String, RequiredNamespace> optionalNamespaces,  String pairingTopic,  Map<String, String>? sessionProperties,  Map<String, Namespace>? generatedNamespaces)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProposalData() when $default != null:
return $default(_that.id,_that.expiry,_that.relays,_that.proposer,_that.requiredNamespaces,_that.optionalNamespaces,_that.pairingTopic,_that.sessionProperties,_that.generatedNamespaces);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int expiry,  List<Relay> relays,  ConnectionMetadata proposer,  Map<String, RequiredNamespace> requiredNamespaces,  Map<String, RequiredNamespace> optionalNamespaces,  String pairingTopic,  Map<String, String>? sessionProperties,  Map<String, Namespace>? generatedNamespaces)  $default,) {final _that = this;
switch (_that) {
case _ProposalData():
return $default(_that.id,_that.expiry,_that.relays,_that.proposer,_that.requiredNamespaces,_that.optionalNamespaces,_that.pairingTopic,_that.sessionProperties,_that.generatedNamespaces);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int expiry,  List<Relay> relays,  ConnectionMetadata proposer,  Map<String, RequiredNamespace> requiredNamespaces,  Map<String, RequiredNamespace> optionalNamespaces,  String pairingTopic,  Map<String, String>? sessionProperties,  Map<String, Namespace>? generatedNamespaces)?  $default,) {final _that = this;
switch (_that) {
case _ProposalData() when $default != null:
return $default(_that.id,_that.expiry,_that.relays,_that.proposer,_that.requiredNamespaces,_that.optionalNamespaces,_that.pairingTopic,_that.sessionProperties,_that.generatedNamespaces);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _ProposalData implements ProposalData {
  const _ProposalData({required this.id, required this.expiry, required final  List<Relay> relays, required this.proposer, required final  Map<String, RequiredNamespace> requiredNamespaces, required final  Map<String, RequiredNamespace> optionalNamespaces, required this.pairingTopic, final  Map<String, String>? sessionProperties, final  Map<String, Namespace>? generatedNamespaces}): _relays = relays,_requiredNamespaces = requiredNamespaces,_optionalNamespaces = optionalNamespaces,_sessionProperties = sessionProperties,_generatedNamespaces = generatedNamespaces;
  factory _ProposalData.fromJson(Map<String, dynamic> json) => _$ProposalDataFromJson(json);

@override final  int id;
@override final  int expiry;
 final  List<Relay> _relays;
@override List<Relay> get relays {
  if (_relays is EqualUnmodifiableListView) return _relays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_relays);
}

@override final  ConnectionMetadata proposer;
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

@override final  String pairingTopic;
 final  Map<String, String>? _sessionProperties;
@override Map<String, String>? get sessionProperties {
  final value = _sessionProperties;
  if (value == null) return null;
  if (_sessionProperties is EqualUnmodifiableMapView) return _sessionProperties;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, Namespace>? _generatedNamespaces;
@override Map<String, Namespace>? get generatedNamespaces {
  final value = _generatedNamespaces;
  if (value == null) return null;
  if (_generatedNamespaces is EqualUnmodifiableMapView) return _generatedNamespaces;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of ProposalData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProposalDataCopyWith<_ProposalData> get copyWith => __$ProposalDataCopyWithImpl<_ProposalData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProposalDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProposalData&&(identical(other.id, id) || other.id == id)&&(identical(other.expiry, expiry) || other.expiry == expiry)&&const DeepCollectionEquality().equals(other._relays, _relays)&&(identical(other.proposer, proposer) || other.proposer == proposer)&&const DeepCollectionEquality().equals(other._requiredNamespaces, _requiredNamespaces)&&const DeepCollectionEquality().equals(other._optionalNamespaces, _optionalNamespaces)&&(identical(other.pairingTopic, pairingTopic) || other.pairingTopic == pairingTopic)&&const DeepCollectionEquality().equals(other._sessionProperties, _sessionProperties)&&const DeepCollectionEquality().equals(other._generatedNamespaces, _generatedNamespaces));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,expiry,const DeepCollectionEquality().hash(_relays),proposer,const DeepCollectionEquality().hash(_requiredNamespaces),const DeepCollectionEquality().hash(_optionalNamespaces),pairingTopic,const DeepCollectionEquality().hash(_sessionProperties),const DeepCollectionEquality().hash(_generatedNamespaces));

@override
String toString() {
  return 'ProposalData(id: $id, expiry: $expiry, relays: $relays, proposer: $proposer, requiredNamespaces: $requiredNamespaces, optionalNamespaces: $optionalNamespaces, pairingTopic: $pairingTopic, sessionProperties: $sessionProperties, generatedNamespaces: $generatedNamespaces)';
}


}

/// @nodoc
abstract mixin class _$ProposalDataCopyWith<$Res> implements $ProposalDataCopyWith<$Res> {
  factory _$ProposalDataCopyWith(_ProposalData value, $Res Function(_ProposalData) _then) = __$ProposalDataCopyWithImpl;
@override @useResult
$Res call({
 int id, int expiry, List<Relay> relays, ConnectionMetadata proposer, Map<String, RequiredNamespace> requiredNamespaces, Map<String, RequiredNamespace> optionalNamespaces, String pairingTopic, Map<String, String>? sessionProperties, Map<String, Namespace>? generatedNamespaces
});


@override $ConnectionMetadataCopyWith<$Res> get proposer;

}
/// @nodoc
class __$ProposalDataCopyWithImpl<$Res>
    implements _$ProposalDataCopyWith<$Res> {
  __$ProposalDataCopyWithImpl(this._self, this._then);

  final _ProposalData _self;
  final $Res Function(_ProposalData) _then;

/// Create a copy of ProposalData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? expiry = null,Object? relays = null,Object? proposer = null,Object? requiredNamespaces = null,Object? optionalNamespaces = null,Object? pairingTopic = null,Object? sessionProperties = freezed,Object? generatedNamespaces = freezed,}) {
  return _then(_ProposalData(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,expiry: null == expiry ? _self.expiry : expiry // ignore: cast_nullable_to_non_nullable
as int,relays: null == relays ? _self._relays : relays // ignore: cast_nullable_to_non_nullable
as List<Relay>,proposer: null == proposer ? _self.proposer : proposer // ignore: cast_nullable_to_non_nullable
as ConnectionMetadata,requiredNamespaces: null == requiredNamespaces ? _self._requiredNamespaces : requiredNamespaces // ignore: cast_nullable_to_non_nullable
as Map<String, RequiredNamespace>,optionalNamespaces: null == optionalNamespaces ? _self._optionalNamespaces : optionalNamespaces // ignore: cast_nullable_to_non_nullable
as Map<String, RequiredNamespace>,pairingTopic: null == pairingTopic ? _self.pairingTopic : pairingTopic // ignore: cast_nullable_to_non_nullable
as String,sessionProperties: freezed == sessionProperties ? _self._sessionProperties : sessionProperties // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,generatedNamespaces: freezed == generatedNamespaces ? _self._generatedNamespaces : generatedNamespaces // ignore: cast_nullable_to_non_nullable
as Map<String, Namespace>?,
  ));
}

/// Create a copy of ProposalData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConnectionMetadataCopyWith<$Res> get proposer {
  
  return $ConnectionMetadataCopyWith<$Res>(_self.proposer, (value) {
    return _then(_self.copyWith(proposer: value));
  });
}
}

// dart format on
