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

 String get baseUrl; String? get apiKey; String? get projectId; String? get appId; String get sdkName; String get sdkVersion; String get sdkPlatform; String get bundleId; String? get clientId;
/// Create a copy of SdkConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SdkConfigCopyWith<SdkConfig> get copyWith => _$SdkConfigCopyWithImpl<SdkConfig>(this as SdkConfig, _$identity);

  /// Serializes this SdkConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SdkConfig&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl)&&(identical(other.apiKey, apiKey) || other.apiKey == apiKey)&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.appId, appId) || other.appId == appId)&&(identical(other.sdkName, sdkName) || other.sdkName == sdkName)&&(identical(other.sdkVersion, sdkVersion) || other.sdkVersion == sdkVersion)&&(identical(other.sdkPlatform, sdkPlatform) || other.sdkPlatform == sdkPlatform)&&(identical(other.bundleId, bundleId) || other.bundleId == bundleId)&&(identical(other.clientId, clientId) || other.clientId == clientId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,baseUrl,apiKey,projectId,appId,sdkName,sdkVersion,sdkPlatform,bundleId,clientId);

@override
String toString() {
  return 'SdkConfig(baseUrl: $baseUrl, apiKey: $apiKey, projectId: $projectId, appId: $appId, sdkName: $sdkName, sdkVersion: $sdkVersion, sdkPlatform: $sdkPlatform, bundleId: $bundleId, clientId: $clientId)';
}


}

/// @nodoc
abstract mixin class $SdkConfigCopyWith<$Res>  {
  factory $SdkConfigCopyWith(SdkConfig value, $Res Function(SdkConfig) _then) = _$SdkConfigCopyWithImpl;
@useResult
$Res call({
 String baseUrl, String? apiKey, String? projectId, String? appId, String sdkName, String sdkVersion, String sdkPlatform, String bundleId, String? clientId
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
@pragma('vm:prefer-inline') @override $Res call({Object? baseUrl = null,Object? apiKey = freezed,Object? projectId = freezed,Object? appId = freezed,Object? sdkName = null,Object? sdkVersion = null,Object? sdkPlatform = null,Object? bundleId = null,Object? clientId = freezed,}) {
  return _then(_self.copyWith(
baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as String,apiKey: freezed == apiKey ? _self.apiKey : apiKey // ignore: cast_nullable_to_non_nullable
as String?,projectId: freezed == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String?,appId: freezed == appId ? _self.appId : appId // ignore: cast_nullable_to_non_nullable
as String?,sdkName: null == sdkName ? _self.sdkName : sdkName // ignore: cast_nullable_to_non_nullable
as String,sdkVersion: null == sdkVersion ? _self.sdkVersion : sdkVersion // ignore: cast_nullable_to_non_nullable
as String,sdkPlatform: null == sdkPlatform ? _self.sdkPlatform : sdkPlatform // ignore: cast_nullable_to_non_nullable
as String,bundleId: null == bundleId ? _self.bundleId : bundleId // ignore: cast_nullable_to_non_nullable
as String,clientId: freezed == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String baseUrl,  String? apiKey,  String? projectId,  String? appId,  String sdkName,  String sdkVersion,  String sdkPlatform,  String bundleId,  String? clientId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SdkConfig() when $default != null:
return $default(_that.baseUrl,_that.apiKey,_that.projectId,_that.appId,_that.sdkName,_that.sdkVersion,_that.sdkPlatform,_that.bundleId,_that.clientId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String baseUrl,  String? apiKey,  String? projectId,  String? appId,  String sdkName,  String sdkVersion,  String sdkPlatform,  String bundleId,  String? clientId)  $default,) {final _that = this;
switch (_that) {
case _SdkConfig():
return $default(_that.baseUrl,_that.apiKey,_that.projectId,_that.appId,_that.sdkName,_that.sdkVersion,_that.sdkPlatform,_that.bundleId,_that.clientId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String baseUrl,  String? apiKey,  String? projectId,  String? appId,  String sdkName,  String sdkVersion,  String sdkPlatform,  String bundleId,  String? clientId)?  $default,) {final _that = this;
switch (_that) {
case _SdkConfig() when $default != null:
return $default(_that.baseUrl,_that.apiKey,_that.projectId,_that.appId,_that.sdkName,_that.sdkVersion,_that.sdkPlatform,_that.bundleId,_that.clientId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SdkConfig implements SdkConfig {
  const _SdkConfig({required this.baseUrl, this.apiKey, this.projectId, this.appId, required this.sdkName, required this.sdkVersion, required this.sdkPlatform, required this.bundleId, this.clientId});
  factory _SdkConfig.fromJson(Map<String, dynamic> json) => _$SdkConfigFromJson(json);

@override final  String baseUrl;
@override final  String? apiKey;
@override final  String? projectId;
@override final  String? appId;
@override final  String sdkName;
@override final  String sdkVersion;
@override final  String sdkPlatform;
@override final  String bundleId;
@override final  String? clientId;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SdkConfig&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl)&&(identical(other.apiKey, apiKey) || other.apiKey == apiKey)&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.appId, appId) || other.appId == appId)&&(identical(other.sdkName, sdkName) || other.sdkName == sdkName)&&(identical(other.sdkVersion, sdkVersion) || other.sdkVersion == sdkVersion)&&(identical(other.sdkPlatform, sdkPlatform) || other.sdkPlatform == sdkPlatform)&&(identical(other.bundleId, bundleId) || other.bundleId == bundleId)&&(identical(other.clientId, clientId) || other.clientId == clientId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,baseUrl,apiKey,projectId,appId,sdkName,sdkVersion,sdkPlatform,bundleId,clientId);

@override
String toString() {
  return 'SdkConfig(baseUrl: $baseUrl, apiKey: $apiKey, projectId: $projectId, appId: $appId, sdkName: $sdkName, sdkVersion: $sdkVersion, sdkPlatform: $sdkPlatform, bundleId: $bundleId, clientId: $clientId)';
}


}

/// @nodoc
abstract mixin class _$SdkConfigCopyWith<$Res> implements $SdkConfigCopyWith<$Res> {
  factory _$SdkConfigCopyWith(_SdkConfig value, $Res Function(_SdkConfig) _then) = __$SdkConfigCopyWithImpl;
@override @useResult
$Res call({
 String baseUrl, String? apiKey, String? projectId, String? appId, String sdkName, String sdkVersion, String sdkPlatform, String bundleId, String? clientId
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
@override @pragma('vm:prefer-inline') $Res call({Object? baseUrl = null,Object? apiKey = freezed,Object? projectId = freezed,Object? appId = freezed,Object? sdkName = null,Object? sdkVersion = null,Object? sdkPlatform = null,Object? bundleId = null,Object? clientId = freezed,}) {
  return _then(_SdkConfig(
baseUrl: null == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as String,apiKey: freezed == apiKey ? _self.apiKey : apiKey // ignore: cast_nullable_to_non_nullable
as String?,projectId: freezed == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String?,appId: freezed == appId ? _self.appId : appId // ignore: cast_nullable_to_non_nullable
as String?,sdkName: null == sdkName ? _self.sdkName : sdkName // ignore: cast_nullable_to_non_nullable
as String,sdkVersion: null == sdkVersion ? _self.sdkVersion : sdkVersion // ignore: cast_nullable_to_non_nullable
as String,sdkPlatform: null == sdkPlatform ? _self.sdkPlatform : sdkPlatform // ignore: cast_nullable_to_non_nullable
as String,bundleId: null == bundleId ? _self.bundleId : bundleId // ignore: cast_nullable_to_non_nullable
as String,clientId: freezed == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$GetPaymentOptionsRequest {

 String get paymentLink; List<String> get accounts; bool get includePaymentInfo;
/// Create a copy of GetPaymentOptionsRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetPaymentOptionsRequestCopyWith<GetPaymentOptionsRequest> get copyWith => _$GetPaymentOptionsRequestCopyWithImpl<GetPaymentOptionsRequest>(this as GetPaymentOptionsRequest, _$identity);

  /// Serializes this GetPaymentOptionsRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetPaymentOptionsRequest&&(identical(other.paymentLink, paymentLink) || other.paymentLink == paymentLink)&&const DeepCollectionEquality().equals(other.accounts, accounts)&&(identical(other.includePaymentInfo, includePaymentInfo) || other.includePaymentInfo == includePaymentInfo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,paymentLink,const DeepCollectionEquality().hash(accounts),includePaymentInfo);

@override
String toString() {
  return 'GetPaymentOptionsRequest(paymentLink: $paymentLink, accounts: $accounts, includePaymentInfo: $includePaymentInfo)';
}


}

/// @nodoc
abstract mixin class $GetPaymentOptionsRequestCopyWith<$Res>  {
  factory $GetPaymentOptionsRequestCopyWith(GetPaymentOptionsRequest value, $Res Function(GetPaymentOptionsRequest) _then) = _$GetPaymentOptionsRequestCopyWithImpl;
@useResult
$Res call({
 String paymentLink, List<String> accounts, bool includePaymentInfo
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
@pragma('vm:prefer-inline') @override $Res call({Object? paymentLink = null,Object? accounts = null,Object? includePaymentInfo = null,}) {
  return _then(_self.copyWith(
paymentLink: null == paymentLink ? _self.paymentLink : paymentLink // ignore: cast_nullable_to_non_nullable
as String,accounts: null == accounts ? _self.accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<String>,includePaymentInfo: null == includePaymentInfo ? _self.includePaymentInfo : includePaymentInfo // ignore: cast_nullable_to_non_nullable
as bool,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String paymentLink,  List<String> accounts,  bool includePaymentInfo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetPaymentOptionsRequest() when $default != null:
return $default(_that.paymentLink,_that.accounts,_that.includePaymentInfo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String paymentLink,  List<String> accounts,  bool includePaymentInfo)  $default,) {final _that = this;
switch (_that) {
case _GetPaymentOptionsRequest():
return $default(_that.paymentLink,_that.accounts,_that.includePaymentInfo);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String paymentLink,  List<String> accounts,  bool includePaymentInfo)?  $default,) {final _that = this;
switch (_that) {
case _GetPaymentOptionsRequest() when $default != null:
return $default(_that.paymentLink,_that.accounts,_that.includePaymentInfo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GetPaymentOptionsRequest implements GetPaymentOptionsRequest {
  const _GetPaymentOptionsRequest({required this.paymentLink, required final  List<String> accounts, this.includePaymentInfo = false}): _accounts = accounts;
  factory _GetPaymentOptionsRequest.fromJson(Map<String, dynamic> json) => _$GetPaymentOptionsRequestFromJson(json);

@override final  String paymentLink;
 final  List<String> _accounts;
@override List<String> get accounts {
  if (_accounts is EqualUnmodifiableListView) return _accounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_accounts);
}

@override@JsonKey() final  bool includePaymentInfo;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetPaymentOptionsRequest&&(identical(other.paymentLink, paymentLink) || other.paymentLink == paymentLink)&&const DeepCollectionEquality().equals(other._accounts, _accounts)&&(identical(other.includePaymentInfo, includePaymentInfo) || other.includePaymentInfo == includePaymentInfo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,paymentLink,const DeepCollectionEquality().hash(_accounts),includePaymentInfo);

@override
String toString() {
  return 'GetPaymentOptionsRequest(paymentLink: $paymentLink, accounts: $accounts, includePaymentInfo: $includePaymentInfo)';
}


}

/// @nodoc
abstract mixin class _$GetPaymentOptionsRequestCopyWith<$Res> implements $GetPaymentOptionsRequestCopyWith<$Res> {
  factory _$GetPaymentOptionsRequestCopyWith(_GetPaymentOptionsRequest value, $Res Function(_GetPaymentOptionsRequest) _then) = __$GetPaymentOptionsRequestCopyWithImpl;
@override @useResult
$Res call({
 String paymentLink, List<String> accounts, bool includePaymentInfo
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
@override @pragma('vm:prefer-inline') $Res call({Object? paymentLink = null,Object? accounts = null,Object? includePaymentInfo = null,}) {
  return _then(_GetPaymentOptionsRequest(
paymentLink: null == paymentLink ? _self.paymentLink : paymentLink // ignore: cast_nullable_to_non_nullable
as String,accounts: null == accounts ? _self._accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<String>,includePaymentInfo: null == includePaymentInfo ? _self.includePaymentInfo : includePaymentInfo // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$PaymentOptionsResponse {

 String get paymentId; PaymentInfo? get info; List<PaymentOption> get options; CollectDataAction? get collectData;
/// Create a copy of PaymentOptionsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentOptionsResponseCopyWith<PaymentOptionsResponse> get copyWith => _$PaymentOptionsResponseCopyWithImpl<PaymentOptionsResponse>(this as PaymentOptionsResponse, _$identity);

  /// Serializes this PaymentOptionsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentOptionsResponse&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId)&&(identical(other.info, info) || other.info == info)&&const DeepCollectionEquality().equals(other.options, options)&&(identical(other.collectData, collectData) || other.collectData == collectData));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,paymentId,info,const DeepCollectionEquality().hash(options),collectData);

@override
String toString() {
  return 'PaymentOptionsResponse(paymentId: $paymentId, info: $info, options: $options, collectData: $collectData)';
}


}

/// @nodoc
abstract mixin class $PaymentOptionsResponseCopyWith<$Res>  {
  factory $PaymentOptionsResponseCopyWith(PaymentOptionsResponse value, $Res Function(PaymentOptionsResponse) _then) = _$PaymentOptionsResponseCopyWithImpl;
@useResult
$Res call({
 String paymentId, PaymentInfo? info, List<PaymentOption> options, CollectDataAction? collectData
});


$PaymentInfoCopyWith<$Res>? get info;$CollectDataActionCopyWith<$Res>? get collectData;

}
/// @nodoc
class _$PaymentOptionsResponseCopyWithImpl<$Res>
    implements $PaymentOptionsResponseCopyWith<$Res> {
  _$PaymentOptionsResponseCopyWithImpl(this._self, this._then);

  final PaymentOptionsResponse _self;
  final $Res Function(PaymentOptionsResponse) _then;

/// Create a copy of PaymentOptionsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? paymentId = null,Object? info = freezed,Object? options = null,Object? collectData = freezed,}) {
  return _then(_self.copyWith(
paymentId: null == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as String,info: freezed == info ? _self.info : info // ignore: cast_nullable_to_non_nullable
as PaymentInfo?,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<PaymentOption>,collectData: freezed == collectData ? _self.collectData : collectData // ignore: cast_nullable_to_non_nullable
as CollectDataAction?,
  ));
}
/// Create a copy of PaymentOptionsResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentInfoCopyWith<$Res>? get info {
    if (_self.info == null) {
    return null;
  }

  return $PaymentInfoCopyWith<$Res>(_self.info!, (value) {
    return _then(_self.copyWith(info: value));
  });
}/// Create a copy of PaymentOptionsResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CollectDataActionCopyWith<$Res>? get collectData {
    if (_self.collectData == null) {
    return null;
  }

  return $CollectDataActionCopyWith<$Res>(_self.collectData!, (value) {
    return _then(_self.copyWith(collectData: value));
  });
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String paymentId,  PaymentInfo? info,  List<PaymentOption> options,  CollectDataAction? collectData)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentOptionsResponse() when $default != null:
return $default(_that.paymentId,_that.info,_that.options,_that.collectData);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String paymentId,  PaymentInfo? info,  List<PaymentOption> options,  CollectDataAction? collectData)  $default,) {final _that = this;
switch (_that) {
case _PaymentOptionsResponse():
return $default(_that.paymentId,_that.info,_that.options,_that.collectData);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String paymentId,  PaymentInfo? info,  List<PaymentOption> options,  CollectDataAction? collectData)?  $default,) {final _that = this;
switch (_that) {
case _PaymentOptionsResponse() when $default != null:
return $default(_that.paymentId,_that.info,_that.options,_that.collectData);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentOptionsResponse implements PaymentOptionsResponse {
  const _PaymentOptionsResponse({required this.paymentId, this.info, required final  List<PaymentOption> options, this.collectData}): _options = options;
  factory _PaymentOptionsResponse.fromJson(Map<String, dynamic> json) => _$PaymentOptionsResponseFromJson(json);

@override final  String paymentId;
@override final  PaymentInfo? info;
 final  List<PaymentOption> _options;
@override List<PaymentOption> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}

@override final  CollectDataAction? collectData;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentOptionsResponse&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId)&&(identical(other.info, info) || other.info == info)&&const DeepCollectionEquality().equals(other._options, _options)&&(identical(other.collectData, collectData) || other.collectData == collectData));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,paymentId,info,const DeepCollectionEquality().hash(_options),collectData);

@override
String toString() {
  return 'PaymentOptionsResponse(paymentId: $paymentId, info: $info, options: $options, collectData: $collectData)';
}


}

/// @nodoc
abstract mixin class _$PaymentOptionsResponseCopyWith<$Res> implements $PaymentOptionsResponseCopyWith<$Res> {
  factory _$PaymentOptionsResponseCopyWith(_PaymentOptionsResponse value, $Res Function(_PaymentOptionsResponse) _then) = __$PaymentOptionsResponseCopyWithImpl;
@override @useResult
$Res call({
 String paymentId, PaymentInfo? info, List<PaymentOption> options, CollectDataAction? collectData
});


@override $PaymentInfoCopyWith<$Res>? get info;@override $CollectDataActionCopyWith<$Res>? get collectData;

}
/// @nodoc
class __$PaymentOptionsResponseCopyWithImpl<$Res>
    implements _$PaymentOptionsResponseCopyWith<$Res> {
  __$PaymentOptionsResponseCopyWithImpl(this._self, this._then);

  final _PaymentOptionsResponse _self;
  final $Res Function(_PaymentOptionsResponse) _then;

/// Create a copy of PaymentOptionsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? paymentId = null,Object? info = freezed,Object? options = null,Object? collectData = freezed,}) {
  return _then(_PaymentOptionsResponse(
paymentId: null == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as String,info: freezed == info ? _self.info : info // ignore: cast_nullable_to_non_nullable
as PaymentInfo?,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<PaymentOption>,collectData: freezed == collectData ? _self.collectData : collectData // ignore: cast_nullable_to_non_nullable
as CollectDataAction?,
  ));
}

/// Create a copy of PaymentOptionsResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentInfoCopyWith<$Res>? get info {
    if (_self.info == null) {
    return null;
  }

  return $PaymentInfoCopyWith<$Res>(_self.info!, (value) {
    return _then(_self.copyWith(info: value));
  });
}/// Create a copy of PaymentOptionsResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CollectDataActionCopyWith<$Res>? get collectData {
    if (_self.collectData == null) {
    return null;
  }

  return $CollectDataActionCopyWith<$Res>(_self.collectData!, (value) {
    return _then(_self.copyWith(collectData: value));
  });
}
}


/// @nodoc
mixin _$PaymentInfo {

 PaymentStatus get status; PayAmount get amount; int get expiresAt; MerchantInfo get merchant; BuyerInfo? get buyer;
/// Create a copy of PaymentInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentInfoCopyWith<PaymentInfo> get copyWith => _$PaymentInfoCopyWithImpl<PaymentInfo>(this as PaymentInfo, _$identity);

  /// Serializes this PaymentInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentInfo&&(identical(other.status, status) || other.status == status)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.merchant, merchant) || other.merchant == merchant)&&(identical(other.buyer, buyer) || other.buyer == buyer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,amount,expiresAt,merchant,buyer);

@override
String toString() {
  return 'PaymentInfo(status: $status, amount: $amount, expiresAt: $expiresAt, merchant: $merchant, buyer: $buyer)';
}


}

/// @nodoc
abstract mixin class $PaymentInfoCopyWith<$Res>  {
  factory $PaymentInfoCopyWith(PaymentInfo value, $Res Function(PaymentInfo) _then) = _$PaymentInfoCopyWithImpl;
@useResult
$Res call({
 PaymentStatus status, PayAmount amount, int expiresAt, MerchantInfo merchant, BuyerInfo? buyer
});


$PayAmountCopyWith<$Res> get amount;$MerchantInfoCopyWith<$Res> get merchant;$BuyerInfoCopyWith<$Res>? get buyer;

}
/// @nodoc
class _$PaymentInfoCopyWithImpl<$Res>
    implements $PaymentInfoCopyWith<$Res> {
  _$PaymentInfoCopyWithImpl(this._self, this._then);

  final PaymentInfo _self;
  final $Res Function(PaymentInfo) _then;

/// Create a copy of PaymentInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? amount = null,Object? expiresAt = null,Object? merchant = null,Object? buyer = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PaymentStatus,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as PayAmount,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as int,merchant: null == merchant ? _self.merchant : merchant // ignore: cast_nullable_to_non_nullable
as MerchantInfo,buyer: freezed == buyer ? _self.buyer : buyer // ignore: cast_nullable_to_non_nullable
as BuyerInfo?,
  ));
}
/// Create a copy of PaymentInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PayAmountCopyWith<$Res> get amount {
  
  return $PayAmountCopyWith<$Res>(_self.amount, (value) {
    return _then(_self.copyWith(amount: value));
  });
}/// Create a copy of PaymentInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MerchantInfoCopyWith<$Res> get merchant {
  
  return $MerchantInfoCopyWith<$Res>(_self.merchant, (value) {
    return _then(_self.copyWith(merchant: value));
  });
}/// Create a copy of PaymentInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BuyerInfoCopyWith<$Res>? get buyer {
    if (_self.buyer == null) {
    return null;
  }

  return $BuyerInfoCopyWith<$Res>(_self.buyer!, (value) {
    return _then(_self.copyWith(buyer: value));
  });
}
}


/// Adds pattern-matching-related methods to [PaymentInfo].
extension PaymentInfoPatterns on PaymentInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentInfo value)  $default,){
final _that = this;
switch (_that) {
case _PaymentInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentInfo value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PaymentStatus status,  PayAmount amount,  int expiresAt,  MerchantInfo merchant,  BuyerInfo? buyer)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentInfo() when $default != null:
return $default(_that.status,_that.amount,_that.expiresAt,_that.merchant,_that.buyer);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PaymentStatus status,  PayAmount amount,  int expiresAt,  MerchantInfo merchant,  BuyerInfo? buyer)  $default,) {final _that = this;
switch (_that) {
case _PaymentInfo():
return $default(_that.status,_that.amount,_that.expiresAt,_that.merchant,_that.buyer);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PaymentStatus status,  PayAmount amount,  int expiresAt,  MerchantInfo merchant,  BuyerInfo? buyer)?  $default,) {final _that = this;
switch (_that) {
case _PaymentInfo() when $default != null:
return $default(_that.status,_that.amount,_that.expiresAt,_that.merchant,_that.buyer);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentInfo implements PaymentInfo {
  const _PaymentInfo({required this.status, required this.amount, required this.expiresAt, required this.merchant, this.buyer});
  factory _PaymentInfo.fromJson(Map<String, dynamic> json) => _$PaymentInfoFromJson(json);

@override final  PaymentStatus status;
@override final  PayAmount amount;
@override final  int expiresAt;
@override final  MerchantInfo merchant;
@override final  BuyerInfo? buyer;

/// Create a copy of PaymentInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentInfoCopyWith<_PaymentInfo> get copyWith => __$PaymentInfoCopyWithImpl<_PaymentInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentInfo&&(identical(other.status, status) || other.status == status)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.merchant, merchant) || other.merchant == merchant)&&(identical(other.buyer, buyer) || other.buyer == buyer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,amount,expiresAt,merchant,buyer);

@override
String toString() {
  return 'PaymentInfo(status: $status, amount: $amount, expiresAt: $expiresAt, merchant: $merchant, buyer: $buyer)';
}


}

/// @nodoc
abstract mixin class _$PaymentInfoCopyWith<$Res> implements $PaymentInfoCopyWith<$Res> {
  factory _$PaymentInfoCopyWith(_PaymentInfo value, $Res Function(_PaymentInfo) _then) = __$PaymentInfoCopyWithImpl;
@override @useResult
$Res call({
 PaymentStatus status, PayAmount amount, int expiresAt, MerchantInfo merchant, BuyerInfo? buyer
});


@override $PayAmountCopyWith<$Res> get amount;@override $MerchantInfoCopyWith<$Res> get merchant;@override $BuyerInfoCopyWith<$Res>? get buyer;

}
/// @nodoc
class __$PaymentInfoCopyWithImpl<$Res>
    implements _$PaymentInfoCopyWith<$Res> {
  __$PaymentInfoCopyWithImpl(this._self, this._then);

  final _PaymentInfo _self;
  final $Res Function(_PaymentInfo) _then;

/// Create a copy of PaymentInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? amount = null,Object? expiresAt = null,Object? merchant = null,Object? buyer = freezed,}) {
  return _then(_PaymentInfo(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PaymentStatus,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as PayAmount,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as int,merchant: null == merchant ? _self.merchant : merchant // ignore: cast_nullable_to_non_nullable
as MerchantInfo,buyer: freezed == buyer ? _self.buyer : buyer // ignore: cast_nullable_to_non_nullable
as BuyerInfo?,
  ));
}

/// Create a copy of PaymentInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PayAmountCopyWith<$Res> get amount {
  
  return $PayAmountCopyWith<$Res>(_self.amount, (value) {
    return _then(_self.copyWith(amount: value));
  });
}/// Create a copy of PaymentInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MerchantInfoCopyWith<$Res> get merchant {
  
  return $MerchantInfoCopyWith<$Res>(_self.merchant, (value) {
    return _then(_self.copyWith(merchant: value));
  });
}/// Create a copy of PaymentInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BuyerInfoCopyWith<$Res>? get buyer {
    if (_self.buyer == null) {
    return null;
  }

  return $BuyerInfoCopyWith<$Res>(_self.buyer!, (value) {
    return _then(_self.copyWith(buyer: value));
  });
}
}


/// @nodoc
mixin _$MerchantInfo {

 String get name; String? get iconUrl;
/// Create a copy of MerchantInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MerchantInfoCopyWith<MerchantInfo> get copyWith => _$MerchantInfoCopyWithImpl<MerchantInfo>(this as MerchantInfo, _$identity);

  /// Serializes this MerchantInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MerchantInfo&&(identical(other.name, name) || other.name == name)&&(identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,iconUrl);

@override
String toString() {
  return 'MerchantInfo(name: $name, iconUrl: $iconUrl)';
}


}

/// @nodoc
abstract mixin class $MerchantInfoCopyWith<$Res>  {
  factory $MerchantInfoCopyWith(MerchantInfo value, $Res Function(MerchantInfo) _then) = _$MerchantInfoCopyWithImpl;
@useResult
$Res call({
 String name, String? iconUrl
});




}
/// @nodoc
class _$MerchantInfoCopyWithImpl<$Res>
    implements $MerchantInfoCopyWith<$Res> {
  _$MerchantInfoCopyWithImpl(this._self, this._then);

  final MerchantInfo _self;
  final $Res Function(MerchantInfo) _then;

/// Create a copy of MerchantInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? iconUrl = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,iconUrl: freezed == iconUrl ? _self.iconUrl : iconUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MerchantInfo].
extension MerchantInfoPatterns on MerchantInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MerchantInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MerchantInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MerchantInfo value)  $default,){
final _that = this;
switch (_that) {
case _MerchantInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MerchantInfo value)?  $default,){
final _that = this;
switch (_that) {
case _MerchantInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String? iconUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MerchantInfo() when $default != null:
return $default(_that.name,_that.iconUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String? iconUrl)  $default,) {final _that = this;
switch (_that) {
case _MerchantInfo():
return $default(_that.name,_that.iconUrl);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String? iconUrl)?  $default,) {final _that = this;
switch (_that) {
case _MerchantInfo() when $default != null:
return $default(_that.name,_that.iconUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MerchantInfo implements MerchantInfo {
  const _MerchantInfo({required this.name, this.iconUrl});
  factory _MerchantInfo.fromJson(Map<String, dynamic> json) => _$MerchantInfoFromJson(json);

@override final  String name;
@override final  String? iconUrl;

/// Create a copy of MerchantInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MerchantInfoCopyWith<_MerchantInfo> get copyWith => __$MerchantInfoCopyWithImpl<_MerchantInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MerchantInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MerchantInfo&&(identical(other.name, name) || other.name == name)&&(identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,iconUrl);

@override
String toString() {
  return 'MerchantInfo(name: $name, iconUrl: $iconUrl)';
}


}

/// @nodoc
abstract mixin class _$MerchantInfoCopyWith<$Res> implements $MerchantInfoCopyWith<$Res> {
  factory _$MerchantInfoCopyWith(_MerchantInfo value, $Res Function(_MerchantInfo) _then) = __$MerchantInfoCopyWithImpl;
@override @useResult
$Res call({
 String name, String? iconUrl
});




}
/// @nodoc
class __$MerchantInfoCopyWithImpl<$Res>
    implements _$MerchantInfoCopyWith<$Res> {
  __$MerchantInfoCopyWithImpl(this._self, this._then);

  final _MerchantInfo _self;
  final $Res Function(_MerchantInfo) _then;

/// Create a copy of MerchantInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? iconUrl = freezed,}) {
  return _then(_MerchantInfo(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,iconUrl: freezed == iconUrl ? _self.iconUrl : iconUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$BuyerInfo {

 String get accountCaip10; String get accountProviderName; String? get accountProviderIcon;
/// Create a copy of BuyerInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BuyerInfoCopyWith<BuyerInfo> get copyWith => _$BuyerInfoCopyWithImpl<BuyerInfo>(this as BuyerInfo, _$identity);

  /// Serializes this BuyerInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BuyerInfo&&(identical(other.accountCaip10, accountCaip10) || other.accountCaip10 == accountCaip10)&&(identical(other.accountProviderName, accountProviderName) || other.accountProviderName == accountProviderName)&&(identical(other.accountProviderIcon, accountProviderIcon) || other.accountProviderIcon == accountProviderIcon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accountCaip10,accountProviderName,accountProviderIcon);

@override
String toString() {
  return 'BuyerInfo(accountCaip10: $accountCaip10, accountProviderName: $accountProviderName, accountProviderIcon: $accountProviderIcon)';
}


}

/// @nodoc
abstract mixin class $BuyerInfoCopyWith<$Res>  {
  factory $BuyerInfoCopyWith(BuyerInfo value, $Res Function(BuyerInfo) _then) = _$BuyerInfoCopyWithImpl;
@useResult
$Res call({
 String accountCaip10, String accountProviderName, String? accountProviderIcon
});




}
/// @nodoc
class _$BuyerInfoCopyWithImpl<$Res>
    implements $BuyerInfoCopyWith<$Res> {
  _$BuyerInfoCopyWithImpl(this._self, this._then);

  final BuyerInfo _self;
  final $Res Function(BuyerInfo) _then;

/// Create a copy of BuyerInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accountCaip10 = null,Object? accountProviderName = null,Object? accountProviderIcon = freezed,}) {
  return _then(_self.copyWith(
accountCaip10: null == accountCaip10 ? _self.accountCaip10 : accountCaip10 // ignore: cast_nullable_to_non_nullable
as String,accountProviderName: null == accountProviderName ? _self.accountProviderName : accountProviderName // ignore: cast_nullable_to_non_nullable
as String,accountProviderIcon: freezed == accountProviderIcon ? _self.accountProviderIcon : accountProviderIcon // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BuyerInfo].
extension BuyerInfoPatterns on BuyerInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BuyerInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BuyerInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BuyerInfo value)  $default,){
final _that = this;
switch (_that) {
case _BuyerInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BuyerInfo value)?  $default,){
final _that = this;
switch (_that) {
case _BuyerInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String accountCaip10,  String accountProviderName,  String? accountProviderIcon)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BuyerInfo() when $default != null:
return $default(_that.accountCaip10,_that.accountProviderName,_that.accountProviderIcon);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String accountCaip10,  String accountProviderName,  String? accountProviderIcon)  $default,) {final _that = this;
switch (_that) {
case _BuyerInfo():
return $default(_that.accountCaip10,_that.accountProviderName,_that.accountProviderIcon);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String accountCaip10,  String accountProviderName,  String? accountProviderIcon)?  $default,) {final _that = this;
switch (_that) {
case _BuyerInfo() when $default != null:
return $default(_that.accountCaip10,_that.accountProviderName,_that.accountProviderIcon);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BuyerInfo implements BuyerInfo {
  const _BuyerInfo({required this.accountCaip10, required this.accountProviderName, this.accountProviderIcon});
  factory _BuyerInfo.fromJson(Map<String, dynamic> json) => _$BuyerInfoFromJson(json);

@override final  String accountCaip10;
@override final  String accountProviderName;
@override final  String? accountProviderIcon;

/// Create a copy of BuyerInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BuyerInfoCopyWith<_BuyerInfo> get copyWith => __$BuyerInfoCopyWithImpl<_BuyerInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BuyerInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BuyerInfo&&(identical(other.accountCaip10, accountCaip10) || other.accountCaip10 == accountCaip10)&&(identical(other.accountProviderName, accountProviderName) || other.accountProviderName == accountProviderName)&&(identical(other.accountProviderIcon, accountProviderIcon) || other.accountProviderIcon == accountProviderIcon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accountCaip10,accountProviderName,accountProviderIcon);

@override
String toString() {
  return 'BuyerInfo(accountCaip10: $accountCaip10, accountProviderName: $accountProviderName, accountProviderIcon: $accountProviderIcon)';
}


}

/// @nodoc
abstract mixin class _$BuyerInfoCopyWith<$Res> implements $BuyerInfoCopyWith<$Res> {
  factory _$BuyerInfoCopyWith(_BuyerInfo value, $Res Function(_BuyerInfo) _then) = __$BuyerInfoCopyWithImpl;
@override @useResult
$Res call({
 String accountCaip10, String accountProviderName, String? accountProviderIcon
});




}
/// @nodoc
class __$BuyerInfoCopyWithImpl<$Res>
    implements _$BuyerInfoCopyWith<$Res> {
  __$BuyerInfoCopyWithImpl(this._self, this._then);

  final _BuyerInfo _self;
  final $Res Function(_BuyerInfo) _then;

/// Create a copy of BuyerInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accountCaip10 = null,Object? accountProviderName = null,Object? accountProviderIcon = freezed,}) {
  return _then(_BuyerInfo(
accountCaip10: null == accountCaip10 ? _self.accountCaip10 : accountCaip10 // ignore: cast_nullable_to_non_nullable
as String,accountProviderName: null == accountProviderName ? _self.accountProviderName : accountProviderName // ignore: cast_nullable_to_non_nullable
as String,accountProviderIcon: freezed == accountProviderIcon ? _self.accountProviderIcon : accountProviderIcon // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$CollectDataAction {

 List<CollectDataField> get fields;
/// Create a copy of CollectDataAction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CollectDataActionCopyWith<CollectDataAction> get copyWith => _$CollectDataActionCopyWithImpl<CollectDataAction>(this as CollectDataAction, _$identity);

  /// Serializes this CollectDataAction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CollectDataAction&&const DeepCollectionEquality().equals(other.fields, fields));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(fields));

@override
String toString() {
  return 'CollectDataAction(fields: $fields)';
}


}

/// @nodoc
abstract mixin class $CollectDataActionCopyWith<$Res>  {
  factory $CollectDataActionCopyWith(CollectDataAction value, $Res Function(CollectDataAction) _then) = _$CollectDataActionCopyWithImpl;
@useResult
$Res call({
 List<CollectDataField> fields
});




}
/// @nodoc
class _$CollectDataActionCopyWithImpl<$Res>
    implements $CollectDataActionCopyWith<$Res> {
  _$CollectDataActionCopyWithImpl(this._self, this._then);

  final CollectDataAction _self;
  final $Res Function(CollectDataAction) _then;

/// Create a copy of CollectDataAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fields = null,}) {
  return _then(_self.copyWith(
fields: null == fields ? _self.fields : fields // ignore: cast_nullable_to_non_nullable
as List<CollectDataField>,
  ));
}

}


/// Adds pattern-matching-related methods to [CollectDataAction].
extension CollectDataActionPatterns on CollectDataAction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CollectDataAction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CollectDataAction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CollectDataAction value)  $default,){
final _that = this;
switch (_that) {
case _CollectDataAction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CollectDataAction value)?  $default,){
final _that = this;
switch (_that) {
case _CollectDataAction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<CollectDataField> fields)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CollectDataAction() when $default != null:
return $default(_that.fields);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<CollectDataField> fields)  $default,) {final _that = this;
switch (_that) {
case _CollectDataAction():
return $default(_that.fields);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<CollectDataField> fields)?  $default,) {final _that = this;
switch (_that) {
case _CollectDataAction() when $default != null:
return $default(_that.fields);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CollectDataAction implements CollectDataAction {
  const _CollectDataAction({required final  List<CollectDataField> fields}): _fields = fields;
  factory _CollectDataAction.fromJson(Map<String, dynamic> json) => _$CollectDataActionFromJson(json);

 final  List<CollectDataField> _fields;
@override List<CollectDataField> get fields {
  if (_fields is EqualUnmodifiableListView) return _fields;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fields);
}


/// Create a copy of CollectDataAction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CollectDataActionCopyWith<_CollectDataAction> get copyWith => __$CollectDataActionCopyWithImpl<_CollectDataAction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CollectDataActionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CollectDataAction&&const DeepCollectionEquality().equals(other._fields, _fields));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_fields));

@override
String toString() {
  return 'CollectDataAction(fields: $fields)';
}


}

/// @nodoc
abstract mixin class _$CollectDataActionCopyWith<$Res> implements $CollectDataActionCopyWith<$Res> {
  factory _$CollectDataActionCopyWith(_CollectDataAction value, $Res Function(_CollectDataAction) _then) = __$CollectDataActionCopyWithImpl;
@override @useResult
$Res call({
 List<CollectDataField> fields
});




}
/// @nodoc
class __$CollectDataActionCopyWithImpl<$Res>
    implements _$CollectDataActionCopyWith<$Res> {
  __$CollectDataActionCopyWithImpl(this._self, this._then);

  final _CollectDataAction _self;
  final $Res Function(_CollectDataAction) _then;

/// Create a copy of CollectDataAction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fields = null,}) {
  return _then(_CollectDataAction(
fields: null == fields ? _self._fields : fields // ignore: cast_nullable_to_non_nullable
as List<CollectDataField>,
  ));
}


}


/// @nodoc
mixin _$CollectDataField {

 String get id; String get name; bool get required; CollectDataFieldType get fieldType;
/// Create a copy of CollectDataField
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CollectDataFieldCopyWith<CollectDataField> get copyWith => _$CollectDataFieldCopyWithImpl<CollectDataField>(this as CollectDataField, _$identity);

  /// Serializes this CollectDataField to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CollectDataField&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.required, required) || other.required == required)&&(identical(other.fieldType, fieldType) || other.fieldType == fieldType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,required,fieldType);

@override
String toString() {
  return 'CollectDataField(id: $id, name: $name, required: $required, fieldType: $fieldType)';
}


}

/// @nodoc
abstract mixin class $CollectDataFieldCopyWith<$Res>  {
  factory $CollectDataFieldCopyWith(CollectDataField value, $Res Function(CollectDataField) _then) = _$CollectDataFieldCopyWithImpl;
@useResult
$Res call({
 String id, String name, bool required, CollectDataFieldType fieldType
});




}
/// @nodoc
class _$CollectDataFieldCopyWithImpl<$Res>
    implements $CollectDataFieldCopyWith<$Res> {
  _$CollectDataFieldCopyWithImpl(this._self, this._then);

  final CollectDataField _self;
  final $Res Function(CollectDataField) _then;

/// Create a copy of CollectDataField
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? required = null,Object? fieldType = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,required: null == required ? _self.required : required // ignore: cast_nullable_to_non_nullable
as bool,fieldType: null == fieldType ? _self.fieldType : fieldType // ignore: cast_nullable_to_non_nullable
as CollectDataFieldType,
  ));
}

}


/// Adds pattern-matching-related methods to [CollectDataField].
extension CollectDataFieldPatterns on CollectDataField {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CollectDataField value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CollectDataField() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CollectDataField value)  $default,){
final _that = this;
switch (_that) {
case _CollectDataField():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CollectDataField value)?  $default,){
final _that = this;
switch (_that) {
case _CollectDataField() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  bool required,  CollectDataFieldType fieldType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CollectDataField() when $default != null:
return $default(_that.id,_that.name,_that.required,_that.fieldType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  bool required,  CollectDataFieldType fieldType)  $default,) {final _that = this;
switch (_that) {
case _CollectDataField():
return $default(_that.id,_that.name,_that.required,_that.fieldType);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  bool required,  CollectDataFieldType fieldType)?  $default,) {final _that = this;
switch (_that) {
case _CollectDataField() when $default != null:
return $default(_that.id,_that.name,_that.required,_that.fieldType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CollectDataField implements CollectDataField {
  const _CollectDataField({required this.id, required this.name, required this.required, required this.fieldType});
  factory _CollectDataField.fromJson(Map<String, dynamic> json) => _$CollectDataFieldFromJson(json);

@override final  String id;
@override final  String name;
@override final  bool required;
@override final  CollectDataFieldType fieldType;

/// Create a copy of CollectDataField
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CollectDataFieldCopyWith<_CollectDataField> get copyWith => __$CollectDataFieldCopyWithImpl<_CollectDataField>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CollectDataFieldToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CollectDataField&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.required, required) || other.required == required)&&(identical(other.fieldType, fieldType) || other.fieldType == fieldType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,required,fieldType);

@override
String toString() {
  return 'CollectDataField(id: $id, name: $name, required: $required, fieldType: $fieldType)';
}


}

/// @nodoc
abstract mixin class _$CollectDataFieldCopyWith<$Res> implements $CollectDataFieldCopyWith<$Res> {
  factory _$CollectDataFieldCopyWith(_CollectDataField value, $Res Function(_CollectDataField) _then) = __$CollectDataFieldCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, bool required, CollectDataFieldType fieldType
});




}
/// @nodoc
class __$CollectDataFieldCopyWithImpl<$Res>
    implements _$CollectDataFieldCopyWith<$Res> {
  __$CollectDataFieldCopyWithImpl(this._self, this._then);

  final _CollectDataField _self;
  final $Res Function(_CollectDataField) _then;

/// Create a copy of CollectDataField
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? required = null,Object? fieldType = null,}) {
  return _then(_CollectDataField(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,required: null == required ? _self.required : required // ignore: cast_nullable_to_non_nullable
as bool,fieldType: null == fieldType ? _self.fieldType : fieldType // ignore: cast_nullable_to_non_nullable
as CollectDataFieldType,
  ));
}


}


/// @nodoc
mixin _$PaymentOption {

 String get id; String get account; PayAmount get amount;@JsonKey(name: 'etaS') int get etaSeconds; List<Action> get actions;
/// Create a copy of PaymentOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentOptionCopyWith<PaymentOption> get copyWith => _$PaymentOptionCopyWithImpl<PaymentOption>(this as PaymentOption, _$identity);

  /// Serializes this PaymentOption to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentOption&&(identical(other.id, id) || other.id == id)&&(identical(other.account, account) || other.account == account)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.etaSeconds, etaSeconds) || other.etaSeconds == etaSeconds)&&const DeepCollectionEquality().equals(other.actions, actions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,account,amount,etaSeconds,const DeepCollectionEquality().hash(actions));

@override
String toString() {
  return 'PaymentOption(id: $id, account: $account, amount: $amount, etaSeconds: $etaSeconds, actions: $actions)';
}


}

/// @nodoc
abstract mixin class $PaymentOptionCopyWith<$Res>  {
  factory $PaymentOptionCopyWith(PaymentOption value, $Res Function(PaymentOption) _then) = _$PaymentOptionCopyWithImpl;
@useResult
$Res call({
 String id, String account, PayAmount amount,@JsonKey(name: 'etaS') int etaSeconds, List<Action> actions
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? account = null,Object? amount = null,Object? etaSeconds = null,Object? actions = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as PayAmount,etaSeconds: null == etaSeconds ? _self.etaSeconds : etaSeconds // ignore: cast_nullable_to_non_nullable
as int,actions: null == actions ? _self.actions : actions // ignore: cast_nullable_to_non_nullable
as List<Action>,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String account,  PayAmount amount, @JsonKey(name: 'etaS')  int etaSeconds,  List<Action> actions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentOption() when $default != null:
return $default(_that.id,_that.account,_that.amount,_that.etaSeconds,_that.actions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String account,  PayAmount amount, @JsonKey(name: 'etaS')  int etaSeconds,  List<Action> actions)  $default,) {final _that = this;
switch (_that) {
case _PaymentOption():
return $default(_that.id,_that.account,_that.amount,_that.etaSeconds,_that.actions);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String account,  PayAmount amount, @JsonKey(name: 'etaS')  int etaSeconds,  List<Action> actions)?  $default,) {final _that = this;
switch (_that) {
case _PaymentOption() when $default != null:
return $default(_that.id,_that.account,_that.amount,_that.etaSeconds,_that.actions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentOption implements PaymentOption {
  const _PaymentOption({required this.id, required this.account, required this.amount, @JsonKey(name: 'etaS') required this.etaSeconds, required final  List<Action> actions}): _actions = actions;
  factory _PaymentOption.fromJson(Map<String, dynamic> json) => _$PaymentOptionFromJson(json);

@override final  String id;
@override final  String account;
@override final  PayAmount amount;
@override@JsonKey(name: 'etaS') final  int etaSeconds;
 final  List<Action> _actions;
@override List<Action> get actions {
  if (_actions is EqualUnmodifiableListView) return _actions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_actions);
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentOption&&(identical(other.id, id) || other.id == id)&&(identical(other.account, account) || other.account == account)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.etaSeconds, etaSeconds) || other.etaSeconds == etaSeconds)&&const DeepCollectionEquality().equals(other._actions, _actions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,account,amount,etaSeconds,const DeepCollectionEquality().hash(_actions));

@override
String toString() {
  return 'PaymentOption(id: $id, account: $account, amount: $amount, etaSeconds: $etaSeconds, actions: $actions)';
}


}

/// @nodoc
abstract mixin class _$PaymentOptionCopyWith<$Res> implements $PaymentOptionCopyWith<$Res> {
  factory _$PaymentOptionCopyWith(_PaymentOption value, $Res Function(_PaymentOption) _then) = __$PaymentOptionCopyWithImpl;
@override @useResult
$Res call({
 String id, String account, PayAmount amount,@JsonKey(name: 'etaS') int etaSeconds, List<Action> actions
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? account = null,Object? amount = null,Object? etaSeconds = null,Object? actions = null,}) {
  return _then(_PaymentOption(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as PayAmount,etaSeconds: null == etaSeconds ? _self.etaSeconds : etaSeconds // ignore: cast_nullable_to_non_nullable
as int,actions: null == actions ? _self._actions : actions // ignore: cast_nullable_to_non_nullable
as List<Action>,
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


/// @nodoc
mixin _$Action {

@JsonKey(name: 'walletRpc') WalletRpcAction get walletRpc;
/// Create a copy of Action
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActionCopyWith<Action> get copyWith => _$ActionCopyWithImpl<Action>(this as Action, _$identity);

  /// Serializes this Action to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Action&&(identical(other.walletRpc, walletRpc) || other.walletRpc == walletRpc));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,walletRpc);

@override
String toString() {
  return 'Action(walletRpc: $walletRpc)';
}


}

/// @nodoc
abstract mixin class $ActionCopyWith<$Res>  {
  factory $ActionCopyWith(Action value, $Res Function(Action) _then) = _$ActionCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'walletRpc') WalletRpcAction walletRpc
});


$WalletRpcActionCopyWith<$Res> get walletRpc;

}
/// @nodoc
class _$ActionCopyWithImpl<$Res>
    implements $ActionCopyWith<$Res> {
  _$ActionCopyWithImpl(this._self, this._then);

  final Action _self;
  final $Res Function(Action) _then;

/// Create a copy of Action
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? walletRpc = null,}) {
  return _then(_self.copyWith(
walletRpc: null == walletRpc ? _self.walletRpc : walletRpc // ignore: cast_nullable_to_non_nullable
as WalletRpcAction,
  ));
}
/// Create a copy of Action
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WalletRpcActionCopyWith<$Res> get walletRpc {
  
  return $WalletRpcActionCopyWith<$Res>(_self.walletRpc, (value) {
    return _then(_self.copyWith(walletRpc: value));
  });
}
}


/// Adds pattern-matching-related methods to [Action].
extension ActionPatterns on Action {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Action value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Action() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Action value)  $default,){
final _that = this;
switch (_that) {
case _Action():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Action value)?  $default,){
final _that = this;
switch (_that) {
case _Action() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'walletRpc')  WalletRpcAction walletRpc)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Action() when $default != null:
return $default(_that.walletRpc);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'walletRpc')  WalletRpcAction walletRpc)  $default,) {final _that = this;
switch (_that) {
case _Action():
return $default(_that.walletRpc);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'walletRpc')  WalletRpcAction walletRpc)?  $default,) {final _that = this;
switch (_that) {
case _Action() when $default != null:
return $default(_that.walletRpc);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Action implements Action {
  const _Action({@JsonKey(name: 'walletRpc') required this.walletRpc});
  factory _Action.fromJson(Map<String, dynamic> json) => _$ActionFromJson(json);

@override@JsonKey(name: 'walletRpc') final  WalletRpcAction walletRpc;

/// Create a copy of Action
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActionCopyWith<_Action> get copyWith => __$ActionCopyWithImpl<_Action>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Action&&(identical(other.walletRpc, walletRpc) || other.walletRpc == walletRpc));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,walletRpc);

@override
String toString() {
  return 'Action(walletRpc: $walletRpc)';
}


}

/// @nodoc
abstract mixin class _$ActionCopyWith<$Res> implements $ActionCopyWith<$Res> {
  factory _$ActionCopyWith(_Action value, $Res Function(_Action) _then) = __$ActionCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'walletRpc') WalletRpcAction walletRpc
});


@override $WalletRpcActionCopyWith<$Res> get walletRpc;

}
/// @nodoc
class __$ActionCopyWithImpl<$Res>
    implements _$ActionCopyWith<$Res> {
  __$ActionCopyWithImpl(this._self, this._then);

  final _Action _self;
  final $Res Function(_Action) _then;

/// Create a copy of Action
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? walletRpc = null,}) {
  return _then(_Action(
walletRpc: null == walletRpc ? _self.walletRpc : walletRpc // ignore: cast_nullable_to_non_nullable
as WalletRpcAction,
  ));
}

/// Create a copy of Action
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WalletRpcActionCopyWith<$Res> get walletRpc {
  
  return $WalletRpcActionCopyWith<$Res>(_self.walletRpc, (value) {
    return _then(_self.copyWith(walletRpc: value));
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

 String get assetSymbol; String get assetName; int get decimals; String? get iconUrl; String? get networkName; String? get networkIconUrl;
/// Create a copy of AmountDisplay
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AmountDisplayCopyWith<AmountDisplay> get copyWith => _$AmountDisplayCopyWithImpl<AmountDisplay>(this as AmountDisplay, _$identity);

  /// Serializes this AmountDisplay to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AmountDisplay&&(identical(other.assetSymbol, assetSymbol) || other.assetSymbol == assetSymbol)&&(identical(other.assetName, assetName) || other.assetName == assetName)&&(identical(other.decimals, decimals) || other.decimals == decimals)&&(identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl)&&(identical(other.networkName, networkName) || other.networkName == networkName)&&(identical(other.networkIconUrl, networkIconUrl) || other.networkIconUrl == networkIconUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,assetSymbol,assetName,decimals,iconUrl,networkName,networkIconUrl);

@override
String toString() {
  return 'AmountDisplay(assetSymbol: $assetSymbol, assetName: $assetName, decimals: $decimals, iconUrl: $iconUrl, networkName: $networkName, networkIconUrl: $networkIconUrl)';
}


}

/// @nodoc
abstract mixin class $AmountDisplayCopyWith<$Res>  {
  factory $AmountDisplayCopyWith(AmountDisplay value, $Res Function(AmountDisplay) _then) = _$AmountDisplayCopyWithImpl;
@useResult
$Res call({
 String assetSymbol, String assetName, int decimals, String? iconUrl, String? networkName, String? networkIconUrl
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
@pragma('vm:prefer-inline') @override $Res call({Object? assetSymbol = null,Object? assetName = null,Object? decimals = null,Object? iconUrl = freezed,Object? networkName = freezed,Object? networkIconUrl = freezed,}) {
  return _then(_self.copyWith(
assetSymbol: null == assetSymbol ? _self.assetSymbol : assetSymbol // ignore: cast_nullable_to_non_nullable
as String,assetName: null == assetName ? _self.assetName : assetName // ignore: cast_nullable_to_non_nullable
as String,decimals: null == decimals ? _self.decimals : decimals // ignore: cast_nullable_to_non_nullable
as int,iconUrl: freezed == iconUrl ? _self.iconUrl : iconUrl // ignore: cast_nullable_to_non_nullable
as String?,networkName: freezed == networkName ? _self.networkName : networkName // ignore: cast_nullable_to_non_nullable
as String?,networkIconUrl: freezed == networkIconUrl ? _self.networkIconUrl : networkIconUrl // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String assetSymbol,  String assetName,  int decimals,  String? iconUrl,  String? networkName,  String? networkIconUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AmountDisplay() when $default != null:
return $default(_that.assetSymbol,_that.assetName,_that.decimals,_that.iconUrl,_that.networkName,_that.networkIconUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String assetSymbol,  String assetName,  int decimals,  String? iconUrl,  String? networkName,  String? networkIconUrl)  $default,) {final _that = this;
switch (_that) {
case _AmountDisplay():
return $default(_that.assetSymbol,_that.assetName,_that.decimals,_that.iconUrl,_that.networkName,_that.networkIconUrl);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String assetSymbol,  String assetName,  int decimals,  String? iconUrl,  String? networkName,  String? networkIconUrl)?  $default,) {final _that = this;
switch (_that) {
case _AmountDisplay() when $default != null:
return $default(_that.assetSymbol,_that.assetName,_that.decimals,_that.iconUrl,_that.networkName,_that.networkIconUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AmountDisplay implements AmountDisplay {
  const _AmountDisplay({required this.assetSymbol, required this.assetName, required this.decimals, this.iconUrl, this.networkName, this.networkIconUrl});
  factory _AmountDisplay.fromJson(Map<String, dynamic> json) => _$AmountDisplayFromJson(json);

@override final  String assetSymbol;
@override final  String assetName;
@override final  int decimals;
@override final  String? iconUrl;
@override final  String? networkName;
@override final  String? networkIconUrl;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AmountDisplay&&(identical(other.assetSymbol, assetSymbol) || other.assetSymbol == assetSymbol)&&(identical(other.assetName, assetName) || other.assetName == assetName)&&(identical(other.decimals, decimals) || other.decimals == decimals)&&(identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl)&&(identical(other.networkName, networkName) || other.networkName == networkName)&&(identical(other.networkIconUrl, networkIconUrl) || other.networkIconUrl == networkIconUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,assetSymbol,assetName,decimals,iconUrl,networkName,networkIconUrl);

@override
String toString() {
  return 'AmountDisplay(assetSymbol: $assetSymbol, assetName: $assetName, decimals: $decimals, iconUrl: $iconUrl, networkName: $networkName, networkIconUrl: $networkIconUrl)';
}


}

/// @nodoc
abstract mixin class _$AmountDisplayCopyWith<$Res> implements $AmountDisplayCopyWith<$Res> {
  factory _$AmountDisplayCopyWith(_AmountDisplay value, $Res Function(_AmountDisplay) _then) = __$AmountDisplayCopyWithImpl;
@override @useResult
$Res call({
 String assetSymbol, String assetName, int decimals, String? iconUrl, String? networkName, String? networkIconUrl
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
@override @pragma('vm:prefer-inline') $Res call({Object? assetSymbol = null,Object? assetName = null,Object? decimals = null,Object? iconUrl = freezed,Object? networkName = freezed,Object? networkIconUrl = freezed,}) {
  return _then(_AmountDisplay(
assetSymbol: null == assetSymbol ? _self.assetSymbol : assetSymbol // ignore: cast_nullable_to_non_nullable
as String,assetName: null == assetName ? _self.assetName : assetName // ignore: cast_nullable_to_non_nullable
as String,decimals: null == decimals ? _self.decimals : decimals // ignore: cast_nullable_to_non_nullable
as int,iconUrl: freezed == iconUrl ? _self.iconUrl : iconUrl // ignore: cast_nullable_to_non_nullable
as String?,networkName: freezed == networkName ? _self.networkName : networkName // ignore: cast_nullable_to_non_nullable
as String?,networkIconUrl: freezed == networkIconUrl ? _self.networkIconUrl : networkIconUrl // ignore: cast_nullable_to_non_nullable
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
mixin _$ConfirmPaymentRequest {

 String get paymentId; String get optionId; List<String> get signatures; List<CollectDataFieldResult>? get collectedData; int? get maxPollMs;
/// Create a copy of ConfirmPaymentRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConfirmPaymentRequestCopyWith<ConfirmPaymentRequest> get copyWith => _$ConfirmPaymentRequestCopyWithImpl<ConfirmPaymentRequest>(this as ConfirmPaymentRequest, _$identity);

  /// Serializes this ConfirmPaymentRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConfirmPaymentRequest&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId)&&(identical(other.optionId, optionId) || other.optionId == optionId)&&const DeepCollectionEquality().equals(other.signatures, signatures)&&const DeepCollectionEquality().equals(other.collectedData, collectedData)&&(identical(other.maxPollMs, maxPollMs) || other.maxPollMs == maxPollMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,paymentId,optionId,const DeepCollectionEquality().hash(signatures),const DeepCollectionEquality().hash(collectedData),maxPollMs);

@override
String toString() {
  return 'ConfirmPaymentRequest(paymentId: $paymentId, optionId: $optionId, signatures: $signatures, collectedData: $collectedData, maxPollMs: $maxPollMs)';
}


}

/// @nodoc
abstract mixin class $ConfirmPaymentRequestCopyWith<$Res>  {
  factory $ConfirmPaymentRequestCopyWith(ConfirmPaymentRequest value, $Res Function(ConfirmPaymentRequest) _then) = _$ConfirmPaymentRequestCopyWithImpl;
@useResult
$Res call({
 String paymentId, String optionId, List<String> signatures, List<CollectDataFieldResult>? collectedData, int? maxPollMs
});




}
/// @nodoc
class _$ConfirmPaymentRequestCopyWithImpl<$Res>
    implements $ConfirmPaymentRequestCopyWith<$Res> {
  _$ConfirmPaymentRequestCopyWithImpl(this._self, this._then);

  final ConfirmPaymentRequest _self;
  final $Res Function(ConfirmPaymentRequest) _then;

/// Create a copy of ConfirmPaymentRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? paymentId = null,Object? optionId = null,Object? signatures = null,Object? collectedData = freezed,Object? maxPollMs = freezed,}) {
  return _then(_self.copyWith(
paymentId: null == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as String,optionId: null == optionId ? _self.optionId : optionId // ignore: cast_nullable_to_non_nullable
as String,signatures: null == signatures ? _self.signatures : signatures // ignore: cast_nullable_to_non_nullable
as List<String>,collectedData: freezed == collectedData ? _self.collectedData : collectedData // ignore: cast_nullable_to_non_nullable
as List<CollectDataFieldResult>?,maxPollMs: freezed == maxPollMs ? _self.maxPollMs : maxPollMs // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ConfirmPaymentRequest].
extension ConfirmPaymentRequestPatterns on ConfirmPaymentRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConfirmPaymentRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConfirmPaymentRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConfirmPaymentRequest value)  $default,){
final _that = this;
switch (_that) {
case _ConfirmPaymentRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConfirmPaymentRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ConfirmPaymentRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String paymentId,  String optionId,  List<String> signatures,  List<CollectDataFieldResult>? collectedData,  int? maxPollMs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConfirmPaymentRequest() when $default != null:
return $default(_that.paymentId,_that.optionId,_that.signatures,_that.collectedData,_that.maxPollMs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String paymentId,  String optionId,  List<String> signatures,  List<CollectDataFieldResult>? collectedData,  int? maxPollMs)  $default,) {final _that = this;
switch (_that) {
case _ConfirmPaymentRequest():
return $default(_that.paymentId,_that.optionId,_that.signatures,_that.collectedData,_that.maxPollMs);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String paymentId,  String optionId,  List<String> signatures,  List<CollectDataFieldResult>? collectedData,  int? maxPollMs)?  $default,) {final _that = this;
switch (_that) {
case _ConfirmPaymentRequest() when $default != null:
return $default(_that.paymentId,_that.optionId,_that.signatures,_that.collectedData,_that.maxPollMs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConfirmPaymentRequest implements ConfirmPaymentRequest {
  const _ConfirmPaymentRequest({required this.paymentId, required this.optionId, required final  List<String> signatures, final  List<CollectDataFieldResult>? collectedData, this.maxPollMs}): _signatures = signatures,_collectedData = collectedData;
  factory _ConfirmPaymentRequest.fromJson(Map<String, dynamic> json) => _$ConfirmPaymentRequestFromJson(json);

@override final  String paymentId;
@override final  String optionId;
 final  List<String> _signatures;
@override List<String> get signatures {
  if (_signatures is EqualUnmodifiableListView) return _signatures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_signatures);
}

 final  List<CollectDataFieldResult>? _collectedData;
@override List<CollectDataFieldResult>? get collectedData {
  final value = _collectedData;
  if (value == null) return null;
  if (_collectedData is EqualUnmodifiableListView) return _collectedData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  int? maxPollMs;

/// Create a copy of ConfirmPaymentRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConfirmPaymentRequestCopyWith<_ConfirmPaymentRequest> get copyWith => __$ConfirmPaymentRequestCopyWithImpl<_ConfirmPaymentRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConfirmPaymentRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConfirmPaymentRequest&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId)&&(identical(other.optionId, optionId) || other.optionId == optionId)&&const DeepCollectionEquality().equals(other._signatures, _signatures)&&const DeepCollectionEquality().equals(other._collectedData, _collectedData)&&(identical(other.maxPollMs, maxPollMs) || other.maxPollMs == maxPollMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,paymentId,optionId,const DeepCollectionEquality().hash(_signatures),const DeepCollectionEquality().hash(_collectedData),maxPollMs);

@override
String toString() {
  return 'ConfirmPaymentRequest(paymentId: $paymentId, optionId: $optionId, signatures: $signatures, collectedData: $collectedData, maxPollMs: $maxPollMs)';
}


}

/// @nodoc
abstract mixin class _$ConfirmPaymentRequestCopyWith<$Res> implements $ConfirmPaymentRequestCopyWith<$Res> {
  factory _$ConfirmPaymentRequestCopyWith(_ConfirmPaymentRequest value, $Res Function(_ConfirmPaymentRequest) _then) = __$ConfirmPaymentRequestCopyWithImpl;
@override @useResult
$Res call({
 String paymentId, String optionId, List<String> signatures, List<CollectDataFieldResult>? collectedData, int? maxPollMs
});




}
/// @nodoc
class __$ConfirmPaymentRequestCopyWithImpl<$Res>
    implements _$ConfirmPaymentRequestCopyWith<$Res> {
  __$ConfirmPaymentRequestCopyWithImpl(this._self, this._then);

  final _ConfirmPaymentRequest _self;
  final $Res Function(_ConfirmPaymentRequest) _then;

/// Create a copy of ConfirmPaymentRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? paymentId = null,Object? optionId = null,Object? signatures = null,Object? collectedData = freezed,Object? maxPollMs = freezed,}) {
  return _then(_ConfirmPaymentRequest(
paymentId: null == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as String,optionId: null == optionId ? _self.optionId : optionId // ignore: cast_nullable_to_non_nullable
as String,signatures: null == signatures ? _self._signatures : signatures // ignore: cast_nullable_to_non_nullable
as List<String>,collectedData: freezed == collectedData ? _self._collectedData : collectedData // ignore: cast_nullable_to_non_nullable
as List<CollectDataFieldResult>?,maxPollMs: freezed == maxPollMs ? _self.maxPollMs : maxPollMs // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$CollectDataFieldResult {

 String get id; String get value;
/// Create a copy of CollectDataFieldResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CollectDataFieldResultCopyWith<CollectDataFieldResult> get copyWith => _$CollectDataFieldResultCopyWithImpl<CollectDataFieldResult>(this as CollectDataFieldResult, _$identity);

  /// Serializes this CollectDataFieldResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CollectDataFieldResult&&(identical(other.id, id) || other.id == id)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,value);

@override
String toString() {
  return 'CollectDataFieldResult(id: $id, value: $value)';
}


}

/// @nodoc
abstract mixin class $CollectDataFieldResultCopyWith<$Res>  {
  factory $CollectDataFieldResultCopyWith(CollectDataFieldResult value, $Res Function(CollectDataFieldResult) _then) = _$CollectDataFieldResultCopyWithImpl;
@useResult
$Res call({
 String id, String value
});




}
/// @nodoc
class _$CollectDataFieldResultCopyWithImpl<$Res>
    implements $CollectDataFieldResultCopyWith<$Res> {
  _$CollectDataFieldResultCopyWithImpl(this._self, this._then);

  final CollectDataFieldResult _self;
  final $Res Function(CollectDataFieldResult) _then;

/// Create a copy of CollectDataFieldResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? value = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CollectDataFieldResult].
extension CollectDataFieldResultPatterns on CollectDataFieldResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CollectDataFieldResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CollectDataFieldResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CollectDataFieldResult value)  $default,){
final _that = this;
switch (_that) {
case _CollectDataFieldResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CollectDataFieldResult value)?  $default,){
final _that = this;
switch (_that) {
case _CollectDataFieldResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CollectDataFieldResult() when $default != null:
return $default(_that.id,_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String value)  $default,) {final _that = this;
switch (_that) {
case _CollectDataFieldResult():
return $default(_that.id,_that.value);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String value)?  $default,) {final _that = this;
switch (_that) {
case _CollectDataFieldResult() when $default != null:
return $default(_that.id,_that.value);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CollectDataFieldResult implements CollectDataFieldResult {
  const _CollectDataFieldResult({required this.id, required this.value});
  factory _CollectDataFieldResult.fromJson(Map<String, dynamic> json) => _$CollectDataFieldResultFromJson(json);

@override final  String id;
@override final  String value;

/// Create a copy of CollectDataFieldResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CollectDataFieldResultCopyWith<_CollectDataFieldResult> get copyWith => __$CollectDataFieldResultCopyWithImpl<_CollectDataFieldResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CollectDataFieldResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CollectDataFieldResult&&(identical(other.id, id) || other.id == id)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,value);

@override
String toString() {
  return 'CollectDataFieldResult(id: $id, value: $value)';
}


}

/// @nodoc
abstract mixin class _$CollectDataFieldResultCopyWith<$Res> implements $CollectDataFieldResultCopyWith<$Res> {
  factory _$CollectDataFieldResultCopyWith(_CollectDataFieldResult value, $Res Function(_CollectDataFieldResult) _then) = __$CollectDataFieldResultCopyWithImpl;
@override @useResult
$Res call({
 String id, String value
});




}
/// @nodoc
class __$CollectDataFieldResultCopyWithImpl<$Res>
    implements _$CollectDataFieldResultCopyWith<$Res> {
  __$CollectDataFieldResultCopyWithImpl(this._self, this._then);

  final _CollectDataFieldResult _self;
  final $Res Function(_CollectDataFieldResult) _then;

/// Create a copy of CollectDataFieldResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? value = null,}) {
  return _then(_CollectDataFieldResult(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
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
