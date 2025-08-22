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
  List<int> get pairingSymKey => throw _privateConstructorUsedError;
  List<int> get proposerPublicKey => throw _privateConstructorUsedError;
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
  int? get expiryTimestamp => throw _privateConstructorUsedError;

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
      List<int> pairingSymKey,
      List<int> proposerPublicKey,
      List<Map<String, dynamic>> relays,
      Map<String, Map<String, dynamic>> requiredNamespaces,
      Map<String, Map<String, dynamic>>? optionalNamespaces,
      Map<String, dynamic> metadata,
      Map<String, String>? sessionProperties,
      Map<String, String>? scopedProperties,
      int? expiryTimestamp});
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
              as List<int>,
      proposerPublicKey: null == proposerPublicKey
          ? _value.proposerPublicKey
          : proposerPublicKey // ignore: cast_nullable_to_non_nullable
              as List<int>,
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
              as int?,
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
      List<int> pairingSymKey,
      List<int> proposerPublicKey,
      List<Map<String, dynamic>> relays,
      Map<String, Map<String, dynamic>> requiredNamespaces,
      Map<String, Map<String, dynamic>>? optionalNamespaces,
      Map<String, dynamic> metadata,
      Map<String, String>? sessionProperties,
      Map<String, String>? scopedProperties,
      int? expiryTimestamp});
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
          ? _value._pairingSymKey
          : pairingSymKey // ignore: cast_nullable_to_non_nullable
              as List<int>,
      proposerPublicKey: null == proposerPublicKey
          ? _value._proposerPublicKey
          : proposerPublicKey // ignore: cast_nullable_to_non_nullable
              as List<int>,
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
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SessionProposalFfiImpl implements _SessionProposalFfi {
  const _$SessionProposalFfiImpl(
      {required this.id,
      required this.topic,
      required final List<int> pairingSymKey,
      required final List<int> proposerPublicKey,
      required final List<Map<String, dynamic>> relays,
      required final Map<String, Map<String, dynamic>> requiredNamespaces,
      final Map<String, Map<String, dynamic>>? optionalNamespaces,
      required final Map<String, dynamic> metadata,
      final Map<String, String>? sessionProperties,
      final Map<String, String>? scopedProperties,
      this.expiryTimestamp})
      : _pairingSymKey = pairingSymKey,
        _proposerPublicKey = proposerPublicKey,
        _relays = relays,
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
  final List<int> _pairingSymKey;
  @override
  List<int> get pairingSymKey {
    if (_pairingSymKey is EqualUnmodifiableListView) return _pairingSymKey;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pairingSymKey);
  }

  final List<int> _proposerPublicKey;
  @override
  List<int> get proposerPublicKey {
    if (_proposerPublicKey is EqualUnmodifiableListView)
      return _proposerPublicKey;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_proposerPublicKey);
  }

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
  final int? expiryTimestamp;

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
            const DeepCollectionEquality()
                .equals(other._pairingSymKey, _pairingSymKey) &&
            const DeepCollectionEquality()
                .equals(other._proposerPublicKey, _proposerPublicKey) &&
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
      const DeepCollectionEquality().hash(_pairingSymKey),
      const DeepCollectionEquality().hash(_proposerPublicKey),
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
      required final List<int> pairingSymKey,
      required final List<int> proposerPublicKey,
      required final List<Map<String, dynamic>> relays,
      required final Map<String, Map<String, dynamic>> requiredNamespaces,
      final Map<String, Map<String, dynamic>>? optionalNamespaces,
      required final Map<String, dynamic> metadata,
      final Map<String, String>? sessionProperties,
      final Map<String, String>? scopedProperties,
      final int? expiryTimestamp}) = _$SessionProposalFfiImpl;

  factory _SessionProposalFfi.fromJson(Map<String, dynamic> json) =
      _$SessionProposalFfiImpl.fromJson;

  @override
  String get id;
  @override
  String get topic;
  @override
  List<int> get pairingSymKey;
  @override
  List<int> get proposerPublicKey;
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
  int? get expiryTimestamp;

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
  List<int> get sessionSymKey => throw _privateConstructorUsedError;
  List<int> get selfPublicKey => throw _privateConstructorUsedError;

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
  $Res call({List<int> sessionSymKey, List<int> selfPublicKey});
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
              as List<int>,
      selfPublicKey: null == selfPublicKey
          ? _value.selfPublicKey
          : selfPublicKey // ignore: cast_nullable_to_non_nullable
              as List<int>,
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
  $Res call({List<int> sessionSymKey, List<int> selfPublicKey});
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
          ? _value._sessionSymKey
          : sessionSymKey // ignore: cast_nullable_to_non_nullable
              as List<int>,
      selfPublicKey: null == selfPublicKey
          ? _value._selfPublicKey
          : selfPublicKey // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$ApproveResultFfiImpl implements _ApproveResultFfi {
  const _$ApproveResultFfiImpl(
      {required final List<int> sessionSymKey,
      required final List<int> selfPublicKey})
      : _sessionSymKey = sessionSymKey,
        _selfPublicKey = selfPublicKey;

  factory _$ApproveResultFfiImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApproveResultFfiImplFromJson(json);

  final List<int> _sessionSymKey;
  @override
  List<int> get sessionSymKey {
    if (_sessionSymKey is EqualUnmodifiableListView) return _sessionSymKey;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sessionSymKey);
  }

  final List<int> _selfPublicKey;
  @override
  List<int> get selfPublicKey {
    if (_selfPublicKey is EqualUnmodifiableListView) return _selfPublicKey;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selfPublicKey);
  }

  @override
  String toString() {
    return 'ApproveResultFfi(sessionSymKey: $sessionSymKey, selfPublicKey: $selfPublicKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApproveResultFfiImpl &&
            const DeepCollectionEquality()
                .equals(other._sessionSymKey, _sessionSymKey) &&
            const DeepCollectionEquality()
                .equals(other._selfPublicKey, _selfPublicKey));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_sessionSymKey),
      const DeepCollectionEquality().hash(_selfPublicKey));

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
      {required final List<int> sessionSymKey,
      required final List<int> selfPublicKey}) = _$ApproveResultFfiImpl;

  factory _ApproveResultFfi.fromJson(Map<String, dynamic> json) =
      _$ApproveResultFfiImpl.fromJson;

  @override
  List<int> get sessionSymKey;
  @override
  List<int> get selfPublicKey;

  /// Create a copy of ApproveResultFfi
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApproveResultFfiImplCopyWith<_$ApproveResultFfiImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SessionRequestRequestFfi _$SessionRequestRequestFfiFromJson(
    Map<String, dynamic> json) {
  return _SessionRequestRequestFfi.fromJson(json);
}

/// @nodoc
mixin _$SessionRequestRequestFfi {
  String get method => throw _privateConstructorUsedError;
  String get params => throw _privateConstructorUsedError; // JSON string
  int? get expiry => throw _privateConstructorUsedError;

  /// Serializes this SessionRequestRequestFfi to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SessionRequestRequestFfi
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SessionRequestRequestFfiCopyWith<SessionRequestRequestFfi> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionRequestRequestFfiCopyWith<$Res> {
  factory $SessionRequestRequestFfiCopyWith(SessionRequestRequestFfi value,
          $Res Function(SessionRequestRequestFfi) then) =
      _$SessionRequestRequestFfiCopyWithImpl<$Res, SessionRequestRequestFfi>;
  @useResult
  $Res call({String method, String params, int? expiry});
}

/// @nodoc
class _$SessionRequestRequestFfiCopyWithImpl<$Res,
        $Val extends SessionRequestRequestFfi>
    implements $SessionRequestRequestFfiCopyWith<$Res> {
  _$SessionRequestRequestFfiCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SessionRequestRequestFfi
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? method = null,
    Object? params = null,
    Object? expiry = freezed,
  }) {
    return _then(_value.copyWith(
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      params: null == params
          ? _value.params
          : params // ignore: cast_nullable_to_non_nullable
              as String,
      expiry: freezed == expiry
          ? _value.expiry
          : expiry // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SessionRequestRequestFfiImplCopyWith<$Res>
    implements $SessionRequestRequestFfiCopyWith<$Res> {
  factory _$$SessionRequestRequestFfiImplCopyWith(
          _$SessionRequestRequestFfiImpl value,
          $Res Function(_$SessionRequestRequestFfiImpl) then) =
      __$$SessionRequestRequestFfiImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String method, String params, int? expiry});
}

/// @nodoc
class __$$SessionRequestRequestFfiImplCopyWithImpl<$Res>
    extends _$SessionRequestRequestFfiCopyWithImpl<$Res,
        _$SessionRequestRequestFfiImpl>
    implements _$$SessionRequestRequestFfiImplCopyWith<$Res> {
  __$$SessionRequestRequestFfiImplCopyWithImpl(
      _$SessionRequestRequestFfiImpl _value,
      $Res Function(_$SessionRequestRequestFfiImpl) _then)
      : super(_value, _then);

  /// Create a copy of SessionRequestRequestFfi
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? method = null,
    Object? params = null,
    Object? expiry = freezed,
  }) {
    return _then(_$SessionRequestRequestFfiImpl(
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      params: null == params
          ? _value.params
          : params // ignore: cast_nullable_to_non_nullable
              as String,
      expiry: freezed == expiry
          ? _value.expiry
          : expiry // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SessionRequestRequestFfiImpl implements _SessionRequestRequestFfi {
  const _$SessionRequestRequestFfiImpl(
      {required this.method, required this.params, this.expiry});

  factory _$SessionRequestRequestFfiImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionRequestRequestFfiImplFromJson(json);

  @override
  final String method;
  @override
  final String params;
// JSON string
  @override
  final int? expiry;

  @override
  String toString() {
    return 'SessionRequestRequestFfi(method: $method, params: $params, expiry: $expiry)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionRequestRequestFfiImpl &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.params, params) || other.params == params) &&
            (identical(other.expiry, expiry) || other.expiry == expiry));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, method, params, expiry);

  /// Create a copy of SessionRequestRequestFfi
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionRequestRequestFfiImplCopyWith<_$SessionRequestRequestFfiImpl>
      get copyWith => __$$SessionRequestRequestFfiImplCopyWithImpl<
          _$SessionRequestRequestFfiImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionRequestRequestFfiImplToJson(
      this,
    );
  }
}

abstract class _SessionRequestRequestFfi implements SessionRequestRequestFfi {
  const factory _SessionRequestRequestFfi(
      {required final String method,
      required final String params,
      final int? expiry}) = _$SessionRequestRequestFfiImpl;

  factory _SessionRequestRequestFfi.fromJson(Map<String, dynamic> json) =
      _$SessionRequestRequestFfiImpl.fromJson;

  @override
  String get method;
  @override
  String get params; // JSON string
  @override
  int? get expiry;

  /// Create a copy of SessionRequestRequestFfi
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionRequestRequestFfiImplCopyWith<_$SessionRequestRequestFfiImpl>
      get copyWith => throw _privateConstructorUsedError;
}

SessionRequestFfi _$SessionRequestFfiFromJson(Map<String, dynamic> json) {
  return _SessionRequestFfi.fromJson(json);
}

/// @nodoc
mixin _$SessionRequestFfi {
  String get chainId => throw _privateConstructorUsedError;
  SessionRequestRequestFfi get request => throw _privateConstructorUsedError;

  /// Serializes this SessionRequestFfi to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SessionRequestFfi
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SessionRequestFfiCopyWith<SessionRequestFfi> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionRequestFfiCopyWith<$Res> {
  factory $SessionRequestFfiCopyWith(
          SessionRequestFfi value, $Res Function(SessionRequestFfi) then) =
      _$SessionRequestFfiCopyWithImpl<$Res, SessionRequestFfi>;
  @useResult
  $Res call({String chainId, SessionRequestRequestFfi request});

  $SessionRequestRequestFfiCopyWith<$Res> get request;
}

/// @nodoc
class _$SessionRequestFfiCopyWithImpl<$Res, $Val extends SessionRequestFfi>
    implements $SessionRequestFfiCopyWith<$Res> {
  _$SessionRequestFfiCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SessionRequestFfi
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chainId = null,
    Object? request = null,
  }) {
    return _then(_value.copyWith(
      chainId: null == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as String,
      request: null == request
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as SessionRequestRequestFfi,
    ) as $Val);
  }

  /// Create a copy of SessionRequestFfi
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SessionRequestRequestFfiCopyWith<$Res> get request {
    return $SessionRequestRequestFfiCopyWith<$Res>(_value.request, (value) {
      return _then(_value.copyWith(request: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SessionRequestFfiImplCopyWith<$Res>
    implements $SessionRequestFfiCopyWith<$Res> {
  factory _$$SessionRequestFfiImplCopyWith(_$SessionRequestFfiImpl value,
          $Res Function(_$SessionRequestFfiImpl) then) =
      __$$SessionRequestFfiImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String chainId, SessionRequestRequestFfi request});

  @override
  $SessionRequestRequestFfiCopyWith<$Res> get request;
}

/// @nodoc
class __$$SessionRequestFfiImplCopyWithImpl<$Res>
    extends _$SessionRequestFfiCopyWithImpl<$Res, _$SessionRequestFfiImpl>
    implements _$$SessionRequestFfiImplCopyWith<$Res> {
  __$$SessionRequestFfiImplCopyWithImpl(_$SessionRequestFfiImpl _value,
      $Res Function(_$SessionRequestFfiImpl) _then)
      : super(_value, _then);

  /// Create a copy of SessionRequestFfi
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chainId = null,
    Object? request = null,
  }) {
    return _then(_$SessionRequestFfiImpl(
      chainId: null == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as String,
      request: null == request
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as SessionRequestRequestFfi,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SessionRequestFfiImpl implements _SessionRequestFfi {
  const _$SessionRequestFfiImpl({required this.chainId, required this.request});

  factory _$SessionRequestFfiImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionRequestFfiImplFromJson(json);

  @override
  final String chainId;
  @override
  final SessionRequestRequestFfi request;

  @override
  String toString() {
    return 'SessionRequestFfi(chainId: $chainId, request: $request)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionRequestFfiImpl &&
            (identical(other.chainId, chainId) || other.chainId == chainId) &&
            (identical(other.request, request) || other.request == request));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, chainId, request);

  /// Create a copy of SessionRequestFfi
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionRequestFfiImplCopyWith<_$SessionRequestFfiImpl> get copyWith =>
      __$$SessionRequestFfiImplCopyWithImpl<_$SessionRequestFfiImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionRequestFfiImplToJson(
      this,
    );
  }
}

abstract class _SessionRequestFfi implements SessionRequestFfi {
  const factory _SessionRequestFfi(
          {required final String chainId,
          required final SessionRequestRequestFfi request}) =
      _$SessionRequestFfiImpl;

  factory _SessionRequestFfi.fromJson(Map<String, dynamic> json) =
      _$SessionRequestFfiImpl.fromJson;

  @override
  String get chainId;
  @override
  SessionRequestRequestFfi get request;

  /// Create a copy of SessionRequestFfi
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionRequestFfiImplCopyWith<_$SessionRequestFfiImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SessionRequestJsonRpcFfi _$SessionRequestJsonRpcFfiFromJson(
    Map<String, dynamic> json) {
  return _SessionRequestJsonRpcFfi.fromJson(json);
}

/// @nodoc
mixin _$SessionRequestJsonRpcFfi {
  int get id => throw _privateConstructorUsedError;
  String get method => throw _privateConstructorUsedError;
  SessionRequestFfi get params => throw _privateConstructorUsedError;

  /// Serializes this SessionRequestJsonRpcFfi to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SessionRequestJsonRpcFfi
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SessionRequestJsonRpcFfiCopyWith<SessionRequestJsonRpcFfi> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionRequestJsonRpcFfiCopyWith<$Res> {
  factory $SessionRequestJsonRpcFfiCopyWith(SessionRequestJsonRpcFfi value,
          $Res Function(SessionRequestJsonRpcFfi) then) =
      _$SessionRequestJsonRpcFfiCopyWithImpl<$Res, SessionRequestJsonRpcFfi>;
  @useResult
  $Res call({int id, String method, SessionRequestFfi params});

  $SessionRequestFfiCopyWith<$Res> get params;
}

/// @nodoc
class _$SessionRequestJsonRpcFfiCopyWithImpl<$Res,
        $Val extends SessionRequestJsonRpcFfi>
    implements $SessionRequestJsonRpcFfiCopyWith<$Res> {
  _$SessionRequestJsonRpcFfiCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SessionRequestJsonRpcFfi
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? method = null,
    Object? params = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      params: null == params
          ? _value.params
          : params // ignore: cast_nullable_to_non_nullable
              as SessionRequestFfi,
    ) as $Val);
  }

  /// Create a copy of SessionRequestJsonRpcFfi
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SessionRequestFfiCopyWith<$Res> get params {
    return $SessionRequestFfiCopyWith<$Res>(_value.params, (value) {
      return _then(_value.copyWith(params: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SessionRequestJsonRpcFfiImplCopyWith<$Res>
    implements $SessionRequestJsonRpcFfiCopyWith<$Res> {
  factory _$$SessionRequestJsonRpcFfiImplCopyWith(
          _$SessionRequestJsonRpcFfiImpl value,
          $Res Function(_$SessionRequestJsonRpcFfiImpl) then) =
      __$$SessionRequestJsonRpcFfiImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String method, SessionRequestFfi params});

  @override
  $SessionRequestFfiCopyWith<$Res> get params;
}

/// @nodoc
class __$$SessionRequestJsonRpcFfiImplCopyWithImpl<$Res>
    extends _$SessionRequestJsonRpcFfiCopyWithImpl<$Res,
        _$SessionRequestJsonRpcFfiImpl>
    implements _$$SessionRequestJsonRpcFfiImplCopyWith<$Res> {
  __$$SessionRequestJsonRpcFfiImplCopyWithImpl(
      _$SessionRequestJsonRpcFfiImpl _value,
      $Res Function(_$SessionRequestJsonRpcFfiImpl) _then)
      : super(_value, _then);

  /// Create a copy of SessionRequestJsonRpcFfi
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? method = null,
    Object? params = null,
  }) {
    return _then(_$SessionRequestJsonRpcFfiImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      params: null == params
          ? _value.params
          : params // ignore: cast_nullable_to_non_nullable
              as SessionRequestFfi,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SessionRequestJsonRpcFfiImpl implements _SessionRequestJsonRpcFfi {
  const _$SessionRequestJsonRpcFfiImpl(
      {required this.id, required this.method, required this.params});

  factory _$SessionRequestJsonRpcFfiImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionRequestJsonRpcFfiImplFromJson(json);

  @override
  final int id;
  @override
  final String method;
  @override
  final SessionRequestFfi params;

  @override
  String toString() {
    return 'SessionRequestJsonRpcFfi(id: $id, method: $method, params: $params)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionRequestJsonRpcFfiImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.params, params) || other.params == params));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, method, params);

  /// Create a copy of SessionRequestJsonRpcFfi
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionRequestJsonRpcFfiImplCopyWith<_$SessionRequestJsonRpcFfiImpl>
      get copyWith => __$$SessionRequestJsonRpcFfiImplCopyWithImpl<
          _$SessionRequestJsonRpcFfiImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionRequestJsonRpcFfiImplToJson(
      this,
    );
  }
}

abstract class _SessionRequestJsonRpcFfi implements SessionRequestJsonRpcFfi {
  const factory _SessionRequestJsonRpcFfi(
          {required final int id,
          required final String method,
          required final SessionRequestFfi params}) =
      _$SessionRequestJsonRpcFfiImpl;

  factory _SessionRequestJsonRpcFfi.fromJson(Map<String, dynamic> json) =
      _$SessionRequestJsonRpcFfiImpl.fromJson;

  @override
  int get id;
  @override
  String get method;
  @override
  SessionRequestFfi get params;

  /// Create a copy of SessionRequestJsonRpcFfi
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionRequestJsonRpcFfiImplCopyWith<_$SessionRequestJsonRpcFfiImpl>
      get copyWith => throw _privateConstructorUsedError;
}

SessionRequestNativeEvent _$SessionRequestNativeEventFromJson(
    Map<String, dynamic> json) {
  return _SessionRequestNativeEvent.fromJson(json);
}

/// @nodoc
mixin _$SessionRequestNativeEvent {
  String get topic =>
      throw _privateConstructorUsedError; // JSON String. Should be transformed into SessionRequestJsonRpcFfi
  String get sessionRequest => throw _privateConstructorUsedError;

  /// Serializes this SessionRequestNativeEvent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SessionRequestNativeEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SessionRequestNativeEventCopyWith<SessionRequestNativeEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionRequestNativeEventCopyWith<$Res> {
  factory $SessionRequestNativeEventCopyWith(SessionRequestNativeEvent value,
          $Res Function(SessionRequestNativeEvent) then) =
      _$SessionRequestNativeEventCopyWithImpl<$Res, SessionRequestNativeEvent>;
  @useResult
  $Res call({String topic, String sessionRequest});
}

/// @nodoc
class _$SessionRequestNativeEventCopyWithImpl<$Res,
        $Val extends SessionRequestNativeEvent>
    implements $SessionRequestNativeEventCopyWith<$Res> {
  _$SessionRequestNativeEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SessionRequestNativeEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? topic = null,
    Object? sessionRequest = null,
  }) {
    return _then(_value.copyWith(
      topic: null == topic
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String,
      sessionRequest: null == sessionRequest
          ? _value.sessionRequest
          : sessionRequest // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SessionRequestNativeEventImplCopyWith<$Res>
    implements $SessionRequestNativeEventCopyWith<$Res> {
  factory _$$SessionRequestNativeEventImplCopyWith(
          _$SessionRequestNativeEventImpl value,
          $Res Function(_$SessionRequestNativeEventImpl) then) =
      __$$SessionRequestNativeEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String topic, String sessionRequest});
}

/// @nodoc
class __$$SessionRequestNativeEventImplCopyWithImpl<$Res>
    extends _$SessionRequestNativeEventCopyWithImpl<$Res,
        _$SessionRequestNativeEventImpl>
    implements _$$SessionRequestNativeEventImplCopyWith<$Res> {
  __$$SessionRequestNativeEventImplCopyWithImpl(
      _$SessionRequestNativeEventImpl _value,
      $Res Function(_$SessionRequestNativeEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of SessionRequestNativeEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? topic = null,
    Object? sessionRequest = null,
  }) {
    return _then(_$SessionRequestNativeEventImpl(
      topic: null == topic
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String,
      sessionRequest: null == sessionRequest
          ? _value.sessionRequest
          : sessionRequest // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SessionRequestNativeEventImpl implements _SessionRequestNativeEvent {
  const _$SessionRequestNativeEventImpl(
      {required this.topic, required this.sessionRequest});

  factory _$SessionRequestNativeEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionRequestNativeEventImplFromJson(json);

  @override
  final String topic;
// JSON String. Should be transformed into SessionRequestJsonRpcFfi
  @override
  final String sessionRequest;

  @override
  String toString() {
    return 'SessionRequestNativeEvent(topic: $topic, sessionRequest: $sessionRequest)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionRequestNativeEventImpl &&
            (identical(other.topic, topic) || other.topic == topic) &&
            (identical(other.sessionRequest, sessionRequest) ||
                other.sessionRequest == sessionRequest));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, topic, sessionRequest);

  /// Create a copy of SessionRequestNativeEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionRequestNativeEventImplCopyWith<_$SessionRequestNativeEventImpl>
      get copyWith => __$$SessionRequestNativeEventImplCopyWithImpl<
          _$SessionRequestNativeEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionRequestNativeEventImplToJson(
      this,
    );
  }
}

abstract class _SessionRequestNativeEvent implements SessionRequestNativeEvent {
  const factory _SessionRequestNativeEvent(
      {required final String topic,
      required final String sessionRequest}) = _$SessionRequestNativeEventImpl;

  factory _SessionRequestNativeEvent.fromJson(Map<String, dynamic> json) =
      _$SessionRequestNativeEventImpl.fromJson;

  @override
  String
      get topic; // JSON String. Should be transformed into SessionRequestJsonRpcFfi
  @override
  String get sessionRequest;

  /// Create a copy of SessionRequestNativeEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionRequestNativeEventImplCopyWith<_$SessionRequestNativeEventImpl>
      get copyWith => throw _privateConstructorUsedError;
}

SessionRequestJsonRpcResponseFfi _$SessionRequestJsonRpcResponseFfiFromJson(
    Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'result':
      return Result.fromJson(json);
    case 'error':
      return Error.fromJson(json);

    default:
      throw CheckedFromJsonException(
          json,
          'runtimeType',
          'SessionRequestJsonRpcResponseFfi',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$SessionRequestJsonRpcResponseFfi {
  int get id => throw _privateConstructorUsedError;
  String get jsonrpc => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int id, String jsonrpc, String result) result,
    required TResult Function(int id, String jsonrpc, String error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int id, String jsonrpc, String result)? result,
    TResult? Function(int id, String jsonrpc, String error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int id, String jsonrpc, String result)? result,
    TResult Function(int id, String jsonrpc, String error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Result value) result,
    required TResult Function(Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Result value)? result,
    TResult? Function(Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Result value)? result,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this SessionRequestJsonRpcResponseFfi to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SessionRequestJsonRpcResponseFfi
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SessionRequestJsonRpcResponseFfiCopyWith<SessionRequestJsonRpcResponseFfi>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionRequestJsonRpcResponseFfiCopyWith<$Res> {
  factory $SessionRequestJsonRpcResponseFfiCopyWith(
          SessionRequestJsonRpcResponseFfi value,
          $Res Function(SessionRequestJsonRpcResponseFfi) then) =
      _$SessionRequestJsonRpcResponseFfiCopyWithImpl<$Res,
          SessionRequestJsonRpcResponseFfi>;
  @useResult
  $Res call({int id, String jsonrpc});
}

/// @nodoc
class _$SessionRequestJsonRpcResponseFfiCopyWithImpl<$Res,
        $Val extends SessionRequestJsonRpcResponseFfi>
    implements $SessionRequestJsonRpcResponseFfiCopyWith<$Res> {
  _$SessionRequestJsonRpcResponseFfiCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SessionRequestJsonRpcResponseFfi
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? jsonrpc = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      jsonrpc: null == jsonrpc
          ? _value.jsonrpc
          : jsonrpc // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ResultImplCopyWith<$Res>
    implements $SessionRequestJsonRpcResponseFfiCopyWith<$Res> {
  factory _$$ResultImplCopyWith(
          _$ResultImpl value, $Res Function(_$ResultImpl) then) =
      __$$ResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String jsonrpc, String result});
}

/// @nodoc
class __$$ResultImplCopyWithImpl<$Res>
    extends _$SessionRequestJsonRpcResponseFfiCopyWithImpl<$Res, _$ResultImpl>
    implements _$$ResultImplCopyWith<$Res> {
  __$$ResultImplCopyWithImpl(
      _$ResultImpl _value, $Res Function(_$ResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of SessionRequestJsonRpcResponseFfi
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? jsonrpc = null,
    Object? result = null,
  }) {
    return _then(_$ResultImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      jsonrpc: null == jsonrpc
          ? _value.jsonrpc
          : jsonrpc // ignore: cast_nullable_to_non_nullable
              as String,
      result: null == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ResultImpl implements Result {
  const _$ResultImpl(
      {required this.id,
      this.jsonrpc = '2.0',
      required this.result,
      final String? $type})
      : $type = $type ?? 'result';

  factory _$ResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResultImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey()
  final String jsonrpc;
  @override
  final String result;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SessionRequestJsonRpcResponseFfi.result(id: $id, jsonrpc: $jsonrpc, result: $result)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResultImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.jsonrpc, jsonrpc) || other.jsonrpc == jsonrpc) &&
            (identical(other.result, result) || other.result == result));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, jsonrpc, result);

  /// Create a copy of SessionRequestJsonRpcResponseFfi
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResultImplCopyWith<_$ResultImpl> get copyWith =>
      __$$ResultImplCopyWithImpl<_$ResultImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int id, String jsonrpc, String result) result,
    required TResult Function(int id, String jsonrpc, String error) error,
  }) {
    return result(id, jsonrpc, this.result);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int id, String jsonrpc, String result)? result,
    TResult? Function(int id, String jsonrpc, String error)? error,
  }) {
    return result?.call(id, jsonrpc, this.result);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int id, String jsonrpc, String result)? result,
    TResult Function(int id, String jsonrpc, String error)? error,
    required TResult orElse(),
  }) {
    if (result != null) {
      return result(id, jsonrpc, this.result);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Result value) result,
    required TResult Function(Error value) error,
  }) {
    return result(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Result value)? result,
    TResult? Function(Error value)? error,
  }) {
    return result?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Result value)? result,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (result != null) {
      return result(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ResultImplToJson(
      this,
    );
  }
}

abstract class Result implements SessionRequestJsonRpcResponseFfi {
  const factory Result(
      {required final int id,
      final String jsonrpc,
      required final String result}) = _$ResultImpl;

  factory Result.fromJson(Map<String, dynamic> json) = _$ResultImpl.fromJson;

  @override
  int get id;
  @override
  String get jsonrpc;
  String get result;

  /// Create a copy of SessionRequestJsonRpcResponseFfi
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResultImplCopyWith<_$ResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res>
    implements $SessionRequestJsonRpcResponseFfiCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String jsonrpc, String error});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$SessionRequestJsonRpcResponseFfiCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of SessionRequestJsonRpcResponseFfi
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? jsonrpc = null,
    Object? error = null,
  }) {
    return _then(_$ErrorImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      jsonrpc: null == jsonrpc
          ? _value.jsonrpc
          : jsonrpc // ignore: cast_nullable_to_non_nullable
              as String,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ErrorImpl implements Error {
  const _$ErrorImpl(
      {required this.id,
      this.jsonrpc = '2.0',
      required this.error,
      final String? $type})
      : $type = $type ?? 'error';

  factory _$ErrorImpl.fromJson(Map<String, dynamic> json) =>
      _$$ErrorImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey()
  final String jsonrpc;
  @override
  final String error;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SessionRequestJsonRpcResponseFfi.error(id: $id, jsonrpc: $jsonrpc, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.jsonrpc, jsonrpc) || other.jsonrpc == jsonrpc) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, jsonrpc, error);

  /// Create a copy of SessionRequestJsonRpcResponseFfi
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int id, String jsonrpc, String result) result,
    required TResult Function(int id, String jsonrpc, String error) error,
  }) {
    return error(id, jsonrpc, this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int id, String jsonrpc, String result)? result,
    TResult? Function(int id, String jsonrpc, String error)? error,
  }) {
    return error?.call(id, jsonrpc, this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int id, String jsonrpc, String result)? result,
    TResult Function(int id, String jsonrpc, String error)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(id, jsonrpc, this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Result value) result,
    required TResult Function(Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Result value)? result,
    TResult? Function(Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Result value)? result,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ErrorImplToJson(
      this,
    );
  }
}

abstract class Error implements SessionRequestJsonRpcResponseFfi {
  const factory Error(
      {required final int id,
      final String jsonrpc,
      required final String error}) = _$ErrorImpl;

  factory Error.fromJson(Map<String, dynamic> json) = _$ErrorImpl.fromJson;

  @override
  int get id;
  @override
  String get jsonrpc;
  String get error;

  /// Create a copy of SessionRequestJsonRpcResponseFfi
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ErrorDataFfi _$ErrorDataFfiFromJson(Map<String, dynamic> json) {
  return _ErrorDataFfi.fromJson(json);
}

/// @nodoc
mixin _$ErrorDataFfi {
  int get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String? get data => throw _privateConstructorUsedError;

  /// Serializes this ErrorDataFfi to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ErrorDataFfi
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ErrorDataFfiCopyWith<ErrorDataFfi> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ErrorDataFfiCopyWith<$Res> {
  factory $ErrorDataFfiCopyWith(
          ErrorDataFfi value, $Res Function(ErrorDataFfi) then) =
      _$ErrorDataFfiCopyWithImpl<$Res, ErrorDataFfi>;
  @useResult
  $Res call({int code, String message, String? data});
}

/// @nodoc
class _$ErrorDataFfiCopyWithImpl<$Res, $Val extends ErrorDataFfi>
    implements $ErrorDataFfiCopyWith<$Res> {
  _$ErrorDataFfiCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ErrorDataFfi
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ErrorDataFfiImplCopyWith<$Res>
    implements $ErrorDataFfiCopyWith<$Res> {
  factory _$$ErrorDataFfiImplCopyWith(
          _$ErrorDataFfiImpl value, $Res Function(_$ErrorDataFfiImpl) then) =
      __$$ErrorDataFfiImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int code, String message, String? data});
}

/// @nodoc
class __$$ErrorDataFfiImplCopyWithImpl<$Res>
    extends _$ErrorDataFfiCopyWithImpl<$Res, _$ErrorDataFfiImpl>
    implements _$$ErrorDataFfiImplCopyWith<$Res> {
  __$$ErrorDataFfiImplCopyWithImpl(
      _$ErrorDataFfiImpl _value, $Res Function(_$ErrorDataFfiImpl) _then)
      : super(_value, _then);

  /// Create a copy of ErrorDataFfi
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(_$ErrorDataFfiImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ErrorDataFfiImpl implements _ErrorDataFfi {
  const _$ErrorDataFfiImpl(
      {required this.code, required this.message, this.data});

  factory _$ErrorDataFfiImpl.fromJson(Map<String, dynamic> json) =>
      _$$ErrorDataFfiImplFromJson(json);

  @override
  final int code;
  @override
  final String message;
  @override
  final String? data;

  @override
  String toString() {
    return 'ErrorDataFfi(code: $code, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorDataFfiImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, code, message, data);

  /// Create a copy of ErrorDataFfi
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorDataFfiImplCopyWith<_$ErrorDataFfiImpl> get copyWith =>
      __$$ErrorDataFfiImplCopyWithImpl<_$ErrorDataFfiImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ErrorDataFfiImplToJson(
      this,
    );
  }
}

abstract class _ErrorDataFfi implements ErrorDataFfi {
  const factory _ErrorDataFfi(
      {required final int code,
      required final String message,
      final String? data}) = _$ErrorDataFfiImpl;

  factory _ErrorDataFfi.fromJson(Map<String, dynamic> json) =
      _$ErrorDataFfiImpl.fromJson;

  @override
  int get code;
  @override
  String get message;
  @override
  String? get data;

  /// Create a copy of ErrorDataFfi
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorDataFfiImplCopyWith<_$ErrorDataFfiImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
