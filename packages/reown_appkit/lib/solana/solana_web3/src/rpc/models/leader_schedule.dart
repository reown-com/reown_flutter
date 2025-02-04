/// Leader Schedule
/// ------------------------------------------------------------------------------------------------
library;

// DO NOT change to List<int> without updating rpc/methods/GetLeaderSchedule.dart.
// The current (lazy) type cast will fail for List<int>.
//
/// Validator identities, as base-58 encoded strings, and their corresponding leader slot indices
/// as values (indices are relative to the first slot in the requested epoch).
typedef LeaderSchedule = Map<String, List>;
