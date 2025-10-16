/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'dart:collection';
import 'dart:typed_data' show Uint8List;
import 'package:json_annotation/json_annotation.dart' show JsonSerializable;
import 'package:reown_appkit/solana/solana_buffer/buffer.dart';
import 'package:reown_appkit/solana/solana_common/models.dart';
import 'package:reown_appkit/solana/solana_common/validators.dart';
import 'package:reown_appkit/solana/solana_web3/src/programs/address_lookup_table/state.dart';
import 'package:reown_appkit/solana/solana_web3/src/transactions/account_meta.dart';
import 'package:reown_appkit/solana/solana_web3/src/transactions/transaction_instruction.dart';
import 'package:reown_appkit/solana/solana_web3/src/types.dart';
import 'package:reown_core/reown_core.dart';
import '../encodings/shortvec.dart' as shortvec;
import '../crypto/nacl.dart' as nacl show pubkeyLength;
import '../crypto/pubkey.dart';
import '../transactions/constants.dart';
import '../transactions/transaction.dart';
import 'message_address_table_lookup.dart';
import 'message_header.dart';
import 'message_instruction.dart';

part 'message.g.dart';

/// Message
/// ------------------------------------------------------------------------------------------------

@JsonSerializable(explicitToJson: true)
class Message extends Serializable {
  /// Creates a the list of [instructions] to be processed atomically by a transaction.
  const Message({
    required this.version,
    required this.header,
    required this.accountKeys,
    required this.recentBlockhash,
    required this.instructions,
    required final List<MessageAddressTableLookup>? addressTableLookups,
  }) : addressTableLookups = const [];

  /// The transaction/message version (`null` == legacy).
  final int? version;

  /// The account types and signatures required by the transaction.
  final MessageHeader header;

  /// List of base-58 encoded public keys used by the transaction, including the instructions and
  /// signatures. The first [MessageHeader.numRequiredSignatures] public keys must sign the
  /// transaction.
  ///
  /// ### Example:
  ///
  ///   If [accountKeys] = `['pk1', 'pk0', 'pk4', 'pk2', 'pk5']`,
  ///
  ///   and [MessageHeader.numRequiredSignatures] = `2`,
  ///
  ///   then [Transaction.signatures] must be = `['message signed by pk1', 'message signed by pk0']`
  ///
  final List<Pubkey> accountKeys;

  /// A base-58 encoded hash of a recent block in the ledger used to prevent transaction
  /// duplication and to give transactions lifetimes.
  final String recentBlockhash;

  /// A list of program instructions that will be executed in sequence and committed in one atomic
  /// transaction if all succeed.
  final Iterable<MessageInstruction> instructions;

  /// A list of address table lookups used by a transaction to dynamically load addresses from
  /// on-chain address lookup tables.
  final List<MessageAddressTableLookup> addressTableLookups;

  /// Creates a `legacy` message.
  factory Message.legacy({
    required final Pubkey payer,
    required final List<TransactionInstruction> instructions,
    required final Blockhash recentBlockhash,
  }) => Message.compile(
    version: null,
    payer: payer,
    instructions: instructions,
    recentBlockhash: recentBlockhash,
  );

  /// Creates a `v0` message.
  factory Message.v0({
    required final Pubkey payer,
    required final List<TransactionInstruction> instructions,
    required final Blockhash recentBlockhash,
    final List<AddressLookupTableAccount>? addressLookupTableAccounts,
  }) => Message.compile(
    version: 0,
    payer: payer,
    instructions: instructions,
    recentBlockhash: recentBlockhash,
    addressLookupTableAccounts: addressLookupTableAccounts,
  );

  /// Creates a transaction message.
  factory Message.compile({
    required final int? version,
    required final Pubkey payer,
    required final List<TransactionInstruction> instructions,
    required final Blockhash recentBlockhash,
    final List<AddressLookupTableAccount>? addressLookupTableAccounts,
  }) {
    /// Program account keys.
    final HashSet<Pubkey> programMetasMap = HashSet();

    /// Static account keys (i.e. all non address table lookup keys).
    final Map<Pubkey, AccountMeta> staticAccountMetasMap = {};

    /// Add the fee payer account.
    staticAccountMetasMap[payer] = AccountMeta.signerAndWritable(payer);

    /// Add the program and instruction accounts.
    for (final TransactionInstruction instruction in instructions) {
      final AccountMeta programMeta = AccountMeta(instruction.programId);
      programMetasMap.add(instruction.programId);
      staticAccountMetasMap[instruction.programId] ??= programMeta;
      for (final AccountMeta key in instruction.keys) {
        final AccountMeta? meta = staticAccountMetasMap[key.pubkey];
        staticAccountMetasMap[key.pubkey] =
            meta?.copyWith(
              isSigner: meta.isSigner || key.isSigner,
              isWritable: meta.isWritable || key.isWritable,
            ) ??
            key;
      }
    }

    /// Address table lookups.
    final List<MessageAddressTableLookup> addressTableLookups = [];
    final List<Pubkey> writableLookups = [];
    final List<Pubkey> readonlyLookups = [];

    /// Extract address table lookup accounts from [staticAccountMetasMap].
    for (final AddressLookupTableAccount lookupAccount
        in addressLookupTableAccounts ?? const []) {
      final List<Pubkey> lookupAddresses = lookupAccount.state.addresses;
      final List<int> writableIndexes = [];
      final List<int> readonlyIndexes = [];
      for (int i = 0; i < lookupAddresses.length; ++i) {
        final Pubkey lookupAddress = lookupAddresses[i];
        final AccountMeta? meta = staticAccountMetasMap[lookupAddress];
        if (meta != null &&
            !meta.isSigner &&
            !programMetasMap.contains(meta.pubkey)) {
          check(i < 256, 'Address lookup table index $i exceeds the max 255.');
          staticAccountMetasMap.remove(lookupAddress);
          if (meta.isWritable) {
            writableIndexes.add(i);
            writableLookups.add(lookupAddress);
          } else {
            readonlyIndexes.add(i);
            readonlyLookups.add(lookupAddress);
          }
        }
      }
      if (writableIndexes.isNotEmpty || readonlyIndexes.isNotEmpty) {
        addressTableLookups.add(
          MessageAddressTableLookup(
            accountKey: lookupAccount.key,
            writableIndexes: writableIndexes,
            readonlyIndexes: readonlyIndexes,
          ),
        );
      }
    }

    // Sort by signer accounts, followed by writable accounts.
    final List<AccountMeta> staticAccountMetas = staticAccountMetasMap.values
        .toList(growable: false);
    staticAccountMetas.sort((final AccountMeta x, final AccountMeta y) {
      // Signers must be placed before non-signers.
      if (x.isSigner != y.isSigner) {
        return x.isSigner ? -1 : 1;
      }
      // Writable accounts must be placed before read-only accounts.
      if (x.isWritable != y.isWritable) {
        return x.isWritable ? -1 : 1;
      }
      return 0;
    });

    // Group the accounts.
    final List<Pubkey> writableSigners = [];
    final List<Pubkey> readonlySigners = [];
    final List<Pubkey> writableNonSigners = [];
    final List<Pubkey> readonlyNonSigners = [];
    for (final AccountMeta meta in staticAccountMetas) {
      if (meta.isSigner) {
        meta.isWritable
            ? writableSigners.add(meta.pubkey)
            : readonlySigners.add(meta.pubkey);
      } else {
        meta.isWritable
            ? writableNonSigners.add(meta.pubkey)
            : readonlyNonSigners.add(meta.pubkey);
      }
    }

    // Create the header.
    final MessageHeader header = MessageHeader(
      numRequiredSignatures: writableSigners.length + readonlySigners.length,
      numReadonlySignedAccounts: readonlySigners.length,
      numReadonlyUnsignedAccounts: readonlyNonSigners.length,
    );

    // Collect static account keys.
    final List<Pubkey> staticAccountKeys =
        writableSigners +
        readonlySigners +
        writableNonSigners +
        readonlyNonSigners;

    // Collect all account keys.
    final List<Pubkey> accountKeys =
        staticAccountKeys + writableLookups + readonlyLookups;

    // DEBUG: Check that the first account is the payer.
    assert(accountKeys.first == payer, 'Missing payer.');

    // DEBUG: Check for duplicate accounts.
    assert(accountKeys.length == Set.of(accountKeys).length, 'Duplicate keys.');

    // Create map from account key to index.
    final Map<Pubkey, int> accountKeysMap = {};
    for (int i = 0; i < accountKeys.length; ++i) {
      accountKeysMap[accountKeys[i]] = i;
    }

    // Create message instructions.
    final List<MessageInstruction> compiledInstructions = [];
    for (final TransactionInstruction instruction in instructions) {
      compiledInstructions.add(
        MessageInstruction(
          programIdIndex: accountKeysMap[instruction.programId]!,
          accounts: instruction.keys.map((e) => accountKeysMap[e.pubkey]!),
          data: base58.encode(instruction.data),
        ),
      );
    }

    return Message(
      version: version,
      header: header,
      accountKeys: staticAccountKeys,
      recentBlockhash: recentBlockhash,
      instructions: compiledInstructions,
      addressTableLookups: addressTableLookups,
    );
  }

  /// The number of account keys contained within [addressTableLookups].
  int get numAccountKeysFromLookups => addressTableLookups.fold(
    0,
    (total, lookup) =>
        total + lookup.readonlyIndexes.length + lookup.writableIndexes.length,
  );

  // /// Map each program id index to its corresponding account key.
  // final Map<int, Pubkey> _indexToProgramIds = {};

  /// {@macro solana_common.Serializable.fromJson}
  factory Message.fromJson(final Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MessageToJson(this);

  /// Check if the account at [index] is a signer account.
  bool isAccountSigner(final int index) {
    return index < header.numRequiredSignatures;
  }

  /// Check if the account at [index] is a writable account.
  bool isAccountWritable(final int index) {
    if (index >= accountKeys.length) {
      int lookupWritableOffset = accountKeys.length;
      for (final MessageAddressTableLookup lookup in addressTableLookups) {
        lookupWritableOffset += lookup.writableIndexes.length;
        if (index < lookupWritableOffset) return true;
      }
      return false;
    } else {
      return index <
              header.numRequiredSignatures - header.numReadonlySignedAccounts ||
          (index >= header.numRequiredSignatures &&
              index < accountKeys.length - header.numReadonlyUnsignedAccounts);
    }
  }

  /// The programs accounts.
  Iterable<Pubkey> programIds() {
    final List<Pubkey> programIds = [];
    for (final MessageInstruction instruction in instructions) {
      final int index = instruction.programIdIndex;
      programIds.add(accountKeys[index]);
    }
    return programIds;
  }

  /// The non-programs accounts.
  Iterable<Pubkey> nonProgramIds() {
    final Iterable<Pubkey> programIds = this.programIds();
    return accountKeys.where((pubkey) => !programIds.contains(pubkey));
  }

  /// Encodes this message into a buffer.
  Buffer serialize() {
    // Create a fixed-length writable buffer for signed data.
    final signaturesBuffer = BufferWriter(2048);

    // Write the version number.
    final int? version = this.version;
    if (version != null) {
      final int maskedVersion = versionPrefixFlag | version;
      signaturesBuffer.setUint8(maskedVersion);
    }

    /// Write the message header.
    signaturesBuffer.setUint8(header.numRequiredSignatures);
    signaturesBuffer.setUint8(header.numReadonlySignedAccounts);
    signaturesBuffer.setUint8(header.numReadonlyUnsignedAccounts);

    // Write the encoded account keys length.
    final int keysLength = accountKeys.length;
    signaturesBuffer.setBuffer(shortvec.encodeLength(keysLength));

    /// Write the account addresses.
    for (final accountKey in accountKeys) {
      signaturesBuffer.setBuffer(accountKey.toBytes());
    }

    /// Write the 32-byte SHA-256 hash.
    final Blockhash blockhash = recentBlockhash;
    // ignore: unnecessary_null_comparison
    check(blockhash != null, 'Message requires a recentBlockhash.');
    signaturesBuffer.setBuffer(base58.decode(blockhash));

    // Create a fixed-length writable buffer with the maximum packet size.
    final instructionsBuffer = BufferWriter(packetDataSize);

    // Write the encoded instructions length.
    final List<int> ixsEncodedLength = shortvec.encodeLength(
      instructions.length,
    );
    instructionsBuffer.setBuffer(ixsEncodedLength);

    // Write the message instructions.
    for (final MessageInstruction instruction in instructions) {
      // Program ID index.
      final int programIdIndex = instruction.programIdIndex;
      instructionsBuffer.setUint8(programIdIndex);

      // Compact array of account address indexes.
      final List<int> keyIndicesCount = shortvec.encodeLength(
        instruction.accounts.length,
      );
      instructionsBuffer.setBuffer(keyIndicesCount);
      final Iterable<int> keyIndices = instruction.accounts;
      instructionsBuffer.setBuffer(keyIndices);

      // Compact array of opaque 8-bit data.
      final Uint8List data = base58.decode(instruction.data);
      final List<int> dataLength = shortvec.encodeLength(data.length);
      instructionsBuffer.setBuffer(dataLength);
      instructionsBuffer.setBuffer(data);
    }

    // Create a fixed-length writable buffer with the maximum packet size.
    final addressTableLookupsBuffer = BufferWriter(packetDataSize);
    if (version != null) {
      // Write the encoded table lookups length.
      final List<int> addressTableLookupsLength = shortvec.encodeLength(
        addressTableLookups.length,
      );
      addressTableLookupsBuffer.setBuffer(addressTableLookupsLength);

      for (final MessageAddressTableLookup addressTableLookup
          in addressTableLookups) {
        // Compact array of the writable indexes length.
        final List<int> writableIndexes = addressTableLookup.writableIndexes;
        final List<int> writableIndexesCount = shortvec.encodeLength(
          writableIndexes.length,
        );

        // Compact array of the readonly indexes length.
        final List<int> readonlyIndexes = addressTableLookup.readonlyIndexes;
        final List<int> readonlyIndexesCount = shortvec.encodeLength(
          readonlyIndexes.length,
        );

        addressTableLookupsBuffer.setBuffer(
          addressTableLookup.accountKey.toBytes(),
        );
        addressTableLookupsBuffer.setBuffer(writableIndexesCount);
        addressTableLookupsBuffer.setBuffer(writableIndexes);
        addressTableLookupsBuffer.setBuffer(readonlyIndexesCount);
        addressTableLookupsBuffer.setBuffer(readonlyIndexes);
      }
    }

    /// Resize and merge the buffers.
    return signaturesBuffer.toBuffer(slice: true) +
        instructionsBuffer.toBuffer(slice: true) +
        addressTableLookupsBuffer.toBuffer(slice: true);
  }

  /// Decodes a byte-array into a [Message] instance.
  factory Message.fromList(final List<int> byteArray) =>
      Message.fromBuffer(Buffer.fromList(byteArray));

  /// Decodes a `base-58` encoded string into a [Message] instance.
  factory Message.fromBase58(final String encoded) =>
      Message.fromBuffer(Buffer.fromString(encoded, BufferEncoding.base58));

  /// Decodes a `base-64` encoded string into a [Message] instance.
  factory Message.fromBase64(final String encoded) =>
      Message.fromBuffer(Buffer.fromString(encoded, BufferEncoding.base64));

  /// Decode a buffer into a [Message] instance.
  factory Message.fromBuffer(final Buffer buffer) =>
      Message.fromBufferReader(buffer.reader);

  /// Decodes a buffer reader into a [Message] instance.
  factory Message.fromBufferReader(final BufferReader reader) {
    /// Read version.
    final int prefix = reader.getUint8();
    final int maskedPrefix = prefix & versionPrefixMask;
    final int? version = prefix != maskedPrefix ? maskedPrefix : null;
    if (version == null) reader.advance(-1); // unread the first byte.

    /// Read the message header.
    final int numRequiredSignatures = reader.getUint8();
    final int numReadonlySignedAccounts = reader.getUint8();
    final int numReadonlyUnsignedAccounts = reader.getUint8();

    /// Read the accounts.
    final int accountCount = shortvec.decodeLength(reader);
    final List<Pubkey> accountKeys = [];
    for (int i = 0; i < accountCount; ++i) {
      final Buffer account = reader.getBuffer(nacl.pubkeyLength);
      accountKeys.add(Pubkey.fromUint8List(account.asUint8List()));
    }

    /// Read the blockhash.
    final Buffer recentBlockhash = reader.getBuffer(nacl.pubkeyLength);

    /// Read the instructions.
    final int instructionCount = shortvec.decodeLength(reader);
    final List<MessageInstruction> instructions = [];
    for (int i = 0; i < instructionCount; ++i) {
      final int programIdIndex = reader.getUint8();
      final int accountCount = shortvec.decodeLength(reader);
      final accounts = reader.getBuffer(accountCount);
      final int dataLength = shortvec.decodeLength(reader);
      final Buffer dataSlice = reader.getBuffer(dataLength);
      final String data = base58.encode(dataSlice.asUint8List());
      instructions.add(
        MessageInstruction(
          programIdIndex: programIdIndex,
          accounts: accounts,
          data: data,
        ),
      );
    }

    /// Read the address table lookups.
    List<MessageAddressTableLookup>? addressTableLookups;
    if (version != null) {
      addressTableLookups = [];
      final int addressTableLookupsCount = shortvec.decodeLength(reader);
      for (int i = 0; i < addressTableLookupsCount; ++i) {
        final Pubkey accountKey = Pubkey.fromBase58(
          reader.getString(nacl.pubkeyLength, BufferEncoding.base58),
        );
        final int writableIndexesCount = shortvec.decodeLength(reader);
        final Iterable<int> writableIndexes = reader.getBuffer(
          writableIndexesCount,
        );
        final int readonlyIndexesCount = shortvec.decodeLength(reader);
        final Iterable<int> readonlyIndexes = reader.getBuffer(
          readonlyIndexesCount,
        );
        addressTableLookups.add(
          MessageAddressTableLookup(
            accountKey: accountKey,
            writableIndexes: writableIndexes.toList(growable: false),
            readonlyIndexes: readonlyIndexes.toList(growable: false),
          ),
        );
      }
    }

    return Message(
      version: version,
      accountKeys: accountKeys,
      header: MessageHeader(
        numRequiredSignatures: numRequiredSignatures,
        numReadonlySignedAccounts: numReadonlySignedAccounts,
        numReadonlyUnsignedAccounts: numReadonlyUnsignedAccounts,
      ),
      recentBlockhash: base58.encode(recentBlockhash.asUint8List()),
      instructions: instructions,
      addressTableLookups: addressTableLookups,
    );
  }

  /// Serializes this message into an encoded string.
  @override
  String toString([final BufferEncoding encoding = BufferEncoding.base64]) =>
      serialize().getString(encoding);
}
