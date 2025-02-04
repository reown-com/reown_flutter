// /// Imports
// /// ------------------------------------------------------------------------------------------------

// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:json_annotation/json_annotation.dart';
// import 'package:reown_appkit/solana/solana_buffer/buffer.dart';
// import 'package:reown_appkit/solana/solana_common/convert.dart';
// import 'package:reown_appkit/solana/solana_common/models.dart';
// import 'package:reown_appkit/solana/solana_common/types.dart';
// import 'package:reown_appkit/solana/solana_common/validators.dart';
// import '../crypto/keypair.dart';
// import '../crypto/nacl.dart' as nacl;
// import '../crypto/pubkey.dart';
// import '../encodings/shortvec.dart' as shortvec;
// import '../exceptions/transaction_exception.dart';
// import '../messages/message.dart';
// import '../messages/message_address_table_lookup.dart';
// import '../messages/message_header.dart';
// import '../messages/message_instruction.dart';
// import '../rpc/connection.dart';
// import '../rpc/models/blockhash_with_expiry_block_height.dart';
// import '../types.dart';
// import 'account_meta.dart';
// import 'constants.dart';
// import 'nonce_information.dart';
// import 'signature_pubkey_pair.dart';
// import 'transaction_instruction.dart';

// part 'transaction.g.dart';

// /// Default (empty) Signature
// /// ------------------------------------------------------------------------------------------------

// final Buffer defaultSignature = Buffer(nacl.signatureLength);

// /// Transaction
// /// ------------------------------------------------------------------------------------------------

// @JsonSerializable(explicitToJson: true)
// class Transaction extends Serializable with TransactionSerializableMixin {

//   /// Transaction.
//   Transaction({
//     this.version,
//     this.feePayer,
//     final List<SignaturePubkeyPair>? signatures,
//     this.recentBlockhash,
//     this.lastValidBlockHeight,
//     final List<TransactionInstruction>? instructions,
//     this.nonceInfo,
//     final List<MessageAddressTableLookup>? addressTableLookups,
//   }): signatures = signatures ?? [],
//       instructions = instructions ?? [],
//       addressTableLookups = addressTableLookups ?? const [];

//   /// The transaction version (`null` == legacy).
//   final int? version;

//   /// The transaction's fee payer.
//   final Pubkey? feePayer;

//   /// One or more signatures for the transaction. Typically created by invoking the [sign] method.
//   final List<SignaturePubkeyPair> signatures;

//   /// A recent transaction id.
//   final Blockhash? recentBlockhash;

//   /// The last block the chain can advance to before tx is declared expired.
//   final u64? lastValidBlockHeight;

//   /// The instructions to atomically execute.
//   final List<TransactionInstruction> instructions;

//   /// If provided, the transaction will use a durable Nonce hash instead of a [recentBlockhash].
//   final NonceInformation? nonceInfo;

//   /// A list of address table lookups used by a transaction to dynamically load addresses from
//   /// on-chain address lookup tables.
//   final List<MessageAddressTableLookup> addressTableLookups;

//   /// The saved compiled message.
//   Message? _message;

//   /// The saved [_message]'s JSON output.
//   Map<String, dynamic>? _json;

//   /// The first (payer) Transaction signature.
//   Uint8List? get signature => signatures.isNotEmpty ? signatures.first.signature : null;

//   /// Blockhash.
//   BlockhashWithExpiryBlockHeight? get blockhash {
//     return recentBlockhash != null && lastValidBlockHeight != null
//       ? BlockhashWithExpiryBlockHeight(
//           blockhash: recentBlockhash!,
//           lastValidBlockHeight: lastValidBlockHeight!,
//         )
//       : null;
//   }

//   /// Creates a `legacy` transaction.
//   factory Transaction.legacy({
//     final Pubkey? feePayer,
//     final List<SignaturePubkeyPair>? signatures,
//     final Blockhash? recentBlockhash,
//     final u64? lastValidBlockHeight,
//     final List<TransactionInstruction>? instructions,
//     final NonceInformation? nonceInfo,
//   }) => Transaction(
//     version: null,
//     feePayer: feePayer,
//     signatures: signatures,
//     recentBlockhash: recentBlockhash,
//     lastValidBlockHeight: lastValidBlockHeight,
//     instructions: instructions,
//     nonceInfo: nonceInfo,
//   );

//   /// Creates a `v0` transaction.
//   factory Transaction.v0({
//     final Pubkey? feePayer,
//     final List<SignaturePubkeyPair>? signatures,
//     final Blockhash? recentBlockhash,
//     final u64? lastValidBlockHeight,
//     final List<TransactionInstruction>? instructions,
//     final NonceInformation? nonceInfo,
//     final List<MessageAddressTableLookup>? addressTableLookups,
//   }) => Transaction(
//     version: 0,
//     feePayer: feePayer,
//     signatures: signatures,
//     recentBlockhash: recentBlockhash,
//     lastValidBlockHeight: lastValidBlockHeight,
//     instructions: instructions,
//     nonceInfo: nonceInfo,
//     addressTableLookups: addressTableLookups,
//   );

//   /// {@macro solana_common.Serializable.fromJson}
//   factory Transaction.fromJson(final Map<String, dynamic> json)
//     => _$TransactionFromJson(json);

//   @override
//   Map<String, dynamic> toJson() => _$TransactionToJson(this);

//   /// Creates a copy of this class applying the provided parameters to the new instance.
//   Transaction copyWith({
//     final int? version,
//     final Pubkey? feePayer,
//     final List<SignaturePubkeyPair>? signatures,
//     final Blockhash? recentBlockhash,
//     final u64? lastValidBlockHeight,
//     final List<TransactionInstruction>? instructions,
//     final NonceInformation? nonceInfo,
//     final List<MessageAddressTableLookup>? addressTableLookups,
//   }) {
//     final transaction = Transaction(
//       version: version ?? this.version,
//       feePayer: feePayer ??  this.feePayer,
//       signatures: signatures ?? this.signatures,
//       recentBlockhash: recentBlockhash ?? this.recentBlockhash,
//       lastValidBlockHeight: lastValidBlockHeight ?? this.lastValidBlockHeight,
//       instructions: instructions ?? this.instructions,
//       nonceInfo: nonceInfo ?? this.nonceInfo,
//       addressTableLookups: addressTableLookups ?? this.addressTableLookups,
//     );
//     transaction._message = _message;
//     transaction._json = _json;
//     return transaction;
//   }

//   /// Creates a copy of this class applying the provided [blockhash].
//   Transaction copyWithBlockhash(
//     final BlockhashWithExpiryBlockHeight blockhash,
//   ) => copyWith(
//       recentBlockhash: blockhash.blockhash,
//       lastValidBlockHeight: blockhash.lastValidBlockHeight,
//     );

//   /// Appends [instruction] to this [Transaction].
//   void add(final TransactionInstruction instruction) {
//     instructions.add(instruction);
//   }

//   /// Appends all [instructions] to this [Transaction].
//   void addAll(final List<TransactionInstruction> instructions) {
//     this.instructions.addAll(instructions);
//   }

//   /// Check that the [pubkeys] have each provided their [signatures].
//   bool validSignatures({ required final List<Pubkey> pubkeys }) {
//     if (signatures.length != pubkeys.length) {
//       return false;
//     }
//     for (int i = 0; i < signatures.length; ++i) {
//       if (signatures[i].pubkey != pubkeys[i]) {
//         return false;
//       }
//     }
//     return true;
//   }

//   /// Compiles the transaction's message.
//   Message compileMessage() {

//     // Return the cached message if no changes have been made.
//     final Message? _message = this._message;
//     if (_message != null && json.encode(_json) == json.encode(toJson())) {
//       return _message;
//     }

//     // Add any `nonce` information to the transaction.
//     final List<TransactionInstruction> instructions = List.from(this.instructions);
//     final NonceInformation? nonceInfo = this.nonceInfo;
//     if (nonceInfo != null) {
//       if (instructions.isEmpty || instructions.first != nonceInfo.nonceInstruction) {
//         instructions.insert(0, nonceInfo.nonceInstruction);
//       }
//     }

//     // Check that a bloch hash has been provided.
//     final Blockhash? recentBlockhash = nonceInfo?.nonce ?? this.recentBlockhash;
//     if(recentBlockhash == null) {
//       throw const TransactionException('Transaction requires a recentBlockhash');
//     }

//     // Check that a payer account has been provided.
//     Pubkey? feePayer = this.feePayer;
//     if (feePayer == null) {
//       if (signatures.isNotEmpty) {
//         feePayer = signatures.first.pubkey;
//       } else {
//         throw const TransactionException('Transaction fee payer required');
//       }
//     }

//     // Collect all [programIds] and [accountMetas] found in the [instructions].
//     final List<Pubkey> programIds = [];
//     final List<AccountMeta> accountMetas = [];
//     for (final TransactionInstruction instruction in instructions) {
//       accountMetas.addAll(instruction.keys);
//       final Pubkey programId = instruction.programId;
//       if (!programIds.contains(programId)) {
//         programIds.add(programId);
//       }
//     }

//     // Append program id account metas.
//     for (final Pubkey programId in programIds) {
//       accountMetas.add(
//         AccountMeta(
//           programId,
//           isSigner: false,
//           isWritable: false,
//         ),
//       );
//     }

//     // Remove duplicate account metas.
//     List<AccountMeta> uniqueMetas = [];
//     for (final AccountMeta accountMeta in accountMetas) {
//       // Find the index of [pubkey]'s existing account meta.
//       final int index = uniqueMetas.indexWhere((final AccountMeta meta) {
//         return meta.pubkey == accountMeta.pubkey;
//       });
//       // Add [pubkey] to [uniqueMetas] if it doesn't already exist or updgrade its existing
//       // account meta to be a `signer` or `writable` if [accountMeta] is a signer or writable.
//       if (index < 0) {
//         uniqueMetas.add(accountMeta);
//       } else {
//         uniqueMetas[index] = accountMeta.copyWith(
//           isSigner: uniqueMetas[index].isSigner || accountMeta.isSigner,
//           isWritable: uniqueMetas[index].isWritable || accountMeta.isWritable,
//         );
//       }
//     }

//     // Sort [uniqueMetas] by signer accounts, followed by writable accounts.
//     uniqueMetas.sort((final AccountMeta x, final AccountMeta y) {
//       // Signers must be placed before non-signers.
//       if (x.isSigner != y.isSigner) {
//         return x.isSigner ? -1 : 1;
//       }
//       // Writable accounts must be placed before read-only accounts.
//       if (x.isWritable != y.isWritable) {
//         return x.isWritable ? -1 : 1;
//       }
//       // Otherwise, sort by the public key's base-58 encoded string.
//       return x.pubkey.toBase58().compareTo(y.pubkey.toBase58());
//     });

//     // Move the fee payer to the front of the list.
//     final int feePayerIndex = uniqueMetas.indexWhere((final AccountMeta meta) {
//       return meta.pubkey == feePayer;
//     });
//     if (feePayerIndex < 0) {
//       uniqueMetas.insert(0, AccountMeta(feePayer, isSigner: true, isWritable: true));
//     } else {
//       final AccountMeta payerMeta = uniqueMetas.removeAt(feePayerIndex);
//       uniqueMetas.insert(0, payerMeta.copyWith(isSigner: true, isWritable: true));
//     }

//     // Check that there are no unknown signers.
//     for (final SignaturePubkeyPair signature in signatures) {
//       final int index = uniqueMetas.indexWhere((final AccountMeta meta) {
//         return meta.pubkey == signature.pubkey;
//       });
//       if (index < 0) {
//         throw TransactionException('Unknown signer: ${signature.pubkey.toBase58()}');
//       } else if (!uniqueMetas[index].isSigner) {
//         uniqueMetas[index] = uniqueMetas[index].copyWith(isSigner: true);
//         throw const TransactionException(
//           'The transaction references a signature that is unnecessary. Only the fee payer and '
//           'instruction signer accounts should sign a transaction.'
//         );
//       }
//     }

//     // [MessageHeader] values.
//     int numRequiredSignatures = 0;
//     int numReadonlySignedAccounts = 0;
//     int numReadonlyUnsignedAccounts = 0;

//     // Collect the signing and non-signing keys into separate lists and count [MessageHeader]
//     // values.
//     final List<Pubkey> signedKeys = [];
//     final List<Pubkey> unsignedKeys = [];
//     for (final AccountMeta accountMeta in uniqueMetas) {
//       if (accountMeta.isSigner) {
//         signedKeys.add(accountMeta.pubkey);
//         numRequiredSignatures += 1;
//         if (!accountMeta.isWritable) {
//           numReadonlySignedAccounts += 1;
//         }
//       } else {
//         unsignedKeys.add(accountMeta.pubkey);
//         if (!accountMeta.isWritable) {
//           numReadonlyUnsignedAccounts += 1;
//         }
//       }
//     }

//     // Convert the [TransactionInstruction]s into [Instructions].
//     final List<Pubkey> accountKeys = signedKeys + unsignedKeys;
//     final Iterable<MessageInstruction> compiledInstructions = instructions.map(
//       (final TransactionInstruction instruction) => instruction.toMessageInstruction(accountKeys),
//     );

//     // Validate the indices of each instruction's program id and accounts.
//     for (final MessageInstruction instruction in compiledInstructions) {
//       check(instruction.programIdIndex >= 0, 'Instruction program id index is < 0.');
//       for (var index in instruction.accounts) {
//         check(index >= 0, 'Instruction account index is < 0.');
//       }
//     }

//     // Return the compiled transaction.
//     return Message(
//       version: version,
//       header: MessageHeader(
//         numRequiredSignatures: numRequiredSignatures,
//         numReadonlySignedAccounts: numReadonlySignedAccounts,
//         numReadonlyUnsignedAccounts: numReadonlyUnsignedAccounts,
//       ),
//       accountKeys: accountKeys,
//       recentBlockhash: recentBlockhash,
//       instructions: compiledInstructions,
//       addressTableLookups: addressTableLookups,
//     );
//   }

//   /// Creates and verifies the transaction's message.
//   Message compileAndVerifyMessage() {

//     // Creates the transaction's message.
//     final Message message = compileMessage();

//     // Get the number of signers required by this transaction.
//     final int numRequiredSignatures = message.header.numRequiredSignatures;

//     // Get the public keys of the accounts that must sign this transaction.
//     final List<Pubkey> pubkeys = message.accountKeys.sublist(0, numRequiredSignatures);

//     // Verify that the accounts required to sign this transaction ([pubkeys]) have provided their
//     // [signatures] or unsign the transaction.
//     if (!validSignatures(pubkeys: pubkeys)) {
//       unsign(pubkeys: pubkeys);
//     }

//     // Return the compiled message.
//     return message;
//   }

//   /// Get a buffer of the Transaction data that needs to be covered by signatures.
//   @override
//   Buffer serializeMessage() {
//     return compileAndVerifyMessage().serialize();
//   }

//   /// Get the estimated fee associated with a transaction
//   Future<u64> getEstimatedFee(final Connection connection) {
//     return connection.getFeeForMessage(compileMessage());
//   }

//   /// Unsign this [Transaction] by replacing all [signatures] with unsigned [pubkeys].
//   void unsign({ required final Iterable<Pubkey> pubkeys }) {
//     signatures.clear();
//     for (final Pubkey pubkey in pubkeys) {
//       signatures.add(SignaturePubkeyPair(pubkey: pubkey));
//     }
//   }

//   /// Signs this [Transaction] with the specified signers. Multiple signatures may be applied to a
//   /// [Transaction]. The first signature is considered "primary" and is used to identify and confirm
//   /// transactions.
//   ///
//   /// If the [Transaction]'s `feePayer` is not set, the first signer will be used as the
//   /// transaction's fee payer account.
//   ///
//   /// Transaction fields should not be modified after the first call to `sign`, as doing so may
//   /// invalidate the signature and cause the [Transaction] to be rejected.
//   ///
//   /// The Transaction must be assigned a valid `recentBlockhash` before invoking this method.
//   void sign(final Iterable<Signer> signers, { final bool clear = true }) {

//     if (signers.isEmpty) {
//       throw const TransactionException(
//         'The transaction has not been signed. Call Transaction.sign() with the required signers.',
//       );
//     }

//     final Set<Pubkey> unique = {};
//     final List<Signer> uniqueSigners = signers.where(
//       (final Signer signer) => unique.add(signer.pubkey)
//     ).toList(growable: false); // consume and store the result of the lazy iterable.

//     if (clear) {
//       unsign(pubkeys: uniqueSigners.map((final Signer pair) => pair.pubkey));
//     }

//     final Message message = compileMessage();
//     _partialSign(message, signers);

//     // final Buffer message = serializeMessage();

//     // for (final Signer signer in uniqueSigners) {
//     //   final Uint8List signature = nacl.sign.detached(message.asUint8List(), signer.seckey);
//     //   final int index = signatures.indexWhere(
//     //     (final SignaturePubkeyPair pair) => signer.pubkey == pair.pubkey,
//     //   );
//     //   if (index < 0) {
//     //     throw TransactionException('Unknown signer ${signer.pubkey}');
//     //   }

//     //   signatures[index] = signatures[index].copyWith(signature: signature);
//     // }
//   }

//   /// Partially sign a transaction with the specified accounts. All accounts must correspond to
//   /// either the fee payer or a signer account in the transaction instructions.
//   ///
//   /// All the caveats from the `sign` method apply to `partialSign`.
//   void partialSign(final Iterable<Signer> signers) {
//     if (signers.isEmpty) {
//       throw const TransactionException('No signers.');
//     }

//     // Dedupe signers
//     final Set<Pubkey> unique = {};
//     final List<Signer> uniqueSigners = signers.where(
//       (final Signer signer) => unique.add(signer.pubkey)
//     ).toList(growable: false); // consume and store the result of the lazy iterable.

//     final message = compileMessage();
//     _partialSign(message, uniqueSigners);
//   }

//   /// @internal
//   void _partialSign(final Message message, final Iterable<Signer> signers) {
//     final signData = message.serialize().asUint8List();
//     for (final Signer signer in signers) {
//       final Uint8List signature = nacl.sign.detached.sync(signData, signer.seckey);
//       _addSignature(signer.pubkey, Buffer.fromUint8List(signature));
//     }
//   }

//   /// Add an externally created signature to a transaction. The public key must correspond to either
//   /// the fee payer or a signer account in the transaction instructions.
//   void addSignature(final Pubkey pubkey, final Buffer signature) {
//     compileMessage(); // Ensure signatures array is populated
//     _addSignature(pubkey, signature);
//   }

//   /// @internal
//   void _addSignature(final Pubkey pubkey, final Buffer signature) {
//     check(signature.length == nacl.signatureLength);
//     final int index = signatures.indexWhere(
//       (final SignaturePubkeyPair pair) => pubkey == pair.pubkey,
//     );
//     if (index < 0) {
//       throw TransactionException('Unknown signer $pubkey.');
//     }
//     signatures[index] = signatures[index].copyWith(signature: signature.asUint8List());
//   }

//   /// Verifies signatures of a complete, signed Transaction.
//   bool verifySignatures() {
//     return _verifySignatures(serializeMessage(), requireAllSignatures: true);
//   }

//   /// Verifies signatures of a complete, signed Transaction.
//   bool _verifySignatures(final Buffer message, { final bool requireAllSignatures = true }) {
//     for (final SignaturePubkeyPair pair in signatures) {
//       final Uint8List? signature = pair.signature;
//       if (signature == null) {
//         if (requireAllSignatures) {
//           return false;
//         }
//       } else {
//         if (!nacl.sign.detached.verifySync(
//           message.asUint8List(),
//           signature, pair.pubkey.toBytes()
//         )) {
//           return false;
//         }
//       }
//     }
//     return true;
//   }

//   /// Serialises this [Transaction] into the wire format.
//   @override
//   Buffer serialize([TransactionSerializableConfig? config]) {

//     config ??= const TransactionSerializableConfig();

//     final Buffer message = serializeMessage();
//     if (config.verifySignatures
//         && !_verifySignatures(message, requireAllSignatures: config.requireAllSignatures)) {
//       throw const TransactionException('Signature verification failed');
//     }

//     return _serialize(message);

//     // final List<int> signatureCount = shortvec.encodeLength(signatures.length);
//     // final int transactionLength = signatureCount.length + signatures.length * 64 + message.length;
//     // check(
//     //   transactionLength <= packetDataSize,
//     //   'Transaction is too large: $transactionLength > $packetDataSize',
//     // );

//     // final BufferWriter writer = BufferWriter(transactionLength);
//     // check(signatures.length < 256, 'The number of signatures must be < 256');
//     // writer.setBuffer(signatureCount);

//     // for (int i = 0; i < signatures.length; ++i) {
//     //   final Uint8List? signature = signatures[i].signature;
//     //   if (signature != null) {
//     //     check(signature.length == nacl.signatureLength, 'Invalid signature length.');
//     //     writer.setBuffer(signature);
//     //   }
//     // }

//     // writer.setBuffer(message);
//     // return writer.toBuffer(slice: false);
//   }

//   /// Serialises a [Transaction] buffer into the wire format.
//   Buffer _serialize(final Buffer message) {
//     final List<int> signatureCount = shortvec.encodeLength(signatures.length);
//     final int transactionLength = signatureCount.length + signatures.length * 64 + message.length;
//     final Buffer wireTransaction = Buffer(transactionLength);
//     check(signatures.length < 256, 'The number of signatures must be < 256');
//     Buffer.fromList(signatureCount).copy(wireTransaction, 0);

//     for (int i = 0; i < signatures.length; ++i) {
//       final Uint8List? signature = signatures[i].signature;
//       if (signature != null) {
//         check(signature.length == nacl.signatureLength, 'Invalid signature length.');
//         Buffer.fromList(signature).copy(wireTransaction, signatureCount.length + i * 64);
//       }
//     }

//     message.copy(wireTransaction, signatureCount.length + signatures.length * 64);
//     check(
//       wireTransaction.length <= packetDataSize,
//       'Transaction is too large: ${wireTransaction.length} > $packetDataSize',
//     );

//     return wireTransaction;
//   }

//   /// Decodes a `base-64` [encoded] transaction into a [Transaction] object.
//   factory Transaction.fromBase64(final String encoded)
//     => Transaction.fromList(base64.decode(encoded));

//   /// Decodes a wire transaction into a [Transaction] object.
//   factory Transaction.fromList(final List<int> bytes) {
//     final List<String> signatures = [];
//     final BufferReader reader = BufferReader.fromList(bytes);
//     final int signatureCount = shortvec.decodeLength(reader);
//     for (int i = 0; i < signatureCount; ++i) {
//       final Buffer signature = reader.getBuffer(nacl.signatureLength);
//       signatures.add(base58.encode(signature.asUint8List()));
//     }
//     return Transaction.populate(
//       Message.fromBufferReader(reader),
//       signatures,
//     );
//   }

//   /// Populates a [Transaction] object with the contents of [message] and the provided [signatures].
//   factory Transaction.populate(
//     final Message message, [
//     final List<String> signatures = const [],
//   ]) {

//     final Blockhash? recentBlockhash = message.recentBlockhash;
//     final Pubkey? feePayer = message.header.numRequiredSignatures > 0
//       && message.accountKeys.isNotEmpty
//         ? message.accountKeys.first
//         : null;

//     final Transaction transaction = Transaction(
//       feePayer: feePayer,
//       recentBlockhash: recentBlockhash,
//     );

//     for (int i = 0; i < signatures.length; ++i) {
//       final String signature = signatures[i];
//       final SignaturePubkeyPair pair = SignaturePubkeyPair(
//         signature: signature != base58.encode(defaultSignature.asUint8List())
//           ? base58.decode(signature)
//           : null,
//         pubkey: message.accountKeys[i],
//       );
//       transaction.signatures.add(pair);
//     }

//     for (final MessageInstruction instruction in message.instructions) {
//       final Iterable<AccountMeta> keys = instruction.accounts.map((final int i) {
//         final Pubkey pubkey = message.accountKeys[i];
//         return AccountMeta(
//           pubkey,
//           isSigner: transaction.signatures.any(
//             (pair) => pair.pubkey == pubkey,
//           ) || message.isAccountSigner(i),
//           isWritable: message.isAccountWritable(i)
//         );
//       });

//       transaction.instructions.add(
//         TransactionInstruction(
//           keys: keys.toList(),
//           programId: message.accountKeys[instruction.programIdIndex],
//           data: base58.decode(instruction.data),
//         )
//       );
//     }

//     transaction._message = message;
//     transaction._json = transaction.toJson();

//     return transaction;
//   }

//   /// Decodes the transaction signatures from the `base-64` [encoded] transaction.
//   static List<TransactionSignature> decodeSignatures(final String encoded) {
//     final List<TransactionSignature> signatures = [];
//     final Uint8List decoded = base64.decode(encoded);
//     final BufferReader reader = BufferReader.fromUint8List(decoded);
//     final int numberOfSignatures = reader.getUint8();
//     for (int _i = 0; _i < numberOfSignatures; ++_i) {
//       signatures.add(base58.encode(reader.getBuffer(nacl.signatureLength).asUint8List()));
//     }
//     return signatures;
//   }
// }
