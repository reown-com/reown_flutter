// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'walletconnect_pay_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SdkConfig {

 String get baseUrl; String get apiKey; String get sdkName; String get sdkVersion; String get sdkPlatform;
/// Create a copy of SdkConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SdkConfigCopyWith<SdkConfig> get copyWith => _$SdkConfigCopyWithImpl<SdkConfig>(this as SdkConfig, _$identity);

  /// Serializes this SdkConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SdkConfig&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl)&&(identical(other.apiKey, apiKey) || other.apiKey == apiKey)&&(identical(other.sdkName, sdkName) || other.sdkName == sdkName)&&(identical(other.sdkVersion, sdkVersion) || other.sdkVersion == sdkVersion)&&(identical(other.sdkPlatform, sdkPlatform) || other.sdkPlatform == sdkPlatform));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,baseUrl,apiKey,sdkName,sdkVersion,sdkPlatform);

@override
String toString() {
  return 'SdkConfig(baseUrl: $baseUrl, apiKey: $apiKey, sdkName: $sdkName, sdkVersion: $sdkVersion, sdkPlatform: $sdkPlatform)';
}


}

/// @nodoc
abstract mixin class $SdkConfigCopyWith<$Res>  {
  factory $SdkConfigCopyWith(SdkConfig value, $Res Function(SdkConfig) _then) = _$SdkConfigCopyWithImpl;
@useResult
$Res call({
 String baseUrl, String apiKey, String sdkName, String sdkVersion, String sdkPlatform
});




}
/// @nodoc
class _$SdkConfigCopyWithImpl<$Res>
    implements $SdkConfigCopyWith<$Res> {
  _$SdkConfigCopyWithImpl(this._self, this._then);

  final SdkConfig _self;
  final $Res Function(SdkConfig) _then;

/// Create a copy of SdkConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? baseUrl = null,Object? apiKey = null,Object? sdkName = null,Object? sdkVersion = null,Object? sdkPlatform = null,}) {
  return _then(_self.copyWith(
baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as String,apiKey: null == apiKey ? _self.apiKey : apiKey // ignore: cast_nullable_to_non_nullable
as String,sdkName: null == sdkName ? _self.sdkName : sdkName // ignore: cast_nullable_to_non_nullable
as String,sdkVersion: null == sdkVersion ? _self.sdkVersion : sdkVersion // ignore: cast_nullable_to_non_nullable
as String,sdkPlatform: null == sdkPlatform ? _self.sdkPlatform : sdkPlatform // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SdkConfig].
extension SdkConfigPatterns on SdkConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SdkConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SdkConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SdkConfig value)  $default,){
final _that = this;
switch (_that) {
case _SdkConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SdkConfig value)?  $default,){
final _that = this;
switch (_that) {
case _SdkConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String baseUrl,  String apiKey,  String sdkName,  String sdkVersion,  String sdkPlatform)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SdkConfig() when $default != null:
return $default(_that.baseUrl,_that.apiKey,_that.sdkName,_that.sdkVersion,_that.sdkPlatform);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String baseUrl,  String apiKey,  String sdkName,  String sdkVersion,  String sdkPlatform)  $default,) {final _that = this;
switch (_that) {
case _SdkConfig():
return $default(_that.baseUrl,_that.apiKey,_that.sdkName,_that.sdkVersion,_that.sdkPlatform);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String baseUrl,  String apiKey,  String sdkName,  String sdkVersion,  String sdkPlatform)?  $default,) {final _that = this;
switch (_that) {
case _SdkConfig() when $default != null:
return $default(_that.baseUrl,_that.apiKey,_that.sdkName,_that.sdkVersion,_that.sdkPlatform);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SdkConfig implements SdkConfig {
  const _SdkConfig({required this.baseUrl, required this.apiKey, required this.sdkName, required this.sdkVersion, required this.sdkPlatform});
  factory _SdkConfig.fromJson(Map<String, dynamic> json) => _$SdkConfigFromJson(json);

@override final  String baseUrl;
@override final  String apiKey;
@override final  String sdkName;
@override final  String sdkVersion;
@override final  String sdkPlatform;

/// Create a copy of SdkConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SdkConfigCopyWith<_SdkConfig> get copyWith => __$SdkConfigCopyWithImpl<_SdkConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SdkConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SdkConfig&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl)&&(identical(other.apiKey, apiKey) || other.apiKey == apiKey)&&(identical(other.sdkName, sdkName) || other.sdkName == sdkName)&&(identical(other.sdkVersion, sdkVersion) || other.sdkVersion == sdkVersion)&&(identical(other.sdkPlatform, sdkPlatform) || other.sdkPlatform == sdkPlatform));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,baseUrl,apiKey,sdkName,sdkVersion,sdkPlatform);

@override
String toString() {
  return 'SdkConfig(baseUrl: $baseUrl, apiKey: $apiKey, sdkName: $sdkName, sdkVersion: $sdkVersion, sdkPlatform: $sdkPlatform)';
}


}

/// @nodoc
abstract mixin class _$SdkConfigCopyWith<$Res> implements $SdkConfigCopyWith<$Res> {
  factory _$SdkConfigCopyWith(_SdkConfig value, $Res Function(_SdkConfig) _then) = __$SdkConfigCopyWithImpl;
@override @useResult
$Res call({
 String baseUrl, String apiKey, String sdkName, String sdkVersion, String sdkPlatform
});




}
/// @nodoc
class __$SdkConfigCopyWithImpl<$Res>
    implements _$SdkConfigCopyWith<$Res> {
  __$SdkConfigCopyWithImpl(this._self, this._then);

  final _SdkConfig _self;
  final $Res Function(_SdkConfig) _then;

/// Create a copy of SdkConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? baseUrl = null,Object? apiKey = null,Object? sdkName = null,Object? sdkVersion = null,Object? sdkPlatform = null,}) {
  return _then(_SdkConfig(
baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as String,apiKey: null == apiKey ? _self.apiKey : apiKey // ignore: cast_nullable_to_non_nullable
as String,sdkName: null == sdkName ? _self.sdkName : sdkName // ignore: cast_nullable_to_non_nullable
as String,sdkVersion: null == sdkVersion ? _self.sdkVersion : sdkVersion // ignore: cast_nullable_to_non_nullable
as String,sdkPlatform: null == sdkPlatform ? _self.sdkPlatform : sdkPlatform // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$GetPaymentOptionsRequest {

 String get paymentLink; List<String> get accounts;
/// Create a copy of GetPaymentOptionsRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetPaymentOptionsRequestCopyWith<GetPaymentOptionsRequest> get copyWith => _$GetPaymentOptionsRequestCopyWithImpl<GetPaymentOptionsRequest>(this as GetPaymentOptionsRequest, _$identity);

  /// Serializes this GetPaymentOptionsRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetPaymentOptionsRequest&&(identical(other.paymentLink, paymentLink) || other.paymentLink == paymentLink)&&const DeepCollectionEquality().equals(other.accounts, accounts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,paymentLink,const DeepCollectionEquality().hash(accounts));

@override
String toString() {
  return 'GetPaymentOptionsRequest(paymentLink: $paymentLink, accounts: $accounts)';
}


}

/// @nodoc
abstract mixin class $GetPaymentOptionsRequestCopyWith<$Res>  {
  factory $GetPaymentOptionsRequestCopyWith(GetPaymentOptionsRequest value, $Res Function(GetPaymentOptionsRequest) _then) = _$GetPaymentOptionsRequestCopyWithImpl;
@useResult
$Res call({
 String paymentLink, List<String> accounts
});




}
/// @nodoc
class _$GetPaymentOptionsRequestCopyWithImpl<$Res>
    implements $GetPaymentOptionsRequestCopyWith<$Res> {
  _$GetPaymentOptionsRequestCopyWithImpl(this._self, this._then);

  final GetPaymentOptionsRequest _self;
  final $Res Function(GetPaymentOptionsRequest) _then;

/// Create a copy of GetPaymentOptionsRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? paymentLink = null,Object? accounts = null,}) {
  return _then(_self.copyWith(
paymentLink: null == paymentLink ? _self.paymentLink : paymentLink // ignore: cast_nullable_to_non_nullable
as String,accounts: null == accounts ? _self.accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [GetPaymentOptionsRequest].
extension GetPaymentOptionsRequestPatterns on GetPaymentOptionsRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetPaymentOptionsRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetPaymentOptionsRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetPaymentOptionsRequest value)  $default,){
final _that = this;
switch (_that) {
case _GetPaymentOptionsRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetPaymentOptionsRequest value)?  $default,){
final _that = this;
switch (_that) {
case _GetPaymentOptionsRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String paymentLink,  List<String> accounts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetPaymentOptionsRequest() when $default != null:
return $default(_that.paymentLink,_that.accounts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String paymentLink,  List<String> accounts)  $default,) {final _that = this;
switch (_that) {
case _GetPaymentOptionsRequest():
return $default(_that.paymentLink,_that.accounts);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String paymentLink,  List<String> accounts)?  $default,) {final _that = this;
switch (_that) {
case _GetPaymentOptionsRequest() when $default != null:
return $default(_that.paymentLink,_that.accounts);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GetPaymentOptionsRequest implements GetPaymentOptionsRequest {
  const _GetPaymentOptionsRequest({required this.paymentLink, required final  List<String> accounts}): _accounts = accounts;
  factory _GetPaymentOptionsRequest.fromJson(Map<String, dynamic> json) => _$GetPaymentOptionsRequestFromJson(json);

@override final  String paymentLink;
 final  List<String> _accounts;
@override List<String> get accounts {
  if (_accounts is EqualUnmodifiableListView) return _accounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_accounts);
}


/// Create a copy of GetPaymentOptionsRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetPaymentOptionsRequestCopyWith<_GetPaymentOptionsRequest> get copyWith => __$GetPaymentOptionsRequestCopyWithImpl<_GetPaymentOptionsRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GetPaymentOptionsRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetPaymentOptionsRequest&&(identical(other.paymentLink, paymentLink) || other.paymentLink == paymentLink)&&const DeepCollectionEquality().equals(other._accounts, _accounts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,paymentLink,const DeepCollectionEquality().hash(_accounts));

@override
String toString() {
  return 'GetPaymentOptionsRequest(paymentLink: $paymentLink, accounts: $accounts)';
}


}

/// @nodoc
abstract mixin class _$GetPaymentOptionsRequestCopyWith<$Res> implements $GetPaymentOptionsRequestCopyWith<$Res> {
  factory _$GetPaymentOptionsRequestCopyWith(_GetPaymentOptionsRequest value, $Res Function(_GetPaymentOptionsRequest) _then) = __$GetPaymentOptionsRequestCopyWithImpl;
@override @useResult
$Res call({
 String paymentLink, List<String> accounts
});




}
/// @nodoc
class __$GetPaymentOptionsRequestCopyWithImpl<$Res>
    implements _$GetPaymentOptionsRequestCopyWith<$Res> {
  __$GetPaymentOptionsRequestCopyWithImpl(this._self, this._then);

  final _GetPaymentOptionsRequest _self;
  final $Res Function(_GetPaymentOptionsRequest) _then;

/// Create a copy of GetPaymentOptionsRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? paymentLink = null,Object? accounts = null,}) {
  return _then(_GetPaymentOptionsRequest(
paymentLink: null == paymentLink ? _self.paymentLink : paymentLink // ignore: cast_nullable_to_non_nullable
as String,accounts: null == accounts ? _self._accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$PaymentOptionsResponse {

 List<PaymentOption> get options;
/// Create a copy of PaymentOptionsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentOptionsResponseCopyWith<PaymentOptionsResponse> get copyWith => _$PaymentOptionsResponseCopyWithImpl<PaymentOptionsResponse>(this as PaymentOptionsResponse, _$identity);

  /// Serializes this PaymentOptionsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentOptionsResponse&&const DeepCollectionEquality().equals(other.options, options));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(options));

@override
String toString() {
  return 'PaymentOptionsResponse(options: $options)';
}


}

/// @nodoc
abstract mixin class $PaymentOptionsResponseCopyWith<$Res>  {
  factory $PaymentOptionsResponseCopyWith(PaymentOptionsResponse value, $Res Function(PaymentOptionsResponse) _then) = _$PaymentOptionsResponseCopyWithImpl;
@useResult
$Res call({
 List<PaymentOption> options
});




}
/// @nodoc
class _$PaymentOptionsResponseCopyWithImpl<$Res>
    implements $PaymentOptionsResponseCopyWith<$Res> {
  _$PaymentOptionsResponseCopyWithImpl(this._self, this._then);

  final PaymentOptionsResponse _self;
  final $Res Function(PaymentOptionsResponse) _then;

/// Create a copy of PaymentOptionsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? options = null,}) {
  return _then(_self.copyWith(
options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<PaymentOption>,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentOptionsResponse].
extension PaymentOptionsResponsePatterns on PaymentOptionsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentOptionsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentOptionsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentOptionsResponse value)  $default,){
final _that = this;
switch (_that) {
case _PaymentOptionsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentOptionsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentOptionsResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<PaymentOption> options)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentOptionsResponse() when $default != null:
return $default(_that.options);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<PaymentOption> options)  $default,) {final _that = this;
switch (_that) {
case _PaymentOptionsResponse():
return $default(_that.options);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<PaymentOption> options)?  $default,) {final _that = this;
switch (_that) {
case _PaymentOptionsResponse() when $default != null:
return $default(_that.options);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentOptionsResponse implements PaymentOptionsResponse {
  const _PaymentOptionsResponse({required final  List<PaymentOption> options}): _options = options;
  factory _PaymentOptionsResponse.fromJson(Map<String, dynamic> json) => _$PaymentOptionsResponseFromJson(json);

 final  List<PaymentOption> _options;
@override List<PaymentOption> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}


/// Create a copy of PaymentOptionsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentOptionsResponseCopyWith<_PaymentOptionsResponse> get copyWith => __$PaymentOptionsResponseCopyWithImpl<_PaymentOptionsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentOptionsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentOptionsResponse&&const DeepCollectionEquality().equals(other._options, _options));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_options));

@override
String toString() {
  return 'PaymentOptionsResponse(options: $options)';
}


}

/// @nodoc
abstract mixin class _$PaymentOptionsResponseCopyWith<$Res> implements $PaymentOptionsResponseCopyWith<$Res> {
  factory _$PaymentOptionsResponseCopyWith(_PaymentOptionsResponse value, $Res Function(_PaymentOptionsResponse) _then) = __$PaymentOptionsResponseCopyWithImpl;
@override @useResult
$Res call({
 List<PaymentOption> options
});




}
/// @nodoc
class __$PaymentOptionsResponseCopyWithImpl<$Res>
    implements _$PaymentOptionsResponseCopyWith<$Res> {
  __$PaymentOptionsResponseCopyWithImpl(this._self, this._then);

  final _PaymentOptionsResponse _self;
  final $Res Function(_PaymentOptionsResponse) _then;

/// Create a copy of PaymentOptionsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? options = null,}) {
  return _then(_PaymentOptionsResponse(
options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<PaymentOption>,
  ));
}


}


/// @nodoc
mixin _$PaymentOption {

 String get id; PayAmount get amount; int get etaSeconds; List<RequiredAction> get requiredActions;
/// Create a copy of PaymentOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentOptionCopyWith<PaymentOption> get copyWith => _$PaymentOptionCopyWithImpl<PaymentOption>(this as PaymentOption, _$identity);

  /// Serializes this PaymentOption to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentOption&&(identical(other.id, id) || other.id == id)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.etaSeconds, etaSeconds) || other.etaSeconds == etaSeconds)&&const DeepCollectionEquality().equals(other.requiredActions, requiredActions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,amount,etaSeconds,const DeepCollectionEquality().hash(requiredActions));

@override
String toString() {
  return 'PaymentOption(id: $id, amount: $amount, etaSeconds: $etaSeconds, requiredActions: $requiredActions)';
}


}

/// @nodoc
abstract mixin class $PaymentOptionCopyWith<$Res>  {
  factory $PaymentOptionCopyWith(PaymentOption value, $Res Function(PaymentOption) _then) = _$PaymentOptionCopyWithImpl;
@useResult
$Res call({
 String id, PayAmount amount, int etaSeconds, List<RequiredAction> requiredActions
});


$PayAmountCopyWith<$Res> get amount;

}
/// @nodoc
class _$PaymentOptionCopyWithImpl<$Res>
    implements $PaymentOptionCopyWith<$Res> {
  _$PaymentOptionCopyWithImpl(this._self, this._then);

  final PaymentOption _self;
  final $Res Function(PaymentOption) _then;

/// Create a copy of PaymentOption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? amount = null,Object? etaSeconds = null,Object? requiredActions = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as PayAmount,etaSeconds: null == etaSeconds ? _self.etaSeconds : etaSeconds // ignore: cast_nullable_to_non_nullable
as int,requiredActions: null == requiredActions ? _self.requiredActions : requiredActions // ignore: cast_nullable_to_non_nullable
as List<RequiredAction>,
  ));
}
/// Create a copy of PaymentOption
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PayAmountCopyWith<$Res> get amount {
  
  return $PayAmountCopyWith<$Res>(_self.amount, (value) {
    return _then(_self.copyWith(amount: value));
  });
}
}


/// Adds pattern-matching-related methods to [PaymentOption].
extension PaymentOptionPatterns on PaymentOption {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentOption value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentOption() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentOption value)  $default,){
final _that = this;
switch (_that) {
case _PaymentOption():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentOption value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentOption() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  PayAmount amount,  int etaSeconds,  List<RequiredAction> requiredActions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentOption() when $default != null:
return $default(_that.id,_that.amount,_that.etaSeconds,_that.requiredActions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  PayAmount amount,  int etaSeconds,  List<RequiredAction> requiredActions)  $default,) {final _that = this;
switch (_that) {
case _PaymentOption():
return $default(_that.id,_that.amount,_that.etaSeconds,_that.requiredActions);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  PayAmount amount,  int etaSeconds,  List<RequiredAction> requiredActions)?  $default,) {final _that = this;
switch (_that) {
case _PaymentOption() when $default != null:
return $default(_that.id,_that.amount,_that.etaSeconds,_that.requiredActions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentOption implements PaymentOption {
  const _PaymentOption({required this.id, required this.amount, required this.etaSeconds, required final  List<RequiredAction> requiredActions}): _requiredActions = requiredActions;
  factory _PaymentOption.fromJson(Map<String, dynamic> json) => _$PaymentOptionFromJson(json);

@override final  String id;
@override final  PayAmount amount;
@override final  int etaSeconds;
 final  List<RequiredAction> _requiredActions;
@override List<RequiredAction> get requiredActions {
  if (_requiredActions is EqualUnmodifiableListView) return _requiredActions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_requiredActions);
}


/// Create a copy of PaymentOption
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentOptionCopyWith<_PaymentOption> get copyWith => __$PaymentOptionCopyWithImpl<_PaymentOption>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentOptionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentOption&&(identical(other.id, id) || other.id == id)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.etaSeconds, etaSeconds) || other.etaSeconds == etaSeconds)&&const DeepCollectionEquality().equals(other._requiredActions, _requiredActions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,amount,etaSeconds,const DeepCollectionEquality().hash(_requiredActions));

@override
String toString() {
  return 'PaymentOption(id: $id, amount: $amount, etaSeconds: $etaSeconds, requiredActions: $requiredActions)';
}


}

/// @nodoc
abstract mixin class _$PaymentOptionCopyWith<$Res> implements $PaymentOptionCopyWith<$Res> {
  factory _$PaymentOptionCopyWith(_PaymentOption value, $Res Function(_PaymentOption) _then) = __$PaymentOptionCopyWithImpl;
@override @useResult
$Res call({
 String id, PayAmount amount, int etaSeconds, List<RequiredAction> requiredActions
});


@override $PayAmountCopyWith<$Res> get amount;

}
/// @nodoc
class __$PaymentOptionCopyWithImpl<$Res>
    implements _$PaymentOptionCopyWith<$Res> {
  __$PaymentOptionCopyWithImpl(this._self, this._then);

  final _PaymentOption _self;
  final $Res Function(_PaymentOption) _then;

/// Create a copy of PaymentOption
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? amount = null,Object? etaSeconds = null,Object? requiredActions = null,}) {
  return _then(_PaymentOption(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as PayAmount,etaSeconds: null == etaSeconds ? _self.etaSeconds : etaSeconds // ignore: cast_nullable_to_non_nullable
as int,requiredActions: null == requiredActions ? _self._requiredActions : requiredActions // ignore: cast_nullable_to_non_nullable
as List<RequiredAction>,
  ));
}

/// Create a copy of PaymentOption
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PayAmountCopyWith<$Res> get amount {
  
  return $PayAmountCopyWith<$Res>(_self.amount, (value) {
    return _then(_self.copyWith(amount: value));
  });
}
}

RequiredAction _$RequiredActionFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'walletRpc':
          return RequiredActionWalletRpc.fromJson(
            json
          );
                case 'build':
          return RequiredActionBuild.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'RequiredAction',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$RequiredAction {

 Object get data;

  /// Serializes this RequiredAction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequiredAction&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'RequiredAction(data: $data)';
}


}

/// @nodoc
class $RequiredActionCopyWith<$Res>  {
$RequiredActionCopyWith(RequiredAction _, $Res Function(RequiredAction) __);
}


/// Adds pattern-matching-related methods to [RequiredAction].
extension RequiredActionPatterns on RequiredAction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( RequiredActionWalletRpc value)?  walletRpc,TResult Function( RequiredActionBuild value)?  build,required TResult orElse(),}){
final _that = this;
switch (_that) {
case RequiredActionWalletRpc() when walletRpc != null:
return walletRpc(_that);case RequiredActionBuild() when build != null:
return build(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( RequiredActionWalletRpc value)  walletRpc,required TResult Function( RequiredActionBuild value)  build,}){
final _that = this;
switch (_that) {
case RequiredActionWalletRpc():
return walletRpc(_that);case RequiredActionBuild():
return build(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( RequiredActionWalletRpc value)?  walletRpc,TResult? Function( RequiredActionBuild value)?  build,}){
final _that = this;
switch (_that) {
case RequiredActionWalletRpc() when walletRpc != null:
return walletRpc(_that);case RequiredActionBuild() when build != null:
return build(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( WalletRpcAction data)?  walletRpc,TResult Function( BuildAction data)?  build,required TResult orElse(),}) {final _that = this;
switch (_that) {
case RequiredActionWalletRpc() when walletRpc != null:
return walletRpc(_that.data);case RequiredActionBuild() when build != null:
return build(_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( WalletRpcAction data)  walletRpc,required TResult Function( BuildAction data)  build,}) {final _that = this;
switch (_that) {
case RequiredActionWalletRpc():
return walletRpc(_that.data);case RequiredActionBuild():
return build(_that.data);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( WalletRpcAction data)?  walletRpc,TResult? Function( BuildAction data)?  build,}) {final _that = this;
switch (_that) {
case RequiredActionWalletRpc() when walletRpc != null:
return walletRpc(_that.data);case RequiredActionBuild() when build != null:
return build(_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class RequiredActionWalletRpc implements RequiredAction {
  const RequiredActionWalletRpc({required this.data, final  String? $type}): $type = $type ?? 'walletRpc';
  factory RequiredActionWalletRpc.fromJson(Map<String, dynamic> json) => _$RequiredActionWalletRpcFromJson(json);

@override final  WalletRpcAction data;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of RequiredAction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RequiredActionWalletRpcCopyWith<RequiredActionWalletRpc> get copyWith => _$RequiredActionWalletRpcCopyWithImpl<RequiredActionWalletRpc>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RequiredActionWalletRpcToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequiredActionWalletRpc&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'RequiredAction.walletRpc(data: $data)';
}


}

/// @nodoc
abstract mixin class $RequiredActionWalletRpcCopyWith<$Res> implements $RequiredActionCopyWith<$Res> {
  factory $RequiredActionWalletRpcCopyWith(RequiredActionWalletRpc value, $Res Function(RequiredActionWalletRpc) _then) = _$RequiredActionWalletRpcCopyWithImpl;
@useResult
$Res call({
 WalletRpcAction data
});


$WalletRpcActionCopyWith<$Res> get data;

}
/// @nodoc
class _$RequiredActionWalletRpcCopyWithImpl<$Res>
    implements $RequiredActionWalletRpcCopyWith<$Res> {
  _$RequiredActionWalletRpcCopyWithImpl(this._self, this._then);

  final RequiredActionWalletRpc _self;
  final $Res Function(RequiredActionWalletRpc) _then;

/// Create a copy of RequiredAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(RequiredActionWalletRpc(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as WalletRpcAction,
  ));
}

/// Create a copy of RequiredAction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WalletRpcActionCopyWith<$Res> get data {
  
  return $WalletRpcActionCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class RequiredActionBuild implements RequiredAction {
  const RequiredActionBuild({required this.data, final  String? $type}): $type = $type ?? 'build';
  factory RequiredActionBuild.fromJson(Map<String, dynamic> json) => _$RequiredActionBuildFromJson(json);

@override final  BuildAction data;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of RequiredAction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RequiredActionBuildCopyWith<RequiredActionBuild> get copyWith => _$RequiredActionBuildCopyWithImpl<RequiredActionBuild>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RequiredActionBuildToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequiredActionBuild&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'RequiredAction.build(data: $data)';
}


}

/// @nodoc
abstract mixin class $RequiredActionBuildCopyWith<$Res> implements $RequiredActionCopyWith<$Res> {
  factory $RequiredActionBuildCopyWith(RequiredActionBuild value, $Res Function(RequiredActionBuild) _then) = _$RequiredActionBuildCopyWithImpl;
@useResult
$Res call({
 BuildAction data
});


$BuildActionCopyWith<$Res> get data;

}
/// @nodoc
class _$RequiredActionBuildCopyWithImpl<$Res>
    implements $RequiredActionBuildCopyWith<$Res> {
  _$RequiredActionBuildCopyWithImpl(this._self, this._then);

  final RequiredActionBuild _self;
  final $Res Function(RequiredActionBuild) _then;

/// Create a copy of RequiredAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(RequiredActionBuild(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as BuildAction,
  ));
}

/// Create a copy of RequiredAction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BuildActionCopyWith<$Res> get data {
  
  return $BuildActionCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$WalletRpcAction {

 String get chainId; String get method; String get params;
/// Create a copy of WalletRpcAction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WalletRpcActionCopyWith<WalletRpcAction> get copyWith => _$WalletRpcActionCopyWithImpl<WalletRpcAction>(this as WalletRpcAction, _$identity);

  /// Serializes this WalletRpcAction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WalletRpcAction&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.method, method) || other.method == method)&&(identical(other.params, params) || other.params == params));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,chainId,method,params);

@override
String toString() {
  return 'WalletRpcAction(chainId: $chainId, method: $method, params: $params)';
}


}

/// @nodoc
abstract mixin class $WalletRpcActionCopyWith<$Res>  {
  factory $WalletRpcActionCopyWith(WalletRpcAction value, $Res Function(WalletRpcAction) _then) = _$WalletRpcActionCopyWithImpl;
@useResult
$Res call({
 String chainId, String method, String params
});




}
/// @nodoc
class _$WalletRpcActionCopyWithImpl<$Res>
    implements $WalletRpcActionCopyWith<$Res> {
  _$WalletRpcActionCopyWithImpl(this._self, this._then);

  final WalletRpcAction _self;
  final $Res Function(WalletRpcAction) _then;

/// Create a copy of WalletRpcAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? chainId = null,Object? method = null,Object? params = null,}) {
  return _then(_self.copyWith(
chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as String,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,params: null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WalletRpcAction].
extension WalletRpcActionPatterns on WalletRpcAction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WalletRpcAction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WalletRpcAction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WalletRpcAction value)  $default,){
final _that = this;
switch (_that) {
case _WalletRpcAction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WalletRpcAction value)?  $default,){
final _that = this;
switch (_that) {
case _WalletRpcAction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String chainId,  String method,  String params)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WalletRpcAction() when $default != null:
return $default(_that.chainId,_that.method,_that.params);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String chainId,  String method,  String params)  $default,) {final _that = this;
switch (_that) {
case _WalletRpcAction():
return $default(_that.chainId,_that.method,_that.params);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String chainId,  String method,  String params)?  $default,) {final _that = this;
switch (_that) {
case _WalletRpcAction() when $default != null:
return $default(_that.chainId,_that.method,_that.params);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WalletRpcAction implements WalletRpcAction {
  const _WalletRpcAction({required this.chainId, required this.method, required this.params});
  factory _WalletRpcAction.fromJson(Map<String, dynamic> json) => _$WalletRpcActionFromJson(json);

@override final  String chainId;
@override final  String method;
@override final  String params;

/// Create a copy of WalletRpcAction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WalletRpcActionCopyWith<_WalletRpcAction> get copyWith => __$WalletRpcActionCopyWithImpl<_WalletRpcAction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WalletRpcActionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WalletRpcAction&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.method, method) || other.method == method)&&(identical(other.params, params) || other.params == params));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,chainId,method,params);

@override
String toString() {
  return 'WalletRpcAction(chainId: $chainId, method: $method, params: $params)';
}


}

/// @nodoc
abstract mixin class _$WalletRpcActionCopyWith<$Res> implements $WalletRpcActionCopyWith<$Res> {
  factory _$WalletRpcActionCopyWith(_WalletRpcAction value, $Res Function(_WalletRpcAction) _then) = __$WalletRpcActionCopyWithImpl;
@override @useResult
$Res call({
 String chainId, String method, String params
});




}
/// @nodoc
class __$WalletRpcActionCopyWithImpl<$Res>
    implements _$WalletRpcActionCopyWith<$Res> {
  __$WalletRpcActionCopyWithImpl(this._self, this._then);

  final _WalletRpcAction _self;
  final $Res Function(_WalletRpcAction) _then;

/// Create a copy of WalletRpcAction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? chainId = null,Object? method = null,Object? params = null,}) {
  return _then(_WalletRpcAction(
chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as String,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,params: null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$BuildAction {

 String get data;
/// Create a copy of BuildAction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BuildActionCopyWith<BuildAction> get copyWith => _$BuildActionCopyWithImpl<BuildAction>(this as BuildAction, _$identity);

  /// Serializes this BuildAction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BuildAction&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'BuildAction(data: $data)';
}


}

/// @nodoc
abstract mixin class $BuildActionCopyWith<$Res>  {
  factory $BuildActionCopyWith(BuildAction value, $Res Function(BuildAction) _then) = _$BuildActionCopyWithImpl;
@useResult
$Res call({
 String data
});




}
/// @nodoc
class _$BuildActionCopyWithImpl<$Res>
    implements $BuildActionCopyWith<$Res> {
  _$BuildActionCopyWithImpl(this._self, this._then);

  final BuildAction _self;
  final $Res Function(BuildAction) _then;

/// Create a copy of BuildAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,}) {
  return _then(_self.copyWith(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BuildAction].
extension BuildActionPatterns on BuildAction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BuildAction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BuildAction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BuildAction value)  $default,){
final _that = this;
switch (_that) {
case _BuildAction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BuildAction value)?  $default,){
final _that = this;
switch (_that) {
case _BuildAction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BuildAction() when $default != null:
return $default(_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String data)  $default,) {final _that = this;
switch (_that) {
case _BuildAction():
return $default(_that.data);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String data)?  $default,) {final _that = this;
switch (_that) {
case _BuildAction() when $default != null:
return $default(_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BuildAction implements BuildAction {
  const _BuildAction({required this.data});
  factory _BuildAction.fromJson(Map<String, dynamic> json) => _$BuildActionFromJson(json);

@override final  String data;

/// Create a copy of BuildAction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BuildActionCopyWith<_BuildAction> get copyWith => __$BuildActionCopyWithImpl<_BuildAction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BuildActionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BuildAction&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'BuildAction(data: $data)';
}


}

/// @nodoc
abstract mixin class _$BuildActionCopyWith<$Res> implements $BuildActionCopyWith<$Res> {
  factory _$BuildActionCopyWith(_BuildAction value, $Res Function(_BuildAction) _then) = __$BuildActionCopyWithImpl;
@override @useResult
$Res call({
 String data
});




}
/// @nodoc
class __$BuildActionCopyWithImpl<$Res>
    implements _$BuildActionCopyWith<$Res> {
  __$BuildActionCopyWithImpl(this._self, this._then);

  final _BuildAction _self;
  final $Res Function(_BuildAction) _then;

/// Create a copy of BuildAction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_BuildAction(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$PayAmount {

 String get unit; String get value; AmountDisplay get display;
/// Create a copy of PayAmount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PayAmountCopyWith<PayAmount> get copyWith => _$PayAmountCopyWithImpl<PayAmount>(this as PayAmount, _$identity);

  /// Serializes this PayAmount to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PayAmount&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.value, value) || other.value == value)&&(identical(other.display, display) || other.display == display));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,unit,value,display);

@override
String toString() {
  return 'PayAmount(unit: $unit, value: $value, display: $display)';
}


}

/// @nodoc
abstract mixin class $PayAmountCopyWith<$Res>  {
  factory $PayAmountCopyWith(PayAmount value, $Res Function(PayAmount) _then) = _$PayAmountCopyWithImpl;
@useResult
$Res call({
 String unit, String value, AmountDisplay display
});


$AmountDisplayCopyWith<$Res> get display;

}
/// @nodoc
class _$PayAmountCopyWithImpl<$Res>
    implements $PayAmountCopyWith<$Res> {
  _$PayAmountCopyWithImpl(this._self, this._then);

  final PayAmount _self;
  final $Res Function(PayAmount) _then;

/// Create a copy of PayAmount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? unit = null,Object? value = null,Object? display = null,}) {
  return _then(_self.copyWith(
unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,display: null == display ? _self.display : display // ignore: cast_nullable_to_non_nullable
as AmountDisplay,
  ));
}
/// Create a copy of PayAmount
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AmountDisplayCopyWith<$Res> get display {
  
  return $AmountDisplayCopyWith<$Res>(_self.display, (value) {
    return _then(_self.copyWith(display: value));
  });
}
}


/// Adds pattern-matching-related methods to [PayAmount].
extension PayAmountPatterns on PayAmount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PayAmount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PayAmount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PayAmount value)  $default,){
final _that = this;
switch (_that) {
case _PayAmount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PayAmount value)?  $default,){
final _that = this;
switch (_that) {
case _PayAmount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String unit,  String value,  AmountDisplay display)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PayAmount() when $default != null:
return $default(_that.unit,_that.value,_that.display);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String unit,  String value,  AmountDisplay display)  $default,) {final _that = this;
switch (_that) {
case _PayAmount():
return $default(_that.unit,_that.value,_that.display);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String unit,  String value,  AmountDisplay display)?  $default,) {final _that = this;
switch (_that) {
case _PayAmount() when $default != null:
return $default(_that.unit,_that.value,_that.display);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PayAmount implements PayAmount {
  const _PayAmount({required this.unit, required this.value, required this.display});
  factory _PayAmount.fromJson(Map<String, dynamic> json) => _$PayAmountFromJson(json);

@override final  String unit;
@override final  String value;
@override final  AmountDisplay display;

/// Create a copy of PayAmount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PayAmountCopyWith<_PayAmount> get copyWith => __$PayAmountCopyWithImpl<_PayAmount>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PayAmountToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PayAmount&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.value, value) || other.value == value)&&(identical(other.display, display) || other.display == display));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,unit,value,display);

@override
String toString() {
  return 'PayAmount(unit: $unit, value: $value, display: $display)';
}


}

/// @nodoc
abstract mixin class _$PayAmountCopyWith<$Res> implements $PayAmountCopyWith<$Res> {
  factory _$PayAmountCopyWith(_PayAmount value, $Res Function(_PayAmount) _then) = __$PayAmountCopyWithImpl;
@override @useResult
$Res call({
 String unit, String value, AmountDisplay display
});


@override $AmountDisplayCopyWith<$Res> get display;

}
/// @nodoc
class __$PayAmountCopyWithImpl<$Res>
    implements _$PayAmountCopyWith<$Res> {
  __$PayAmountCopyWithImpl(this._self, this._then);

  final _PayAmount _self;
  final $Res Function(_PayAmount) _then;

/// Create a copy of PayAmount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? unit = null,Object? value = null,Object? display = null,}) {
  return _then(_PayAmount(
unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,display: null == display ? _self.display : display // ignore: cast_nullable_to_non_nullable
as AmountDisplay,
  ));
}

/// Create a copy of PayAmount
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AmountDisplayCopyWith<$Res> get display {
  
  return $AmountDisplayCopyWith<$Res>(_self.display, (value) {
    return _then(_self.copyWith(display: value));
  });
}
}


/// @nodoc
mixin _$AmountDisplay {

 String get assetSymbol; String get assetName; int get decimals; String? get iconUrl; String? get networkName;
/// Create a copy of AmountDisplay
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AmountDisplayCopyWith<AmountDisplay> get copyWith => _$AmountDisplayCopyWithImpl<AmountDisplay>(this as AmountDisplay, _$identity);

  /// Serializes this AmountDisplay to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AmountDisplay&&(identical(other.assetSymbol, assetSymbol) || other.assetSymbol == assetSymbol)&&(identical(other.assetName, assetName) || other.assetName == assetName)&&(identical(other.decimals, decimals) || other.decimals == decimals)&&(identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl)&&(identical(other.networkName, networkName) || other.networkName == networkName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,assetSymbol,assetName,decimals,iconUrl,networkName);

@override
String toString() {
  return 'AmountDisplay(assetSymbol: $assetSymbol, assetName: $assetName, decimals: $decimals, iconUrl: $iconUrl, networkName: $networkName)';
}


}

/// @nodoc
abstract mixin class $AmountDisplayCopyWith<$Res>  {
  factory $AmountDisplayCopyWith(AmountDisplay value, $Res Function(AmountDisplay) _then) = _$AmountDisplayCopyWithImpl;
@useResult
$Res call({
 String assetSymbol, String assetName, int decimals, String? iconUrl, String? networkName
});




}
/// @nodoc
class _$AmountDisplayCopyWithImpl<$Res>
    implements $AmountDisplayCopyWith<$Res> {
  _$AmountDisplayCopyWithImpl(this._self, this._then);

  final AmountDisplay _self;
  final $Res Function(AmountDisplay) _then;

/// Create a copy of AmountDisplay
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? assetSymbol = null,Object? assetName = null,Object? decimals = null,Object? iconUrl = freezed,Object? networkName = freezed,}) {
  return _then(_self.copyWith(
assetSymbol: null == assetSymbol ? _self.assetSymbol : assetSymbol // ignore: cast_nullable_to_non_nullable
as String,assetName: null == assetName ? _self.assetName : assetName // ignore: cast_nullable_to_non_nullable
as String,decimals: null == decimals ? _self.decimals : decimals // ignore: cast_nullable_to_non_nullable
as int,iconUrl: freezed == iconUrl ? _self.iconUrl : iconUrl // ignore: cast_nullable_to_non_nullable
as String?,networkName: freezed == networkName ? _self.networkName : networkName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AmountDisplay].
extension AmountDisplayPatterns on AmountDisplay {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AmountDisplay value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AmountDisplay() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AmountDisplay value)  $default,){
final _that = this;
switch (_that) {
case _AmountDisplay():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AmountDisplay value)?  $default,){
final _that = this;
switch (_that) {
case _AmountDisplay() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String assetSymbol,  String assetName,  int decimals,  String? iconUrl,  String? networkName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AmountDisplay() when $default != null:
return $default(_that.assetSymbol,_that.assetName,_that.decimals,_that.iconUrl,_that.networkName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String assetSymbol,  String assetName,  int decimals,  String? iconUrl,  String? networkName)  $default,) {final _that = this;
switch (_that) {
case _AmountDisplay():
return $default(_that.assetSymbol,_that.assetName,_that.decimals,_that.iconUrl,_that.networkName);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String assetSymbol,  String assetName,  int decimals,  String? iconUrl,  String? networkName)?  $default,) {final _that = this;
switch (_that) {
case _AmountDisplay() when $default != null:
return $default(_that.assetSymbol,_that.assetName,_that.decimals,_that.iconUrl,_that.networkName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AmountDisplay implements AmountDisplay {
  const _AmountDisplay({required this.assetSymbol, required this.assetName, required this.decimals, this.iconUrl, this.networkName});
  factory _AmountDisplay.fromJson(Map<String, dynamic> json) => _$AmountDisplayFromJson(json);

@override final  String assetSymbol;
@override final  String assetName;
@override final  int decimals;
@override final  String? iconUrl;
@override final  String? networkName;

/// Create a copy of AmountDisplay
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AmountDisplayCopyWith<_AmountDisplay> get copyWith => __$AmountDisplayCopyWithImpl<_AmountDisplay>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AmountDisplayToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AmountDisplay&&(identical(other.assetSymbol, assetSymbol) || other.assetSymbol == assetSymbol)&&(identical(other.assetName, assetName) || other.assetName == assetName)&&(identical(other.decimals, decimals) || other.decimals == decimals)&&(identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl)&&(identical(other.networkName, networkName) || other.networkName == networkName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,assetSymbol,assetName,decimals,iconUrl,networkName);

@override
String toString() {
  return 'AmountDisplay(assetSymbol: $assetSymbol, assetName: $assetName, decimals: $decimals, iconUrl: $iconUrl, networkName: $networkName)';
}


}

/// @nodoc
abstract mixin class _$AmountDisplayCopyWith<$Res> implements $AmountDisplayCopyWith<$Res> {
  factory _$AmountDisplayCopyWith(_AmountDisplay value, $Res Function(_AmountDisplay) _then) = __$AmountDisplayCopyWithImpl;
@override @useResult
$Res call({
 String assetSymbol, String assetName, int decimals, String? iconUrl, String? networkName
});




}
/// @nodoc
class __$AmountDisplayCopyWithImpl<$Res>
    implements _$AmountDisplayCopyWith<$Res> {
  __$AmountDisplayCopyWithImpl(this._self, this._then);

  final _AmountDisplay _self;
  final $Res Function(_AmountDisplay) _then;

/// Create a copy of AmountDisplay
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? assetSymbol = null,Object? assetName = null,Object? decimals = null,Object? iconUrl = freezed,Object? networkName = freezed,}) {
  return _then(_AmountDisplay(
assetSymbol: null == assetSymbol ? _self.assetSymbol : assetSymbol // ignore: cast_nullable_to_non_nullable
as String,assetName: null == assetName ? _self.assetName : assetName // ignore: cast_nullable_to_non_nullable
as String,decimals: null == decimals ? _self.decimals : decimals // ignore: cast_nullable_to_non_nullable
as int,iconUrl: freezed == iconUrl ? _self.iconUrl : iconUrl // ignore: cast_nullable_to_non_nullable
as String?,networkName: freezed == networkName ? _self.networkName : networkName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$GetRequiredPaymentActionsRequest {

 String get optionId; String get paymentId;
/// Create a copy of GetRequiredPaymentActionsRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetRequiredPaymentActionsRequestCopyWith<GetRequiredPaymentActionsRequest> get copyWith => _$GetRequiredPaymentActionsRequestCopyWithImpl<GetRequiredPaymentActionsRequest>(this as GetRequiredPaymentActionsRequest, _$identity);

  /// Serializes this GetRequiredPaymentActionsRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetRequiredPaymentActionsRequest&&(identical(other.optionId, optionId) || other.optionId == optionId)&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,optionId,paymentId);

@override
String toString() {
  return 'GetRequiredPaymentActionsRequest(optionId: $optionId, paymentId: $paymentId)';
}


}

/// @nodoc
abstract mixin class $GetRequiredPaymentActionsRequestCopyWith<$Res>  {
  factory $GetRequiredPaymentActionsRequestCopyWith(GetRequiredPaymentActionsRequest value, $Res Function(GetRequiredPaymentActionsRequest) _then) = _$GetRequiredPaymentActionsRequestCopyWithImpl;
@useResult
$Res call({
 String optionId, String paymentId
});




}
/// @nodoc
class _$GetRequiredPaymentActionsRequestCopyWithImpl<$Res>
    implements $GetRequiredPaymentActionsRequestCopyWith<$Res> {
  _$GetRequiredPaymentActionsRequestCopyWithImpl(this._self, this._then);

  final GetRequiredPaymentActionsRequest _self;
  final $Res Function(GetRequiredPaymentActionsRequest) _then;

/// Create a copy of GetRequiredPaymentActionsRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? optionId = null,Object? paymentId = null,}) {
  return _then(_self.copyWith(
optionId: null == optionId ? _self.optionId : optionId // ignore: cast_nullable_to_non_nullable
as String,paymentId: null == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GetRequiredPaymentActionsRequest].
extension GetRequiredPaymentActionsRequestPatterns on GetRequiredPaymentActionsRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetRequiredPaymentActionsRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetRequiredPaymentActionsRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetRequiredPaymentActionsRequest value)  $default,){
final _that = this;
switch (_that) {
case _GetRequiredPaymentActionsRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetRequiredPaymentActionsRequest value)?  $default,){
final _that = this;
switch (_that) {
case _GetRequiredPaymentActionsRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String optionId,  String paymentId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetRequiredPaymentActionsRequest() when $default != null:
return $default(_that.optionId,_that.paymentId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String optionId,  String paymentId)  $default,) {final _that = this;
switch (_that) {
case _GetRequiredPaymentActionsRequest():
return $default(_that.optionId,_that.paymentId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String optionId,  String paymentId)?  $default,) {final _that = this;
switch (_that) {
case _GetRequiredPaymentActionsRequest() when $default != null:
return $default(_that.optionId,_that.paymentId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GetRequiredPaymentActionsRequest implements GetRequiredPaymentActionsRequest {
  const _GetRequiredPaymentActionsRequest({required this.optionId, required this.paymentId});
  factory _GetRequiredPaymentActionsRequest.fromJson(Map<String, dynamic> json) => _$GetRequiredPaymentActionsRequestFromJson(json);

@override final  String optionId;
@override final  String paymentId;

/// Create a copy of GetRequiredPaymentActionsRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetRequiredPaymentActionsRequestCopyWith<_GetRequiredPaymentActionsRequest> get copyWith => __$GetRequiredPaymentActionsRequestCopyWithImpl<_GetRequiredPaymentActionsRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GetRequiredPaymentActionsRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetRequiredPaymentActionsRequest&&(identical(other.optionId, optionId) || other.optionId == optionId)&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,optionId,paymentId);

@override
String toString() {
  return 'GetRequiredPaymentActionsRequest(optionId: $optionId, paymentId: $paymentId)';
}


}

/// @nodoc
abstract mixin class _$GetRequiredPaymentActionsRequestCopyWith<$Res> implements $GetRequiredPaymentActionsRequestCopyWith<$Res> {
  factory _$GetRequiredPaymentActionsRequestCopyWith(_GetRequiredPaymentActionsRequest value, $Res Function(_GetRequiredPaymentActionsRequest) _then) = __$GetRequiredPaymentActionsRequestCopyWithImpl;
@override @useResult
$Res call({
 String optionId, String paymentId
});




}
/// @nodoc
class __$GetRequiredPaymentActionsRequestCopyWithImpl<$Res>
    implements _$GetRequiredPaymentActionsRequestCopyWith<$Res> {
  __$GetRequiredPaymentActionsRequestCopyWithImpl(this._self, this._then);

  final _GetRequiredPaymentActionsRequest _self;
  final $Res Function(_GetRequiredPaymentActionsRequest) _then;

/// Create a copy of GetRequiredPaymentActionsRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? optionId = null,Object? paymentId = null,}) {
  return _then(_GetRequiredPaymentActionsRequest(
optionId: null == optionId ? _self.optionId : optionId // ignore: cast_nullable_to_non_nullable
as String,paymentId: null == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ConfirmPaymentJsonRequest {

 String get paymentId; String get optionId; List<SignatureResult> get results; int? get maxPollMs;
/// Create a copy of ConfirmPaymentJsonRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConfirmPaymentJsonRequestCopyWith<ConfirmPaymentJsonRequest> get copyWith => _$ConfirmPaymentJsonRequestCopyWithImpl<ConfirmPaymentJsonRequest>(this as ConfirmPaymentJsonRequest, _$identity);

  /// Serializes this ConfirmPaymentJsonRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConfirmPaymentJsonRequest&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId)&&(identical(other.optionId, optionId) || other.optionId == optionId)&&const DeepCollectionEquality().equals(other.results, results)&&(identical(other.maxPollMs, maxPollMs) || other.maxPollMs == maxPollMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,paymentId,optionId,const DeepCollectionEquality().hash(results),maxPollMs);

@override
String toString() {
  return 'ConfirmPaymentJsonRequest(paymentId: $paymentId, optionId: $optionId, results: $results, maxPollMs: $maxPollMs)';
}


}

/// @nodoc
abstract mixin class $ConfirmPaymentJsonRequestCopyWith<$Res>  {
  factory $ConfirmPaymentJsonRequestCopyWith(ConfirmPaymentJsonRequest value, $Res Function(ConfirmPaymentJsonRequest) _then) = _$ConfirmPaymentJsonRequestCopyWithImpl;
@useResult
$Res call({
 String paymentId, String optionId, List<SignatureResult> results, int? maxPollMs
});




}
/// @nodoc
class _$ConfirmPaymentJsonRequestCopyWithImpl<$Res>
    implements $ConfirmPaymentJsonRequestCopyWith<$Res> {
  _$ConfirmPaymentJsonRequestCopyWithImpl(this._self, this._then);

  final ConfirmPaymentJsonRequest _self;
  final $Res Function(ConfirmPaymentJsonRequest) _then;

/// Create a copy of ConfirmPaymentJsonRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? paymentId = null,Object? optionId = null,Object? results = null,Object? maxPollMs = freezed,}) {
  return _then(_self.copyWith(
paymentId: null == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as String,optionId: null == optionId ? _self.optionId : optionId // ignore: cast_nullable_to_non_nullable
as String,results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<SignatureResult>,maxPollMs: freezed == maxPollMs ? _self.maxPollMs : maxPollMs // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ConfirmPaymentJsonRequest].
extension ConfirmPaymentJsonRequestPatterns on ConfirmPaymentJsonRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConfirmPaymentJsonRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConfirmPaymentJsonRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConfirmPaymentJsonRequest value)  $default,){
final _that = this;
switch (_that) {
case _ConfirmPaymentJsonRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConfirmPaymentJsonRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ConfirmPaymentJsonRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String paymentId,  String optionId,  List<SignatureResult> results,  int? maxPollMs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConfirmPaymentJsonRequest() when $default != null:
return $default(_that.paymentId,_that.optionId,_that.results,_that.maxPollMs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String paymentId,  String optionId,  List<SignatureResult> results,  int? maxPollMs)  $default,) {final _that = this;
switch (_that) {
case _ConfirmPaymentJsonRequest():
return $default(_that.paymentId,_that.optionId,_that.results,_that.maxPollMs);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String paymentId,  String optionId,  List<SignatureResult> results,  int? maxPollMs)?  $default,) {final _that = this;
switch (_that) {
case _ConfirmPaymentJsonRequest() when $default != null:
return $default(_that.paymentId,_that.optionId,_that.results,_that.maxPollMs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConfirmPaymentJsonRequest implements ConfirmPaymentJsonRequest {
  const _ConfirmPaymentJsonRequest({required this.paymentId, required this.optionId, required final  List<SignatureResult> results, this.maxPollMs}): _results = results;
  factory _ConfirmPaymentJsonRequest.fromJson(Map<String, dynamic> json) => _$ConfirmPaymentJsonRequestFromJson(json);

@override final  String paymentId;
@override final  String optionId;
 final  List<SignatureResult> _results;
@override List<SignatureResult> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}

@override final  int? maxPollMs;

/// Create a copy of ConfirmPaymentJsonRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConfirmPaymentJsonRequestCopyWith<_ConfirmPaymentJsonRequest> get copyWith => __$ConfirmPaymentJsonRequestCopyWithImpl<_ConfirmPaymentJsonRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConfirmPaymentJsonRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConfirmPaymentJsonRequest&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId)&&(identical(other.optionId, optionId) || other.optionId == optionId)&&const DeepCollectionEquality().equals(other._results, _results)&&(identical(other.maxPollMs, maxPollMs) || other.maxPollMs == maxPollMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,paymentId,optionId,const DeepCollectionEquality().hash(_results),maxPollMs);

@override
String toString() {
  return 'ConfirmPaymentJsonRequest(paymentId: $paymentId, optionId: $optionId, results: $results, maxPollMs: $maxPollMs)';
}


}

/// @nodoc
abstract mixin class _$ConfirmPaymentJsonRequestCopyWith<$Res> implements $ConfirmPaymentJsonRequestCopyWith<$Res> {
  factory _$ConfirmPaymentJsonRequestCopyWith(_ConfirmPaymentJsonRequest value, $Res Function(_ConfirmPaymentJsonRequest) _then) = __$ConfirmPaymentJsonRequestCopyWithImpl;
@override @useResult
$Res call({
 String paymentId, String optionId, List<SignatureResult> results, int? maxPollMs
});




}
/// @nodoc
class __$ConfirmPaymentJsonRequestCopyWithImpl<$Res>
    implements _$ConfirmPaymentJsonRequestCopyWith<$Res> {
  __$ConfirmPaymentJsonRequestCopyWithImpl(this._self, this._then);

  final _ConfirmPaymentJsonRequest _self;
  final $Res Function(_ConfirmPaymentJsonRequest) _then;

/// Create a copy of ConfirmPaymentJsonRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? paymentId = null,Object? optionId = null,Object? results = null,Object? maxPollMs = freezed,}) {
  return _then(_ConfirmPaymentJsonRequest(
paymentId: null == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as String,optionId: null == optionId ? _self.optionId : optionId // ignore: cast_nullable_to_non_nullable
as String,results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<SignatureResult>,maxPollMs: freezed == maxPollMs ? _self.maxPollMs : maxPollMs // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$SignatureResult {

 SignatureValue get signature;
/// Create a copy of SignatureResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignatureResultCopyWith<SignatureResult> get copyWith => _$SignatureResultCopyWithImpl<SignatureResult>(this as SignatureResult, _$identity);

  /// Serializes this SignatureResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignatureResult&&(identical(other.signature, signature) || other.signature == signature));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,signature);

@override
String toString() {
  return 'SignatureResult(signature: $signature)';
}


}

/// @nodoc
abstract mixin class $SignatureResultCopyWith<$Res>  {
  factory $SignatureResultCopyWith(SignatureResult value, $Res Function(SignatureResult) _then) = _$SignatureResultCopyWithImpl;
@useResult
$Res call({
 SignatureValue signature
});


$SignatureValueCopyWith<$Res> get signature;

}
/// @nodoc
class _$SignatureResultCopyWithImpl<$Res>
    implements $SignatureResultCopyWith<$Res> {
  _$SignatureResultCopyWithImpl(this._self, this._then);

  final SignatureResult _self;
  final $Res Function(SignatureResult) _then;

/// Create a copy of SignatureResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? signature = null,}) {
  return _then(_self.copyWith(
signature: null == signature ? _self.signature : signature // ignore: cast_nullable_to_non_nullable
as SignatureValue,
  ));
}
/// Create a copy of SignatureResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SignatureValueCopyWith<$Res> get signature {
  
  return $SignatureValueCopyWith<$Res>(_self.signature, (value) {
    return _then(_self.copyWith(signature: value));
  });
}
}


/// Adds pattern-matching-related methods to [SignatureResult].
extension SignatureResultPatterns on SignatureResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignatureResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignatureResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignatureResult value)  $default,){
final _that = this;
switch (_that) {
case _SignatureResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignatureResult value)?  $default,){
final _that = this;
switch (_that) {
case _SignatureResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SignatureValue signature)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignatureResult() when $default != null:
return $default(_that.signature);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SignatureValue signature)  $default,) {final _that = this;
switch (_that) {
case _SignatureResult():
return $default(_that.signature);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SignatureValue signature)?  $default,) {final _that = this;
switch (_that) {
case _SignatureResult() when $default != null:
return $default(_that.signature);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SignatureResult implements SignatureResult {
  const _SignatureResult({required this.signature});
  factory _SignatureResult.fromJson(Map<String, dynamic> json) => _$SignatureResultFromJson(json);

@override final  SignatureValue signature;

/// Create a copy of SignatureResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignatureResultCopyWith<_SignatureResult> get copyWith => __$SignatureResultCopyWithImpl<_SignatureResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SignatureResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignatureResult&&(identical(other.signature, signature) || other.signature == signature));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,signature);

@override
String toString() {
  return 'SignatureResult(signature: $signature)';
}


}

/// @nodoc
abstract mixin class _$SignatureResultCopyWith<$Res> implements $SignatureResultCopyWith<$Res> {
  factory _$SignatureResultCopyWith(_SignatureResult value, $Res Function(_SignatureResult) _then) = __$SignatureResultCopyWithImpl;
@override @useResult
$Res call({
 SignatureValue signature
});


@override $SignatureValueCopyWith<$Res> get signature;

}
/// @nodoc
class __$SignatureResultCopyWithImpl<$Res>
    implements _$SignatureResultCopyWith<$Res> {
  __$SignatureResultCopyWithImpl(this._self, this._then);

  final _SignatureResult _self;
  final $Res Function(_SignatureResult) _then;

/// Create a copy of SignatureResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? signature = null,}) {
  return _then(_SignatureResult(
signature: null == signature ? _self.signature : signature // ignore: cast_nullable_to_non_nullable
as SignatureValue,
  ));
}

/// Create a copy of SignatureResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SignatureValueCopyWith<$Res> get signature {
  
  return $SignatureValueCopyWith<$Res>(_self.signature, (value) {
    return _then(_self.copyWith(signature: value));
  });
}
}


/// @nodoc
mixin _$SignatureValue {

 String get value;
/// Create a copy of SignatureValue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignatureValueCopyWith<SignatureValue> get copyWith => _$SignatureValueCopyWithImpl<SignatureValue>(this as SignatureValue, _$identity);

  /// Serializes this SignatureValue to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignatureValue&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'SignatureValue(value: $value)';
}


}

/// @nodoc
abstract mixin class $SignatureValueCopyWith<$Res>  {
  factory $SignatureValueCopyWith(SignatureValue value, $Res Function(SignatureValue) _then) = _$SignatureValueCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class _$SignatureValueCopyWithImpl<$Res>
    implements $SignatureValueCopyWith<$Res> {
  _$SignatureValueCopyWithImpl(this._self, this._then);

  final SignatureValue _self;
  final $Res Function(SignatureValue) _then;

/// Create a copy of SignatureValue
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SignatureValue].
extension SignatureValuePatterns on SignatureValue {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignatureValue value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignatureValue() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignatureValue value)  $default,){
final _that = this;
switch (_that) {
case _SignatureValue():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignatureValue value)?  $default,){
final _that = this;
switch (_that) {
case _SignatureValue() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignatureValue() when $default != null:
return $default(_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String value)  $default,) {final _that = this;
switch (_that) {
case _SignatureValue():
return $default(_that.value);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String value)?  $default,) {final _that = this;
switch (_that) {
case _SignatureValue() when $default != null:
return $default(_that.value);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SignatureValue implements SignatureValue {
  const _SignatureValue({required this.value});
  factory _SignatureValue.fromJson(Map<String, dynamic> json) => _$SignatureValueFromJson(json);

@override final  String value;

/// Create a copy of SignatureValue
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignatureValueCopyWith<_SignatureValue> get copyWith => __$SignatureValueCopyWithImpl<_SignatureValue>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SignatureValueToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignatureValue&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value);

@override
String toString() {
  return 'SignatureValue(value: $value)';
}


}

/// @nodoc
abstract mixin class _$SignatureValueCopyWith<$Res> implements $SignatureValueCopyWith<$Res> {
  factory _$SignatureValueCopyWith(_SignatureValue value, $Res Function(_SignatureValue) _then) = __$SignatureValueCopyWithImpl;
@override @useResult
$Res call({
 String value
});




}
/// @nodoc
class __$SignatureValueCopyWithImpl<$Res>
    implements _$SignatureValueCopyWith<$Res> {
  __$SignatureValueCopyWithImpl(this._self, this._then);

  final _SignatureValue _self;
  final $Res Function(_SignatureValue) _then;

/// Create a copy of SignatureValue
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_SignatureValue(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ConfirmPaymentResponse {

 PaymentStatus get status; bool get isFinal; int? get pollInMs;
/// Create a copy of ConfirmPaymentResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConfirmPaymentResponseCopyWith<ConfirmPaymentResponse> get copyWith => _$ConfirmPaymentResponseCopyWithImpl<ConfirmPaymentResponse>(this as ConfirmPaymentResponse, _$identity);

  /// Serializes this ConfirmPaymentResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConfirmPaymentResponse&&(identical(other.status, status) || other.status == status)&&(identical(other.isFinal, isFinal) || other.isFinal == isFinal)&&(identical(other.pollInMs, pollInMs) || other.pollInMs == pollInMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,isFinal,pollInMs);

@override
String toString() {
  return 'ConfirmPaymentResponse(status: $status, isFinal: $isFinal, pollInMs: $pollInMs)';
}


}

/// @nodoc
abstract mixin class $ConfirmPaymentResponseCopyWith<$Res>  {
  factory $ConfirmPaymentResponseCopyWith(ConfirmPaymentResponse value, $Res Function(ConfirmPaymentResponse) _then) = _$ConfirmPaymentResponseCopyWithImpl;
@useResult
$Res call({
 PaymentStatus status, bool isFinal, int? pollInMs
});




}
/// @nodoc
class _$ConfirmPaymentResponseCopyWithImpl<$Res>
    implements $ConfirmPaymentResponseCopyWith<$Res> {
  _$ConfirmPaymentResponseCopyWithImpl(this._self, this._then);

  final ConfirmPaymentResponse _self;
  final $Res Function(ConfirmPaymentResponse) _then;

/// Create a copy of ConfirmPaymentResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? isFinal = null,Object? pollInMs = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PaymentStatus,isFinal: null == isFinal ? _self.isFinal : isFinal // ignore: cast_nullable_to_non_nullable
as bool,pollInMs: freezed == pollInMs ? _self.pollInMs : pollInMs // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ConfirmPaymentResponse].
extension ConfirmPaymentResponsePatterns on ConfirmPaymentResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConfirmPaymentResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConfirmPaymentResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConfirmPaymentResponse value)  $default,){
final _that = this;
switch (_that) {
case _ConfirmPaymentResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConfirmPaymentResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ConfirmPaymentResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PaymentStatus status,  bool isFinal,  int? pollInMs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConfirmPaymentResponse() when $default != null:
return $default(_that.status,_that.isFinal,_that.pollInMs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PaymentStatus status,  bool isFinal,  int? pollInMs)  $default,) {final _that = this;
switch (_that) {
case _ConfirmPaymentResponse():
return $default(_that.status,_that.isFinal,_that.pollInMs);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PaymentStatus status,  bool isFinal,  int? pollInMs)?  $default,) {final _that = this;
switch (_that) {
case _ConfirmPaymentResponse() when $default != null:
return $default(_that.status,_that.isFinal,_that.pollInMs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConfirmPaymentResponse implements ConfirmPaymentResponse {
  const _ConfirmPaymentResponse({required this.status, required this.isFinal, this.pollInMs});
  factory _ConfirmPaymentResponse.fromJson(Map<String, dynamic> json) => _$ConfirmPaymentResponseFromJson(json);

@override final  PaymentStatus status;
@override final  bool isFinal;
@override final  int? pollInMs;

/// Create a copy of ConfirmPaymentResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConfirmPaymentResponseCopyWith<_ConfirmPaymentResponse> get copyWith => __$ConfirmPaymentResponseCopyWithImpl<_ConfirmPaymentResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConfirmPaymentResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConfirmPaymentResponse&&(identical(other.status, status) || other.status == status)&&(identical(other.isFinal, isFinal) || other.isFinal == isFinal)&&(identical(other.pollInMs, pollInMs) || other.pollInMs == pollInMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,isFinal,pollInMs);

@override
String toString() {
  return 'ConfirmPaymentResponse(status: $status, isFinal: $isFinal, pollInMs: $pollInMs)';
}


}

/// @nodoc
abstract mixin class _$ConfirmPaymentResponseCopyWith<$Res> implements $ConfirmPaymentResponseCopyWith<$Res> {
  factory _$ConfirmPaymentResponseCopyWith(_ConfirmPaymentResponse value, $Res Function(_ConfirmPaymentResponse) _then) = __$ConfirmPaymentResponseCopyWithImpl;
@override @useResult
$Res call({
 PaymentStatus status, bool isFinal, int? pollInMs
});




}
/// @nodoc
class __$ConfirmPaymentResponseCopyWithImpl<$Res>
    implements _$ConfirmPaymentResponseCopyWith<$Res> {
  __$ConfirmPaymentResponseCopyWithImpl(this._self, this._then);

  final _ConfirmPaymentResponse _self;
  final $Res Function(_ConfirmPaymentResponse) _then;

/// Create a copy of ConfirmPaymentResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? isFinal = null,Object? pollInMs = freezed,}) {
  return _then(_ConfirmPaymentResponse(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PaymentStatus,isFinal: null == isFinal ? _self.isFinal : isFinal // ignore: cast_nullable_to_non_nullable
as bool,pollInMs: freezed == pollInMs ? _self.pollInMs : pollInMs // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
