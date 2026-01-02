// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'walletconnect_pay_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SdkConfig _$SdkConfigFromJson(Map<String, dynamic> json) => _SdkConfig(
  baseUrl: json['baseUrl'] as String,
  apiKey: json['apiKey'] as String,
  sdkName: json['sdkName'] as String,
  sdkVersion: json['sdkVersion'] as String,
  sdkPlatform: json['sdkPlatform'] as String,
);

Map<String, dynamic> _$SdkConfigToJson(_SdkConfig instance) =>
    <String, dynamic>{
      'baseUrl': instance.baseUrl,
      'apiKey': instance.apiKey,
      'sdkName': instance.sdkName,
      'sdkVersion': instance.sdkVersion,
      'sdkPlatform': instance.sdkPlatform,
    };

_GetPaymentOptionsRequest _$GetPaymentOptionsRequestFromJson(
  Map<String, dynamic> json,
) => _GetPaymentOptionsRequest(
  paymentLink: json['paymentLink'] as String,
  accounts: (json['accounts'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$GetPaymentOptionsRequestToJson(
  _GetPaymentOptionsRequest instance,
) => <String, dynamic>{
  'paymentLink': instance.paymentLink,
  'accounts': instance.accounts,
};

_PaymentOptionsResponse _$PaymentOptionsResponseFromJson(
  Map<String, dynamic> json,
) => _PaymentOptionsResponse(
  options: (json['options'] as List<dynamic>)
      .map((e) => PaymentOption.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PaymentOptionsResponseToJson(
  _PaymentOptionsResponse instance,
) => <String, dynamic>{
  'options': instance.options.map((e) => e.toJson()).toList(),
};

_PaymentOption _$PaymentOptionFromJson(Map<String, dynamic> json) =>
    _PaymentOption(
      id: json['id'] as String,
      amount: PayAmount.fromJson(json['amount'] as Map<String, dynamic>),
      etaSeconds: (json['etaSeconds'] as num).toInt(),
      requiredActions: (json['requiredActions'] as List<dynamic>)
          .map((e) => RequiredAction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PaymentOptionToJson(
  _PaymentOption instance,
) => <String, dynamic>{
  'id': instance.id,
  'amount': instance.amount.toJson(),
  'etaSeconds': instance.etaSeconds,
  'requiredActions': instance.requiredActions.map((e) => e.toJson()).toList(),
};

RequiredActionWalletRpc _$RequiredActionWalletRpcFromJson(
  Map<String, dynamic> json,
) => RequiredActionWalletRpc(
  data: WalletRpcAction.fromJson(json['data'] as Map<String, dynamic>),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$RequiredActionWalletRpcToJson(
  RequiredActionWalletRpc instance,
) => <String, dynamic>{'data': instance.data.toJson(), 'type': instance.$type};

RequiredActionBuild _$RequiredActionBuildFromJson(Map<String, dynamic> json) =>
    RequiredActionBuild(
      data: BuildAction.fromJson(json['data'] as Map<String, dynamic>),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$RequiredActionBuildToJson(
  RequiredActionBuild instance,
) => <String, dynamic>{'data': instance.data.toJson(), 'type': instance.$type};

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

_BuildAction _$BuildActionFromJson(Map<String, dynamic> json) =>
    _BuildAction(data: json['data'] as String);

Map<String, dynamic> _$BuildActionToJson(_BuildAction instance) =>
    <String, dynamic>{'data': instance.data};

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
    );

Map<String, dynamic> _$AmountDisplayToJson(_AmountDisplay instance) =>
    <String, dynamic>{
      'assetSymbol': instance.assetSymbol,
      'assetName': instance.assetName,
      'decimals': instance.decimals,
      'iconUrl': instance.iconUrl,
      'networkName': instance.networkName,
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

_ConfirmPaymentJsonRequest _$ConfirmPaymentJsonRequestFromJson(
  Map<String, dynamic> json,
) => _ConfirmPaymentJsonRequest(
  paymentId: json['paymentId'] as String,
  optionId: json['optionId'] as String,
  results: (json['results'] as List<dynamic>)
      .map((e) => SignatureResult.fromJson(e as Map<String, dynamic>))
      .toList(),
  maxPollMs: (json['maxPollMs'] as num?)?.toInt(),
);

Map<String, dynamic> _$ConfirmPaymentJsonRequestToJson(
  _ConfirmPaymentJsonRequest instance,
) => <String, dynamic>{
  'paymentId': instance.paymentId,
  'optionId': instance.optionId,
  'results': instance.results.map((e) => e.toJson()).toList(),
  'maxPollMs': instance.maxPollMs,
};

_SignatureResult _$SignatureResultFromJson(Map<String, dynamic> json) =>
    _SignatureResult(
      signature: SignatureValue.fromJson(
        json['signature'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$SignatureResultToJson(_SignatureResult instance) =>
    <String, dynamic>{'signature': instance.signature.toJson()};

_SignatureValue _$SignatureValueFromJson(Map<String, dynamic> json) =>
    _SignatureValue(value: json['value'] as String);

Map<String, dynamic> _$SignatureValueToJson(_SignatureValue instance) =>
    <String, dynamic>{'value': instance.value};

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

const _$PaymentStatusEnumMap = {
  PaymentStatus.requiresAction: 'requiresAction',
  PaymentStatus.processing: 'processing',
  PaymentStatus.succeeded: 'succeeded',
  PaymentStatus.failed: 'failed',
  PaymentStatus.expired: 'expired',
};
