// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CoreEventProperties _$CoreEventPropertiesFromJson(Map<String, dynamic> json) =>
    _CoreEventProperties(
      message: json['message'] as String?,
      name: json['name'] as String?,
      method: json['method'] as String?,
      connected: json['connected'] as bool?,
      namespace: json['namespace'] as String?,
      network: json['network'] as String?,
      caipNetworkId: json['caipNetworkId'] as String?,
      explorerId: json['explorerId'] as String?,
      walletRank: (json['walletRank'] as num?)?.toInt(),
      displayIndex: (json['displayIndex'] as num?)?.toInt(),
      view: json['view'] as String?,
      provider: json['provider'] as String?,
      platform: json['platform'] as String?,
      trace: (json['trace'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      topic: json['topic'] as String?,
      correlation_id: (json['correlation_id'] as num?)?.toInt(),
      client_id: json['client_id'] as String?,
      direction: json['direction'] as String?,
      userAgent: json['userAgent'] as String?,
      sendToken: json['sendToken'] as String?,
      sendAmount: json['sendAmount'] as String?,
      address: json['address'] as String?,
      project_id: json['project_id'] as String?,
      cursor: json['cursor'] as String?,
      exchange: (json['exchange'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      configuration: (json['configuration'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      currentPayment: (json['currentPayment'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      source: json['source'] as String?,
      headless: json['headless'] as bool?,
      reconnect: json['reconnect'] as bool?,
      link: json['link'] as String?,
      linkType: json['linkType'] as String?,
      showWallets: json['showWallets'] as bool?,
      siweConfig: json['siweConfig'] as Map<String, dynamic>?,
      themeMode: json['themeMode'] as String?,
      networks: (json['networks'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      defaultNetwork: json['defaultNetwork'] as String?,
      chainImages: (json['chainImages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$CoreEventPropertiesToJson(
  _CoreEventProperties instance,
) => <String, dynamic>{
  'message': ?instance.message,
  'name': ?instance.name,
  'method': ?instance.method,
  'connected': ?instance.connected,
  'namespace': ?instance.namespace,
  'network': ?instance.network,
  'caipNetworkId': ?instance.caipNetworkId,
  'explorerId': ?instance.explorerId,
  'walletRank': ?instance.walletRank,
  'displayIndex': ?instance.displayIndex,
  'view': ?instance.view,
  'provider': ?instance.provider,
  'platform': ?instance.platform,
  'trace': ?instance.trace,
  'topic': ?instance.topic,
  'correlation_id': ?instance.correlation_id,
  'client_id': ?instance.client_id,
  'direction': ?instance.direction,
  'userAgent': ?instance.userAgent,
  'sendToken': ?instance.sendToken,
  'sendAmount': ?instance.sendAmount,
  'address': ?instance.address,
  'project_id': ?instance.project_id,
  'cursor': ?instance.cursor,
  'exchange': ?instance.exchange,
  'configuration': ?instance.configuration,
  'currentPayment': ?instance.currentPayment,
  'source': ?instance.source,
  'headless': ?instance.headless,
  'reconnect': ?instance.reconnect,
  'link': ?instance.link,
  'linkType': ?instance.linkType,
  'showWallets': ?instance.showWallets,
  'siweConfig': ?instance.siweConfig,
  'themeMode': ?instance.themeMode,
  'networks': ?instance.networks,
  'defaultNetwork': ?instance.defaultNetwork,
  'chainImages': ?instance.chainImages,
  'metadata': ?instance.metadata,
};
