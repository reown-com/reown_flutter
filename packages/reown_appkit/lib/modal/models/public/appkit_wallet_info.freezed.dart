// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appkit_wallet_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReownAppKitModalWalletInfo {

 AppKitModalWalletListing get listing; bool get installed; bool get recent;
/// Create a copy of ReownAppKitModalWalletInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReownAppKitModalWalletInfoCopyWith<ReownAppKitModalWalletInfo> get copyWith => _$ReownAppKitModalWalletInfoCopyWithImpl<ReownAppKitModalWalletInfo>(this as ReownAppKitModalWalletInfo, _$identity);

  /// Serializes this ReownAppKitModalWalletInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReownAppKitModalWalletInfo&&(identical(other.listing, listing) || other.listing == listing)&&(identical(other.installed, installed) || other.installed == installed)&&(identical(other.recent, recent) || other.recent == recent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,listing,installed,recent);

@override
String toString() {
  return 'ReownAppKitModalWalletInfo(listing: $listing, installed: $installed, recent: $recent)';
}


}

/// @nodoc
abstract mixin class $ReownAppKitModalWalletInfoCopyWith<$Res>  {
  factory $ReownAppKitModalWalletInfoCopyWith(ReownAppKitModalWalletInfo value, $Res Function(ReownAppKitModalWalletInfo) _then) = _$ReownAppKitModalWalletInfoCopyWithImpl;
@useResult
$Res call({
 AppKitModalWalletListing listing, bool installed, bool recent
});




}
/// @nodoc
class _$ReownAppKitModalWalletInfoCopyWithImpl<$Res>
    implements $ReownAppKitModalWalletInfoCopyWith<$Res> {
  _$ReownAppKitModalWalletInfoCopyWithImpl(this._self, this._then);

  final ReownAppKitModalWalletInfo _self;
  final $Res Function(ReownAppKitModalWalletInfo) _then;

/// Create a copy of ReownAppKitModalWalletInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? listing = null,Object? installed = null,Object? recent = null,}) {
  return _then(_self.copyWith(
listing: null == listing ? _self.listing : listing // ignore: cast_nullable_to_non_nullable
as AppKitModalWalletListing,installed: null == installed ? _self.installed : installed // ignore: cast_nullable_to_non_nullable
as bool,recent: null == recent ? _self.recent : recent // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ReownAppKitModalWalletInfo].
extension ReownAppKitModalWalletInfoPatterns on ReownAppKitModalWalletInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReownAppKitModalWalletInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReownAppKitModalWalletInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReownAppKitModalWalletInfo value)  $default,){
final _that = this;
switch (_that) {
case _ReownAppKitModalWalletInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReownAppKitModalWalletInfo value)?  $default,){
final _that = this;
switch (_that) {
case _ReownAppKitModalWalletInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AppKitModalWalletListing listing,  bool installed,  bool recent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReownAppKitModalWalletInfo() when $default != null:
return $default(_that.listing,_that.installed,_that.recent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AppKitModalWalletListing listing,  bool installed,  bool recent)  $default,) {final _that = this;
switch (_that) {
case _ReownAppKitModalWalletInfo():
return $default(_that.listing,_that.installed,_that.recent);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AppKitModalWalletListing listing,  bool installed,  bool recent)?  $default,) {final _that = this;
switch (_that) {
case _ReownAppKitModalWalletInfo() when $default != null:
return $default(_that.listing,_that.installed,_that.recent);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReownAppKitModalWalletInfo implements ReownAppKitModalWalletInfo {
  const _ReownAppKitModalWalletInfo({required this.listing, this.installed = false, this.recent = false});
  factory _ReownAppKitModalWalletInfo.fromJson(Map<String, dynamic> json) => _$ReownAppKitModalWalletInfoFromJson(json);

@override final  AppKitModalWalletListing listing;
@override@JsonKey() final  bool installed;
@override@JsonKey() final  bool recent;

/// Create a copy of ReownAppKitModalWalletInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReownAppKitModalWalletInfoCopyWith<_ReownAppKitModalWalletInfo> get copyWith => __$ReownAppKitModalWalletInfoCopyWithImpl<_ReownAppKitModalWalletInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReownAppKitModalWalletInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReownAppKitModalWalletInfo&&(identical(other.listing, listing) || other.listing == listing)&&(identical(other.installed, installed) || other.installed == installed)&&(identical(other.recent, recent) || other.recent == recent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,listing,installed,recent);

@override
String toString() {
  return 'ReownAppKitModalWalletInfo(listing: $listing, installed: $installed, recent: $recent)';
}


}

/// @nodoc
abstract mixin class _$ReownAppKitModalWalletInfoCopyWith<$Res> implements $ReownAppKitModalWalletInfoCopyWith<$Res> {
  factory _$ReownAppKitModalWalletInfoCopyWith(_ReownAppKitModalWalletInfo value, $Res Function(_ReownAppKitModalWalletInfo) _then) = __$ReownAppKitModalWalletInfoCopyWithImpl;
@override @useResult
$Res call({
 AppKitModalWalletListing listing, bool installed, bool recent
});




}
/// @nodoc
class __$ReownAppKitModalWalletInfoCopyWithImpl<$Res>
    implements _$ReownAppKitModalWalletInfoCopyWith<$Res> {
  __$ReownAppKitModalWalletInfoCopyWithImpl(this._self, this._then);

  final _ReownAppKitModalWalletInfo _self;
  final $Res Function(_ReownAppKitModalWalletInfo) _then;

/// Create a copy of ReownAppKitModalWalletInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? listing = null,Object? installed = null,Object? recent = null,}) {
  return _then(_ReownAppKitModalWalletInfo(
listing: null == listing ? _self.listing : listing // ignore: cast_nullable_to_non_nullable
as AppKitModalWalletListing,installed: null == installed ? _self.installed : installed // ignore: cast_nullable_to_non_nullable
as bool,recent: null == recent ? _self.recent : recent // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
