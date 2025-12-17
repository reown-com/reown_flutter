// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_results.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GetQuoteStatusResult _$GetQuoteStatusResultFromJson(
  Map<String, dynamic> json,
) => _GetQuoteStatusResult(
  status: $enumDecode(_$QuoteStatusEnumMap, json['status']),
);

Map<String, dynamic> _$GetQuoteStatusResultToJson(
  _GetQuoteStatusResult instance,
) => <String, dynamic>{'status': _$QuoteStatusEnumMap[instance.status]!};

const _$QuoteStatusEnumMap = {
  QuoteStatus.waiting: 'waiting',
  QuoteStatus.pending: 'pending',
  QuoteStatus.success: 'success',
  QuoteStatus.failure: 'failure',
  QuoteStatus.refund: 'refund',
  QuoteStatus.timeout: 'timeout',
  QuoteStatus.submitted: 'submitted',
};
