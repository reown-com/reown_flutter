// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'result_models.freezed.dart';
part 'result_models.g.dart';

@freezed
sealed class SolanaTransactionParams with _$SolanaTransactionParams {
  const factory SolanaTransactionParams({
    required String transaction,
    required String pubkey,
  }) = _SolanaTransactionParams;

  factory SolanaTransactionParams.fromJson(Map<String, dynamic> json) =>
      _$SolanaTransactionParamsFromJson(json);
}

@freezed
sealed class EvmTransactionParams with _$EvmTransactionParams {
  const factory EvmTransactionParams({
    required String from,
    required String to,
    required String value,
    String? gas,
    String? gasPrice,
    String? maxFeePerGas,
    String? maxPriorityFeePerGas,
    String? input,
    String? data,
  }) = _EvmTransactionParams;

  factory EvmTransactionParams.fromJson(Map<String, dynamic> json) =>
      _$EvmTransactionParamsFromJson(json);
}

@freezed
sealed class TronTransactionObject with _$TronTransactionObject {
  const factory TronTransactionObject({
    dynamic raw_data,
    required String raw_data_hex,
    required List<String>? signature,
    required String txID,
    bool? visible,
  }) = _TronTransactionObject;

  factory TronTransactionObject.fromJson(Map<String, dynamic> json) =>
      _$TronTransactionObjectFromJson(json);
}

@freezed
sealed class TronTransaction with _$TronTransaction {
  const factory TronTransaction({
    required TronTransactionResult result,
    required TronTransactionObject transaction,
  }) = _TronTransaction;

  factory TronTransaction.fromJson(Map<String, dynamic> json) =>
      _$TronTransactionFromJson(json);
}

@freezed
sealed class TronTransactionResult with _$TronTransactionResult {
  const factory TronTransactionResult({required bool result}) =
      _TronTransactionResult;

  factory TronTransactionResult.fromJson(Map<String, dynamic> json) =>
      _$TronTransactionResultFromJson(json);
}

@freezed
sealed class TronTransactionParams with _$TronTransactionParams {
  const factory TronTransactionParams({
    required TronTransaction transaction,
    required String address,
  }) = _TronTransactionParams;

  factory TronTransactionParams.fromJson(Map<String, dynamic> json) =>
      _$TronTransactionParamsFromJson(json);
}

@Freezed(unionKey: 'method', unionValueCase: FreezedUnionCase.none)
sealed class TransactionRpc with _$TransactionRpc {
  @FreezedUnionValue('eth_sendTransaction')
  const factory TransactionRpc.evm({
    required String id,
    required String chainId,
    @Default('eth_sendTransaction') String method,
    required List<EvmTransactionParams> params,
  }) = EvmTransactionRpc;

  @FreezedUnionValue('solana_signAndSendTransaction')
  const factory TransactionRpc.solana({
    required String id,
    required String chainId,
    @Default('solana_signAndSendTransaction') String method,
    required SolanaTransactionParams params,
  }) = SolanaTransactionRpc;

  @FreezedUnionValue('tron_signTransaction')
  const factory TransactionRpc.tron({
    required String id,
    required String chainId,
    @Default('tron_signTransaction') String method,
    required TronTransactionParams params,
  }) = TronTransactionRpc;

  factory TransactionRpc.fromJson(Map<String, dynamic> json) =>
      _$TransactionRpcFromJson(json);
}

@freezed
sealed class BuildTransactionResult with _$BuildTransactionResult {
  const factory BuildTransactionResult({
    required List<TransactionRpc> transactions,
  }) = _BuildTransactionResult;

  factory BuildTransactionResult.fromJson(Map<String, dynamic> json) =>
      _$BuildTransactionResultFromJson(json);
}

@freezed
sealed class SupportedNamespace with _$SupportedNamespace {
  const factory SupportedNamespace({
    required List<String> assetNamespaces,
    dynamic capabilities,
    required List<String> events,
    required List<String> methods,
    required String name,
  }) = _SupportedNamespace;

  factory SupportedNamespace.fromJson(Map<String, dynamic> json) =>
      _$SupportedNamespaceFromJson(json);
}

@freezed
sealed class SupportedNetworksResult with _$SupportedNetworksResult {
  const factory SupportedNetworksResult({
    required List<SupportedNamespace> namespaces,
  }) = _SupportedNetworksResult;

  factory SupportedNetworksResult.fromJson(Map<String, dynamic> json) =>
      _$SupportedNetworksResultFromJson(json);
}
