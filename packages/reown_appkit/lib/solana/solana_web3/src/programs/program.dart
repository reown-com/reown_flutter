/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_buffer/buffer.dart';
import '../crypto/pubkey.dart';
import '../exceptions/program_exception.dart';
import '../rpc/connection.dart';
import '../rpc/models/account_info.dart';
import '../transactions/account_meta.dart';
import '../transactions/transaction_instruction.dart';

/// Program
/// ------------------------------------------------------------------------------------------------

abstract class Program {
  /// Solana program.
  const Program(this.pubkey);

  /// The public key that identifies this program (i.e. program id).
  final Pubkey pubkey;

  // /// {@template solana_web3.Program.findAddress}
  // /// Finds a valid program address for the given [seeds].
  // ///
  // /// `Valid program addresses must fall off the ed25519 curve.` This function iterates a nonce
  // /// until it finds one that can be combined with the seeds to produce a valid program address.
  // ///
  // /// Throws an [AssertionError] if [seeds] contains an invalid seed.
  // ///
  // /// Throws a [PubkeyException] if a valid program address could not be found.
  // /// {@endtemplate}
  // ProgramAddress findAddress(final List<List<int>> seeds)
  //   => Pubkey.findProgramAddress(seeds, pubkey);

  /// {@template solana_web3.Program.checkDeployed}
  /// Check that the program has been deployed to the cluster and is an executable program.
  ///
  /// Throws a [ProgramException] if [pubkey] does not refer to a valid program.
  /// {@endtemplate}
  Future<void> checkDeployed(final Connection connection) async {
    final AccountInfo? programInfo = await connection.getAccountInfo(pubkey);
    if (programInfo == null) {
      throw ProgramException(
          'The program $runtimeType ($pubkey) has not been deployed.');
    } else if (!programInfo.executable) {
      throw ProgramException(
          'The program $runtimeType ($pubkey) is not executable.');
    }
  }

  /// Encodes the program [instruction].
  Iterable<int> encodeInstruction<T extends Enum>(final T instruction) =>
      Buffer.fromUint8(instruction.index);

  /// Creates a [TransactionInstruction] for the program [instruction].
  TransactionInstruction createTransactionIntruction(
    final Enum instruction, {
    required final List<AccountMeta> keys,
    final List<Iterable<int>> data = const [],
  }) {
    return TransactionInstruction(
      keys: keys,
      programId: pubkey,
      data: Buffer.flatten([encodeInstruction(instruction), ...data])
          .asUint8List(),
    );
  }
}
