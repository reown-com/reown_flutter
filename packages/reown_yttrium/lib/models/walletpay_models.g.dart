// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'walletpay_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DisplayData _$DisplayDataFromJson(Map<String, dynamic> json) => _DisplayData(
  paymentOptions: (json['paymentOptions'] as List<dynamic>)
      .map((e) => PaymentItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$DisplayDataToJson(_DisplayData instance) =>
    <String, dynamic>{'paymentOptions': instance.paymentOptions};

_PaymentItem _$PaymentItemFromJson(Map<String, dynamic> json) => _PaymentItem(
  asset: json['asset'] as String,
  amount: json['amount'] as String,
  chain: json['chain'] as String?,
  symbol: json['symbol'] as String?,
  parsedData: json['parsedData'] == null
      ? null
      : ParsedDataPaymentItem.fromJson(
          json['parsedData'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$PaymentItemToJson(_PaymentItem instance) =>
    <String, dynamic>{
      'asset': instance.asset,
      'amount': instance.amount,
      'chain': instance.chain,
      'symbol': instance.symbol,
      'parsedData': instance.parsedData,
    };

_ParsedDataPaymentItem _$ParsedDataPaymentItemFromJson(
  Map<String, dynamic> json,
) => _ParsedDataPaymentItem(
  assetName: json['assetName'] as String,
  amount: json['amount'] as String,
  chain: json['chain'] as String,
);

Map<String, dynamic> _$ParsedDataPaymentItemToJson(
  _ParsedDataPaymentItem instance,
) => <String, dynamic>{
  'assetName': instance.assetName,
  'amount': instance.amount,
  'chain': instance.chain,
};

_WalletPayAction _$WalletPayActionFromJson(Map<String, dynamic> json) =>
    _WalletPayAction(
      method: json['method'] as String,
      data: json['data'],
      hash: json['hash'] as String,
    );

Map<String, dynamic> _$WalletPayActionToJson(_WalletPayAction instance) =>
    <String, dynamic>{
      'method': instance.method,
      'data': instance.data,
      'hash': instance.hash,
    };

_TransferData _$TransferDataFromJson(Map<String, dynamic> json) =>
    _TransferData(
      from: json['from'] as String?,
      to: json['to'] as String?,
      value: json['value'] as String?,
      nbf: (json['nbf'] as num?)?.toInt(),
      exp: (json['exp'] as num?)?.toInt(),
      nonce: json['nonce'] as String?,
    );

Map<String, dynamic> _$TransferDataToJson(_TransferData instance) =>
    <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
      'value': instance.value,
      'nbf': instance.nbf,
      'exp': instance.exp,
      'nonce': instance.nonce,
    };

_TransferConfirmation _$TransferConfirmationFromJson(
  Map<String, dynamic> json,
) => _TransferConfirmation(
  type: json['type'] as String,
  data: json['data'] as String,
  hash: json['hash'] as String,
);

Map<String, dynamic> _$TransferConfirmationToJson(
  _TransferConfirmation instance,
) => <String, dynamic>{
  'type': instance.type,
  'data': instance.data,
  'hash': instance.hash,
};

_WalletPayResponseResultV1 _$WalletPayResponseResultV1FromJson(
  Map<String, dynamic> json,
) => _WalletPayResponseResultV1(
  transferConfirmation: TransferConfirmation.fromJson(
    json['transferConfirmation'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$WalletPayResponseResultV1ToJson(
  _WalletPayResponseResultV1 instance,
) => <String, dynamic>{'transferConfirmation': instance.transferConfirmation};
