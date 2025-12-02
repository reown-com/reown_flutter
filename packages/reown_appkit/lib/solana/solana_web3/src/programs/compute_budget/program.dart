/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_borsh/borsh.dart';
import 'package:reown_appkit/solana/solana_common/types.dart';
import '../../crypto/pubkey.dart';
import '../../transactions/transaction_instruction.dart';
import '../program.dart';
import 'instruction.dart';

/// Compute Budget Program
/// ------------------------------------------------------------------------------------------------

class ComputeBudgetProgram extends Program {
  ComputeBudgetProgram._()
    : super(Pubkey.fromBase58('ComputeBudget111111111111111111111111111111'));

  /// Internal singleton instance.
  static final ComputeBudgetProgram _instance = ComputeBudgetProgram._();

  /// The program id.
  static Pubkey get programId => _instance.pubkey;

  /// Request units.
  ///
  /// - [units] - Units to request for transaction-wide compute.
  /// - [additionalFee] - Prioritization fee lamports.
  @Deprecated(
    'Instead, call [setComputeUnitLimit] and/or [setComputeUnitPrice].',
  )
  TransactionInstruction requestUnitsDeprecated({
    required final int units,
    required final int additionalFee,
  }) {
    final List<Iterable<u8>> data = [
      borsh.u32.encode(units),
      borsh.u32.encode(additionalFee),
    ];

    return _instance.createTransactionIntruction(
      ComputeBudgetInstruction.requestUnitsDeprecated,
      keys: const [],
      data: data,
    );
  }

  /// Request a specific transaction-wide program heap region size in bytes. The value requested
  /// must be a multiple of 1024. This new heap region size applies to each program executed in the
  /// transaction, including all calls to CPIs.
  ///
  /// - [bytes] - Requested transaction-wide program heap size in bytes. Must be multiple of 1024.
  /// Applies to each program, including CPIs.
  TransactionInstruction requestHeapFrame({required final u32 bytes}) {
    assert(
      (bytes % 1024) == 0,
      'Heap size [bytes] must be a multiple of 1024.',
    );
    final List<Iterable<u8>> data = [borsh.u32.encode(bytes)];

    return _instance.createTransactionIntruction(
      ComputeBudgetInstruction.requestHeapFrame,
      keys: const [],
      data: data,
    );
  }

  /// Set a specific compute unit limit that the transaction is allowed to consume.
  ///
  /// - [units] - Transaction-wide compute unit limit.
  TransactionInstruction setComputeUnitLimit({required final u32 units}) {
    final List<Iterable<u8>> data = [borsh.u32.encode(units)];

    return _instance.createTransactionIntruction(
      ComputeBudgetInstruction.setComputeUnitLimit,
      keys: const [],
      data: data,
    );
  }

  /// Set a compute unit price in [microLamports] to pay a higher transaction fee for higher
  /// transaction prioritization.
  ///
  /// - [microLamports] - Transaction compute unit price used for prioritization fees.
  TransactionInstruction setComputeUnitPrice({
    required final bu64 microLamports,
  }) {
    final List<Iterable<u8>> data = [borsh.u64.encode(microLamports)];

    return _instance.createTransactionIntruction(
      ComputeBudgetInstruction.setComputeUnitPrice,
      keys: const [],
      data: data,
    );
  }

  /// Set a specific transaction-wide account data size limit in bytes.
  ///
  /// - [limit] - Maximum allocation size in bytes.
  TransactionInstruction setAccountsDataSizeLimit({required final u32 limit}) {
    final List<Iterable<u8>> data = [borsh.u32.encode(limit)];

    return _instance.createTransactionIntruction(
      ComputeBudgetInstruction.setAccountsDataSizeLimit,
      keys: const [],
      data: data,
    );
  }
}
