import 'package:get_it/get_it.dart';
import 'package:reown_walletkit/reown_walletkit.dart';

// class UpdateEvent extends EventArgs {
//   final bool loading;

//   UpdateEvent({required this.loading});
// }

abstract class IWalletKitService extends Disposable {
  Future<void> create();
  Future<void> init();

  ReownWalletKit get walletKit;
}
