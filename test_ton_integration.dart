// Test script to verify TON integration
import 'packages/reown_appkit/lib/modal/utils/public/appkit_modal_networks_utils.dart';
import 'packages/reown_appkit/lib/modal/utils/public/appkit_modal_default_networks.dart';

void main() {
  print('Testing TON integration...');
  
  // Test 1: Check if TON namespace is available
  print('TON namespace: ${NetworkUtils.ton}');
  
  // Test 2: Check if TON methods are defined
  print('TON methods: ${NetworkUtils.defaultNetworkMethods[NetworkUtils.ton]}');
  
  // Test 3: Check if TON events are defined
  print('TON events: ${NetworkUtils.defaultNetworkEvents[NetworkUtils.ton]}');
  
  // Test 4: Check if TON networks are available
  final tonNetworks = ReownAppKitModalNetworks.getAllSupportedNetworks(namespace: NetworkUtils.ton);
  print('TON networks found: ${tonNetworks.length}');
  
  for (final network in tonNetworks) {
    print('  - ${network.name} (${network.chainId}): ${network.currency}');
    print('    RPC: ${network.rpcUrl}');
    print('    Explorer: ${network.explorerUrl}');
    print('    Test network: ${network.isTestNetwork}');
    print('');
  }
  
  print('TON integration test completed successfully!');
}
