import 'package:reown_appkit/modal/services/solflare_service/models/solflare_events.dart';
import 'package:reown_appkit/modal/services/third_party_wallet_service.dart';
import 'package:reown_appkit/reown_appkit.dart';

abstract class ISolflareService implements IThirdPartyWalletService {
  void completeSolflareRequest({required String url});

  abstract final Event<SolflareConnectEvent> onSolflareConnect;
  abstract final Event<SolflareErrorEvent> onSolflareError;
  abstract final Event<SolflareResponseEvent> onSolflareResponse;
}
