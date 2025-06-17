import 'package:reown_sign/i_sign_wallet.dart';
import 'package:reown_walletkit/chain_abstraction/i_chain_abstraction.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit/sui/i_sui_client.dart';

abstract class IReownWalletKit
    implements IReownSignWallet, IChainAbstractionClient {
  final String protocol = 'wc';
  final int version = 2;

  abstract final IReownSign reOwnSign;
  abstract final IChainAbstractionClient chainAbstractionClient;
  abstract final ISuiClient suiClient;
}
