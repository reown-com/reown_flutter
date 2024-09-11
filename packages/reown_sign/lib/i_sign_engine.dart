import 'package:reown_sign/i_sign_dapp.dart';
import 'package:reown_sign/i_sign_wallet.dart';

abstract class IReownSign implements IReownSignWallet, IReownSignDapp {
  Future<void> checkAndExpire();
}
