/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_web3/src/crypto/pubkey.dart';
import '../configs/get_program_accounts_config.dart';
import '../interfaces/json_rpc_list_method.dart';
import '../models/program_account.dart';

/// Get Program Accounts
/// ------------------------------------------------------------------------------------------------

/// A codec for `getProgramAccounts` JSON RPC methods.
class GetProgramAccounts
    extends JsonRpcListMethod<Map<String, dynamic>, ProgramAccount> {
  /// Creates a codec for `getProgramAccounts` JSON RPC methods.
  GetProgramAccounts(
    final Pubkey program, {
    final GetProgramAccountsConfig? config,
  }) : super(
         'getProgramAccounts',
         values: [program.toBase58()],
         config: config ?? GetProgramAccountsConfig(),
       );

  @override
  ProgramAccount itemDecoder(final Map<String, dynamic> item) =>
      ProgramAccount.fromJson(item);
}
