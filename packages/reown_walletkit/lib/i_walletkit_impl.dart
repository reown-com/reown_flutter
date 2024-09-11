import 'package:reown_sign/i_sign_wallet.dart';
import 'package:reown_sign/reown_sign.dart';

abstract class IReownWalletKit implements IReownSignWallet {
  final String protocol = 'wc';
  final int version = 2;

  abstract final IReownSign reOwnSign;
}
