import 'package:reown_sign/i_sign_wallet.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit/ton/i_ton_client.dart';

abstract class IReownWalletKit implements IReownSignWallet {
  final String protocol = 'wc';
  final int version = 2;

  abstract final IReownSign reOwnSign;
  abstract final ITonClient tonClient;
}
