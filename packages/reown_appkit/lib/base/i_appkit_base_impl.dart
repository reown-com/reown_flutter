import 'package:reown_sign/i_sign_dapp.dart';
import 'package:reown_sign/reown_sign.dart';

///
abstract class IReownAppKit implements IReownSignDapp {
  ///
  final String protocol = 'wc';

  ///
  final int version = 2;

  ///
  abstract final IReownSign reOwnSign;
}
