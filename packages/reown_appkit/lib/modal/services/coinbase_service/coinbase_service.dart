import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

import 'package:reown_appkit/modal/services/coinbase_service/i_coinbase_service.dart';
import 'package:reown_appkit/modal/services/coinbase_service/models/coinbase_data.dart';
import 'package:reown_appkit/modal/services/coinbase_service/models/coinbase_events.dart';

import 'package:coinbase_wallet_sdk/currency.dart';
import 'package:coinbase_wallet_sdk/action.dart';
import 'package:coinbase_wallet_sdk/coinbase_wallet_sdk.dart';
import 'package:coinbase_wallet_sdk/configuration.dart';
import 'package:coinbase_wallet_sdk/eth_web3_rpc.dart';
import 'package:coinbase_wallet_sdk/request.dart';
import 'package:reown_appkit/modal/services/explorer_service/i_explorer_service.dart';
import 'package:reown_appkit/reown_appkit.dart';

class CoinbaseService implements ICoinbaseService {
  static const coinbasePackageName = 'org.toshi';
  static const defaultWalletData = ReownAppKitModalWalletInfo(
    listing: Listing(
      id: 'fd20dc426fb37566d803205b19bbc1d4096b248ac04548e3cfb6b3a38bd033aa',
      name: 'Coinbase Wallet',
      homepage: 'https://www.coinbase.com/wallet/',
      imageId: 'a5ebc364-8f91-4200-fcc6-be81310a0000',
      order: 4110,
      mobileLink: 'cbwallet://wsegue',
      appStore: 'https://apps.apple.com/app/apple-store/id1278383455',
      playStore: 'https://play.google.com/store/apps/details?id=org.toshi',
      // rdns: 'com.coinbase.wallet',
    ),
    installed: false,
    recent: false,
  );

  String _iconImage = '';

  @override
  ConnectionMetadata get metadata => ConnectionMetadata(
        metadata: PairingMetadata(
          name: _walletData.listing.name,
          description: '',
          url: _walletData.listing.homepage,
          icons: [
            _iconImage,
          ],
          redirect: Redirect(
            native: _walletData.listing.mobileLink,
            universal: _walletData.listing.webappLink,
          ),
        ),
        publicKey: '',
      );

  @override
  List<String> get supportedMethods => [
        ...MethodsConstants.requiredMethods,
        'eth_requestAccounts',
        'eth_signTypedData_v3',
        'eth_signTypedData_v4',
        'eth_signTransaction',
        MethodsConstants.walletSwitchEthChain,
        MethodsConstants.walletAddEthChain,
        'wallet_watchAsset',
      ];

  @override
  Event<CoinbaseConnectEvent> onCoinbaseConnect = Event<CoinbaseConnectEvent>();

  @override
  Event<CoinbaseErrorEvent> onCoinbaseError = Event<CoinbaseErrorEvent>();

  @override
  Event<CoinbaseSessionEvent> onCoinbaseSessionUpdate =
      Event<CoinbaseSessionEvent>();

  @override
  Event<CoinbaseResponseEvent> get onCoinbaseResponse =>
      Event<CoinbaseResponseEvent>();

  late final PairingMetadata _metadata;
  late bool _enabled;
  late ReownAppKitModalWalletInfo _walletData;
  late final IReownCore _core;

  IExplorerService get _explorerService => GetIt.I<IExplorerService>();

  CoinbaseService({
    required PairingMetadata metadata,
    required IReownCore core,
    bool enabled = false,
  })  : _metadata = metadata,
        _enabled = enabled,
        _core = core;

  @override
  Future<void> init() async {
    if (!_enabled) return;
    // Configure SDK for each platform

    _walletData =
        (await _explorerService.getCoinbaseWalletObject()) ?? defaultWalletData;
    final imageId = defaultWalletData.listing.imageId;
    _iconImage = _explorerService.getWalletImageUrl(imageId);

    final walletLink = _walletData.listing.mobileLink ?? '';
    final redirect = _metadata.redirect;
    final callback = redirect?.universal ?? redirect?.native ?? '';
    _core.logger.i(
      '[$runtimeType] init with host: ${Uri.parse(walletLink)}, callback: ${Uri.parse(callback)}',
    );
    if (callback.isNotEmpty || walletLink.isNotEmpty) {
      try {
        final config = Configuration(
          ios: IOSConfiguration(
            host: Uri.parse(walletLink),
            callback: Uri.parse(callback),
          ),
          android: AndroidConfiguration(
            domain: Uri.parse(callback),
          ),
        );
        await CoinbaseWalletSDK.shared.configure(config);
      } catch (_) {
        // Silent error
      }
    } else {
      _enabled = false;
      _core.logger.e('[$runtimeType] Initialization error');
      throw CoinbaseServiceException('Initialization error');
    }
  }

  @override
  Future<String> get ownPublicKey async {
    try {
      return await CoinbaseWalletSDK.shared.ownPublicKey();
    } catch (e) {
      _core.logger.e('[$runtimeType] ownPublicKey $e');
      return '';
    }
  }

  @override
  Future<String> get peerPublicKey async {
    try {
      return await CoinbaseWalletSDK.shared.peerPublicKey();
    } catch (e) {
      _core.logger.e('[$runtimeType] peerPublicKey $e');
      return '';
    }
  }

  @override
  Future<void> getAccount() async {
    await _checkInstalled();
    try {
      final results = await CoinbaseWalletSDK.shared.initiateHandshake([
        const RequestAccounts(),
      ]);
      final result = results.first;
      if (result.error != null) {
        final errorCode = result.error?.code;
        final errorMessage = result.error!.message;
        onCoinbaseError.broadcast(CoinbaseErrorEvent(errorMessage));
        throw CoinbaseServiceException('$errorMessage ($errorCode)');
      }

      final data = CoinbaseData.fromJson(result.account!.toJson()).copytWith(
        peer: metadata.copyWith(
          publicKey: await peerPublicKey,
        ),
        self: ConnectionMetadata(
          metadata: _metadata,
          publicKey: await ownPublicKey,
        ),
      );
      onCoinbaseConnect.broadcast(CoinbaseConnectEvent(data));
      _core.logger.i('[$runtimeType] getAccount ${data.toJson()}');
      return;
    } on PlatformException catch (e, s) {
      _core.logger.e('[$runtimeType] getAccount PlatformException $e');
      // Currently Coinbase SDK is not differentiate between User rejection or any other kind of error in iOS
      final errorMessage = (e.message ?? '').toLowerCase();
      onCoinbaseError.broadcast(CoinbaseErrorEvent(errorMessage));
      throw CoinbaseServiceException(errorMessage, e, s);
    } catch (e, s) {
      _core.logger.e('[$runtimeType] getAccount $e');
      onCoinbaseError.broadcast(CoinbaseErrorEvent('Initial handshake error'));
      throw CoinbaseServiceException('Initial handshake error', e, s);
    }
  }

  @override
  Future<dynamic> request({
    required String chainId,
    required SessionRequestParams request,
  }) async {
    await _checkInstalled();
    final cid = chainId.contains(':') ? chainId.split(':').last : chainId;
    _core.logger.i('[$runtimeType] request $chainId, ${request.toJson()}');
    try {
      final req = Request(actions: [request.toCoinbaseRequest(cid)]);
      final result = (await CoinbaseWalletSDK.shared.makeRequest(req)).first;
      if (result.error != null) {
        final errorCode = result.error?.code;
        final errorMessage = result.error!.message;
        onCoinbaseError.broadcast(CoinbaseErrorEvent(errorMessage));
        throw CoinbaseServiceException('$errorMessage ($errorCode)');
      }
      final value = result.value?.replaceAll('"', '');
      switch (req.actions.first.method) {
        case 'wallet_switchEthereumChain':
        case 'wallet_addEthereumChain':
          final event = CoinbaseSessionEvent(chainId: cid);
          onCoinbaseSessionUpdate.broadcast(event);
          break;
        case 'eth_requestAccounts':
          final json = jsonDecode(value!);
          final data = CoinbaseData.fromJson(json).copytWith(
            peer: metadata.copyWith(
              publicKey: await peerPublicKey,
            ),
            self: ConnectionMetadata(
              metadata: _metadata,
              publicKey: await ownPublicKey,
            ),
          );
          onCoinbaseConnect.broadcast(CoinbaseConnectEvent(data));
          break;
        default:
          onCoinbaseResponse.broadcast(CoinbaseResponseEvent(data: value));
          break;
      }
      _core.logger.i('[$runtimeType] request result $value');
      return value;
    } on CoinbaseServiceException catch (e) {
      _core.logger.e('[$runtimeType] request CoinbaseServiceException $e');
      onCoinbaseError.broadcast(CoinbaseErrorEvent(e.message));
      rethrow;
    } on PlatformException catch (e, s) {
      _core.logger.e('[$runtimeType] request PlatformException $e');
      final message = 'Coinbase Wallet Error: (${e.code}) ${e.message}';
      onCoinbaseError.broadcast(CoinbaseErrorEvent(message));
      throw CoinbaseServiceException(message, e, s);
    }
  }

  @override
  Future<bool> isInstalled() async {
    try {
      return await CoinbaseWalletSDK.shared.isAppInstalled();
    } catch (e, s) {
      _core.logger.e('[$runtimeType] isInstalled $e');
      throw CoinbaseServiceException('Check is installed error', e, s);
    }
  }

  @override
  Future<bool> isConnected() async {
    try {
      return await CoinbaseWalletSDK.shared.isConnected();
    } catch (e, s) {
      _core.logger.e('[$runtimeType] isConnected $e');
      throw CoinbaseServiceException('Check is connected error', e, s);
    }
  }

  @override
  Future<void> resetSession() async {
    try {
      return CoinbaseWalletSDK.shared.resetSession();
    } catch (e, s) {
      _core.logger.e('[$runtimeType] resetSession $e');
      throw CoinbaseServiceException('Reset session error', e, s);
    }
  }

  Future<bool> _checkInstalled() async {
    final installed = await isInstalled();
    if (!installed) {
      throw CoinbaseWalletNotInstalledException();
    }
    return true;
  }
}

extension on SessionRequestParams {
  Action toCoinbaseRequest(String? chainId) {
    switch (method) {
      case 'personal_sign':
        final address = _getAddressFromParamsList(method, params);
        final message = _getDataFromParamsList(method, params);
        return PersonalSign(address: address, message: message);
      case 'eth_signTypedData_v3':
        final address = _getAddressFromParamsList(method, params);
        final jsonData = _getDataFromParamsList(method, params);
        return SignTypedDataV3(address: address, typedDataJson: jsonData);
      case 'eth_signTypedData_v4':
        final address = _getAddressFromParamsList(method, params);
        final jsonData = _getDataFromParamsList(method, params);
        return SignTypedDataV4(address: address, typedDataJson: jsonData);
      case 'eth_requestAccounts':
        return RequestAccounts();
      case 'eth_signTransaction':
      case MethodsConstants.ethSendTransaction:
        BigInt? weiValue;
        final jsonData = _getTransactionFromParams(params);
        if (jsonData.containsKey('value')) {
          final hexValue = jsonData['value'].toString().replaceFirst('0x', '');
          final value = int.parse(hexValue, radix: 16);
          weiValue = BigInt.from(value);
        }
        final data = jsonData['data']?.toString();
        if (method == 'eth_signTransaction') {
          return SignTransaction(
            fromAddress: jsonData['from'].toString(),
            toAddress: jsonData['to'].toString(),
            chainId: chainId!,
            weiValue: weiValue,
            data: data,
          );
        }
        return SendTransaction(
          fromAddress: jsonData['from'].toString(),
          toAddress: jsonData['to'].toString(),
          chainId: chainId!,
          weiValue: weiValue,
          data: data,
        );
      case MethodsConstants.walletSwitchEthChain:
      case MethodsConstants.walletAddEthChain:
        try {
          final namespace = ReownAppKitModalNetworks.getNamespaceForChainId(
            chainId!,
          );
          final chainInfo = ReownAppKitModalNetworks.getNetworkById(
            namespace,
            chainId,
          )!;
          return AddEthereumChain(
            chainId: chainInfo.chainId,
            rpcUrls: [chainInfo.rpcUrl],
            chainName: chainInfo.name,
            nativeCurrency: Currency(
              name: chainInfo.currency,
              symbol: chainInfo.currency,
              decimals: 18,
            ),
            iconUrls: [chainInfo.chainIcon!],
            blockExplorerUrls: [
              chainInfo.explorerUrl,
            ],
          );
        } catch (e, s) {
          throw CoinbaseServiceException('Unrecognized chainId $chainId', e, s);
        }
      case 'wallet_watchAsset':
        final address = _getAddressFromParamsList(method, params);
        final symbol = _getDataFromParamsList(method, params);
        return WatchAsset(
          address: address,
          symbol: symbol,
        );
      default:
        throw CoinbaseServiceException('Unsupported request method $method');
    }
  }

  String _getAddressFromParamsList(String method, dynamic params) {
    try {
      final paramsList = List.from((params as List));
      if (method == 'personal_sign') {
        // for `personal_sign` first value in params has to be always the message
        paramsList.removeAt(0);
      }

      return paramsList.firstWhere((p) {
        try {
          EthereumAddress.fromHex(p);
          return true;
        } catch (e) {
          return false;
        }
      });
    } catch (e) {
      rethrow;
    }
  }

  dynamic _getDataFromParamsList(String method, dynamic params) {
    try {
      final paramsList = List.from((params as List));
      if (method == 'personal_sign') {
        return paramsList.first;
      }
      return paramsList.firstWhere((p) {
        final address = _getAddressFromParamsList(method, params);
        return p != address;
      });
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> _getTransactionFromParams(dynamic params) {
    final param = (params as List<dynamic>).first;
    return param as Map<String, dynamic>;
  }
}
