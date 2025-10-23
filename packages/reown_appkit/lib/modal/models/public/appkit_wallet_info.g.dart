// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appkit_wallet_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReownAppKitModalWalletInfo _$ReownAppKitModalWalletInfoFromJson(
  Map<String, dynamic> json,
) => _ReownAppKitModalWalletInfo(
  listing: AppKitModalWalletListing.fromJson(
    json['listing'] as Map<String, dynamic>,
  ),
  installed: json['installed'] as bool? ?? false,
  recent: json['recent'] as bool? ?? false,
);

Map<String, dynamic> _$ReownAppKitModalWalletInfoToJson(
  _ReownAppKitModalWalletInfo instance,
) => <String, dynamic>{
  'listing': instance.listing.toJson(),
  'installed': instance.installed,
  'recent': instance.recent,
};

_AppKitModalWalletListing _$AppKitModalWalletListingFromJson(
  Map<String, dynamic> json,
) => _AppKitModalWalletListing(
  id: json['id'] as String,
  name: json['name'] as String,
  homepage: json['homepage'] as String,
  imageId: json['image_id'] as String,
  order: (json['order'] as num).toInt(),
  mobileLink: json['mobile_link'] as String?,
  desktopLink: json['desktop_link'] as String?,
  linkMode: json['link_mode'] as String?,
  webappLink: json['webapp_link'] as String?,
  appStore: json['app_store'] as String?,
  playStore: json['play_store'] as String?,
  rdns: json['rdns'] as String?,
  chromeStore: json['chrome_store'] as String?,
  injected: (json['injected'] as List<dynamic>?)
      ?.map((e) => Injected.fromJson(e as Map<String, dynamic>))
      .toList(),
  chains: (json['chains'] as List<dynamic>?)?.map((e) => e as String).toList(),
  categories: (json['categories'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  description: json['description'] as String?,
  badgeType: json['badge_type'] as String?,
  supportsWc: json['supports_wc'] as bool?,
  isTopWallet: json['is_top_wallet'] as bool?,
);

Map<String, dynamic> _$AppKitModalWalletListingToJson(
  _AppKitModalWalletListing instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'homepage': instance.homepage,
  'image_id': instance.imageId,
  'order': instance.order,
  'mobile_link': instance.mobileLink,
  'desktop_link': instance.desktopLink,
  'link_mode': instance.linkMode,
  'webapp_link': instance.webappLink,
  'app_store': instance.appStore,
  'play_store': instance.playStore,
  'rdns': instance.rdns,
  'chrome_store': instance.chromeStore,
  'injected': instance.injected?.map((e) => e.toJson()).toList(),
  'chains': instance.chains,
  'categories': instance.categories,
  'description': instance.description,
  'badge_type': instance.badgeType,
  'supports_wc': instance.supportsWc,
  'is_top_wallet': instance.isTopWallet,
};

_Injected _$InjectedFromJson(Map<String, dynamic> json) => _Injected(
  namespace: json['namespace'] as String,
  injectedId: json['injected_id'] as String,
);

Map<String, dynamic> _$InjectedToJson(_Injected instance) => <String, dynamic>{
  'namespace': instance.namespace,
  'injected_id': instance.injectedId,
};
