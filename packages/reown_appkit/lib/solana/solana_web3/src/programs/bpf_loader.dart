// /// Imports
// /// ------------------------------------------------------------------------------------------------

// import 'package:reown_appkit/solana/solana_buffer/buffer.dart';
// import '../keypair.dart';
// import '../pubkey.dart';
// import '../rpc/connection.dart';
// import 'loader.dart';

// /// BPF Loader
// /// ------------------------------------------------------------------------------------------------

// /// BPF loader program id.
// final bpfLoaderProgramId = Pubkey.fromBase58(
//   'BPFLoader2111111111111111111111111111111111',
// );

// /// Factory class for transactions to interact with a program loader.
// class BpfLoader {

//   /// Returns the minimum number of signatures required to load a program (not including retries).
//   ///
//   /// Can be used to calculate transaction fees.
//   static int getMinNumSignatures(final int dataLength) {
//     return Loader.getMinNumSignatures(dataLength);
//   }

//   /// Loads a BPF program.
//   ///
//   /// Returns `true` if the [program] was loaded successfully and `false` if the program was already
//   /// loaded.
//   ///
//   /// [connection]      The connection to use.
//   /// [payer]           the `account` that will pay program loading fees.
//   /// [program]         The `account` to load the program into.
//   /// [elf]             The entire ELF containing the BPF program.
//   /// [loaderProgramId] The program id of the BPF loader to use.
//   static Future<bool> load(
//     final Connection connection,
//     final Signer payer,
//     final Signer program,
//     final Buffer elf,
//     final Pubkey loaderProgramId,
//   ) {
//     return Loader.load(connection, payer, program, loaderProgramId, elf);
//   }
// }
