/// Stake Pool Instruction
/// ------------------------------------------------------------------------------------------------
library;

enum StakePoolInstruction {
  initialize,
  addValidatorToPool,
  removeValidatorFromPool,
  decreaseValidatorStake,
  increaseValidatorStake,
  setPreferredValidator,
  updateValidatorListBalance,
  updateStakePoolBalance,
  cleanupRemovedValidatorEntries,
  depositStake,
  withdrawStake,
  setManager,
  setFee,
  setStaker,
  depositSol,
  setFundingAuthority,
  withdrawSol,
  createTokenMetadata,
  updateTokenMetadata,
  increaseAdditionalValidatorStake,
  decreaseAdditionalValidatorStake,
  redelegate,
}
