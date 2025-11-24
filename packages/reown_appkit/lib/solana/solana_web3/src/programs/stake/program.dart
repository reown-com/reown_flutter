/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_borsh/borsh.dart';
import 'package:reown_appkit/solana/solana_buffer/buffer.dart';
import 'package:reown_appkit/solana/solana_common/extensions.dart';
import 'package:reown_appkit/solana/solana_common/types.dart' show u8, bu64;
import '../../constants/sysvar.dart';
import '../../crypto/pubkey.dart';
import '../../transactions/account_meta.dart';
import '../../transactions/transaction_instruction.dart';
import '../program.dart';
import '../system/program.dart';
import 'instruction.dart';
import 'state.dart';

/// Stake Program
/// ------------------------------------------------------------------------------------------------

class StakeProgram extends Program {
  /// Stake program.
  StakeProgram._()
    : super(Pubkey.fromBase58('Stake11111111111111111111111111111111111111'));

  /// Internal singleton instance.
  static final StakeProgram _instance = StakeProgram._();

  /// The program id.
  static Pubkey get programId => _instance.pubkey;

  /// Configuration account.
  static Pubkey get configId =>
      Pubkey.fromBase58('StakeConfig11111111111111111111111111111111');

  /// The max space of a Stake account.
  ///
  /// This is generated from the solana-stake-program StakeState struct as `StakeState::size_of()`:
  /// https://docs.rs/solana-stake-program/latest/solana_stake_program/stake_state/enum.StakeState.html
  static const int space = 200;

  @override
  Iterable<int> encodeInstruction<T extends Enum>(final T instruction) =>
      Buffer.fromUint32(instruction.index);

  /// Creates a [SystemProgram] instruction that generates a stake account.
  static TransactionInstruction createAccount({
    required final Pubkey fromPubkey,
    required final Pubkey newAccountPubkey,
    required final bu64 lamports,
  }) {
    return SystemProgram.createAccount(
      fromPubkey: fromPubkey,
      newAccountPubkey: newAccountPubkey,
      lamports: lamports,
      space: space.toBigInt(),
      programId: programId,
    );
  }

  /// Creates a [SystemProgram] instruction that generates a stake account. The address is derived
  /// from [fromPubkey] and [seed].
  static TransactionInstruction createAccountWithSeed({
    required final Pubkey fromPubkey,
    required final Pubkey newAccountPubkey,
    required final Pubkey basePubkey,
    required final String seed,
    required final bu64 lamports,
  }) {
    return SystemProgram.createAccountWithSeed(
      fromPubkey: fromPubkey,
      newAccountPubkey: newAccountPubkey,
      basePubkey: basePubkey,
      seed: seed,
      lamports: lamports,
      space: space.toBigInt(),
      programId: programId,
    );
  }

  /// Initialize a stake with lockup and authorization information.
  ///
  /// ### Keys:
  /// - `[w]` [stakeAccount] - Uninitialized stake account.
  ///
  /// ### Data:
  /// - [authorized] - Public keys that must sign staker transactions and withdrawer transactions.
  /// - [lockup] - Information about withdrawal restrictions.
  static TransactionInstruction initialize({
    required final Pubkey stakeAccount,
    required final Authorized authorized,
    required final Lockup lockup,
  }) {
    // 0. `[w]` Uninitialized stake account.
    // 1. `[]` Rent sysvar.
    final List<AccountMeta> keys = [
      AccountMeta.writable(stakeAccount),
      AccountMeta(sysvarRentPubkey),
    ];

    final List<Iterable<u8>> data = [
      Authorized.codec.encode(authorized.toJson()),
      Lockup.codec.encode(lockup.toJson()),
    ];

    return _instance.createTransactionIntruction(
      StakeInstruction.initialize,
      keys: keys,
      data: data,
    );
  }

  /// Authorize a key to manage stake or withdrawal.
  ///
  /// ### Keys:
  /// - `[w]` [stakeAccount] - Stake account to be updated.
  /// - `[s]` [authority] - The stake or withdraw authority.
  /// - `[s]` [custodian] - Lockup authority, if updating StakeAuthorize.withdrawer before lockup.
  ///
  /// ### Data:
  /// - [newAuthority]
  /// - [authorityType]
  static TransactionInstruction authorize({
    // Keys
    required final Pubkey stakeAccount,
    required final Pubkey authority,
    final Pubkey? custodian,
    // Data
    required final Pubkey newAuthority,
    required final StakeAuthorize authorityType,
  }) {
    // 0. `[w]` Stake account to be updated
    // 1. `[]` Clock sysvar
    // 2. `[s]` The stake or withdraw authority
    // 3. `[s]` Lockup authority, if updating StakeAuthorize.withdrawer before lockup.
    final List<AccountMeta> keys = [
      AccountMeta.writable(stakeAccount),
      AccountMeta(sysvarClockPubkey),
      AccountMeta.signer(authority),
      if (custodian != null) AccountMeta.signer(custodian),
    ];

    final List<Iterable<u8>> data = [
      borsh.pubkey.encode(newAuthority.toBase58()),
      borsh.enumeration(StakeAuthorize.values).encode(authorityType),
      [0, 0, 0], // padding
    ];

    return _instance.createTransactionIntruction(
      StakeInstruction.authorize,
      keys: keys,
      data: data,
    );
  }

  /// Delegate a stake to a particular vote account.
  ///
  /// ### Keys:
  /// - `[w]` [stakeAccount] - Initialized stake account to be delegated.
  /// - `[]` [voteAccount] - Vote account to which this stake will be delegated.
  /// - `[s]` [authority] - Stake authority.
  ///
  /// The entire balance of the staking account is staked. DelegateStake can be called multiple
  /// times, but re-delegation is delayed by one epoch.
  static TransactionInstruction delegateStake({
    required final Pubkey stakeAccount,
    required final Pubkey voteAccount,
    required final Pubkey authority,
  }) {
    // 0. `[w]` Initialized stake account to be delegated
    // 1. `[]` Vote account to which this stake will be delegated
    // 2. `[]` Clock sysvar
    // 3. `[]` Stake history sysvar that carries stake warmup/cooldown history
    // 4. `[]` Address of config account that carries stake config
    // 5. `[s]` Stake authority
    final List<AccountMeta> keys = [
      AccountMeta.writable(stakeAccount),
      AccountMeta(voteAccount),
      AccountMeta(sysvarClockPubkey),
      AccountMeta(sysvarStakeHistoryPubkey),
      AccountMeta(StakeProgram.configId),
      AccountMeta.signer(authority),
    ];

    return _instance.createTransactionIntruction(
      StakeInstruction.delegateStake,
      keys: keys,
    );
  }

  /// Split u64 tokens and stake off a stake account into another stake account.
  ///
  /// ### Keys:
  /// - `[w]` [stakeAccount] - Stake account to be split; must be in the Initialized or Stake state.
  /// - `[w]` [uninitializedStakeAccount] - Uninitialized stake account that will take the split-off
  ///   amount.
  /// - `[s]` [authority] - Stake authority.
  static TransactionInstruction split({
    // Keys
    required final Pubkey stakeAccount,
    required final Pubkey uninitializedStakeAccount,
    required final Pubkey authority,
    // Data
    required final bu64 lamports,
  }) {
    // 0. `[w]` Stake account to be split; must be in the Initialized or Stake state.
    // 1. `[w]` Uninitialized stake account that will take the split-off amount.
    // 2. `[s]` Stake authority.
    final List<AccountMeta> keys = [
      AccountMeta.writable(stakeAccount),
      AccountMeta.writable(uninitializedStakeAccount),
      AccountMeta.signer(authority),
    ];

    final List<Iterable<u8>> data = [borsh.u64.encode(lamports)];

    return _instance.createTransactionIntruction(
      StakeInstruction.split,
      keys: keys,
      data: data,
    );
  }

  /// Withdraw unstaked lamports from the stake account.
  ///
  /// ### Keys:
  /// - `[w]` [stakeAccount] - Stake account from which to withdraw.
  /// - `[w]` [recipientAccount] - Recipient account.
  /// - `[s]` [withdrawAuthority] - Withdraw authority.
  /// - `[s]` [custodian] - Lockup authority, if before lockup expiration.
  ///
  /// ### Data:
  /// - [lamports] - The portion of the stake account balance to be withdrawn.
  static TransactionInstruction withdraw({
    // Keys
    required final Pubkey stakeAccount,
    required final Pubkey recipientAccount,
    required final Pubkey withdrawAuthority,
    final Pubkey? custodian,
    // Data
    required final bu64 lamports,
  }) {
    // 0. `[w]` Stake account from which to withdraw
    // 1. `[w]` Recipient account
    // 2. `[]` Clock sysvar
    // 3. `[]` Stake history sysvar that carries stake warmup/cooldown history
    // 4. `[s]` Withdraw authority
    // 5. `[s]` Lockup authority, if before lockup expiration
    final List<AccountMeta> keys = [
      AccountMeta.writable(stakeAccount),
      AccountMeta.writable(recipientAccount),
      AccountMeta(sysvarClockPubkey),
      AccountMeta(sysvarStakeHistoryPubkey),
      AccountMeta.signer(withdrawAuthority),
      if (custodian != null) AccountMeta.signer(custodian),
    ];

    final List<Iterable<u8>> data = [borsh.u64.encode(lamports)];

    return _instance.createTransactionIntruction(
      StakeInstruction.withdraw,
      keys: keys,
      data: data,
    );
  }

  /// Deactivates the stake in the account.
  ///
  /// ### Keys:
  /// - `[w]` [stakeAccount] - Delegated stake account.
  /// - `[s]` [authority] - Stake authority.
  static TransactionInstruction deactivate({
    required final Pubkey stakeAccount,
    required final Pubkey authority,
  }) {
    // 0. `[w]` Delegated stake account
    // 1. `[]` Clock sysvar
    // 2. `[s]` Stake authority
    final List<AccountMeta> keys = [
      AccountMeta.writable(stakeAccount),
      AccountMeta(sysvarClockPubkey),
      AccountMeta.signer(authority),
    ];

    return _instance.createTransactionIntruction(
      StakeInstruction.deactivate,
      keys: keys,
    );
  }

  /// Set stake lockup.
  ///
  /// If a lockup is not active, the withdraw authority may set a new lockup.
  /// If a lockup is active, the lockup custodian may update the lockup parameters.
  ///
  /// ### Keys:
  /// - `[w]` [stakeAccount] - Initialized stake account.
  /// - `[s]` [authority] - Lockup authority or withdraw authority.
  ///
  /// ### Data:
  /// - [lockup]
  static TransactionInstruction setLockup({
    // Keys
    required final Pubkey stakeAccount,
    required final Pubkey authority,
    // Data
    required final LockupArgs lockup,
  }) {
    // 0. `[w]` Initialized stake account
    // 1. `[s]` Lockup authority or withdraw authority
    final List<AccountMeta> keys = [
      AccountMeta.writable(stakeAccount),
      AccountMeta.signer(authority),
    ];

    final List<Iterable<u8>> data = [Lockup.codec.encode(lockup.toJson())];

    return _instance.createTransactionIntruction(
      StakeInstruction.setLockup,
      keys: keys,
      data: data,
    );
  }

  /// Merge two stake accounts.
  ///
  /// Both accounts must have identical lockup and authority keys. A merge is possible between two
  /// stakes in the following states with no additional conditions:
  ///
  /// * two deactivated stakes
  /// * an inactive stake into an activating stake during its activation epoch
  ///
  /// For the following cases, the voter pubkey and vote credits observed must match:
  ///
  /// * two activated stakes
  /// * two activating accounts that share an activation epoch, during the activation epoch
  ///
  /// All other combinations of stake states will fail to merge, including all "transient" states,
  /// where a stake is activating or deactivating with a non-zero effective stake.
  ///
  /// ### Keys:
  /// - `[w]` [destinationStakeAccount] - Destination stake account.
  /// - `[w]` [sourceStakeAccount] - Source stake account, this account will be drained.
  /// - `[s]` [authority] - Stake authority.
  static TransactionInstruction merge({
    required final Pubkey destinationStakeAccount,
    required final Pubkey sourceStakeAccount,
    required final Pubkey authority,
  }) {
    // 0. `[w]` Destination stake account for the merge
    // 1. `[w]` Source stake account for to merge.  This account will be drained
    // 2. `[]` Clock sysvar
    // 3. `[]` Stake history sysvar that carries stake warmup/cooldown history
    // 4. `[s]` Stake authority
    final List<AccountMeta> keys = [
      AccountMeta.writable(destinationStakeAccount),
      AccountMeta.writable(sourceStakeAccount),
      AccountMeta(sysvarClockPubkey),
      AccountMeta(sysvarStakeHistoryPubkey),
      AccountMeta.signer(authority),
    ];

    return _instance.createTransactionIntruction(
      StakeInstruction.merge,
      keys: keys,
    );
  }

  /// Authorize a key to manage stake or withdrawal with a derived key.
  ///
  /// ### Keys:
  /// - `[w]` [stakeAccount] - Stake account to be updated.
  /// - `[s]` [authorityBase] - Base key of stake or withdraw authority.
  /// - `[s]` [custodian] - Lockup authority, if updating StakeAuthorize.withdrawer before lockup.
  static TransactionInstruction authorizeWithSeed({
    // Keys
    required final Pubkey stakeAccount,
    required final Pubkey authorityBase,
    required final Pubkey? custodian,
    // Data
    required final Pubkey newAuthority,
    required final StakeAuthorize authorityType,
    required final String authoritySeed,
    required final Pubkey authorityOwner,
  }) {
    // 0. `[w]` Stake account to be updated
    // 1. `[]` Clock sysvar
    // 2. `[s]` The stake or withdraw authority
    // 3. `[s]` Lockup authority, if updating StakeAuthorize::Withdrawer before lockup expiration.
    final List<AccountMeta> keys = [
      AccountMeta.writable(stakeAccount),
      AccountMeta(sysvarClockPubkey),
      AccountMeta.signer(authorityBase),
      if (custodian != null) AccountMeta.signer(custodian),
    ];

    final List<Iterable<u8>> data = [
      borsh.pubkey.encode(newAuthority.toBase58()),
      borsh.enumeration(StakeAuthorize.values).encode(authorityType),
      [0, 0, 0], // padding
      borsh.rustString().encode(authoritySeed),
      borsh.pubkey.encode(authorityOwner.toBase58()),
    ];

    return _instance.createTransactionIntruction(
      StakeInstruction.authorizeWithSeed,
      keys: keys,
      data: data,
    );
  }

  /// Initialize a stake with authorization information.
  ///
  /// This instruction is similar to `initialize` except that the withdraw authority must be a
  /// signer, and no lockup is applied to the account.
  ///
  /// ### Keys:
  /// - `[w]` [stakeAccount] - Uninitialized stake account.
  /// - `[]` [authority] - The stake authority.
  /// - `[s]` [withdrawAuthority] - The withdraw authority.
  ///
  static TransactionInstruction initializeChecked({
    required final Pubkey stakeAccount,
    required final Pubkey authority,
    required final Pubkey withdrawAuthority,
  }) {
    // `[w]` Uninitialized stake account
    // `[]` Rent sysvar
    // `[]` The stake authority
    // `[s]` The withdraw authority
    final List<AccountMeta> keys = [
      AccountMeta.writable(stakeAccount),
      AccountMeta(sysvarRentPubkey),
      AccountMeta(authority),
      AccountMeta.signer(withdrawAuthority),
    ];

    return _instance.createTransactionIntruction(
      StakeInstruction.initializeChecked,
      keys: keys,
    );
  }

  /// Authorize a key to manage stake or withdrawal.
  ///
  /// This instruction behaves like `Authorize` with the additional requirement that the new stake
  /// or withdraw authority must also be a signer.
  ///
  /// ### Keys:
  /// - `[w]` [stakeAccount] - Stake account to be updated.
  /// - `[s]` [authority] - The stake or withdraw authority.
  /// - `[s]` [newAuthority] - The new stake or withdraw authority.
  /// - `[s]` [custodian] - Lockup authority if updating [StakeAuthorize.withdrawer] before lockup expiration.
  static TransactionInstruction authorizeChecked({
    // Keys
    required final Pubkey stakeAccount,
    required final Pubkey authority,
    required final Pubkey? custodian,
    // Data
    required final Pubkey newAuthority,
    required final StakeAuthorize authorityType,
  }) {
    // 0. `[w]` Stake account to be updated
    // 1. `[]` Clock sysvar
    // 2. `[s]` The stake or withdraw authority
    // 3. `[s]` [newAuthority] - The new stake or withdraw authority.
    // 4. `[s]` Lockup authority if updating StakeAuthorize.withdrawer before lockup expiration.
    final List<AccountMeta> keys = [
      AccountMeta.writable(stakeAccount),
      AccountMeta(sysvarClockPubkey),
      AccountMeta.signer(authority),
      AccountMeta.signer(newAuthority),
      if (custodian != null) AccountMeta.signer(custodian),
    ];

    final List<Iterable<u8>> data = [
      borsh.enumeration(StakeAuthorize.values).encode(authorityType),
      [0, 0, 0], // padding
    ];

    return _instance.createTransactionIntruction(
      StakeInstruction.authorizeChecked,
      keys: keys,
      data: data,
    );
  }

  /// Authorize a key to manage stake or withdrawal with a derived key.
  ///
  /// This instruction behaves like `AuthorizeWithSeed` with the additional requirement that the new
  /// stake or withdraw authority must also be a signer.
  ///
  /// ### Keys:
  /// - `[w]` Stake account to be updated
  /// - `[s]` Base key of stake or withdraw authority
  /// - `[]` Clock sysvar
  /// - `[s]` The new stake or withdraw authority
  /// - `[s]` Lockup authority if updating [StakeAuthorize.withdrawer] before lockup expiration.
  static TransactionInstruction authorizeCheckedWithSeed({
    // Keys
    required final Pubkey stakeAccount,
    required final Pubkey authorityBase,
    required final Pubkey? custodian,
    // Data
    required final Pubkey newAuthority,
    required final StakeAuthorize authorityType,
    required final String authoritySeed,
    required final Pubkey authorityOwner,
  }) {
    // 0. `[w]` Stake account to be updated
    // 1. `[s]` Base key of stake or withdraw authority
    // 2. `[]` Clock sysvar
    // 3. `[s]` The new stake or withdraw authority
    // 4. `[s]` Lockup authority if updating StakeAuthorize.withdrawer before lockup expiration.
    final List<AccountMeta> keys = [
      AccountMeta.writable(stakeAccount),
      AccountMeta.signer(authorityBase),
      AccountMeta(sysvarClockPubkey),
      AccountMeta.signer(newAuthority),
      if (custodian != null) AccountMeta.signer(custodian),
    ];

    final List<Iterable<u8>> data = [
      borsh.enumeration(StakeAuthorize.values).encode(authorityType),
      [0, 0, 0], // padding
      borsh.rustString().encode(authoritySeed),
      borsh.pubkey.encode(authorityOwner.toBase58()),
    ];

    return _instance.createTransactionIntruction(
      StakeInstruction.authorizeCheckedWithSeed,
      keys: keys,
      data: data,
    );
  }

  /// Set stake lockup.
  ///
  /// This instruction behaves like `SetLockup` with the additional requirement that the new lockup
  /// authority also be a signer.
  ///
  /// If a lockup is not active, the withdraw authority may set a new lockup.
  /// If a lockup is active, the lockup custodian may update the lockup parameters.
  ///
  /// ### Keys:
  /// - `[w]` [stakeAccount] - Initialized stake account.
  /// - `[s]` [authority] - Lockup authority or withdraw authority.
  /// - `[s]` [custodian] - New lockup authority (optional).
  static TransactionInstruction setLockupChecked({
    // Keys
    required final Pubkey stakeAccount,
    required final Pubkey authority,
    required final Pubkey? custodian,
    // Data
    required final LockupCheckedArgs lockup,
  }) {
    // 0. `[w]` Initialized stake account
    // 1. `[s]` Lockup authority or withdraw authority
    // 2. `[s]` New lockup authority (optional)
    final List<AccountMeta> keys = [
      AccountMeta.writable(stakeAccount),
      AccountMeta.signer(authority),
      if (custodian != null) AccountMeta.signer(custodian),
    ];

    final List<Iterable<u8>> data = [
      LockupCheckedArgs.codec.encode(lockup.toJson()),
    ];

    return _instance.createTransactionIntruction(
      StakeInstruction.setLockupChecked,
      keys: keys,
      data: data,
    );
  }

  /// Get the minimum stake delegation, in lamports.
  ///
  /// ### Keys:
  /// - None
  ///
  /// Returns the minimum delegation as a little-endian encoded u64 value. Programs can use the
  /// [`getMinimumDelegation()`] helper function to invoke and retrieve the return value for this
  /// instruction.
  ///
  /// [`getMinimumDelegation()`]: super::tools::get_minimum_delegation
  static TransactionInstruction getMinimumDelegation() {
    return _instance.createTransactionIntruction(
      StakeInstruction.getMinimumDelegation,
      keys: const [],
    );
  }

  /// Deactivate stake delegated to a vote account that has been delinquent for at least
  /// `MINIMUM_DELINQUENT_EPOCHS_FOR_DEACTIVATION` epochs.
  ///
  /// No signer is required for this instruction as it is a common good to deactivate abandoned
  /// stake.
  ///
  /// ### Keys:
  /// - `[w]` [delegatedStakeAccount] - Delegated stake account.
  /// - `[]` [delinquentVoteAccount] - Delinquent vote account for the delegated stake account.
  /// - `[]` [referenceVoteAccount] - Reference vote account that has voted at least once in the
  ///   last `MINIMUM_DELINQUENT_EPOCHS_FOR_DEACTIVATION` epochs
  static TransactionInstruction deactivateDelinquent({
    required final Pubkey delegatedStakeAccount,
    required final Pubkey delinquentVoteAccount,
    required final Pubkey referenceVoteAccount,
  }) {
    // 0. `[w]` Delegated stake account
    // 1. `[]` Delinquent vote account for the delegated stake account
    // 2. `[]` Reference vote account that has voted at least once in the last
    //    `MINIMUM_DELINQUENT_EPOCHS_FOR_DEACTIVATION` epochs
    final List<AccountMeta> keys = [
      AccountMeta.writable(delegatedStakeAccount),
      AccountMeta(delinquentVoteAccount),
      AccountMeta(referenceVoteAccount),
    ];

    return _instance.createTransactionIntruction(
      StakeInstruction.deactivateDelinquent,
      keys: keys,
    );
  }

  /// Redelegate activated stake to another vote account.
  ///
  /// Upon success:
  ///   * the balance of the delegated stake account will be reduced to the undelegated amount in
  ///     the account (rent exempt minimum and any additional lamports not part of the delegation),
  ///     and scheduled for deactivation.
  ///   * the provided uninitialized stake account will receive the original balance of the
  ///     delegated stake account, minus the rent exempt minimum, and scheduled for activation to
  ///     the provided vote account. Any existing lamports in the uninitialized stake account
  ///     will also be included in the re-delegation.
  ///
  /// ### Keys:
  /// - `[w]` [delegatedStakeAccount] - Delegated stake account to be redelegated. The account must
  ///     be fullyvactivated and carry a balance greater than or equal to the minimum delegation
  ///     amountvplus rent exempt minimum.
  /// - `[w]` [uninitializedtStakeAccount] - Uninitialized stake account that will hold the
  ///     redelegated stake.
  /// - `[]` [voteAccount] - Vote account to which this stake will be re-delegated.
  /// - `[s]` [authority] - Stake authority.
  static TransactionInstruction redelegate({
    required final Pubkey delegatedStakeAccount,
    required final Pubkey uninitializedtStakeAccount,
    required final Pubkey voteAccount,
    required final Pubkey authority,
  }) {
    // 0. `[w]` Delegated stake account to be redelegated. The account must be fully activated and
    //    carry a balance greater than or equal to the minimum delegation amount plus rent exempt
    //    minimum
    // 1. `[w]` Uninitialized stake account that will hold the redelegated stake
    // 2. `[]` Vote account to which this stake will be re-delegated
    // 3. `[]` Address of config account that carries stake config
    // 4. `[s]` Stake authority
    final List<AccountMeta> keys = [
      AccountMeta.writable(delegatedStakeAccount),
      AccountMeta.writable(uninitializedtStakeAccount),
      AccountMeta(voteAccount),
      AccountMeta(StakeProgram.configId),
      AccountMeta.signer(authority),
    ];

    return _instance.createTransactionIntruction(
      StakeInstruction.redelegate,
      keys: keys,
    );
  }
}
