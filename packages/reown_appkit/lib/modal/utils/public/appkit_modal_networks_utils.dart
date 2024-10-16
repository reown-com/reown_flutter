import 'package:reown_core/reown_core.dart';

export 'appkit_modal_default_networks.dart';
export 'appkit_modal_siwe_utils.dart';

class NetworkUtils {
  static const eip155 = 'eip155';
  static const solana = 'solana';

  static Map<String, List<String>> defaultNetworkMethods = {
    eip155: MethodsConstants.allMethods.toSet().toList(),
    solana: [
      'solana_getAccounts',
      'solana_signMessage',
      'solana_signTransaction',
      'solana_signAllTransactions',
      'solana_signAndSendTransaction',
    ],
  };

  static Map<String, List<String>> defaultNetworkEvents = {
    eip155: EventsConstants.allEvents.toSet().toList(),
    solana: [],
  };
}
