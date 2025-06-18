import 'package:freezed_annotation/freezed_annotation.dart';

part 'stacks.freezed.dart';
part 'stacks.g.dart';

@freezed
class TransferStxRequest with _$TransferStxRequest {
  const factory TransferStxRequest({
    required BigInt amount,
    required String recipient,
    String? memo,
  }) = _TransferStxRequest;

  factory TransferStxRequest.fromJson(Map<String, dynamic> json) =>
      _$TransferStxRequestFromJson(json);
}

@freezed
class TransferStxResponse with _$TransferStxResponse {
  const factory TransferStxResponse({
    required String transaction,
    required String txid,
  }) = _TransferStxResponse;

  factory TransferStxResponse.fromJson(Map<String, dynamic> json) =>
      _$TransferStxResponseFromJson(json);
}

enum StacksVersion {
  mainnet_p2pkh,
  mainnet_p2sh,
  testnet_p2pkh,
  testnet_p2sh;

  @override
  String toString() {
    switch (this) {
      case StacksVersion.mainnet_p2pkh:
        return 'mainnet-p2pkh';
      case StacksVersion.mainnet_p2sh:
        return 'mainnet-p2sh';
      case StacksVersion.testnet_p2pkh:
        return 'testnet-p2pkh';
      case StacksVersion.testnet_p2sh:
        return 'testnet-p2sh';
    }
  }
}
