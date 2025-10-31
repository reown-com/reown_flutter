import 'dart:convert';

import 'package:reown_appkit/reown_appkit.dart';
import 'package:reown_appkit/solana/solana_web3/solana_web3.dart' as solana;
import 'package:reown_appkit/solana/solana_web3/programs.dart' as programs;

enum SolanaMethods {
  solanaSignMessage,
  solanaSignTransaction,
  solanaSignAndSendTransaction,
  solanaSignAllTransactions,
}

enum SolanaEvents { none }

class Solana {
  static final Map<SolanaMethods, String> methods = {
    SolanaMethods.solanaSignMessage: 'solana_signMessage',
    SolanaMethods.solanaSignTransaction: 'solana_signTransaction',
    SolanaMethods.solanaSignAndSendTransaction: 'solana_signAndSendTransaction',
    SolanaMethods.solanaSignAllTransactions: 'solana_signAllTransactions',
  };

  static final List<String> events = [];

  static String personalSignMessage() {
    final bytes = utf8.encode('Welcome to Flutter AppKit on Solana');
    return base58.encode(bytes);
  }

  static Future<solana.Transaction> constructSolanaTX(
    String address,
    ReownAppKitModalNetworkInfo chainData,
  ) async {
    // Create a connection to the devnet cluster.
    final cluster = solana.Cluster.https(Uri.parse(chainData.rpcUrl).authority);
    // final cluster = solana.Cluster.devnet;
    final connection = solana.Connection(cluster);

    // Fetch the latest blockhash.
    final blockhash = await connection.getLatestBlockhash();

    // Create a System Program instruction to transfer 0.5 SOL from [address1] to [address2].
    final transactionv0 = solana.Transaction.v0(
      payer: solana.Pubkey.fromBase58(address),
      recentBlockhash: blockhash.blockhash,
      instructions: [
        solana.TransactionInstruction.fromJson({
          'programId': '11111111111111111111111111111111',
          'data': [2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0],
          'keys': [
            {'isSigner': true, 'isWritable': true, 'pubkey': address},
            {
              'isSigner': false,
              'isWritable': true,
              'pubkey': address, // should be recipient address
            },
          ],
        }),
      ],
    );

    return transactionv0;
  }

  static Future<solana.Transaction> constructSolanaTX2(
    String address,
    ReownAppKitModalNetworkInfo chainData,
  ) async {
    // Create a connection to the devnet cluster.
    final cluster = solana.Cluster.https(Uri.parse(chainData.rpcUrl).authority);
    // final cluster = solana.Cluster.devnet;
    final connection = solana.Connection(cluster);

    // Fetch the latest blockhash.
    final blockhash = await connection.getLatestBlockhash();

    // Define transfer amount in lamports (1 SOL = 1,000,000,000 lamports)
    // Amount to send in lamports (0.01 SOL)
    final lamports = BigInt.from(10000000);

    // Create the transfer instruction
    final transferInstruction = programs.SystemProgram.transfer(
      fromPubkey: solana.Pubkey.fromBase58(address),
      toPubkey: solana.Pubkey.fromBase58(address),
      lamports: lamports,
    );

    final transactionv0 = solana.Transaction.v0(
      payer: solana.Pubkey.fromBase58(address),
      recentBlockhash: blockhash.blockhash,
      instructions: [transferInstruction],
    );

    return transactionv0;
  }

  static String serializeTransaction(solana.Transaction transaction) {
    const config = solana.TransactionSerializableConfig(
      verifySignatures: false,
    );
    final bytes = transaction.serialize(config).asUint8List();
    return base64.encode(bytes);
  }
}
