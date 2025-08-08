// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rust_sign_client.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SessionProposalFfi _$SessionProposalFfiFromJson(Map<String, dynamic> json) {
  return _SessionProposalFfi.fromJson(json);
}

/// @nodoc
mixin _$SessionProposalFfi {
  String get id => throw _privateConstructorUsedError;
  String get topic => throw _privateConstructorUsedError;
  String get pairingSymKey => throw _privateConstructorUsedError;
  String get proposerPublicKey => throw _privateConstructorUsedError;
  List<Map<String, dynamic>> get relays => throw _privateConstructorUsedError;
  Map<String, Map<String, dynamic>> get requiredNamespaces =>
      throw _privateConstructorUsedError;
  Map<String, Map<String, dynamic>>? get optionalNamespaces =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;
  Map<String, String>? get sessionProperties =>
      throw _privateConstructorUsedError;
  Map<String, String>? get scopedProperties =>
      throw _privateConstructorUsedError;
  String? get expiryTimestamp => throw _privateConstructorUsedError;

  /// Serializes this SessionProposalFfi to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SessionProposalFfi
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SessionProposalFfiCopyWith<SessionProposalFfi> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionProposalFfiCopyWith<$Res> {
  factory $SessionProposalFfiCopyWith(
          SessionProposalFfi value, $Res Function(SessionProposalFfi) then) =
      _$SessionProposalFfiCopyWithImpl<$Res, SessionProposalFfi>;
  @useResult
  $Res call(
      {String id,
      String topic,
      String pairingSymKey,
      String proposerPublicKey,
      List<Map<String, dynamic>> relays,
      Map<String, Map<String, dynamic>> requiredNamespaces,
      Map<String, Map<String, dynamic>>? optionalNamespaces,
      Map<String, dynamic> metadata,
      Map<String, String>? sessionProperties,
      Map<String, String>? scopedProperties,
      String? expiryTimestamp});
}

/// @nodoc
class _$SessionProposalFfiCopyWithImpl<$Res, $Val extends SessionProposalFfi>
    implements $SessionProposalFfiCopyWith<$Res> {
  _$SessionProposalFfiCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SessionProposalFfi
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? topic = null,
    Object? pairingSymKey = null,
    Object? proposerPublicKey = null,
    Object? relays = null,
    Object? requiredNamespaces = null,
    Object? optionalNamespaces = freezed,
    Object? metadata = null,
    Object? sessionProperties = freezed,
    Object? scopedProperties = freezed,
    Object? expiryTimestamp = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      topic: null == topic
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String,
      pairingSymKey: null == pairingSymKey
          ? _value.pairingSymKey
          : pairingSymKey // ignore: cast_nullable_to_non_nullable
              as String,
      proposerPublicKey: null == proposerPublicKey
          ? _value.proposerPublicKey
          : proposerPublicKey // ignore: cast_nullable_to_non_nullable
              as String,
      relays: null == relays
          ? _value.relays
          : relays // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
      requiredNamespaces: null == requiredNamespaces
          ? _value.requiredNamespaces
          : requiredNamespaces // ignore: cast_nullable_to_non_nullable
              as Map<String, Map<String, dynamic>>,
      optionalNamespaces: freezed == optionalNamespaces
          ? _value.optionalNamespaces
          : optionalNamespaces // ignore: cast_nullable_to_non_nullable
              as Map<String, Map<String, dynamic>>?,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      sessionProperties: freezed == sessionProperties
          ? _value.sessionProperties
          : sessionProperties // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      scopedProperties: freezed == scopedProperties
          ? _value.scopedProperties
          : scopedProperties // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      expiryTimestamp: freezed == expiryTimestamp
          ? _value.expiryTimestamp
          : expiryTimestamp // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SessionProposalFfiImplCopyWith<$Res>
    implements $SessionProposalFfiCopyWith<$Res> {
  factory _$$SessionProposalFfiImplCopyWith(_$SessionProposalFfiImpl value,
          $Res Function(_$SessionProposalFfiImpl) then) =
      __$$SessionProposalFfiImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String topic,
      String pairingSymKey,
      String proposerPublicKey,
      List<Map<String, dynamic>> relays,
      Map<String, Map<String, dynamic>> requiredNamespaces,
      Map<String, Map<String, dynamic>>? optionalNamespaces,
      Map<String, dynamic> metadata,
      Map<String, String>? sessionProperties,
      Map<String, String>? scopedProperties,
      String? expiryTimestamp});
}

/// @nodoc
class __$$SessionProposalFfiImplCopyWithImpl<$Res>
    extends _$SessionProposalFfiCopyWithImpl<$Res, _$SessionProposalFfiImpl>
    implements _$$SessionProposalFfiImplCopyWith<$Res> {
  __$$SessionProposalFfiImplCopyWithImpl(_$SessionProposalFfiImpl _value,
      $Res Function(_$SessionProposalFfiImpl) _then)
      : super(_value, _then);

  /// Create a copy of SessionProposalFfi
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? topic = null,
    Object? pairingSymKey = null,
    Object? proposerPublicKey = null,
    Object? relays = null,
    Object? requiredNamespaces = null,
    Object? optionalNamespaces = freezed,
    Object? metadata = null,
    Object? sessionProperties = freezed,
    Object? scopedProperties = freezed,
    Object? expiryTimestamp = freezed,
  }) {
    return _then(_$SessionProposalFfiImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      topic: null == topic
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String,
      pairingSymKey: null == pairingSymKey
          ? _value.pairingSymKey
          : pairingSymKey // ignore: cast_nullable_to_non_nullable
              as String,
      proposerPublicKey: null == proposerPublicKey
          ? _value.proposerPublicKey
          : proposerPublicKey // ignore: cast_nullable_to_non_nullable
              as String,
      relays: null == relays
          ? _value._relays
          : relays // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
      requiredNamespaces: null == requiredNamespaces
          ? _value._requiredNamespaces
          : requiredNamespaces // ignore: cast_nullable_to_non_nullable
              as Map<String, Map<String, dynamic>>,
      optionalNamespaces: freezed == optionalNamespaces
          ? _value._optionalNamespaces
          : optionalNamespaces // ignore: cast_nullable_to_non_nullable
              as Map<String, Map<String, dynamic>>?,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      sessionProperties: freezed == sessionProperties
          ? _value._sessionProperties
          : sessionProperties // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      scopedProperties: freezed == scopedProperties
          ? _value._scopedProperties
          : scopedProperties // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      expiryTimestamp: freezed == expiryTimestamp
          ? _value.expiryTimestamp
          : expiryTimestamp // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SessionProposalFfiImpl implements _SessionProposalFfi {
  const _$SessionProposalFfiImpl(
      {required this.id,
      required this.topic,
      required this.pairingSymKey,
      required this.proposerPublicKey,
      required final List<Map<String, dynamic>> relays,
      required final Map<String, Map<String, dynamic>> requiredNamespaces,
      final Map<String, Map<String, dynamic>>? optionalNamespaces,
      required final Map<String, dynamic> metadata,
      final Map<String, String>? sessionProperties,
      final Map<String, String>? scopedProperties,
      this.expiryTimestamp})
      : _relays = relays,
        _requiredNamespaces = requiredNamespaces,
        _optionalNamespaces = optionalNamespaces,
        _metadata = metadata,
        _sessionProperties = sessionProperties,
        _scopedProperties = scopedProperties;

  factory _$SessionProposalFfiImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionProposalFfiImplFromJson(json);

  @override
  final String id;
  @override
  final String topic;
  @override
  final String pairingSymKey;
  @override
  final String proposerPublicKey;
  final List<Map<String, dynamic>> _relays;
  @override
  List<Map<String, dynamic>> get relays {
    if (_relays is EqualUnmodifiableListView) return _relays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_relays);
  }

  final Map<String, Map<String, dynamic>> _requiredNamespaces;
  @override
  Map<String, Map<String, dynamic>> get requiredNamespaces {
    if (_requiredNamespaces is EqualUnmodifiableMapView)
      return _requiredNamespaces;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_requiredNamespaces);
  }

  final Map<String, Map<String, dynamic>>? _optionalNamespaces;
  @override
  Map<String, Map<String, dynamic>>? get optionalNamespaces {
    final value = _optionalNamespaces;
    if (value == null) return null;
    if (_optionalNamespaces is EqualUnmodifiableMapView)
      return _optionalNamespaces;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic> _metadata;
  @override
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  final Map<String, String>? _sessionProperties;
  @override
  Map<String, String>? get sessionProperties {
    final value = _sessionProperties;
    if (value == null) return null;
    if (_sessionProperties is EqualUnmodifiableMapView)
      return _sessionProperties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, String>? _scopedProperties;
  @override
  Map<String, String>? get scopedProperties {
    final value = _scopedProperties;
    if (value == null) return null;
    if (_scopedProperties is EqualUnmodifiableMapView) return _scopedProperties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final String? expiryTimestamp;

  @override
  String toString() {
    return 'SessionProposalFfi(id: $id, topic: $topic, pairingSymKey: $pairingSymKey, proposerPublicKey: $proposerPublicKey, relays: $relays, requiredNamespaces: $requiredNamespaces, optionalNamespaces: $optionalNamespaces, metadata: $metadata, sessionProperties: $sessionProperties, scopedProperties: $scopedProperties, expiryTimestamp: $expiryTimestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionProposalFfiImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.topic, topic) || other.topic == topic) &&
            (identical(other.pairingSymKey, pairingSymKey) ||
                other.pairingSymKey == pairingSymKey) &&
            (identical(other.proposerPublicKey, proposerPublicKey) ||
                other.proposerPublicKey == proposerPublicKey) &&
            const DeepCollectionEquality().equals(other._relays, _relays) &&
            const DeepCollectionEquality()
                .equals(other._requiredNamespaces, _requiredNamespaces) &&
            const DeepCollectionEquality()
                .equals(other._optionalNamespaces, _optionalNamespaces) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            const DeepCollectionEquality()
                .equals(other._sessionProperties, _sessionProperties) &&
            const DeepCollectionEquality()
                .equals(other._scopedProperties, _scopedProperties) &&
            (identical(other.expiryTimestamp, expiryTimestamp) ||
                other.expiryTimestamp == expiryTimestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      topic,
      pairingSymKey,
      proposerPublicKey,
      const DeepCollectionEquality().hash(_relays),
      const DeepCollectionEquality().hash(_requiredNamespaces),
      const DeepCollectionEquality().hash(_optionalNamespaces),
      const DeepCollectionEquality().hash(_metadata),
      const DeepCollectionEquality().hash(_sessionProperties),
      const DeepCollectionEquality().hash(_scopedProperties),
      expiryTimestamp);

  /// Create a copy of SessionProposalFfi
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionProposalFfiImplCopyWith<_$SessionProposalFfiImpl> get copyWith =>
      __$$SessionProposalFfiImplCopyWithImpl<_$SessionProposalFfiImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionProposalFfiImplToJson(
      this,
    );
  }
}

abstract class _SessionProposalFfi implements SessionProposalFfi {
  const factory _SessionProposalFfi(
      {required final String id,
      required final String topic,
      required final String pairingSymKey,
      required final String proposerPublicKey,
      required final List<Map<String, dynamic>> relays,
      required final Map<String, Map<String, dynamic>> requiredNamespaces,
      final Map<String, Map<String, dynamic>>? optionalNamespaces,
      required final Map<String, dynamic> metadata,
      final Map<String, String>? sessionProperties,
      final Map<String, String>? scopedProperties,
      final String? expiryTimestamp}) = _$SessionProposalFfiImpl;

  factory _SessionProposalFfi.fromJson(Map<String, dynamic> json) =
      _$SessionProposalFfiImpl.fromJson;

  @override
  String get id;
  @override
  String get topic;
  @override
  String get pairingSymKey;
  @override
  String get proposerPublicKey;
  @override
  List<Map<String, dynamic>> get relays;
  @override
  Map<String, Map<String, dynamic>> get requiredNamespaces;
  @override
  Map<String, Map<String, dynamic>>? get optionalNamespaces;
  @override
  Map<String, dynamic> get metadata;
  @override
  Map<String, String>? get sessionProperties;
  @override
  Map<String, String>? get scopedProperties;
  @override
  String? get expiryTimestamp;

  /// Create a copy of SessionProposalFfi
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionProposalFfiImplCopyWith<_$SessionProposalFfiImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SettleNamespaceFfi _$SettleNamespaceFfiFromJson(Map<String, dynamic> json) {
  return _SettleNamespaceFfi.fromJson(json);
}

/// @nodoc
mixin _$SettleNamespaceFfi {
  List<String> get accounts => throw _privateConstructorUsedError;
  List<String> get methods => throw _privateConstructorUsedError;
  List<String> get events => throw _privateConstructorUsedError;
  List<String> get chains => throw _privateConstructorUsedError;

  /// Serializes this SettleNamespaceFfi to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SettleNamespaceFfi
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SettleNamespaceFfiCopyWith<SettleNamespaceFfi> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettleNamespaceFfiCopyWith<$Res> {
  factory $SettleNamespaceFfiCopyWith(
          SettleNamespaceFfi value, $Res Function(SettleNamespaceFfi) then) =
      _$SettleNamespaceFfiCopyWithImpl<$Res, SettleNamespaceFfi>;
  @useResult
  $Res call(
      {List<String> accounts,
      List<String> methods,
      List<String> events,
      List<String> chains});
}

/// @nodoc
class _$SettleNamespaceFfiCopyWithImpl<$Res, $Val extends SettleNamespaceFfi>
    implements $SettleNamespaceFfiCopyWith<$Res> {
  _$SettleNamespaceFfiCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SettleNamespaceFfi
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accounts = null,
    Object? methods = null,
    Object? events = null,
    Object? chains = null,
  }) {
    return _then(_value.copyWith(
      accounts: null == accounts
          ? _value.accounts
          : accounts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      methods: null == methods
          ? _value.methods
          : methods // ignore: cast_nullable_to_non_nullable
              as List<String>,
      events: null == events
          ? _value.events
          : events // ignore: cast_nullable_to_non_nullable
              as List<String>,
      chains: null == chains
          ? _value.chains
          : chains // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SettleNamespaceFfiImplCopyWith<$Res>
    implements $SettleNamespaceFfiCopyWith<$Res> {
  factory _$$SettleNamespaceFfiImplCopyWith(_$SettleNamespaceFfiImpl value,
          $Res Function(_$SettleNamespaceFfiImpl) then) =
      __$$SettleNamespaceFfiImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> accounts,
      List<String> methods,
      List<String> events,
      List<String> chains});
}

/// @nodoc
class __$$SettleNamespaceFfiImplCopyWithImpl<$Res>
    extends _$SettleNamespaceFfiCopyWithImpl<$Res, _$SettleNamespaceFfiImpl>
    implements _$$SettleNamespaceFfiImplCopyWith<$Res> {
  __$$SettleNamespaceFfiImplCopyWithImpl(_$SettleNamespaceFfiImpl _value,
      $Res Function(_$SettleNamespaceFfiImpl) _then)
      : super(_value, _then);

  /// Create a copy of SettleNamespaceFfi
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accounts = null,
    Object? methods = null,
    Object? events = null,
    Object? chains = null,
  }) {
    return _then(_$SettleNamespaceFfiImpl(
      accounts: null == accounts
          ? _value._accounts
          : accounts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      methods: null == methods
          ? _value._methods
          : methods // ignore: cast_nullable_to_non_nullable
              as List<String>,
      events: null == events
          ? _value._events
          : events // ignore: cast_nullable_to_non_nullable
              as List<String>,
      chains: null == chains
          ? _value._chains
          : chains // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SettleNamespaceFfiImpl implements _SettleNamespaceFfi {
  const _$SettleNamespaceFfiImpl(
      {required final List<String> accounts,
      required final List<String> methods,
      required final List<String> events,
      required final List<String> chains})
      : _accounts = accounts,
        _methods = methods,
        _events = events,
        _chains = chains;

  factory _$SettleNamespaceFfiImpl.fromJson(Map<String, dynamic> json) =>
      _$$SettleNamespaceFfiImplFromJson(json);

  final List<String> _accounts;
  @override
  List<String> get accounts {
    if (_accounts is EqualUnmodifiableListView) return _accounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_accounts);
  }

  final List<String> _methods;
  @override
  List<String> get methods {
    if (_methods is EqualUnmodifiableListView) return _methods;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_methods);
  }

  final List<String> _events;
  @override
  List<String> get events {
    if (_events is EqualUnmodifiableListView) return _events;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_events);
  }

  final List<String> _chains;
  @override
  List<String> get chains {
    if (_chains is EqualUnmodifiableListView) return _chains;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chains);
  }

  @override
  String toString() {
    return 'SettleNamespaceFfi(accounts: $accounts, methods: $methods, events: $events, chains: $chains)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettleNamespaceFfiImpl &&
            const DeepCollectionEquality().equals(other._accounts, _accounts) &&
            const DeepCollectionEquality().equals(other._methods, _methods) &&
            const DeepCollectionEquality().equals(other._events, _events) &&
            const DeepCollectionEquality().equals(other._chains, _chains));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_accounts),
      const DeepCollectionEquality().hash(_methods),
      const DeepCollectionEquality().hash(_events),
      const DeepCollectionEquality().hash(_chains));

  /// Create a copy of SettleNamespaceFfi
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SettleNamespaceFfiImplCopyWith<_$SettleNamespaceFfiImpl> get copyWith =>
      __$$SettleNamespaceFfiImplCopyWithImpl<_$SettleNamespaceFfiImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SettleNamespaceFfiImplToJson(
      this,
    );
  }
}

abstract class _SettleNamespaceFfi implements SettleNamespaceFfi {
  const factory _SettleNamespaceFfi(
      {required final List<String> accounts,
      required final List<String> methods,
      required final List<String> events,
      required final List<String> chains}) = _$SettleNamespaceFfiImpl;

  factory _SettleNamespaceFfi.fromJson(Map<String, dynamic> json) =
      _$SettleNamespaceFfiImpl.fromJson;

  @override
  List<String> get accounts;
  @override
  List<String> get methods;
  @override
  List<String> get events;
  @override
  List<String> get chains;

  /// Create a copy of SettleNamespaceFfi
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SettleNamespaceFfiImplCopyWith<_$SettleNamespaceFfiImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MetadataFfi _$MetadataFfiFromJson(Map<String, dynamic> json) {
  return _MetadataFfi.fromJson(json);
}

/// @nodoc
mixin _$MetadataFfi {
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  List<String> get icons => throw _privateConstructorUsedError;
  String? get verifyUrl => throw _privateConstructorUsedError;
  RedirectFfi? get redirect => throw _privateConstructorUsedError;

  /// Serializes this MetadataFfi to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MetadataFfi
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MetadataFfiCopyWith<MetadataFfi> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MetadataFfiCopyWith<$Res> {
  factory $MetadataFfiCopyWith(
          MetadataFfi value, $Res Function(MetadataFfi) then) =
      _$MetadataFfiCopyWithImpl<$Res, MetadataFfi>;
  @useResult
  $Res call(
      {String name,
      String description,
      String url,
      List<String> icons,
      String? verifyUrl,
      RedirectFfi? redirect});

  $RedirectFfiCopyWith<$Res>? get redirect;
}

/// @nodoc
class _$MetadataFfiCopyWithImpl<$Res, $Val extends MetadataFfi>
    implements $MetadataFfiCopyWith<$Res> {
  _$MetadataFfiCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MetadataFfi
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? url = null,
    Object? icons = null,
    Object? verifyUrl = freezed,
    Object? redirect = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      icons: null == icons
          ? _value.icons
          : icons // ignore: cast_nullable_to_non_nullable
              as List<String>,
      verifyUrl: freezed == verifyUrl
          ? _value.verifyUrl
          : verifyUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      redirect: freezed == redirect
          ? _value.redirect
          : redirect // ignore: cast_nullable_to_non_nullable
              as RedirectFfi?,
    ) as $Val);
  }

  /// Create a copy of MetadataFfi
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RedirectFfiCopyWith<$Res>? get redirect {
    if (_value.redirect == null) {
      return null;
    }

    return $RedirectFfiCopyWith<$Res>(_value.redirect!, (value) {
      return _then(_value.copyWith(redirect: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MetadataFfiImplCopyWith<$Res>
    implements $MetadataFfiCopyWith<$Res> {
  factory _$$MetadataFfiImplCopyWith(
          _$MetadataFfiImpl value, $Res Function(_$MetadataFfiImpl) then) =
      __$$MetadataFfiImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String description,
      String url,
      List<String> icons,
      String? verifyUrl,
      RedirectFfi? redirect});

  @override
  $RedirectFfiCopyWith<$Res>? get redirect;
}

/// @nodoc
class __$$MetadataFfiImplCopyWithImpl<$Res>
    extends _$MetadataFfiCopyWithImpl<$Res, _$MetadataFfiImpl>
    implements _$$MetadataFfiImplCopyWith<$Res> {
  __$$MetadataFfiImplCopyWithImpl(
      _$MetadataFfiImpl _value, $Res Function(_$MetadataFfiImpl) _then)
      : super(_value, _then);

  /// Create a copy of MetadataFfi
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? url = null,
    Object? icons = null,
    Object? verifyUrl = freezed,
    Object? redirect = freezed,
  }) {
    return _then(_$MetadataFfiImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      icons: null == icons
          ? _value._icons
          : icons // ignore: cast_nullable_to_non_nullable
              as List<String>,
      verifyUrl: freezed == verifyUrl
          ? _value.verifyUrl
          : verifyUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      redirect: freezed == redirect
          ? _value.redirect
          : redirect // ignore: cast_nullable_to_non_nullable
              as RedirectFfi?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$MetadataFfiImpl implements _MetadataFfi {
  const _$MetadataFfiImpl(
      {required this.name,
      required this.description,
      this.url = '',
      final List<String> icons = const <String>[],
      this.verifyUrl,
      this.redirect})
      : _icons = icons;

  factory _$MetadataFfiImpl.fromJson(Map<String, dynamic> json) =>
      _$$MetadataFfiImplFromJson(json);

  @override
  final String name;
  @override
  final String description;
  @override
  @JsonKey()
  final String url;
  final List<String> _icons;
  @override
  @JsonKey()
  List<String> get icons {
    if (_icons is EqualUnmodifiableListView) return _icons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_icons);
  }

  @override
  final String? verifyUrl;
  @override
  final RedirectFfi? redirect;

  @override
  String toString() {
    return 'MetadataFfi(name: $name, description: $description, url: $url, icons: $icons, verifyUrl: $verifyUrl, redirect: $redirect)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MetadataFfiImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.url, url) || other.url == url) &&
            const DeepCollectionEquality().equals(other._icons, _icons) &&
            (identical(other.verifyUrl, verifyUrl) ||
                other.verifyUrl == verifyUrl) &&
            (identical(other.redirect, redirect) ||
                other.redirect == redirect));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, description, url,
      const DeepCollectionEquality().hash(_icons), verifyUrl, redirect);

  /// Create a copy of MetadataFfi
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MetadataFfiImplCopyWith<_$MetadataFfiImpl> get copyWith =>
      __$$MetadataFfiImplCopyWithImpl<_$MetadataFfiImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MetadataFfiImplToJson(
      this,
    );
  }
}

abstract class _MetadataFfi implements MetadataFfi {
  const factory _MetadataFfi(
      {required final String name,
      required final String description,
      final String url,
      final List<String> icons,
      final String? verifyUrl,
      final RedirectFfi? redirect}) = _$MetadataFfiImpl;

  factory _MetadataFfi.fromJson(Map<String, dynamic> json) =
      _$MetadataFfiImpl.fromJson;

  @override
  String get name;
  @override
  String get description;
  @override
  String get url;
  @override
  List<String> get icons;
  @override
  String? get verifyUrl;
  @override
  RedirectFfi? get redirect;

  /// Create a copy of MetadataFfi
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MetadataFfiImplCopyWith<_$MetadataFfiImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RedirectFfi _$RedirectFfiFromJson(Map<String, dynamic> json) {
  return _RedirectFfi.fromJson(json);
}

/// @nodoc
mixin _$RedirectFfi {
  String? get native => throw _privateConstructorUsedError;
  String? get universal => throw _privateConstructorUsedError;
  bool get linkMode => throw _privateConstructorUsedError;

  /// Serializes this RedirectFfi to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RedirectFfi
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RedirectFfiCopyWith<RedirectFfi> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RedirectFfiCopyWith<$Res> {
  factory $RedirectFfiCopyWith(
          RedirectFfi value, $Res Function(RedirectFfi) then) =
      _$RedirectFfiCopyWithImpl<$Res, RedirectFfi>;
  @useResult
  $Res call({String? native, String? universal, bool linkMode});
}

/// @nodoc
class _$RedirectFfiCopyWithImpl<$Res, $Val extends RedirectFfi>
    implements $RedirectFfiCopyWith<$Res> {
  _$RedirectFfiCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RedirectFfi
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? native = freezed,
    Object? universal = freezed,
    Object? linkMode = null,
  }) {
    return _then(_value.copyWith(
      native: freezed == native
          ? _value.native
          : native // ignore: cast_nullable_to_non_nullable
              as String?,
      universal: freezed == universal
          ? _value.universal
          : universal // ignore: cast_nullable_to_non_nullable
              as String?,
      linkMode: null == linkMode
          ? _value.linkMode
          : linkMode // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RedirectFfiImplCopyWith<$Res>
    implements $RedirectFfiCopyWith<$Res> {
  factory _$$RedirectFfiImplCopyWith(
          _$RedirectFfiImpl value, $Res Function(_$RedirectFfiImpl) then) =
      __$$RedirectFfiImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? native, String? universal, bool linkMode});
}

/// @nodoc
class __$$RedirectFfiImplCopyWithImpl<$Res>
    extends _$RedirectFfiCopyWithImpl<$Res, _$RedirectFfiImpl>
    implements _$$RedirectFfiImplCopyWith<$Res> {
  __$$RedirectFfiImplCopyWithImpl(
      _$RedirectFfiImpl _value, $Res Function(_$RedirectFfiImpl) _then)
      : super(_value, _then);

  /// Create a copy of RedirectFfi
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? native = freezed,
    Object? universal = freezed,
    Object? linkMode = null,
  }) {
    return _then(_$RedirectFfiImpl(
      native: freezed == native
          ? _value.native
          : native // ignore: cast_nullable_to_non_nullable
              as String?,
      universal: freezed == universal
          ? _value.universal
          : universal // ignore: cast_nullable_to_non_nullable
              as String?,
      linkMode: null == linkMode
          ? _value.linkMode
          : linkMode // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$RedirectFfiImpl implements _RedirectFfi {
  const _$RedirectFfiImpl({this.native, this.universal, this.linkMode = false});

  factory _$RedirectFfiImpl.fromJson(Map<String, dynamic> json) =>
      _$$RedirectFfiImplFromJson(json);

  @override
  final String? native;
  @override
  final String? universal;
  @override
  @JsonKey()
  final bool linkMode;

  @override
  String toString() {
    return 'RedirectFfi(native: $native, universal: $universal, linkMode: $linkMode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RedirectFfiImpl &&
            (identical(other.native, native) || other.native == native) &&
            (identical(other.universal, universal) ||
                other.universal == universal) &&
            (identical(other.linkMode, linkMode) ||
                other.linkMode == linkMode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, native, universal, linkMode);

  /// Create a copy of RedirectFfi
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RedirectFfiImplCopyWith<_$RedirectFfiImpl> get copyWith =>
      __$$RedirectFfiImplCopyWithImpl<_$RedirectFfiImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RedirectFfiImplToJson(
      this,
    );
  }
}

abstract class _RedirectFfi implements RedirectFfi {
  const factory _RedirectFfi(
      {final String? native,
      final String? universal,
      final bool linkMode}) = _$RedirectFfiImpl;

  factory _RedirectFfi.fromJson(Map<String, dynamic> json) =
      _$RedirectFfiImpl.fromJson;

  @override
  String? get native;
  @override
  String? get universal;
  @override
  bool get linkMode;

  /// Create a copy of RedirectFfi
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RedirectFfiImplCopyWith<_$RedirectFfiImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ApproveResultFfi _$ApproveResultFfiFromJson(Map<String, dynamic> json) {
  return _ApproveResultFfi.fromJson(json);
}

/// @nodoc
mixin _$ApproveResultFfi {
  String get sessionSymKey => throw _privateConstructorUsedError;
  String get selfPublicKey => throw _privateConstructorUsedError;

  /// Serializes this ApproveResultFfi to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApproveResultFfi
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApproveResultFfiCopyWith<ApproveResultFfi> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApproveResultFfiCopyWith<$Res> {
  factory $ApproveResultFfiCopyWith(
          ApproveResultFfi value, $Res Function(ApproveResultFfi) then) =
      _$ApproveResultFfiCopyWithImpl<$Res, ApproveResultFfi>;
  @useResult
  $Res call({String sessionSymKey, String selfPublicKey});
}

/// @nodoc
class _$ApproveResultFfiCopyWithImpl<$Res, $Val extends ApproveResultFfi>
    implements $ApproveResultFfiCopyWith<$Res> {
  _$ApproveResultFfiCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApproveResultFfi
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionSymKey = null,
    Object? selfPublicKey = null,
  }) {
    return _then(_value.copyWith(
      sessionSymKey: null == sessionSymKey
          ? _value.sessionSymKey
          : sessionSymKey // ignore: cast_nullable_to_non_nullable
              as String,
      selfPublicKey: null == selfPublicKey
          ? _value.selfPublicKey
          : selfPublicKey // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ApproveResultFfiImplCopyWith<$Res>
    implements $ApproveResultFfiCopyWith<$Res> {
  factory _$$ApproveResultFfiImplCopyWith(_$ApproveResultFfiImpl value,
          $Res Function(_$ApproveResultFfiImpl) then) =
      __$$ApproveResultFfiImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String sessionSymKey, String selfPublicKey});
}

/// @nodoc
class __$$ApproveResultFfiImplCopyWithImpl<$Res>
    extends _$ApproveResultFfiCopyWithImpl<$Res, _$ApproveResultFfiImpl>
    implements _$$ApproveResultFfiImplCopyWith<$Res> {
  __$$ApproveResultFfiImplCopyWithImpl(_$ApproveResultFfiImpl _value,
      $Res Function(_$ApproveResultFfiImpl) _then)
      : super(_value, _then);

  /// Create a copy of ApproveResultFfi
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionSymKey = null,
    Object? selfPublicKey = null,
  }) {
    return _then(_$ApproveResultFfiImpl(
      sessionSymKey: null == sessionSymKey
          ? _value.sessionSymKey
          : sessionSymKey // ignore: cast_nullable_to_non_nullable
              as String,
      selfPublicKey: null == selfPublicKey
          ? _value.selfPublicKey
          : selfPublicKey // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$ApproveResultFfiImpl implements _ApproveResultFfi {
  const _$ApproveResultFfiImpl(
      {required this.sessionSymKey, required this.selfPublicKey});

  factory _$ApproveResultFfiImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApproveResultFfiImplFromJson(json);

  @override
  final String sessionSymKey;
  @override
  final String selfPublicKey;

  @override
  String toString() {
    return 'ApproveResultFfi(sessionSymKey: $sessionSymKey, selfPublicKey: $selfPublicKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApproveResultFfiImpl &&
            (identical(other.sessionSymKey, sessionSymKey) ||
                other.sessionSymKey == sessionSymKey) &&
            (identical(other.selfPublicKey, selfPublicKey) ||
                other.selfPublicKey == selfPublicKey));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, sessionSymKey, selfPublicKey);

  /// Create a copy of ApproveResultFfi
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApproveResultFfiImplCopyWith<_$ApproveResultFfiImpl> get copyWith =>
      __$$ApproveResultFfiImplCopyWithImpl<_$ApproveResultFfiImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApproveResultFfiImplToJson(
      this,
    );
  }
}

abstract class _ApproveResultFfi implements ApproveResultFfi {
  const factory _ApproveResultFfi(
      {required final String sessionSymKey,
      required final String selfPublicKey}) = _$ApproveResultFfiImpl;

  factory _ApproveResultFfi.fromJson(Map<String, dynamic> json) =
      _$ApproveResultFfiImpl.fromJson;

  @override
  String get sessionSymKey;
  @override
  String get selfPublicKey;

  /// Create a copy of ApproveResultFfi
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApproveResultFfiImplCopyWith<_$ApproveResultFfiImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
