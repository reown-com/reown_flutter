/// Transaction Errors
/// ------------------------------------------------------------------------------------------------
library;

/// Source: https://github.com/solana-labs/solana/blob/c0c60386544ec9a9ec7119229f37386d9f070523/sdk/src/transaction/error.rs#L13

enum TransactionError {
  /// An account is already being processed in another transaction in a way that does not support
  /// parallelism.
  ///
  /// ignore: constant_identifier_names
  AccountInUse,

  /// A `Pubkey` appears twice in the transaction's `account_keys`.  Instructions can reference
  /// `Pubkey`s more than once but the message must contain a list with no duplicate keys.
  ///
  /// ignore: constant_identifier_names
  AccountLoadedTwice,

  /// Attempt to debit an account but found no record of a prior credit.
  ///
  /// ignore: constant_identifier_names
  AccountNotFound,

  /// Attempt to load a program that does not exist.
  ///
  /// ignore: constant_identifier_names
  ProgramAccountNotFound,

  /// The from `Pubkey` does not have sufficient balance to pay the fee to schedule the transaction.
  ///
  /// ignore: constant_identifier_names
  InsufficientFundsForFee,

  /// This account may not be used to pay transaction fees.
  ///
  /// ignore: constant_identifier_names
  InvalidAccountForFee,

  /// The bank has seen this transaction before. This can occur under normal operation when a UDP
  /// packet is duplicated, as a user error from a client not updating its `recent_blockhash`, or as
  /// a double-spend attack.
  ///
  /// ignore: constant_identifier_names
  AlreadyProcessed,

  /// The bank has not seen the given `recent_blockhash` or the transaction is too old and the
  /// `recent_blockhash` has been discarded.
  ///
  /// ignore: constant_identifier_names
  BlockhashNotFound,

  /// An error occurred while processing an instruction. The first element of the tuple indicates
  /// the instruction index in which the error occurred.
  ///
  /// ignore: constant_identifier_names
  InstructionError,

  /// Loader call chain is too deep.
  ///
  /// ignore: constant_identifier_names
  CallChainTooDeep,

  /// Transaction requires a fee but has no signature present.
  ///
  /// ignore: constant_identifier_names
  MissingSignatureForFee,

  /// Transaction contains an invalid account reference.
  ///
  /// ignore: constant_identifier_names
  InvalidAccountIndex,

  /// Transaction did not pass signature verification.
  ///
  /// ignore: constant_identifier_names
  SignatureFailure,

  /// This program may not be used for executing instructions.
  ///
  /// ignore: constant_identifier_names
  InvalidProgramForExecution,

  /// Transaction failed to sanitise accounts offsets correctly implies that account locks are not
  /// taken for this TX, and should not be unlocked.
  ///
  /// ignore: constant_identifier_names
  SanitizeFailure,

  /// Transactions are currently disabled due to cluster maintenance.
  ///
  /// ignore: constant_identifier_names
  ClusterMaintenance,

  /// Transaction processing left an account with an outstanding borrowed reference.
  ///
  /// ignore: constant_identifier_names
  AccountBorrowOutstanding,

  /// Transaction would exceed max Block Cost Limit.
  ///
  /// ignore: constant_identifier_names
  WouldExceedMaxBlockCostLimit,

  /// Transaction version is unsupported.
  ///
  /// ignore: constant_identifier_names
  UnsupportedVersion,

  /// Transaction loads a writable account that cannot be written.
  ///
  /// ignore: constant_identifier_names
  InvalidWritableAccount,

  /// Transaction would exceed max account limit within the block.
  ///
  /// ignore: constant_identifier_names
  WouldExceedMaxAccountCostLimit,

  /// Transaction would exceed max account data limit within the block.
  ///
  /// ignore: constant_identifier_names
  WouldExceedMaxAccountDataCostLimit,
  ;

  /// Returns the enum variant where [EnumName.name] is equal to [name].
  ///
  /// Throws an [ArgumentError] if [name] cannot be matched to an existing variant.
  ///
  /// ```
  /// TransactionError.fromJson('AccountInUse');
  /// ```
  factory TransactionError.fromJson(final String name) => values.byName(name);

  /// Returns the enum variant where [EnumName.name] is equal to [name].
  ///
  /// Returns `null` if [name] cannot be matched to an existing variant.
  ///
  /// ```
  /// TransactionError.tryFromJson('AccountInUse');
  /// ```
  static TransactionError? tryFromJson(final String? name) =>
      name != null ? TransactionError.fromJson(name) : null;
}
