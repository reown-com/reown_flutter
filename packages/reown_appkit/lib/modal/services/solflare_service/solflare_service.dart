import 'dart:async';
import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:reown_appkit/modal/constants/string_constants.dart';

import 'package:reown_appkit/modal/services/explorer_service/i_explorer_service.dart';
import 'package:reown_appkit/modal/services/solflare_service/i_solflare_service.dart';
import 'package:reown_appkit/modal/services/solflare_service/models/solflare_data.dart';
import 'package:reown_appkit/modal/services/solflare_service/models/solflare_events.dart';
import 'package:reown_appkit/modal/services/solflare_service/solflare_helper.dart';
import 'package:reown_appkit/modal/services/solflare_service/utils/solflare_utils.dart';
import 'package:reown_appkit/modal/services/third_party_wallet_service.dart';
import 'package:reown_appkit/reown_appkit.dart';

class SolflareService implements ISolflareService {
  String _iconImage = '';
  ReownAppKitModalWalletInfo? _solflareWalletData;
  SolflareHelper? _solflareHelper;

  late final PairingMetadata _metadata;
  late final IReownCore _core;

  String? _selectedChainId;

  IExplorerService get _explorerService => GetIt.I<IExplorerService>();

  @override
  ConnectionMetadata get walletMetadata => ConnectionMetadata(
    metadata: PairingMetadata(
      name: _solflareWalletData?.listing.name ?? 'Solflare',
      description: _solflareWalletData?.listing.description ?? '',
      url: _solflareWalletData?.listing.homepage ?? '',
      icons: [_iconImage],
      redirect: Redirect(
        native: _solflareWalletData?.listing.mobileLink,
        universal: _solflareWalletData?.listing.linkMode,
        linkMode: _solflareWalletData?.listing.linkMode != null,
      ),
    ),
    publicKey: '',
  );

  @override
  List<String> get walletSupportedMethods =>
      NetworkUtils.defaultNetworkMethods[NetworkUtils.solana]!
        ..remove('solana_getAccounts');

  @override
  Event<SolflareConnectEvent> onSolflareConnect = Event<SolflareConnectEvent>();

  @override
  Event<SolflareErrorEvent> onSolflareError = Event<SolflareErrorEvent>();

  @override
  Event<SolflareResponseEvent> get onSolflareResponse =>
      Event<SolflareResponseEvent>();

  SolflareService({required PairingMetadata metadata, required IReownCore core})
    : _metadata = metadata,
      _core = core;

  @override
  Future<void> init() async {
    _solflareWalletData =
        (await _explorerService.getSolflareWalletObject()) ??
        ReownAppKitModalWalletInfo(
          listing: SolflareUtils.defaultListingData,
          installed: false,
          recent: false,
        );

    _iconImage = _explorerService.getWalletIcon(_solflareWalletData);

    final dappRedirect = (_metadata.redirect?.linkMode == true)
        ? _metadata.redirect?.universal
        : _metadata.redirect?.native;

    _solflareHelper = SolflareHelper(
      redirect: walletMetadata.metadata.redirect!,
      appUrl: _metadata.url,
      redirectLink: dappRedirect ?? '',
      core: _core,
    );
  }

  @override
  Future<String> get dappPublicKey async =>
      _solflareHelper?.dappPublicKey ?? '';

  @override
  Future<String> get walletPublicKey async =>
      _solflareHelper?.walletPublicKey ?? '';

  @override
  Future<bool> isConnected() async {
    try {
      return _solflareHelper!.restoreSession();
    } catch (e, s) {
      _core.logger.e('[$runtimeType] isConnected $e', stackTrace: s);
    }

    return false;
  }

  @override
  Future<void> connect({String? chainId}) async {
    // await _checkInstalled();
    try {
      final solanaNets = ReownAppKitModalNetworks.getAllSupportedNetworks(
        namespace: NetworkUtils.solana,
      ).where((c) => !c.isTestNetwork);
      if (solanaNets.isEmpty) {
        throw ThirdPartyWalletUnsupportedChains(
          walletName: walletMetadata.metadata.name,
          message:
              '${walletMetadata.metadata.name} requires Solana network to connect',
        );
      }

      _selectedChainId = chainId ?? solanaNets.first.chainId;

      final namespace = NamespaceUtils.getNamespaceFromChain(_selectedChainId!);
      if (namespace != NetworkUtils.solana) {
        _selectedChainId = solanaNets.first.chainId;
      }

      final selectedCluster = SolflareUtils.walletClusters[_selectedChainId];
      final solflareUri = _solflareHelper?.buildConnectionUri(
        cluster: selectedCluster,
      );
      _core.logger.d('[$runtimeType] connect $solflareUri');
      await ReownCoreUtils.openURL(solflareUri.toString());
    } catch (e, s) {
      if (e is ThirdPartyWalletException) {
        _core.logger.e('[$runtimeType] ${e.message}', stackTrace: s);
        rethrow;
      }

      final errorMessage = '${walletMetadata.metadata.name} connect error';
      _core.logger.e('[$runtimeType] $errorMessage', error: e, stackTrace: s);
      onSolflareError.broadcast(SolflareErrorEvent(-1, errorMessage));
      throw ThirdPartyWalletException(errorMessage, e, s);
    }
  }

  Completer<dynamic> _requestCompleter = Completer<dynamic>();
  @override
  Future<dynamic> request({
    required String chainId,
    required SessionRequestParams request,
  }) async {
    // await _checkInstalled();
    _core.logger.d(
      '[$runtimeType] ${request.method} ${jsonEncode(request.params)}',
    );
    _requestCompleter = Completer<dynamic>();

    try {
      late final Uri requestUri;
      switch (request.method) {
        case 'solana_signMessage':
          requestUri = _solflareHelper!.buildSignMessageUri(
            message: request.params['message'],
          );
        case 'solana_signTransaction':
          requestUri = _solflareHelper!.buildSignTransactionUri(
            transaction: request.params['transaction'],
          );
        case 'solana_signAllTransactions':
          requestUri = _solflareHelper!.buildUriSignAllTransactions(
            transactions: request.params['transactions'],
          );
        case 'solana_signAndSendTransaction':
          requestUri = _solflareHelper!.buildSignAndSendTransactionUri(
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
      onSolflareError.broadcast(SolflareErrorEvent(-1, errorMessage));
      throw ThirdPartyWalletException(errorMessage, e, s);
    }

    return _requestCompleter.future;
  }

  @override
  Future<void> disconnect() async {
    // await _checkInstalled();
    try {
      final disconnectUri = _solflareHelper?.buildDisconnectUri();
      await ReownCoreUtils.openURL(disconnectUri.toString());
    } catch (e, s) {
      final errorMessage = '${walletMetadata.metadata.name} disconnect error';
      _core.logger.e('[$runtimeType] $errorMessage', error: e, stackTrace: s);
      onSolflareError.broadcast(SolflareErrorEvent(-1, errorMessage));
      throw ThirdPartyWalletException(errorMessage, e, s);
    }
  }

  @override
  bool get isInstalled => _solflareWalletData?.installed ?? false;

  @override
  void completeSolflareRequest({required String url}) async {
    final params = Uri.parse(url).queryParameters;
    final payload = await _solflareHelper!.decryptPayload(params);
    final solflareRequest = payload['solflareRequest'];
    _core.logger.d('[$runtimeType] completeSolflareRequest, payload: $payload');

    switch (solflareRequest) {
      case 'connect':
        _onConnectSolflareWallet(payload);
        break;
      case 'disconnect':
        _onDisconnectSolflareWallet(payload);
        break;
      default:
        _onRequestResponse(payload);
        break;
    }
  }

  // Future<bool> _checkInstalled() async {
  //   if (!isInstalled) {
  //     throw ThirdPartyWalletNotInstalled(walletName: 'Solflare Wallet');
  //   }
  //   return true;
  // }

  Future<void> _onConnectSolflareWallet(Map<String, dynamic> payload) async {
    if (payload.containsKey('errorCode')) {
      final errorCode = int.parse(payload['errorCode']);
      final errorMessage = payload['errorMessage'];
      onSolflareError.broadcast(SolflareErrorEvent(errorCode, errorMessage));
      return;
    }

    final data = SolflareData.fromJson(payload).copyWith(
      chainId: _selectedChainId,
      peer: walletMetadata.copyWith(publicKey: await walletPublicKey),
      self: ConnectionMetadata(
        metadata: _metadata,
        publicKey: await dappPublicKey,
      ),
    );
    await _solflareHelper?.persistSession();
    onSolflareConnect.broadcast(SolflareConnectEvent(data));
    _core.logger.i(
      '[$runtimeType] _onConnectSolflareWallet ${jsonEncode(data.toJson())}',
    );
  }

  Future<void> _onDisconnectSolflareWallet(_) async {
    await _core.storage.delete(StorageConstants.solflareSession);
    return _solflareHelper?.resetSharedSecret();
  }

  void _onRequestResponse(Map<String, dynamic> payload) {
    final p = Map<String, dynamic>.from(payload)..remove('solflareRequest');
    _requestCompleter.complete(p);
  }
}
