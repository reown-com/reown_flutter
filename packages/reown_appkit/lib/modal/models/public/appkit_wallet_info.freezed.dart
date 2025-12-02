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


$AppKitModalWalletListingCopyWith<$Res> get listing;

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
/// Create a copy of ReownAppKitModalWalletInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppKitModalWalletListingCopyWith<$Res> get listing {
  
  return $AppKitModalWalletListingCopyWith<$Res>(_self.listing, (value) {
    return _then(_self.copyWith(listing: value));
  });
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


@override $AppKitModalWalletListingCopyWith<$Res> get listing;

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

/// Create a copy of ReownAppKitModalWalletInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppKitModalWalletListingCopyWith<$Res> get listing {
  
  return $AppKitModalWalletListingCopyWith<$Res>(_self.listing, (value) {
    return _then(_self.copyWith(listing: value));
  });
}
}


/// @nodoc
mixin _$AppKitModalWalletListing {

 String get id; String get name; String get homepage;@JsonKey(name: 'image_id') String get imageId; int get order;@JsonKey(name: 'mobile_link') String? get mobileLink;@JsonKey(name: 'desktop_link') String? get desktopLink;@JsonKey(name: 'link_mode') String? get linkMode;@JsonKey(name: 'webapp_link') String? get webappLink;@JsonKey(name: 'app_store') String? get appStore;@JsonKey(name: 'play_store') String? get playStore; String? get rdns;@JsonKey(name: 'chrome_store') String? get chromeStore; List<Injected>? get injected; List<String>? get chains; List<String>? get categories; String? get description;@JsonKey(name: 'badge_type') String? get badgeType;@JsonKey(name: 'supports_wc') bool? get supportsWc;@JsonKey(name: 'is_top_wallet') bool? get isTopWallet;
/// Create a copy of AppKitModalWalletListing
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppKitModalWalletListingCopyWith<AppKitModalWalletListing> get copyWith => _$AppKitModalWalletListingCopyWithImpl<AppKitModalWalletListing>(this as AppKitModalWalletListing, _$identity);

  /// Serializes this AppKitModalWalletListing to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppKitModalWalletListing&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.homepage, homepage) || other.homepage == homepage)&&(identical(other.imageId, imageId) || other.imageId == imageId)&&(identical(other.order, order) || other.order == order)&&(identical(other.mobileLink, mobileLink) || other.mobileLink == mobileLink)&&(identical(other.desktopLink, desktopLink) || other.desktopLink == desktopLink)&&(identical(other.linkMode, linkMode) || other.linkMode == linkMode)&&(identical(other.webappLink, webappLink) || other.webappLink == webappLink)&&(identical(other.appStore, appStore) || other.appStore == appStore)&&(identical(other.playStore, playStore) || other.playStore == playStore)&&(identical(other.rdns, rdns) || other.rdns == rdns)&&(identical(other.chromeStore, chromeStore) || other.chromeStore == chromeStore)&&const DeepCollectionEquality().equals(other.injected, injected)&&const DeepCollectionEquality().equals(other.chains, chains)&&const DeepCollectionEquality().equals(other.categories, categories)&&(identical(other.description, description) || other.description == description)&&(identical(other.badgeType, badgeType) || other.badgeType == badgeType)&&(identical(other.supportsWc, supportsWc) || other.supportsWc == supportsWc)&&(identical(other.isTopWallet, isTopWallet) || other.isTopWallet == isTopWallet));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,homepage,imageId,order,mobileLink,desktopLink,linkMode,webappLink,appStore,playStore,rdns,chromeStore,const DeepCollectionEquality().hash(injected),const DeepCollectionEquality().hash(chains),const DeepCollectionEquality().hash(categories),description,badgeType,supportsWc,isTopWallet]);

@override
String toString() {
  return 'AppKitModalWalletListing(id: $id, name: $name, homepage: $homepage, imageId: $imageId, order: $order, mobileLink: $mobileLink, desktopLink: $desktopLink, linkMode: $linkMode, webappLink: $webappLink, appStore: $appStore, playStore: $playStore, rdns: $rdns, chromeStore: $chromeStore, injected: $injected, chains: $chains, categories: $categories, description: $description, badgeType: $badgeType, supportsWc: $supportsWc, isTopWallet: $isTopWallet)';
}


}

/// @nodoc
abstract mixin class $AppKitModalWalletListingCopyWith<$Res>  {
  factory $AppKitModalWalletListingCopyWith(AppKitModalWalletListing value, $Res Function(AppKitModalWalletListing) _then) = _$AppKitModalWalletListingCopyWithImpl;
@useResult
$Res call({
 String id, String name, String homepage,@JsonKey(name: 'image_id') String imageId, int order,@JsonKey(name: 'mobile_link') String? mobileLink,@JsonKey(name: 'desktop_link') String? desktopLink,@JsonKey(name: 'link_mode') String? linkMode,@JsonKey(name: 'webapp_link') String? webappLink,@JsonKey(name: 'app_store') String? appStore,@JsonKey(name: 'play_store') String? playStore, String? rdns,@JsonKey(name: 'chrome_store') String? chromeStore, List<Injected>? injected, List<String>? chains, List<String>? categories, String? description,@JsonKey(name: 'badge_type') String? badgeType,@JsonKey(name: 'supports_wc') bool? supportsWc,@JsonKey(name: 'is_top_wallet') bool? isTopWallet
});




}
/// @nodoc
class _$AppKitModalWalletListingCopyWithImpl<$Res>
    implements $AppKitModalWalletListingCopyWith<$Res> {
  _$AppKitModalWalletListingCopyWithImpl(this._self, this._then);

  final AppKitModalWalletListing _self;
  final $Res Function(AppKitModalWalletListing) _then;

/// Create a copy of AppKitModalWalletListing
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? homepage = null,Object? imageId = null,Object? order = null,Object? mobileLink = freezed,Object? desktopLink = freezed,Object? linkMode = freezed,Object? webappLink = freezed,Object? appStore = freezed,Object? playStore = freezed,Object? rdns = freezed,Object? chromeStore = freezed,Object? injected = freezed,Object? chains = freezed,Object? categories = freezed,Object? description = freezed,Object? badgeType = freezed,Object? supportsWc = freezed,Object? isTopWallet = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,homepage: null == homepage ? _self.homepage : homepage // ignore: cast_nullable_to_non_nullable
as String,imageId: null == imageId ? _self.imageId : imageId // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,mobileLink: freezed == mobileLink ? _self.mobileLink : mobileLink // ignore: cast_nullable_to_non_nullable
as String?,desktopLink: freezed == desktopLink ? _self.desktopLink : desktopLink // ignore: cast_nullable_to_non_nullable
as String?,linkMode: freezed == linkMode ? _self.linkMode : linkMode // ignore: cast_nullable_to_non_nullable
as String?,webappLink: freezed == webappLink ? _self.webappLink : webappLink // ignore: cast_nullable_to_non_nullable
as String?,appStore: freezed == appStore ? _self.appStore : appStore // ignore: cast_nullable_to_non_nullable
as String?,playStore: freezed == playStore ? _self.playStore : playStore // ignore: cast_nullable_to_non_nullable
as String?,rdns: freezed == rdns ? _self.rdns : rdns // ignore: cast_nullable_to_non_nullable
as String?,chromeStore: freezed == chromeStore ? _self.chromeStore : chromeStore // ignore: cast_nullable_to_non_nullable
as String?,injected: freezed == injected ? _self.injected : injected // ignore: cast_nullable_to_non_nullable
as List<Injected>?,chains: freezed == chains ? _self.chains : chains // ignore: cast_nullable_to_non_nullable
as List<String>?,categories: freezed == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,badgeType: freezed == badgeType ? _self.badgeType : badgeType // ignore: cast_nullable_to_non_nullable
as String?,supportsWc: freezed == supportsWc ? _self.supportsWc : supportsWc // ignore: cast_nullable_to_non_nullable
as bool?,isTopWallet: freezed == isTopWallet ? _self.isTopWallet : isTopWallet // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [AppKitModalWalletListing].
extension AppKitModalWalletListingPatterns on AppKitModalWalletListing {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppKitModalWalletListing value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppKitModalWalletListing() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppKitModalWalletListing value)  $default,){
final _that = this;
switch (_that) {
case _AppKitModalWalletListing():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppKitModalWalletListing value)?  $default,){
final _that = this;
switch (_that) {
case _AppKitModalWalletListing() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String homepage, @JsonKey(name: 'image_id')  String imageId,  int order, @JsonKey(name: 'mobile_link')  String? mobileLink, @JsonKey(name: 'desktop_link')  String? desktopLink, @JsonKey(name: 'link_mode')  String? linkMode, @JsonKey(name: 'webapp_link')  String? webappLink, @JsonKey(name: 'app_store')  String? appStore, @JsonKey(name: 'play_store')  String? playStore,  String? rdns, @JsonKey(name: 'chrome_store')  String? chromeStore,  List<Injected>? injected,  List<String>? chains,  List<String>? categories,  String? description, @JsonKey(name: 'badge_type')  String? badgeType, @JsonKey(name: 'supports_wc')  bool? supportsWc, @JsonKey(name: 'is_top_wallet')  bool? isTopWallet)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppKitModalWalletListing() when $default != null:
return $default(_that.id,_that.name,_that.homepage,_that.imageId,_that.order,_that.mobileLink,_that.desktopLink,_that.linkMode,_that.webappLink,_that.appStore,_that.playStore,_that.rdns,_that.chromeStore,_that.injected,_that.chains,_that.categories,_that.description,_that.badgeType,_that.supportsWc,_that.isTopWallet);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String homepage, @JsonKey(name: 'image_id')  String imageId,  int order, @JsonKey(name: 'mobile_link')  String? mobileLink, @JsonKey(name: 'desktop_link')  String? desktopLink, @JsonKey(name: 'link_mode')  String? linkMode, @JsonKey(name: 'webapp_link')  String? webappLink, @JsonKey(name: 'app_store')  String? appStore, @JsonKey(name: 'play_store')  String? playStore,  String? rdns, @JsonKey(name: 'chrome_store')  String? chromeStore,  List<Injected>? injected,  List<String>? chains,  List<String>? categories,  String? description, @JsonKey(name: 'badge_type')  String? badgeType, @JsonKey(name: 'supports_wc')  bool? supportsWc, @JsonKey(name: 'is_top_wallet')  bool? isTopWallet)  $default,) {final _that = this;
switch (_that) {
case _AppKitModalWalletListing():
return $default(_that.id,_that.name,_that.homepage,_that.imageId,_that.order,_that.mobileLink,_that.desktopLink,_that.linkMode,_that.webappLink,_that.appStore,_that.playStore,_that.rdns,_that.chromeStore,_that.injected,_that.chains,_that.categories,_that.description,_that.badgeType,_that.supportsWc,_that.isTopWallet);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String homepage, @JsonKey(name: 'image_id')  String imageId,  int order, @JsonKey(name: 'mobile_link')  String? mobileLink, @JsonKey(name: 'desktop_link')  String? desktopLink, @JsonKey(name: 'link_mode')  String? linkMode, @JsonKey(name: 'webapp_link')  String? webappLink, @JsonKey(name: 'app_store')  String? appStore, @JsonKey(name: 'play_store')  String? playStore,  String? rdns, @JsonKey(name: 'chrome_store')  String? chromeStore,  List<Injected>? injected,  List<String>? chains,  List<String>? categories,  String? description, @JsonKey(name: 'badge_type')  String? badgeType, @JsonKey(name: 'supports_wc')  bool? supportsWc, @JsonKey(name: 'is_top_wallet')  bool? isTopWallet)?  $default,) {final _that = this;
switch (_that) {
case _AppKitModalWalletListing() when $default != null:
return $default(_that.id,_that.name,_that.homepage,_that.imageId,_that.order,_that.mobileLink,_that.desktopLink,_that.linkMode,_that.webappLink,_that.appStore,_that.playStore,_that.rdns,_that.chromeStore,_that.injected,_that.chains,_that.categories,_that.description,_that.badgeType,_that.supportsWc,_that.isTopWallet);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppKitModalWalletListing implements AppKitModalWalletListing {
  const _AppKitModalWalletListing({required this.id, required this.name, required this.homepage, @JsonKey(name: 'image_id') required this.imageId, required this.order, @JsonKey(name: 'mobile_link') this.mobileLink, @JsonKey(name: 'desktop_link') this.desktopLink, @JsonKey(name: 'link_mode') this.linkMode, @JsonKey(name: 'webapp_link') this.webappLink, @JsonKey(name: 'app_store') this.appStore, @JsonKey(name: 'play_store') this.playStore, this.rdns, @JsonKey(name: 'chrome_store') this.chromeStore, final  List<Injected>? injected, final  List<String>? chains, final  List<String>? categories, this.description, @JsonKey(name: 'badge_type') this.badgeType, @JsonKey(name: 'supports_wc') this.supportsWc, @JsonKey(name: 'is_top_wallet') this.isTopWallet}): _injected = injected,_chains = chains,_categories = categories;
  factory _AppKitModalWalletListing.fromJson(Map<String, dynamic> json) => _$AppKitModalWalletListingFromJson(json);

@override final  String id;
@override final  String name;
@override final  String homepage;
@override@JsonKey(name: 'image_id') final  String imageId;
@override final  int order;
@override@JsonKey(name: 'mobile_link') final  String? mobileLink;
@override@JsonKey(name: 'desktop_link') final  String? desktopLink;
@override@JsonKey(name: 'link_mode') final  String? linkMode;
@override@JsonKey(name: 'webapp_link') final  String? webappLink;
@override@JsonKey(name: 'app_store') final  String? appStore;
@override@JsonKey(name: 'play_store') final  String? playStore;
@override final  String? rdns;
@override@JsonKey(name: 'chrome_store') final  String? chromeStore;
 final  List<Injected>? _injected;
@override List<Injected>? get injected {
  final value = _injected;
  if (value == null) return null;
  if (_injected is EqualUnmodifiableListView) return _injected;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _chains;
@override List<String>? get chains {
  final value = _chains;
  if (value == null) return null;
  if (_chains is EqualUnmodifiableListView) return _chains;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _categories;
@override List<String>? get categories {
  final value = _categories;
  if (value == null) return null;
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? description;
@override@JsonKey(name: 'badge_type') final  String? badgeType;
@override@JsonKey(name: 'supports_wc') final  bool? supportsWc;
@override@JsonKey(name: 'is_top_wallet') final  bool? isTopWallet;

/// Create a copy of AppKitModalWalletListing
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppKitModalWalletListingCopyWith<_AppKitModalWalletListing> get copyWith => __$AppKitModalWalletListingCopyWithImpl<_AppKitModalWalletListing>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppKitModalWalletListingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppKitModalWalletListing&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.homepage, homepage) || other.homepage == homepage)&&(identical(other.imageId, imageId) || other.imageId == imageId)&&(identical(other.order, order) || other.order == order)&&(identical(other.mobileLink, mobileLink) || other.mobileLink == mobileLink)&&(identical(other.desktopLink, desktopLink) || other.desktopLink == desktopLink)&&(identical(other.linkMode, linkMode) || other.linkMode == linkMode)&&(identical(other.webappLink, webappLink) || other.webappLink == webappLink)&&(identical(other.appStore, appStore) || other.appStore == appStore)&&(identical(other.playStore, playStore) || other.playStore == playStore)&&(identical(other.rdns, rdns) || other.rdns == rdns)&&(identical(other.chromeStore, chromeStore) || other.chromeStore == chromeStore)&&const DeepCollectionEquality().equals(other._injected, _injected)&&const DeepCollectionEquality().equals(other._chains, _chains)&&const DeepCollectionEquality().equals(other._categories, _categories)&&(identical(other.description, description) || other.description == description)&&(identical(other.badgeType, badgeType) || other.badgeType == badgeType)&&(identical(other.supportsWc, supportsWc) || other.supportsWc == supportsWc)&&(identical(other.isTopWallet, isTopWallet) || other.isTopWallet == isTopWallet));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,homepage,imageId,order,mobileLink,desktopLink,linkMode,webappLink,appStore,playStore,rdns,chromeStore,const DeepCollectionEquality().hash(_injected),const DeepCollectionEquality().hash(_chains),const DeepCollectionEquality().hash(_categories),description,badgeType,supportsWc,isTopWallet]);

@override
String toString() {
  return 'AppKitModalWalletListing(id: $id, name: $name, homepage: $homepage, imageId: $imageId, order: $order, mobileLink: $mobileLink, desktopLink: $desktopLink, linkMode: $linkMode, webappLink: $webappLink, appStore: $appStore, playStore: $playStore, rdns: $rdns, chromeStore: $chromeStore, injected: $injected, chains: $chains, categories: $categories, description: $description, badgeType: $badgeType, supportsWc: $supportsWc, isTopWallet: $isTopWallet)';
}


}

/// @nodoc
abstract mixin class _$AppKitModalWalletListingCopyWith<$Res> implements $AppKitModalWalletListingCopyWith<$Res> {
  factory _$AppKitModalWalletListingCopyWith(_AppKitModalWalletListing value, $Res Function(_AppKitModalWalletListing) _then) = __$AppKitModalWalletListingCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String homepage,@JsonKey(name: 'image_id') String imageId, int order,@JsonKey(name: 'mobile_link') String? mobileLink,@JsonKey(name: 'desktop_link') String? desktopLink,@JsonKey(name: 'link_mode') String? linkMode,@JsonKey(name: 'webapp_link') String? webappLink,@JsonKey(name: 'app_store') String? appStore,@JsonKey(name: 'play_store') String? playStore, String? rdns,@JsonKey(name: 'chrome_store') String? chromeStore, List<Injected>? injected, List<String>? chains, List<String>? categories, String? description,@JsonKey(name: 'badge_type') String? badgeType,@JsonKey(name: 'supports_wc') bool? supportsWc,@JsonKey(name: 'is_top_wallet') bool? isTopWallet
});




}
/// @nodoc
class __$AppKitModalWalletListingCopyWithImpl<$Res>
    implements _$AppKitModalWalletListingCopyWith<$Res> {
  __$AppKitModalWalletListingCopyWithImpl(this._self, this._then);

  final _AppKitModalWalletListing _self;
  final $Res Function(_AppKitModalWalletListing) _then;

/// Create a copy of AppKitModalWalletListing
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? homepage = null,Object? imageId = null,Object? order = null,Object? mobileLink = freezed,Object? desktopLink = freezed,Object? linkMode = freezed,Object? webappLink = freezed,Object? appStore = freezed,Object? playStore = freezed,Object? rdns = freezed,Object? chromeStore = freezed,Object? injected = freezed,Object? chains = freezed,Object? categories = freezed,Object? description = freezed,Object? badgeType = freezed,Object? supportsWc = freezed,Object? isTopWallet = freezed,}) {
  return _then(_AppKitModalWalletListing(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,homepage: null == homepage ? _self.homepage : homepage // ignore: cast_nullable_to_non_nullable
as String,imageId: null == imageId ? _self.imageId : imageId // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,mobileLink: freezed == mobileLink ? _self.mobileLink : mobileLink // ignore: cast_nullable_to_non_nullable
as String?,desktopLink: freezed == desktopLink ? _self.desktopLink : desktopLink // ignore: cast_nullable_to_non_nullable
as String?,linkMode: freezed == linkMode ? _self.linkMode : linkMode // ignore: cast_nullable_to_non_nullable
as String?,webappLink: freezed == webappLink ? _self.webappLink : webappLink // ignore: cast_nullable_to_non_nullable
as String?,appStore: freezed == appStore ? _self.appStore : appStore // ignore: cast_nullable_to_non_nullable
as String?,playStore: freezed == playStore ? _self.playStore : playStore // ignore: cast_nullable_to_non_nullable
as String?,rdns: freezed == rdns ? _self.rdns : rdns // ignore: cast_nullable_to_non_nullable
as String?,chromeStore: freezed == chromeStore ? _self.chromeStore : chromeStore // ignore: cast_nullable_to_non_nullable
as String?,injected: freezed == injected ? _self._injected : injected // ignore: cast_nullable_to_non_nullable
as List<Injected>?,chains: freezed == chains ? _self._chains : chains // ignore: cast_nullable_to_non_nullable
as List<String>?,categories: freezed == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,badgeType: freezed == badgeType ? _self.badgeType : badgeType // ignore: cast_nullable_to_non_nullable
as String?,supportsWc: freezed == supportsWc ? _self.supportsWc : supportsWc // ignore: cast_nullable_to_non_nullable
as bool?,isTopWallet: freezed == isTopWallet ? _self.isTopWallet : isTopWallet // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}


/// @nodoc
mixin _$Injected {

 String get namespace;@JsonKey(name: 'injected_id') String get injectedId;
/// Create a copy of Injected
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InjectedCopyWith<Injected> get copyWith => _$InjectedCopyWithImpl<Injected>(this as Injected, _$identity);

  /// Serializes this Injected to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Injected&&(identical(other.namespace, namespace) || other.namespace == namespace)&&(identical(other.injectedId, injectedId) || other.injectedId == injectedId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,namespace,injectedId);

@override
String toString() {
  return 'Injected(namespace: $namespace, injectedId: $injectedId)';
}


}

/// @nodoc
abstract mixin class $InjectedCopyWith<$Res>  {
  factory $InjectedCopyWith(Injected value, $Res Function(Injected) _then) = _$InjectedCopyWithImpl;
@useResult
$Res call({
 String namespace,@JsonKey(name: 'injected_id') String injectedId
});




}
/// @nodoc
class _$InjectedCopyWithImpl<$Res>
    implements $InjectedCopyWith<$Res> {
  _$InjectedCopyWithImpl(this._self, this._then);

  final Injected _self;
  final $Res Function(Injected) _then;

/// Create a copy of Injected
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? namespace = null,Object? injectedId = null,}) {
  return _then(_self.copyWith(
namespace: null == namespace ? _self.namespace : namespace // ignore: cast_nullable_to_non_nullable
as String,injectedId: null == injectedId ? _self.injectedId : injectedId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Injected].
extension InjectedPatterns on Injected {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Injected value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Injected() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Injected value)  $default,){
final _that = this;
switch (_that) {
case _Injected():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Injected value)?  $default,){
final _that = this;
switch (_that) {
case _Injected() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String namespace, @JsonKey(name: 'injected_id')  String injectedId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Injected() when $default != null:
return $default(_that.namespace,_that.injectedId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String namespace, @JsonKey(name: 'injected_id')  String injectedId)  $default,) {final _that = this;
switch (_that) {
case _Injected():
return $default(_that.namespace,_that.injectedId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String namespace, @JsonKey(name: 'injected_id')  String injectedId)?  $default,) {final _that = this;
switch (_that) {
case _Injected() when $default != null:
return $default(_that.namespace,_that.injectedId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Injected implements Injected {
  const _Injected({required this.namespace, @JsonKey(name: 'injected_id') required this.injectedId});
  factory _Injected.fromJson(Map<String, dynamic> json) => _$InjectedFromJson(json);

@override final  String namespace;
@override@JsonKey(name: 'injected_id') final  String injectedId;

/// Create a copy of Injected
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InjectedCopyWith<_Injected> get copyWith => __$InjectedCopyWithImpl<_Injected>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InjectedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Injected&&(identical(other.namespace, namespace) || other.namespace == namespace)&&(identical(other.injectedId, injectedId) || other.injectedId == injectedId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,namespace,injectedId);

@override
String toString() {
  return 'Injected(namespace: $namespace, injectedId: $injectedId)';
}


}

/// @nodoc
abstract mixin class _$InjectedCopyWith<$Res> implements $InjectedCopyWith<$Res> {
  factory _$InjectedCopyWith(_Injected value, $Res Function(_Injected) _then) = __$InjectedCopyWithImpl;
@override @useResult
$Res call({
 String namespace,@JsonKey(name: 'injected_id') String injectedId
});




}
/// @nodoc
class __$InjectedCopyWithImpl<$Res>
    implements _$InjectedCopyWith<$Res> {
  __$InjectedCopyWithImpl(this._self, this._then);

  final _Injected _self;
  final $Res Function(_Injected) _then;

/// Create a copy of Injected
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? namespace = null,Object? injectedId = null,}) {
  return _then(_Injected(
namespace: null == namespace ? _self.namespace : namespace // ignore: cast_nullable_to_non_nullable
as String,injectedId: null == injectedId ? _self.injectedId : injectedId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
