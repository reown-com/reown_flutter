// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appkit_network_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReownAppKitModalNetworkInfoImpl _$$ReownAppKitModalNetworkInfoImplFromJson(
        Map<String, dynamic> json) =>
    _$ReownAppKitModalNetworkInfoImpl(
      name: json['name'] as String,
      chainId: json['chainId'] as String,
      currency: json['currency'] as String,
      rpcUrl: json['rpcUrl'] as String,
      explorerUrl: json['explorerUrl'] as String,
      extraRpcUrls: (json['extraRpcUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      isTestNetwork: json['isTestNetwork'] as bool? ?? false,
      chainIcon: json['chainIcon'] as String?,
    );

Map<String, dynamic> _$$ReownAppKitModalNetworkInfoImplToJson(
        _$ReownAppKitModalNetworkInfoImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'chainId': instance.chainId,
      'currency': instance.currency,
      'rpcUrl': instance.rpcUrl,
      'explorerUrl': instance.explorerUrl,
      'extraRpcUrls': instance.extraRpcUrls,
      'isTestNetwork': instance.isTestNetwork,
      'chainIcon': instance.chainIcon,
    };
