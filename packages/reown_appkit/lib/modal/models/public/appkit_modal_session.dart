import 'package:get_it/get_it.dart';
import 'package:reown_appkit/modal/services/coinbase_service/coinbase_service.dart';
import 'package:reown_appkit/modal/services/coinbase_service/i_coinbase_service.dart';
import 'package:reown_appkit/modal/services/coinbase_service/models/coinbase_data.dart';
import 'package:reown_appkit/modal/services/magic_service/i_magic_service.dart';
import 'package:reown_appkit/modal/services/magic_service/models/magic_data.dart';
import 'package:reown_appkit/reown_appkit.dart';

// TODO ReownAppKitModal this should be hidden
enum ReownAppKitModalConnector {
  wc,
  coinbase,
  magic,
  none;

  bool get isWC => this == ReownAppKitModalConnector.wc;
  bool get isCoinbase => this == ReownAppKitModalConnector.coinbase;
  bool get isMagic => this == ReownAppKitModalConnector.magic;
  bool get noSession => this == ReownAppKitModalConnector.none;
}

/// Session object of the modal when connected
class ReownAppKitModalSession {
  SessionData? _sessionData;
  CoinbaseData? _coinbaseData;
  MagicData? _magicData;
  SIWESession? _siweSession;

  ReownAppKitModalSession({
    SessionData? sessionData,
    CoinbaseData? coinbaseData,
    MagicData? magicData,
    SIWESession? siweSession,
  })  : _sessionData = sessionData,
        _coinbaseData = coinbaseData,
        _magicData = magicData,
        _siweSession = siweSession;

  /// USED TO READ THE SESSION FROM LOCAL STORAGE
  factory ReownAppKitModalSession.fromMap(Map<String, dynamic> map) {
    final sessionDataString = map['sessionData'];
    final coinbaseDataString = map['coinbaseData'];
    final magicDataString = map['magicData'];
    final siweSession = map['siweSession'];
    return ReownAppKitModalSession(
      sessionData: sessionDataString != null
          ? SessionData.fromJson(sessionDataString)
          : null,
      coinbaseData: coinbaseDataString != null
          ? CoinbaseData.fromJson(coinbaseDataString)
          : null,
      magicData:
          magicDataString != null ? MagicData.fromJson(magicDataString) : null,
      siweSession:
          siweSession != null ? SIWESession.fromJson(siweSession) : null,
    );
  }

  ReownAppKitModalSession copyWith({
    SessionData? sessionData,
    CoinbaseData? coinbaseData,
    MagicData? magicData,
    SIWESession? siweSession,
  }) {
    final newCoinbaseData = _coinbaseData?.copytWith(
      address: coinbaseData?.address,
      chainName: coinbaseData?.chainName,
      chainId: coinbaseData?.chainId,
      self: coinbaseData?.self,
      peer: coinbaseData?.peer,
    );
    final newMagicData = _magicData?.copytWith(
      email: magicData?.email,
      address: magicData?.address,
      chainId: magicData?.chainId,
      userName: magicData?.userName,
      smartAccountDeployed: magicData?.smartAccountDeployed,
      preferredAccountType: magicData?.preferredAccountType,
      self: magicData?.self,
      peer: magicData?.peer,
      provider: magicData?.provider,
    );
    return ReownAppKitModalSession(
      sessionData: sessionData ?? _sessionData,
      coinbaseData: newCoinbaseData ?? _coinbaseData,
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
    if (_magicData != null) {
      // TODO rename to ReownAppKitModalConnector.socials
      return ReownAppKitModalConnector.magic;
    }

    return ReownAppKitModalConnector.none;
  }

  bool hasSwitchMethod() {
    if (sessionService.noSession) {
      return false;
    }
    if (sessionService.isCoinbase) {
      return true;
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
    final eventsList = <String>[];

    if (sessionService.noSession) {
      return null;
    }
    if (sessionService.isCoinbase) {
      return eventsList;
    }
    if (sessionService.isMagic) {
      return eventsList;
    }

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
    ).map((e) => '${NetworkUtils.eip155}:${e.chainId}').toList();

    if (sessionService.isCoinbase) {
      return [...allEIP155];
    }

    final allSolana = ReownAppKitModalNetworks.getAllSupportedNetworks(
      namespace: NetworkUtils.solana,
    ).map((e) => '${NetworkUtils.solana}:${e.chainId}').toList();

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
      return ReownAppKitModalNetworks.getAllSupportedNetworks(namespace: ns)
          .map((e) => '$ns:${e.chainId}:${getAddress(ns)}')
          .toList();
    }

    if (sessionService.isMagic) {
      final ns = namespace ?? NetworkUtils.eip155;
      return ReownAppKitModalNetworks.getAllSupportedNetworks(namespace: ns)
          .map((e) => '$ns:${e.chainId}:${getAddress(ns)}')
          .toList();
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
      acknowledged: acknowledged ?? false,
      controller: controller ?? '',
      namespaces: _namespaces() ?? {},
      self: self!,
      peer: peer!,
      requiredNamespaces: _sessionData?.requiredNamespaces,
      optionalNamespaces: _sessionData?.optionalNamespaces,
      sessionProperties: _sessionData?.sessionProperties,
      authentication: _sessionData?.authentication,
      transportType: _sessionData?.transportType ?? TransportType.relay,
    );
    return sessionData.toJson();
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
  String get email => _magicData?.email ?? '';

  String get userName => _magicData?.userName ?? '';

  AppKitSocialOption? get socialProvider => _magicData?.provider;

  //
  String? getAddress(String namespace) {
    if (sessionService.noSession) {
      return null;
    }
    if (sessionService.isCoinbase) {
      return _coinbaseData!.address;
    }
    if (sessionService.isMagic) {
      return _magicData!.address;
    }
    final ns = namespaces?[namespace];
    final accounts = ns?.accounts ?? [];
    if (accounts.isNotEmpty) {
      return NamespaceUtils.getAccount(accounts.first);
    }
    return null;
  }

  String get chainId {
    if (sessionService.isWC) {
      final chainIds = NamespaceUtils.getChainIdsFromNamespaces(
        namespaces: namespaces ?? {},
      );
      if (chainIds.isNotEmpty) {
        return (chainIds..sort()).first.split(':')[1];
      }
    }
    if (sessionService.isCoinbase) {
      return _coinbaseData!.chainId.toString();
    }
    if (sessionService.isMagic) {
      return _magicData!.chainId.toString();
    }
    return '1';
  }

  String? get connectedWalletName {
    if (sessionService.isCoinbase) {
      return CoinbaseService.defaultWalletData.listing.name;
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
      ...(_magicData?.toJson() ?? {}),
    };
  }

  Map<String, Namespace>? _namespaces() {
    if (sessionService.isCoinbase) {
      // Coinbase only supports eip155 chains
      final eip155 = NetworkUtils.eip155;
      final allEIP155 = ReownAppKitModalNetworks.getAllSupportedNetworks(
        namespace: eip155,
      ).map((e) => '$eip155:${e.chainId}').toList();
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

    if (sessionService.isMagic) {
      final ns = ReownAppKitModalNetworks.getNamespaceForChainId(
        _magicData!.chainId,
      );
      final allChains = ReownAppKitModalNetworks.getAllSupportedNetworks(
        namespace: ns,
      ).map((e) => '$ns:${e.chainId}').toList();
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
      if (_magicData != null) 'magicData': _magicData?.toJson(),
      if (_siweSession != null) 'siweSession': _siweSession?.toJson(),
    };
  }
}
