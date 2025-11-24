/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_borsh/borsh.dart';
import 'package:reown_appkit/solana/solana_common/types.dart';
import 'package:reown_appkit/solana/solana_common/validators.dart';
import 'package:reown_appkit/solana/solana_web3/src/programs/token/state.dart';
import '../../constants/sysvar.dart';
import '../../crypto/pubkey.dart';
import '../../transactions/account_meta.dart';
import '../../transactions/transaction_instruction.dart';
import '../program.dart';
import 'instruction.dart';

/// Token Program
/// ------------------------------------------------------------------------------------------------

class TokenProgram extends Program {
  TokenProgram._()
    : super(Pubkey.fromBase58('TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA'));

  /// Internal singleton instance.
  static final TokenProgram _instance = TokenProgram._();

  /// The program id.
  static Pubkey get programId => _instance.pubkey;

  /// Minimum number of multisignature signers.
  static const minSigners = 1;

  /// Maximum number of multisignature signers.
  static const maxSigners = 11;

  /// Initializes a new mint and optionally deposits all the newly minted tokens in an account.
  ///
  /// The `initializeMint` instruction requires no signers and MUST be included within the same
  /// Transaction as the system program's `createAccount` instruction that creates the account being
  /// initialized. Otherwise another party can acquire ownership of the uninitialized account.
  ///
  /// ### Keys:
  /// - `[w]` [mint] - The mint to initialize.
  ///
  /// ### Data:
  /// - [decimals] - Number of base 10 digits to the right of the decimal place.
  /// - [mintAuthority] - The authority/multisignature to mint tokens.
  /// - [freezeAuthority] - The freeze authority/multisignature of the mint.
  static TransactionInstruction initializeMint({
    // Keys
    required final Pubkey mint,
    // Data
    required final u8 decimals,
    required final Pubkey mintAuthority,
    final Pubkey? freezeAuthority,
  }) {
    // 0. `[w]` The mint to initialize.
    // 1. `[]` Rent sysvar.
    final List<AccountMeta> keys = [
      AccountMeta.writable(mint),
      AccountMeta(sysvarRentPubkey),
    ];

    final List<Iterable<int>> data = [
      borsh.u8.encode(decimals),
      borsh.pubkey.encode(mintAuthority.toBase58()),
      borsh.pubkey.cOption().encode(freezeAuthority?.toBase58()),
    ];

    return _instance.createTransactionIntruction(
      TokenInstruction.initializeMint,
      keys: keys,
      data: data,
    );
  }

  /// Initializes a new account to hold tokens. If this account is associated with the native mint
  /// then the token balance of the initialized account will be equal to the amount of SOL in the
  /// account. If this account is associated with another mint, that mint must be initialized before
  /// this command can succeed.
  ///
  /// The `initializeAccount` instruction requires no signers and MUST be included within the same
  /// Transaction as the system program's `createAccount` instruction that creates the account being
  /// initialized. Otherwise another party can acquire ownership of the uninitialized account.
  ///
  /// ### Keys:
  /// - `[w]` [account] - The account to initialize.
  /// - `[]` [mint] - The mint this account will be associated with.
  /// - `[]` [owner] - The new account's owner/multisignature.
  static TransactionInstruction initializeAccount({
    required final Pubkey account,
    required final Pubkey mint,
    required final Pubkey owner,
  }) {
    // 0. `[writable]`  The account to initialize.
    // 1. `[]` The mint this account will be associated with.
    // 2. `[]` The new account's owner/multisignature.
    // 3. `[]` Rent sysvar
    final List<AccountMeta> keys = [
      AccountMeta.writable(account),
      AccountMeta(mint),
      AccountMeta(owner),
      AccountMeta(sysvarRentPubkey),
    ];

    return _instance.createTransactionIntruction(
      TokenInstruction.initializeAccount,
      keys: keys,
    );
  }

  /// Initializes a multisignature account with N provided signers.
  ///
  /// Multisignature accounts can used in place of any single owner/delegate accounts in any token
  /// instruction that require an owner/delegate to be present. The variant field represents the
  /// number of signers required to validate this multisignature account.
  ///
  /// The `initializeMultisig` instruction requires no signers and MUST be included within the same
  /// Transaction as the system program's `createAccount` instruction that creates the account being
  /// initialized. Otherwise another party can acquire ownership of the uninitialized account.
  ///
  /// ### Keys:
  /// - `[w]` [account] - The multisignature account to initialize.
  /// - `[]` [signers] - The signer accounts ([minSigners] : [maxSigners]).
  ///
  /// Data
  /// - [numberOfSigners] - The number of signers required to validate this multisignature account.
  static TransactionInstruction initializeMultisig({
    // Keys
    required final Pubkey account,
    required final List<Pubkey> signers,
    // Data
    required final u8 numberOfSigners,
  }) {
    // Validation
    checkGte(signers.length, minSigners, 'signers');
    checkLte(signers.length, maxSigners, 'signers');

    // 0. `[w]` The multisignature account to initialize.
    // 1. `[]` Rent sysvar.
    // 2. `[]` ..2+N The signer accounts, must equal to N where 1 <= N <= 11.
    final List<AccountMeta> keys = [
      AccountMeta.writable(account),
      AccountMeta(sysvarRentPubkey),
      for (final Pubkey signer in signers) AccountMeta(signer),
    ];

    final List<Iterable<int>> data = [borsh.u8.encode(numberOfSigners)];

    return _instance.createTransactionIntruction(
      TokenInstruction.initializeMultisig,
      keys: keys,
      data: data,
    );
  }

  /// Transfers tokens from one account to another either directly or via a delegate. If this
  /// account is associated with the native mint then equal amounts of SOL and Tokens will be
  /// transferred to the destination account.
  ///
  /// ### Keys:
  /// Single owner/delegate
  /// - `[w]` [source] - The source account.
  /// - `[w]` [destination] - The destination account.
  /// - `[s]` [owner] - The source account's owner/delegate.
  ///
  /// Multisignature owner/delegate
  /// - `[w]` [source] - The source account.
  /// - `[w]` [destination] - The destination account.
  /// - `[]` [owner] - The source account's multisignature owner/delegate.
  /// - `[s]` [signers] - The signer accounts.
  ///
  /// ### Data:
  /// - [amount] - The amount of tokens to transfer.
  static TransactionInstruction transfer({
    // Keys
    required final Pubkey source,
    required final Pubkey destination,
    required final Pubkey owner,
    final List<Pubkey> signers = const [],
    // Data
    required final bu64 amount,
  }) {
    // * Single owner/delegate
    // 0. `[w]` The source account.
    // 1. `[w]` The destination account.
    // 2. `[s]` The source account's owner/delegate.
    //
    // * Multisignature owner/delegate
    // 0. `[w]` The source account.
    // 1. `[w]` The destination account.
    // 2. `[]` The source account's multisignature owner/delegate.
    // 3. ..3+M `[s]` M signer accounts.
    final List<AccountMeta> keys = [
      AccountMeta.writable(source),
      AccountMeta.writable(destination),
      AccountMeta(owner, isSigner: signers.isEmpty),
      for (final Pubkey signer in signers) AccountMeta.signer(signer),
    ];

    final List<Iterable<int>> data = [borsh.u64.encode(amount)];

    return _instance.createTransactionIntruction(
      TokenInstruction.transfer,
      keys: keys,
      data: data,
    );
  }

  /// Approves a delegate. A delegate is given the authority over tokens on behalf of the source
  /// account's owner.
  ///
  /// ### Keys:
  /// Single owner
  /// - `[w]` [source] - The source account.
  /// - `[]` [delegate] - The delegate.
  /// - `[s]` [owner] - The source account owner.
  ///
  /// Multisignature owner
  /// - `[w]` [source] - The source account.
  /// - `[]` [delegate] - The delegate.
  /// - `[]` [owner] - The source account's multisignature owner.
  /// - `[s]` [signers] - The signer accounts.
  ///
  /// ### Data:
  /// - [amount] - The amount of tokens the delegate is approved for.
  static TransactionInstruction approve({
    // Keys
    required final Pubkey source,
    required final Pubkey delegate,
    required final Pubkey owner,
    final List<Pubkey> signers = const [],
    // Data
    required final bu64 amount,
  }) {
    // * Single owner
    // 0. `[w]` The source account.
    // 1. `[]` The delegate.
    // 2. `[s]` The source account owner.
    //
    // * Multisignature owner
    // 0. `[w]` The source account.
    // 1. `[]` The delegate.
    // 2. `[]` The source account's multisignature owner.
    // 3. ..3+M `[s]` M signer accounts
    final List<AccountMeta> keys = [
      AccountMeta.writable(source),
      AccountMeta(delegate),
      AccountMeta(owner, isSigner: signers.isEmpty),
      for (final Pubkey signer in signers) AccountMeta.signer(signer),
    ];

    final List<Iterable<int>> data = [borsh.u64.encode(amount)];

    return _instance.createTransactionIntruction(
      TokenInstruction.approve,
      keys: keys,
      data: data,
    );
  }

  /// Revokes the delegate's authority.
  ///
  /// ### Keys:
  /// Single owner
  /// - `[w]` [source] - The source account.
  /// - `[s]` [owner] - The source account owner.
  ///
  /// Multisignature owner
  /// - `[w]` [source] - The source account.
  /// - `[]`  [owner] - The source account's multisignature owner.
  /// - `[s]` [signers] - The signer accounts.
  static TransactionInstruction revoke({
    // Keys
    required final Pubkey source,
    required final Pubkey owner,
    final List<Pubkey> signers = const [],
  }) {
    // * Single owner
    // 0. `[w]` The source account.
    // 1. `[s]` The source account owner.
    ///
    // * Multisignature owner
    // 0. `[w]` The source account.
    // 1. `[]` The source account's multisignature owner.
    // 2. ..2+M `[s]` M signer accounts.
    final List<AccountMeta> keys = [
      AccountMeta.writable(source),
      AccountMeta(owner, isSigner: signers.isEmpty),
      for (final Pubkey signer in signers) AccountMeta.signer(signer),
    ];

    return _instance.createTransactionIntruction(
      TokenInstruction.revoke,
      keys: keys,
    );
  }

  /// Sets a new authority of a mint or account.
  ///
  /// ### Keys:
  /// Single authority
  /// - `[w]` [account] - The mint or account to change the authority of.
  /// - `[s]` [authority] - The current authority of the mint or account.
  ///
  /// Multisignature authority
  /// - `[w]` [account] - The mint or account to change the authority of.
  /// - `[]` [authority] - The mint's or account's current multisignature authority.
  /// - `[s]` [signers] - The signer accounts.
  ///
  /// ### Data:
  /// - [authorityType] - The type of authority to update.
  /// - [newAuthority] - The new authority.
  static TransactionInstruction setAuthority({
    // Keys
    required final Pubkey account,
    required final Pubkey authority,
    final List<Pubkey> signers = const [],
    // Data
    required final AuthorityType authorityType,
    required final Pubkey? newAuthority,
  }) {
    // * Single authority
    // 0. `[w]` The mint or account to change the authority of.
    // 1. `[s]` The current authority of the mint or account.
    //
    // * Multisignature authority
    // 0. `[w]` The mint or account to change the authority of.
    // 1. `[]` The mint's or account's current multisignature authority.
    // 2. `[s]` ..2+M, M signer accounts.
    final List<AccountMeta> keys = [
      AccountMeta.writable(account),
      AccountMeta(authority, isSigner: signers.isEmpty),
      for (final Pubkey signer in signers) AccountMeta.signer(signer),
    ];

    final List<Iterable<u8>> data = [
      borsh.enumeration(AuthorityType.values).encode(authorityType),
      borsh.pubkey.option().encode(newAuthority?.toBase58()),
    ];

    return _instance.createTransactionIntruction(
      TokenInstruction.setAuthority,
      keys: keys,
      data: data,
    );
  }

  /// Mints new tokens to an account.  The native mint does not support minting.
  ///
  /// ### Keys:
  /// Single authority
  /// - `[w]` [mint] - The mint.
  /// - `[w]` [account] - The account to mint tokens to.
  /// - `[s]` [mintAuthority] - The mint's minting authority.
  ///
  /// Multisignature authority
  /// - `[w]` [mint] - The mint.
  /// - `[w]` [account] - The account to mint tokens to.
  /// - `[]` [mintAuthority] - The mint's multisignature mint-tokens authority.
  /// - `[s]` [signers] - The signer accounts.
  ///
  /// ### Data:
  /// - [amount] - The amount of new tokens to mint.
  static TransactionInstruction mintTo({
    // Keys
    required final Pubkey mint,
    required final Pubkey account,
    required final Pubkey mintAuthority,
    final List<Pubkey> signers = const [],
    // Data
    required final bu64 amount,
  }) {
    // * Single authority
    // 0. `[writable]` The mint.
    // 1. `[writable]` The account to mint tokens to.
    // 2. `[signer]` The mint's minting authority.
    //
    // * Multisignature authority
    // 0. `[writable]` The mint.
    // 1. `[writable]` The account to mint tokens to.
    // 2. `[]` The mint's multisignature mint-tokens authority.
    // 3. ..3+M `[signer]` M signer accounts.
    final List<AccountMeta> keys = [
      AccountMeta.writable(mint),
      AccountMeta.writable(account),
      AccountMeta(mintAuthority, isSigner: signers.isEmpty),
      for (final Pubkey signer in signers) AccountMeta.signer(signer),
    ];

    final List<Iterable<u8>> data = [borsh.u64.encode(amount)];

    return _instance.createTransactionIntruction(
      TokenInstruction.mintTo,
      keys: keys,
      data: data,
    );
  }

  /// Burns tokens by removing them from an account.  `Burn` does not support
  /// accounts associated with the native mint, use `CloseAccount` instead.
  ///
  /// ### Keys:
  /// Single owner/delegate
  /// - `[w]` [account] - The account to burn from.
  /// - `[w]` [mint] - The token mint.
  /// - `[s]` [authority] - The account's owner/delegate.
  ///
  /// Multisignature owner/delegate
  /// - `[w]` [account] - The account to burn from.
  /// - `[w]` [mint] - The token mint.
  /// - `[]` [authority] - The account's multisignature owner/delegate.
  /// - `[s]` [signers] - The signer accounts.
  ///
  /// ### Data:
  /// - [amount] - The amount of tokens to burn.
  static TransactionInstruction burn({
    // Keys
    required final Pubkey account,
    required final Pubkey mint,
    required final Pubkey authority,
    final List<Pubkey> signers = const [],
    // Data
    required final bu64 amount,
  }) {
    // * Single owner/delegate
    // 0. `[writable]` The account to burn from.
    // 1. `[writable]` The token mint.
    // 2. `[signer]` The account's owner/delegate.
    //
    // * Multisignature owner/delegate
    // 0. `[writable]` The account to burn from.
    // 1. `[writable]` The token mint.
    // 2. `[]` The account's multisignature owner/delegate.
    // 3. ..3+M `[signer]` M signer accounts.
    final List<AccountMeta> keys = [
      AccountMeta.writable(account),
      AccountMeta.writable(mint),
      AccountMeta(authority, isSigner: signers.isEmpty),
      for (final Pubkey signer in signers) AccountMeta.signer(signer),
    ];

    final List<Iterable<u8>> data = [borsh.u64.encode(amount)];

    return _instance.createTransactionIntruction(
      TokenInstruction.burn,
      keys: keys,
      data: data,
    );
  }

  /// Close an account by transferring all its SOL to the destination account.
  /// Non-native accounts may only be closed if its token amount is zero.
  ///
  /// ### Keys:
  /// - Single owner
  /// - `[w]` [account] - The account to close.
  /// - `[w]` [destination] - The destination account.
  /// - `[s]` [owner] - The account's owner.
  ///
  /// - Multisignature owner
  /// - `[w]` [account] - The account to close.
  /// - `[w]` [destination] - The destination account.
  /// - `[]` [owner] - The account's multisignature owner.
  /// - `[s]` [signers] - The signer accounts.
  static TransactionInstruction closeAccount({
    required final Pubkey account,
    required final Pubkey destination,
    required final Pubkey owner,
    final List<Pubkey> signers = const [],
  }) {
    // * Single owner
    // 0. `[writable]` The account to close.
    // 1. `[writable]` The destination account.
    // 2. `[signer]` The account's owner.
    //
    // * Multisignature owner
    // 0. `[writable]` The account to close.
    // 1. `[writable]` The destination account.
    // 2. `[]` The account's multisignature owner.
    // 3. ..3+M `[signer]` M signer accounts.
    final List<AccountMeta> keys = [
      AccountMeta.writable(account),
      AccountMeta.writable(destination),
      AccountMeta(owner, isSigner: signers.isEmpty),
      for (final Pubkey signer in signers) AccountMeta.signer(signer),
    ];

    return _instance.createTransactionIntruction(
      TokenInstruction.closeAccount,
      keys: keys,
    );
  }

  /// Freeze an Initialized account using the Mint's freeze_authority (if
  /// set).
  ///
  /// ### Keys:
  /// Single owner
  /// - `[w]` [account] - The account to freeze.
  /// - `[]` [mint] - The token mint.
  /// - `[s]` [authority] - The mint freeze authority.
  ///
  /// Multisignature owner
  /// - `[w]` [account] - The account to freeze.
  /// - `[]` [mint] - The token mint.
  /// - `[]` [authority] - The mint's multisignature freeze authority.
  /// - `[s]` [signers] - The signer accounts.
  static TransactionInstruction freezeAccount({
    required final Pubkey account,
    required final Pubkey mint,
    required final Pubkey authority,
    final List<Pubkey> signers = const [],
  }) {
    // * Single owner
    // 0. `[w]` The account to fress.
    // 1. `[w]` The token mint.
    // 2. `[s]` The mint freeze authority.
    //
    // * Multisignature owner
    // 0. `[w]` The account to freeze.
    // 1. `[w]` The token mint.
    // 2. `[]` The mint's multisignature freeze authority.
    // 3. `[s]` ..3+M, M signer accounts.
    final List<AccountMeta> keys = [
      AccountMeta.writable(account),
      AccountMeta.writable(mint),
      AccountMeta(authority, isSigner: signers.isEmpty),
      for (final Pubkey signer in signers) AccountMeta.signer(signer),
    ];

    return _instance.createTransactionIntruction(
      TokenInstruction.freezeAccount,
      keys: keys,
    );
  }

  /// Thaw a Frozen account using the Mint's freeze_authority (if set).
  ///
  /// ### Keys:
  ///   * Single owner
  ///   0. `[writable]` The account to freeze.
  ///   1. `[]` The token mint.
  ///   2. `[signer]` The mint freeze authority.
  ///
  ///   * Multisignature owner
  ///   0. `[writable]` The account to freeze.
  ///   1. `[]` The token mint.
  ///   2. `[]` The mint's multisignature freeze authority.
  ///   3. ..3+M `[signer]` M signer accounts.
  static TransactionInstruction thawAccount({
    required final Pubkey account,
    required final Pubkey mint,
    required final Pubkey authority,
    final List<Pubkey> signers = const [],
  }) {
    // * Single owner
    // 0. `[w]` The account to fress.
    // 1. `[w]` The token mint.
    // 2. `[s]` The mint freeze authority.
    //
    // * Multisignature owner
    // 0. `[w]` The account to freeze.
    // 1. `[w]` The token mint.
    // 2. `[]` The mint's multisignature freeze authority.
    // 3. `[s]` ..3+M, M signer accounts.
    final List<AccountMeta> keys = [
      AccountMeta.writable(account),
      AccountMeta.writable(mint),
      AccountMeta(authority, isSigner: signers.isEmpty),
      for (final Pubkey signer in signers) AccountMeta.signer(signer),
    ];

    return _instance.createTransactionIntruction(
      TokenInstruction.freezeAccount,
      keys: keys,
    );
  }

  /// Transfers tokens from one account to another either directly or via a delegate.  If this
  /// account is associated with the native mint then equal amounts of SOL and Tokens will be
  /// transferred to the destination account.
  ///
  /// This instruction differs from Transfer in that the token mint and decimals value is checked by
  /// the caller.  This may be useful when creating transactions offline or within a hardware
  /// wallet.
  ///
  /// ### Keys:
  /// Single owner/delegate
  /// - `[w]` [source] - The source account.
  /// - `[]` [mint] - The token mint.
  /// - `[w]` [destination] - The destination account.
  /// - `[s]` [owner] - The source account's owner/delegate.
  ///
  /// Multisignature owner/delegate
  /// - `[w]` [source] - The source account.
  /// - `[]` [mint] - The token mint.
  /// - `[w]` [destination] - The destination account.
  /// - `[]` [owner] - The source account's multisignature owner/delegate.
  /// - `[s]` [signers] - The signer accounts.
  ///
  /// ### Data:
  /// - [amount] - The amount of tokens to transfer.
  /// - [decimals] - Expected number of base 10 digits to the right of the decimal place.
  static TransactionInstruction transferChecked({
    // Keys
    required final Pubkey source,
    required final Pubkey mint,
    required final Pubkey destination,
    required final Pubkey owner,
    final List<Pubkey> signers = const [],
    // Data
    required final bu64 amount,
    required final u8 decimals,
  }) {
    // * Single owner/delegate
    // 0. `[w]` The source account.
    // 1. `[]` The token mint.
    // 2. `[w]` The destination account.
    // 3. `[s]` The source account's owner/delegate.
    ///
    // * Multisignature owner/delegate
    // 0. `[w]` The source account.
    // 1. `[]` The token mint.
    // 2. `[w]` The destination account.
    // 3. `[]` The source account's multisignature owner/delegate.
    // 4. `[s]` ..4+M, M signer accounts.
    final List<AccountMeta> keys = [
      AccountMeta.writable(source),
      AccountMeta(mint),
      AccountMeta.writable(destination),
      AccountMeta(owner, isSigner: signers.isEmpty),
      for (final Pubkey signer in signers) AccountMeta.signer(signer),
    ];

    final List<Iterable<int>> data = [
      borsh.u64.encode(amount),
      borsh.u8.encode(decimals),
    ];

    return _instance.createTransactionIntruction(
      TokenInstruction.transferChecked,
      keys: keys,
      data: data,
    );
  }

  /// Approves a delegate.  A delegate is given the authority over tokens on behalf of the source
  /// account's owner.
  ///
  /// This instruction differs from Approve in that the token mint and decimals value is checked by
  /// the caller.  This may be useful when creating transactions offline or within a hardware
  /// wallet.
  ///
  /// ### Keys:
  /// Single owner
  /// - `[writable]` [source] - The source account.
  /// - `[]` [mint] - The token mint.
  /// - `[]` [delegate] - The delegate.
  /// - `[signer]` [owner] - The source account owner.
  ///
  /// Multisignature owner
  /// - `[writable]` [source] - The source account.
  /// - `[]` [mint] - The token mint.
  /// - `[]` [delegate] - The delegate.
  /// - `[]` [owner] - The source account's multisignature owner.
  /// - `[s]` [signers] - The signer accounts.
  ///
  /// ### Data:
  /// - [amount] - The amount of tokens the delegate is approved for.
  /// - [decimals] - Expected number of base 10 digits to the right of the decimal place.
  static TransactionInstruction approveChecked({
    // Keys
    required final Pubkey source,
    required final Pubkey mint,
    required final Pubkey delegate,
    required final Pubkey owner,
    final List<Pubkey> signers = const [],
    // Data
    required final bu64 amount,
    required final u8 decimals,
  }) {
    // * Single owner
    // 0. `[w]` The source account.
    // 1. `[]` The token mint.
    // 2. `[]` The delegate.
    // 3. `[s]` The source account owner.
    ///
    // * Multisignature owner
    // 0. `[w]` The source account.
    // 1. `[]` The token mint.
    // 2. `[]` The delegate.
    // 3. `[]` The source account's multisignature owner.
    // 4. `[s]` ..4+M, M signer accounts
    final List<AccountMeta> keys = [
      AccountMeta.writable(source),
      AccountMeta(mint),
      AccountMeta(delegate),
      AccountMeta(owner, isSigner: signers.isEmpty),
      for (final Pubkey signer in signers) AccountMeta.signer(signer),
    ];

    final List<Iterable<int>> data = [
      borsh.u64.encode(amount),
      borsh.u8.encode(decimals),
    ];

    return _instance.createTransactionIntruction(
      TokenInstruction.approveChecked,
      keys: keys,
      data: data,
    );
  }

  /// Mints new tokens to an account.  The native mint does not support minting.
  ///
  /// This instruction differs from MintTo in that the decimals value is checked by the caller. This
  /// may be useful when creating transactions offline or within a hardware wallet.
  ///
  /// ### Keys:
  /// Single authority
  /// - `[w]` [mint] - The mint.
  /// - `[w]` [account] - The account to mint tokens to.
  /// - `[s]` [mintAuthority] - The mint's minting authority.
  ///
  /// Multisignature authority
  /// - `[w]` [mint] - The mint.
  /// - `[w]` [account] - The account to mint tokens to.
  /// - `[]` [mintAuthority] - The mint's multisignature mint-tokens authority.
  /// - `[s]` [signers] - The signer accounts.
  ///
  /// ### Data:
  /// - [amount] - The amount of new tokens to mint.
  /// - [decimals] - Expected number of base 10 digits to the right of the decimal place.
  static TransactionInstruction mintToChecked({
    // Keys
    required final Pubkey mint,
    required final Pubkey account,
    required final Pubkey mintAuthority,
    final List<Pubkey> signers = const [],
    // Data
    required final bu64 amount,
    required final u8 decimals,
  }) {
    // * Single authority
    // 0. `[writable]` The mint.
    // 1. `[writable]` The account to mint tokens to.
    // 2. `[signer]` The mint's minting authority.
    //
    // * Multisignature authority
    // 0. `[writable]` The mint.
    // 1. `[writable]` The account to mint tokens to.
    // 2. `[]` The mint's multisignature mint-tokens authority.
    // 3. ..3+M `[signer]` M signer accounts.
    final List<AccountMeta> keys = [
      AccountMeta.writable(mint),
      AccountMeta.writable(account),
      AccountMeta(mintAuthority, isSigner: signers.isEmpty),
      for (final Pubkey signer in signers) AccountMeta.signer(signer),
    ];

    final List<Iterable<u8>> data = [
      borsh.u64.encode(amount),
      borsh.u8.encode(decimals),
    ];

    return _instance.createTransactionIntruction(
      TokenInstruction.mintToChecked,
      keys: keys,
      data: data,
    );
  }

  /// Burns tokens by removing them from an account.  `BurnChecked` does not support accounts
  /// associated with the native mint, use `closeAccount` instead.
  ///
  /// This instruction differs from Burn in that the decimals value is checked by the caller. This
  /// may be useful when creating transactions offline or within a hardware wallet.
  ///
  /// ### Keys:
  /// Single owner/delegate
  /// - `[w]` [account] - The account to burn from.
  /// - `[w]` [mint] - The token mint.
  /// - `[s]` [authority] - The account's owner/delegate.
  ///
  /// Multisignature owner/delegate
  /// - `[w]` [account] - The account to burn from.
  /// - `[w]` [mint] - The token mint.
  /// - `[]` [authority] - The account's multisignature owner/delegate.
  /// - `[s]` [signers] - The signer accounts.
  ///
  /// ### Data:
  /// - [amount] - The amount of tokens to burn.
  /// - [decimals] - Expected number of base 10 digits to the right of the decimal place.
  static TransactionInstruction burnChecked({
    // Keys
    required final Pubkey account,
    required final Pubkey mint,
    required final Pubkey authority,
    final List<Pubkey> signers = const [],
    // Data
    required final bu64 amount,
    required final u8 decimals,
  }) {
    // * Single owner/delegate
    // 0. `[writable]` The account to burn from.
    // 1. `[writable]` The token mint.
    // 2. `[signer]` The account's owner/delegate.
    //
    // * Multisignature owner/delegate
    // 0. `[writable]` The account to burn from.
    // 1. `[writable]` The token mint.
    // 2. `[]` The account's multisignature owner/delegate.
    // 3. ..3+M `[signer]` M signer accounts.
    final List<AccountMeta> keys = [
      AccountMeta.writable(account),
      AccountMeta.writable(mint),
      AccountMeta(authority, isSigner: signers.isEmpty),
      for (final Pubkey signer in signers) AccountMeta.signer(signer),
    ];

    final List<Iterable<u8>> data = [
      borsh.u64.encode(amount),
      borsh.u8.encode(decimals),
    ];

    return _instance.createTransactionIntruction(
      TokenInstruction.burnChecked,
      keys: keys,
      data: data,
    );
  }

  /// Like InitializeAccount, but the owner pubkey is passed via instruction data rather than the
  /// accounts list. This variant may be preferable when using Cross Program Invocation from an
  /// instruction that does not need the owner's `AccountInfo` otherwise.
  ///
  /// ### Keys:
  /// - `[w]` [account] - The account to initialize.
  /// - `[]` [mint] - The mint this account will be associated with.
  ///
  /// ### Data:
  /// - [owner] - The new account's owner/multisignature.
  static TransactionInstruction initializeAccount2({
    // Keys
    required final Pubkey account,
    required final Pubkey mint,
    // Data
    required final Pubkey owner,
  }) {
    // 0. `[writable]`  The account to initialize.
    // 1. `[]` The mint this account will be associated with.
    // 2. `[]` Rent sysvar
    final List<AccountMeta> keys = [
      AccountMeta.writable(account),
      AccountMeta(mint),
      AccountMeta(sysvarRentPubkey),
    ];

    final List<Iterable<u8>> data = [borsh.pubkey.encode(owner.toBase58())];

    return _instance.createTransactionIntruction(
      TokenInstruction.initializeAccount2,
      keys: keys,
      data: data,
    );
  }

  /// Given a wrapped / native token account (a token account containing SOL) updates its amount
  /// field based on the account's underlying `lamports`. This is useful if a non-wrapped SOL
  /// account uses `system_instruction::transfer` to move lamports to a wrapped token account, and
  /// needs to have its token `amount` field updated.
  ///
  /// ### Keys:
  /// - `[w]` [account] - The native token account to sync with its underlying lamports.
  static TransactionInstruction syncNative({required final Pubkey account}) {
    // 0. `[w]` The native token account to sync with its underlying lamports.
    final List<AccountMeta> keys = [AccountMeta.writable(account)];

    return _instance.createTransactionIntruction(
      TokenInstruction.syncNative,
      keys: keys,
    );
  }

  /// Like InitializeAccount2, but does not require the Rent sysvar to be provided.
  ///
  /// ### Keys:
  /// - `[w]` [account] - The account to initialize.
  /// - `[]` [mint] - The mint this account will be associated with.
  ///
  /// ### Data:
  /// - [owner] - The new account's owner/multisignature.
  static TransactionInstruction initializeAccount3({
    // Keys
    required final Pubkey account,
    required final Pubkey mint,
    // Data
    required final Pubkey owner,
  }) {
    // 0. `[writable]`  The account to initialize.
    // 1. `[]` The mint this account will be associated with.
    final List<AccountMeta> keys = [
      AccountMeta.writable(account),
      AccountMeta(mint),
    ];

    final List<Iterable<u8>> data = [borsh.pubkey.encode(owner.toBase58())];

    return _instance.createTransactionIntruction(
      TokenInstruction.initializeAccount3,
      keys: keys,
      data: data,
    );
  }

  /// Like InitializeMultisig, but does not require the Rent sysvar to be provided.
  ///
  /// ### Keys:
  /// - `[w]` [account] - The multisignature account to initialize.
  /// - `[]` [signers] - The signer accounts ([minSigners] : [maxSigners]).
  ///
  /// Data
  /// - [numberOfSigners] - The number of signers required to validate this multisignature account.
  static TransactionInstruction initializeMultisig2({
    // Keys
    required final Pubkey account,
    required final List<Pubkey> signers,
    // Data
    required final u8 numberOfSigners,
  }) {
    // Validation
    checkGte(signers.length, minSigners, 'signers');
    checkLte(signers.length, maxSigners, 'signers');

    // 0. `[w]` The multisignature account to initialize.
    // 1. `[]` ..2+N The signer accounts, must equal to N where 1 <= N <= 11.
    final List<AccountMeta> keys = [
      AccountMeta.writable(account),
      for (final Pubkey signer in signers) AccountMeta(signer),
    ];

    final List<Iterable<int>> data = [borsh.u8.encode(numberOfSigners)];

    return _instance.createTransactionIntruction(
      TokenInstruction.initializeMultisig2,
      keys: keys,
      data: data,
    );
  }

  /// Like InitializeMint, but does not require the Rent sysvar to be provided.
  ///
  /// ### Keys:
  /// - `[w]` [mint] - The mint to initialize.
  ///
  /// ### Data:
  /// - [decimals] - Number of base 10 digits to the right of the decimal place.
  /// - [mintAuthority] - The authority/multisignature to mint tokens.
  /// - [freezeAuthority] - The freeze authority/multisignature of the mint.
  static TransactionInstruction initializeMint2({
    // Keys
    required final Pubkey mint,
    // Data
    required final u8 decimals,
    required final Pubkey mintAuthority,
    final Pubkey? freezeAuthority,
  }) {
    // 0. `[w]` The mint to initialize.
    final List<AccountMeta> keys = [AccountMeta.writable(mint)];

    final List<Iterable<int>> data = [
      borsh.u8.encode(decimals),
      borsh.pubkey.encode(mintAuthority.toBase58()),
      borsh.pubkey.cOption().encode(freezeAuthority?.toBase58()),
    ];

    return _instance.createTransactionIntruction(
      TokenInstruction.initializeMint2,
      keys: keys,
      data: data,
    );
  }

  // /// Gets the required size of an account for the given mint as a little-endian
  // /// `u64`.
  // ///
  // /// Return data can be fetched using `sol_get_return_data` and deserializing
  // /// the return data as a little-endian `u64`.
  // ///
  // /// ### Keys:
  // ///   0. `[]` The mint to calculate for
  // GetAccountDataSize, // typically, there's also data, but this program ignores it

  /// Initialize the Immutable Owner extension for the given token account.
  ///
  /// Fails if the account has already been initialized, so must be called before
  /// `initializeAccount`.
  ///
  /// No-ops in this version of the program, but is included for compatibility with the Associated
  /// Token Account program.
  ///
  /// ### Keys:
  /// - `[w]` [account] The account to initialize.
  static TransactionInstruction initializeImmutableOwner({
    required final Pubkey account,
  }) {
    //  0. `[w]` The account to initialize.
    final List<AccountMeta> keys = [AccountMeta.writable(account)];

    return _instance.createTransactionIntruction(
      TokenInstruction.initializeImmutableOwner,
      keys: keys,
    );
  }

  // /// Convert an Amount of tokens to a UiAmount `string`, using the given mint.
  // /// In this version of the program, the mint can only specify the number of decimals.
  // ///
  // /// Fails on an invalid mint.
  // ///
  // /// Return data can be fetched using `sol_get_return_data` and deserialized with
  // /// `String::from_utf8`.
  // ///
  // /// ### Keys:
  // ///   0. `[]` The mint to calculate for
  // AmountToUiAmount {
  //     /// The amount of tokens to reformat.
  //     amount: u64,
  // },

  // /// Convert a UiAmount of tokens to a little-endian `u64` raw Amount, using the given mint.
  // /// In this version of the program, the mint can only specify the number of decimals.
  // ///
  // /// Return data can be fetched using `sol_get_return_data` and deserializing
  // /// the return data as a little-endian `u64`.
  // ///
  // /// ### Keys:
  // ///   0. `[]` The mint to calculate for
  // UiAmountToAmount {
  //     /// The ui_amount of tokens to reformat.
  //     ui_amount: &'a str,
  // },

  // ***********************************************************************************************
  // Any new variants also need to be added to program-2022 `TokenInstruction`, so that the latter
  // remains a superset of this instruction set.
  // ***********************************************************************************************
}
