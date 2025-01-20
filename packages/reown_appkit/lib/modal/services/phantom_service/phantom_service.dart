import 'dart:async';
import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:reown_appkit/modal/constants/string_constants.dart';

import 'package:reown_appkit/modal/services/explorer_service/i_explorer_service.dart';
import 'package:reown_appkit/modal/services/phantom_service/i_phantom_service.dart';
import 'package:reown_appkit/modal/services/phantom_service/models/phantom_data.dart';
import 'package:reown_appkit/modal/services/phantom_service/models/phantom_events.dart';
import 'package:reown_appkit/modal/services/phantom_service/phantom_helper.dart';
import 'package:reown_appkit/modal/services/third_party_wallet_service.dart';
import 'package:reown_appkit/reown_appkit.dart';

class PhantomService implements IPhantomService {
  static const _defaultListingData = Listing(
    id: 'a797aa35c0fadbfc1a53e7f675162ed5226968b44a19ee3d24385c64d1d3c393',
    name: 'Phantom Wallet',
    homepage: 'https://phantom.app/',
    imageId: 'c38443bb-b3c1-4697-e569-408de3fcc100',
    order: 4110,
    mobileLink: 'phantom://',
    webappLink: 'https://phantom.app/ul/',
    appStore:
        'https://apps.apple.com/us/app/phantom-crypto-wallet/id1598432977',
    playStore:
        'https://play.google.com/store/apps/details?id=app.phantom&hl=en',
  );

  late final String _iconImage;
  late final PairingMetadata _metadata;
  late final ReownAppKitModalWalletInfo? _walletData;
  late final IReownCore _core;
  late final PhantomHelper _phantomHelper;

  String? _selectedChainId;

  // mainnet-beta, testnet, or devnet
  final Map<String, String> _clusters = {
    '5eykt4UsFv8P8NJdTREpY1vzqKqZKvdp': 'mainnet-beta',
    '4uhcVJyU9pJkvQyS88uRDiswHXSCkY3z': 'testnet',
    'EtWTRABZaYq6iMfeYKouRu166VU2xqa1': 'devnet',
  };

  IExplorerService get _explorerService => GetIt.I<IExplorerService>();

  @override
  ConnectionMetadata get walletMetadata => ConnectionMetadata(
        metadata: PairingMetadata(
          name: _walletData!.listing.name,
          description: '',
          url: _walletData.listing.homepage,
          icons: [_iconImage],
          redirect: Redirect(
            native: _walletData.listing.mobileLink,
            universal: _walletData.listing.linkMode,
            linkMode: _walletData.listing.linkMode != null,
          ),
        ),
        publicKey: '',
      );

  @override
  List<String> get walletSupportedMethods => [
        'solana_signMessage',
        'solana_signTransaction',
        'solana_signAllTransactions',
        'solana_signAndSendTransaction',
      ];

  @override
  Event<PhantomConnectEvent> onPhantomConnect = Event<PhantomConnectEvent>();

  @override
  Event<PhantomErrorEvent> onPhantomError = Event<PhantomErrorEvent>();

  @override
  Event<PhantomResponseEvent> get onPhantomResponse =>
      Event<PhantomResponseEvent>();

  PhantomService({
    required PairingMetadata metadata,
    required IReownCore core,
  })  : _metadata = metadata,
        _core = core;

  @override
  Future<void> init() async {
    _walletData = await _explorerService.getPhantomWalletObject();
    final imageId = _walletData?.listing.imageId ?? _defaultListingData.imageId;
    _iconImage = _explorerService.getWalletImageUrl(imageId);

    final redirect =
        (_metadata.redirect?.universal ?? _metadata.redirect?.native)!;

    _phantomHelper = PhantomHelper(
      appUrl: _metadata.url,
      redirectLink: redirect,
      core: _core,
    );
  }

  @override
  Future<String> get dappPublicKey async => _phantomHelper.dappPublicKey;

  @override
  Future<String> get walletPublicKey async => _phantomHelper.walletPublicKey;

  @override
  Future<bool> isConnected() async {
    try {
      return _phantomHelper.restoreSession();
    } catch (e, s) {
      _core.logger.e('[$runtimeType] isConnected $e', stackTrace: s);
    }

    return false;
  }

  @override
  Future<void> connect({String? chainId}) async {
    await _checkInstalled();
    try {
      final solanaNets = ReownAppKitModalNetworks.getAllSupportedNetworks(
        namespace: NetworkUtils.solana,
      ).where((c) => !c.isTestNetwork);
      if (solanaNets.isEmpty) {
        throw ThirdPartyWalletUnsupportedChains(
          walletName: walletMetadata.metadata.name,
        );
      }

      _selectedChainId = chainId ?? solanaNets.first.chainId;

      final namespace = ReownAppKitModalNetworks.getNamespaceForChainId(
        _selectedChainId!,
      );
      if (namespace != NetworkUtils.solana) {
        _selectedChainId = solanaNets.first.chainId;
      }

      final selectedCluster = _clusters[_selectedChainId];
      final phantomUri = _phantomHelper.buildConnectionUri(
        cluster: selectedCluster,
      );
      await ReownCoreUtils.openURL(phantomUri.toString());
    } catch (e, s) {
      if (e is ThirdPartyWalletException) {
        _core.logger.e('[$runtimeType] ${e.message}', stackTrace: s);
        rethrow;
      }

      final errorMessage = '${walletMetadata.metadata.name} connect error';
      _core.logger.e('[$runtimeType] $errorMessage', error: e, stackTrace: s);
      onPhantomError.broadcast(PhantomErrorEvent(-1, errorMessage));
      throw ThirdPartyWalletException(errorMessage, e, s);
    }
  }

  Completer<dynamic> _requestCompleter = Completer<dynamic>();
  @override
  Future<dynamic> request({
    required String chainId,
    required SessionRequestParams request,
  }) async {
    await _checkInstalled();
    _core.logger.d(
      '[$runtimeType] ${request.method} ${jsonEncode(request.params)}',
    );
    _requestCompleter = Completer<dynamic>();

    try {
      late final Uri requestUri;
      switch (request.method) {
        case 'solana_signMessage':
          requestUri = _phantomHelper.buildSignMessageUri(
            message: request.params['message'],
          );
        case 'solana_signTransaction':
          requestUri = _phantomHelper.buildSignTransactionUri(
            transaction: request.params['transaction'],
          );
        case 'solana_signAllTransactions':
          requestUri = _phantomHelper.buildUriSignAllTransactions(
            transactions: request.params['transactions'],
          );
        case 'solana_signAndSendTransaction':
          requestUri = _phantomHelper.buildSignAndSendTransactionUri(
            transaction: request.params['transaction'],
          );
        default:
          throw ThirdPartyWalletException('${request.method} unimplemented');
      }

      _core.logger.d('[$runtimeType] request  $requestUri');
      await ReownCoreUtils.openURL(requestUri.toString());
    } catch (e, s) {
      final errorMessage = '${walletMetadata.metadata.name} request error';
      _core.logger.e('[$runtimeType] $errorMessage', error: e, stackTrace: s);
      onPhantomError.broadcast(PhantomErrorEvent(-1, errorMessage));
      throw ThirdPartyWalletException(errorMessage, e, s);
    }

    return _requestCompleter.future;
  }

  @override
  Future<void> disconnect() async {
    await _checkInstalled();
    try {
      final disconnectUri = _phantomHelper.buildDisconnectUri();
      await ReownCoreUtils.openURL(disconnectUri.toString());
    } catch (e, s) {
      final errorMessage = '${walletMetadata.metadata.name} disconnect error';
      _core.logger.e('[$runtimeType] $errorMessage', error: e, stackTrace: s);
      onPhantomError.broadcast(PhantomErrorEvent(-1, errorMessage));
      throw ThirdPartyWalletException(errorMessage, e, s);
    }
  }

  @override
  Future<bool> isInstalled() async => true;

  @override
  void completePhantomRequest({required String url}) async {
    final params = Uri.parse(url).queryParameters;
    final payload = await _phantomHelper.decryptPayload(params);
    final phantomRequest = payload['phantomRequest'];
    _core.logger.d('[$runtimeType] completePhantomRequest, payload: $payload');

    switch (phantomRequest) {
      case 'connect':
        _onConnectPhantomWallet(payload);
        break;
      case 'disconnect':
        _onDisconnectPhantomWallet(payload);
        break;
      default:
        _onRequestResponse(payload);
        break;
    }
  }

  Future<bool> _checkInstalled() async {
    final installed = await isInstalled();
    if (!installed) {
      throw ThirdPartyWalletNotInstalled(walletName: 'Phantom Wallet');
    }
    return true;
  }

  Future<void> _onConnectPhantomWallet(Map<String, dynamic> payload) async {
    if (payload.containsKey('errorCode')) {
      final errorCode = int.parse(payload['errorCode']);
      final errorMessage = payload['errorMessage'];
      onPhantomError.broadcast(PhantomErrorEvent(errorCode, errorMessage));
      return;
    }

    final data = PhantomData.fromJson(payload).copytWith(
      chainId: _selectedChainId,
      peer: walletMetadata.copyWith(publicKey: await walletPublicKey),
      self: ConnectionMetadata(
        metadata: _metadata,
        publicKey: await dappPublicKey,
      ),
    );
    await _phantomHelper.persistSession();
    onPhantomConnect.broadcast(PhantomConnectEvent(data));
    _core.logger.i(
      '[$runtimeType] _onConnectPhantomWallet ${jsonEncode(data.toJson())}',
    );
  }

  Future<void> _onDisconnectPhantomWallet(_) async {
    await _core.storage.delete(StorageConstants.phantomSession);
    return _phantomHelper.resetSharedSecret();
  }

  void _onRequestResponse(Map<String, dynamic> payload) {
    final p = Map<String, dynamic>.from(payload)..remove('phantomRequest');
    _requestCompleter.complete(p);
  }
}
