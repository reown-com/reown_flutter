/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'dart:convert' show base64;
import 'dart:typed_data' show Uint8List;
import 'package:json_annotation/json_annotation.dart' show JsonSerializable;
import 'package:reown_appkit/solana/solana_buffer/buffer.dart';
import 'package:reown_appkit/solana/solana_common/models.dart';
import 'package:reown_appkit/solana/solana_common/validators.dart';
import 'package:reown_core/reown_core.dart';
import '../crypto/keypair.dart';
import '../crypto/nacl.dart' as nacl;
import '../crypto/pubkey.dart';
import '../encodings/shortvec.dart' as shortvec;
import '../encodings/unit8_list_json_converter.dart';
import '../messages/message.dart';
import '../programs/address_lookup_table/state.dart';
import '../types.dart';
import 'transaction_instruction.dart';

part 'transaction.g.dart';

/// Transaction
/// ------------------------------------------------------------------------------------------------

@JsonSerializable(explicitToJson: true)
class Transaction extends Serializable with TransactionSerializableMixin {
  /// Transaction.
  Transaction({final List<Uint8List>? signatures, required this.message})
    : signatures = signatures ?? [] {
    if (this.signatures.isEmpty) {
      for (int i = 0; i < message.header.numRequiredSignatures; ++i) {
        this.signatures.add(Uint8List(nacl.signatureLength));
      }
    } else {
      check(
        this.signatures.length == message.header.numRequiredSignatures,
        'Number of required signatures mismatch: ${message.header.numRequiredSignatures}.',
      );
    }
  }

  /// One or more signatures for the transaction. Typically created by invoking the [sign] method.
  @Uint8ListJsonConverter()
  final List<Uint8List> signatures;

  /// One or more signatures for the transaction. Typically created by invoking the [sign] method.
  final Message message;

  /// The first Transaction signature (fee payer).
  Uint8List? get signature => signatures.isNotEmpty ? signatures.first : null;

  /// The transaction/message version (`null` == legacy).
  int? get version => message.version;

  /// The transaction/message blockhash.
  Blockhash get blockhash => message.recentBlockhash;

  /// Creates a `legacy` transaction.
  factory Transaction.legacy({
    final List<Uint8List>? signatures,
    required final Pubkey payer,
    required final List<TransactionInstruction> instructions,
    required final Blockhash recentBlockhash,
  }) => Transaction(
    signatures: signatures,
    message: Message.legacy(
      payer: payer,
      instructions: instructions,
      recentBlockhash: recentBlockhash,
    ),
  );

  /// Creates a `v0` transaction.
  factory Transaction.v0({
    final List<Uint8List>? signatures,
    required final Pubkey payer,
    required final List<TransactionInstruction> instructions,
    required final Blockhash recentBlockhash,
    final List<AddressLookupTableAccount>? addressLookupTableAccounts,
  }) => Transaction(
    signatures: signatures,
    message: Message.v0(
      payer: payer,
      instructions: instructions,
      recentBlockhash: recentBlockhash,
      addressLookupTableAccounts: addressLookupTableAccounts,
    ),
  );

  /// {@macro solana_common.Serializable.fromJson}
  factory Transaction.fromJson(final Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TransactionToJson(this);

  @override
  Buffer serialize([final TransactionSerializableConfig? config]) {
    // Create a writable buffer large enough to store the transaction data.
    final BufferWriter serializedTransaction = BufferWriter(2048);

    /// Serialize the transaction message.
    final Buffer serializedMessage = message.serialize();

    // Write the [signatures] encoded length.
    final List<int> signaturesEncodedLength = shortvec.encodeLength(
      signatures.length,
    );
    serializedTransaction.setBuffer(signaturesEncodedLength);

    /// Write the [signatures].
    for (final Uint8List signature in signatures) {
      serializedTransaction.setBuffer(signature);
    }

    /// Write the [message].
    serializedTransaction.setBuffer(serializedMessage);

    /// Resize the buffer.
    return serializedTransaction.toBuffer(slice: true);
  }

  @override
  Buffer serializeMessage() => message.serialize();

  /// Decodes a `base-58` [encoded] transaction into a [Transaction] object.
  factory Transaction.fromBase58(final String encoded) =>
      Transaction.deserialize(base58.decode(encoded));

  /// Decodes a `base-64` [encoded] transaction into a [Transaction] object.
  factory Transaction.fromBase64(final String encoded) =>
      Transaction.deserialize(base64.decode(encoded));

  /// Decodes a serialized transaction into a [Transaction] object.
  factory Transaction.deserialize(final Iterable<int> bytes) {
    // Create a buffer reader over the serialized transaction data.
    final BufferReader reader = BufferReader.fromList(bytes);

    // Read the [signatures].
    final List<Uint8List> signatures = [];
    final int signaturesLength = shortvec.decodeLength(reader);
    for (int i = 0; i < signaturesLength; ++i) {
      signatures.add(reader.getBuffer(nacl.signatureLength).asUint8List());
    }

    // Read the [message].
    final Message message = Message.fromBufferReader(reader);

    // Create the [Transaction].
    return Transaction(signatures: signatures, message: message);
  }

  /// Signs this [Transaction] with the specified signers. Multiple signatures may be applied to a
  /// [Transaction]. The first signature is considered "primary" and is used to identify and confirm
  /// transactions.
  void sign(final List<Signer> signers) {
    final Uint8List serializedMessage = message.serialize().asUint8List();
    final int numRequiredSignatures = message.header.numRequiredSignatures;
    final List<Pubkey> signerPubkeys = message.accountKeys.sublist(
      0,
      numRequiredSignatures,
    );
    for (final Signer signer in signers) {
      final int signerIndex = signerPubkeys.indexOf(signer.pubkey);
      check(signerIndex >= 0, 'Unknown transaction signer.');
      signatures[signerIndex] = nacl.sign.detached.sync(
        serializedMessage,
        signer.seckey,
      );
    }
  }

  /// Add an externally created [signature] to a transaction. The [pubkey] must correspond to the
  /// fee payer or a signer account in the transaction instructions ([Message.accountKeys]).
  void addSignature(final Pubkey pubkey, final Uint8List signature) {
    check(
      signature.length == nacl.signatureLength,
      'Invalid signature length ${signature.length}',
    );
    final int numRequiredSignatures = message.header.numRequiredSignatures;
    final List<Pubkey> signerPubkeys = message.accountKeys.sublist(
      0,
      numRequiredSignatures,
    );
    final int signerIndex = signerPubkeys.indexWhere(
      (signerPubkey) => signerPubkey == pubkey,
    );
    check(signerIndex >= 0, 'Unknown transaction signer.');
    signatures[signerIndex] = signature;
  }
}
