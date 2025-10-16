/// Request Units Params
/// ------------------------------------------------------------------------------------------------
library;

class RequestUnitsParams {
  /// Request units instruction params.
  const RequestUnitsParams({required this.units, required this.additionalFee});

  /// Units to request for transaction-wide compute.
  final int units;

  /// Prioritization fee lamports.
  final int additionalFee;
}

/// Request Heap Frame Params
/// ------------------------------------------------------------------------------------------------

class RequestHeapFrameParams {
  /// Request heap frame instruction params.
  const RequestHeapFrameParams(this.bytes);

  /// Requested transaction-wide program heap size in bytes. Must be multiple of 1024. Applies to
  /// each program, including CPIs.
  final int bytes;
}

/// Set Compute Unit Limit Params
/// ------------------------------------------------------------------------------------------------

class SetComputeUnitLimitParams {
  /// Set compute unit limit instruction params.
  const SetComputeUnitLimitParams(this.units);

  /// Transaction-wide compute unit limit.
  final int units;
}

/// Set Compute Unit Price Params
/// ------------------------------------------------------------------------------------------------

class SetComputeUnitPriceParams {
  // Set compute unit price instruction params.
  const SetComputeUnitPriceParams(this.microLamports);

  /// Transaction compute unit price used for prioritization fees.
  final BigInt microLamports;
}

/// Set Accounts Data Size Limit Params
/// ------------------------------------------------------------------------------------------------

class SetAccountsDataSizeLimitParams {
  // Set a specific transaction-wide account data size limit in bytes.
  const SetAccountsDataSizeLimitParams(this.limit);

  /// Maximum allocation size in bytes.
  final BigInt limit;
}
