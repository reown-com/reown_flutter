// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appkit_wallet_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReownAppKitModalWalletInfoImpl _$$ReownAppKitModalWalletInfoImplFromJson(
        Map<String, dynamic> json) =>
    _$ReownAppKitModalWalletInfoImpl(
      listing: AppKitModalWalletListing.fromJson(json['listing']),
      installed: json['installed'] as bool? ?? false,
      recent: json['recent'] as bool? ?? false,
    );

Map<String, dynamic> _$$ReownAppKitModalWalletInfoImplToJson(
        _$ReownAppKitModalWalletInfoImpl instance) =>
    <String, dynamic>{
      'listing': instance.listing.toJson(),
      'installed': instance.installed,
      'recent': instance.recent,
    };
