// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'w3m_wallet_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppKitWalletInfoImpl _$$AppKitWalletInfoImplFromJson(
        Map<String, dynamic> json) =>
    _$AppKitWalletInfoImpl(
      listing: Listing.fromJson(json['listing']),
      installed: json['installed'] as bool,
      recent: json['recent'] as bool,
    );

Map<String, dynamic> _$$AppKitWalletInfoImplToJson(
        _$AppKitWalletInfoImpl instance) =>
    <String, dynamic>{
      'listing': instance.listing.toJson(),
      'installed': instance.installed,
      'recent': instance.recent,
    };
