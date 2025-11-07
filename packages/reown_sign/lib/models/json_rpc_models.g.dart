// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_rpc_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WcPairingDeleteRequest _$WcPairingDeleteRequestFromJson(
  Map<String, dynamic> json,
) => _WcPairingDeleteRequest(
  code: (json['code'] as num).toInt(),
  message: json['message'] as String,
);

Map<String, dynamic> _$WcPairingDeleteRequestToJson(
  _WcPairingDeleteRequest instance,
) => <String, dynamic>{'code': instance.code, 'message': instance.message};

_WcPairingPingRequest _$WcPairingPingRequestFromJson(
  Map<String, dynamic> json,
) => _WcPairingPingRequest(data: json['data'] as Map<String, dynamic>);

Map<String, dynamic> _$WcPairingPingRequestToJson(
  _WcPairingPingRequest instance,
) => <String, dynamic>{'data': instance.data};

_WcSessionProposeRequest _$WcSessionProposeRequestFromJson(
  Map<String, dynamic> json,
) => _WcSessionProposeRequest(
  relays: (json['relays'] as List<dynamic>)
      .map((e) => Relay.fromJson(e as Map<String, dynamic>))
      .toList(),
  requiredNamespaces: (json['requiredNamespaces'] as Map<String, dynamic>).map(
    (k, e) =>
        MapEntry(k, RequiredNamespace.fromJson(e as Map<String, dynamic>)),
  ),
  optionalNamespaces: (json['optionalNamespaces'] as Map<String, dynamic>?)
      ?.map(
        (k, e) =>
            MapEntry(k, RequiredNamespace.fromJson(e as Map<String, dynamic>)),
      ),
  sessionProperties: (json['sessionProperties'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as String),
  ),
  proposer: ConnectionMetadata.fromJson(
    json['proposer'] as Map<String, dynamic>,
  ),
  requests: json['requests'] == null
      ? null
      : ProposalRequests.fromJson(json['requests'] as Map<String, dynamic>),
);

Map<String, dynamic> _$WcSessionProposeRequestToJson(
  _WcSessionProposeRequest instance,
) => <String, dynamic>{
  'relays': instance.relays.map((e) => e.toJson()).toList(),
  'requiredNamespaces': instance.requiredNamespaces.map(
    (k, e) => MapEntry(k, e.toJson()),
  ),
  'optionalNamespaces': ?instance.optionalNamespaces?.map(
    (k, e) => MapEntry(k, e.toJson()),
  ),
  'sessionProperties': ?instance.sessionProperties,
  'proposer': instance.proposer.toJson(),
  'requests': ?instance.requests?.toJson(),
};

_WcSessionSettleRequest _$WcSessionSettleRequestFromJson(
  Map<String, dynamic> json,
) => _WcSessionSettleRequest(
  relay: Relay.fromJson(json['relay'] as Map<String, dynamic>),
  namespaces: (json['namespaces'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(k, Namespace.fromJson(e as Map<String, dynamic>)),
  ),
  expiry: (json['expiry'] as num).toInt(),
  controller: ConnectionMetadata.fromJson(
    json['controller'] as Map<String, dynamic>,
  ),
  requiredNamespaces: (json['requiredNamespaces'] as Map<String, dynamic>?)
      ?.map(
        (k, e) =>
            MapEntry(k, RequiredNamespace.fromJson(e as Map<String, dynamic>)),
      ),
  optionalNamespaces: (json['optionalNamespaces'] as Map<String, dynamic>?)
      ?.map(
        (k, e) =>
            MapEntry(k, RequiredNamespace.fromJson(e as Map<String, dynamic>)),
      ),
  sessionProperties: (json['sessionProperties'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as String),
  ),
  proposalRequestsResponses: json['proposalRequestsResponses'] == null
      ? null
      : ProposalRequestsResponses.fromJson(
          json['proposalRequestsResponses'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$WcSessionSettleRequestToJson(
  _WcSessionSettleRequest instance,
) => <String, dynamic>{
  'relay': instance.relay.toJson(),
  'namespaces': instance.namespaces.map((k, e) => MapEntry(k, e.toJson())),
  'expiry': instance.expiry,
  'controller': instance.controller.toJson(),
  'requiredNamespaces': ?instance.requiredNamespaces?.map(
    (k, e) => MapEntry(k, e.toJson()),
  ),
  'optionalNamespaces': ?instance.optionalNamespaces?.map(
    (k, e) => MapEntry(k, e.toJson()),
  ),
  'sessionProperties': ?instance.sessionProperties,
  'proposalRequestsResponses': ?instance.proposalRequestsResponses?.toJson(),
};

_WcSessionProposeResponse _$WcSessionProposeResponseFromJson(
  Map<String, dynamic> json,
) => _WcSessionProposeResponse(
  relay: Relay.fromJson(json['relay'] as Map<String, dynamic>),
  responderPublicKey: json['responderPublicKey'] as String,
);

Map<String, dynamic> _$WcSessionProposeResponseToJson(
  _WcSessionProposeResponse instance,
) => <String, dynamic>{
  'relay': instance.relay.toJson(),
  'responderPublicKey': instance.responderPublicKey,
};

_WcSessionUpdateRequest _$WcSessionUpdateRequestFromJson(
  Map<String, dynamic> json,
) => _WcSessionUpdateRequest(
  namespaces: (json['namespaces'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(k, Namespace.fromJson(e as Map<String, dynamic>)),
  ),
);

Map<String, dynamic> _$WcSessionUpdateRequestToJson(
  _WcSessionUpdateRequest instance,
) => <String, dynamic>{
  'namespaces': instance.namespaces.map((k, e) => MapEntry(k, e.toJson())),
};

_WcSessionExtendRequest _$WcSessionExtendRequestFromJson(
  Map<String, dynamic> json,
) => _WcSessionExtendRequest(data: json['data'] as Map<String, dynamic>?);

Map<String, dynamic> _$WcSessionExtendRequestToJson(
  _WcSessionExtendRequest instance,
) => <String, dynamic>{'data': ?instance.data};

_WcSessionDeleteRequest _$WcSessionDeleteRequestFromJson(
  Map<String, dynamic> json,
) => _WcSessionDeleteRequest(
  code: (json['code'] as num).toInt(),
  message: json['message'] as String,
  data: json['data'] as String?,
);

Map<String, dynamic> _$WcSessionDeleteRequestToJson(
  _WcSessionDeleteRequest instance,
) => <String, dynamic>{
  'code': instance.code,
  'message': instance.message,
  'data': ?instance.data,
};

_WcSessionPingRequest _$WcSessionPingRequestFromJson(
  Map<String, dynamic> json,
) => _WcSessionPingRequest(data: json['data'] as Map<String, dynamic>?);

Map<String, dynamic> _$WcSessionPingRequestToJson(
  _WcSessionPingRequest instance,
) => <String, dynamic>{'data': ?instance.data};

_WcSessionRequestRequest _$WcSessionRequestRequestFromJson(
  Map<String, dynamic> json,
) => _WcSessionRequestRequest(
  chainId: json['chainId'] as String,
  request: SessionRequestParams.fromJson(
    json['request'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$WcSessionRequestRequestToJson(
  _WcSessionRequestRequest instance,
) => <String, dynamic>{
  'chainId': instance.chainId,
  'request': instance.request.toJson(),
};

_WcSessionEventRequest _$WcSessionEventRequestFromJson(
  Map<String, dynamic> json,
) => _WcSessionEventRequest(
  chainId: json['chainId'] as String,
  event: SessionEventParams.fromJson(json['event'] as Map<String, dynamic>),
);

Map<String, dynamic> _$WcSessionEventRequestToJson(
  _WcSessionEventRequest instance,
) => <String, dynamic>{
  'chainId': instance.chainId,
  'event': instance.event.toJson(),
};

_WcSessionAuthRequestParams _$WcSessionAuthRequestParamsFromJson(
  Map<String, dynamic> json,
) => _WcSessionAuthRequestParams(
  authPayload: SessionAuthPayload.fromJson(
    json['authPayload'] as Map<String, dynamic>,
  ),
  requester: ConnectionMetadata.fromJson(
    json['requester'] as Map<String, dynamic>,
  ),
  expiryTimestamp: (json['expiryTimestamp'] as num).toInt(),
);

Map<String, dynamic> _$WcSessionAuthRequestParamsToJson(
  _WcSessionAuthRequestParams instance,
) => <String, dynamic>{
  'authPayload': instance.authPayload.toJson(),
  'requester': instance.requester.toJson(),
  'expiryTimestamp': instance.expiryTimestamp,
};

_WcSessionAuthRequestResult _$WcSessionAuthRequestResultFromJson(
  Map<String, dynamic> json,
) => _WcSessionAuthRequestResult(
  cacaos: (json['cacaos'] as List<dynamic>)
      .map((e) => Cacao.fromJson(e as Map<String, dynamic>))
      .toList(),
  responder: ConnectionMetadata.fromJson(
    json['responder'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$WcSessionAuthRequestResultToJson(
  _WcSessionAuthRequestResult instance,
) => <String, dynamic>{
  'cacaos': instance.cacaos.map((e) => e.toJson()).toList(),
  'responder': instance.responder.toJson(),
};
