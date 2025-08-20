import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:reown_appkit/modal/services/coinbase_service/i_coinbase_service.dart';
import 'package:reown_appkit/modal/services/coinbase_service/models/coinbase_data.dart';
import 'package:reown_appkit/modal/services/coinbase_service/utils/coinbase_utils.dart';
import 'package:reown_appkit/modal/services/magic_service/i_magic_service.dart';
import 'package:reown_appkit/modal/services/magic_service/models/magic_data.dart';
import 'package:reown_appkit/modal/services/phantom_service/i_phantom_service.dart';
import 'package:reown_appkit/modal/services/phantom_service/models/phantom_data.dart';
import 'package:reown_appkit/modal/services/solflare_service/i_solflare_service.dart';
import 'package:reown_appkit/modal/services/solflare_service/models/solflare_data.dart';
import 'package:reown_appkit/reown_appkit.dart';

// TODO ReownAppKitModal this should be hidden
enum ReownAppKitModalConnector {
  wc,
  coinbase,
  phantom,
  solflare,
  magic,
  none;

  bool get isWC => this == ReownAppKitModalConnector.wc;
  bool get isCoinbase => this == ReownAppKitModalConnector.coinbase;
  bool get isPhantom => this == ReownAppKitModalConnector.phantom;
  bool get isSolflare => this == ReownAppKitModalConnector.solflare;
  bool get isMagic => this == ReownAppKitModalConnector.magic;
  bool get noSession => this == ReownAppKitModalConnector.none;
}

/// Session object of the modal when connected
class ReownAppKitModalSession {
  SessionData? _sessionData;
  CoinbaseData? _coinbaseData;
  PhantomData? _phantomData;
  SolflareData? _solflareData;
  MagicData? _magicData;
  SIWESession? _siweSession;
  bool _isSmartAccount = false;

  ReownAppKitModalSession({
    SessionData? sessionData,
    CoinbaseData? coinbaseData,
    PhantomData? phantomData,
    SolflareData? solflareData,
    MagicData? magicData,
    SIWESession? siweSession,
    bool isSmartAccount = false,
  }) : _sessionData = sessionData,
       _coinbaseData = coinbaseData,
       _phantomData = phantomData,
       _solflareData = solflareData,
       _magicData = magicData,
       _siweSession = siweSession,
       _isSmartAccount = isSmartAccount;

  /// USED TO READ THE SESSION FROM LOCAL STORAGE
  factory ReownAppKitModalSession.fromMap(Map<String, dynamic> map) {
    final sessionDataString = map['sessionData'];
    final coinbaseDataString = map['coinbaseData'];
    final phantomDataString = map['phantomData'];
    final solflareDataString = map['solflareData'];
    final magicDataString = map['magicData'];
    final siweSession = map['siweSession'];
    final smartAccount = map['isSmartAccount'] ?? false;
    return ReownAppKitModalSession(
      sessionData: sessionDataString != null
          ? SessionData.fromJson(sessionDataString)
          : null,
      coinbaseData: coinbaseDataString != null
          ? CoinbaseData.fromJson(coinbaseDataString)
          : null,
      phantomData: phantomDataString != null
          ? PhantomData.fromJson(phantomDataString)
          : null,
      solflareData: solflareDataString != null
          ? SolflareData.fromJson(solflareDataString)
          : null,
      magicData: magicDataString != null
          ? MagicData.fromJson(magicDataString)
          : null,
      siweSession: siweSession != null
          ? SIWESession.fromJson(siweSession)
          : null,
      isSmartAccount: smartAccount,
    );
  }

  ReownAppKitModalSession copyWith({
    SessionData? sessionData,
    CoinbaseData? coinbaseData,
    PhantomData? phantomData,
    SolflareData? solflareData,
    MagicData? magicData,
    SIWESession? siweSession,
  }) {
    final newCoinbaseData = _coinbaseData?.copyWith(
      address: coinbaseData?.address,
      chainName: coinbaseData?.chainName,
      chainId: coinbaseData?.chainId,
      self: coinbaseData?.self,
      peer: coinbaseData?.peer,
    );
    final newPhantomData = _phantomData?.copyWith(
      address: phantomData?.address,
      self: phantomData?.self,
      peer: phantomData?.peer,
    );
    final newSolflareData = _solflareData?.copyWith(
      address: solflareData?.address,
      self: solflareData?.self,
      peer: solflareData?.peer,
    );
    final newMagicData = _magicData?.copyWith(
      email: magicData?.email,
      address: magicData?.address,
      chainId: magicData?.chainId,
      farcasterUserName: magicData?.farcasterUserName,
      smartAccountDeployed: magicData?.smartAccountDeployed,
      preferredAccountType: magicData?.preferredAccountType,
      self: magicData?.self,
      peer: magicData?.peer,
      provider: magicData?.provider,
    );
    return ReownAppKitModalSession(
      sessionData: sessionData ?? _sessionData,
      coinbaseData: newCoinbaseData ?? _coinbaseData,
      phantomData: newPhantomData ?? _phantomData,
      solflareData: newSolflareData ?? _solflareData,
      magicData: newMagicData ?? _magicData,
      siweSession: siweSession ?? _siweSession,
    );
  }

  /// Indicates the connected service
  ReownAppKitModalConnector get sessionService {
    if (_sessionData != null) {
      return ReownAppKitModalConnector.wc;
    }
    if (_coinbaseData != null) {
      return ReownAppKitModalConnector.coinbase;
    }
    if (_phantomData != null) {
      return ReownAppKitModalConnector.phantom;
    }
    if (_solflareData != null) {
      return ReownAppKitModalConnector.solflare;
    }
    if (_magicData != null) {
      return ReownAppKitModalConnector.magic;
    }

    return ReownAppKitModalConnector.none;
  }

  void switchSmartAccounts() => _isSmartAccount = !_isSmartAccount;

  bool hasSwitchMethod() {
    if (sessionService.noSession) {
      return false;
    }
    if (sessionService.isCoinbase) {
      return true;
    }
    if (sessionService.isPhantom) {
      // Phantom Wallet can only use one cluster (network) at a time
      // it will connect to mainnet-beta by default if no network is selected beforehand
      return false;
    }
    if (sessionService.isSolflare) {
      // Solflare Wallet can only use one cluster (network) at a time
      // it will connect to mainnet-beta by default if no network is selected beforehand
      return false;
    }
    if (sessionService.isMagic) {
      return true;
    }

    final nsMethods = getApprovedMethods(namespace: NetworkUtils.eip155) ?? [];
    final supportsAddChain = nsMethods.contains(
      MethodsConstants.walletAddEthChain,
    );
    return supportsAddChain;
  }

  List<String>? getApprovedMethods({String? namespace}) {
    final methodsList = <String>[];

    if (sessionService.noSession) {
      return null;
    }
    if (sessionService.isCoinbase) {
      return GetIt.I<ICoinbaseService>().supportedMethods;
    }
    if (sessionService.isPhantom) {
      return GetIt.I<IPhantomService>().walletSupportedMethods;
    }
    if (sessionService.isSolflare) {
      return GetIt.I<ISolflareService>().walletSupportedMethods;
    }
    if (sessionService.isMagic) {
      final ns = namespace ?? NetworkUtils.eip155;
      return GetIt.I<IMagicService>().supportedMethods[ns];
    }

    final sessionNamespaces = _sessionData!.namespaces;
    if ((namespace ?? '').isEmpty) {
      for (var namespace in sessionNamespaces.keys) {
        final events = sessionNamespaces[namespace]?.methods ?? [];
        methodsList.addAll(events);
      }

      return methodsList;
    }

    return sessionNamespaces[namespace]?.methods ?? [];
  }

  List<String>? getApprovedEvents({String? namespace}) {
    if (sessionService.noSession) {
      return null;
    }
    if (sessionService.isCoinbase ||
        sessionService.isPhantom ||
        sessionService.isSolflare ||
        sessionService.isMagic) {
      return <String>[];
    }

    final eventsList = <String>[];
    final sessionNamespaces = _sessionData!.namespaces;
    if ((namespace ?? '').isEmpty) {
      for (var namespace in sessionNamespaces.keys) {
        final events = sessionNamespaces[namespace]?.events ?? [];
        eventsList.addAll(events);
      }

      return eventsList;
    }

    return sessionNamespaces[namespace]?.events ?? [];
  }

  List<String>? getApprovedChains({String? namespace}) {
    if (sessionService.noSession) {
      return null;
    }
    // Coinbase only support EIP155 but since we can not know which chains are actually approved...
    // Magic only support EIP155 and Solana but since we can not know which chains are actually approved...

    final allEIP155 = ReownAppKitModalNetworks.getAllSupportedNetworks(
      namespace: NetworkUtils.eip155,
    ).map((e) => e.chainId).toList();

    if (sessionService.isCoinbase) {
      return [...allEIP155];
    }

    final allSolana = ReownAppKitModalNetworks.getAllSupportedNetworks(
      namespace: NetworkUtils.solana,
    ).map((e) => e.chainId).toList();

    if (sessionService.isPhantom) {
      return [_phantomData!.chainId];
    }

    if (sessionService.isSolflare) {
      return [_solflareData!.chainId];
    }

    if (sessionService.isMagic) {
      return [...allEIP155, ...allSolana];
    }

    final accounts = getAccounts(namespace: namespace) ?? [];
    return NamespaceUtils.getChainsFromAccounts(accounts);
  }

  List<String>? getAccounts({String? namespace}) {
    final accountList = <String>[];

    if (sessionService.noSession) {
      return null;
    }

    if (sessionService.isCoinbase) {
      final ns = NetworkUtils.eip155;
      return ReownAppKitModalNetworks.getAllSupportedNetworks(
        namespace: ns,
      ).map((e) => '${e.chainId}:${getAddress(ns)}').toList();
    }

    if (sessionService.isPhantom) {
      final ns = namespace ?? NetworkUtils.solana;
      return ReownAppKitModalNetworks.getAllSupportedNetworks(
        namespace: ns,
      ).map((e) => '${e.chainId}:${getAddress(ns)}').toList();
    }

    if (sessionService.isSolflare) {
      final ns = namespace ?? NetworkUtils.solana;
      return ReownAppKitModalNetworks.getAllSupportedNetworks(
        namespace: ns,
      ).map((e) => '${e.chainId}:${getAddress(ns)}').toList();
    }

    if (sessionService.isMagic) {
      final ns = namespace ?? NetworkUtils.eip155;
      return ReownAppKitModalNetworks.getAllSupportedNetworks(
        namespace: ns,
      ).map((e) => '${e.chainId}:${getAddress(ns)}').toList();
    }

    if (_isSmartAccount) {
      return sessionSmartAccounts;
    }

    final sessionNamespaces = _sessionData!.namespaces;
    if ((namespace ?? '').isEmpty) {
      for (var namespace in sessionNamespaces.keys) {
        final accounts = sessionNamespaces[namespace]?.accounts ?? [];
        accountList.addAll(accounts);
      }

      return accountList;
    }

    return sessionNamespaces[namespace]?.accounts ?? [];
  }

  Redirect? getSessionRedirect() {
    if (sessionService.noSession) {
      return null;
    }

    return _sessionData?.peer.metadata.redirect;
  }

  // toJson() would convert ReownAppKitModalSession to a SessionData kind of map
  // no matter if Coinbase Wallet or Email Wallet is connected
  Map<String, dynamic> toJson() {
    if (_sessionData != null) {
      return _sessionData!.toJson();
    }

    final sessionData = SessionData(
      topic: topic ?? '',
      pairingTopic: pairingTopic ?? '',
      relay: relay ?? Relay(ReownConstants.RELAYER_DEFAULT_PROTOCOL),
      expiry: expiry ?? 0,
      acknowledged: true,
      controller: sessionService.name,
      namespaces: _namespaces() ?? {},
      self: self!,
      peer: peer!,
    );
    return {
      ...sessionData.toJson(),
      'relay': null,
      'transportType': sessionService.name,
    };
  }
}

extension ReownAppKitModalSessionExtension on ReownAppKitModalSession {
  String? get topic => _sessionData?.topic;
  String? get pairingTopic => _sessionData?.pairingTopic;
  Relay? get relay => _sessionData?.relay;
  int? get expiry => _sessionData?.expiry;
  bool? get acknowledged => _sessionData?.acknowledged;
  String? get controller => _sessionData?.controller;
  Map<String, Namespace>? get namespaces => _sessionData?.namespaces;

  ConnectionMetadata? get self {
    if (sessionService.isCoinbase) {
      return _coinbaseData?.self;
    }
    if (sessionService.isPhantom) {
      return _phantomData?.self;
    }
    if (sessionService.isSolflare) {
      return _solflareData?.self;
    }
    if (sessionService.isMagic) {
      return _magicData?.self ??
          ConnectionMetadata(
            publicKey: '',
            metadata: PairingMetadata(
              name: 'Email Wallet',
              description: '',
              url: '',
              icons: [],
            ),
          );
    }
    return _sessionData?.self;
  }

  ConnectionMetadata? get peer {
    if (sessionService.isCoinbase) {
      return _coinbaseData?.peer;
    }
    if (sessionService.isPhantom) {
      return _phantomData?.peer;
    }
    if (sessionService.isSolflare) {
      return _solflareData?.peer;
    }
    if (sessionService.isMagic) {
      return _magicData?.peer ??
          ConnectionMetadata(
            publicKey: '',
            metadata: PairingMetadata(
              name: 'Email Wallet',
              description: '',
              url: '',
              icons: [],
            ),
          );
    }
    return _sessionData?.peer;
  }

  //
  Map<String, dynamic> get sessionProperties =>
      _sessionData?.sessionProperties ?? {};

  //
  List<String> get sessionSmartAccounts {
    try {
      return List<String>.from(jsonDecode(sessionProperties['smartAccounts']));
    } catch (_) {
      return [];
    }
  }

  String? get socialProvider =>
      sessionProperties['provider'] ?? _magicData?.provider?.name;
  String? get sessionEmail => sessionProperties['email'] ?? _magicData?.email;
  String? get sessionUsername =>
      sessionProperties['username'] ??
      _magicData?.farcasterUserName ??
      sessionEmail;

  //
  String? getAddress(String namespace) {
    if (sessionService.noSession) {
      return null;
    }
    if (sessionService.isCoinbase) {
      return _coinbaseData!.address;
    }
    if (sessionService.isPhantom) {
      return _phantomData!.address;
    }
    if (sessionService.isSolflare) {
      return _solflareData!.address;
    }
    if (sessionService.isMagic) {
      return _magicData!.address;
    }
    if (_isSmartAccount) {
      return NamespaceUtils.getAccount(sessionSmartAccounts.first);
    }

    final ns = namespaces?[namespace];
    final accounts = List<String>.from(ns?.accounts ?? [])
      ..removeWhere((item) => sessionSmartAccounts.contains(item));
    if (accounts.isNotEmpty) {
      return NamespaceUtils.getAccount(accounts.first);
    }
    return null;
  }

  String get chainId {
    if (sessionService.isCoinbase) {
      return _coinbaseData!.chainId.toString();
    }
    if (sessionService.isPhantom) {
      return _phantomData!.chainId;
    }
    if (sessionService.isSolflare) {
      return _solflareData!.chainId;
    }
    if (sessionService.isMagic) {
      return _magicData!.chainId;
    }

    final chainIds = NamespaceUtils.getChainIdsFromNamespaces(
      namespaces: namespaces ?? {},
    );
    return (chainIds..sort()).first;
  }

  String? get connectedWalletName {
    if (sessionService.isCoinbase) {
      return CoinbaseUtils.defaultListingData.name;
    }
    if (sessionService.isPhantom) {
      return peer!.metadata.name;
    }
    if (sessionService.isSolflare) {
      return peer!.metadata.name;
    }
    if (sessionService.isMagic) {
      return peer?.metadata.name;
    }
    if (sessionService.isWC) {
      return peer?.metadata.name;
    }
    return null;
  }

  Map<String, dynamic> toRawJson() {
    return {
      ...(_sessionData?.toJson() ?? {}),
      ...(_coinbaseData?.toJson() ?? {}),
      ...(_phantomData?.toJson() ?? {}),
      ...(_solflareData?.toJson() ?? {}),
      ...(_magicData?.toJson() ?? {}),
    };
  }

  Map<String, Namespace>? _namespaces() {
    if (sessionService.isCoinbase) {
      // Coinbase only supports eip155 chains
      final eip155 = NetworkUtils.eip155;
      final allEIP155 = getApprovedChains(namespace: eip155)!;
      return {
        eip155: Namespace(
          chains: [...allEIP155],
          accounts: [...getAccounts(namespace: eip155)!],
          methods: [...GetIt.I<ICoinbaseService>().supportedMethods],
          // Coinbase does not have events as it doesn't use WC protocol
          events: [],
        ),
      };
    }

    if (sessionService.isPhantom) {
      // Phantom only supports solana chains through the deeplink API
      final solana = NetworkUtils.solana;
      final allSolana = getApprovedChains(namespace: solana)!;
      return {
        solana: Namespace(
          chains: [...allSolana],
          accounts: [...getAccounts(namespace: solana)!],
          methods: [...GetIt.I<IPhantomService>().walletSupportedMethods],
          // Phantom does not have events as it doesn't use WC protocol
          events: [],
        ),
      };
    }

    if (sessionService.isSolflare) {
      // Solflare only supports solana chains through the deeplink API
      final solana = NetworkUtils.solana;
      final allSolana = getApprovedChains(namespace: solana)!;
      return {
        solana: Namespace(
          chains: [...allSolana],
          accounts: [...getAccounts(namespace: solana)!],
          methods: [...GetIt.I<ISolflareService>().walletSupportedMethods],
          // Solflare does not have events as it doesn't use WC protocol
          events: [],
        ),
      };
    }

    if (sessionService.isMagic) {
      final ns = NamespaceUtils.getNamespaceFromChain(_magicData!.chainId);
      final allChains = ReownAppKitModalNetworks.getAllSupportedNetworks(
        namespace: ns,
      ).map((e) => e.chainId).toList();
      return {
        ns: Namespace(
          chains: [...allChains],
          accounts: [...getAccounts(namespace: ns)!],
          methods: [...NetworkUtils.defaultNetworkMethods[ns]!],
          // Magic does not have events as it doesn't use WC protocol
          events: [],
        ),
      };
    }

    return namespaces;
  }

  /// USED TO STORE THE SESSION IN LOCAL STORAGE
  Map<String, dynamic> toMap() {
    return {
      if (_sessionData != null) 'sessionData': _sessionData!.toJson(),
      if (_coinbaseData != null) 'coinbaseData': _coinbaseData?.toJson(),
      if (_phantomData != null) 'phantomData': _phantomData?.toJson(),
      if (_solflareData != null) 'solflareData': _solflareData?.toJson(),
      if (_magicData != null) 'magicData': _magicData?.toJson(),
      if (_siweSession != null) 'siweSession': _siweSession?.toJson(),
      'isSmartAccount': _isSmartAccount,
    };
  }
}
