// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appkit_network_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReownAppKitModalNetworkInfo {

 String get name; String get chainId; String get currency; String get rpcUrl; String get explorerUrl; List<String> get extraRpcUrls; bool get isTestNetwork; String? get chainIcon;
/// Create a copy of ReownAppKitModalNetworkInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReownAppKitModalNetworkInfoCopyWith<ReownAppKitModalNetworkInfo> get copyWith => _$ReownAppKitModalNetworkInfoCopyWithImpl<ReownAppKitModalNetworkInfo>(this as ReownAppKitModalNetworkInfo, _$identity);

  /// Serializes this ReownAppKitModalNetworkInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReownAppKitModalNetworkInfo&&(identical(other.name, name) || other.name == name)&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.rpcUrl, rpcUrl) || other.rpcUrl == rpcUrl)&&(identical(other.explorerUrl, explorerUrl) || other.explorerUrl == explorerUrl)&&const DeepCollectionEquality().equals(other.extraRpcUrls, extraRpcUrls)&&(identical(other.isTestNetwork, isTestNetwork) || other.isTestNetwork == isTestNetwork)&&(identical(other.chainIcon, chainIcon) || other.chainIcon == chainIcon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,chainId,currency,rpcUrl,explorerUrl,const DeepCollectionEquality().hash(extraRpcUrls),isTestNetwork,chainIcon);

@override
String toString() {
  return 'ReownAppKitModalNetworkInfo(name: $name, chainId: $chainId, currency: $currency, rpcUrl: $rpcUrl, explorerUrl: $explorerUrl, extraRpcUrls: $extraRpcUrls, isTestNetwork: $isTestNetwork, chainIcon: $chainIcon)';
}


}

/// @nodoc
abstract mixin class $ReownAppKitModalNetworkInfoCopyWith<$Res>  {
  factory $ReownAppKitModalNetworkInfoCopyWith(ReownAppKitModalNetworkInfo value, $Res Function(ReownAppKitModalNetworkInfo) _then) = _$ReownAppKitModalNetworkInfoCopyWithImpl;
@useResult
$Res call({
 String name, String chainId, String currency, String rpcUrl, String explorerUrl, List<String> extraRpcUrls, bool isTestNetwork, String? chainIcon
});




}
/// @nodoc
class _$ReownAppKitModalNetworkInfoCopyWithImpl<$Res>
    implements $ReownAppKitModalNetworkInfoCopyWith<$Res> {
  _$ReownAppKitModalNetworkInfoCopyWithImpl(this._self, this._then);

  final ReownAppKitModalNetworkInfo _self;
  final $Res Function(ReownAppKitModalNetworkInfo) _then;

/// Create a copy of ReownAppKitModalNetworkInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? chainId = null,Object? currency = null,Object? rpcUrl = null,Object? explorerUrl = null,Object? extraRpcUrls = null,Object? isTestNetwork = null,Object? chainIcon = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,rpcUrl: null == rpcUrl ? _self.rpcUrl : rpcUrl // ignore: cast_nullable_to_non_nullable
as String,explorerUrl: null == explorerUrl ? _self.explorerUrl : explorerUrl // ignore: cast_nullable_to_non_nullable
as String,extraRpcUrls: null == extraRpcUrls ? _self.extraRpcUrls : extraRpcUrls // ignore: cast_nullable_to_non_nullable
as List<String>,isTestNetwork: null == isTestNetwork ? _self.isTestNetwork : isTestNetwork // ignore: cast_nullable_to_non_nullable
as bool,chainIcon: freezed == chainIcon ? _self.chainIcon : chainIcon // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReownAppKitModalNetworkInfo].
extension ReownAppKitModalNetworkInfoPatterns on ReownAppKitModalNetworkInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReownAppKitModalNetworkInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReownAppKitModalNetworkInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReownAppKitModalNetworkInfo value)  $default,){
final _that = this;
switch (_that) {
case _ReownAppKitModalNetworkInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReownAppKitModalNetworkInfo value)?  $default,){
final _that = this;
switch (_that) {
case _ReownAppKitModalNetworkInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String chainId,  String currency,  String rpcUrl,  String explorerUrl,  List<String> extraRpcUrls,  bool isTestNetwork,  String? chainIcon)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReownAppKitModalNetworkInfo() when $default != null:
return $default(_that.name,_that.chainId,_that.currency,_that.rpcUrl,_that.explorerUrl,_that.extraRpcUrls,_that.isTestNetwork,_that.chainIcon);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String chainId,  String currency,  String rpcUrl,  String explorerUrl,  List<String> extraRpcUrls,  bool isTestNetwork,  String? chainIcon)  $default,) {final _that = this;
switch (_that) {
case _ReownAppKitModalNetworkInfo():
return $default(_that.name,_that.chainId,_that.currency,_that.rpcUrl,_that.explorerUrl,_that.extraRpcUrls,_that.isTestNetwork,_that.chainIcon);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String chainId,  String currency,  String rpcUrl,  String explorerUrl,  List<String> extraRpcUrls,  bool isTestNetwork,  String? chainIcon)?  $default,) {final _that = this;
switch (_that) {
case _ReownAppKitModalNetworkInfo() when $default != null:
return $default(_that.name,_that.chainId,_that.currency,_that.rpcUrl,_that.explorerUrl,_that.extraRpcUrls,_that.isTestNetwork,_that.chainIcon);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReownAppKitModalNetworkInfo implements ReownAppKitModalNetworkInfo {
  const _ReownAppKitModalNetworkInfo({required this.name, required this.chainId, required this.currency, required this.rpcUrl, required this.explorerUrl, final  List<String> extraRpcUrls = const <String>[], this.isTestNetwork = false, this.chainIcon}): _extraRpcUrls = extraRpcUrls;
  factory _ReownAppKitModalNetworkInfo.fromJson(Map<String, dynamic> json) => _$ReownAppKitModalNetworkInfoFromJson(json);

@override final  String name;
@override final  String chainId;
@override final  String currency;
@override final  String rpcUrl;
@override final  String explorerUrl;
 final  List<String> _extraRpcUrls;
@override@JsonKey() List<String> get extraRpcUrls {
  if (_extraRpcUrls is EqualUnmodifiableListView) return _extraRpcUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_extraRpcUrls);
}

@override@JsonKey() final  bool isTestNetwork;
@override final  String? chainIcon;

/// Create a copy of ReownAppKitModalNetworkInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReownAppKitModalNetworkInfoCopyWith<_ReownAppKitModalNetworkInfo> get copyWith => __$ReownAppKitModalNetworkInfoCopyWithImpl<_ReownAppKitModalNetworkInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReownAppKitModalNetworkInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReownAppKitModalNetworkInfo&&(identical(other.name, name) || other.name == name)&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.rpcUrl, rpcUrl) || other.rpcUrl == rpcUrl)&&(identical(other.explorerUrl, explorerUrl) || other.explorerUrl == explorerUrl)&&const DeepCollectionEquality().equals(other._extraRpcUrls, _extraRpcUrls)&&(identical(other.isTestNetwork, isTestNetwork) || other.isTestNetwork == isTestNetwork)&&(identical(other.chainIcon, chainIcon) || other.chainIcon == chainIcon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,chainId,currency,rpcUrl,explorerUrl,const DeepCollectionEquality().hash(_extraRpcUrls),isTestNetwork,chainIcon);

@override
String toString() {
  return 'ReownAppKitModalNetworkInfo(name: $name, chainId: $chainId, currency: $currency, rpcUrl: $rpcUrl, explorerUrl: $explorerUrl, extraRpcUrls: $extraRpcUrls, isTestNetwork: $isTestNetwork, chainIcon: $chainIcon)';
}


}

/// @nodoc
abstract mixin class _$ReownAppKitModalNetworkInfoCopyWith<$Res> implements $ReownAppKitModalNetworkInfoCopyWith<$Res> {
  factory _$ReownAppKitModalNetworkInfoCopyWith(_ReownAppKitModalNetworkInfo value, $Res Function(_ReownAppKitModalNetworkInfo) _then) = __$ReownAppKitModalNetworkInfoCopyWithImpl;
@override @useResult
$Res call({
 String name, String chainId, String currency, String rpcUrl, String explorerUrl, List<String> extraRpcUrls, bool isTestNetwork, String? chainIcon
});




}
/// @nodoc
class __$ReownAppKitModalNetworkInfoCopyWithImpl<$Res>
    implements _$ReownAppKitModalNetworkInfoCopyWith<$Res> {
  __$ReownAppKitModalNetworkInfoCopyWithImpl(this._self, this._then);

  final _ReownAppKitModalNetworkInfo _self;
  final $Res Function(_ReownAppKitModalNetworkInfo) _then;

/// Create a copy of ReownAppKitModalNetworkInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? chainId = null,Object? currency = null,Object? rpcUrl = null,Object? explorerUrl = null,Object? extraRpcUrls = null,Object? isTestNetwork = null,Object? chainIcon = freezed,}) {
  return _then(_ReownAppKitModalNetworkInfo(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,rpcUrl: null == rpcUrl ? _self.rpcUrl : rpcUrl // ignore: cast_nullable_to_non_nullable
as String,explorerUrl: null == explorerUrl ? _self.explorerUrl : explorerUrl // ignore: cast_nullable_to_non_nullable
as String,extraRpcUrls: null == extraRpcUrls ? _self._extraRpcUrls : extraRpcUrls // ignore: cast_nullable_to_non_nullable
as List<String>,isTestNetwork: null == isTestNetwork ? _self.isTestNetwork : isTestNetwork // ignore: cast_nullable_to_non_nullable
as bool,chainIcon: freezed == chainIcon ? _self.chainIcon : chainIcon // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
