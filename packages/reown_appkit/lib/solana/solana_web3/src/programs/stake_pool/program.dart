/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'dart:convert';
import 'package:reown_appkit/solana/solana_borsh/borsh.dart';
import 'package:reown_appkit/solana/solana_borsh/codecs.dart';
import 'package:reown_appkit/solana/solana_buffer/extensions.dart';
import 'package:reown_appkit/solana/solana_common/types.dart';
import 'package:reown_appkit/solana/solana_web3/programs.dart';
import '../../encodings/lamports.dart';
import '../../constants/sysvar.dart';
import '../../crypto/pubkey.dart';
import '../../rpc/models/program_address.dart';
import '../../transactions/account_meta.dart';
import '../../transactions/transaction_instruction.dart';

/// Stake Pool Program
/// ------------------------------------------------------------------------------------------------

class StakePoolProgram extends Program {
  /// Stake pool program.
  StakePoolProgram._()
    : super(Pubkey.fromBase58('SPoo1Ku8WFXoNDMHPsrGSTSG1Y47rzgn41SLUNakuHy'));

  /// Internal singleton instance.
  static final StakePoolProgram _instance = StakePoolProgram._();

  /// The program id.
  static Pubkey get programId => _instance.pubkey;

  /// Maximum number of validators to update during UpdateValidatorListBalance.
  static const int maxValidatorsToUpdate = 5;

  /// Minimum amount of staked SOL required in a validator stake account to allow for merges without
  /// a mismatch on credits observed.
  static const int minimumActiveStake = lamportsPerSol;

  /// The deposit authority seed.
  static const String depositAuthoritySeed = 'deposit';

  /// The withdrawal authority seed.
  static const String withdrawAuthoritySeed = 'withdraw';

  /// The transient stake account seed.
  static const String transientStakeSeedPrefix = 'transient';

  /// The ephemeral stake account seed.
  static const String ephemeralStakeSeedPrefix = 'ephemeral';

  /// Find the deposit authority account address of the given [stakePoolAddress].
  static ProgramAddress findDepositAuthorityProgramAddress(
    final Pubkey stakePoolAddress,
  ) {
    return Pubkey.findProgramAddress([
      stakePoolAddress.toBytes(),
      utf8.encode(depositAuthoritySeed),
    ], StakePoolProgram.programId);
  }

  /// Find the withdraw authority account address of the given [stakePoolAddress].
  static ProgramAddress findWithdrawAuthorityProgramAddress(
    final Pubkey stakePoolAddress,
  ) {
    return Pubkey.findProgramAddress([
      stakePoolAddress.toBytes(),
      utf8.encode(withdrawAuthoritySeed),
    ], StakePoolProgram.programId);
  }

  /// Find the stake account address of the given validator [voteAccountAddress] and
  /// [stakePoolAddress].
  static ProgramAddress findStakeProgramAddress(
    final Pubkey voteAccountAddress,
    final Pubkey stakePoolAddress, [
    final bu64? seed,
  ]) {
    return Pubkey.findProgramAddress([
      voteAccountAddress.toBytes(),
      stakePoolAddress.toBytes(),
      if (seed != null) seed.toUint8List(8),
    ], StakePoolProgram.programId);
  }

  /// Find the transient stake account address of the given validator [voteAccountAddress],
  /// [stakePoolAddress] and [seed] (u64).
  static ProgramAddress findTransientStakeProgramAddress(
    final Pubkey voteAccountAddress,
    final Pubkey stakePoolAddress,
    final bu64 seed,
  ) {
    return Pubkey.findProgramAddress([
      utf8.encode(transientStakeSeedPrefix),
      voteAccountAddress.toBytes(),
      stakePoolAddress.toBytes(),
      seed.toUint8List(8),
    ], StakePoolProgram.programId);
  }

  /// Find the ephemeral stake account address of [stakePoolAddress] and [seed] (u64).
  static ProgramAddress findEphemeralStakeProgramAddress(
    final Pubkey stakePoolAddress,
    final bu64 seed,
  ) {
    return Pubkey.findProgramAddress([
      utf8.encode(ephemeralStakeSeedPrefix),
      stakePoolAddress.toBytes(),
      seed.toUint8List(8),
    ], StakePoolProgram.programId);
  }

  /// Initializes a new [StakePool].
  ///
  /// Keys:
  /// - `[w]` [stakePoolAddress] - New StakePool to create.
  /// - `[s]` [manager] - Manager.
  /// - `[]` [staker] - Staker.
  /// - `[]` [withdrawAuthority] - Stake pool withdraw authority.
  /// - `[w]` [validatorList] - Uninitialized validator stake list storage account.
  /// - `[]` [reserveStake] - Reserve stake account must be initialized, have zero balance, and staker /
  ///   withdrawer authority set to pool withdraw authority.
  /// - `[]` [poolMint] - Pool token mint. Must have zero supply, owned by withdraw authority.
  /// - `[]` [managerFeeAccount] - Pool account to deposit the generated fee for manager.
  /// - `[]` [depositAuthority] - (Optional) Deposit authority that must sign all deposits. Defaults
  ///   to the program address generated using `findDepositAuthorityProgramAddress`, making deposits
  ///   permissionless.
  ///
  /// Data:
  /// - [fee] - Fee assessed as percentage of perceived rewards.
  /// - [withdrawalFee] - Fee charged per withdrawal as percentage of withdrawal.
  /// - [depositFee] - Fee charged per deposit as percentage of deposit.
  /// - [referralFee] - Percentage 0-100 of deposit_fee that goes to referrer.
  /// - [maxValidators] - Maximum expected number of validators.
  static TransactionInstruction initialize({
    // Keys
    required final Pubkey stakePoolAddress,
    required final Pubkey manager,
    required final Pubkey staker,
    final Pubkey? withdrawAuthority,
    required final Pubkey validatorList,
    required final Pubkey reserveStake,
    required final Pubkey poolMint,
    required final Pubkey managerFeeAccount,
    final Pubkey? depositAuthority,
    // Data
    required final Fee fee,
    required final Fee withdrawalFee,
    required final Fee depositFee,
    required final u8 referralFee,
    required final u32 maxValidators,
  }) {
    // 0. `[w]` New StakePool to create.
    // 1. `[s]` Manager
    // 2. `[]` Staker
    // 3. `[]` Stake pool withdraw authority
    // 4. `[w]` Uninitialized validator stake list storage account
    // 5. `[]` Reserve stake account must be initialized, have zero balance,
    //     and staker / withdrawer authority set to pool withdraw authority.
    // 6. `[]` Pool token mint. Must have zero supply, owned by withdraw authority.
    // 7. `[]` Pool account to deposit the generated fee for manager.
    // 8. `[]` Token program id
    // 9. `[]` (Optional) Deposit authority that must sign all deposits. Defaults to the program
    //    address generated using `findDepositAuthorityProgramAddress`, making deposits
    //    permissionless.
    final List<AccountMeta> keys = [
      AccountMeta.writable(stakePoolAddress),
      AccountMeta.signer(manager),
      AccountMeta(staker),
      AccountMeta(
        withdrawAuthority ??
            findWithdrawAuthorityProgramAddress(stakePoolAddress).pubkey,
      ),
      AccountMeta.writable(validatorList),
      AccountMeta(reserveStake),
      AccountMeta(poolMint),
      AccountMeta(managerFeeAccount),
      AccountMeta(TokenProgram.programId),
      if (depositAuthority != null) AccountMeta(depositAuthority),
    ];

    final BorshStructCodec feeCodec = borsh.struct(Fee.codec.schema);
    final List<Iterable<int>> data = [
      feeCodec.encode(fee.toJson()),
      feeCodec.encode(withdrawalFee.toJson()),
      feeCodec.encode(depositFee.toJson()),
      borsh.u8.encode(referralFee),
      borsh.u32.encode(maxValidators),
    ];

    return _instance.createTransactionIntruction(
      StakePoolInstruction.initialize,
      keys: keys,
      data: data,
    );
  }

  /// (Staker only) Adds a stake account delegated to validator, to the pool's list of managed
  /// validators.
  ///
  /// The stake account will have the rent-exempt amount plus
  /// `max(crate::MINIMUM_ACTIVE_STAKE, solana_program::stake::tools::get_minimum_delegation())`. It
  /// is funded from the stake pool reserve.
  ///
  /// Keys:
  /// - `[w]` [stakePoolAddress] - Stake pool address.
  /// - `[s]` [staker] - Staker.
  /// - `[w]` [reserveStake] - Reserve stake account.
  /// - `[]` [withdrawAuthority] - Stake pool withdraw authority.
  /// - `[w]` [validatorList] - Validator stake list storage account.
  /// - `[w]` [stakeAccount] - Stake account to add to the pool.
  /// - `[]` [voteAccount] - Validator this stake account will be delegated to.
  ///
  /// Data:
  /// - [seed] - Optional non-zero u32 seed used for generating the validator stake address.
  static TransactionInstruction addValidatorToPool({
    // Keys
    required final Pubkey stakePoolAddress,
    required final Pubkey staker,
    required final Pubkey reserveStake,
    required final Pubkey withdrawAuthority,
    required final Pubkey validatorList,
    required final Pubkey stakeAccount,
    required final Pubkey voteAccount,
    // Data
    final u32? seed,
  }) {
    //  0. `[w]` Stake pool
    //  1. `[s]` Staker
    //  2. `[w]` Reserve stake account
    //  3. `[]` Stake pool withdraw authority
    //  4. `[w]` Validator stake list storage account
    //  5. `[w]` Stake account to add to the pool
    //  6. `[]` Validator this stake account will be delegated to
    //  7. `[]` Rent sysvar
    //  8. `[]` Clock sysvar
    //  9. '[]' Stake history sysvar
    // 10. '[]' Stake config sysvar
    // 11. `[]` System program
    // 12. `[]` Stake program
    final List<AccountMeta> keys = [
      AccountMeta.writable(stakePoolAddress),
      AccountMeta.signer(staker),
      AccountMeta.writable(reserveStake),
      AccountMeta(withdrawAuthority),
      AccountMeta.writable(validatorList),
      AccountMeta.writable(stakeAccount),
      AccountMeta(voteAccount),
      AccountMeta(sysvarRentPubkey),
      AccountMeta(sysvarClockPubkey),
      AccountMeta(sysvarStakeHistoryPubkey),
      AccountMeta(StakeProgram.configId),
      AccountMeta(SystemProgram.programId),
      AccountMeta(StakeProgram.programId),
    ];

    final List<Iterable<int>> data = [borsh.u32.option().encode(seed)];

    return _instance.createTransactionIntruction(
      StakePoolInstruction.addValidatorToPool,
      keys: keys,
      data: data,
    );
  }

  /// (Staker only) Removes a validator from the pool, deactivating its stake.
  ///
  /// Only succeeds if the validator stake account has the minimum of
  /// `max(crate::MINIMUM_ACTIVE_STAKE, solana_program::stake::tools::get_minimum_delegation())`
  /// plus the rent-exempt amount.
  ///
  /// Keys:
  /// - [stakePoolAddress] `[w]` - Stake pool.
  /// - [staker] `[s]` Staker.
  /// - [withdrawAuthority] `[]` Stake pool withdraw authority.
  /// - [validatorList] `[w]` Validator stake list storage account.
  /// - [stakeAccount] `[w]` Stake account to remove from the pool.
  /// - [transientStakeAccount] `[]` Transient stake account, to check that that we're not trying
  ///   to activate.
  static TransactionInstruction removeValidatorFromPool({
    required final Pubkey stakePoolAddress,
    required final Pubkey staker,
    required final Pubkey withdrawAuthority,
    required final Pubkey validatorList,
    required final Pubkey stakeAccount,
    required final Pubkey transientStakeAccount,
  }) {
    // 0. `[w]` Stake pool
    // 1. `[s]` Staker
    // 2. `[]` Stake pool withdraw authority
    // 3. `[w]` Validator stake list storage account
    // 4. `[w]` Stake account to remove from the pool
    // 5. `[]` Transient stake account, to check that that we're not trying to activate
    // 6. `[]` Sysvar clock
    // 7. `[]` Stake program id
    final List<AccountMeta> keys = [
      AccountMeta.writable(stakePoolAddress),
      AccountMeta.signer(staker),
      AccountMeta(withdrawAuthority),
      AccountMeta.writable(validatorList),
      AccountMeta.writable(stakeAccount),
      AccountMeta(transientStakeAccount),
      AccountMeta(sysvarClockPubkey),
      AccountMeta(StakeProgram.programId),
    ];

    return _instance.createTransactionIntruction(
      StakePoolInstruction.removeValidatorFromPool,
      keys: keys,
    );
  }

  /// (Staker only) Decrease active stake on a validator, eventually moving it to the reserve.
  ///
  /// Internally, this instruction splits a validator stake account into its corresponding transient
  /// stake account and deactivates it.
  ///
  /// In order to rebalance the pool without taking custody, the staker needs a way of reducing the
  /// stake on a stake account. This instruction splits some amount of stake, up to the total
  /// activated stake, from the canonical validator stake account, into its "transient" stake
  /// account.
  ///
  /// The instruction only succeeds if the transient stake account does not exist. The amount of
  /// lamports to move must be at least rent-exemption plus
  /// `max(crate::MINIMUM_ACTIVE_STAKE, solana_program::stake::tools::get_minimum_delegation())`.
  ///
  /// Keys:
  /// - `[]` [stakePoolAddress] - Stake pool.
  /// - `[s]` [staker] - Stake pool staker.
  /// - `[]` [withdrawAuthority] - Stake pool withdraw authority.
  /// - `[w]` [validatorList] - Validator list.
  /// - `[w]` [stakeAccount] - Canonical stake account to split from.
  /// - `[w]` [transientStakeAccount] - Transient stake account to receive split.
  ///
  /// Data:
  /// - [lamports] - Amount of lamports to split into the transient stake account.
  /// - [transientStakeSeed] - Seed used to create transient stake account.
  static TransactionInstruction decreaseValidatorStake({
    // Keys
    required final Pubkey stakePoolAddress,
    required final Pubkey staker,
    required final Pubkey withdrawAuthority,
    required final Pubkey validatorList,
    required final Pubkey stakeAccount,
    required final Pubkey transientStakeAccount,
    // Data
    required final bu64 lamports,
    required final bu64 transientStakeSeed,
  }) {
    //  0. `[]` Stake pool
    //  1. `[s]` Stake pool staker
    //  2. `[]` Stake pool withdraw authority
    //  3. `[w]` Validator list
    //  4. `[w]` Canonical stake account to split from
    //  5. `[w]` Transient stake account to receive split
    //  6. `[]` Clock sysvar
    //  7. `[]` Rent sysvar
    //  8. `[]` System program
    //  9. `[]` Stake program
    final List<AccountMeta> keys = [
      AccountMeta(stakePoolAddress),
      AccountMeta.signer(staker),
      AccountMeta(withdrawAuthority),
      AccountMeta.writable(validatorList),
      AccountMeta.writable(stakeAccount),
      AccountMeta.writable(transientStakeAccount),
      AccountMeta(sysvarClockPubkey),
      AccountMeta(sysvarRentPubkey),
      AccountMeta(SystemProgram.programId),
      AccountMeta(StakeProgram.programId),
    ];

    final List<Iterable<int>> data = [
      borsh.u64.encode(lamports),
      borsh.u64.encode(transientStakeSeed),
    ];

    return _instance.createTransactionIntruction(
      StakePoolInstruction.decreaseValidatorStake,
      keys: keys,
      data: data,
    );
  }

  /// (Staker only) Increase stake on a validator from the reserve account.
  ///
  /// Internally, this instruction splits reserve stake into a transient stake account and delegate
  /// to the appropriate validator. `UpdateValidatorListBalance` will do the work of merging once
  /// it's ready.
  ///
  /// This instruction only succeeds if the transient stake account does not exist. The minimum
  /// amount to move is rent-exemption plus
  /// `max(crate::MINIMUM_ACTIVE_STAKE, solana_program::stake::tools::get_minimum_delegation())`.
  ///
  /// Keys:
  /// - `[]` [stakePoolAddress] - Stake pool.
  /// - `[s]` [staker] - Stake pool staker.
  /// - `[]` [withdrawAuthority] - Stake pool withdraw authority.
  /// - `[w]` [validatorList] - Validator list.
  /// - `[w]` [reserveStake] - Stake pool reserve stake.
  /// - `[w]` [transientStakeAccount] - Transient stake account.
  /// - `[]` [validatorStakeAccount] - Validator stake account.
  /// - `[]` [validatorVoteAccount] - Validator vote account to delegate to.
  ///
  /// Data:
  /// - [lamports] - Amount of lamports to increase on the given validator. The actual amount split
  ///   into the transient stake account is: `lamports + stake rent exemption`. The rent-exemption
  ///   of the stake account is withdrawn back to the reserve after it is merged.
  /// - [transientStakeSeed] - Seed used to create transient stake account.
  static TransactionInstruction increaseValidatorStake({
    // Keys
    required final Pubkey stakePoolAddress,
    required final Pubkey staker,
    required final Pubkey withdrawAuthority,
    required final Pubkey validatorList,
    required final Pubkey reserveStake,
    required final Pubkey transientStakeAccount,
    required final Pubkey validatorStakeAccount,
    required final Pubkey validatorVoteAccount,
    // Data
    required final bu64 lamports,
    required final bu64 transientStakeSeed,
  }) {
    //  0. `[]` Stake pool
    //  1. `[s]` Stake pool staker
    //  2. `[]` Stake pool withdraw authority
    //  3. `[w]` Validator list
    //  4. `[w]` Stake pool reserve stake
    //  5. `[w]` Transient stake account
    //  6. `[]` Validator stake account
    //  7. `[]` Validator vote account to delegate to
    //  8. '[]' Clock sysvar
    //  9. '[]' Rent sysvar
    // 10. `[]` Stake History sysvar
    // 11. `[]` Stake Config sysvar
    // 12. `[]` System program
    // 13. `[]` Stake program
    final List<AccountMeta> keys = [
      AccountMeta(stakePoolAddress),
      AccountMeta.signer(staker),
      AccountMeta(withdrawAuthority),
      AccountMeta.writable(validatorList),
      AccountMeta.writable(reserveStake),
      AccountMeta.writable(transientStakeAccount),
      AccountMeta(validatorStakeAccount),
      AccountMeta(validatorVoteAccount),
      AccountMeta(sysvarClockPubkey),
      AccountMeta(sysvarRentPubkey),
      AccountMeta(sysvarStakeHistoryPubkey),
      AccountMeta(StakeProgram.configId),
      AccountMeta(SystemProgram.programId),
      AccountMeta(StakeProgram.programId),
    ];

    final List<Iterable<int>> data = [
      borsh.u64.encode(lamports),
      borsh.u64.encode(transientStakeSeed),
    ];

    return _instance.createTransactionIntruction(
      StakePoolInstruction.increaseValidatorStake,
      keys: keys,
      data: data,
    );
  }

  /// (Staker only) Set the preferred deposit or withdraw stake account for the stake pool.
  ///
  /// In order to avoid users abusing the stake pool as a free conversion between SOL staked on
  /// different validators, the staker can force all deposits and/or withdraws to go to one chosen
  /// account, or unset that account.
  ///
  /// Fails if the validator is not part of the stake pool.
  ///
  /// Keys:
  /// - [stakePoolAddress] `[w]` - Stake pool.
  /// - [staker] `[s]` Stake pool staker.
  /// - [validatorList] `[]` Validator list.
  ///
  /// Data:
  /// - [validatorType] - Affected operation (deposit or withdraw).
  /// - [validatorVoteAddress] - Validator vote account that deposits or withdraws must go through,
  ///   unset with `null`
  static TransactionInstruction setPreferredValidator({
    // Keys
    required final Pubkey stakePoolAddress,
    required final Pubkey staker,
    required final Pubkey validatorList,
    // Data
    required final PreferredValidatorType validatorType,
    required final Pubkey? validatorVoteAddress,
  }) {
    // 0. `[w]` Stake pool
    // 1. `[s]` Stake pool staker
    // 2. `[]` Validator list
    final List<AccountMeta> keys = [
      AccountMeta.writable(stakePoolAddress),
      AccountMeta.signer(staker),
      AccountMeta(validatorList),
    ];

    final List<Iterable<int>> data = [
      borsh.enumeration(PreferredValidatorType.values).encode(validatorType),
      borsh.pubkey.option().encode(validatorVoteAddress?.toBase58()),
    ];

    return _instance.createTransactionIntruction(
      StakePoolInstruction.setPreferredValidator,
      keys: keys,
      data: data,
    );
  }

  /// Updates balances of validator and transient stake accounts in the pool.
  ///
  /// While going through the pairs of validator and transient stake accounts, if the transient
  /// stake is inactive, it is merged into the reserve stake account. If the transient stake is
  /// active and has matching credits observed, it is merged into the canonical validator stake
  /// account. In all other states, nothing is done, and the balance is simply added to the
  /// canonical stake account balance.
  ///
  /// Keys:
  /// - `[]` [stakePoolAddress] - Stake pool.
  /// - `[]` [withdrawAuthority] - Stake pool withdraw authority.
  /// - `[w]` [validatorList] - Validator stake list storage account.
  /// - `[w]` [reserveStake] - Reserve stake account.
  /// - `[]` [validatorAndTransientStakeAccounts] - N pairs of validator and transient stake accounts.
  ///
  /// Data:
  /// - [startIndex] -  Index to start updating on the validator list.
  /// - [noMerge] - If true, don't try merging transient stake accounts into the reserve or
  ///   validator stake account.  Useful for testing or if a particular stake account is in a bad
  ///   state, but we still want to update.
  static TransactionInstruction updateValidatorListBalance({
    // Keys
    required final Pubkey stakePoolAddress,
    required final Pubkey withdrawAuthority,
    required final Pubkey validatorList,
    required final Pubkey reserveStake,
    required final List<Pubkey> validatorAndTransientStakeAccounts,
    // Data
    required final u32 startIndex,
    required final bool noMerge,
  }) {
    assert((validatorAndTransientStakeAccounts.length % 2) == 0);
    //  0. `[]` Stake pool
    //  1. `[]` Stake pool withdraw authority
    //  2. `[w]` Validator stake list storage account
    //  3. `[w]` Reserve stake account
    //  4. `[]` Sysvar clock
    //  5. `[]` Sysvar stake history
    //  6. `[]` Stake program
    //  7. `[w]` N pairs of validator and transient stake accounts
    final List<AccountMeta> keys = [
      AccountMeta(stakePoolAddress),
      AccountMeta(withdrawAuthority),
      AccountMeta.writable(validatorList),
      AccountMeta.writable(reserveStake),
      AccountMeta(sysvarClockPubkey),
      AccountMeta(sysvarStakeHistoryPubkey),
      AccountMeta(StakeProgram.programId),
      for (final Pubkey account in validatorAndTransientStakeAccounts)
        AccountMeta.writable(account),
    ];

    final List<Iterable<int>> data = [
      borsh.u32.encode(startIndex),
      borsh.boolean.encode(noMerge),
    ];

    return _instance.createTransactionIntruction(
      StakePoolInstruction.updateValidatorListBalance,
      keys: keys,
      data: data,
    );
  }

  /// Updates total pool balance based on balances in the reserve and validator list.
  ///
  /// Keys:
  /// - `[w]` [stakePoolAddress] - Stake pool.
  /// - `[]` [withdrawAuthority] - Stake pool withdraw authority.
  /// - `[w]` [validatorList] - Validator stake list storage account.
  /// - `[]` [reserveStake] - Reserve stake account.
  /// - `[w]` [managerFeeAccount] - Account to receive pool fee tokens.
  /// - `[w]` [poolMint] - Pool mint account.
  static TransactionInstruction updateStakePoolBalance({
    required final Pubkey stakePoolAddress,
    required final Pubkey withdrawAuthority,
    required final Pubkey validatorList,
    required final Pubkey reserveStake,
    required final Pubkey managerFeeAccount,
    required final Pubkey poolMint,
  }) {
    // 0. `[w]` Stake pool
    // 1. `[]` Stake pool withdraw authority
    // 2. `[w]` Validator stake list storage account
    // 3. `[]` Reserve stake account
    // 4. `[w]` Account to receive pool fee tokens
    // 5. `[w]` Pool mint account
    // 6. `[]` Pool token program
    final List<AccountMeta> keys = [
      AccountMeta.writable(stakePoolAddress),
      AccountMeta(withdrawAuthority),
      AccountMeta.writable(validatorList),
      AccountMeta(reserveStake),
      AccountMeta.writable(managerFeeAccount),
      AccountMeta.writable(poolMint),
      AccountMeta(TokenProgram.programId),
    ];

    return _instance.createTransactionIntruction(
      StakePoolInstruction.updateStakePoolBalance,
      keys: keys,
    );
  }

  /// Cleans up validator stake account entries marked as `ready for removal`.
  ///
  /// Keys:
  /// - `[]` [stakePoolAddress] - Stake pool.
  /// - `[w]` [validatorList] - Validator stake list storage account.
  static TransactionInstruction cleanupRemovedValidatorEntries({
    required final Pubkey stakePoolAddress,
    required final Pubkey validatorList,
  }) {
    // 0. `[]` Stake pool
    // 1. `[w]` Validator stake list storage account
    final List<AccountMeta> keys = [
      AccountMeta(stakePoolAddress),
      AccountMeta.writable(validatorList),
    ];

    return _instance.createTransactionIntruction(
      StakePoolInstruction.cleanupRemovedValidatorEntries,
      keys: keys,
    );
  }

  /// Deposit some stake into the pool.  The output is a "pool" token representing ownership into
  /// the pool. Inputs are converted to the current ratio.
  ///
  /// Keys:
  /// - `[w]` [stakePoolAddress] - Stake pool.
  /// - `[w]` [validatorList] - Validator stake list storage account.
  /// - `[s]/[]` [depositAuthority] - Stake pool deposit authority.
  /// - `[]` [withdrawAuthority] - Stake pool withdraw authority.
  /// - `[w]` [stakeAccount] - Stake account to join the pool (withdraw authority for the stake
  ///     account should be first set to the stake pool deposit authority).
  /// - `[w]` [validatorStakeAccount] - Validator stake account for the stake account to be merged with.
  /// - `[w]` [reserveStake] - Reserve stake account, to withdraw rent exempt reserve.
  /// - `[w]` [userTokenAccount] - User account to receive pool tokens.
  /// - `[w]` [tokenAccount] - Account to receive pool fee tokens.
  /// - `[w]` [referralFeeAccount] - Account to receive a portion of pool fee tokens as referral fees.
  /// - `[w]` [poolMint] - Pool token mint account.
  static TransactionInstruction depositStake({
    required final Pubkey stakePoolAddress,
    required final Pubkey validatorList,
    required final Pubkey depositAuthority,
    final bool isDepositAuthoritySigner = false,
    required final Pubkey withdrawAuthority,
    required final Pubkey stakeAccount,
    required final Pubkey validatorStakeAccount,
    required final Pubkey reserveStake,
    required final Pubkey userTokenAccount,
    required final Pubkey tokenAccount,
    required final Pubkey referralFeeAccount,
    required final Pubkey poolMint,
  }) {
    // 0. `[w]` Stake pool
    // 1. `[w]` Validator stake list storage account
    // 2. `[s]/[]` Stake pool deposit authority
    // 3. `[]` Stake pool withdraw authority
    // 4. `[w]` Stake account to join the pool (withdraw authority for the stake account should be
    //          first set to the stake pool deposit authority)
    // 5. `[w]` Validator stake account for the stake account to be merged with
    // 6. `[w]` Reserve stake account, to withdraw rent exempt reserve
    // 7. `[w]` User account to receive pool tokens
    // 8. `[w]` Account to receive pool fee tokens
    // 9. `[w]` Account to receive a portion of pool fee tokens as referral fees
    // 10. `[w]` Pool token mint account
    // 11. `[]` Sysvar clock account
    // 12. `[]` Sysvar stake history account
    // 13. `[]` Pool token program id
    // 14. `[]` Stake program id
    final List<AccountMeta> keys = [
      AccountMeta.writable(stakePoolAddress),
      AccountMeta.writable(validatorList),
      AccountMeta(depositAuthority, isSigner: isDepositAuthoritySigner),
      AccountMeta(withdrawAuthority),
      AccountMeta.writable(stakeAccount),
      AccountMeta.writable(validatorStakeAccount),
      AccountMeta.writable(reserveStake),
      AccountMeta.writable(userTokenAccount),
      AccountMeta.writable(tokenAccount),
      AccountMeta.writable(referralFeeAccount),
      AccountMeta.writable(poolMint),
      AccountMeta(sysvarClockPubkey),
      AccountMeta(sysvarStakeHistoryPubkey),
      AccountMeta(TokenProgram.programId),
      AccountMeta(StakeProgram.programId),
    ];

    return _instance.createTransactionIntruction(
      StakePoolInstruction.depositStake,
      keys: keys,
    );
  }

  /// Withdraw the token from the pool at the current ratio.
  ///
  /// Succeeds if the stake account has enough SOL to cover the desired amount of pool tokens, and
  /// if the withdrawal keeps the total staked amount above the minimum of rent-exempt amount +
  /// `max(crate::MINIMUM_ACTIVE_STAKE, solana_program::stake::tools::get_minimum_delegation())`.
  ///
  /// When allowing withdrawals, the order of priority goes:
  ///
  ///   * preferred withdraw validator stake account (if set)
  ///   * validator stake accounts
  ///   * transient stake accounts
  ///   * reserve stake account OR totally remove validator stake accounts
  ///
  /// A user can freely withdraw from a validator stake account, and if they are all at the minimum,
  /// then they can withdraw from transient stake accounts, and if they are all at minimum, then
  /// they can withdraw from the reserve or remove any validator from the pool.
  ///
  /// Keys:
  /// - `[w]` [stakePoolAddress] - Stake pool.
  /// - `[w]` [validatorList] - Validator stake list storage account.
  /// - `[]` [withdrawAuthority] - Stake pool withdraw authority.
  /// - `[w]` [validatorOrReserveStakeAccount] - Validator or reserve stake account to split.
  /// - `[w]` [unitializedStakeAccount] - Unitialized stake account to receive withdrawal.
  /// - `[]` [userWithdrawAuthority] - User account to set as a new withdraw authority.
  /// - `[s]` [userTransferAuthority] - User transfer authority, for pool token account.
  /// - `[w]` [userTokenAccount] - User account with pool tokens to burn from.
  /// - `[w]` [managerFeeAccount] - Account to receive pool fee tokens.
  /// - `[w]` [poolMint] - Pool token mint account.
  ///
  /// Data:
  /// - [lamports] - Amount of pool tokens to withdraw.
  static TransactionInstruction withdrawStake({
    // Keys
    required final Pubkey stakePoolAddress,
    required final Pubkey validatorList,
    required final Pubkey withdrawAuthority,
    required final Pubkey validatorOrReserveStakeAccount,
    required final Pubkey unitializedStakeAccount,
    required final Pubkey userWithdrawAuthority,
    required final Pubkey userTransferAuthority,
    required final Pubkey userTokenAccount,
    required final Pubkey managerFeeAccount,
    required final Pubkey poolMint,
    // Data
    required final bu64 lamports,
  }) {
    //  0. `[w]` Stake pool
    //  1. `[w]` Validator stake list storage account
    //  2. `[]` Stake pool withdraw authority
    //  3. `[w]` Validator or reserve stake account to split
    //  4. `[w]` Unitialized stake account to receive withdrawal
    //  5. `[]` User account to set as a new withdraw authority
    //  6. `[s]` User transfer authority, for pool token account
    //  7. `[w]` User account with pool tokens to burn from
    //  8. `[w]` Account to receive pool fee tokens
    //  9. `[w]` Pool token mint account
    // 10. `[]` Sysvar clock account (required)
    // 11. `[]` Pool token program id
    // 12. `[]` Stake program id
    final List<AccountMeta> keys = [
      AccountMeta.writable(stakePoolAddress),
      AccountMeta.writable(validatorList),
      AccountMeta(withdrawAuthority),
      AccountMeta.writable(validatorOrReserveStakeAccount),
      AccountMeta.writable(unitializedStakeAccount),
      AccountMeta(userWithdrawAuthority),
      AccountMeta.signer(userTransferAuthority),
      AccountMeta.writable(userTokenAccount),
      AccountMeta.writable(managerFeeAccount),
      AccountMeta.writable(poolMint),
      AccountMeta(sysvarClockPubkey),
      AccountMeta(TokenProgram.programId),
      AccountMeta(StakeProgram.programId),
    ];

    final List<Iterable<int>> data = [borsh.u64.encode(lamports)];

    return _instance.createTransactionIntruction(
      StakePoolInstruction.withdrawStake,
      keys: keys,
      data: data,
    );
  }

  /// (Manager only) Update manager.
  ///
  /// Keys:
  /// - `[w]` [stakePoolAddress] - StakePool.
  /// - `[s]` [manager] - Manager.
  /// - `[s]` [newManager] - New manager.
  /// - `[]` [newManagerFeeAccount] - New manager fee account.
  static TransactionInstruction setManager({
    required final Pubkey stakePoolAddress,
    required final Pubkey manager,
    required final Pubkey newManager,
    required final Pubkey newManagerFeeAccount,
  }) {
    /// 0. `[w]` StakePool
    /// 1. `[s]` Manager
    /// 2. `[s]` New manager
    /// 3. `[]` New manager fee account
    final List<AccountMeta> keys = [
      AccountMeta.writable(stakePoolAddress),
      AccountMeta.signer(manager),
      AccountMeta.signer(newManager),
      AccountMeta(newManagerFeeAccount),
    ];

    return _instance.createTransactionIntruction(
      StakePoolInstruction.setManager,
      keys: keys,
    );
  }

  /// (Manager only) Update fee.
  ///
  /// Keys:
  /// - `[w]` [stakePoolAddress] - StakePool.
  /// - `[s]` [manager] - Manager.
  ///
  /// Data:
  /// - [fee] - Type of fee to update and value to update it to.
  static TransactionInstruction setFee({
    // Keys
    required final Pubkey stakePoolAddress,
    required final Pubkey manager,
    // Data
    required final FeeType fee,
  }) {
    /// 0. `[w]` StakePool.
    /// 1. `[s]` Manager.
    final List<AccountMeta> keys = [
      AccountMeta.writable(stakePoolAddress),
      AccountMeta.signer(manager),
    ];

    final BorshRustEnumCodec feeTypeCode = borsh.rustEnumeration(
      FeeType.codecs,
    );

    final List<Iterable<int>> data = [feeTypeCode.encode(fee)];

    return _instance.createTransactionIntruction(
      StakePoolInstruction.setFee,
      keys: keys,
      data: data,
    );
  }

  /// (Manager or staker only) Update staker.
  ///
  /// Keys:
  /// - `[w]` [stakePoolAddress] - StakePool.
  /// - `[s]` [staker] - Manager or current staker.
  /// - '[]` [newStaker] - New staker pubkey.
  static TransactionInstruction setStaker({
    required final Pubkey stakePoolAddress,
    required final Pubkey staker,
    required final Pubkey newStaker,
  }) {
    /// 0. `[w]` StakePool
    /// 1. `[s]` Manager or current staker
    /// 2. '[]` New staker pubkey
    final List<AccountMeta> keys = [
      AccountMeta.writable(stakePoolAddress),
      AccountMeta.signer(staker),
      AccountMeta(newStaker),
    ];

    return _instance.createTransactionIntruction(
      StakePoolInstruction.setStaker,
      keys: keys,
    );
  }

  /// Deposit SOL directly into the pool's reserve account. The output is a "pool" token
  /// representing ownership into the pool. Inputs are converted to the current ratio.
  ///
  /// Keys:
  /// - `[w]` [stakePoolAddress] - Stake pool
  /// - `[]` [withdrawAuthority] - Stake pool withdraw authority
  /// - `[w]` [reserveStake] - Reserve stake account, to deposit SOL
  /// - `[s]` [payer] - Account providing the lamports to be deposited into the pool
  /// - `[w]` [payerTokenAccount] - User account to receive pool tokens
  /// - `[w]` [feeAccount] - Account to receive fee tokens
  /// - `[w]` [referralFeeAccount] - Account to receive a portion of fee as referral fees
  /// - `[w]` [poolMint] - Pool token mint account
  /// - `[s]` [depositAuthority] - (Optional) Stake pool sol deposit authority.
  ///
  /// Data:
  /// - [lamports] - Amount of solana to deposit in exchange for pool tokens.
  static TransactionInstruction depositSol({
    // Keys
    required final Pubkey stakePoolAddress,
    required final Pubkey withdrawAuthority,
    required final Pubkey reserveStake,
    required final Pubkey payer,
    required final Pubkey payerTokenAccount,
    required final Pubkey feeAccount,
    required final Pubkey referralFeeAccount,
    required final Pubkey poolMint,
    final Pubkey? depositAuthority,
    // Data
    required final bu64 lamports,
  }) {
    //  0. `[w]` Stake pool
    //  1. `[]` Stake pool withdraw authority
    //  2. `[w]` Reserve stake account, to deposit SOL
    //  3. `[s]` Account providing the lamports to be deposited into the pool
    //  4. `[w]` User account to receive pool tokens
    //  5. `[w]` Account to receive fee tokens
    //  6. `[w]` Account to receive a portion of fee as referral fees
    //  7. `[w]` Pool token mint account
    //  8. `[]` System program account
    //  9. `[]` Token program id
    // 10. `[s]` (Optional) Stake pool sol deposit authority.
    final List<AccountMeta> keys = [
      AccountMeta.writable(stakePoolAddress),
      AccountMeta(withdrawAuthority),
      AccountMeta.writable(reserveStake),
      AccountMeta.signer(payer),
      AccountMeta.writable(payerTokenAccount),
      AccountMeta.writable(feeAccount),
      AccountMeta.writable(referralFeeAccount),
      AccountMeta.writable(poolMint),
      AccountMeta(SystemProgram.programId),
      AccountMeta(TokenProgram.programId),
      if (depositAuthority != null) AccountMeta.signer(depositAuthority),
    ];

    final List<Iterable<int>> data = [borsh.u64.encode(lamports)];

    return _instance.createTransactionIntruction(
      StakePoolInstruction.depositSol,
      keys: keys,
      data: data,
    );
  }

  /// (Manager only) Update SOL deposit, stake deposit, or SOL withdrawal authority.
  ///
  /// Keys:
  /// - `[w]` [stakePoolAddress] - StakePool.
  /// - `[s]` [manager] - Manager.
  /// - '[]` [newAuthority] - New authority pubkey or none.
  ///
  /// Data:
  /// - [fundingType] - The authority to update.
  static TransactionInstruction setFundingAuthority({
    // Keys
    required final Pubkey stakePoolAddress,
    required final Pubkey manager,
    required final Pubkey? newAuthority,
    // Data
    required final FundingType fundingType,
  }) {
    /// 0. `[w]` StakePool
    /// 1. `[s]` Manager
    /// 2. '[]` New authority pubkey or none
    final List<AccountMeta> keys = [
      AccountMeta.writable(stakePoolAddress),
      AccountMeta.signer(manager),
      if (newAuthority != null) AccountMeta(newAuthority),
    ];

    final List<Iterable<int>> data = [
      borsh.enumeration(FundingType.values).encode(fundingType),
    ];

    return _instance.createTransactionIntruction(
      StakePoolInstruction.setFundingAuthority,
      keys: keys,
      data: data,
    );
  }

  /// Withdraw SOL directly from the pool's reserve account. Fails if the reserve does not have
  /// enough SOL.
  ///
  /// - `[w]` [stakePoolAddress] - Stake pool.
  /// - `[]` [withdrawAuthority] - Stake pool withdraw authority.
  /// - `[s]` [userTransferAuthority] - User transfer authority, for pool token account.
  /// - `[w]` [userTokenAccount] - User account to burn pool tokens.
  /// - `[w]` [reserveStake] - Reserve stake account, to withdraw SOL.
  /// - `[w]` [receiverAccount] - Account receiving the lamports from the reserve, must be a system account.
  /// - `[w]` [receiverTokenAccount] - Account to receive pool fee tokens.
  /// - `[w]` [poolMint] - Pool token mint account.
  /// - `[s]` [solWithdrawAuthority] - (Optional) Stake pool sol withdraw authority.
  static TransactionInstruction withdrawSol({
    // Keys
    required final Pubkey stakePoolAddress,
    required final Pubkey withdrawAuthority,
    required final Pubkey userTransferAuthority,
    required final Pubkey userTokenAccount,
    required final Pubkey reserveStake,
    required final Pubkey receiverAccount,
    required final Pubkey receiverTokenAccount,
    required final Pubkey poolMint,
    final Pubkey? solWithdrawAuthority,
    // Data
    required final bu64 lamports,
  }) {
    //  0. `[w]` Stake pool
    //  1. `[]` Stake pool withdraw authority
    //  2. `[s]` User transfer authority, for pool token account
    //  3. `[w]` User account to burn pool tokens
    //  4. `[w]` Reserve stake account, to withdraw SOL
    //  5. `[w]` Account receiving the lamports from the reserve, must be a system account
    //  6. `[w]` Account to receive pool fee tokens
    //  7. `[w]` Pool token mint account
    //  8. '[]' Clock sysvar
    //  9. '[]' Stake history sysvar
    // 10. `[]` Stake program account
    // 11. `[]` Token program id
    // 12. `[s]` (Optional) Stake pool sol withdraw authority
    final List<AccountMeta> keys = [
      AccountMeta.writable(stakePoolAddress),
      AccountMeta(withdrawAuthority),
      AccountMeta.signer(userTransferAuthority),
      AccountMeta.writable(userTokenAccount),
      AccountMeta.writable(reserveStake),
      AccountMeta.writable(receiverAccount),
      AccountMeta.writable(receiverTokenAccount),
      AccountMeta.writable(poolMint),
      AccountMeta(sysvarClockPubkey),
      AccountMeta(sysvarStakeHistoryPubkey),
      AccountMeta(StakeProgram.programId),
      AccountMeta(TokenProgram.programId),
      if (solWithdrawAuthority != null)
        AccountMeta.signer(solWithdrawAuthority),
    ];

    final List<Iterable<int>> data = [borsh.u64.encode(lamports)];

    return _instance.createTransactionIntruction(
      StakePoolInstruction.withdrawSol,
      keys: keys,
      data: data,
    );
  }

  /// Create token metadata for the stake-pool token in the metaplex-token program.
  ///
  /// ### Keys:
  /// - `[]` [stakePoolAddress] - Stake pool.
  /// - `[s]` [manager] - Manager.
  /// - `[]` [withdrawAuthority] - Stake pool withdraw authority.
  /// - `[]` [poolMint] - Pool token mint account.
  /// - `[s, w]` [payer] - Payer for creation of token metadata account.
  /// - `[w]` [tokenMetadataAccount] - Token metadata account.
  ///
  /// ### Data:
  /// - [name] - Token name.
  /// - [symbol] - Token symbol e.g. `stkSOL`.
  /// - [uri] - URI of the uploaded metadata of the spl-token.
  static TransactionInstruction createTokenMetadata({
    // Keys
    required final Pubkey stakePoolAddress,
    required final Pubkey manager,
    required final Pubkey withdrawAuthority,
    required final Pubkey poolMint,
    required final Pubkey payer,
    required final Pubkey tokenMetadataAccount,
    // Data
    required final String name,
    required final String symbol,
    required final String uri,
  }) {
    // 0. `[]` Stake pool
    // 1. `[s]` Manager
    // 2. `[]` Stake pool withdraw authority
    // 3. `[]` Pool token mint account
    // 4. `[s, w]` Payer for creation of token metadata account
    // 5. `[w]` Token metadata account
    // 6. `[]` Metadata program id
    // 7. `[]` System program id
    // 8. `[]` Rent sysvar
    final List<AccountMeta> keys = [
      AccountMeta(stakePoolAddress),
      AccountMeta.signer(manager),
      AccountMeta(withdrawAuthority),
      AccountMeta(poolMint),
      AccountMeta.signerAndWritable(payer),
      AccountMeta.writable(tokenMetadataAccount),
      AccountMeta(MetaplexTokenMetadataProgram.programId),
      AccountMeta(SystemProgram.programId),
      AccountMeta(sysvarRentPubkey),
    ];

    final BorshStringCodec rustString = borsh.rustString();
    final List<Iterable<int>> data = [
      rustString.encode(name),
      rustString.encode(symbol),
      rustString.encode(uri),
    ];

    return _instance.createTransactionIntruction(
      StakePoolInstruction.createTokenMetadata,
      keys: keys,
      data: data,
    );
  }

  /// Update token metadata for the stake-pool token in the metaplex-token program.
  ///
  /// 0. `[]` [stakePoolAddress] - Stake pool.
  /// 1. `[s]` [manager] - Manager.
  /// 2. `[]` [withdrawAuthority] - Stake pool withdraw authority.
  /// 3. `[w]` [tokenMetadataAccount] - Token metadata account.
  ///
  static TransactionInstruction updateTokenMetadata({
    // Keys
    required final Pubkey stakePoolAddress,
    required final Pubkey manager,
    required final Pubkey withdrawAuthority,
    required final Pubkey tokenMetadataAccount,
    // Data
    required final String name,
    required final String symbol,
    required final String uri,
  }) {
    // 0. `[]` Stake pool
    // 1. `[s]` Manager
    // 2. `[]` Stake pool withdraw authority
    // 3. `[w]` Token metadata account
    // 4. `[]` Metadata program id
    final List<AccountMeta> keys = [
      AccountMeta(stakePoolAddress),
      AccountMeta.signer(manager),
      AccountMeta(withdrawAuthority),
      AccountMeta.writable(tokenMetadataAccount),
      AccountMeta(MetaplexTokenMetadataProgram.programId),
    ];

    final BorshStringCodec rustString = borsh.rustString();
    final List<Iterable<int>> data = [
      rustString.encode(name),
      rustString.encode(symbol),
      rustString.encode(uri),
    ];

    return _instance.createTransactionIntruction(
      StakePoolInstruction.updateTokenMetadata,
      keys: keys,
      data: data,
    );
  }

  /// (Staker only) Increase stake on a validator again in an epoch.
  ///
  /// Works regardless if the transient stake account exists.
  ///
  /// Internally, this instruction splits reserve stake into an ephemeral stake account, activates
  /// it, then merges or splits it into the transient stake account delegated to the appropriate
  /// validator. `UpdateValidatorListBalance` will do the work of merging once it's ready.
  ///
  /// The minimum amount to move is rent-exemption plus
  /// `max(crate::MINIMUM_ACTIVE_STAKE, solana_program::stake::tools::get_minimum_delegation())`.
  ///
  ///  The rent-exemption of the stake account is withdrawn back to the reserve after it is merged.
  ///
  /// Keys:
  /// - `[]` [stakePoolAddress] - Stake pool.
  /// - `[s]` [staker] -  Stake pool staker.
  /// - `[]` [withdrawAuthority] - Stake pool withdraw authority.
  /// - `[w]` [validatorList] - Validator list.
  /// - `[w]` [reserveStake] - Stake pool reserve stake.
  /// - `[w]` [uninitializedStakeAccount] - Uninitialized ephemeral stake account to receive stake.
  /// - `[w]` [transientStakeAccount] - Transient stake account.
  /// - `[]` [validatorStakeAccount] - Validator stake account.
  /// - `[]` [voteAccount] - Validator vote account to delegate to.
  ///
  /// Data:
  /// - [lamports] - Amount of lamports to increase on the given validator. The actual amount split
  ///   into the transient stake account is: `lamports + stake_rent_exemption`.
  /// - [transientStakeSeed] - Seed used to create transient stake account.
  /// - [ephemeralStakeSeed] - Seed used to create ephemeral account.
  ///  userdata:
  static TransactionInstruction increaseAdditionalValidatorStake({
    // Keys
    required final Pubkey stakePoolAddress,
    required final Pubkey staker,
    required final Pubkey withdrawAuthority,
    required final Pubkey validatorList,
    required final Pubkey reserveStake,
    required final Pubkey uninitializedStakeAccount,
    required final Pubkey transientStakeAccount,
    required final Pubkey validatorStakeAccount,
    required final Pubkey voteAccount,
    // Data
    required final bu64 lamports,
    required final bu64 transientStakeSeed,
    required final bu64 ephemeralStakeSeed,
  }) {
    //  0. `[]` Stake pool
    //  1. `[s]` Stake pool staker
    //  2. `[]` Stake pool withdraw authority
    //  3. `[w]` Validator list
    //  4. `[w]` Stake pool reserve stake
    //  5. `[w]` Uninitialized ephemeral stake account to receive stake
    //  6. `[w]` Transient stake account
    //  7. `[]` Validator stake account
    //  8. `[]` Validator vote account to delegate to
    //  9. '[]' Clock sysvar
    // 10. `[]` Stake History sysvar
    // 11. `[]` Stake Config sysvar
    // 12. `[]` System program
    // 13. `[]` Stake program
    final List<AccountMeta> keys = [
      AccountMeta(stakePoolAddress),
      AccountMeta.signer(staker),
      AccountMeta(withdrawAuthority),
      AccountMeta.writable(validatorList),
      AccountMeta.writable(reserveStake),
      AccountMeta.writable(uninitializedStakeAccount),
      AccountMeta.writable(transientStakeAccount),
      AccountMeta(validatorStakeAccount),
      AccountMeta(voteAccount),
      AccountMeta(sysvarClockPubkey),
      AccountMeta(sysvarStakeHistoryPubkey),
      AccountMeta(StakeProgram.configId),
      AccountMeta(SystemProgram.programId),
      AccountMeta(StakeProgram.programId),
    ];

    final List<Iterable<int>> data = [
      borsh.u64.encode(lamports),
      borsh.u64.encode(transientStakeSeed),
      borsh.u64.encode(ephemeralStakeSeed),
    ];

    return _instance.createTransactionIntruction(
      StakePoolInstruction.increaseAdditionalValidatorStake,
      keys: keys,
      data: data,
    );
  }

  /// (Staker only) Decrease active stake again from a validator, eventually moving it to the
  /// reserve.
  ///
  /// Works regardless if the transient stake account already exists.
  ///
  /// Internally, this instruction splits a validator stake account into an ephemeral stake account,
  /// deactivates it, then merges or splits it into the transient stake account delegated to the
  /// appropriate validator.
  ///
  ///  The amount of lamports to move must be at least rent-exemption plus
  /// `max(crate::MINIMUM_ACTIVE_STAKE, solana_program::stake::tools::get_minimum_delegation())`.
  ///
  /// Keys:
  /// - `[]` [stakePoolAddress] - Stake pool.
  /// - `[s]` [staker] - Stake pool staker.
  /// - `[]` [withdrawAuthority] - Stake pool withdraw authority.
  /// - `[w]` [validatorList] - Validator list.
  /// - `[w]` [stakeAccount] - Canonical stake account to split from.
  /// - `[w]` [uninitializedStakeAccount] - Uninitialized ephemeral stake account to receive stake.
  /// - `[w]` [transientStakeAccount] - Transient stake account.
  ///
  /// Data:
  /// - [lamports] - Amount of lamports to split into the transient stake account.
  /// - [transientStakeSeed] - Seed used to create transient stake account.
  /// - [ephemeralStakeSeed] - Seed used to create ephemeral account.
  static TransactionInstruction decreaseAdditionalValidatorStake({
    // Keys
    required final Pubkey stakePoolAddress,
    required final Pubkey staker,
    required final Pubkey withdrawAuthority,
    required final Pubkey validatorList,
    required final Pubkey stakeAccount,
    required final Pubkey uninitializedStakeAccount,
    required final Pubkey transientStakeAccount,
    // Data
    required final bu64 lamports,
    required final bu64 transientStakeSeed,
    required final bu64 ephemeralStakeSeed,
  }) {
    //  0. `[]` Stake pool
    //  1. `[s]` Stake pool staker
    //  2. `[]` Stake pool withdraw authority
    //  3. `[w]` Validator list
    //  4. `[w]` Canonical stake account to split from
    //  5. `[w]` Uninitialized ephemeral stake account to receive stake
    //  6. `[w]` Transient stake account
    //  7. `[]` Clock sysvar
    //  8. '[]' Stake history sysvar
    //  9. `[]` System program
    // 10. `[]` Stake program
    final List<AccountMeta> keys = [
      AccountMeta(stakePoolAddress),
      AccountMeta.signer(staker),
      AccountMeta(withdrawAuthority),
      AccountMeta.writable(validatorList),
      AccountMeta.writable(stakeAccount),
      AccountMeta.writable(uninitializedStakeAccount),
      AccountMeta.writable(transientStakeAccount),
      AccountMeta(sysvarClockPubkey),
      AccountMeta(sysvarStakeHistoryPubkey),
      AccountMeta(SystemProgram.programId),
      AccountMeta(StakeProgram.programId),
    ];

    final List<Iterable<int>> data = [
      borsh.u64.encode(lamports),
      borsh.u64.encode(transientStakeSeed),
      borsh.u64.encode(ephemeralStakeSeed),
    ];

    return _instance.createTransactionIntruction(
      StakePoolInstruction.decreaseAdditionalValidatorStake,
      keys: keys,
      data: data,
    );
  }

  /// (Staker only) Redelegate active stake on a validator, eventually moving it to another.
  ///
  /// Internally, this instruction splits a validator stake account into its corresponding transient
  /// stake account, redelegates it to an ephemeral stake account, then merges that stake into the
  /// destination transient stake account.
  ///
  /// In order to rebalance the pool without taking custody, the staker needs a way of reducing the
  /// stake on a stake account. This instruction splits some amount of stake, up to the total
  /// activated stake, from the canonical validator stake account, into its "transient" stake
  /// account.
  ///
  /// The instruction only succeeds if the source transient stake account and ephemeral stake
  /// account do not exist.
  ///
  /// The amount of lamports to move must be at least twice rent-exemption plus the minimum
  /// delegation amount. Rent-exemption is required for the source transient stake account, and
  /// rent-exemption plus minimum delegation is required for the destination ephemeral stake
  /// account.
  ///
  ///  0. `[]` Stake pool
  ///  1. `[s]` Stake pool staker
  ///  2. `[]` Stake pool withdraw authority
  ///  3. `[w]` Validator list
  ///  4. `[w]` Source canonical stake account to split from
  ///  5. `[w]` Source transient stake account to receive split and be redelegated
  ///  6. `[w]` Uninitialized ephemeral stake account to receive redelegation
  ///  7. `[w]` Destination transient stake account to receive ephemeral stake by merge
  ///  8. `[]` Destination stake account to receive transient stake after activation
  ///  9. `[]` Destination validator vote account
  /// 10. `[]` Clock sysvar
  /// 11. `[]` Stake History sysvar
  /// 12. `[]` Stake Config sysvar
  /// 13. `[]` System program
  /// 14. `[]` Stake program
  ///
  /// ### Data:
  /// - [lamports] - Amount of lamports to redelegate.
  /// - [sourceTransientStakeSeed] - Seed used to create source transient stake account.
  /// - [ephemeralStakeSeed] - Seed used to create destination ephemeral account.
  /// - [destinationTransientStakeSeed] - Seed used to create destination transient stake account.
  ///   If there is already transient stake, this must match the current seed, otherwise it can be
  ///   anything.
  static TransactionInstruction redelegate({
    // Keys
    required final Pubkey stakePoolAddress,
    required final Pubkey staker,
    required final Pubkey withdrawAuthority,
    required final Pubkey validatorList,
    required final Pubkey sourceStakeAccount,
    required final Pubkey sourceTransientStakeAccount,
    required final Pubkey uninitializedEphemeralStakeAccount,
    required final Pubkey destinationTransientStakeAccount,
    required final Pubkey destinationStakeAccount,
    required final Pubkey destinationVoteAccount,
    // Data
    required final bu64 lamports,
    required final bu64 sourceTransientStakeSeed,
    required final bu64 ephemeralStakeSeed,
    required final bu64 destinationTransientStakeSeed,
  }) {
    //  0. `[]` Stake pool
    //  1. `[s]` Stake pool staker
    //  2. `[]` Stake pool withdraw authority
    //  3. `[w]` Validator list
    //  4. `[w]` Source canonical stake account to split from
    //  5. `[w]` Source transient stake account to receive split and be redelegated
    //  6. `[w]` Uninitialized ephemeral stake account to receive redelegation
    //  7. `[w]` Destination transient stake account to receive ephemeral stake by merge
    //  8. `[]` Destination stake account to receive transient stake after activation
    //  9. `[]` Destination validator vote account
    // 10. `[]` Clock sysvar
    // 11. `[]` Stake History sysvar
    // 12. `[]` Stake Config sysvar
    // 13. `[]` System program
    // 14. `[]` Stake program
    final List<AccountMeta> keys = [
      AccountMeta(stakePoolAddress),
      AccountMeta.signer(staker),
      AccountMeta(withdrawAuthority),
      AccountMeta.writable(validatorList),
      AccountMeta.writable(sourceStakeAccount),
      AccountMeta.writable(sourceTransientStakeAccount),
      AccountMeta.writable(uninitializedEphemeralStakeAccount),
      AccountMeta.writable(destinationTransientStakeAccount),
      AccountMeta(destinationStakeAccount),
      AccountMeta(destinationVoteAccount),
      AccountMeta(sysvarClockPubkey),
      AccountMeta(sysvarStakeHistoryPubkey),
      AccountMeta(StakeProgram.configId),
      AccountMeta(SystemProgram.programId),
      AccountMeta(StakeProgram.programId),
    ];

    final List<Iterable<int>> data = [
      borsh.u64.encode(lamports),
      borsh.u64.encode(sourceTransientStakeSeed),
      borsh.u64.encode(ephemeralStakeSeed),
      borsh.u64.encode(destinationTransientStakeSeed),
    ];

    return _instance.createTransactionIntruction(
      StakePoolInstruction.redelegate,
      keys: keys,
      data: data,
    );
  }
}
