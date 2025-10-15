import 'package:freezed_annotation/freezed_annotation.dart';

part 'ton.freezed.dart';
part 'ton.g.dart';

@freezed
sealed class TonKeyPair with _$TonKeyPair {
  const factory TonKeyPair({
    required String sk,
    required String pk,
  }) = _TonKeyPair;

  factory TonKeyPair.fromJson(Map<String, dynamic> json) =>
      _$TonKeyPairFromJson(json);
}

@freezed
sealed class TonIdentity with _$TonIdentity {
  const factory TonIdentity({
    required String friendlyEq,
    required String rawHex,
    required String workchain,
  }) = _TonIdentity;

  factory TonIdentity.fromJson(Map<String, dynamic> json) =>
      _$TonIdentityFromJson(json);
}

@freezed
sealed class TonMessage with _$TonMessage {
  const factory TonMessage({
    required String address,
    required String amount,
    String? payload,
    String? stateInit,
  }) = _TonMessage;

  factory TonMessage.fromJson(Map<String, dynamic> json) =>
      _$TonMessageFromJson(json);
}