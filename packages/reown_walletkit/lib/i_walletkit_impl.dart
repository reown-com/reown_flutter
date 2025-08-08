import 'package:reown_sign/i_sign_wallet.dart';
import 'package:reown_walletkit/chain_abstraction/i_chain_abstraction.dart';
import 'package:reown_walletkit/reown_walletkit.dart';

abstract class IReownWalletKit implements IReownSignWallet {
  final String protocol = 'wc';
  final int version = 2;

  abstract final IReownSign reOwnSign;

  /// ---------------------------------
  /// ⚠️ This method is experimental. Use with caution.
  /// ---------------------------------
  abstract final IChainAbstractionClient chainAbstractionClient;
}
