/// TODO: These constants should be removed in favor of reading them out of a Syscall account.
library;

/// The number of `tick` ledger entries per `second`.
///
/// A `tick` is a ledger entry that estimates wallclock duration.
const int numberOfTicksPerSecond = 160;

/// The default number of `ticks` per `slot`.
///
/// A `tick` is a ledger entry that estimates wallclock duration.
///
/// A `slot` is the period of time for which each leader ingests transactions and produces a block.
const int defaultTicksPerSlot = 64;

/// The number of `slots` per second.
///
/// A `slot` is the period of time for which each leader ingests transactions and produces a block.
const double numberOfSlotsPerSecond =
    numberOfTicksPerSecond / defaultTicksPerSlot;

/// The duration of a `slot` in milliseconds.
///
/// A `slot` is the period of time for which each leader ingests transactions and produces a block.
const double millisecondsPerSlot = 1000 / numberOfSlotsPerSecond;
