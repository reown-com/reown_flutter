/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../crypto/pubkey.dart';

/// Sysvar Public Keys
/// ------------------------------------------------------------------------------------------------

/// The Clock sysvar contains data on cluster time, including the current slot, epoch, and estimated
/// wall-clock Unix timestamp. It is updated every slot.
final Pubkey sysvarClockPubkey = Pubkey.fromBase58(
  'SysvarC1ock11111111111111111111111111111111',
);

/// The EpochSchedule sysvar contains epoch scheduling constants that are set in genesis, and
/// enables calculating the number of slots in a given epoch, the epoch for a given slot, etc.
final Pubkey sysvarEpochSchedulePubkey = Pubkey.fromBase58(
  'SysvarEpochSchedu1e111111111111111111111111',
);

/// The Instructions sysvar contains the serialized instructions in a Message while that Message is
/// being processed. This allows program instructions to reference other instructions in the same
/// transaction.
final Pubkey sysvarInstructionsPubkey = Pubkey.fromBase58(
  'Sysvar1nstructions1111111111111111111111111',
);

/// The RecentBlockhashes sysvar contains the active recent blockhashes as well as their associated
/// fee calculators. It is updated every slot. Entries are ordered by descending block height, so
/// the first entry holds the most recent block hash, and the last entry holds an old block hash.
final Pubkey sysvarRecentBlockhashesPubkey = Pubkey.fromBase58(
  'SysvarRecentB1ockHashes11111111111111111111',
);

/// The Rent sysvar contains the rental rate. Currently, the rate is static and set in genesis. The
/// Rent burn percentage is modified by manual feature activation.
final Pubkey sysvarRentPubkey = Pubkey.fromBase58(
  'SysvarRent111111111111111111111111111111111',
);

final Pubkey sysvarRewardsPubkey = Pubkey.fromBase58(
  'SysvarRewards111111111111111111111111111111',
);

/// The SlotHashes sysvar contains the most recent hashes of the slot's parent banks. It is updated
/// every slot.
final Pubkey sysvarSlotHashesPubkey = Pubkey.fromBase58(
  'SysvarS1otHashes111111111111111111111111111',
);

/// The SlotHistory sysvar contains a bitvector of slots present over the last epoch. It is updated
/// every slot.
final Pubkey sysvarSlotHistoryPubkey = Pubkey.fromBase58(
  'SysvarS1otHistory11111111111111111111111111',
);

/// The StakeHistory sysvar contains the history of cluster-wide stake activations and
/// de-activations per epoch. It is updated at the start of every epoch.
final Pubkey sysvarStakeHistoryPubkey = Pubkey.fromBase58(
  'SysvarStakeHistory1111111111111111111111111',
);
