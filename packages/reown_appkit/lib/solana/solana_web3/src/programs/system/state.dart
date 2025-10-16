/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/types.dart';
import '../../crypto/pubkey.dart';

/// Create Account Params
/// ------------------------------------------------------------------------------------------------

class CreateAccountParams {
  /// Creates account system transaction params.
  const CreateAccountParams({
    required this.fromPubkey,
    required this.newAccountPubkey,
    required this.lamports,
    required this.space,
    required this.programId,
  });

  /// The account that will transfer lamports to the created account.
  final Pubkey fromPubkey;

  /// The public key of the created account.
  final Pubkey newAccountPubkey;

  /// The amount of lamports to transfer to the created account.
  final u64 lamports;

  /// The amount of space in bytes to allocate to the created account.
  final u64 space;

  /// The public key of the program to assign as the owner of the created account.
  final Pubkey programId;
}

/// Transfer Params
/// ------------------------------------------------------------------------------------------------

class TransferParams {
  /// Transfer system transaction params.
  const TransferParams({
    required this.fromPubkey,
    required this.toPubkey,
    required this.lamports,
  });

  /// The account that will transfer lamports.
  final Pubkey fromPubkey;

  /// The account that will receive transferred lamports.
  final Pubkey toPubkey;

  /// The amount of lamports to transfer.
  final u64 lamports;
}

/// Assign Params
/// ------------------------------------------------------------------------------------------------

class AssignParams {
  /// Assign system transaction params.
  const AssignParams({required this.accountPubkey, required this.programId});

  /// The public key of the account which will be assigned a new owner.
  final Pubkey accountPubkey;

  /// The public key of the program to assign as the owner.
  final Pubkey programId;
}

/// Create Account With Seed Params
/// ------------------------------------------------------------------------------------------------

class CreateAccountWithSeedParams {
  /// Create account with [seed] system transaction params.
  const CreateAccountWithSeedParams({
    required this.fromPubkey,
    required this.newAccountPubkey,
    required this.basePubkey,
    required this.seed,
    required this.lamports,
    required this.space,
    required this.programId,
  });

  /// The account that will transfer lamports to the created account.
  final Pubkey fromPubkey;

  /// The public key of the created account. Must be pre-calculated with Pubkey.createWithSeed().
  final Pubkey newAccountPubkey;

  /// The base public key used to derive the address of the created account. Must be the same as the
  /// base key used to create `newAccountPubkey`.
  final Pubkey basePubkey;

  /// The seed used to derive the address of the created account. Must be the same as the seed used
  /// to create `newAccountPubkey`.
  final String seed;

  /// The amount of lamports to transfer to the created account.
  final u64 lamports;

  /// The amount of space in bytes to allocate to the created account.
  final u64 space;

  /// The public key of the program to assign as the owner of the created account.
  final Pubkey programId;
}

/// Create Nonce Account Params
/// ------------------------------------------------------------------------------------------------

class CreateNonceAccountParams {
  /// Create nonce account system transaction params.
  const CreateNonceAccountParams({
    required this.fromPubkey,
    required this.noncePubkey,
    required this.authorizedPubkey,
    required this.lamports,
  });

  /// The account that will transfer lamports to the created nonce account.
  final Pubkey fromPubkey;

  /// The public key of the created nonce account.
  final Pubkey noncePubkey;

  /// Thje public key to set as authority of the created nonce account.
  final Pubkey authorizedPubkey;

  /// The amount of lamports to transfer to the created nonce account.
  final u64 lamports;
}

/// Create Nonce Account With Seed Params
/// ------------------------------------------------------------------------------------------------

class CreateNonceAccountWithSeedParams {
  /// Create nonce account with seed system transaction params.
  const CreateNonceAccountWithSeedParams({
    required this.fromPubkey,
    required this.noncePubkey,
    required this.authorizedPubkey,
    required this.lamports,
    required this.basePubkey,
    required this.seed,
  });

  /// The account that will transfer lamports to the created nonce account.
  final Pubkey fromPubkey;

  /// The public key of the created nonce account.
  final Pubkey noncePubkey;

  /// The public key to set as the authority of the created nonce account.
  final Pubkey authorizedPubkey;

  /// The amount of lamports to transfer to the created nonce account.
  final u64 lamports;

  /// The base public key used to derive the address of the nonce account.
  final Pubkey basePubkey;

  /// The seed used to derive the address of the nonce account.
  final String seed;
}

/// Initialize Nonce Params
/// ------------------------------------------------------------------------------------------------

class InitializeNonceParams {
  /// Initialize nonce account system instruction params.
  const InitializeNonceParams({
    required this.noncePubkey,
    required this.authorizedPubkey,
  });

  /// The nonce account to be initialized.
  final Pubkey noncePubkey;

  /// The public key to set as the authority of the initialized nonce account.
  final Pubkey authorizedPubkey;
}

/// Advance Nonce Params
/// ------------------------------------------------------------------------------------------------

class AdvanceNonceParams {
  /// Advance nonce account system instruction params.
  const AdvanceNonceParams({
    required this.noncePubkey,
    required this.authorizedPubkey,
  });

  /// The nonce account.
  final Pubkey noncePubkey;

  /// The public key of the nonce authority.
  final Pubkey authorizedPubkey;
}

/// Withdraw Nonce Params
/// ------------------------------------------------------------------------------------------------

class WithdrawNonceParams {
  /// Withdraw nonce account system transaction params.
  const WithdrawNonceParams({
    required this.noncePubkey,
    required this.authorizedPubkey,
    required this.toPubkey,
    required this.lamports,
  });

  /// The nonce account.
  final Pubkey noncePubkey;

  /// The public key of the nonce authority.
  final Pubkey authorizedPubkey;

  /// The public key of the account which will receive the withdrawn nonce account balance.
  final Pubkey toPubkey;

  /// The mount of lamports to withdraw from the nonce account.
  final u64 lamports;
}

/// Authorize Nonce Params
/// ------------------------------------------------------------------------------------------------

class AuthorizeNonceParams {
  /// Authorise nonce account system transaction params.
  const AuthorizeNonceParams({
    required this.noncePubkey,
    required this.authorizedPubkey,
    required this.newAuthorizedPubkey,
  });

  /// The nonce account.
  final Pubkey noncePubkey;

  /// The public key of the current nonce authority.
  final Pubkey authorizedPubkey;

  /// The public key to set as the new nonce authority.
  final Pubkey newAuthorizedPubkey;
}

/// Allocate Params
/// ------------------------------------------------------------------------------------------------

class AllocateParams {
  /// Allocate account system transaction params.
  const AllocateParams({required this.accountPubkey, required this.space});

  /// The account to allocate.
  final Pubkey accountPubkey;

  /// The amount of space in bytes to allocate.
  final u64 space;
}

/// Allocate With Seed Params
/// ------------------------------------------------------------------------------------------------

class AllocateWithSeedParams {
  /// Allocate account with seed system transaction params.
  const AllocateWithSeedParams({
    required this.accountPubkey,
    required this.basePubkey,
    required this.seed,
    required this.space,
    required this.programId,
  });

  /// The account to allocate.
  final Pubkey accountPubkey;

  /// The base public key used to derive the address of the allocated account.
  final Pubkey basePubkey;

  /// The seed used to derive the address of the allocated account.
  final String seed;

  /// The amount of space in bytes to allocate.
  final u64 space;

  /// The public key of the program to assign as the owner of the allocated account.
  final Pubkey programId;
}

/// Assign With Seed Params
/// ------------------------------------------------------------------------------------------------

class AssignWithSeedParams {
  /// Assign account with seed system transaction params.
  const AssignWithSeedParams({
    required this.accountPubkey,
    required this.basePubkey,
    required this.seed,
    required this.programId,
  });

  /// The public key of the account which will be assigned a new owner.
  final Pubkey accountPubkey;

  /// The base public key used to derive the address of the assigned account.
  final Pubkey basePubkey;

  /// The seed used to derive the address of the assigned account.
  final String seed;

  /// The public key of the program to assign as the owner.
  final Pubkey programId;
}

/// Transfer With Seed Params
/// ------------------------------------------------------------------------------------------------

class TransferWithSeedParams {
  /// Transfer with seed system transaction params.
  const TransferWithSeedParams({
    required this.fromPubkey,
    required this.basePubkey,
    required this.toPubkey,
    required this.lamports,
    required this.seed,
    required this.programId,
  });

  /// The account that will transfer lamports.
  final Pubkey fromPubkey;

  /// The base public key used to derive the funding account address.
  final Pubkey basePubkey;

  /// The account that will receive the transferred lamports.
  final Pubkey toPubkey;

  /// The amount of lamports to transfer.
  final u64 lamports;

  /// The seed used to derive the funding account address.
  final String seed;

  /// The program id used to derive the funding account address.
  final Pubkey programId;
}

/// Decoded Transfer Instruction
/// ------------------------------------------------------------------------------------------------

class DecodedTransferInstruction {
  /// Decoded transfer system transaction instruction.
  const DecodedTransferInstruction({
    required this.fromPubkey,
    required this.toPubkey,
    required this.lamports,
  });

  /// The account that will transfer lamports.
  final Pubkey fromPubkey;

  /// The account that will receive the transferred lamports.
  final Pubkey toPubkey;

  /// The amount of lamports to transfer.
  final u64 lamports;
}

/// Decoded Transfer With Seed Instruction
/// ------------------------------------------------------------------------------------------------

class DecodedTransferWithSeedInstruction {
  /// Decoded transferWithSeed system transaction instruction.
  const DecodedTransferWithSeedInstruction({
    required this.fromPubkey,
    required this.basePubkey,
    required this.toPubkey,
    required this.lamports,
    required this.seed,
    required this.programId,
  });

  /// The account that will transfer lamports.
  final Pubkey fromPubkey;

  /// The base public key used to derive the funding account address.
  final Pubkey basePubkey;

  /// The account that will receive transferred lamports.
  final Pubkey toPubkey;

  /// The amount of lamports to transfer.
  final u64 lamports;

  /// The seed used to derive the funding account address.
  final String seed;

  /// The program id used to derive the funding account address.
  final Pubkey programId;
}
