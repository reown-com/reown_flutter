/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'dart:typed_data' show Uint8List;
import 'package:json_annotation/json_annotation.dart' show JsonSerializable;
import 'package:reown_appkit/solana/solana_common/models.dart';
import '../crypto/pubkey.dart';
import '../encodings/unit8_list_json_converter.dart';

part 'signature_pubkey_pair.g.dart';

/// Signature Public Key Pair
/// ------------------------------------------------------------------------------------------------

@JsonSerializable()
class SignaturePubkeyPair extends Serializable {
  /// A signature and its corresponding public key.
  const SignaturePubkeyPair({
    this.signature,
    required this.pubkey,
  });

  /// The signature.
  @Uint8ListJsonConverter()
  final Uint8List? signature;

  /// The public key.
  final Pubkey pubkey;

  /// {@macro solana_common.Serializable.fromJson}
  factory SignaturePubkeyPair.fromJson(final Map<String, dynamic> json) =>
      _$SignaturePubkeyPairFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SignaturePubkeyPairToJson(this);

  /// Creates a copy of this class applying the provided parameters to the new instance.
  SignaturePubkeyPair copyWith({
    final Uint8List? signature,
    final Pubkey? pubkey,
  }) =>
      SignaturePubkeyPair(
        signature: signature ?? this.signature,
        pubkey: pubkey ?? this.pubkey,
      );
}
