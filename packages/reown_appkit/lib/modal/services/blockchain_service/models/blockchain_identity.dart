import 'package:freezed_annotation/freezed_annotation.dart';

part 'blockchain_identity.g.dart';
part 'blockchain_identity.freezed.dart';

@freezed
class BlockchainIdentity with _$BlockchainIdentity {
  const factory BlockchainIdentity({
    String? name,
    String? avatar,
  }) = _BlockchainIdentity;

  factory BlockchainIdentity.fromJson(Map<String, dynamic> json) =>
      _$BlockchainIdentityFromJson(json);
}
