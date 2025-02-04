// /// Imports
// /// ------------------------------------------------------------------------------------------------

// import 'dart:convert';
// import 'package:reown_appkit/solana/solana_buffer/buffer.dart';
// import 'package:reown_appkit/solana/solana_common/extensions.dart';
// import 'package:reown_appkit/solana/solana_jsonrpc/jsonrpc.dart';
// import '../codecs/account_encoding.dart';
// import '../constants/sysvar.dart';
// import '../keypair.dart';
// import '../pubkey.dart';
// import '../rpc/connection.dart';
// import '../rpc/models/account_info.dart';
// import '../transactions/account_meta.dart';
// import '../transactions/constants.dart';
// import '../transactions/transaction.dart';
// import '../transactions/transaction_instruction.dart';
// import 'system/program.dart';

// /// Loader
// /// ------------------------------------------------------------------------------------------------

// class Loader {

//   /// Program loader interface.
//   const Loader._();

//   /// Keep program chunks under `packetDataSize`, leaving enough room for the rest of the
//   /// Transaction fields.
//   ///
//   /// TODO: replace 300 with a proper constant for the size of the other Transaction fields.
//   ///
//   /// The amount of program data placed in each load Transaction.
//   static const int chunkSize = packetDataSize - 300;

//   /// Returns the minimum number of signatures required to load a program, not including retries.
//   ///
//   /// This can be used to calculate transaction fees.
//   static int getMinNumSignatures(final int dataLength) {
//     return (
//       2 *     // Every transaction requires two signatures (payer + program)
//       ((dataLength / Loader.chunkSize).ceil()
//         + 1   // Add one for Create transaction
//         + 1)  // Add one for Finalise transaction
//     );
//   }

//   /// Loads a generic program.
//   ///
//   /// Returns `true` if the [program] was loaded successfully and `false` if the program was already
//   /// loaded.
//   ///
//   /// [connection]      The connection to use.
//   /// [payer]           the `account` that will pay program loading fees.
//   /// [program]         The `account` to load the program into.
//   /// [programId]       The public key that identifies the loader.
//   /// [data]            The program octets.
//   static Future<bool> load(
//     Connection connection,
//     Signer payer,
//     Signer program,
//     Pubkey programId,
//     Buffer data,
//   ) async {
//     {
//       final u64 balanceNeeded = await connection.getMinimumBalanceForRentExemption(
//         data.length,
//       );

//       // Fetch program account info to check if it has already been created.
//       final AccountInfo? programInfo = await connection.getAccountInfo(
//         program.pubkey,
//         config: GetAccountInfoConfig(
//           commitment: Commitment.confirmed,
//           encoding: AccountEncoding.base64,
//         ),
//       );

//       final Transaction transaction = Transaction();

//       if (programInfo != null) {
//         if (programInfo.executable) {
//           print('Program load() failed, the account is already executable.');
//           return false;
//         }

//         final int dataLength = base64.decode(programInfo.binaryData).length;
//         if (dataLength != data.length) {
//           transaction.add(
//             SystemProgram.allocate(
//               accountPubkey: program.pubkey,
//               space: data.length.toBigInt(),
//             ),
//           );
//         }

//         if (programInfo.owner != programId.toBase58()) {
//           transaction.add(
//             SystemProgram.assign(
//               accountPubkey: program.pubkey,
//               programId: programId,
//             ),
//           );
//         }

//         if (programInfo.lamports < balanceNeeded) {
//           transaction.add(
//             SystemProgram.transfer(
//               fromPubkey: payer.pubkey,
//               toPubkey: program.pubkey,
//               lamports: (balanceNeeded - programInfo.lamports).toBigInt(),
//             ),
//           );
//         }
//       } else {
//         transaction.add(
//           SystemProgram.createAccount(
//             fromPubkey: payer.pubkey,
//             newAccountPubkey: program.pubkey,
//             lamports: balanceNeeded > 0 ? balanceNeeded.toBigInt() : BigInt.one,
//             space: data.length.toBigInt(),
//             programId: programId,
//           ),
//         );
//       }

//       // If the account is already created correctly, skip this step and proceed directly to loading
//       // instructions
//       if (transaction.instructions.isNotEmpty) {
//         await connection.sendAndConfirmTransaction(
//           transaction,
//           signers: [payer, program],
//           config: SendAndConfirmTransactionConfig(commitment: Commitment.confirmed),
//         );
//       }
//     }

//     int offset = 0;
//     Buffer buffer = data.slice(0);
//     List<Future<String>> transactions = [];
//     while (buffer.isNotEmpty) {
//       final bytes = buffer.slice(0, chunkSize);
//       final data = BufferWriter(chunkSize + 16);
//       data.setUint32(0);      // Load instruction
//       data.setUint32(offset); // offset
//       data.setUint32(0);      // bytesLength
//       data.setUint32(0);      // bytesLengthPadding
//       data.setBuffer(bytes);  // bytes

//       final Transaction transaction = Transaction()..add(
//         TransactionInstruction(
//           keys: [AccountMeta(program.pubkey, isSigner: true, isWritable: true)],
//           programId: programId,
//           data: data.buffer.asUint8List(),
//         ),
//       );

//       transactions.add(
//         connection.sendAndConfirmTransaction(
//           transaction,
//           signers: [payer, program],
//           config: SendAndConfirmTransactionConfig(commitment: Commitment.confirmed),
//         ),
//       );

//       // Delay between sends in an attempt to reduce rate limit errors
//       if (connection.httpCluster.uri.host.contains('solana.com')) {
//         const int requestsPerSecond = 4;
//         await Future.delayed(const Duration(seconds: requestsPerSecond));
//       }

//       offset += chunkSize;
//       buffer = buffer.slice(chunkSize);
//     }

//     await Future.wait(transactions);

//     // Finalise the account loaded with program data for execution
//     {
//       final Buffer data = Buffer.fromUint32(1); // Finalise instruction
//       final Transaction transaction = Transaction()..add(
//         TransactionInstruction(
//           keys: [
//             AccountMeta(program.pubkey, isSigner: true, isWritable: true),
//             AccountMeta(sysvarRentPubkey, isSigner: false, isWritable: false),
//         ],
//         programId: programId,
//         data: data.asUint8List(),
//         )
//       );

//       await connection.sendAndConfirmTransaction(
//         transaction,
//         signers: [payer, program],
//         config: SendAndConfirmTransactionConfig(commitment: Commitment.confirmed),
//       );
//     }

//     // success
//     return true;
//   }
// }
