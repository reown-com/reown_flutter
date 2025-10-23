// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'basic_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CoreEventProperties {

 String? get message; String? get name; String? get method; bool? get connected; String? get namespace; String? get network; String? get caipNetworkId; String? get explorerId; int? get walletRank; int? get displayIndex; String? get view; String? get provider; String? get platform; List<String>? get trace; String? get topic; int? get correlation_id; String? get client_id; String? get direction; String? get userAgent; String? get token; String? get amount; String? get hash; String? get address; String? get project_id; String? get cursor; Map<String, String>? get exchange; Map<String, String>? get configuration; Map<String, String>? get currentPayment; String? get source; bool? get headless; bool? get reconnect; String? get link; String? get linkType; bool? get showWallets; Map<String, dynamic>? get siweConfig; String? get themeMode;//   themeVariables?: ThemeVariables
//   allowUnsupportedChain?: boolean
 List<String>? get networks; String? get defaultNetwork; List<String>? get chainImages;//   connectorImages?: Record<string, string>
//   coinbasePreference?: 'all' | 'smartWalletOnly' | 'eoaOnly'
 Map<String, dynamic>? get metadata; String? get accountType; String? get query; bool? get certified; bool? get installed;
/// Create a copy of CoreEventProperties
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CoreEventPropertiesCopyWith<CoreEventProperties> get copyWith => _$CoreEventPropertiesCopyWithImpl<CoreEventProperties>(this as CoreEventProperties, _$identity);

  /// Serializes this CoreEventProperties to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoreEventProperties&&(identical(other.message, message) || other.message == message)&&(identical(other.name, name) || other.name == name)&&(identical(other.method, method) || other.method == method)&&(identical(other.connected, connected) || other.connected == connected)&&(identical(other.namespace, namespace) || other.namespace == namespace)&&(identical(other.network, network) || other.network == network)&&(identical(other.caipNetworkId, caipNetworkId) || other.caipNetworkId == caipNetworkId)&&(identical(other.explorerId, explorerId) || other.explorerId == explorerId)&&(identical(other.walletRank, walletRank) || other.walletRank == walletRank)&&(identical(other.displayIndex, displayIndex) || other.displayIndex == displayIndex)&&(identical(other.view, view) || other.view == view)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.platform, platform) || other.platform == platform)&&const DeepCollectionEquality().equals(other.trace, trace)&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.correlation_id, correlation_id) || other.correlation_id == correlation_id)&&(identical(other.client_id, client_id) || other.client_id == client_id)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.userAgent, userAgent) || other.userAgent == userAgent)&&(identical(other.token, token) || other.token == token)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.hash, hash) || other.hash == hash)&&(identical(other.address, address) || other.address == address)&&(identical(other.project_id, project_id) || other.project_id == project_id)&&(identical(other.cursor, cursor) || other.cursor == cursor)&&const DeepCollectionEquality().equals(other.exchange, exchange)&&const DeepCollectionEquality().equals(other.configuration, configuration)&&const DeepCollectionEquality().equals(other.currentPayment, currentPayment)&&(identical(other.source, source) || other.source == source)&&(identical(other.headless, headless) || other.headless == headless)&&(identical(other.reconnect, reconnect) || other.reconnect == reconnect)&&(identical(other.link, link) || other.link == link)&&(identical(other.linkType, linkType) || other.linkType == linkType)&&(identical(other.showWallets, showWallets) || other.showWallets == showWallets)&&const DeepCollectionEquality().equals(other.siweConfig, siweConfig)&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&const DeepCollectionEquality().equals(other.networks, networks)&&(identical(other.defaultNetwork, defaultNetwork) || other.defaultNetwork == defaultNetwork)&&const DeepCollectionEquality().equals(other.chainImages, chainImages)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.accountType, accountType) || other.accountType == accountType)&&(identical(other.query, query) || other.query == query)&&(identical(other.certified, certified) || other.certified == certified)&&(identical(other.installed, installed) || other.installed == installed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,message,name,method,connected,namespace,network,caipNetworkId,explorerId,walletRank,displayIndex,view,provider,platform,const DeepCollectionEquality().hash(trace),topic,correlation_id,client_id,direction,userAgent,token,amount,hash,address,project_id,cursor,const DeepCollectionEquality().hash(exchange),const DeepCollectionEquality().hash(configuration),const DeepCollectionEquality().hash(currentPayment),source,headless,reconnect,link,linkType,showWallets,const DeepCollectionEquality().hash(siweConfig),themeMode,const DeepCollectionEquality().hash(networks),defaultNetwork,const DeepCollectionEquality().hash(chainImages),const DeepCollectionEquality().hash(metadata),accountType,query,certified,installed]);

@override
String toString() {
  return 'CoreEventProperties(message: $message, name: $name, method: $method, connected: $connected, namespace: $namespace, network: $network, caipNetworkId: $caipNetworkId, explorerId: $explorerId, walletRank: $walletRank, displayIndex: $displayIndex, view: $view, provider: $provider, platform: $platform, trace: $trace, topic: $topic, correlation_id: $correlation_id, client_id: $client_id, direction: $direction, userAgent: $userAgent, token: $token, amount: $amount, hash: $hash, address: $address, project_id: $project_id, cursor: $cursor, exchange: $exchange, configuration: $configuration, currentPayment: $currentPayment, source: $source, headless: $headless, reconnect: $reconnect, link: $link, linkType: $linkType, showWallets: $showWallets, siweConfig: $siweConfig, themeMode: $themeMode, networks: $networks, defaultNetwork: $defaultNetwork, chainImages: $chainImages, metadata: $metadata, accountType: $accountType, query: $query, certified: $certified, installed: $installed)';
}


}

/// @nodoc
abstract mixin class $CoreEventPropertiesCopyWith<$Res>  {
  factory $CoreEventPropertiesCopyWith(CoreEventProperties value, $Res Function(CoreEventProperties) _then) = _$CoreEventPropertiesCopyWithImpl;
@useResult
$Res call({
 String? message, String? name, String? method, bool? connected, String? namespace, String? network, String? caipNetworkId, String? explorerId, int? walletRank, int? displayIndex, String? view, String? provider, String? platform, List<String>? trace, String? topic, int? correlation_id, String? client_id, String? direction, String? userAgent, String? token, String? amount, String? hash, String? address, String? project_id, String? cursor, Map<String, String>? exchange, Map<String, String>? configuration, Map<String, String>? currentPayment, String? source, bool? headless, bool? reconnect, String? link, String? linkType, bool? showWallets, Map<String, dynamic>? siweConfig, String? themeMode, List<String>? networks, String? defaultNetwork, List<String>? chainImages, Map<String, dynamic>? metadata, String? accountType, String? query, bool? certified, bool? installed
});




}
/// @nodoc
class _$CoreEventPropertiesCopyWithImpl<$Res>
    implements $CoreEventPropertiesCopyWith<$Res> {
  _$CoreEventPropertiesCopyWithImpl(this._self, this._then);

  final CoreEventProperties _self;
  final $Res Function(CoreEventProperties) _then;

/// Create a copy of CoreEventProperties
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = freezed,Object? name = freezed,Object? method = freezed,Object? connected = freezed,Object? namespace = freezed,Object? network = freezed,Object? caipNetworkId = freezed,Object? explorerId = freezed,Object? walletRank = freezed,Object? displayIndex = freezed,Object? view = freezed,Object? provider = freezed,Object? platform = freezed,Object? trace = freezed,Object? topic = freezed,Object? correlation_id = freezed,Object? client_id = freezed,Object? direction = freezed,Object? userAgent = freezed,Object? token = freezed,Object? amount = freezed,Object? hash = freezed,Object? address = freezed,Object? project_id = freezed,Object? cursor = freezed,Object? exchange = freezed,Object? configuration = freezed,Object? currentPayment = freezed,Object? source = freezed,Object? headless = freezed,Object? reconnect = freezed,Object? link = freezed,Object? linkType = freezed,Object? showWallets = freezed,Object? siweConfig = freezed,Object? themeMode = freezed,Object? networks = freezed,Object? defaultNetwork = freezed,Object? chainImages = freezed,Object? metadata = freezed,Object? accountType = freezed,Object? query = freezed,Object? certified = freezed,Object? installed = freezed,}) {
  return _then(_self.copyWith(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,method: freezed == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String?,connected: freezed == connected ? _self.connected : connected // ignore: cast_nullable_to_non_nullable
as bool?,namespace: freezed == namespace ? _self.namespace : namespace // ignore: cast_nullable_to_non_nullable
as String?,network: freezed == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String?,caipNetworkId: freezed == caipNetworkId ? _self.caipNetworkId : caipNetworkId // ignore: cast_nullable_to_non_nullable
as String?,explorerId: freezed == explorerId ? _self.explorerId : explorerId // ignore: cast_nullable_to_non_nullable
as String?,walletRank: freezed == walletRank ? _self.walletRank : walletRank // ignore: cast_nullable_to_non_nullable
as int?,displayIndex: freezed == displayIndex ? _self.displayIndex : displayIndex // ignore: cast_nullable_to_non_nullable
as int?,view: freezed == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as String?,provider: freezed == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String?,platform: freezed == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String?,trace: freezed == trace ? _self.trace : trace // ignore: cast_nullable_to_non_nullable
as List<String>?,topic: freezed == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String?,correlation_id: freezed == correlation_id ? _self.correlation_id : correlation_id // ignore: cast_nullable_to_non_nullable
as int?,client_id: freezed == client_id ? _self.client_id : client_id // ignore: cast_nullable_to_non_nullable
as String?,direction: freezed == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String?,userAgent: freezed == userAgent ? _self.userAgent : userAgent // ignore: cast_nullable_to_non_nullable
as String?,token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String?,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String?,hash: freezed == hash ? _self.hash : hash // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,project_id: freezed == project_id ? _self.project_id : project_id // ignore: cast_nullable_to_non_nullable
as String?,cursor: freezed == cursor ? _self.cursor : cursor // ignore: cast_nullable_to_non_nullable
as String?,exchange: freezed == exchange ? _self.exchange : exchange // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,configuration: freezed == configuration ? _self.configuration : configuration // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,currentPayment: freezed == currentPayment ? _self.currentPayment : currentPayment // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,headless: freezed == headless ? _self.headless : headless // ignore: cast_nullable_to_non_nullable
as bool?,reconnect: freezed == reconnect ? _self.reconnect : reconnect // ignore: cast_nullable_to_non_nullable
as bool?,link: freezed == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String?,linkType: freezed == linkType ? _self.linkType : linkType // ignore: cast_nullable_to_non_nullable
as String?,showWallets: freezed == showWallets ? _self.showWallets : showWallets // ignore: cast_nullable_to_non_nullable
as bool?,siweConfig: freezed == siweConfig ? _self.siweConfig : siweConfig // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,themeMode: freezed == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as String?,networks: freezed == networks ? _self.networks : networks // ignore: cast_nullable_to_non_nullable
as List<String>?,defaultNetwork: freezed == defaultNetwork ? _self.defaultNetwork : defaultNetwork // ignore: cast_nullable_to_non_nullable
as String?,chainImages: freezed == chainImages ? _self.chainImages : chainImages // ignore: cast_nullable_to_non_nullable
as List<String>?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,accountType: freezed == accountType ? _self.accountType : accountType // ignore: cast_nullable_to_non_nullable
as String?,query: freezed == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String?,certified: freezed == certified ? _self.certified : certified // ignore: cast_nullable_to_non_nullable
as bool?,installed: freezed == installed ? _self.installed : installed // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [CoreEventProperties].
extension CoreEventPropertiesPatterns on CoreEventProperties {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CoreEventProperties value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CoreEventProperties() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CoreEventProperties value)  $default,){
final _that = this;
switch (_that) {
case _CoreEventProperties():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CoreEventProperties value)?  $default,){
final _that = this;
switch (_that) {
case _CoreEventProperties() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? message,  String? name,  String? method,  bool? connected,  String? namespace,  String? network,  String? caipNetworkId,  String? explorerId,  int? walletRank,  int? displayIndex,  String? view,  String? provider,  String? platform,  List<String>? trace,  String? topic,  int? correlation_id,  String? client_id,  String? direction,  String? userAgent,  String? token,  String? amount,  String? hash,  String? address,  String? project_id,  String? cursor,  Map<String, String>? exchange,  Map<String, String>? configuration,  Map<String, String>? currentPayment,  String? source,  bool? headless,  bool? reconnect,  String? link,  String? linkType,  bool? showWallets,  Map<String, dynamic>? siweConfig,  String? themeMode,  List<String>? networks,  String? defaultNetwork,  List<String>? chainImages,  Map<String, dynamic>? metadata,  String? accountType,  String? query,  bool? certified,  bool? installed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CoreEventProperties() when $default != null:
return $default(_that.message,_that.name,_that.method,_that.connected,_that.namespace,_that.network,_that.caipNetworkId,_that.explorerId,_that.walletRank,_that.displayIndex,_that.view,_that.provider,_that.platform,_that.trace,_that.topic,_that.correlation_id,_that.client_id,_that.direction,_that.userAgent,_that.token,_that.amount,_that.hash,_that.address,_that.project_id,_that.cursor,_that.exchange,_that.configuration,_that.currentPayment,_that.source,_that.headless,_that.reconnect,_that.link,_that.linkType,_that.showWallets,_that.siweConfig,_that.themeMode,_that.networks,_that.defaultNetwork,_that.chainImages,_that.metadata,_that.accountType,_that.query,_that.certified,_that.installed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? message,  String? name,  String? method,  bool? connected,  String? namespace,  String? network,  String? caipNetworkId,  String? explorerId,  int? walletRank,  int? displayIndex,  String? view,  String? provider,  String? platform,  List<String>? trace,  String? topic,  int? correlation_id,  String? client_id,  String? direction,  String? userAgent,  String? token,  String? amount,  String? hash,  String? address,  String? project_id,  String? cursor,  Map<String, String>? exchange,  Map<String, String>? configuration,  Map<String, String>? currentPayment,  String? source,  bool? headless,  bool? reconnect,  String? link,  String? linkType,  bool? showWallets,  Map<String, dynamic>? siweConfig,  String? themeMode,  List<String>? networks,  String? defaultNetwork,  List<String>? chainImages,  Map<String, dynamic>? metadata,  String? accountType,  String? query,  bool? certified,  bool? installed)  $default,) {final _that = this;
switch (_that) {
case _CoreEventProperties():
return $default(_that.message,_that.name,_that.method,_that.connected,_that.namespace,_that.network,_that.caipNetworkId,_that.explorerId,_that.walletRank,_that.displayIndex,_that.view,_that.provider,_that.platform,_that.trace,_that.topic,_that.correlation_id,_that.client_id,_that.direction,_that.userAgent,_that.token,_that.amount,_that.hash,_that.address,_that.project_id,_that.cursor,_that.exchange,_that.configuration,_that.currentPayment,_that.source,_that.headless,_that.reconnect,_that.link,_that.linkType,_that.showWallets,_that.siweConfig,_that.themeMode,_that.networks,_that.defaultNetwork,_that.chainImages,_that.metadata,_that.accountType,_that.query,_that.certified,_that.installed);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? message,  String? name,  String? method,  bool? connected,  String? namespace,  String? network,  String? caipNetworkId,  String? explorerId,  int? walletRank,  int? displayIndex,  String? view,  String? provider,  String? platform,  List<String>? trace,  String? topic,  int? correlation_id,  String? client_id,  String? direction,  String? userAgent,  String? token,  String? amount,  String? hash,  String? address,  String? project_id,  String? cursor,  Map<String, String>? exchange,  Map<String, String>? configuration,  Map<String, String>? currentPayment,  String? source,  bool? headless,  bool? reconnect,  String? link,  String? linkType,  bool? showWallets,  Map<String, dynamic>? siweConfig,  String? themeMode,  List<String>? networks,  String? defaultNetwork,  List<String>? chainImages,  Map<String, dynamic>? metadata,  String? accountType,  String? query,  bool? certified,  bool? installed)?  $default,) {final _that = this;
switch (_that) {
case _CoreEventProperties() when $default != null:
return $default(_that.message,_that.name,_that.method,_that.connected,_that.namespace,_that.network,_that.caipNetworkId,_that.explorerId,_that.walletRank,_that.displayIndex,_that.view,_that.provider,_that.platform,_that.trace,_that.topic,_that.correlation_id,_that.client_id,_that.direction,_that.userAgent,_that.token,_that.amount,_that.hash,_that.address,_that.project_id,_that.cursor,_that.exchange,_that.configuration,_that.currentPayment,_that.source,_that.headless,_that.reconnect,_that.link,_that.linkType,_that.showWallets,_that.siweConfig,_that.themeMode,_that.networks,_that.defaultNetwork,_that.chainImages,_that.metadata,_that.accountType,_that.query,_that.certified,_that.installed);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _CoreEventProperties implements CoreEventProperties {
  const _CoreEventProperties({this.message, this.name, this.method, this.connected, this.namespace, this.network, this.caipNetworkId, this.explorerId, this.walletRank, this.displayIndex, this.view, this.provider, this.platform, final  List<String>? trace, this.topic, this.correlation_id, this.client_id, this.direction, this.userAgent, this.token, this.amount, this.hash, this.address, this.project_id, this.cursor, final  Map<String, String>? exchange, final  Map<String, String>? configuration, final  Map<String, String>? currentPayment, this.source, this.headless, this.reconnect, this.link, this.linkType, this.showWallets, final  Map<String, dynamic>? siweConfig, this.themeMode, final  List<String>? networks, this.defaultNetwork, final  List<String>? chainImages, final  Map<String, dynamic>? metadata, this.accountType, this.query, this.certified, this.installed}): _trace = trace,_exchange = exchange,_configuration = configuration,_currentPayment = currentPayment,_siweConfig = siweConfig,_networks = networks,_chainImages = chainImages,_metadata = metadata;
  factory _CoreEventProperties.fromJson(Map<String, dynamic> json) => _$CoreEventPropertiesFromJson(json);

@override final  String? message;
@override final  String? name;
@override final  String? method;
@override final  bool? connected;
@override final  String? namespace;
@override final  String? network;
@override final  String? caipNetworkId;
@override final  String? explorerId;
@override final  int? walletRank;
@override final  int? displayIndex;
@override final  String? view;
@override final  String? provider;
@override final  String? platform;
 final  List<String>? _trace;
@override List<String>? get trace {
  final value = _trace;
  if (value == null) return null;
  if (_trace is EqualUnmodifiableListView) return _trace;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? topic;
@override final  int? correlation_id;
@override final  String? client_id;
@override final  String? direction;
@override final  String? userAgent;
@override final  String? token;
@override final  String? amount;
@override final  String? hash;
@override final  String? address;
@override final  String? project_id;
@override final  String? cursor;
 final  Map<String, String>? _exchange;
@override Map<String, String>? get exchange {
  final value = _exchange;
  if (value == null) return null;
  if (_exchange is EqualUnmodifiableMapView) return _exchange;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, String>? _configuration;
@override Map<String, String>? get configuration {
  final value = _configuration;
  if (value == null) return null;
  if (_configuration is EqualUnmodifiableMapView) return _configuration;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, String>? _currentPayment;
@override Map<String, String>? get currentPayment {
  final value = _currentPayment;
  if (value == null) return null;
  if (_currentPayment is EqualUnmodifiableMapView) return _currentPayment;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  String? source;
@override final  bool? headless;
@override final  bool? reconnect;
@override final  String? link;
@override final  String? linkType;
@override final  bool? showWallets;
 final  Map<String, dynamic>? _siweConfig;
@override Map<String, dynamic>? get siweConfig {
  final value = _siweConfig;
  if (value == null) return null;
  if (_siweConfig is EqualUnmodifiableMapView) return _siweConfig;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  String? themeMode;
//   themeVariables?: ThemeVariables
//   allowUnsupportedChain?: boolean
 final  List<String>? _networks;
//   themeVariables?: ThemeVariables
//   allowUnsupportedChain?: boolean
@override List<String>? get networks {
  final value = _networks;
  if (value == null) return null;
  if (_networks is EqualUnmodifiableListView) return _networks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? defaultNetwork;
 final  List<String>? _chainImages;
@override List<String>? get chainImages {
  final value = _chainImages;
  if (value == null) return null;
  if (_chainImages is EqualUnmodifiableListView) return _chainImages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

//   connectorImages?: Record<string, string>
//   coinbasePreference?: 'all' | 'smartWalletOnly' | 'eoaOnly'
 final  Map<String, dynamic>? _metadata;
//   connectorImages?: Record<string, string>
//   coinbasePreference?: 'all' | 'smartWalletOnly' | 'eoaOnly'
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  String? accountType;
@override final  String? query;
@override final  bool? certified;
@override final  bool? installed;

/// Create a copy of CoreEventProperties
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CoreEventPropertiesCopyWith<_CoreEventProperties> get copyWith => __$CoreEventPropertiesCopyWithImpl<_CoreEventProperties>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CoreEventPropertiesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CoreEventProperties&&(identical(other.message, message) || other.message == message)&&(identical(other.name, name) || other.name == name)&&(identical(other.method, method) || other.method == method)&&(identical(other.connected, connected) || other.connected == connected)&&(identical(other.namespace, namespace) || other.namespace == namespace)&&(identical(other.network, network) || other.network == network)&&(identical(other.caipNetworkId, caipNetworkId) || other.caipNetworkId == caipNetworkId)&&(identical(other.explorerId, explorerId) || other.explorerId == explorerId)&&(identical(other.walletRank, walletRank) || other.walletRank == walletRank)&&(identical(other.displayIndex, displayIndex) || other.displayIndex == displayIndex)&&(identical(other.view, view) || other.view == view)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.platform, platform) || other.platform == platform)&&const DeepCollectionEquality().equals(other._trace, _trace)&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.correlation_id, correlation_id) || other.correlation_id == correlation_id)&&(identical(other.client_id, client_id) || other.client_id == client_id)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.userAgent, userAgent) || other.userAgent == userAgent)&&(identical(other.token, token) || other.token == token)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.hash, hash) || other.hash == hash)&&(identical(other.address, address) || other.address == address)&&(identical(other.project_id, project_id) || other.project_id == project_id)&&(identical(other.cursor, cursor) || other.cursor == cursor)&&const DeepCollectionEquality().equals(other._exchange, _exchange)&&const DeepCollectionEquality().equals(other._configuration, _configuration)&&const DeepCollectionEquality().equals(other._currentPayment, _currentPayment)&&(identical(other.source, source) || other.source == source)&&(identical(other.headless, headless) || other.headless == headless)&&(identical(other.reconnect, reconnect) || other.reconnect == reconnect)&&(identical(other.link, link) || other.link == link)&&(identical(other.linkType, linkType) || other.linkType == linkType)&&(identical(other.showWallets, showWallets) || other.showWallets == showWallets)&&const DeepCollectionEquality().equals(other._siweConfig, _siweConfig)&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&const DeepCollectionEquality().equals(other._networks, _networks)&&(identical(other.defaultNetwork, defaultNetwork) || other.defaultNetwork == defaultNetwork)&&const DeepCollectionEquality().equals(other._chainImages, _chainImages)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.accountType, accountType) || other.accountType == accountType)&&(identical(other.query, query) || other.query == query)&&(identical(other.certified, certified) || other.certified == certified)&&(identical(other.installed, installed) || other.installed == installed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,message,name,method,connected,namespace,network,caipNetworkId,explorerId,walletRank,displayIndex,view,provider,platform,const DeepCollectionEquality().hash(_trace),topic,correlation_id,client_id,direction,userAgent,token,amount,hash,address,project_id,cursor,const DeepCollectionEquality().hash(_exchange),const DeepCollectionEquality().hash(_configuration),const DeepCollectionEquality().hash(_currentPayment),source,headless,reconnect,link,linkType,showWallets,const DeepCollectionEquality().hash(_siweConfig),themeMode,const DeepCollectionEquality().hash(_networks),defaultNetwork,const DeepCollectionEquality().hash(_chainImages),const DeepCollectionEquality().hash(_metadata),accountType,query,certified,installed]);

@override
String toString() {
  return 'CoreEventProperties(message: $message, name: $name, method: $method, connected: $connected, namespace: $namespace, network: $network, caipNetworkId: $caipNetworkId, explorerId: $explorerId, walletRank: $walletRank, displayIndex: $displayIndex, view: $view, provider: $provider, platform: $platform, trace: $trace, topic: $topic, correlation_id: $correlation_id, client_id: $client_id, direction: $direction, userAgent: $userAgent, token: $token, amount: $amount, hash: $hash, address: $address, project_id: $project_id, cursor: $cursor, exchange: $exchange, configuration: $configuration, currentPayment: $currentPayment, source: $source, headless: $headless, reconnect: $reconnect, link: $link, linkType: $linkType, showWallets: $showWallets, siweConfig: $siweConfig, themeMode: $themeMode, networks: $networks, defaultNetwork: $defaultNetwork, chainImages: $chainImages, metadata: $metadata, accountType: $accountType, query: $query, certified: $certified, installed: $installed)';
}


}

/// @nodoc
abstract mixin class _$CoreEventPropertiesCopyWith<$Res> implements $CoreEventPropertiesCopyWith<$Res> {
  factory _$CoreEventPropertiesCopyWith(_CoreEventProperties value, $Res Function(_CoreEventProperties) _then) = __$CoreEventPropertiesCopyWithImpl;
@override @useResult
$Res call({
 String? message, String? name, String? method, bool? connected, String? namespace, String? network, String? caipNetworkId, String? explorerId, int? walletRank, int? displayIndex, String? view, String? provider, String? platform, List<String>? trace, String? topic, int? correlation_id, String? client_id, String? direction, String? userAgent, String? token, String? amount, String? hash, String? address, String? project_id, String? cursor, Map<String, String>? exchange, Map<String, String>? configuration, Map<String, String>? currentPayment, String? source, bool? headless, bool? reconnect, String? link, String? linkType, bool? showWallets, Map<String, dynamic>? siweConfig, String? themeMode, List<String>? networks, String? defaultNetwork, List<String>? chainImages, Map<String, dynamic>? metadata, String? accountType, String? query, bool? certified, bool? installed
});




}
/// @nodoc
class __$CoreEventPropertiesCopyWithImpl<$Res>
    implements _$CoreEventPropertiesCopyWith<$Res> {
  __$CoreEventPropertiesCopyWithImpl(this._self, this._then);

  final _CoreEventProperties _self;
  final $Res Function(_CoreEventProperties) _then;

/// Create a copy of CoreEventProperties
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = freezed,Object? name = freezed,Object? method = freezed,Object? connected = freezed,Object? namespace = freezed,Object? network = freezed,Object? caipNetworkId = freezed,Object? explorerId = freezed,Object? walletRank = freezed,Object? displayIndex = freezed,Object? view = freezed,Object? provider = freezed,Object? platform = freezed,Object? trace = freezed,Object? topic = freezed,Object? correlation_id = freezed,Object? client_id = freezed,Object? direction = freezed,Object? userAgent = freezed,Object? token = freezed,Object? amount = freezed,Object? hash = freezed,Object? address = freezed,Object? project_id = freezed,Object? cursor = freezed,Object? exchange = freezed,Object? configuration = freezed,Object? currentPayment = freezed,Object? source = freezed,Object? headless = freezed,Object? reconnect = freezed,Object? link = freezed,Object? linkType = freezed,Object? showWallets = freezed,Object? siweConfig = freezed,Object? themeMode = freezed,Object? networks = freezed,Object? defaultNetwork = freezed,Object? chainImages = freezed,Object? metadata = freezed,Object? accountType = freezed,Object? query = freezed,Object? certified = freezed,Object? installed = freezed,}) {
  return _then(_CoreEventProperties(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,method: freezed == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String?,connected: freezed == connected ? _self.connected : connected // ignore: cast_nullable_to_non_nullable
as bool?,namespace: freezed == namespace ? _self.namespace : namespace // ignore: cast_nullable_to_non_nullable
as String?,network: freezed == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String?,caipNetworkId: freezed == caipNetworkId ? _self.caipNetworkId : caipNetworkId // ignore: cast_nullable_to_non_nullable
as String?,explorerId: freezed == explorerId ? _self.explorerId : explorerId // ignore: cast_nullable_to_non_nullable
as String?,walletRank: freezed == walletRank ? _self.walletRank : walletRank // ignore: cast_nullable_to_non_nullable
as int?,displayIndex: freezed == displayIndex ? _self.displayIndex : displayIndex // ignore: cast_nullable_to_non_nullable
as int?,view: freezed == view ? _self.view : view // ignore: cast_nullable_to_non_nullable
as String?,provider: freezed == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String?,platform: freezed == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String?,trace: freezed == trace ? _self._trace : trace // ignore: cast_nullable_to_non_nullable
as List<String>?,topic: freezed == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String?,correlation_id: freezed == correlation_id ? _self.correlation_id : correlation_id // ignore: cast_nullable_to_non_nullable
as int?,client_id: freezed == client_id ? _self.client_id : client_id // ignore: cast_nullable_to_non_nullable
as String?,direction: freezed == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String?,userAgent: freezed == userAgent ? _self.userAgent : userAgent // ignore: cast_nullable_to_non_nullable
as String?,token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String?,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String?,hash: freezed == hash ? _self.hash : hash // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,project_id: freezed == project_id ? _self.project_id : project_id // ignore: cast_nullable_to_non_nullable
as String?,cursor: freezed == cursor ? _self.cursor : cursor // ignore: cast_nullable_to_non_nullable
as String?,exchange: freezed == exchange ? _self._exchange : exchange // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,configuration: freezed == configuration ? _self._configuration : configuration // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,currentPayment: freezed == currentPayment ? _self._currentPayment : currentPayment // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,headless: freezed == headless ? _self.headless : headless // ignore: cast_nullable_to_non_nullable
as bool?,reconnect: freezed == reconnect ? _self.reconnect : reconnect // ignore: cast_nullable_to_non_nullable
as bool?,link: freezed == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String?,linkType: freezed == linkType ? _self.linkType : linkType // ignore: cast_nullable_to_non_nullable
as String?,showWallets: freezed == showWallets ? _self.showWallets : showWallets // ignore: cast_nullable_to_non_nullable
as bool?,siweConfig: freezed == siweConfig ? _self._siweConfig : siweConfig // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,themeMode: freezed == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as String?,networks: freezed == networks ? _self._networks : networks // ignore: cast_nullable_to_non_nullable
as List<String>?,defaultNetwork: freezed == defaultNetwork ? _self.defaultNetwork : defaultNetwork // ignore: cast_nullable_to_non_nullable
as String?,chainImages: freezed == chainImages ? _self._chainImages : chainImages // ignore: cast_nullable_to_non_nullable
as List<String>?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,accountType: freezed == accountType ? _self.accountType : accountType // ignore: cast_nullable_to_non_nullable
as String?,query: freezed == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String?,certified: freezed == certified ? _self.certified : certified // ignore: cast_nullable_to_non_nullable
as bool?,installed: freezed == installed ? _self.installed : installed // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
