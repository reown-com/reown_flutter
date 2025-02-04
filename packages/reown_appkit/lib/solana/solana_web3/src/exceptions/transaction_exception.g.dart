// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_exception.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionException _$TransactionExceptionFromJson(
        Map<String, dynamic> json) =>
    TransactionException(
      json['message'] as String,
      code: (json['code'] as num?)?.toInt(),
    );
