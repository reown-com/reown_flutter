/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'dart:convert';
import 'dart:typed_data';
import 'package:reown_appkit/solana/solana_borsh/borsh.dart';
import 'package:reown_appkit/solana/solana_borsh/codecs.dart';
import 'package:reown_appkit/solana/solana_borsh/models.dart';
import 'package:reown_appkit/solana/solana_borsh/types.dart';
import 'package:reown_appkit/solana/solana_common/extensions.dart';
import 'package:reown_appkit/solana/solana_common/models.dart';
import 'package:reown_appkit/solana/solana_common/types.dart';
import '../../rpc/models/account_info.dart';
import '../stake/state.dart';

/// Account Type
/// ------------------------------------------------------------------------------------------------

enum AccountType {
  /// The account has not been initialized.
  uninitialized,

  /// Stake pool.
  stakePool,

  /// Validator stake list.
  validatorList,
}

/// Fee
/// ------------------------------------------------------------------------------------------------

/// Fee rate as a ratio, minted on `UpdateStakePoolBalance` as a proportion of the rewards.
/// If either the numerator or the denominator is 0, the fee is considered to be 0.
class Fee extends BorshObject {
  const Fee({required this.denominator, required this.numerator});

  /// Denominator of the fee ratio.
  final u64 denominator;

  /// Numerator of the fee ratio.
  final u64 numerator;

  double get ratio => denominator == 0.0 ? 0.0 : numerator / denominator;

  factory Fee.fromJson(final Map<String, dynamic> json) =>
      Fee(denominator: json['denominator'], numerator: json['numerator']);

  static Fee? tryFromJson(final Map<String, dynamic>? json) =>
      json != null ? Fee.fromJson(json) : null;

  static BorshStructSizedCodec get codec =>
      borsh.structSized({'denominator': borsh.u64, 'numerator': borsh.u64});

  @override
  BorshSchema get borshSchema => codec.schema;

  @override
  Map<String, dynamic> toJson() => {
    'denominator': denominator,
    'numerator': numerator,
  };
}

/// Stake Pool
/// ------------------------------------------------------------------------------------------------

class StakePool extends BorshObject {
  const StakePool({
    required this.accountType,
    required this.manager,
    required this.staker,
    required this.stakeDepositAuthority,
    required this.stakeWithdrawBumpSeed,
    required this.validatorList,
    required this.reserveStake,
    required this.poolMint,
    required this.managerFeeAccount,
    required this.tokenProgramId,
    required this.totalLamports,
    required this.poolTokenSupply,
    required this.lastUpdateEpoch,
    required this.lockup,
    required this.epochFee,
    required this.nextEpochFee,
    required this.preferredDepositValidatorVoteAddress,
    required this.preferredWithdrawValidatorVoteAddress,
    required this.stakeDepositFee,
    required this.stakeWithdrawalFee,
    required this.nextStakeWithdrawalFee,
    required this.stakeReferralFee,
    required this.solDepositAuthority,
    required this.solDepositFee,
    required this.solReferralFee,
    required this.solWithdrawAuthority,
    required this.solWithdrawalFee,
    required this.nextSolWithdrawalFee,
    required this.lastEpochPoolTokenSupply,
    required this.lastEpochTotalLamports,
  });

  /// Account type, must be StakePool currently
  final AccountType accountType;

  /// Manager authority, allows for updating the staker, manager, and fee account
  final String manager; // pubkey

  /// Staker authority, allows for adding and removing validators, and managing stake
  /// distribution
  final String staker; // pubkey

  /// Stake deposit authority
  ///
  /// If a depositor pubkey is specified on initialization, then deposits must be signed by this
  /// authority. If no deposit authority is specified, then the stake pool will default to the
  /// result of:
  /// ```
  /// Pubkey::find_program_address(
  ///     [
  ///       <stake_pool_address>,
  ///       utf8.encode("deposit"),
  ///     ],
  ///     <stake_pool_program_id>,
  /// );
  /// ```
  final String stakeDepositAuthority; // pubkey

  /// Stake withdrawal authority bump seed
  /// for `create_program_address(&[state::StakePool account, "withdrawal"])`
  final u8 stakeWithdrawBumpSeed; // u8

  /// Validator stake list storage account
  final String validatorList; // pubkey

  /// Reserve stake account, holds deactivated stake
  final String reserveStake; // pubkey

  /// Pool Mint
  final String poolMint; // pubkey

  /// Manager fee account
  final String managerFeeAccount; // pubkey

  /// Pool token program id
  final String tokenProgramId; // pubkey

  /// Total stake under management.
  /// Note that if `lastUpdateEpoch` does not match the current epoch then
  /// this field may not be accurate
  final u64 totalLamports; // u64;

  /// Total supply of pool tokens (should always match the supply in the Pool Mint)
  final u64 poolTokenSupply; // u64

  /// Last epoch the `totalLamports` field was updated
  final u64 lastUpdateEpoch; // u64

  /// Lockup that all stakes in the pool must have
  final Lockup lockup;

  /// Fee taken as a proportion of rewards each epoch
  final Fee epochFee;

  /// Fee for next epoch
  final Fee? nextEpochFee;

  /// Preferred deposit validator vote account pubkey
  final String? preferredDepositValidatorVoteAddress; // Option<pubkey>

  /// Preferred withdraw validator vote account pubkey
  final String? preferredWithdrawValidatorVoteAddress; // Option<pubkey>

  /// Fee assessed on stake deposits
  final Fee stakeDepositFee;

  /// Fee assessed on withdrawals
  final Fee stakeWithdrawalFee;

  /// Future stake withdrawal fee, to be set for the following epoch
  final Fee? nextStakeWithdrawalFee;

  /// Fees paid out to referrers on referred stake deposits.
  /// Expressed as a percentage (0 - 100) of deposit fees.
  /// i.e. `stakeDepositFee`% of stake deposited is collected as deposit fees for every deposit
  /// and `stakeReferralFee`% of the collected stake deposit fees is paid out to the referrer
  final u8 stakeReferralFee; // u8

  /// Toggles whether the `DepositSol` instruction requires a signature from
  /// this `solDepositAuthority`
  final String? solDepositAuthority; // Option<pubkey>

  /// Fee assessed on SOL deposits
  final Fee solDepositFee;

  /// Fees paid out to referrers on referred SOL deposits.
  /// Expressed as a percentage (0 - 100) of SOL deposit fees.
  /// i.e. `solDepositFee`% of SOL deposited is collected as deposit fees for every deposit
  /// and `solReferralFee`% of the collected SOL deposit fees is paid out to the referrer
  final u8 solReferralFee; // u8

  /// Toggles whether the `WithdrawSol` instruction requires a signature from
  /// the `deposit_authority`
  final String? solWithdrawAuthority; // Option<pubkey>

  /// Fee assessed on SOL withdrawals
  final Fee solWithdrawalFee;

  /// Future SOL withdrawal fee, to be set for the following epoch
  final Fee? nextSolWithdrawalFee;

  /// Last epoch's total pool tokens, used only for APR estimation
  final u64 lastEpochPoolTokenSupply; // u64

  /// Last epoch's total lamports, used only for APR estimation
  final u64 lastEpochTotalLamports; // u64

  factory StakePool.fromAccountInfo(final AccountInfo info) {
    final Uint8List buffer = base64.decode((info.data as List)[0]);
    return borsh.deserialize(codec.schema, buffer, StakePool.fromJson);
  }

  factory StakePool.fromJson(final Map<String, dynamic> json) => StakePool(
    accountType: json['accountType'],
    manager: json['manager'],
    staker: json['staker'],
    stakeDepositAuthority: json['stakeDepositAuthority'],
    stakeWithdrawBumpSeed: json['stakeWithdrawBumpSeed'],
    validatorList: json['validatorList'],
    reserveStake: json['reserveStake'],
    poolMint: json['poolMint'],
    managerFeeAccount: json['managerFeeAccount'],
    tokenProgramId: json['tokenProgramId'],
    totalLamports: json['totalLamports'],
    poolTokenSupply: json['poolTokenSupply'],
    lastUpdateEpoch: json['lastUpdateEpoch'],
    lockup: Lockup.fromJson(json['lockup']),
    epochFee: Fee.fromJson(json['epochFee']),
    nextEpochFee: Fee.tryFromJson(json['nextEpochFee']),
    preferredDepositValidatorVoteAddress:
        json['preferredDepositValidatorVoteAddress'],
    preferredWithdrawValidatorVoteAddress:
        json['preferredWithdrawValidatorVoteAddress'],
    stakeDepositFee: Fee.fromJson(json['stakeDepositFee']),
    stakeWithdrawalFee: Fee.fromJson(json['stakeWithdrawalFee']),
    nextStakeWithdrawalFee: Fee.tryFromJson(json['nextStakeWithdrawalFee']),
    stakeReferralFee: json['stakeReferralFee'],
    solDepositAuthority: json['solDepositAuthority'],
    solDepositFee: Fee.fromJson(json['solDepositFee']),
    solReferralFee: json['solReferralFee'],
    solWithdrawAuthority: json['solWithdrawAuthority'],
    solWithdrawalFee: Fee.fromJson(json['solWithdrawalFee']),
    nextSolWithdrawalFee: Fee.tryFromJson(json['nextSolWithdrawalFee']),
    lastEpochPoolTokenSupply: json['lastEpochPoolTokenSupply'],
    lastEpochTotalLamports: json['lastEpochTotalLamports'],
  );

  static BorshStructCodec get codec => borsh.struct({
    'accountType': borsh.enumeration(AccountType.values),
    'manager': borsh.pubkey,
    'staker': borsh.pubkey,
    'stakeDepositAuthority': borsh.pubkey,
    'stakeWithdrawBumpSeed': borsh.u8,
    'validatorList': borsh.pubkey,
    'reserveStake': borsh.pubkey,
    'poolMint': borsh.pubkey,
    'managerFeeAccount': borsh.pubkey,
    'tokenProgramId': borsh.pubkey,
    'totalLamports': borsh.u64,
    'poolTokenSupply': borsh.u64,
    'lastUpdateEpoch': borsh.u64,
    'lockup': Lockup.codec,
    'epochFee': Fee.codec,
    'nextEpochFee': Fee.codec.option(),
    'preferredDepositValidatorVoteAddress': borsh.pubkey.option(),
    'preferredWithdrawValidatorVoteAddress': borsh.pubkey.option(),
    'stakeDepositFee': Fee.codec,
    'stakeWithdrawalFee': Fee.codec,
    'nextStakeWithdrawalFee': Fee.codec.option(),
    'stakeReferralFee': borsh.u8,
    'solDepositAuthority': borsh.pubkey.option(),
    'solDepositFee': Fee.codec,
    'solReferralFee': borsh.u8,
    'solWithdrawAuthority': borsh.pubkey.option(),
    'solWithdrawalFee': Fee.codec,
    'nextSolWithdrawalFee': Fee.codec.option(),
    'lastEpochPoolTokenSupply': borsh.u64,
    'lastEpochTotalLamports': borsh.u64,
  });

  @override
  BorshSchema get borshSchema => codec.schema;

  @override
  Map<String, dynamic> toJson() => {
    'accountType': accountType,
    'manager': manager,
    'staker': staker,
    'stakeDepositAuthority': stakeDepositAuthority,
    'stakeWithdrawBumpSeed': stakeWithdrawBumpSeed,
    'validatorList': validatorList,
    'reserveStake': reserveStake,
    'poolMint': poolMint,
    'managerFeeAccount': managerFeeAccount,
    'tokenProgramId': tokenProgramId,
    'totalLamports': totalLamports,
    'poolTokenSupply': poolTokenSupply,
    'lastUpdateEpoch': lastUpdateEpoch,
    'lockup': lockup.toJson(),
    'epochFee': epochFee.toJson(),
    'nextEpochFee': nextEpochFee?.toJson(),
    'preferredDepositValidatorVoteAddress':
        preferredDepositValidatorVoteAddress,
    'preferredWithdrawValidatorVoteAddress':
        preferredWithdrawValidatorVoteAddress,
    'stakeDepositFee': stakeDepositFee.toJson(),
    'stakeWithdrawalFee': stakeWithdrawalFee.toJson(),
    'nextStakeWithdrawalFee': nextStakeWithdrawalFee?.toJson(),
    'stakeReferralFee': stakeReferralFee,
    'solDepositAuthority': solDepositAuthority,
    'solDepositFee': solDepositFee.toJson(),
    'solReferralFee': solReferralFee,
    'solWithdrawAuthority': solWithdrawAuthority,
    'solWithdrawalFee': solWithdrawalFee.toJson(),
    'nextSolWithdrawalFee': nextSolWithdrawalFee?.toJson(),
    'lastEpochPoolTokenSupply': lastEpochPoolTokenSupply,
    'lastEpochTotalLamports': lastEpochTotalLamports,
  };
}

/// Validator List
/// ------------------------------------------------------------------------------------------------

class ValidatorList extends BorshObject {
  /// Storage list for all validator stake accounts in the pool.
  const ValidatorList({required this.header, required this.validators});

  /// Data outside of the validator list, separated out for cheaper deserializations
  final ValidatorListHeader header;

  /// List of stake info for each validator in the pool
  final List<ValidatorStakeInfo> validators;

  factory ValidatorList.fromAccountInfo(final AccountInfo info) {
    final Uint8List buffer = base64.decode((info.data as List)[0]);
    return borsh.deserialize(codec.schema, buffer, ValidatorList.fromJson);
  }

  factory ValidatorList.fromJson(final Map<String, dynamic> json) {
    return ValidatorList(
      header: ValidatorListHeader.fromJson(json['header']),
      validators: IterableSerializable.fromJson(
        json['validators'],
        ValidatorStakeInfo.fromJson,
      ),
    );
  }

  static BorshStructCodec get codec => borsh.struct({
    'header': ValidatorListHeader.codec,
    'validators': borsh.vec(ValidatorStakeInfo.codec),
  });

  @override
  BorshSchema get borshSchema => codec.schema;

  @override
  Map<String, dynamic> toJson() => {
    'header': header.toJson(),
    'validators': validators.toJson(),
  };
}

/// Validator List Header
/// ------------------------------------------------------------------------------------------------

class ValidatorListHeader extends BorshObject {
  /// Helper type to deserialize just the start of a ValidatorList.
  const ValidatorListHeader({
    required this.accountType,
    required this.maxValidators,
  });

  /// Account type, must be ValidatorList currently
  final AccountType accountType;

  /// Maximum allowable number of validators
  final int maxValidators;

  factory ValidatorListHeader.fromAccountInfo(final AccountInfo info) {
    final Uint8List buffer = base64.decode((info.data as List)[0]);
    return borsh.deserialize(
      codec.schema,
      buffer,
      ValidatorListHeader.fromJson,
    );
  }

  factory ValidatorListHeader.fromJson(final Map<String, dynamic> json) =>
      ValidatorListHeader(
        accountType: json['accountType'],
        maxValidators: json['maxValidators'],
      );

  static BorshStructSizedCodec get codec => borsh.structSized({
    'accountType': borsh.enumeration(AccountType.values),
    'maxValidators': borsh.u32,
  });

  @override
  BorshSchema get borshSchema => codec.schema;

  @override
  Map<String, dynamic> toJson() => {
    'accountType': accountType,
    'maxValidators': maxValidators,
  };
}

/// Stake Status
/// ------------------------------------------------------------------------------------------------

/// Status of the stake account in the validator list, for accounting.
enum StakeStatus {
  /// Stake account is active, there may be a transient stake as well
  active,

  /// Only transient stake account exists, when a transient stake is
  /// deactivating during validator removal
  deactivatingTransient,

  /// No more validator stake accounts exist, entry ready for removal during
  /// `UpdateStakePoolBalance`
  readyForRemoval,

  /// Only the validator stake account is deactivating, no transient stake
  /// account exists
  deactivatingValidator,

  /// Both the transient and validator stake account are deactivating, when
  /// a validator is removed with a transient stake active
  deactivatingAll,
}

/// Stake Withdraw Source
/// ------------------------------------------------------------------------------------------------

/// Withdrawal type, figured out during process_withdraw_stake
enum StakeWithdrawSource {
  /// Some of an active stake account, but not all
  active,

  /// Some of a transient stake account
  transient,

  /// Take a whole validator stake account
  validatorRemoval,
}

/// Validator Stake Info
/// ------------------------------------------------------------------------------------------------

class ValidatorStakeInfo extends Serializable with BorshObjectMixin {
  /// Information about a validator in the pool
  ///
  /// NOTE: ORDER IS VERY IMPORTANT HERE, PLEASE DO NOT RE-ORDER THE FIELDS UNLESS
  /// THERE'S AN EXTREMELY GOOD REASON.
  ///
  /// To save on BPF instructions, the serialized bytes are reinterpreted with an
  /// unsafe pointer cast, which means that this structure cannot have any
  /// undeclared alignment-padding in its representation.
  const ValidatorStakeInfo({
    required this.activeStakeLamports,
    required this.transientStakeLamports,
    required this.lastUpdateEpoch,
    required this.transientSeedSuffix,
    required this.unused,
    required this.validatorSeedSuffix,
    required this.status,
    required this.voteAccountAddress,
  });

  /// Amount of lamports on the validator stake account, including rent
  ///
  /// Note that if `lastUpdateEpoch` does not match the current epoch then
  /// this field may not be accurate
  final u64 activeStakeLamports; // u64

  /// Amount of transient stake delegated to this validator
  ///
  /// Note that if `lastUpdateEpoch` does not match the current epoch then
  /// this field may not be accurate
  final u64 transientStakeLamports; // u64

  /// Last epoch the active and transient stake lamports fields were updated
  final u64 lastUpdateEpoch; // u64

  /// Transient account seed suffix, used to derive the transient stake account address
  final u64 transientSeedSuffix; // u64

  /// Unused space, initially meant to specify the end of seed suffixes
  final u32 unused; // u32

  /// Validator account seed suffix
  final u32
  validatorSeedSuffix; // u32 - really `Option<NonZeroU32>` so 0 is `None`

  /// Status of the validator stake account.
  final StakeStatus status;

  /// Validator vote account address.
  final String voteAccountAddress;

  factory ValidatorStakeInfo.fromAccountInfo(final AccountInfo info) {
    final Uint8List buffer = base64.decode((info.data as List)[0]);
    return borsh.deserialize(codec.schema, buffer, ValidatorStakeInfo.fromJson);
  }

  factory ValidatorStakeInfo.fromJson(final Map<String, dynamic> json) =>
      ValidatorStakeInfo(
        activeStakeLamports: json['activeStakeLamports'],
        transientStakeLamports: json['transientStakeLamports'],
        lastUpdateEpoch: json['lastUpdateEpoch'],
        transientSeedSuffix: json['transientSeedSuffix'],
        unused: json['unused'],
        validatorSeedSuffix: json['validatorSeedSuffix'],
        status: json['status'],
        voteAccountAddress: json['voteAccountAddress'],
      );

  static BorshStructSizedCodec get codec => borsh.structSized({
    'activeStakeLamports': borsh.u64,
    'transientStakeLamports': borsh.u64,
    'lastUpdateEpoch': borsh.u64,
    'transientSeedSuffix': borsh.u64,
    'unused': borsh.u32,
    'validatorSeedSuffix': borsh.u32,
    'status': borsh.enumeration(StakeStatus.values),
    'voteAccountAddress': borsh.pubkey,
  });

  @override
  BorshSchema get borshSchema => codec.schema;

  @override
  Map<String, dynamic> toJson() => {
    'activeStakeLamports': activeStakeLamports,
    'transientStakeLamports': transientStakeLamports,
    'lastUpdateEpoch': lastUpdateEpoch,
    'transientSeedSuffix': transientSeedSuffix,
    'unused': unused,
    'validatorSeedSuffix': validatorSeedSuffix,
    'status': status,
    'voteAccountAddress': voteAccountAddress,
  };
}

/// Preferred Validator Type
/// ------------------------------------------------------------------------------------------------

/// Defines which validator vote account is set during the `setPreferredValidator` instruction.
enum PreferredValidatorType {
  /// Set preferred validator for deposits.
  deposit,

  /// Set preferred validator for withdraws.
  withdraw,
}

/// Funding Type
/// ------------------------------------------------------------------------------------------------

/// Defines which authority to update in the `setFundingAuthority` instruction.
enum FundingType {
  /// Sets the stake deposit authority.
  stakeDeposit,

  /// Sets the SOL deposit authority.
  solDeposit,

  /// Sets the SOL withdraw authority.
  solWithdraw,
}

/// Fee Type
/// ------------------------------------------------------------------------------------------------

/// The type of fees that can be set on the stake pool.
class FeeType extends RustEnum {
  const FeeType._(super.index, super.codec);

  factory FeeType.from(final int index, final List values) =>
      FeeType._(index, values);

  static List<BorshTupleSizedCodec> get codecs => [
    borsh.tupleSized([borsh.u8]),
    borsh.tupleSized([borsh.u8]),
    borsh.tupleSized([borsh.structSized(Fee.codec.schema)]),
    borsh.tupleSized([borsh.structSized(Fee.codec.schema)]),
    borsh.tupleSized([borsh.structSized(Fee.codec.schema)]),
    borsh.tupleSized([borsh.structSized(Fee.codec.schema)]),
    borsh.tupleSized([borsh.structSized(Fee.codec.schema)]),
  ];

  /// Referral fees for SOL deposits.
  static FeeType solReferral(final u8 arg0) => FeeType._(0, [arg0]);

  /// Referral fees for stake deposits.
  static FeeType stakeReferral(final u8 arg0) => FeeType._(1, [arg0]);

  /// Management fee paid per epoch.
  static FeeType epoch(final Fee fee) => FeeType._(2, [fee]);

  /// Stake withdrawal fee.
  static FeeType stakeWithdrawal(final Fee fee) => FeeType._(3, [fee]);

  /// Deposit fee for SOL deposits.
  static FeeType solDeposit(final Fee fee) => FeeType._(4, [fee]);

  /// Deposit fee for stake deposits.
  static FeeType stakeDeposit(final Fee fee) => FeeType._(5, [fee]);

  /// SOL withdrawal fee.
  static FeeType solWithdrawal(final Fee fee) => FeeType._(6, [fee]);
}
