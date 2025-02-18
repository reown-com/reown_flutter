/// Token Instruction
/// ------------------------------------------------------------------------------------------------
library;

enum TokenInstruction {
  initializeMint,
  initializeAccount,
  initializeMultisig,
  transfer,
  approve,
  revoke,
  setAuthority,
  mintTo,
  burn,
  closeAccount,
  freezeAccount,
  thawAccount,
  transferChecked,
  approveChecked,
  mintToChecked,
  burnChecked,
  initializeAccount2,
  syncNative,
  initializeAccount3,
  initializeMultisig2,
  initializeMint2,
  getAccountDataSize,
  initializeImmutableOwner,
  amountToUiAmount,
  uiAmountToAmount,
}
