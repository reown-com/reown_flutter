/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'dart:convert';
import 'package:reown_appkit/solana/solana_common/types.dart';
import 'package:reown_appkit/solana/solana_common/validators.dart';
import '../../crypto/pubkey.dart';
import '../../transactions/account_meta.dart';
import '../../transactions/transaction_instruction.dart';
import '../program.dart';
import 'instruction.dart';

/// Memo Program
/// ------------------------------------------------------------------------------------------------

class MemoProgram extends Program {
  MemoProgram._()
      : super(Pubkey.fromBase58('MemoSq4gqABAXKb96qnH8TysNcWxMyWCqXgDLGmfcHr'));

  /// Internal singleton instance.
  static final MemoProgram _instance = MemoProgram._();

  /// The program id.
  static Pubkey get programId => _instance.pubkey;

  /// Maximum length.
  static const int maxLength = 566;

  /// Creates and returns an instruction which validates a string of UTF-8 encoded characters and
  /// verifies that any accounts provided are signers of the transaction.  The program also logs the
  /// memo, as well as any verified signer addresses, to the transaction log, so that anyone can
  /// easily observe memos and know they were approved by zero or more addresses by inspecting the
  /// transaction log from a trusted provider.
  ///
  /// Public keys passed in via the signerPubkeys will identify Signers which must subsequently sign
  /// the Transaction including the returned TransactionInstruction in order for the transaction to be
  /// valid.
  ///
  /// - [memo] - The UTF-8 encoded memo string to validate.
  /// - [signers] - An array of public keys which must sign the Transaction including the returned
  ///   TransactionInstruction in order for the transaction to be valid and the memo verification to
  ///   succeed. null is allowed if there are no signers for the memo verification.
  static TransactionInstruction create(
    final String memo, {
    final List<Pubkey> signers = const [],
  }) {
    final List<AccountMeta> keys = [
      for (final Pubkey signer in signers) AccountMeta.signer(signer),
    ];

    final Iterable<u8> encoded = utf8.encode(memo);

    // A 32-byte public key takes up 44-bytes in length when converted to base58, each 8-bytes are
    // represented as 11-bytes.
    check((encoded.length + keys.length * 44) <= maxLength);

    final List<Iterable<u8>> data = [
      encoded,
    ];

    return _instance.createTransactionIntruction(
      MemoInstruction.create,
      keys: keys,
      data: data,
    );
  }
}
