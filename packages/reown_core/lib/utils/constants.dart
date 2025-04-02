class ReownConstants {
  static const CORE_PROTOCOL = 'wc';
  static const CORE_VERSION = 2;
  static const CORE_CONTEXT = 'core';

  static const CORE_STORAGE_PREFIX =
      '$CORE_PROTOCOL@$CORE_VERSION:$CORE_CONTEXT:';

  static const DEFAULT_RELAY_URL = 'wss://relay.walletconnect.org';
  static const DEFAULT_PUSH_URL = 'https://echo.walletconnect.org';
  static const VERIFY_SERVER = 'https://verify.walletconnect.org';
  static const EVENTS_SERVER = 'https://pulse.walletconnect.org';
  static const TRUSTED_VERIFY_URLS = [VERIFY_SERVER];

  static const RELAYER_DEFAULT_PROTOCOL = 'irn';

  static const THIRTY_SECONDS = 30;
  static const ONE_MINUTE = 60;
  static const FIVE_MINUTES = ONE_MINUTE * 5;
  static const ONE_HOUR = ONE_MINUTE * 60;
  static const ONE_DAY = ONE_MINUTE * 24 * 60;
  static const SEVEN_DAYS = ONE_DAY * 7;
  static const THIRTY_DAYS = ONE_DAY * 30;
}

class StoreVersions {
  // Core
  static const CONTEXT_KEYCHAIN = 'keychain';
  static const VERSION_KEYCHAIN = '0.3';
  static const CONTEXT_JSON_RPC_HISTORY = 'jsonRpcHistory';
  static const VERSION_JSON_RPC_HISTORY = '1.0';
  static const CONTEXT_PAIRINGS = 'pairings';
  static const VERSION_PAIRINGS = '1.0';
  static const CONTEXT_EXPIRER = 'expirer';
  static const VERSION_EXPIRER = '0.3';
  static const CONTEXT_MESSAGE_TRACKER = 'messageTracker';
  static const VERSION_MESSAGE_TRACKER = '1.0';
  static const CONTEXT_TOPIC_MAP = 'topicMap';
  static const VERSION_TOPIC_MAP = '1.0';
  static const CONTEXT_TOPIC_TO_RECEIVER_PUBLIC_KEY =
      'topicToReceiverPublicKey';
  static const VERSION_TOPIC_TO_RECEIVER_PUBLIC_KEY = '1.1';
  static const CONTEXT_LINKMODE = 'linkMode';
  static const VERSION_LINKMODE = '1.0';

  // Sign
  static const CONTEXT_PROPOSALS = 'proposals';
  static const VERSION_PROPOSALS = '1.1';
  static const CONTEXT_SESSIONS = 'sessions';
  static const VERSION_SESSIONS = '1.1';
  static const CONTEXT_PENDING_REQUESTS = 'pendingRequests';
  static const VERSION_PENDING_REQUESTS = '1.0';

  // Auth
  static const CONTEXT_AUTH_KEYS = 'authKeys';
  static const VERSION_AUTH_KEYS = '2.0';
  static const CONTEXT_PAIRING_TOPICS = 'authPairingTopics';
  static const VERSION_PAIRING_TOPICS = '2.0';
  static const CONTEXT_AUTH_REQUESTS = 'authRequests';
  static const VERSION_AUTH_REQUESTS = '2.0';
  static const CONTEXT_COMPLETE_REQUESTS = 'completeRequests';
  static const VERSION_COMPLETE_REQUESTS = '2.1';
}

class MethodsConstants {
  static const walletSwitchEthChain = 'wallet_switchEthereumChain';
  static const walletAddEthChain = 'wallet_addEthereumChain';
  static const ethSendTransaction = 'eth_sendTransaction';
  static const requiredMethods = [
    ethSendTransaction,
    'personal_sign',
  ];
  static const optionalMethods = [
    'eth_accounts',
    'eth_requestAccounts',
    'eth_sendRawTransaction',
    'eth_sign',
    'eth_signTransaction',
    'eth_signTypedData',
    'eth_signTypedData_v3',
    'eth_signTypedData_v4',
    walletSwitchEthChain,
    walletAddEthChain,
    'wallet_getPermissions',
    'wallet_requestPermissions',
    'wallet_registerOnboarding',
    'wallet_watchAsset',
    'wallet_scanQRCode',
  ];
  static const allMethods = [...requiredMethods, ...optionalMethods];
}

class EventsConstants {
  static const chainChanged = 'chainChanged';
  static const accountsChanged = 'accountsChanged';
  static const requiredEvents = [
    chainChanged,
    accountsChanged,
  ];
  static const optionalEvents = [
    'message',
    'disconnect',
    'connect',
  ];
  static const allEvents = [...requiredEvents, ...optionalEvents];
}
