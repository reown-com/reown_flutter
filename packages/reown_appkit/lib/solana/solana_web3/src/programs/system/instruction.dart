/// System Instruction
/// ------------------------------------------------------------------------------------------------
library;

enum SystemInstruction {
  create, // 0
  assign, // 1
  transfer, // 2
  createWithSeed, // 3
  advanceNonceAccount, // 4
  withdrawNonceAccount, // 5
  initializeNonceAccount, // 6
  authorizeNonceAccount, // 7
  allocate, // 8
  allocateWithSeed, // 9
  assignWithSeed, // 10
  transferWithSeed, // 11
  upgradeNonceAccount, // 12
}
