import 'package:reown_appkit/modal/services/phantom_service/models/phantom_events.dart';
import 'package:reown_appkit/modal/services/third_party_wallet_service.dart';
import 'package:reown_appkit/reown_appkit.dart';

abstract class IPhantomService implements IThirdPartyWalletService {
  void completePhantomRequest({required String url});

  abstract final Event<PhantomConnectEvent> onPhantomConnect;
  abstract final Event<PhantomErrorEvent> onPhantomError;
  abstract final Event<PhantomResponseEvent> onPhantomResponse;
}
