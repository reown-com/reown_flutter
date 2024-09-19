import 'package:reown_appkit/reown_appkit.dart';
import 'package:reown_sign/version.dart' as reown_sign;

class CoreConstants {
  // Request Headers
  static const X_SDK_TYPE = 'appkit';
  static const X_SDK_VERSION = packageVersion;
  static const X_CORE_SDK_VERSION = 'flutter_${reown_sign.packageVersion}';
  static const String namespace = 'eip155';
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
  static const String recentWalletId =
      '${CoreConstants.X_SDK_TYPE}_recentWallet';
  static const String connectedWalletData =
      '${CoreConstants.X_SDK_TYPE}_walletData';
  static const String selectedChainId =
      '${CoreConstants.X_SDK_TYPE}_selectedChainId';
  static const String modalSession = '${CoreConstants.X_SDK_TYPE}_session';
}

class UrlConstants {
  static const apiService = 'https://api.web3modal.com';
  static const blockChainService = 'https://rpc.walletconnect.org';
  static const analyticsService = 'https://pulse.walletconnect.org';
  static const exploreWallets =
      'https://explorer.walletconnect.com/?type=wallet';
  //
  static const secureService =
      'https://secure-mobile.walletconnect.com/mobile-sdk';
  static const secureDashboard = 'https://secure.walletconnect.com/dashboard';
  //
  static const learnMoreUrl =
      'https://ethereum.org/en/developers/docs/networks';
  static const String docsUrl = 'https://docs.reown.com';
  static const String cloudService = 'https://cloud.reown.com';
}
