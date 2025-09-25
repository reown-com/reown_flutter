// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rust_sign_client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SessionProposalFfi _$SessionProposalFfiFromJson(Map<String, dynamic> json) =>
    _SessionProposalFfi(
      id: json['id'] as String,
      topic: json['topic'] as String,
      pairingSymKey: (json['pairingSymKey'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      proposerPublicKey: (json['proposerPublicKey'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      relays: (json['relays'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      requiredNamespaces: (json['requiredNamespaces'] as Map<String, dynamic>)
          .map((k, e) => MapEntry(k, e as Map<String, dynamic>)),
      optionalNamespaces: (json['optionalNamespaces'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as Map<String, dynamic>)),
      metadata: json['metadata'] as Map<String, dynamic>,
      sessionProperties: (json['sessionProperties'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
      scopedProperties: (json['scopedProperties'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, e as String)),
      expiryTimestamp: (json['expiryTimestamp'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SessionProposalFfiToJson(_SessionProposalFfi instance) =>
    <String, dynamic>{
      'id': instance.id,
      'topic': instance.topic,
      'pairingSymKey': instance.pairingSymKey,
      'proposerPublicKey': instance.proposerPublicKey,
      'relays': instance.relays,
      'requiredNamespaces': instance.requiredNamespaces,
      'optionalNamespaces': instance.optionalNamespaces,
      'metadata': instance.metadata,
      'sessionProperties': instance.sessionProperties,
      'scopedProperties': instance.scopedProperties,
      'expiryTimestamp': instance.expiryTimestamp,
    };

_SettleNamespaceFfi _$SettleNamespaceFfiFromJson(
  Map<String, dynamic> json,
) => _SettleNamespaceFfi(
  accounts: (json['accounts'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  methods: (json['methods'] as List<dynamic>).map((e) => e as String).toList(),
  events: (json['events'] as List<dynamic>).map((e) => e as String).toList(),
  chains: (json['chains'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$SettleNamespaceFfiToJson(_SettleNamespaceFfi instance) =>
    <String, dynamic>{
      'accounts': instance.accounts,
      'methods': instance.methods,
      'events': instance.events,
      'chains': instance.chains,
    };

_MetadataFfi _$MetadataFfiFromJson(Map<String, dynamic> json) => _MetadataFfi(
  name: json['name'] as String,
  description: json['description'] as String,
  url: json['url'] as String? ?? '',
  icons:
      (json['icons'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  verifyUrl: json['verifyUrl'] as String?,
  redirect: json['redirect'] == null
      ? null
      : RedirectFfi.fromJson(json['redirect'] as Map<String, dynamic>),
);

Map<String, dynamic> _$MetadataFfiToJson(_MetadataFfi instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'url': instance.url,
      'icons': instance.icons,
      'verifyUrl': ?instance.verifyUrl,
      'redirect': ?instance.redirect?.toJson(),
    };

_RedirectFfi _$RedirectFfiFromJson(Map<String, dynamic> json) => _RedirectFfi(
  native: json['native'] as String?,
  universal: json['universal'] as String?,
  linkMode: json['linkMode'] as bool? ?? false,
);

Map<String, dynamic> _$RedirectFfiToJson(_RedirectFfi instance) =>
    <String, dynamic>{
      'native': instance.native,
      'universal': instance.universal,
      'linkMode': instance.linkMode,
    };

_ApproveResultFfi _$ApproveResultFfiFromJson(Map<String, dynamic> json) =>
    _ApproveResultFfi(
      sessionSymKey: (json['sessionSymKey'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      selfPublicKey: (json['selfPublicKey'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$ApproveResultFfiToJson(_ApproveResultFfi instance) =>
    <String, dynamic>{
      'sessionSymKey': instance.sessionSymKey,
      'selfPublicKey': instance.selfPublicKey,
    };

_SessionRequestRequestFfi _$SessionRequestRequestFfiFromJson(
  Map<String, dynamic> json,
) => _SessionRequestRequestFfi(
  method: json['method'] as String,
  params: json['params'] as String,
  expiry: (json['expiry'] as num?)?.toInt(),
);

Map<String, dynamic> _$SessionRequestRequestFfiToJson(
  _SessionRequestRequestFfi instance,
) => <String, dynamic>{
  'method': instance.method,
  'params': instance.params,
  'expiry': instance.expiry,
};

_SessionRequestFfi _$SessionRequestFfiFromJson(Map<String, dynamic> json) =>
    _SessionRequestFfi(
      chainId: json['chainId'] as String,
      request: SessionRequestRequestFfi.fromJson(
        json['request'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$SessionRequestFfiToJson(_SessionRequestFfi instance) =>
    <String, dynamic>{
      'chainId': instance.chainId,
      'request': instance.request.toJson(),
    };

_SessionRequestJsonRpcFfi _$SessionRequestJsonRpcFfiFromJson(
  Map<String, dynamic> json,
) => _SessionRequestJsonRpcFfi(
  id: (json['id'] as num).toInt(),
  method: json['method'] as String,
  params: SessionRequestFfi.fromJson(json['params'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SessionRequestJsonRpcFfiToJson(
  _SessionRequestJsonRpcFfi instance,
) => <String, dynamic>{
  'id': instance.id,
  'method': instance.method,
  'params': instance.params.toJson(),
};

_SessionRequestNativeEvent _$SessionRequestNativeEventFromJson(
  Map<String, dynamic> json,
) => _SessionRequestNativeEvent(
  topic: json['topic'] as String,
  sessionRequest: json['sessionRequest'] as String,
);

Map<String, dynamic> _$SessionRequestNativeEventToJson(
  _SessionRequestNativeEvent instance,
) => <String, dynamic>{
  'topic': instance.topic,
  'sessionRequest': instance.sessionRequest,
};

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
  id: (json['id'] as num).toInt(),
  jsonrpc: json['jsonrpc'] as String? ?? '2.0',
  result: json['result'] as String,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
  'id': instance.id,
  'jsonrpc': instance.jsonrpc,
  'result': instance.result,
  'runtimeType': instance.$type,
};

Error _$ErrorFromJson(Map<String, dynamic> json) => Error(
  id: (json['id'] as num).toInt(),
  jsonrpc: json['jsonrpc'] as String? ?? '2.0',
  error: json['error'] as String,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$ErrorToJson(Error instance) => <String, dynamic>{
  'id': instance.id,
  'jsonrpc': instance.jsonrpc,
  'error': instance.error,
  'runtimeType': instance.$type,
};

_ErrorDataFfi _$ErrorDataFfiFromJson(Map<String, dynamic> json) =>
    _ErrorDataFfi(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      data: json['data'] as String?,
    );

Map<String, dynamic> _$ErrorDataFfiToJson(_ErrorDataFfi instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
