import 'dart:convert';
import 'dart:typed_data';
import 'package:pointycastle/digests/sha256.dart';

class StellarChainUtils {
  static const _pubnetPassphrase = 'Public Global Stellar Network ; September 2015';
  static const _testnetPassphrase = 'Test SDF Network ; September 2015';

  // XDR EnvelopeType discriminants
  static const _envelopeTypeTxV0 = 0;
  static const _envelopeTypeTx = 2;
  static const _envelopeTypeTxFeeBump = 5;

  // DecoratedSignature with an ed25519 signature: hint (4) + length (4, =64) + signature (64)
  static const _decoratedSignatureLength = 72;
  static const _ed25519SignatureLength = 64;
  static const _maxEnvelopeSignatures = 20;

  /// Computes the Stellar transaction hash from a base64-encoded, signed
  /// TransactionEnvelope XDR as sha256(network_id || envelope_type || transaction_body).
  /// Signatures are computed over the hash, so the trailing signature array is
  /// stripped rather than hashed. For fee-bump envelopes this yields the
  /// canonical fee-bump hash.
  ///
  /// [signedXdr] base64-encoded TransactionEnvelope XDR (V0, V1 or fee-bump).
  /// [chainId] CAIP-2 chain id (`stellar:pubnet` / `stellar:testnet`), defaults to pubnet.
  /// Returns the lowercase hex transaction hash (64 chars).
  static String getStellarTxHashFromSignedXdr(String signedXdr, {String? chainId}) {
    final bytes = base64.decode(signedXdr);
    if (bytes.length < 8) {
      throw ArgumentError('Stellar envelope too short');
    }

    final discriminant = _readUint32BE(bytes, 0);
    final int envelopeType;
    final int bodyStart;
    switch (discriminant) {
      // V0 transactions are hashed as ENVELOPE_TYPE_TX over the envelope bytes
      // INCLUDING the leading 4 zero bytes - they double as the legacy
      // AccountID key-type tag
      case _envelopeTypeTxV0:
        envelopeType = _envelopeTypeTx;
        bodyStart = 0;
      case _envelopeTypeTx:
        envelopeType = _envelopeTypeTx;
        bodyStart = 4;
      case _envelopeTypeTxFeeBump:
        envelopeType = _envelopeTypeTxFeeBump;
        bodyStart = 4;
      default:
        throw ArgumentError('Unsupported Stellar envelope type: $discriminant');
    }

    final signatureArrayOffset = _findSignatureArrayOffset(bytes);

    final reference = (chainId ?? 'stellar:pubnet').split(':').last;
    final String passphrase;
    switch (reference) {
      case 'pubnet':
        passphrase = _pubnetPassphrase;
      case 'testnet':
        passphrase = _testnetPassphrase;
      default:
        throw ArgumentError('Unknown Stellar network: $chainId');
    }

    final networkId = _sha256(Uint8List.fromList(utf8.encode(passphrase)));
    final payload = Uint8List.fromList([
      ...networkId,
      0, 0, 0, envelopeType,
      ...bytes.sublist(bodyStart, signatureArrayOffset),
    ]);

    final hash = _sha256(payload);
    return hash.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  }

  /// Locates the start of the trailing `DecoratedSignature signatures<20>` XDR
  /// array without parsing the transaction body. Assumes ed25519 signatures
  /// (fixed 72-byte entries), which is what the WalletConnect Stellar RPC spec
  /// mandates wallets emit.
  static int _findSignatureArrayOffset(Uint8List bytes) {
    for (var signatureCount = 0; signatureCount <= _maxEnvelopeSignatures; signatureCount++) {
      final offset = bytes.length - 4 - _decoratedSignatureLength * signatureCount;
      if (offset < 4) break;
      if (_readUint32BE(bytes, offset) != signatureCount) continue;

      var isValid = true;
      for (var i = 0; i < signatureCount; i++) {
        final entryOffset = offset + 4 + _decoratedSignatureLength * i;
        // each entry's signature length field must be exactly 64 (ed25519)
        if (_readUint32BE(bytes, entryOffset + 4) != _ed25519SignatureLength) {
          isValid = false;
          break;
        }
      }
      if (isValid) return offset;
    }
    throw ArgumentError('Could not locate Stellar envelope signature array');
  }

  static int _readUint32BE(Uint8List bytes, int offset) {
    return (bytes[offset] << 24) |
        (bytes[offset + 1] << 16) |
        (bytes[offset + 2] << 8) |
        bytes[offset + 3];
  }

  static Uint8List _sha256(Uint8List data) {
    return SHA256Digest().process(data);
  }
}
