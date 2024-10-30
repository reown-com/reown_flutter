// ignore_for_file: public_member_api_docs

import 'package:reown_appkit/reown_appkit.dart';
import 'package:reown_core/version.dart' as reown_core;
import 'package:reown_sign/version.dart' as reown_sign;

class CoreConstants {
  // Request Headers
  static const X_SDK_TYPE = 'appkit';
  static const X_SDK_VERSION = 'flutter-$packageVersion';
  static const X_CORE_SDK_VERSION = 'core-${reown_core.packageVersion}';
  static const X_SIGN_SDK_VERSION = 'sign-${reown_sign.packageVersion}';
}

class UIConstants {
  // UI
  static const String selectNetwork = 'Select network';
  static const String selectNetworkShort = 'Network';
  static const String connected = 'Connected';
  static const String error = 'Error';
  static const String copyAddress = 'Copy Address';
  static const String disconnect = 'Disconnect';
  static const String addressCopied = 'Address copied';
  static const String noChain = 'No Chain';
  static const String connectButtonError = 'Network Error';
  static const String connectButtonReconnecting = 'Reconnecting';
  static const String connectButtonIdle = 'Connect wallet';
  static const String connectButtonIdleShort = 'Connect';
  static const String connectButtonConnecting = 'Connecting...';
  static const String connectButtonConnected = 'Disconnect';
  static const String noResults = 'No results found';
}

class StorageConstants {
  // Storage
  static const prefix = '${CoreConstants.X_SDK_TYPE}:$packageVersion//';

  static const String recentWalletId = '${prefix}recentWallet';
  static const String connectedWalletData = '${prefix}walletData';
  static const String selectedChainId = '${prefix}selectedChainId';
  static const String modalSession = '${prefix}session';
}

class UrlConstants {
  static const apiService = 'https://api.web3modal.com';
  static const blockChainService = 'https://rpc.walletconnect.org';
  static const analyticsService = 'https://pulse.walletconnect.org';
  static const exploreWallets =
      'https://explorer.walletconnect.com/?type=wallet';
  //
  static const secureOrigin1 = 'secure-mobile.walletconnect.com';
  static const secureOrigin2 = 'secure.walletconnect.com';
  static const secureService = 'https://$secureOrigin1/mobile-sdk';
  static const secureDashboard = 'https://$secureOrigin2/dashboard';
  //
  static const learnMoreUrl =
      'https://ethereum.org/en/developers/docs/networks';
  static const String docsUrl = 'https://docs.reown.com';
  static const String cloudService = 'https://cloud.reown.com';
}
