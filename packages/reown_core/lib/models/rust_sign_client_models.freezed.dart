// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rust_sign_client_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SessionProposal _$SessionProposalFromJson(Map<String, dynamic> json) {
  return _SessionProposal.fromJson(json);
}

/// @nodoc
mixin _$SessionProposal {
  String get id => throw _privateConstructorUsedError;
  String get topic => throw _privateConstructorUsedError;
  String get pairingSymKey =>
      throw _privateConstructorUsedError; // hex encoded string
  String get proposerPublicKey =>
      throw _privateConstructorUsedError; // hex encoded string
  List<Relay> get relays => throw _privateConstructorUsedError;
  Map<String, Map<String, dynamic>> get requiredNamespaces =>
      throw _privateConstructorUsedError;
  Map<String, Map<String, dynamic>>? get optionalNamespaces =>
      throw _privateConstructorUsedError;
  PairingMetadata get metadata => throw _privateConstructorUsedError;
  Map<String, String>? get sessionProperties =>
      throw _privateConstructorUsedError;
  Map<String, String>? get scopedProperties =>
      throw _privateConstructorUsedError;
  int? get expiryTimestamp => throw _privateConstructorUsedError;

  /// Serializes this SessionProposal to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SessionProposal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SessionProposalCopyWith<SessionProposal> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionProposalCopyWith<$Res> {
  factory $SessionProposalCopyWith(
          SessionProposal value, $Res Function(SessionProposal) then) =
      _$SessionProposalCopyWithImpl<$Res, SessionProposal>;
  @useResult
  $Res call(
      {String id,
      String topic,
      String pairingSymKey,
      String proposerPublicKey,
      List<Relay> relays,
      Map<String, Map<String, dynamic>> requiredNamespaces,
      Map<String, Map<String, dynamic>>? optionalNamespaces,
      PairingMetadata metadata,
      Map<String, String>? sessionProperties,
      Map<String, String>? scopedProperties,
      int? expiryTimestamp});

  $PairingMetadataCopyWith<$Res> get metadata;
}

/// @nodoc
class _$SessionProposalCopyWithImpl<$Res, $Val extends SessionProposal>
    implements $SessionProposalCopyWith<$Res> {
  _$SessionProposalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SessionProposal
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
              as List<Relay>,
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
              as PairingMetadata,
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

  /// Create a copy of SessionProposal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PairingMetadataCopyWith<$Res> get metadata {
    return $PairingMetadataCopyWith<$Res>(_value.metadata, (value) {
      return _then(_value.copyWith(metadata: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SessionProposalImplCopyWith<$Res>
    implements $SessionProposalCopyWith<$Res> {
  factory _$$SessionProposalImplCopyWith(_$SessionProposalImpl value,
          $Res Function(_$SessionProposalImpl) then) =
      __$$SessionProposalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String topic,
      String pairingSymKey,
      String proposerPublicKey,
      List<Relay> relays,
      Map<String, Map<String, dynamic>> requiredNamespaces,
      Map<String, Map<String, dynamic>>? optionalNamespaces,
      PairingMetadata metadata,
      Map<String, String>? sessionProperties,
      Map<String, String>? scopedProperties,
      int? expiryTimestamp});

  @override
  $PairingMetadataCopyWith<$Res> get metadata;
}

/// @nodoc
class __$$SessionProposalImplCopyWithImpl<$Res>
    extends _$SessionProposalCopyWithImpl<$Res, _$SessionProposalImpl>
    implements _$$SessionProposalImplCopyWith<$Res> {
  __$$SessionProposalImplCopyWithImpl(
      _$SessionProposalImpl _value, $Res Function(_$SessionProposalImpl) _then)
      : super(_value, _then);

  /// Create a copy of SessionProposal
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
    return _then(_$SessionProposalImpl(
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
              as List<Relay>,
      requiredNamespaces: null == requiredNamespaces
          ? _value._requiredNamespaces
          : requiredNamespaces // ignore: cast_nullable_to_non_nullable
              as Map<String, Map<String, dynamic>>,
      optionalNamespaces: freezed == optionalNamespaces
          ? _value._optionalNamespaces
          : optionalNamespaces // ignore: cast_nullable_to_non_nullable
              as Map<String, Map<String, dynamic>>?,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as PairingMetadata,
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
class _$SessionProposalImpl implements _SessionProposal {
  const _$SessionProposalImpl(
      {required this.id,
      required this.topic,
      required this.pairingSymKey,
      required this.proposerPublicKey,
      required final List<Relay> relays,
      required final Map<String, Map<String, dynamic>> requiredNamespaces,
      final Map<String, Map<String, dynamic>>? optionalNamespaces,
      required this.metadata,
      final Map<String, String>? sessionProperties,
      final Map<String, String>? scopedProperties,
      this.expiryTimestamp})
      : _relays = relays,
        _requiredNamespaces = requiredNamespaces,
        _optionalNamespaces = optionalNamespaces,
        _sessionProperties = sessionProperties,
        _scopedProperties = scopedProperties;

  factory _$SessionProposalImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionProposalImplFromJson(json);

  @override
  final String id;
  @override
  final String topic;
  @override
  final String pairingSymKey;
// hex encoded string
  @override
  final String proposerPublicKey;
// hex encoded string
  final List<Relay> _relays;
// hex encoded string
  @override
  List<Relay> get relays {
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

  @override
  final PairingMetadata metadata;
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
    return 'SessionProposal(id: $id, topic: $topic, pairingSymKey: $pairingSymKey, proposerPublicKey: $proposerPublicKey, relays: $relays, requiredNamespaces: $requiredNamespaces, optionalNamespaces: $optionalNamespaces, metadata: $metadata, sessionProperties: $sessionProperties, scopedProperties: $scopedProperties, expiryTimestamp: $expiryTimestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionProposalImpl &&
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
            (identical(other.metadata, metadata) ||
                other.metadata == metadata) &&
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
      metadata,
      const DeepCollectionEquality().hash(_sessionProperties),
      const DeepCollectionEquality().hash(_scopedProperties),
      expiryTimestamp);

  /// Create a copy of SessionProposal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionProposalImplCopyWith<_$SessionProposalImpl> get copyWith =>
      __$$SessionProposalImplCopyWithImpl<_$SessionProposalImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionProposalImplToJson(
      this,
    );
  }
}

abstract class _SessionProposal implements SessionProposal {
  const factory _SessionProposal(
      {required final String id,
      required final String topic,
      required final String pairingSymKey,
      required final String proposerPublicKey,
      required final List<Relay> relays,
      required final Map<String, Map<String, dynamic>> requiredNamespaces,
      final Map<String, Map<String, dynamic>>? optionalNamespaces,
      required final PairingMetadata metadata,
      final Map<String, String>? sessionProperties,
      final Map<String, String>? scopedProperties,
      final int? expiryTimestamp}) = _$SessionProposalImpl;

  factory _SessionProposal.fromJson(Map<String, dynamic> json) =
      _$SessionProposalImpl.fromJson;

  @override
  String get id;
  @override
  String get topic;
  @override
  String get pairingSymKey; // hex encoded string
  @override
  String get proposerPublicKey; // hex encoded string
  @override
  List<Relay> get relays;
  @override
  Map<String, Map<String, dynamic>> get requiredNamespaces;
  @override
  Map<String, Map<String, dynamic>>? get optionalNamespaces;
  @override
  PairingMetadata get metadata;
  @override
  Map<String, String>? get sessionProperties;
  @override
  Map<String, String>? get scopedProperties;
  @override
  int? get expiryTimestamp;

  /// Create a copy of SessionProposal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionProposalImplCopyWith<_$SessionProposalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ApproveResult _$ApproveResultFromJson(Map<String, dynamic> json) {
  return _ApproveResult.fromJson(json);
}

/// @nodoc
mixin _$ApproveResult {
  String get sessionSymKey =>
      throw _privateConstructorUsedError; // hex encoded string
  String get selfPublicKey => throw _privateConstructorUsedError;

  /// Serializes this ApproveResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApproveResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApproveResultCopyWith<ApproveResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApproveResultCopyWith<$Res> {
  factory $ApproveResultCopyWith(
          ApproveResult value, $Res Function(ApproveResult) then) =
      _$ApproveResultCopyWithImpl<$Res, ApproveResult>;
  @useResult
  $Res call({String sessionSymKey, String selfPublicKey});
}

/// @nodoc
class _$ApproveResultCopyWithImpl<$Res, $Val extends ApproveResult>
    implements $ApproveResultCopyWith<$Res> {
  _$ApproveResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApproveResult
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
abstract class _$$ApproveResultImplCopyWith<$Res>
    implements $ApproveResultCopyWith<$Res> {
  factory _$$ApproveResultImplCopyWith(
          _$ApproveResultImpl value, $Res Function(_$ApproveResultImpl) then) =
      __$$ApproveResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String sessionSymKey, String selfPublicKey});
}

/// @nodoc
class __$$ApproveResultImplCopyWithImpl<$Res>
    extends _$ApproveResultCopyWithImpl<$Res, _$ApproveResultImpl>
    implements _$$ApproveResultImplCopyWith<$Res> {
  __$$ApproveResultImplCopyWithImpl(
      _$ApproveResultImpl _value, $Res Function(_$ApproveResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of ApproveResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionSymKey = null,
    Object? selfPublicKey = null,
  }) {
    return _then(_$ApproveResultImpl(
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
class _$ApproveResultImpl implements _ApproveResult {
  const _$ApproveResultImpl(
      {required this.sessionSymKey, required this.selfPublicKey});

  factory _$ApproveResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApproveResultImplFromJson(json);

  @override
  final String sessionSymKey;
// hex encoded string
  @override
  final String selfPublicKey;

  @override
  String toString() {
    return 'ApproveResult(sessionSymKey: $sessionSymKey, selfPublicKey: $selfPublicKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApproveResultImpl &&
            (identical(other.sessionSymKey, sessionSymKey) ||
                other.sessionSymKey == sessionSymKey) &&
            (identical(other.selfPublicKey, selfPublicKey) ||
                other.selfPublicKey == selfPublicKey));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, sessionSymKey, selfPublicKey);

  /// Create a copy of ApproveResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApproveResultImplCopyWith<_$ApproveResultImpl> get copyWith =>
      __$$ApproveResultImplCopyWithImpl<_$ApproveResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApproveResultImplToJson(
      this,
    );
  }
}

abstract class _ApproveResult implements ApproveResult {
  const factory _ApproveResult(
      {required final String sessionSymKey,
      required final String selfPublicKey}) = _$ApproveResultImpl;

  factory _ApproveResult.fromJson(Map<String, dynamic> json) =
      _$ApproveResultImpl.fromJson;

  @override
  String get sessionSymKey; // hex encoded string
  @override
  String get selfPublicKey;

  /// Create a copy of ApproveResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApproveResultImplCopyWith<_$ApproveResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
