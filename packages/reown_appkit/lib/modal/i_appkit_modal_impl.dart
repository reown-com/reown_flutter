// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reown_appkit/reown_appkit.dart';

enum ReownAppKitModalStatus {
  idle,
  initializing,
  initialized,
  error;

  bool get isInitialized => this == initialized;
  bool get isLoading => this == initializing;
  bool get isError => this == error;
}

/// Either a [projectId] and [metadata] must be provided or an already created [appKit].
/// optionalNamespaces is mostly not needed, if you use it, the values set here will override every optionalNamespaces set in evey chain
abstract class IReownAppKitModal with ChangeNotifier {
  BuildContext? get modalContext;

  /// Whether or not this object has been initialized.
  ReownAppKitModalStatus get status;

  bool get hasNamespaces;

  FeaturesConfig get featuresConfig;

  /// The object that manages sessions, authentication, events, and requests for WalletConnect.
  IReownAppKit? get appKit;

  /// Variable that can be used to check if the modal is visible on screen.
  bool get isOpen;

  /// Variable that can be used to check if appKitModal is connected
  bool get isConnected;

  /// The URI that can be used to connect to this dApp.
  /// This is only available after the [openModalView] function is called.
  String? get wcUri;

  /// The current session's data.
  ReownAppKitModalSession? get session;

  /// The url to the account's avatar image.
  /// Pass this into a [Image.network] and it will load the avatar image.
  String? get avatarUrl;

  /// Returns the balance of the currently connected wallet on the selected chain.
  @Deprecated('Use balanceNotifier')
  String get chainBalance;

  /// Returns the balance of the currently connected wallet on the selected chain.
  ValueNotifier<String> get balanceNotifier;

  /// The currently selected chain.
  ReownAppKitModalNetworkInfo? get selectedChain;

  /// The currently selected wallet.
  ReownAppKitModalWalletInfo? get selectedWallet;

  /// Sets up the explorer and appKit if they already been initialized.
  Future<void> init();

  /// Opens modal on Network Selection Screen
  Future<void> openNetworksView();

  /// Opens the modal with the provided [startWidget] (if any).
  /// If none is provided, the default state will be used based on platform.
  Future<void> openModalView([Widget? startWidget]);

  /// Connects to the relay if not already connected.
  /// If the relay is already connected, this does nothing.
  Future<void> reconnectRelay();

  /// Sets the [selectedWallet] to be connected
  void selectWallet(ReownAppKitModalWalletInfo? walletInfo);

  /// Sets the [selectedChain]
  /// If the wallet is already connected, it will request the chain to be changed and will update the session with the new chain.
  /// If [chainInfo] is null this will disconnect the wallet.
  Future<void> selectChain(
    ReownAppKitModalNetworkInfo? chainInfo, {
    bool switchChain = false,
  });

  /// Launch blockchain explorer for the current chain in external browser
  void launchBlockExplorer();

  /// Used to expire and delete any inactive pairing
  Future<void> expirePreviousInactivePairings();

  /// This will do nothing if [isConnected] is true.
  Future<void> buildConnectionUri();

  /// Connects the [selectedWallet] previously selected
  Future<void> connectSelectedWallet({bool inBrowser = false});

  /// Opens the native wallet [selectedWallet] after connected
  void launchConnectedWallet();

  /// List of available chains to be added in connected wallet
  List<String>? getAvailableChains();

  /// List of approved chains by connected wallet
  List<String>? getApprovedChains({String? namespace});

  /// List of approved methods by connected wallet
  List<String>? getApprovedMethods({String? namespace});

  /// List of approved events by connected wallet
  List<String>? getApprovedEvents({String? namespace});

  /// Loads/Refresh account balance and identity
  Future<void> loadAccountData();

  /// Disconnects the session and pairing, if any.
  /// If there is no session, this does nothing.
  Future<void> disconnect({bool disconnectAllSessions = true});

  Future<List<dynamic>> requestReadContract({
    required String? topic,
    required String chainId,
    required DeployedContract deployedContract,
    required String functionName,
    EthereumAddress? sender,
    List parameters = const [],
  });

  Future<dynamic> requestWriteContract({
    required String? topic,
    required String chainId,
    required DeployedContract deployedContract,
    required String functionName,
    required Transaction transaction,
    List parameters = const [],
    String? method,
  });

  /// Make a request
  Future<dynamic> request({
    required String? topic,
    required String chainId,
    String? switchToChainId,
    required SessionRequestParams request,
  });

  Future<void> requestSwitchToChain(ReownAppKitModalNetworkInfo newChain);
  Future<void> requestAddChain(ReownAppKitModalNetworkInfo newChain);

  Future<bool> dispatchEnvelope(String url);

  /// Closes the modal.
  void closeModal({bool disconnectSession = false});

  @override
  Future<void> dispose();

  /* EVENTS DECLARATIONS */

  abstract final Event<ModalConnect> onModalConnect;
  abstract final Event<ModalConnect> onModalUpdate;
  abstract final Event<ModalNetworkChange> onModalNetworkChange;
  abstract final Event<ModalDisconnect> onModalDisconnect;
  abstract final Event<ModalError> onModalError;
  //
  abstract final Event<SessionExpire> onSessionExpireEvent;
  abstract final Event<SessionUpdate> onSessionUpdateEvent;
  abstract final Event<SessionEvent> onSessionEventEvent;
}
