/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_borsh/borsh.dart';
import 'package:reown_appkit/solana/solana_borsh/codecs.dart';
import 'package:reown_appkit/solana/solana_buffer/buffer.dart';
import 'package:reown_appkit/solana/solana_common/extensions.dart';
import 'package:reown_appkit/solana/solana_common/types.dart';
import '../../constants/sysvar.dart';
import '../../crypto/pubkey.dart';
import '../../transactions/nonce_account.dart';
import '../../transactions/account_meta.dart';
import '../../transactions/transaction_instruction.dart';
import '../program.dart';
import 'instruction.dart';

/// System Program
/// ------------------------------------------------------------------------------------------------

class SystemProgram extends Program {
  /// System program.
  SystemProgram._() : super(Pubkey.zero());

  /// Internal singleton instance.
  static final SystemProgram _instance = SystemProgram._();

  /// The program id.
  static Pubkey get programId => _instance.pubkey;

  @override
  Iterable<int> encodeInstruction<T extends Enum>(final T instruction) =>
      Buffer.fromUint32(instruction.index);

  /// Generates a transaction instruction that creates a new account.
  ///
  /// ### Keys:
  /// - `[w,s]` [fromPubkey] - The account that will transfer lamports to the created account.
  /// - `[w,s]` [newAccountPubkey] - The public key of the created account.
  ///
  /// ### Data:
  /// - [lamports] - The amount of lamports to transfer to the created account.
  /// - [space] - The amount of space in bytes to allocate to the created account.
  /// - [programId] - The public key of the program to assign as the owner of the created account.
  static TransactionInstruction createAccount({
    required final Pubkey fromPubkey,
    required final Pubkey newAccountPubkey,
    required final bu64 lamports,
    required final bu64 space,
    required final Pubkey programId,
  }) {
    final List<AccountMeta> keys = [
      AccountMeta.signerAndWritable(fromPubkey),
      AccountMeta.signerAndWritable(newAccountPubkey),
    ];

    final List<Iterable<int>> data = [
      borsh.u64.encode(lamports),
      borsh.u64.encode(space),
      borsh.pubkey.encode(programId.toBase58()),
    ];

    return _instance.createTransactionIntruction(
      SystemInstruction.create,
      keys: keys,
      data: data,
    );
  }

  /// Generates a transaction instruction that transfers lamports from one account to another.
  ///
  /// ### Keys:
  /// - [fromPubkey] The account that will transfer lamports.
  /// - [toPubkey] The account that will receive transferred lamports.
  ///
  /// ### Data:
  /// - [lamports] The amount of lamports to transfer.
  static TransactionInstruction transfer({
    required final Pubkey fromPubkey,
    required final Pubkey toPubkey,
    required final BigInt lamports,
  }) {
    final List<AccountMeta> keys = [
      AccountMeta.signerAndWritable(fromPubkey),
      AccountMeta.writable(toPubkey),
    ];

    final List<Iterable<int>> data = [borsh.u64.encode(lamports)];

    return _instance.createTransactionIntruction(
      SystemInstruction.transfer,
      keys: keys,
      data: data,
    );
  }

  /// Generates a transaction instruction that transfers lamports from one account to another.
  ///
  /// ### Keys:
  /// - [fromPubkey] The account that will transfer lamports.
  /// - [basePubkey] The base public key used to derive the funding account address.
  /// - [toPubkey] The account that will receive the transferred lamports.
  ///
  /// ### Data:
  /// - [lamports] The amount of lamports to transfer.
  /// - [seed] The seed used to derive the funding account address.
  /// - [programId] The program id used to derive the funding account address.
  static TransactionInstruction transferWithSeed({
    required final Pubkey fromPubkey,
    required final Pubkey basePubkey,
    required final Pubkey toPubkey,
    required final BigInt lamports,
    required final String seed,
    required final Pubkey programId,
  }) {
    final List<AccountMeta> keys = [
      AccountMeta.writable(fromPubkey),
      AccountMeta.signer(basePubkey),
      AccountMeta.writable(toPubkey),
    ];

    final List<Iterable<int>> data = [
      borsh.u64.encode(lamports),
      borsh.rustString().encode(seed),
      borsh.pubkey.encode(programId.toBase58()),
    ];

    return _instance.createTransactionIntruction(
      SystemInstruction.transferWithSeed,
      keys: keys,
      data: data,
    );
  }

  /// Generates a transaction instruction that assigns an account to a program.
  ///
  /// ### Keys:
  /// - [accountPubkey] The public key of the account which will be assigned a new owner.
  ///
  /// ### Data:
  /// - [programId] The public key of the program to assign as the owner.
  static TransactionInstruction assign({
    required final Pubkey accountPubkey,
    required final Pubkey programId,
  }) {
    final List<AccountMeta> keys = [
      AccountMeta.signerAndWritable(accountPubkey),
    ];

    final List<Iterable<int>> data = [
      borsh.pubkey.encode(programId.toBase58()),
    ];

    return _instance.createTransactionIntruction(
      SystemInstruction.assign,
      keys: keys,
      data: data,
    );
  }

  /// Generates a transaction instruction that assigns an account to a program.
  ///
  /// ### Keys:
  /// - [accountPubkey] The public key of the account which will be assigned a new owner.
  ///
  /// ### Data:
  /// - [basePubkey] The base public key used to derive the address of the assigned account.
  /// - [seed] The seed used to derive the address of the assigned account.
  /// - [programId] The public key of the program to assign as the owner.
  static TransactionInstruction assignWithSeed({
    required final Pubkey accountPubkey,
    required final Pubkey basePubkey,
    required final String seed,
    required final Pubkey programId,
  }) {
    final List<AccountMeta> keys = [
      AccountMeta.writable(accountPubkey),
      AccountMeta.signer(basePubkey),
    ];

    final List<Iterable<int>> data = [
      borsh.pubkey.encode(basePubkey.toBase58()),
      borsh.rustString().encode(seed),
      borsh.pubkey.encode(programId.toBase58()),
    ];

    return _instance.createTransactionIntruction(
      SystemInstruction.assignWithSeed,
      keys: keys,
      data: data,
    );
  }

  /// Creates a transaction instruction that creates a new account at an address generated with
  /// `fromPubkey`, a `seed`, and `programId`.
  ///
  /// ### Keys:
  /// - [fromPubkey] The account that will transfer lamports to the created account.
  /// - [newAccountPubkey] The public key of the created account. Must be pre-calculated with
  ///   Pubkey.createWithSeed().
  ///
  /// ### Data:
  /// - [basePubkey] The base public key used to derive the address of the created account. Must be
  ///   the same as the base key used to create `newAccountPubkey`.
  /// - [seed] The seed used to derive the address of the created account. Must be the same as the
  ///   seed used to create `newAccountPubkey`.
  /// - [lamports] The amount of lamports to transfer to the created account.
  /// - [space] The amount of space in bytes to allocate to the created account.
  /// - [programId] The public key of the program to assign as the owner of the created account.
  static TransactionInstruction createAccountWithSeed({
    required final Pubkey fromPubkey,
    required final Pubkey newAccountPubkey,
    required final Pubkey basePubkey,
    required final String seed,
    required final bu64 lamports,
    required final bu64 space,
    required final Pubkey programId,
  }) {
    final List<AccountMeta> keys = [
      AccountMeta.signerAndWritable(fromPubkey),
      AccountMeta.writable(newAccountPubkey),
      if (fromPubkey != basePubkey) AccountMeta.signer(basePubkey),
    ];

    final List<Iterable<int>> data = [
      borsh.pubkey.encode(basePubkey.toBase58()),
      borsh.rustString().encode(seed),
      borsh.u64.encode(lamports),
      borsh.u64.encode(space),
      borsh.pubkey.encode(programId.toBase58()),
    ];

    return _instance.createTransactionIntruction(
      SystemInstruction.createWithSeed,
      keys: keys,
      data: data,
    );
  }

  /// Generates a transaction that creates a new Nonce account.
  ///
  /// ### Keys:
  /// - `[s, w]` [fromPubkey] The account that will transfer lamports to the created nonce account.
  /// - `[s, w]` [noncePubkey] The public key of the created nonce account.
  /// - `[]` [authorizedPubkey] The public key to set as the authority of the created nonce account.
  ///
  /// ### Data:
  /// - [lamports] The amount of lamports to transfer to the created nonce account.
  static List<TransactionInstruction> createNonceAccount({
    required final Pubkey fromPubkey,
    required final Pubkey noncePubkey,
    required final Pubkey authorizedPubkey,
    required final bu64 lamports,
  }) => [
    SystemProgram.createAccount(
      fromPubkey: fromPubkey,
      newAccountPubkey: noncePubkey,
      lamports: lamports,
      space: NonceAccount.length.toBigInt(),
      programId: SystemProgram.programId,
    ),
    nonceInitialize(
      noncePubkey: noncePubkey,
      authorizedPubkey: authorizedPubkey,
    ),
  ];

  /// Generates a transaction that creates a new Nonce account.
  ///
  /// ### Keys:
  /// - `[s, w]` [fromPubkey] The account that will transfer lamports to the created nonce account.
  /// - `[s, w]` [noncePubkey] The public key of the created nonce account.
  /// - `[]` [authorizedPubkey] The public key to set as the authority of the created nonce account.
  ///
  /// ### Data:
  /// - [lamports] The amount of lamports to transfer to the created nonce account.
  /// - [basePubkey] The base public key used to derive the address of the nonce account.
  /// - [seed] The seed used to derive the address of the nonce account.
  static List<TransactionInstruction> createNonceAccountWithSeed({
    required final Pubkey fromPubkey,
    required final Pubkey noncePubkey,
    required final Pubkey authorizedPubkey,
    required final bu64 lamports,
    required final Pubkey basePubkey,
    required final String seed,
  }) => [
    SystemProgram.createAccountWithSeed(
      fromPubkey: fromPubkey,
      newAccountPubkey: noncePubkey,
      basePubkey: basePubkey,
      seed: seed,
      lamports: lamports,
      space: NonceAccount.length.toBigInt(),
      programId: SystemProgram.programId,
    ),
    nonceInitialize(
      noncePubkey: noncePubkey,
      authorizedPubkey: authorizedPubkey,
    ),
  ];

  /// Generates an instruction to initialize a Nonce account.
  ///
  /// ### Keys:
  /// - `[w]` [noncePubkey] The nonce account.
  ///
  /// ### Data:
  /// - [authorizedPubkey] The public key of the nonce authority.
  static TransactionInstruction nonceInitialize({
    required final Pubkey noncePubkey,
    required final Pubkey authorizedPubkey,
  }) {
    final List<AccountMeta> keys = [
      AccountMeta.writable(noncePubkey),
      AccountMeta(sysvarRecentBlockhashesPubkey),
      AccountMeta(sysvarRentPubkey),
    ];

    final List<Iterable<int>> data = [
      borsh.pubkey.encode(authorizedPubkey.toBase58()),
    ];

    return _instance.createTransactionIntruction(
      SystemInstruction.initializeNonceAccount,
      keys: keys,
      data: data,
    );
  }

  /// Generates an instruction to advance the nonce in a Nonce account.
  ///
  /// ### Keys:
  /// - `[w]` [noncePubkey] The nonce account.
  /// - `[s]` [authorizedPubkey] The public key of the nonce authority.
  static TransactionInstruction nonceAdvance({
    required final Pubkey noncePubkey,
    required final Pubkey authorizedPubkey,
  }) {
    final List<AccountMeta> keys = [
      AccountMeta.writable(noncePubkey),
      AccountMeta(sysvarRecentBlockhashesPubkey),
      AccountMeta.signer(authorizedPubkey),
    ];

    return _instance.createTransactionIntruction(
      SystemInstruction.advanceNonceAccount,
      keys: keys,
    );
  }

  /// Generates a transaction instruction that withdraws lamports from a Nonce account.
  ///
  /// ### Keys:
  /// - `[w]` [noncePubkey] The nonce account.
  /// - `[s]` [authorizedPubkey] The public key of the nonce authority.
  /// - `[w]` [toPubkey] The public key of the account which will receive the withdrawn nonce
  ///   account balance.
  ///
  /// ### Data:
  /// - [lamports] The mount of lamports to withdraw from the nonce account.
  static TransactionInstruction nonceWithdraw({
    required final Pubkey noncePubkey,
    required final Pubkey authorizedPubkey,
    required final Pubkey toPubkey,
    required final bu64 lamports,
  }) {
    final List<AccountMeta> keys = [
      AccountMeta.writable(noncePubkey),
      AccountMeta.writable(toPubkey),
      AccountMeta(sysvarRecentBlockhashesPubkey),
      AccountMeta(sysvarRentPubkey),
      AccountMeta.signer(authorizedPubkey),
    ];

    final List<Iterable<int>> data = [borsh.u64.encode(lamports)];

    return _instance.createTransactionIntruction(
      SystemInstruction.withdrawNonceAccount,
      keys: keys,
      data: data,
    );
  }

  /// Generates a transaction instruction that authorises a new Pubkey as the authority on a
  /// Nonce account.
  ///
  /// ### Keys:
  /// - `[w]` [noncePubkey] The nonce account.
  /// - `[s]` [authorizedPubkey] The public key of the current nonce authority.
  ///
  /// ### Data:
  /// - [newAuthorizedPubkey] The public key to set as the new nonce authority.
  static TransactionInstruction nonceAuthorize({
    required final Pubkey noncePubkey,
    required final Pubkey authorizedPubkey,
    required final Pubkey newAuthorizedPubkey,
  }) {
    final List<AccountMeta> keys = [
      AccountMeta.writable(noncePubkey),
      AccountMeta.signer(authorizedPubkey),
    ];

    final List<Iterable<int>> data = [
      borsh.pubkey.encode(newAuthorizedPubkey.toBase58()),
    ];

    return _instance.createTransactionIntruction(
      SystemInstruction.authorizeNonceAccount,
      keys: keys,
      data: data,
    );
  }

  /// Generates a transaction instruction that allocates space in an account without funding.
  ///
  /// ### Keys:
  /// - `[s, w]` [accountPubkey] The public key of the account which will be assigned a new owner.
  ///
  /// ### Data:
  /// - [space] The amount of space in bytes to allocate.
  static TransactionInstruction allocate({
    required final Pubkey accountPubkey,
    required final bu64 space,
  }) {
    final List<AccountMeta> keys = [
      AccountMeta.signerAndWritable(accountPubkey),
    ];

    final List<Iterable<int>> data = [borsh.u64.encode(space)];

    return _instance.createTransactionIntruction(
      SystemInstruction.allocate,
      keys: keys,
      data: data,
    );
  }

  /// Generates a transaction instruction that allocates space in an account without funding.
  ///
  /// ### Keys:
  /// - `[w]` [accountPubkey] The public key of the account which will be assigned a new owner.
  /// - `[s]` [basePubkey] The base public key used to derive the address of the assigned account.
  ///
  /// ### Data:
  /// - [basePubkey] The base public key used to derive the address of the assigned account.
  /// - [seed] The seed used to derive the address of the assigned account.
  /// - [space] The amount of space in bytes to allocate.
  /// - [programId] The public key of the program to assign as the owner.
  static TransactionInstruction allocateWithSeed({
    required final Pubkey accountPubkey,
    required final Pubkey basePubkey,
    required final String seed,
    required final bu64 space,
    required final Pubkey programId,
  }) {
    final List<AccountMeta> keys = [
      AccountMeta.writable(accountPubkey),
      AccountMeta.signer(basePubkey),
    ];

    final BorshStringSizedCodec pubkey = borsh.pubkey;
    final List<Iterable<int>> data = [
      pubkey.encode(basePubkey.toBase58()),
      borsh.rustString().encode(seed),
      borsh.u64.encode(space),
      pubkey.encode(programId.toBase58()),
    ];

    return _instance.createTransactionIntruction(
      SystemInstruction.allocateWithSeed,
      keys: keys,
      data: data,
    );
  }
}
