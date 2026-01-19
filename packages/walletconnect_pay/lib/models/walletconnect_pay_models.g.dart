// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'walletconnect_pay_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SdkConfig _$SdkConfigFromJson(Map<String, dynamic> json) => _SdkConfig(
  baseUrl: json['baseUrl'] as String,
  apiKey: json['apiKey'] as String?,
  projectId: json['projectId'] as String?,
  appId: json['appId'] as String?,
  sdkName: json['sdkName'] as String,
  sdkVersion: json['sdkVersion'] as String,
  sdkPlatform: json['sdkPlatform'] as String,
  bundleId: json['bundleId'] as String,
  clientId: json['clientId'] as String?,
);

Map<String, dynamic> _$SdkConfigToJson(_SdkConfig instance) =>
    <String, dynamic>{
      'baseUrl': instance.baseUrl,
      'apiKey': instance.apiKey,
      'projectId': instance.projectId,
      'appId': instance.appId,
      'sdkName': instance.sdkName,
      'sdkVersion': instance.sdkVersion,
      'sdkPlatform': instance.sdkPlatform,
      'bundleId': instance.bundleId,
      'clientId': instance.clientId,
    };

_GetPaymentOptionsRequest _$GetPaymentOptionsRequestFromJson(
  Map<String, dynamic> json,
) => _GetPaymentOptionsRequest(
  paymentLink: json['paymentLink'] as String,
  accounts: (json['accounts'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  includePaymentInfo: json['includePaymentInfo'] as bool? ?? false,
);

Map<String, dynamic> _$GetPaymentOptionsRequestToJson(
  _GetPaymentOptionsRequest instance,
) => <String, dynamic>{
  'paymentLink': instance.paymentLink,
  'accounts': instance.accounts,
  'includePaymentInfo': instance.includePaymentInfo,
};

_PaymentOptionsResponse _$PaymentOptionsResponseFromJson(
  Map<String, dynamic> json,
) => _PaymentOptionsResponse(
  paymentId: json['paymentId'] as String,
  info: json['info'] == null
      ? null
      : PaymentInfo.fromJson(json['info'] as Map<String, dynamic>),
  options: (json['options'] as List<dynamic>)
      .map((e) => PaymentOption.fromJson(e as Map<String, dynamic>))
      .toList(),
  collectData: json['collectData'] == null
      ? null
      : CollectDataAction.fromJson(json['collectData'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PaymentOptionsResponseToJson(
  _PaymentOptionsResponse instance,
) => <String, dynamic>{
  'paymentId': instance.paymentId,
  'info': instance.info?.toJson(),
  'options': instance.options.map((e) => e.toJson()).toList(),
  'collectData': instance.collectData?.toJson(),
};

_PaymentInfo _$PaymentInfoFromJson(Map<String, dynamic> json) => _PaymentInfo(
  status: $enumDecode(_$PaymentStatusEnumMap, json['status']),
  amount: PayAmount.fromJson(json['amount'] as Map<String, dynamic>),
  expiresAt: (json['expiresAt'] as num).toInt(),
  merchant: MerchantInfo.fromJson(json['merchant'] as Map<String, dynamic>),
  buyer: json['buyer'] == null
      ? null
      : BuyerInfo.fromJson(json['buyer'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PaymentInfoToJson(_PaymentInfo instance) =>
    <String, dynamic>{
      'status': _$PaymentStatusEnumMap[instance.status]!,
      'amount': instance.amount.toJson(),
      'expiresAt': instance.expiresAt,
      'merchant': instance.merchant.toJson(),
      'buyer': instance.buyer?.toJson(),
    };

const _$PaymentStatusEnumMap = {
  PaymentStatus.requires_action: 'requires_action',
  PaymentStatus.processing: 'processing',
  PaymentStatus.succeeded: 'succeeded',
  PaymentStatus.failed: 'failed',
  PaymentStatus.expired: 'expired',
};

_MerchantInfo _$MerchantInfoFromJson(Map<String, dynamic> json) =>
    _MerchantInfo(
      name: json['name'] as String,
      iconUrl: json['iconUrl'] as String?,
    );

Map<String, dynamic> _$MerchantInfoToJson(_MerchantInfo instance) =>
    <String, dynamic>{'name': instance.name, 'iconUrl': instance.iconUrl};

_BuyerInfo _$BuyerInfoFromJson(Map<String, dynamic> json) => _BuyerInfo(
  accountCaip10: json['accountCaip10'] as String,
  accountProviderName: json['accountProviderName'] as String,
  accountProviderIcon: json['accountProviderIcon'] as String?,
);

Map<String, dynamic> _$BuyerInfoToJson(_BuyerInfo instance) =>
    <String, dynamic>{
      'accountCaip10': instance.accountCaip10,
      'accountProviderName': instance.accountProviderName,
      'accountProviderIcon': instance.accountProviderIcon,
    };

_CollectDataAction _$CollectDataActionFromJson(Map<String, dynamic> json) =>
    _CollectDataAction(
      fields: (json['fields'] as List<dynamic>)
          .map((e) => CollectDataField.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CollectDataActionToJson(_CollectDataAction instance) =>
    <String, dynamic>{
      'fields': instance.fields.map((e) => e.toJson()).toList(),
    };

_CollectDataField _$CollectDataFieldFromJson(Map<String, dynamic> json) =>
    _CollectDataField(
      id: json['id'] as String,
      name: json['name'] as String,
      required: json['required'] as bool,
      fieldType: $enumDecode(_$CollectDataFieldTypeEnumMap, json['fieldType']),
    );

Map<String, dynamic> _$CollectDataFieldToJson(_CollectDataField instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'required': instance.required,
      'fieldType': _$CollectDataFieldTypeEnumMap[instance.fieldType]!,
    };

const _$CollectDataFieldTypeEnumMap = {
  CollectDataFieldType.text: 'text',
  CollectDataFieldType.date: 'date',
};

_PaymentOption _$PaymentOptionFromJson(Map<String, dynamic> json) =>
    _PaymentOption(
      id: json['id'] as String,
      account: json['account'] as String,
      amount: PayAmount.fromJson(json['amount'] as Map<String, dynamic>),
      etaSeconds: (json['etaS'] as num).toInt(),
      actions: (json['actions'] as List<dynamic>)
          .map((e) => Action.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PaymentOptionToJson(_PaymentOption instance) =>
    <String, dynamic>{
      'id': instance.id,
      'account': instance.account,
      'amount': instance.amount.toJson(),
      'etaS': instance.etaSeconds,
      'actions': instance.actions.map((e) => e.toJson()).toList(),
    };

_Action _$ActionFromJson(Map<String, dynamic> json) => _Action(
  walletRpc: WalletRpcAction.fromJson(
    json['walletRpc'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$ActionToJson(_Action instance) => <String, dynamic>{
  'walletRpc': instance.walletRpc.toJson(),
};

_WalletRpcAction _$WalletRpcActionFromJson(Map<String, dynamic> json) =>
    _WalletRpcAction(
      chainId: json['chainId'] as String,
      method: json['method'] as String,
      params: json['params'] as String,
    );

Map<String, dynamic> _$WalletRpcActionToJson(_WalletRpcAction instance) =>
    <String, dynamic>{
      'chainId': instance.chainId,
      'method': instance.method,
      'params': instance.params,
    };

_PayAmount _$PayAmountFromJson(Map<String, dynamic> json) => _PayAmount(
  unit: json['unit'] as String,
  value: json['value'] as String,
  display: AmountDisplay.fromJson(json['display'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PayAmountToJson(_PayAmount instance) =>
    <String, dynamic>{
      'unit': instance.unit,
      'value': instance.value,
      'display': instance.display.toJson(),
    };

_AmountDisplay _$AmountDisplayFromJson(Map<String, dynamic> json) =>
    _AmountDisplay(
      assetSymbol: json['assetSymbol'] as String,
      assetName: json['assetName'] as String,
      decimals: (json['decimals'] as num).toInt(),
      iconUrl: json['iconUrl'] as String?,
      networkName: json['networkName'] as String?,
      networkIconUrl: json['networkIconUrl'] as String?,
    );

Map<String, dynamic> _$AmountDisplayToJson(_AmountDisplay instance) =>
    <String, dynamic>{
      'assetSymbol': instance.assetSymbol,
      'assetName': instance.assetName,
      'decimals': instance.decimals,
      'iconUrl': instance.iconUrl,
      'networkName': instance.networkName,
      'networkIconUrl': instance.networkIconUrl,
    };

_GetRequiredPaymentActionsRequest _$GetRequiredPaymentActionsRequestFromJson(
  Map<String, dynamic> json,
) => _GetRequiredPaymentActionsRequest(
  optionId: json['optionId'] as String,
  paymentId: json['paymentId'] as String,
);

Map<String, dynamic> _$GetRequiredPaymentActionsRequestToJson(
  _GetRequiredPaymentActionsRequest instance,
) => <String, dynamic>{
  'optionId': instance.optionId,
  'paymentId': instance.paymentId,
};

_ConfirmPaymentRequest _$ConfirmPaymentRequestFromJson(
  Map<String, dynamic> json,
) => _ConfirmPaymentRequest(
  paymentId: json['paymentId'] as String,
  optionId: json['optionId'] as String,
  signatures: (json['signatures'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  collectedData: (json['collectedData'] as List<dynamic>?)
      ?.map((e) => CollectDataFieldResult.fromJson(e as Map<String, dynamic>))
      .toList(),
  maxPollMs: (json['maxPollMs'] as num?)?.toInt(),
);

Map<String, dynamic> _$ConfirmPaymentRequestToJson(
  _ConfirmPaymentRequest instance,
) => <String, dynamic>{
  'paymentId': instance.paymentId,
  'optionId': instance.optionId,
  'signatures': instance.signatures,
  'collectedData': instance.collectedData?.map((e) => e.toJson()).toList(),
  'maxPollMs': instance.maxPollMs,
};

_CollectDataFieldResult _$CollectDataFieldResultFromJson(
  Map<String, dynamic> json,
) => _CollectDataFieldResult(
  id: json['id'] as String,
  value: json['value'] as String,
);

Map<String, dynamic> _$CollectDataFieldResultToJson(
  _CollectDataFieldResult instance,
) => <String, dynamic>{'id': instance.id, 'value': instance.value};

_ConfirmPaymentResponse _$ConfirmPaymentResponseFromJson(
  Map<String, dynamic> json,
) => _ConfirmPaymentResponse(
  status: $enumDecode(_$PaymentStatusEnumMap, json['status']),
  isFinal: json['isFinal'] as bool,
  pollInMs: (json['pollInMs'] as num?)?.toInt(),
);

Map<String, dynamic> _$ConfirmPaymentResponseToJson(
  _ConfirmPaymentResponse instance,
) => <String, dynamic>{
  'status': _$PaymentStatusEnumMap[instance.status]!,
  'isFinal': instance.isFinal,
  'pollInMs': instance.pollInMs,
};
