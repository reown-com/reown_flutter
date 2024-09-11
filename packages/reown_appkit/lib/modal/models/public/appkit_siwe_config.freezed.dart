// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appkit_siwe_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SIWECreateMessageArgs _$SIWECreateMessageArgsFromJson(
    Map<String, dynamic> json) {
  return _SIWECreateMessageArgs.fromJson(json);
}

/// @nodoc
mixin _$SIWECreateMessageArgs {
  String get chainId => throw _privateConstructorUsedError;
  String get domain => throw _privateConstructorUsedError;
  String get nonce => throw _privateConstructorUsedError;
  String get uri => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get version => throw _privateConstructorUsedError;
  CacaoHeader? get type => throw _privateConstructorUsedError;
  String? get nbf => throw _privateConstructorUsedError;
  String? get exp => throw _privateConstructorUsedError;
  String? get statement => throw _privateConstructorUsedError;
  String? get requestId => throw _privateConstructorUsedError;
  List<String>? get resources => throw _privateConstructorUsedError;
  int? get expiry => throw _privateConstructorUsedError;
  String? get iat => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SIWECreateMessageArgsCopyWith<SIWECreateMessageArgs> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SIWECreateMessageArgsCopyWith<$Res> {
  factory $SIWECreateMessageArgsCopyWith(SIWECreateMessageArgs value,
          $Res Function(SIWECreateMessageArgs) then) =
      _$SIWECreateMessageArgsCopyWithImpl<$Res, SIWECreateMessageArgs>;
  @useResult
  $Res call(
      {String chainId,
      String domain,
      String nonce,
      String uri,
      String address,
      String version,
      CacaoHeader? type,
      String? nbf,
      String? exp,
      String? statement,
      String? requestId,
      List<String>? resources,
      int? expiry,
      String? iat});

  $CacaoHeaderCopyWith<$Res>? get type;
}

/// @nodoc
class _$SIWECreateMessageArgsCopyWithImpl<$Res,
        $Val extends SIWECreateMessageArgs>
    implements $SIWECreateMessageArgsCopyWith<$Res> {
  _$SIWECreateMessageArgsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chainId = null,
    Object? domain = null,
    Object? nonce = null,
    Object? uri = null,
    Object? address = null,
    Object? version = null,
    Object? type = freezed,
    Object? nbf = freezed,
    Object? exp = freezed,
    Object? statement = freezed,
    Object? requestId = freezed,
    Object? resources = freezed,
    Object? expiry = freezed,
    Object? iat = freezed,
  }) {
    return _then(_value.copyWith(
      chainId: null == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as String,
      domain: null == domain
          ? _value.domain
          : domain // ignore: cast_nullable_to_non_nullable
              as String,
      nonce: null == nonce
          ? _value.nonce
          : nonce // ignore: cast_nullable_to_non_nullable
              as String,
      uri: null == uri
          ? _value.uri
          : uri // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as CacaoHeader?,
      nbf: freezed == nbf
          ? _value.nbf
          : nbf // ignore: cast_nullable_to_non_nullable
              as String?,
      exp: freezed == exp
          ? _value.exp
          : exp // ignore: cast_nullable_to_non_nullable
              as String?,
      statement: freezed == statement
          ? _value.statement
          : statement // ignore: cast_nullable_to_non_nullable
              as String?,
      requestId: freezed == requestId
          ? _value.requestId
          : requestId // ignore: cast_nullable_to_non_nullable
              as String?,
      resources: freezed == resources
          ? _value.resources
          : resources // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      expiry: freezed == expiry
          ? _value.expiry
          : expiry // ignore: cast_nullable_to_non_nullable
              as int?,
      iat: freezed == iat
          ? _value.iat
          : iat // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CacaoHeaderCopyWith<$Res>? get type {
    if (_value.type == null) {
      return null;
    }

    return $CacaoHeaderCopyWith<$Res>(_value.type!, (value) {
      return _then(_value.copyWith(type: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SIWECreateMessageArgsImplCopyWith<$Res>
    implements $SIWECreateMessageArgsCopyWith<$Res> {
  factory _$$SIWECreateMessageArgsImplCopyWith(
          _$SIWECreateMessageArgsImpl value,
          $Res Function(_$SIWECreateMessageArgsImpl) then) =
      __$$SIWECreateMessageArgsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String chainId,
      String domain,
      String nonce,
      String uri,
      String address,
      String version,
      CacaoHeader? type,
      String? nbf,
      String? exp,
      String? statement,
      String? requestId,
      List<String>? resources,
      int? expiry,
      String? iat});

  @override
  $CacaoHeaderCopyWith<$Res>? get type;
}

/// @nodoc
class __$$SIWECreateMessageArgsImplCopyWithImpl<$Res>
    extends _$SIWECreateMessageArgsCopyWithImpl<$Res,
        _$SIWECreateMessageArgsImpl>
    implements _$$SIWECreateMessageArgsImplCopyWith<$Res> {
  __$$SIWECreateMessageArgsImplCopyWithImpl(_$SIWECreateMessageArgsImpl _value,
      $Res Function(_$SIWECreateMessageArgsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chainId = null,
    Object? domain = null,
    Object? nonce = null,
    Object? uri = null,
    Object? address = null,
    Object? version = null,
    Object? type = freezed,
    Object? nbf = freezed,
    Object? exp = freezed,
    Object? statement = freezed,
    Object? requestId = freezed,
    Object? resources = freezed,
    Object? expiry = freezed,
    Object? iat = freezed,
  }) {
    return _then(_$SIWECreateMessageArgsImpl(
      chainId: null == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as String,
      domain: null == domain
          ? _value.domain
          : domain // ignore: cast_nullable_to_non_nullable
              as String,
      nonce: null == nonce
          ? _value.nonce
          : nonce // ignore: cast_nullable_to_non_nullable
              as String,
      uri: null == uri
          ? _value.uri
          : uri // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as CacaoHeader?,
      nbf: freezed == nbf
          ? _value.nbf
          : nbf // ignore: cast_nullable_to_non_nullable
              as String?,
      exp: freezed == exp
          ? _value.exp
          : exp // ignore: cast_nullable_to_non_nullable
              as String?,
      statement: freezed == statement
          ? _value.statement
          : statement // ignore: cast_nullable_to_non_nullable
              as String?,
      requestId: freezed == requestId
          ? _value.requestId
          : requestId // ignore: cast_nullable_to_non_nullable
              as String?,
      resources: freezed == resources
          ? _value._resources
          : resources // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      expiry: freezed == expiry
          ? _value.expiry
          : expiry // ignore: cast_nullable_to_non_nullable
              as int?,
      iat: freezed == iat
          ? _value.iat
          : iat // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SIWECreateMessageArgsImpl implements _SIWECreateMessageArgs {
  const _$SIWECreateMessageArgsImpl(
      {required this.chainId,
      required this.domain,
      required this.nonce,
      required this.uri,
      required this.address,
      this.version = '1',
      this.type = const CacaoHeader(t: 'eip4361'),
      this.nbf,
      this.exp,
      this.statement,
      this.requestId,
      final List<String>? resources,
      this.expiry,
      this.iat})
      : _resources = resources;

  factory _$SIWECreateMessageArgsImpl.fromJson(Map<String, dynamic> json) =>
      _$$SIWECreateMessageArgsImplFromJson(json);

  @override
  final String chainId;
  @override
  final String domain;
  @override
  final String nonce;
  @override
  final String uri;
  @override
  final String address;
  @override
  @JsonKey()
  final String version;
  @override
  @JsonKey()
  final CacaoHeader? type;
  @override
  final String? nbf;
  @override
  final String? exp;
  @override
  final String? statement;
  @override
  final String? requestId;
  final List<String>? _resources;
  @override
  List<String>? get resources {
    final value = _resources;
    if (value == null) return null;
    if (_resources is EqualUnmodifiableListView) return _resources;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? expiry;
  @override
  final String? iat;

  @override
  String toString() {
    return 'SIWECreateMessageArgs(chainId: $chainId, domain: $domain, nonce: $nonce, uri: $uri, address: $address, version: $version, type: $type, nbf: $nbf, exp: $exp, statement: $statement, requestId: $requestId, resources: $resources, expiry: $expiry, iat: $iat)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SIWECreateMessageArgsImpl &&
            (identical(other.chainId, chainId) || other.chainId == chainId) &&
            (identical(other.domain, domain) || other.domain == domain) &&
            (identical(other.nonce, nonce) || other.nonce == nonce) &&
            (identical(other.uri, uri) || other.uri == uri) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.nbf, nbf) || other.nbf == nbf) &&
            (identical(other.exp, exp) || other.exp == exp) &&
            (identical(other.statement, statement) ||
                other.statement == statement) &&
            (identical(other.requestId, requestId) ||
                other.requestId == requestId) &&
            const DeepCollectionEquality()
                .equals(other._resources, _resources) &&
            (identical(other.expiry, expiry) || other.expiry == expiry) &&
            (identical(other.iat, iat) || other.iat == iat));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      chainId,
      domain,
      nonce,
      uri,
      address,
      version,
      type,
      nbf,
      exp,
      statement,
      requestId,
      const DeepCollectionEquality().hash(_resources),
      expiry,
      iat);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SIWECreateMessageArgsImplCopyWith<_$SIWECreateMessageArgsImpl>
      get copyWith => __$$SIWECreateMessageArgsImplCopyWithImpl<
          _$SIWECreateMessageArgsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SIWECreateMessageArgsImplToJson(
      this,
    );
  }
}

abstract class _SIWECreateMessageArgs implements SIWECreateMessageArgs {
  const factory _SIWECreateMessageArgs(
      {required final String chainId,
      required final String domain,
      required final String nonce,
      required final String uri,
      required final String address,
      final String version,
      final CacaoHeader? type,
      final String? nbf,
      final String? exp,
      final String? statement,
      final String? requestId,
      final List<String>? resources,
      final int? expiry,
      final String? iat}) = _$SIWECreateMessageArgsImpl;

  factory _SIWECreateMessageArgs.fromJson(Map<String, dynamic> json) =
      _$SIWECreateMessageArgsImpl.fromJson;

  @override
  String get chainId;
  @override
  String get domain;
  @override
  String get nonce;
  @override
  String get uri;
  @override
  String get address;
  @override
  String get version;
  @override
  CacaoHeader? get type;
  @override
  String? get nbf;
  @override
  String? get exp;
  @override
  String? get statement;
  @override
  String? get requestId;
  @override
  List<String>? get resources;
  @override
  int? get expiry;
  @override
  String? get iat;
  @override
  @JsonKey(ignore: true)
  _$$SIWECreateMessageArgsImplCopyWith<_$SIWECreateMessageArgsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

SIWEMessageArgs _$SIWEMessageArgsFromJson(Map<String, dynamic> json) {
  return _SIWEMessageArgs.fromJson(json);
}

/// @nodoc
mixin _$SIWEMessageArgs {
  String get domain => throw _privateConstructorUsedError;
  String get uri => throw _privateConstructorUsedError;
  CacaoHeader? get type => throw _privateConstructorUsedError;
  String? get nbf => throw _privateConstructorUsedError;
  String? get exp => throw _privateConstructorUsedError;
  String? get statement => throw _privateConstructorUsedError;
  String? get requestId => throw _privateConstructorUsedError;
  List<String>? get resources => throw _privateConstructorUsedError;
  int? get expiry => throw _privateConstructorUsedError;
  String? get iat => throw _privateConstructorUsedError;
  List<String>? get methods => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SIWEMessageArgsCopyWith<SIWEMessageArgs> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SIWEMessageArgsCopyWith<$Res> {
  factory $SIWEMessageArgsCopyWith(
          SIWEMessageArgs value, $Res Function(SIWEMessageArgs) then) =
      _$SIWEMessageArgsCopyWithImpl<$Res, SIWEMessageArgs>;
  @useResult
  $Res call(
      {String domain,
      String uri,
      CacaoHeader? type,
      String? nbf,
      String? exp,
      String? statement,
      String? requestId,
      List<String>? resources,
      int? expiry,
      String? iat,
      List<String>? methods});

  $CacaoHeaderCopyWith<$Res>? get type;
}

/// @nodoc
class _$SIWEMessageArgsCopyWithImpl<$Res, $Val extends SIWEMessageArgs>
    implements $SIWEMessageArgsCopyWith<$Res> {
  _$SIWEMessageArgsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? domain = null,
    Object? uri = null,
    Object? type = freezed,
    Object? nbf = freezed,
    Object? exp = freezed,
    Object? statement = freezed,
    Object? requestId = freezed,
    Object? resources = freezed,
    Object? expiry = freezed,
    Object? iat = freezed,
    Object? methods = freezed,
  }) {
    return _then(_value.copyWith(
      domain: null == domain
          ? _value.domain
          : domain // ignore: cast_nullable_to_non_nullable
              as String,
      uri: null == uri
          ? _value.uri
          : uri // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as CacaoHeader?,
      nbf: freezed == nbf
          ? _value.nbf
          : nbf // ignore: cast_nullable_to_non_nullable
              as String?,
      exp: freezed == exp
          ? _value.exp
          : exp // ignore: cast_nullable_to_non_nullable
              as String?,
      statement: freezed == statement
          ? _value.statement
          : statement // ignore: cast_nullable_to_non_nullable
              as String?,
      requestId: freezed == requestId
          ? _value.requestId
          : requestId // ignore: cast_nullable_to_non_nullable
              as String?,
      resources: freezed == resources
          ? _value.resources
          : resources // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      expiry: freezed == expiry
          ? _value.expiry
          : expiry // ignore: cast_nullable_to_non_nullable
              as int?,
      iat: freezed == iat
          ? _value.iat
          : iat // ignore: cast_nullable_to_non_nullable
              as String?,
      methods: freezed == methods
          ? _value.methods
          : methods // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CacaoHeaderCopyWith<$Res>? get type {
    if (_value.type == null) {
      return null;
    }

    return $CacaoHeaderCopyWith<$Res>(_value.type!, (value) {
      return _then(_value.copyWith(type: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SIWEMessageArgsImplCopyWith<$Res>
    implements $SIWEMessageArgsCopyWith<$Res> {
  factory _$$SIWEMessageArgsImplCopyWith(_$SIWEMessageArgsImpl value,
          $Res Function(_$SIWEMessageArgsImpl) then) =
      __$$SIWEMessageArgsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String domain,
      String uri,
      CacaoHeader? type,
      String? nbf,
      String? exp,
      String? statement,
      String? requestId,
      List<String>? resources,
      int? expiry,
      String? iat,
      List<String>? methods});

  @override
  $CacaoHeaderCopyWith<$Res>? get type;
}

/// @nodoc
class __$$SIWEMessageArgsImplCopyWithImpl<$Res>
    extends _$SIWEMessageArgsCopyWithImpl<$Res, _$SIWEMessageArgsImpl>
    implements _$$SIWEMessageArgsImplCopyWith<$Res> {
  __$$SIWEMessageArgsImplCopyWithImpl(
      _$SIWEMessageArgsImpl _value, $Res Function(_$SIWEMessageArgsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? domain = null,
    Object? uri = null,
    Object? type = freezed,
    Object? nbf = freezed,
    Object? exp = freezed,
    Object? statement = freezed,
    Object? requestId = freezed,
    Object? resources = freezed,
    Object? expiry = freezed,
    Object? iat = freezed,
    Object? methods = freezed,
  }) {
    return _then(_$SIWEMessageArgsImpl(
      domain: null == domain
          ? _value.domain
          : domain // ignore: cast_nullable_to_non_nullable
              as String,
      uri: null == uri
          ? _value.uri
          : uri // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as CacaoHeader?,
      nbf: freezed == nbf
          ? _value.nbf
          : nbf // ignore: cast_nullable_to_non_nullable
              as String?,
      exp: freezed == exp
          ? _value.exp
          : exp // ignore: cast_nullable_to_non_nullable
              as String?,
      statement: freezed == statement
          ? _value.statement
          : statement // ignore: cast_nullable_to_non_nullable
              as String?,
      requestId: freezed == requestId
          ? _value.requestId
          : requestId // ignore: cast_nullable_to_non_nullable
              as String?,
      resources: freezed == resources
          ? _value._resources
          : resources // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      expiry: freezed == expiry
          ? _value.expiry
          : expiry // ignore: cast_nullable_to_non_nullable
              as int?,
      iat: freezed == iat
          ? _value.iat
          : iat // ignore: cast_nullable_to_non_nullable
              as String?,
      methods: freezed == methods
          ? _value._methods
          : methods // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SIWEMessageArgsImpl implements _SIWEMessageArgs {
  const _$SIWEMessageArgsImpl(
      {required this.domain,
      required this.uri,
      this.type = const CacaoHeader(t: 'eip4361'),
      this.nbf,
      this.exp,
      this.statement,
      this.requestId,
      final List<String>? resources,
      this.expiry,
      this.iat,
      final List<String>? methods})
      : _resources = resources,
        _methods = methods;

  factory _$SIWEMessageArgsImpl.fromJson(Map<String, dynamic> json) =>
      _$$SIWEMessageArgsImplFromJson(json);

  @override
  final String domain;
  @override
  final String uri;
  @override
  @JsonKey()
  final CacaoHeader? type;
  @override
  final String? nbf;
  @override
  final String? exp;
  @override
  final String? statement;
  @override
  final String? requestId;
  final List<String>? _resources;
  @override
  List<String>? get resources {
    final value = _resources;
    if (value == null) return null;
    if (_resources is EqualUnmodifiableListView) return _resources;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? expiry;
  @override
  final String? iat;
  final List<String>? _methods;
  @override
  List<String>? get methods {
    final value = _methods;
    if (value == null) return null;
    if (_methods is EqualUnmodifiableListView) return _methods;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'SIWEMessageArgs(domain: $domain, uri: $uri, type: $type, nbf: $nbf, exp: $exp, statement: $statement, requestId: $requestId, resources: $resources, expiry: $expiry, iat: $iat, methods: $methods)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SIWEMessageArgsImpl &&
            (identical(other.domain, domain) || other.domain == domain) &&
            (identical(other.uri, uri) || other.uri == uri) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.nbf, nbf) || other.nbf == nbf) &&
            (identical(other.exp, exp) || other.exp == exp) &&
            (identical(other.statement, statement) ||
                other.statement == statement) &&
            (identical(other.requestId, requestId) ||
                other.requestId == requestId) &&
            const DeepCollectionEquality()
                .equals(other._resources, _resources) &&
            (identical(other.expiry, expiry) || other.expiry == expiry) &&
            (identical(other.iat, iat) || other.iat == iat) &&
            const DeepCollectionEquality().equals(other._methods, _methods));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      domain,
      uri,
      type,
      nbf,
      exp,
      statement,
      requestId,
      const DeepCollectionEquality().hash(_resources),
      expiry,
      iat,
      const DeepCollectionEquality().hash(_methods));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SIWEMessageArgsImplCopyWith<_$SIWEMessageArgsImpl> get copyWith =>
      __$$SIWEMessageArgsImplCopyWithImpl<_$SIWEMessageArgsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SIWEMessageArgsImplToJson(
      this,
    );
  }
}

abstract class _SIWEMessageArgs implements SIWEMessageArgs {
  const factory _SIWEMessageArgs(
      {required final String domain,
      required final String uri,
      final CacaoHeader? type,
      final String? nbf,
      final String? exp,
      final String? statement,
      final String? requestId,
      final List<String>? resources,
      final int? expiry,
      final String? iat,
      final List<String>? methods}) = _$SIWEMessageArgsImpl;

  factory _SIWEMessageArgs.fromJson(Map<String, dynamic> json) =
      _$SIWEMessageArgsImpl.fromJson;

  @override
  String get domain;
  @override
  String get uri;
  @override
  CacaoHeader? get type;
  @override
  String? get nbf;
  @override
  String? get exp;
  @override
  String? get statement;
  @override
  String? get requestId;
  @override
  List<String>? get resources;
  @override
  int? get expiry;
  @override
  String? get iat;
  @override
  List<String>? get methods;
  @override
  @JsonKey(ignore: true)
  _$$SIWEMessageArgsImplCopyWith<_$SIWEMessageArgsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SIWEVerifyMessageArgs _$SIWEVerifyMessageArgsFromJson(
    Map<String, dynamic> json) {
  return _SIWEVerifyMessageArgs.fromJson(json);
}

/// @nodoc
mixin _$SIWEVerifyMessageArgs {
  String get message => throw _privateConstructorUsedError;
  String get signature => throw _privateConstructorUsedError;
  Cacao? get cacao => throw _privateConstructorUsedError; // for One-Click Auth
  String? get clientId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SIWEVerifyMessageArgsCopyWith<SIWEVerifyMessageArgs> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SIWEVerifyMessageArgsCopyWith<$Res> {
  factory $SIWEVerifyMessageArgsCopyWith(SIWEVerifyMessageArgs value,
          $Res Function(SIWEVerifyMessageArgs) then) =
      _$SIWEVerifyMessageArgsCopyWithImpl<$Res, SIWEVerifyMessageArgs>;
  @useResult
  $Res call({String message, String signature, Cacao? cacao, String? clientId});

  $CacaoCopyWith<$Res>? get cacao;
}

/// @nodoc
class _$SIWEVerifyMessageArgsCopyWithImpl<$Res,
        $Val extends SIWEVerifyMessageArgs>
    implements $SIWEVerifyMessageArgsCopyWith<$Res> {
  _$SIWEVerifyMessageArgsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? signature = null,
    Object? cacao = freezed,
    Object? clientId = freezed,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      signature: null == signature
          ? _value.signature
          : signature // ignore: cast_nullable_to_non_nullable
              as String,
      cacao: freezed == cacao
          ? _value.cacao
          : cacao // ignore: cast_nullable_to_non_nullable
              as Cacao?,
      clientId: freezed == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CacaoCopyWith<$Res>? get cacao {
    if (_value.cacao == null) {
      return null;
    }

    return $CacaoCopyWith<$Res>(_value.cacao!, (value) {
      return _then(_value.copyWith(cacao: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SIWEVerifyMessageArgsImplCopyWith<$Res>
    implements $SIWEVerifyMessageArgsCopyWith<$Res> {
  factory _$$SIWEVerifyMessageArgsImplCopyWith(
          _$SIWEVerifyMessageArgsImpl value,
          $Res Function(_$SIWEVerifyMessageArgsImpl) then) =
      __$$SIWEVerifyMessageArgsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, String signature, Cacao? cacao, String? clientId});

  @override
  $CacaoCopyWith<$Res>? get cacao;
}

/// @nodoc
class __$$SIWEVerifyMessageArgsImplCopyWithImpl<$Res>
    extends _$SIWEVerifyMessageArgsCopyWithImpl<$Res,
        _$SIWEVerifyMessageArgsImpl>
    implements _$$SIWEVerifyMessageArgsImplCopyWith<$Res> {
  __$$SIWEVerifyMessageArgsImplCopyWithImpl(_$SIWEVerifyMessageArgsImpl _value,
      $Res Function(_$SIWEVerifyMessageArgsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? signature = null,
    Object? cacao = freezed,
    Object? clientId = freezed,
  }) {
    return _then(_$SIWEVerifyMessageArgsImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      signature: null == signature
          ? _value.signature
          : signature // ignore: cast_nullable_to_non_nullable
              as String,
      cacao: freezed == cacao
          ? _value.cacao
          : cacao // ignore: cast_nullable_to_non_nullable
              as Cacao?,
      clientId: freezed == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SIWEVerifyMessageArgsImpl implements _SIWEVerifyMessageArgs {
  const _$SIWEVerifyMessageArgsImpl(
      {required this.message,
      required this.signature,
      this.cacao,
      this.clientId});

  factory _$SIWEVerifyMessageArgsImpl.fromJson(Map<String, dynamic> json) =>
      _$$SIWEVerifyMessageArgsImplFromJson(json);

  @override
  final String message;
  @override
  final String signature;
  @override
  final Cacao? cacao;
// for One-Click Auth
  @override
  final String? clientId;

  @override
  String toString() {
    return 'SIWEVerifyMessageArgs(message: $message, signature: $signature, cacao: $cacao, clientId: $clientId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SIWEVerifyMessageArgsImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.signature, signature) ||
                other.signature == signature) &&
            (identical(other.cacao, cacao) || other.cacao == cacao) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, message, signature, cacao, clientId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SIWEVerifyMessageArgsImplCopyWith<_$SIWEVerifyMessageArgsImpl>
      get copyWith => __$$SIWEVerifyMessageArgsImplCopyWithImpl<
          _$SIWEVerifyMessageArgsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SIWEVerifyMessageArgsImplToJson(
      this,
    );
  }
}

abstract class _SIWEVerifyMessageArgs implements SIWEVerifyMessageArgs {
  const factory _SIWEVerifyMessageArgs(
      {required final String message,
      required final String signature,
      final Cacao? cacao,
      final String? clientId}) = _$SIWEVerifyMessageArgsImpl;

  factory _SIWEVerifyMessageArgs.fromJson(Map<String, dynamic> json) =
      _$SIWEVerifyMessageArgsImpl.fromJson;

  @override
  String get message;
  @override
  String get signature;
  @override
  Cacao? get cacao;
  @override // for One-Click Auth
  String? get clientId;
  @override
  @JsonKey(ignore: true)
  _$$SIWEVerifyMessageArgsImplCopyWith<_$SIWEVerifyMessageArgsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

SIWESession _$SIWESessionFromJson(Map<String, dynamic> json) {
  return _SIWESession.fromJson(json);
}

/// @nodoc
mixin _$SIWESession {
  String get address => throw _privateConstructorUsedError;
  List<String> get chains => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SIWESessionCopyWith<SIWESession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SIWESessionCopyWith<$Res> {
  factory $SIWESessionCopyWith(
          SIWESession value, $Res Function(SIWESession) then) =
      _$SIWESessionCopyWithImpl<$Res, SIWESession>;
  @useResult
  $Res call({String address, List<String> chains});
}

/// @nodoc
class _$SIWESessionCopyWithImpl<$Res, $Val extends SIWESession>
    implements $SIWESessionCopyWith<$Res> {
  _$SIWESessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? chains = null,
  }) {
    return _then(_value.copyWith(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      chains: null == chains
          ? _value.chains
          : chains // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SIWESessionImplCopyWith<$Res>
    implements $SIWESessionCopyWith<$Res> {
  factory _$$SIWESessionImplCopyWith(
          _$SIWESessionImpl value, $Res Function(_$SIWESessionImpl) then) =
      __$$SIWESessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String address, List<String> chains});
}

/// @nodoc
class __$$SIWESessionImplCopyWithImpl<$Res>
    extends _$SIWESessionCopyWithImpl<$Res, _$SIWESessionImpl>
    implements _$$SIWESessionImplCopyWith<$Res> {
  __$$SIWESessionImplCopyWithImpl(
      _$SIWESessionImpl _value, $Res Function(_$SIWESessionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? chains = null,
  }) {
    return _then(_$SIWESessionImpl(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      chains: null == chains
          ? _value._chains
          : chains // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SIWESessionImpl implements _SIWESession {
  const _$SIWESessionImpl(
      {required this.address, required final List<String> chains})
      : _chains = chains;

  factory _$SIWESessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SIWESessionImplFromJson(json);

  @override
  final String address;
  final List<String> _chains;
  @override
  List<String> get chains {
    if (_chains is EqualUnmodifiableListView) return _chains;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chains);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SIWESessionImpl &&
            (identical(other.address, address) || other.address == address) &&
            const DeepCollectionEquality().equals(other._chains, _chains));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, address, const DeepCollectionEquality().hash(_chains));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SIWESessionImplCopyWith<_$SIWESessionImpl> get copyWith =>
      __$$SIWESessionImplCopyWithImpl<_$SIWESessionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SIWESessionImplToJson(
      this,
    );
  }
}

abstract class _SIWESession implements SIWESession {
  const factory _SIWESession(
      {required final String address,
      required final List<String> chains}) = _$SIWESessionImpl;

  factory _SIWESession.fromJson(Map<String, dynamic> json) =
      _$SIWESessionImpl.fromJson;

  @override
  String get address;
  @override
  List<String> get chains;
  @override
  @JsonKey(ignore: true)
  _$$SIWESessionImplCopyWith<_$SIWESessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
