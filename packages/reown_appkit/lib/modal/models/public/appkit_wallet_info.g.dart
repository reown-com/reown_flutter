// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appkit_wallet_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReownAppKitModalWalletInfo _$ReownAppKitModalWalletInfoFromJson(
  Map<String, dynamic> json,
) => _ReownAppKitModalWalletInfo(
  listing: AppKitModalWalletListing.fromJson(json['listing']),
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
