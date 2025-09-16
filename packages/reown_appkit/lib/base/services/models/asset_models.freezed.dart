// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'asset_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AssetMetadata {

 String get name; String get symbol; int get decimals;
/// Create a copy of AssetMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssetMetadataCopyWith<AssetMetadata> get copyWith => _$AssetMetadataCopyWithImpl<AssetMetadata>(this as AssetMetadata, _$identity);

  /// Serializes this AssetMetadata to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssetMetadata&&(identical(other.name, name) || other.name == name)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.decimals, decimals) || other.decimals == decimals));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,symbol,decimals);

@override
String toString() {
  return 'AssetMetadata(name: $name, symbol: $symbol, decimals: $decimals)';
}


}

/// @nodoc
abstract mixin class $AssetMetadataCopyWith<$Res>  {
  factory $AssetMetadataCopyWith(AssetMetadata value, $Res Function(AssetMetadata) _then) = _$AssetMetadataCopyWithImpl;
@useResult
$Res call({
 String name, String symbol, int decimals
});




}
/// @nodoc
class _$AssetMetadataCopyWithImpl<$Res>
    implements $AssetMetadataCopyWith<$Res> {
  _$AssetMetadataCopyWithImpl(this._self, this._then);

  final AssetMetadata _self;
  final $Res Function(AssetMetadata) _then;

/// Create a copy of AssetMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? symbol = null,Object? decimals = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,decimals: null == decimals ? _self.decimals : decimals // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AssetMetadata].
extension AssetMetadataPatterns on AssetMetadata {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AssetMetadata value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AssetMetadata() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AssetMetadata value)  $default,){
final _that = this;
switch (_that) {
case _AssetMetadata():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AssetMetadata value)?  $default,){
final _that = this;
switch (_that) {
case _AssetMetadata() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String symbol,  int decimals)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AssetMetadata() when $default != null:
return $default(_that.name,_that.symbol,_that.decimals);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String symbol,  int decimals)  $default,) {final _that = this;
switch (_that) {
case _AssetMetadata():
return $default(_that.name,_that.symbol,_that.decimals);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String symbol,  int decimals)?  $default,) {final _that = this;
switch (_that) {
case _AssetMetadata() when $default != null:
return $default(_that.name,_that.symbol,_that.decimals);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AssetMetadata implements AssetMetadata {
  const _AssetMetadata({required this.name, required this.symbol, required this.decimals});
  factory _AssetMetadata.fromJson(Map<String, dynamic> json) => _$AssetMetadataFromJson(json);

@override final  String name;
@override final  String symbol;
@override final  int decimals;

/// Create a copy of AssetMetadata
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AssetMetadataCopyWith<_AssetMetadata> get copyWith => __$AssetMetadataCopyWithImpl<_AssetMetadata>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AssetMetadataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssetMetadata&&(identical(other.name, name) || other.name == name)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.decimals, decimals) || other.decimals == decimals));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,symbol,decimals);

@override
String toString() {
  return 'AssetMetadata(name: $name, symbol: $symbol, decimals: $decimals)';
}


}

/// @nodoc
abstract mixin class _$AssetMetadataCopyWith<$Res> implements $AssetMetadataCopyWith<$Res> {
  factory _$AssetMetadataCopyWith(_AssetMetadata value, $Res Function(_AssetMetadata) _then) = __$AssetMetadataCopyWithImpl;
@override @useResult
$Res call({
 String name, String symbol, int decimals
});




}
/// @nodoc
class __$AssetMetadataCopyWithImpl<$Res>
    implements _$AssetMetadataCopyWith<$Res> {
  __$AssetMetadataCopyWithImpl(this._self, this._then);

  final _AssetMetadata _self;
  final $Res Function(_AssetMetadata) _then;

/// Create a copy of AssetMetadata
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? symbol = null,Object? decimals = null,}) {
  return _then(_AssetMetadata(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,decimals: null == decimals ? _self.decimals : decimals // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ExchangeAsset {

 String get network; String get asset; AssetMetadata get metadata;
/// Create a copy of ExchangeAsset
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExchangeAssetCopyWith<ExchangeAsset> get copyWith => _$ExchangeAssetCopyWithImpl<ExchangeAsset>(this as ExchangeAsset, _$identity);

  /// Serializes this ExchangeAsset to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExchangeAsset&&(identical(other.network, network) || other.network == network)&&(identical(other.asset, asset) || other.asset == asset)&&(identical(other.metadata, metadata) || other.metadata == metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,network,asset,metadata);

@override
String toString() {
  return 'ExchangeAsset(network: $network, asset: $asset, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $ExchangeAssetCopyWith<$Res>  {
  factory $ExchangeAssetCopyWith(ExchangeAsset value, $Res Function(ExchangeAsset) _then) = _$ExchangeAssetCopyWithImpl;
@useResult
$Res call({
 String network, String asset, AssetMetadata metadata
});


$AssetMetadataCopyWith<$Res> get metadata;

}
/// @nodoc
class _$ExchangeAssetCopyWithImpl<$Res>
    implements $ExchangeAssetCopyWith<$Res> {
  _$ExchangeAssetCopyWithImpl(this._self, this._then);

  final ExchangeAsset _self;
  final $Res Function(ExchangeAsset) _then;

/// Create a copy of ExchangeAsset
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? network = null,Object? asset = null,Object? metadata = null,}) {
  return _then(_self.copyWith(
network: null == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String,asset: null == asset ? _self.asset : asset // ignore: cast_nullable_to_non_nullable
as String,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as AssetMetadata,
  ));
}
/// Create a copy of ExchangeAsset
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AssetMetadataCopyWith<$Res> get metadata {
  
  return $AssetMetadataCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}
}


/// Adds pattern-matching-related methods to [ExchangeAsset].
extension ExchangeAssetPatterns on ExchangeAsset {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExchangeAsset value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExchangeAsset() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExchangeAsset value)  $default,){
final _that = this;
switch (_that) {
case _ExchangeAsset():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExchangeAsset value)?  $default,){
final _that = this;
switch (_that) {
case _ExchangeAsset() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String network,  String asset,  AssetMetadata metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExchangeAsset() when $default != null:
return $default(_that.network,_that.asset,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String network,  String asset,  AssetMetadata metadata)  $default,) {final _that = this;
switch (_that) {
case _ExchangeAsset():
return $default(_that.network,_that.asset,_that.metadata);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String network,  String asset,  AssetMetadata metadata)?  $default,) {final _that = this;
switch (_that) {
case _ExchangeAsset() when $default != null:
return $default(_that.network,_that.asset,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExchangeAsset implements ExchangeAsset {
  const _ExchangeAsset({required this.network, required this.asset, required this.metadata});
  factory _ExchangeAsset.fromJson(Map<String, dynamic> json) => _$ExchangeAssetFromJson(json);

@override final  String network;
@override final  String asset;
@override final  AssetMetadata metadata;

/// Create a copy of ExchangeAsset
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExchangeAssetCopyWith<_ExchangeAsset> get copyWith => __$ExchangeAssetCopyWithImpl<_ExchangeAsset>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExchangeAssetToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExchangeAsset&&(identical(other.network, network) || other.network == network)&&(identical(other.asset, asset) || other.asset == asset)&&(identical(other.metadata, metadata) || other.metadata == metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,network,asset,metadata);

@override
String toString() {
  return 'ExchangeAsset(network: $network, asset: $asset, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$ExchangeAssetCopyWith<$Res> implements $ExchangeAssetCopyWith<$Res> {
  factory _$ExchangeAssetCopyWith(_ExchangeAsset value, $Res Function(_ExchangeAsset) _then) = __$ExchangeAssetCopyWithImpl;
@override @useResult
$Res call({
 String network, String asset, AssetMetadata metadata
});


@override $AssetMetadataCopyWith<$Res> get metadata;

}
/// @nodoc
class __$ExchangeAssetCopyWithImpl<$Res>
    implements _$ExchangeAssetCopyWith<$Res> {
  __$ExchangeAssetCopyWithImpl(this._self, this._then);

  final _ExchangeAsset _self;
  final $Res Function(_ExchangeAsset) _then;

/// Create a copy of ExchangeAsset
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? network = null,Object? asset = null,Object? metadata = null,}) {
  return _then(_ExchangeAsset(
network: null == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String,asset: null == asset ? _self.asset : asset // ignore: cast_nullable_to_non_nullable
as String,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as AssetMetadata,
  ));
}

/// Create a copy of ExchangeAsset
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AssetMetadataCopyWith<$Res> get metadata {
  
  return $AssetMetadataCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}
}

// dart format on
