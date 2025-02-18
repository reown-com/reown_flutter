// /// Imports
// /// ------------------------------------------------------------------------------------------------

// import 'dart:typed_data' show Uint8List;
// import 'package:json_annotation/json_annotation.dart' show JsonSerializable;
// import 'package:reown_appkit/solana/solana_buffer/buffer.dart';
// import 'package:reown_appkit/solana/solana_common/convert.dart';
// import 'package:reown_appkit/solana/solana_common/models.dart';
// import '../encodings/shortvec.dart' as shortvec;
// import '../crypto/nacl.dart' as nacl show pubkeyLength;
// import '../crypto/pubkey.dart';
// import '../transactions/constants.dart';
// import '../transactions/transaction.dart';
// import 'message_address_table_lookup.dart';
// import 'message_header.dart';
// import 'message_instruction.dart';

// part 'message.g.dart';

// /// Message
// /// ------------------------------------------------------------------------------------------------

// @JsonSerializable(explicitToJson: true)
// class Message extends Serializable {

//   /// Creates a the list of [instructions] to be processed atomically by a transaction.
//   Message({
//     required this.version,
//     required this.accountKeys,
//     required this.header,
//     required this.recentBlockhash,
//     required this.instructions,
//     final List<MessageAddressTableLookup>? addressTableLookups,
//   }): addressTableLookups = const [] {
//     for (final MessageInstruction instruction in instructions) {
//       final int index = instruction.programIdIndex;
//       _indexToProgramIds[index] = accountKeys[index];
//     }
//   }

//   /// The message version (`null` == legacy).
//   final int? version;

//   /// List of base-58 encoded public keys used by the transaction, including the instructions and
//   /// signatures. The first [MessageHeader.numRequiredSignatures] public keys must sign the
//   /// transaction.
//   ///
//   /// ### Example:
//   ///
//   ///   If [accountKeys] = `['pk1', 'pk0', 'pk4', 'pk2', 'pk5']`,
//   ///
//   ///   and [MessageHeader.numRequiredSignatures] = `2`,
//   ///
//   ///   then [Transaction.signatures] must be = `['message signed by pk1', 'message signed by pk0']`
//   ///
//   final List<Pubkey> accountKeys;

//   /// The account types and signatures required by the transaction.
//   final MessageHeader header;

//    /// A base-58 encoded hash of a recent block in the ledger used to prevent transaction
//    /// duplication and to give transactions lifetimes.
//   final String recentBlockhash;

//   /// A list of program instructions that will be executed in sequence and committed in one atomic
//   /// transaction if all succeed.
//   final Iterable<MessageInstruction> instructions;

//   /// A list of address table lookups used by a transaction to dynamically load addresses from
//   /// on-chain address lookup tables.
//   final List<MessageAddressTableLookup> addressTableLookups;

//   /// Map each program id index to its corresponding account key.
//   final Map<int, Pubkey> _indexToProgramIds = {};

//   /// Creates a `legacy` message.
//   factory Message.legacy({
//     required final List<Pubkey> accountKeys,
//     required final MessageHeader header,
//     required final String recentBlockhash,
//     required final Iterable<MessageInstruction> instructions,
//   }) => Message(
//     version: null,
//     accountKeys: accountKeys,
//     header: header,
//     recentBlockhash: recentBlockhash,
//     instructions: instructions,
//   );

//   /// Creates a `v0` message.
//   factory Message.v0({
//     required final List<Pubkey> accountKeys,
//     required final MessageHeader header,
//     required final String recentBlockhash,
//     required final Iterable<MessageInstruction> instructions,
//   final List<MessageAddressTableLookup>? addressTableLookups,
//   }) => Message(
//     version: 0,
//     accountKeys: accountKeys,
//     header: header,
//     recentBlockhash: recentBlockhash,
//     instructions: instructions,
//     addressTableLookups: addressTableLookups,
//   );

//   /// {@macro solana_common.Serializable.fromJson}
//   factory Message.fromJson(final Map<String, dynamic> json) => _$MessageFromJson(json);

//   @override
//   Map<String, dynamic> toJson() => _$MessageToJson(this);

//   /// Check if the account at [index] is a signer account.
//   bool isAccountSigner(final int index) {
//     return index < header.numRequiredSignatures;
//   }

//   /// Check if the account at [index] is a writable account.
//   bool isAccountWritable(final int index) {
//     if (index >= accountKeys.length) {
//       int lookupWritableOffset = accountKeys.length;
//       for (final MessageAddressTableLookup lookup in addressTableLookups) {
//         lookupWritableOffset += lookup.writableIndexes.length;
//         if (index < lookupWritableOffset) return true;
//       }
//       return false;
//     } else {
//       return index < header.numRequiredSignatures - header.numReadonlySignedAccounts
//         || (index >= header.numRequiredSignatures
//           && index < accountKeys.length - header.numReadonlyUnsignedAccounts);
//     }
//   }

//   /// Check if the account at [index] is a program account.
//   bool isProgramId(final int index) {
//     return _indexToProgramIds.containsKey(index);
//   }

//   /// The programs accounts.
//   Iterable<Pubkey> get programIds {
//     return _indexToProgramIds.values;
//   }

//   /// The non-programs accounts.
//   Iterable<Pubkey> get nonProgramIds {
//     int index = 0;
//     return accountKeys.where((_) => !isProgramId(index++));
//   }

//   /// Encodes this message into a buffer.
//   Buffer serialize() {

//     // Create a fixed-length writable buffer for signed data.
//     final signaturesBuffer = BufferWriter(2048);

//     // Write the version number.
//     final int? version = this.version;
//     if (version != null) {
//       final int maskedVersion = versionPrefixFlag | version;
//       signaturesBuffer.setUint8(maskedVersion);
//     }

//     /// Write the message header.
//     signaturesBuffer.setUint8(header.numRequiredSignatures);
//     signaturesBuffer.setUint8(header.numReadonlySignedAccounts);
//     signaturesBuffer.setUint8(header.numReadonlyUnsignedAccounts);

//     // Write the encoded account keys length.
//     final int keysLength = accountKeys.length;
//     signaturesBuffer.setBuffer(shortvec.encodeLength(keysLength));

//     /// Write the account addresses.
//     for (final accountKey in accountKeys) {
//       signaturesBuffer.setBuffer(accountKey.toBytes());
//     }

//     /// Write the 32-byte SHA-256 hash.
//     signaturesBuffer.setBuffer(base58.decode(recentBlockhash));

//     // Create a fixed-length writable buffer with the maximum packet size.
//     final instructionsBuffer = BufferWriter(packetDataSize);

//     // Write the encoded instructions length.
//     final List<int> ixsEncodedLength = shortvec.encodeLength(instructions.length);
//     instructionsBuffer.setBuffer(ixsEncodedLength);

//     // Write the message instructions.
//     for (final MessageInstruction instruction in instructions) {

//       // Program ID index.
//       final int programIdIndex = instruction.programIdIndex;
//       instructionsBuffer.setUint8(programIdIndex);

//       // Compact array of account address indexes.
//       final List<int> keyIndicesCount = shortvec.encodeLength(instruction.accounts.length);
//       instructionsBuffer.setBuffer(keyIndicesCount);
//       final Iterable<int> keyIndices = instruction.accounts;
//       instructionsBuffer.setBuffer(keyIndices);

//       // Compact array of opaque 8-bit data.
//       final Uint8List data = base58.decode(instruction.data);
//       final List<int> dataLength = shortvec.encodeLength(data.length);
//       instructionsBuffer.setBuffer(dataLength);
//       instructionsBuffer.setBuffer(data);
//     }

//     // Create a fixed-length writable buffer with the maximum packet size.
//     final addressTableLookupsBuffer = BufferWriter(packetDataSize);
//     if (version != null) {

//       // Write the encoded table lookups length.
//       final List<int> addressTableLookupsLength = shortvec.encodeLength(addressTableLookups.length);
//       addressTableLookupsBuffer.setBuffer(addressTableLookupsLength);

//       for (final MessageAddressTableLookup addressTableLookup in addressTableLookups) {

//         // Compact array of the writable indexes length.
//         final List<int> writableIndexes = addressTableLookup.writableIndexes;
//         final List<int> writableIndexesCount = shortvec.encodeLength(writableIndexes.length);

//         // Compact array of the readonly indexes length.
//         final List<int> readonlyIndexes = addressTableLookup.readonlyIndexes;
//         final List<int> readonlyIndexesCount = shortvec.encodeLength(readonlyIndexes.length);

//         addressTableLookupsBuffer.setBuffer(addressTableLookup.accountKey.toBytes());
//         addressTableLookupsBuffer.setBuffer(writableIndexesCount);
//         addressTableLookupsBuffer.setBuffer(writableIndexes);
//         addressTableLookupsBuffer.setBuffer(readonlyIndexesCount);
//         addressTableLookupsBuffer.setBuffer(readonlyIndexes);
//       }
//     }

//     /// Resize and merge the buffers.
//     return signaturesBuffer.toBuffer(slice: true)
//       + instructionsBuffer.toBuffer(slice: true)
//       + addressTableLookupsBuffer.toBuffer(slice: true);
//   }

//   /// Decodes a byte-array into a [Message] instance.
//   factory Message.fromList(final List<int> byteArray)
//     => Message.fromBuffer(Buffer.fromList(byteArray));

//   /// Decodes a `base-64` encoded string into a [Message] instance.
//   factory Message.fromBase64(final String encoded)
//     => Message.fromBuffer(Buffer.fromString(encoded, BufferEncoding.base64));

//   /// Decode a buffer into a [Message] instance.
//   factory Message.fromBuffer(final Buffer buffer)
//     => Message.fromBufferReader(buffer.reader);

//   /// Decodes a buffer reader into a [Message] instance.
//   factory Message.fromBufferReader(final BufferReader reader) {

//     /// Reader version.
//     final int prefix = reader[0];
//     final int maskedPrefix = prefix & versionPrefixMask;
//     final int? version = maskedPrefix != prefix ? (reader.getUint8() & versionPrefixMask) : null;

//     /// Read the message header.
//     final int numRequiredSignatures = reader.getUint8();
//     final int numReadonlySignedAccounts = reader.getUint8();
//     final int numReadonlyUnsignedAccounts = reader.getUint8();

//     /// Read the accounts.
//     final int accountCount = shortvec.decodeLength(reader);
//     final List<Pubkey> accountKeys = [];
//     for (int i = 0; i < accountCount; ++i) {
//       final Buffer account = reader.getBuffer(nacl.pubkeyLength);
//       accountKeys.add(Pubkey.fromUint8List(account.asUint8List()));
//     }

//     /// Read the blockhash.
//     final Buffer recentBlockhash = reader.getBuffer(nacl.pubkeyLength);

//     /// Read the instructions.
//     final int instructionCount = shortvec.decodeLength(reader);
//     final List<MessageInstruction> instructions = [];
//     for (int _i = 0; _i < instructionCount; ++_i) {
//       final int programIdIndex = reader.getUint8();
//       final int accountCount = shortvec.decodeLength(reader);
//       final accounts = reader.getBuffer(accountCount);
//       final int dataLength = shortvec.decodeLength(reader);
//       final Buffer dataSlice = reader.getBuffer(dataLength);
//       final String data = base58.encode(dataSlice.asUint8List());
//       instructions.add(
//         MessageInstruction(
//           programIdIndex: programIdIndex,
//           accounts: accounts,
//           data: data,
//         ),
//       );
//     }

//     /// Read the address table lookups.
//     List<MessageAddressTableLookup>? addressTableLookups;
//     if (version != null) {
//       addressTableLookups = [];
//       final int addressTableLookupsCount = shortvec.decodeLength(reader);
//       for (int _i = 0; _i < addressTableLookupsCount; ++_i) {
//         final Pubkey accountKey = Pubkey.fromBase58(reader.getString(nacl.pubkeyLength, BufferEncoding.base58));
//         final int writableIndexesCount = shortvec.decodeLength(reader);
//         final Iterable<int> writableIndexes = reader.getBuffer(writableIndexesCount);
//         final int readonlyIndexesCount = shortvec.decodeLength(reader);
//         final Iterable<int> readonlyIndexes = reader.getBuffer(readonlyIndexesCount);
//         addressTableLookups.add(
//           MessageAddressTableLookup(
//             accountKey: accountKey,
//             writableIndexes: writableIndexes.toList(growable: false),
//             readonlyIndexes: readonlyIndexes.toList(growable: false),
//           ),
//         );
//       }
//     }

//     return Message(
//       version: version,
//       accountKeys: accountKeys,
//       header: MessageHeader(
//         numRequiredSignatures: numRequiredSignatures,
//         numReadonlySignedAccounts: numReadonlySignedAccounts,
//         numReadonlyUnsignedAccounts: numReadonlyUnsignedAccounts,
//       ),
//       recentBlockhash: base58.encode(recentBlockhash.asUint8List()),
//       instructions: instructions,
//       addressTableLookups: addressTableLookups,
//     );
//   }

//   /// Serializes this message into an encoded string.
//   @override
//   String toString([
//     final BufferEncoding encoding = BufferEncoding.base64,
//   ]) => serialize().getString(encoding);
// }
