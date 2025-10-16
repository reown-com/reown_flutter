/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'dart:typed_data' show Uint8List;
import 'package:reown_appkit/solana/solana_buffer/buffer.dart';
import 'package:reown_appkit/solana/solana_common/validators.dart' show check;
import '../../crypto/keypair.dart';
import '../../crypto/nacl.dart' as nacl;
import '../../crypto/pubkey.dart';
import '../../transactions/transaction_instruction.dart';
import '../program.dart';

/// Ed25519 Program
/// ------------------------------------------------------------------------------------------------

/// Ed25519 Program
class Ed25519Program extends Program {
  /// Ed25519 Program
  Ed25519Program._()
    : super(Pubkey.fromBase58('Ed25519SigVerify111111111111111111111111111'));

  /// Internal singleton instance.
  static final Ed25519Program _instance = Ed25519Program._();

  /// The program id.
  static Pubkey get programId => _instance.pubkey;

  /// Creates an ed25519 instruction with a public key and signature. The public key must be a
  /// buffer that is 32 bytes long, and the signature must be a buffer of 64 bytes.
  static TransactionInstruction createInstructionWithPubkey({
    required final Uint8List pubkey,
    required final Uint8List message,
    required final Uint8List signature,
    required final int? instructionIndex,
  }) {
    check(
      pubkey.length == nacl.pubkeyLength,
      'The public Key must be ${nacl.pubkeyLength} bytes but received ${pubkey.length} bytes.',
    );

    check(
      signature.length == nacl.signatureLength,
      'The signature must be ${nacl.signatureLength} bytes but received ${signature.length} bytes.',
    );

    const numSignatures = 1;
    const pubkeyOffset = 16; // instruction size.
    final signatureOffset = pubkeyOffset + pubkey.length;
    final messageDataOffset = signatureOffset + signature.length;
    final index =
        instructionIndex ??
        0xffff; // An index of `u16::MAX` makes it default to the
    //current instruction.

    final BufferWriter buffer = BufferWriter.mutable();
    buffer.setUint8(numSignatures);
    buffer.setUint8(0); // padding,
    buffer.setUint16(signatureOffset);
    buffer.setUint16(index); // signatureInstructionIndex
    buffer.setUint16(pubkeyOffset);
    buffer.setUint16(index); // publicKeyInstructionIndex
    buffer.setUint16(messageDataOffset);
    buffer.setUint16(message.length);
    buffer.setUint16(index); // messageInstructionIndex

    buffer.setBuffer(pubkey);
    buffer.setBuffer(signature);
    buffer.setBuffer(message);

    return TransactionInstruction(
      keys: const [],
      programId: Ed25519Program.programId,
      data: buffer.toBuffer(slice: true).asUint8List(),
    );
  }

  //// Create an ed25519 instruction with a private key. The private key must be a buffer that is 64
  /// bytes long.
  static TransactionInstruction createInstructionWithPrivateKey({
    required final Uint8List privateKey,
    required final Uint8List message,
    required final int? instructionIndex,
  }) {
    check(
      privateKey.length == nacl.seckeyLength,
      'The private key must be ${nacl.seckeyLength} bytes but received ${privateKey.length} bytes.',
    );

    try {
      final keypair = Keypair.fromSeckeySync(privateKey);
      final pubkey = keypair.pubkey.toBytes();
      final signature = nacl.sign.detached.sync(message, keypair.seckey);

      return createInstructionWithPubkey(
        pubkey: pubkey,
        message: message,
        signature: signature,
        instructionIndex: instructionIndex,
      );
    } catch (error) {
      throw Exception('Error creating ED25519 instruction: $error');
    }
  }
}
