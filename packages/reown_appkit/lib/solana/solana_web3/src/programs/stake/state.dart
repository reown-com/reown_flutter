/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'dart:convert';
import 'package:reown_appkit/solana/solana_borsh/borsh.dart';
import 'package:reown_appkit/solana/solana_borsh/codecs.dart';
import 'package:reown_appkit/solana/solana_borsh/models.dart';
import 'package:reown_appkit/solana/solana_borsh/types.dart';
import 'package:reown_appkit/solana/solana_common/types.dart';
import '../../crypto/pubkey.dart';

/// Stake State
/// ------------------------------------------------------------------------------------------------

enum StakeState { uninitialized, initialized, stake, rewardsPool }

/// Authorized
/// ------------------------------------------------------------------------------------------------

class Authorized extends BorshObject {
  /// Stake account authority info.
  const Authorized({required this.staker, required this.withdrawer});

  /// Stake authority.
  final String staker;

  /// Withdraw authority.
  final String withdrawer;

  /// {@macro solana_borsh.BorshObject.borshCodec}
  static BorshStructSizedCodec get codec =>
      borsh.structSized({'staker': borsh.pubkey, 'withdrawer': borsh.pubkey});

  @override
  BorshSchema get borshSchema => codec.schema;

  /// {@macro solana_common.Serializable.fromJson}
  factory Authorized.fromJson(final Map<String, dynamic> json) =>
      Authorized(staker: json['staker'], withdrawer: json['withdrawer']);

  /// {@macro solana_common.Serializable.tryFromJson}
  static Authorized? tryFromJson(final Map<String, dynamic>? json) =>
      json != null ? Authorized.fromJson(json) : null;

  @override
  Map<String, dynamic> toJson() => {'staker': staker, 'withdrawer': withdrawer};
}

/// Stake Authorize
/// ------------------------------------------------------------------------------------------------

enum StakeAuthorize { staker, withdrawer }

/// Lockup
/// ------------------------------------------------------------------------------------------------

class Lockup extends BorshObject {
  /// Stake account lockup info.
  const Lockup({
    required this.unixTimestamp,
    required this.epoch,
    required this.custodian,
  });

  /// Unix timestamp of lockup expiration.
  final i64 unixTimestamp;

  /// Epoch of lockup expiration.
  final i64 epoch;

  /// Lockup custodian authority (base-58).
  final String custodian;

  /// {@macro solana_borsh.BorshObject.borshCodec}
  static BorshStructSizedCodec get codec => borsh.structSized({
    'unixTimestamp': borsh.i64,
    'epoch': borsh.i64,
    'custodian': borsh.pubkey,
  });

  @override
  BorshSchema get borshSchema => codec.schema;

  /// {@macro solana_common.Serializable.fromJson}
  factory Lockup.fromJson(final Map<String, dynamic> json) => Lockup(
    unixTimestamp: json['unixTimestamp'],
    epoch: json['epoch'],
    custodian: json['custodian'],
  );

  /// {@macro solana_common.Serializable.tryFromJson}
  static Lockup? tryFromJson(final Map<String, dynamic>? json) =>
      json != null ? Lockup.fromJson(json) : null;

  /// The default, inactive lockup value.
  static Lockup get inactive =>
      Lockup(unixTimestamp: 0, epoch: 0, custodian: Pubkey.zero().toBase58());

  @override
  Map<String, dynamic> toJson() => {
    'unixTimestamp': unixTimestamp,
    'epoch': epoch,
    'custodian': custodian,
  };
}

/// Lockup Args
/// ------------------------------------------------------------------------------------------------

class LockupArgs extends BorshObject {
  /// Stake account lockup arguments.
  const LockupArgs({this.unixTimestamp, this.epoch, this.custodian});

  /// Unix timestamp of lockup expiration.
  final i64? unixTimestamp;

  /// Epoch of lockup expiration.
  final i64? epoch;

  /// Lockup custodian authority (base-58).
  final String? custodian;

  /// {@macro solana_borsh.BorshObject.borshCodec}
  static BorshStructCodec get codec => borsh.struct({
    'unixTimestamp': borsh.i64.option(),
    'epoch': borsh.i64.option(),
    'custodian': borsh.pubkey.option(),
  });

  @override
  BorshSchema get borshSchema => codec.schema;

  /// {@macro solana_common.Serializable.fromJson}
  factory LockupArgs.fromJson(final Map<String, dynamic> json) => LockupArgs(
    unixTimestamp: json['unixTimestamp'],
    epoch: json['epoch'],
    custodian: json['custodian'],
  );

  /// {@macro solana_common.Serializable.tryFromJson}
  static LockupArgs? tryFromJson(final Map<String, dynamic>? json) =>
      json != null ? LockupArgs.fromJson(json) : null;

  @override
  Map<String, dynamic> toJson() => {
    'unixTimestamp': unixTimestamp,
    'epoch': epoch,
    'custodian': custodian,
  };
}

/// Lockup Checked Args
/// ------------------------------------------------------------------------------------------------

class LockupCheckedArgs extends BorshObject {
  /// Stake account lockup arguments.
  const LockupCheckedArgs({this.unixTimestamp, this.epoch});

  /// Unix timestamp of lockup expiration.
  final i64? unixTimestamp;

  /// Epoch of lockup expiration.
  final i64? epoch;

  /// {@macro solana_borsh.BorshObject.borshCodec}
  static BorshStructSizedCodec get codec => borsh.structSized({
    'unixTimestamp': borsh.i64.option(),
    'epoch': borsh.i64.option(),
  });

  @override
  BorshSchema get borshSchema => codec.schema;

  /// {@macro solana_common.Serializable.fromJson}
  factory LockupCheckedArgs.fromJson(final Map<String, dynamic> json) =>
      LockupCheckedArgs(
        unixTimestamp: json['unixTimestamp'],
        epoch: json['epoch'],
      );

  /// {@macro solana_common.Serializable.tryFromJson}
  static LockupCheckedArgs? tryFromJson(final Map<String, dynamic>? json) =>
      json != null ? LockupCheckedArgs.fromJson(json) : null;

  @override
  Map<String, dynamic> toJson() => {
    'unixTimestamp': unixTimestamp,
    'epoch': epoch,
  };
}

/// Stake Account Type
/// ------------------------------------------------------------------------------------------------

enum StakeAccountType { uninitialized, initialized, delegated, rewardsPool }

/// Stake
/// ------------------------------------------------------------------------------------------------

class Stake extends BorshObject {
  const Stake({required this.delegation, required this.creditsObserved});

  final Delegation delegation;

  /// Credits observed is credits from vote account state when delegated or redeemed.
  final u64 creditsObserved;

  /// {@macro solana_borsh.BorshObject.borshCodec}
  static BorshStructSizedCodec get codec => borsh.structSized({
    'delegation': Delegation.codec,
    'creditsObserved': borsh.u64,
  });

  @override
  BorshSchema get borshSchema => codec.schema;

  /// {@macro solana_borsh.BorshObject.fromBorsh}
  static Stake fromBorsh(final Iterable<int> buffer) =>
      borsh.deserialize(codec.schema, buffer, Stake.fromJson);

  /// {@macro solana_borsh.BorshObject.tryFromBorsh}
  static Stake? tryFromBorsh(final Iterable<int>? buffer) =>
      buffer != null ? Stake.fromBorsh(buffer) : null;

  /// {@macro solana_borsh.BorshObject.fromBorshBase64}
  factory Stake.fromBorshBase64(final String encoded) =>
      Stake.fromBorsh(base64.decode(encoded));

  /// {@macro solana_borsh.BorshObject.tryFromBorshBase64}
  static Stake? tryFromBorshBase64(final String? encoded) =>
      encoded != null ? Stake.fromBorshBase64(encoded) : null;

  /// {@macro solana_common.Serializable.fromJson}
  factory Stake.fromJson(final Map<String, dynamic> json) => Stake(
    delegation: Delegation.fromJson(json['delegation']),
    creditsObserved: json['creditsObserved'],
  );

  /// {@macro solana_common.Serializable.tryFromJson}
  static Stake? tryFromJson(final Map<String, dynamic>? json) =>
      json != null ? Stake.fromJson(json) : null;

  @override
  Map<String, dynamic> toJson() => {
    'delegation': delegation.toJson(),
    'creditsObserved': creditsObserved,
  };
}

/// Delegation
/// ------------------------------------------------------------------------------------------------

class Delegation extends BorshObject {
  const Delegation({
    required this.voterPubkey,
    required this.stake,
    required this.activationEpoch,
    required this.deactivationEpoch,
    required this.warmupCooldownRate,
  });

  /// To whom the stake is delegated (base-58).
  final String voterPubkey;

  /// Activated stake amount, set at delegate() time.
  final u64 stake;

  /// Epoch at which this stake was activated, std::Epoch::MAX if is a bootstrap stake.
  final u64 activationEpoch;

  /// Epoch the stake was deactivated, std::Epoch::MAX if not deactivated.
  final u64 deactivationEpoch;

  /// How much stake we can activate per-epoch as a fraction of currently effective stake.
  final f64 warmupCooldownRate;

  /// {@macro solana_borsh.BorshObject.borshCodec}
  static BorshStructSizedCodec get codec => borsh.structSized({
    'voterPubkey': borsh.pubkey,
    'stake': borsh.u64,
    'activationEpoch': borsh.u64,
    'deactivationEpoch': borsh.u64,
    'warmupCooldownRate': borsh.f64,
  });

  @override
  BorshSchema get borshSchema => codec.schema;

  /// {@macro solana_borsh.BorshObject.fromBorsh}
  static Delegation fromBorsh(final Iterable<int> buffer) =>
      borsh.deserialize(codec.schema, buffer, Delegation.fromJson);

  /// {@macro solana_borsh.BorshObject.tryFromBorsh}
  static Delegation? tryFromBorsh(final Iterable<int>? buffer) =>
      buffer != null ? Delegation.fromBorsh(buffer) : null;

  /// {@macro solana_borsh.BorshObject.fromBorshBase64}
  factory Delegation.fromBorshBase64(final String encoded) =>
      Delegation.fromBorsh(base64.decode(encoded));

  /// {@macro solana_borsh.BorshObject.tryFromBorshBase64}
  static Delegation? tryFromBorshBase64(final String? encoded) =>
      encoded != null ? Delegation.fromBorshBase64(encoded) : null;

  /// {@macro solana_common.Serializable.fromJson}
  factory Delegation.fromJson(final Map<String, dynamic> json) => Delegation(
    voterPubkey: json['voterPubkey'],
    stake: json['stake'],
    activationEpoch: json['activationEpoch'],
    deactivationEpoch: json['deactivationEpoch'],
    warmupCooldownRate: json['warmupCooldownRate'],
  );

  /// {@macro solana_common.Serializable.tryFromJson}
  static Delegation? tryFromJson(final Map<String, dynamic>? json) =>
      json != null ? Delegation.fromJson(json) : null;

  @override
  Map<String, dynamic> toJson() => {
    'voterPubkey': voterPubkey,
    'stake': stake,
    'activationEpoch': activationEpoch,
    'deactivationEpoch': deactivationEpoch,
    'warmupCooldownRate': warmupCooldownRate,
  };
}

/// Meta
/// ------------------------------------------------------------------------------------------------

class StakeMeta extends BorshObject {
  const StakeMeta({
    required this.rentExemptReserve,
    required this.authorized,
    required this.lockup,
  });

  final u64 rentExemptReserve;
  final Authorized authorized;
  final Lockup lockup;

  /// {@macro solana_borsh.BorshObject.borshCodec}
  static final BorshStructSizedCodec codec = borsh.structSized({
    'rentExemptReserve': borsh.u64,
    'authorized': Authorized.codec,
    'lockup': Lockup.codec,
  });

  @override
  BorshSchema get borshSchema => codec.schema;

  /// {@macro solana_borsh.BorshObject.fromBorsh}
  static StakeMeta fromBorsh(final Iterable<int> buffer) =>
      borsh.deserialize(codec.schema, buffer, StakeMeta.fromJson);

  /// {@macro solana_borsh.BorshObject.tryFromBorsh}
  static StakeMeta? tryFromBorsh(final Iterable<int>? buffer) =>
      buffer != null ? StakeMeta.fromBorsh(buffer) : null;

  /// {@macro solana_borsh.BorshObject.fromBorshBase64}
  factory StakeMeta.fromBorshBase64(final String encoded) =>
      StakeMeta.fromBorsh(base64.decode(encoded));

  /// {@macro solana_borsh.BorshObject.tryFromBorshBase64}
  static StakeMeta? tryFromBorshBase64(final String? encoded) =>
      encoded != null ? StakeMeta.fromBorshBase64(encoded) : null;

  /// {@macro solana_common.Serializable.fromJson}
  factory StakeMeta.fromJson(final Map<String, dynamic> json) => StakeMeta(
    rentExemptReserve: json['rentExemptReserve'],
    authorized: Authorized.fromJson(json['authorized']),
    lockup: Lockup.fromJson(json['lockup']),
  );

  /// {@macro solana_common.Serializable.tryFromJson}
  static StakeMeta? tryFromJson(final Map<String, dynamic>? json) =>
      json != null ? StakeMeta.fromJson(json) : null;

  @override
  Map<String, dynamic> toJson() => {
    'rentExemptReserve': rentExemptReserve,
    'authorized': authorized.toJson(),
    'lockup': lockup.toJson(),
  };
}
