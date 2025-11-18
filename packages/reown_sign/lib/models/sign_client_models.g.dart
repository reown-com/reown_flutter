// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_client_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProposalRequestsResponses _$ProposalRequestsResponsesFromJson(
  Map<String, dynamic> json,
) => _ProposalRequestsResponses(
  authentication: (json['authentication'] as List<dynamic>?)
      ?.map((e) => Cacao.fromJson(e as Map<String, dynamic>))
      .toList(),
  walletPayResult: json['walletPayResult'] == null
      ? null
      : WalletPayResult.fromJson(
          json['walletPayResult'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$ProposalRequestsResponsesToJson(
  _ProposalRequestsResponses instance,
) => <String, dynamic>{
  'authentication': ?instance.authentication?.map((e) => e.toJson()).toList(),
  'walletPayResult': ?instance.walletPayResult?.toJson(),
};
