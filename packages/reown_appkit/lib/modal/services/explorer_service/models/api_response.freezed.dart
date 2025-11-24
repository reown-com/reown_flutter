// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GetWalletsResponse {

 int get count; int? get nextPage; int? get previousPage; List<AppKitModalWalletListing> get data;
/// Create a copy of GetWalletsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetWalletsResponseCopyWith<GetWalletsResponse> get copyWith => _$GetWalletsResponseCopyWithImpl<GetWalletsResponse>(this as GetWalletsResponse, _$identity);

  /// Serializes this GetWalletsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetWalletsResponse&&(identical(other.count, count) || other.count == count)&&(identical(other.nextPage, nextPage) || other.nextPage == nextPage)&&(identical(other.previousPage, previousPage) || other.previousPage == previousPage)&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,count,nextPage,previousPage,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'GetWalletsResponse(count: $count, nextPage: $nextPage, previousPage: $previousPage, data: $data)';
}


}

/// @nodoc
abstract mixin class $GetWalletsResponseCopyWith<$Res>  {
  factory $GetWalletsResponseCopyWith(GetWalletsResponse value, $Res Function(GetWalletsResponse) _then) = _$GetWalletsResponseCopyWithImpl;
@useResult
$Res call({
 int count, int? nextPage, int? previousPage, List<AppKitModalWalletListing> data
});




}
/// @nodoc
class _$GetWalletsResponseCopyWithImpl<$Res>
    implements $GetWalletsResponseCopyWith<$Res> {
  _$GetWalletsResponseCopyWithImpl(this._self, this._then);

  final GetWalletsResponse _self;
  final $Res Function(GetWalletsResponse) _then;

/// Create a copy of GetWalletsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? count = null,Object? nextPage = freezed,Object? previousPage = freezed,Object? data = null,}) {
  return _then(_self.copyWith(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,nextPage: freezed == nextPage ? _self.nextPage : nextPage // ignore: cast_nullable_to_non_nullable
as int?,previousPage: freezed == previousPage ? _self.previousPage : previousPage // ignore: cast_nullable_to_non_nullable
as int?,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as List<AppKitModalWalletListing>,
  ));
}

}


/// Adds pattern-matching-related methods to [GetWalletsResponse].
extension GetWalletsResponsePatterns on GetWalletsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetWalletsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetWalletsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetWalletsResponse value)  $default,){
final _that = this;
switch (_that) {
case _GetWalletsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetWalletsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _GetWalletsResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int count,  int? nextPage,  int? previousPage,  List<AppKitModalWalletListing> data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetWalletsResponse() when $default != null:
return $default(_that.count,_that.nextPage,_that.previousPage,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int count,  int? nextPage,  int? previousPage,  List<AppKitModalWalletListing> data)  $default,) {final _that = this;
switch (_that) {
case _GetWalletsResponse():
return $default(_that.count,_that.nextPage,_that.previousPage,_that.data);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int count,  int? nextPage,  int? previousPage,  List<AppKitModalWalletListing> data)?  $default,) {final _that = this;
switch (_that) {
case _GetWalletsResponse() when $default != null:
return $default(_that.count,_that.nextPage,_that.previousPage,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GetWalletsResponse implements GetWalletsResponse {
  const _GetWalletsResponse({required this.count, required this.nextPage, required this.previousPage, required final  List<AppKitModalWalletListing> data}): _data = data;
  factory _GetWalletsResponse.fromJson(Map<String, dynamic> json) => _$GetWalletsResponseFromJson(json);

@override final  int count;
@override final  int? nextPage;
@override final  int? previousPage;
 final  List<AppKitModalWalletListing> _data;
@override List<AppKitModalWalletListing> get data {
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data);
}


/// Create a copy of GetWalletsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetWalletsResponseCopyWith<_GetWalletsResponse> get copyWith => __$GetWalletsResponseCopyWithImpl<_GetWalletsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GetWalletsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetWalletsResponse&&(identical(other.count, count) || other.count == count)&&(identical(other.nextPage, nextPage) || other.nextPage == nextPage)&&(identical(other.previousPage, previousPage) || other.previousPage == previousPage)&&const DeepCollectionEquality().equals(other._data, _data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,count,nextPage,previousPage,const DeepCollectionEquality().hash(_data));

@override
String toString() {
  return 'GetWalletsResponse(count: $count, nextPage: $nextPage, previousPage: $previousPage, data: $data)';
}


}

/// @nodoc
abstract mixin class _$GetWalletsResponseCopyWith<$Res> implements $GetWalletsResponseCopyWith<$Res> {
  factory _$GetWalletsResponseCopyWith(_GetWalletsResponse value, $Res Function(_GetWalletsResponse) _then) = __$GetWalletsResponseCopyWithImpl;
@override @useResult
$Res call({
 int count, int? nextPage, int? previousPage, List<AppKitModalWalletListing> data
});




}
/// @nodoc
class __$GetWalletsResponseCopyWithImpl<$Res>
    implements _$GetWalletsResponseCopyWith<$Res> {
  __$GetWalletsResponseCopyWithImpl(this._self, this._then);

  final _GetWalletsResponse _self;
  final $Res Function(_GetWalletsResponse) _then;

/// Create a copy of GetWalletsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? count = null,Object? nextPage = freezed,Object? previousPage = freezed,Object? data = null,}) {
  return _then(_GetWalletsResponse(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,nextPage: freezed == nextPage ? _self.nextPage : nextPage // ignore: cast_nullable_to_non_nullable
as int?,previousPage: freezed == previousPage ? _self.previousPage : previousPage // ignore: cast_nullable_to_non_nullable
as int?,data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<AppKitModalWalletListing>,
  ));
}


}


/// @nodoc
mixin _$NativeDataResponse {

 int get count; List<NativeAppData> get data;
/// Create a copy of NativeDataResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NativeDataResponseCopyWith<NativeDataResponse> get copyWith => _$NativeDataResponseCopyWithImpl<NativeDataResponse>(this as NativeDataResponse, _$identity);

  /// Serializes this NativeDataResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NativeDataResponse&&(identical(other.count, count) || other.count == count)&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,count,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'NativeDataResponse(count: $count, data: $data)';
}


}

/// @nodoc
abstract mixin class $NativeDataResponseCopyWith<$Res>  {
  factory $NativeDataResponseCopyWith(NativeDataResponse value, $Res Function(NativeDataResponse) _then) = _$NativeDataResponseCopyWithImpl;
@useResult
$Res call({
 int count, List<NativeAppData> data
});




}
/// @nodoc
class _$NativeDataResponseCopyWithImpl<$Res>
    implements $NativeDataResponseCopyWith<$Res> {
  _$NativeDataResponseCopyWithImpl(this._self, this._then);

  final NativeDataResponse _self;
  final $Res Function(NativeDataResponse) _then;

/// Create a copy of NativeDataResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? count = null,Object? data = null,}) {
  return _then(_self.copyWith(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as List<NativeAppData>,
  ));
}

}


/// Adds pattern-matching-related methods to [NativeDataResponse].
extension NativeDataResponsePatterns on NativeDataResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NativeDataResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NativeDataResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NativeDataResponse value)  $default,){
final _that = this;
switch (_that) {
case _NativeDataResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NativeDataResponse value)?  $default,){
final _that = this;
switch (_that) {
case _NativeDataResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int count,  List<NativeAppData> data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NativeDataResponse() when $default != null:
return $default(_that.count,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int count,  List<NativeAppData> data)  $default,) {final _that = this;
switch (_that) {
case _NativeDataResponse():
return $default(_that.count,_that.data);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int count,  List<NativeAppData> data)?  $default,) {final _that = this;
switch (_that) {
case _NativeDataResponse() when $default != null:
return $default(_that.count,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NativeDataResponse implements NativeDataResponse {
  const _NativeDataResponse({required this.count, required final  List<NativeAppData> data}): _data = data;
  factory _NativeDataResponse.fromJson(Map<String, dynamic> json) => _$NativeDataResponseFromJson(json);

@override final  int count;
 final  List<NativeAppData> _data;
@override List<NativeAppData> get data {
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data);
}


/// Create a copy of NativeDataResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NativeDataResponseCopyWith<_NativeDataResponse> get copyWith => __$NativeDataResponseCopyWithImpl<_NativeDataResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NativeDataResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NativeDataResponse&&(identical(other.count, count) || other.count == count)&&const DeepCollectionEquality().equals(other._data, _data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,count,const DeepCollectionEquality().hash(_data));

@override
String toString() {
  return 'NativeDataResponse(count: $count, data: $data)';
}


}

/// @nodoc
abstract mixin class _$NativeDataResponseCopyWith<$Res> implements $NativeDataResponseCopyWith<$Res> {
  factory _$NativeDataResponseCopyWith(_NativeDataResponse value, $Res Function(_NativeDataResponse) _then) = __$NativeDataResponseCopyWithImpl;
@override @useResult
$Res call({
 int count, List<NativeAppData> data
});




}
/// @nodoc
class __$NativeDataResponseCopyWithImpl<$Res>
    implements _$NativeDataResponseCopyWith<$Res> {
  __$NativeDataResponseCopyWithImpl(this._self, this._then);

  final _NativeDataResponse _self;
  final $Res Function(_NativeDataResponse) _then;

/// Create a copy of NativeDataResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? count = null,Object? data = null,}) {
  return _then(_NativeDataResponse(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<NativeAppData>,
  ));
}


}

// dart format on
