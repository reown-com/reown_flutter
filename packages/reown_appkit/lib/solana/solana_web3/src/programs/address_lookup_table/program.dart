/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_borsh/borsh.dart';
import 'package:reown_appkit/solana/solana_borsh/codecs.dart';
import 'package:reown_appkit/solana/solana_buffer/buffer.dart';
import 'package:reown_appkit/solana/solana_buffer/extensions.dart';
import '../../crypto/pubkey.dart';
import '../../rpc/models/program_address.dart';
import '../../transactions/account_meta.dart';
import '../../transactions/transaction_instruction.dart';
import '../program.dart';
import '../system/program.dart';
import 'instruction.dart';

/// Address Lookup Table Program
/// ------------------------------------------------------------------------------------------------

/// Address Lookup Table Program
class AddressLookupTableProgram extends Program {
  /// Address Lookup Table Program.
  AddressLookupTableProgram._()
      : super(Pubkey.fromBase58('AddressLookupTab1e1111111111111111111111111'));

  /// Internal singleton instance.
  static final AddressLookupTableProgram _instance =
      AddressLookupTableProgram._();

  /// The program id.
  static Pubkey get programId => _instance.pubkey;

  /// Derives a lookup table address from the [authority] and [recentSlot].
  static ProgramAddress findAddressLookupTable(
    final Pubkey authority,
    final BigInt recentSlot,
  ) =>
      Pubkey.findProgramAddress(
        [
          authority.toBytes(),
          recentSlot.toUint64Buffer(),
        ],
        programId,
      );

  @override
  Iterable<int> encodeInstruction<T extends Enum>(
    final T instruction,
  ) =>
      Buffer.fromUint32(instruction.index);

  ///
  static TransactionInstruction create({
    // Keys
    required final ProgramAddress address,
    required final Pubkey authority,
    required final Pubkey payer,
    // Data
    required final BigInt recentSlot,
  }) {
    assert(
        findAddressLookupTable(authority, recentSlot).pubkey == address.pubkey);

    final List<AccountMeta> keys = [
      AccountMeta.writable(address.pubkey),
      AccountMeta.signer(authority),
      AccountMeta.signerAndWritable(payer),
      AccountMeta(SystemProgram.programId),
    ];

    final List<Iterable<int>> data = [
      recentSlot.toUint64Buffer(),
      [address.bump],
    ];

    return _instance.createTransactionIntruction(
      AddressLookupTableInstruction.createLookupTable,
      keys: keys,
      data: data,
    );
  }

  ///
  static TransactionInstruction freeze({
    // Keys
    required final Pubkey address,
    required final Pubkey authority,
  }) {
    final List<AccountMeta> keys = [
      AccountMeta.writable(address),
      AccountMeta.signer(authority),
    ];

    return _instance.createTransactionIntruction(
      AddressLookupTableInstruction.freezeLookupTable,
      keys: keys,
    );
  }

  ///
  static TransactionInstruction extend({
    // Keys
    required final Pubkey address,
    required final Pubkey authority,
    required final Pubkey payer,
    // Data
    required final List<Pubkey> addresses,
  }) {
    final List<AccountMeta> keys = [
      AccountMeta.writable(address),
      AccountMeta.signer(authority),
      AccountMeta.signerAndWritable(payer),
      AccountMeta(SystemProgram.programId),
    ];

    final BorshStringSizedCodec pubkeyCodec = borsh.pubkey;
    final List<Iterable<int>> data = [
      borsh.u64.encode(BigInt.from(addresses.length)),
      for (final Pubkey address in addresses)
        pubkeyCodec.encode(address.toBase58())
    ];

    return _instance.createTransactionIntruction(
      AddressLookupTableInstruction.extendLookupTable,
      keys: keys,
      data: data,
    );
  }

  ///
  static TransactionInstruction deactivate({
    // Keys
    required final Pubkey address,
    required final Pubkey authority,
  }) {
    final List<AccountMeta> keys = [
      AccountMeta.writable(address),
      AccountMeta.signer(authority),
    ];

    return _instance.createTransactionIntruction(
      AddressLookupTableInstruction.deactivateLookupTable,
      keys: keys,
    );
  }

  ///
  static TransactionInstruction close({
    // Keys
    required final Pubkey address,
    required final Pubkey authority,
    required final Pubkey recipient,
  }) {
    final List<AccountMeta> keys = [
      AccountMeta.writable(address),
      AccountMeta.signer(authority),
      AccountMeta.writable(recipient),
    ];

    return _instance.createTransactionIntruction(
      AddressLookupTableInstruction.closeLookupTable,
      keys: keys,
    );
  }
}
