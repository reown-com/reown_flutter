import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

import 'package:reown_appkit/modal/services/explorer_service/i_explorer_service.dart';
import 'package:reown_appkit/modal/services/phantom_service/i_phantom_service.dart';
import 'package:reown_appkit/modal/services/phantom_service/models/phantom_events.dart';
import 'package:reown_appkit/modal/services/phantom_service/phantom_helper.dart';
import 'package:reown_appkit/reown_appkit.dart';

class PhantomService implements IPhantomService {
  static const phantomPackageName = 'app.phantom';
  static const defaultWalletData = ReownAppKitModalWalletInfo(
    listing: Listing(
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
  List<String> get supportedMethods =>
      NetworkUtils.defaultNetworkMethods['solana']!.toList();

  @override
  Event<PhantomConnectEvent> onPhantomConnect = Event<PhantomConnectEvent>();

  @override
  Event<PhantomErrorEvent> onPhantomError = Event<PhantomErrorEvent>();

  @override
  Event<PhantomSessionEvent> onPhantomSessionUpdate =
      Event<PhantomSessionEvent>();

  @override
  Event<PhantomResponseEvent> get onPhantomResponse =>
      Event<PhantomResponseEvent>();

  late final PairingMetadata _metadata;
  // late bool _enabled;
  late ReownAppKitModalWalletInfo _walletData;
  late final IReownCore _core;
  // late final solana.Ed25519Keypair _keyPair;
  late final PhantomHelper _phantomHelper;

  IExplorerService get _explorerService => GetIt.I<IExplorerService>();

  PhantomService({
    required PairingMetadata metadata,
    required IReownCore core,
    // bool enabled = false,
  })  : _metadata = metadata,
        // _enabled = enabled,
        _core = core;

  @override
  Future<void> init() async {
    // if (!_enabled) return;
    // Configure SDK for each platform

    _walletData = defaultWalletData;
    // _walletData =
    //     (await _explorerService.getPhantomWalletObject()) ?? defaultWalletData;
    final imageId = defaultWalletData.listing.imageId;
    _iconImage = _explorerService.getWalletImageUrl(imageId);

    // final keyPair = _core.crypto.getUtils().generateKeyPair();
    // final publicKey = utf8.encode(keyPair.publicKey);
    // _keyPair = nacl.sign.keypair.sync();

    final redirect =
        (_metadata.redirect?.universal ?? _metadata.redirect?.native)!;
    _phantomHelper = PhantomHelper(
      appUrl: _metadata.url,
      redirectLink: redirect,
    );
  }

  @override
  Future<String> get ownPublicKey async => _phantomHelper.publicKey;

  @override
  Future<String> get peerPublicKey async => _phantomHelper.solanaAddress;

  @override
  Future<void> getAccount() async {
    await _checkInstalled();
    try {
      final phantomUri = _phantomHelper.buildConnectionUri();
      print('[$runtimeType] $phantomUri');
      await ReownCoreUtils.openURL(phantomUri.toString());
    } on PlatformException catch (e, s) {
      _core.logger.e('[$runtimeType] getAccount PlatformException $e');
      // Currently Phantom SDK is not differentiate between User rejection or any other kind of error in iOS
      final errorMessage = (e.message ?? '').toLowerCase();
      onPhantomError.broadcast(PhantomErrorEvent(errorMessage));
      throw PhantomServiceException(errorMessage, e, s);
    } catch (e, s) {
      _core.logger.e('[$runtimeType] getAccount $e');
      onPhantomError.broadcast(PhantomErrorEvent('Initial handshake error'));
      throw PhantomServiceException('Initial handshake error', e, s);
    }
  }

  @override
  void completePhantomRequest({required String url}) async {
    final params = Uri.parse(url).queryParameters;
    final request = ReownCoreUtils.getSearchParamFromURL(
      url,
      'phantomRequest',
    );

    final payload = _phantomHelper.decryptPayload(params: params);
    print('[$runtimeType] payload $payload');

    if (request == 'connect') {
      // TODO create session
      final signMessageUri = _phantomHelper.buildSignMessageUri(
        message: 'Sign this message',
      );
      print('[$runtimeType] $signMessageUri');
      await ReownCoreUtils.openURL(signMessageUri.toString());
    }
  }

  @override
  Future<dynamic> request({
    required String chainId,
    required SessionRequestParams request,
  }) async {
    // await _checkInstalled();
    // final cid = chainId.contains(':') ? chainId.split(':').last : chainId;
    // _core.logger.i('[$runtimeType] request $chainId, ${request.toJson()}');
    // try {
    //   final req = Request(actions: [request.toPhantomRequest(cid)]);
    //   final result = (await PhantomWalletSDK.shared.makeRequest(req)).first;
    //   if (result.error != null) {
    //     final errorCode = result.error?.code;
    //     final errorMessage = result.error!.message;
    //     onPhantomError.broadcast(PhantomErrorEvent(errorMessage));
    //     throw PhantomServiceException('$errorMessage ($errorCode)');
    //   }
    //   final value = result.value?.replaceAll('"', '');
    //   switch (req.actions.first.method) {
    //     case 'wallet_switchEthereumChain':
    //     case 'wallet_addEthereumChain':
    //       final event = PhantomSessionEvent(chainId: cid);
    //       onPhantomSessionUpdate.broadcast(event);
    //       break;
    //     case 'eth_requestAccounts':
    //       final json = jsonDecode(value!);
    //       final data = PhantomData.fromJson(json).copytWith(
    //         peer: metadata.copyWith(
    //           publicKey: await peerPublicKey,
    //         ),
    //         self: ConnectionMetadata(
    //           metadata: _metadata,
    //           publicKey: await ownPublicKey,
    //         ),
    //       );
    //       onPhantomConnect.broadcast(PhantomConnectEvent(data));
    //       break;
    //     default:
    //       onPhantomResponse.broadcast(PhantomResponseEvent(data: value));
    //       break;
    //   }
    //   _core.logger.i('[$runtimeType] request result $value');
    //   return value;
    // } on PhantomServiceException catch (e) {
    //   _core.logger.e('[$runtimeType] request PhantomServiceException $e');
    //   onPhantomError.broadcast(PhantomErrorEvent(e.message));
    //   rethrow;
    // } on PlatformException catch (e, s) {
    //   _core.logger.e('[$runtimeType] request PlatformException $e');
    //   final message = 'Phantom Wallet Error: (${e.code}) ${e.message}';
    //   onPhantomError.broadcast(PhantomErrorEvent(message));
    //   throw PhantomServiceException(message, e, s);
    // }
  }

  @override
  Future<bool> isInstalled() async {
    return true;
    // try {
    //   return await PhantomWalletSDK.shared.isAppInstalled();
    // } catch (e, s) {
    //   _core.logger.e('[$runtimeType] isInstalled $e');
    //   throw PhantomServiceException('Check is installed error', e, s);
    // }
  }

  @override
  Future<bool> isConnected() async {
    return false;
    // try {
    //   return await PhantomWalletSDK.shared.isConnected();
    // } catch (e, s) {
    //   _core.logger.e('[$runtimeType] isConnected $e');
    //   throw PhantomServiceException('Check is connected error', e, s);
    // }
  }

  @override
  Future<void> resetSession() async {
    // try {
    //   return PhantomWalletSDK.shared.resetSession();
    // } catch (e, s) {
    //   _core.logger.e('[$runtimeType] resetSession $e');
    //   throw PhantomServiceException('Reset session error', e, s);
    // }
  }

  Future<bool> _checkInstalled() async {
    final installed = await isInstalled();
    if (!installed) {
      throw PhantomWalletNotInstalledException();
    }
    return true;
  }
}

// extension on SessionRequestParams {
//   Action toPhantomRequest(String? chainId) {
//     switch (method) {
//       case 'personal_sign':
//         final address = _getAddressFromParamsList(method, params);
//         final message = _getDataFromParamsList(method, params);
//         return PersonalSign(address: address, message: message);
//       case 'eth_signTypedData_v3':
//         final address = _getAddressFromParamsList(method, params);
//         final jsonData = _getDataFromParamsList(method, params);
//         return SignTypedDataV3(address: address, typedDataJson: jsonData);
//       case 'eth_signTypedData_v4':
//         final address = _getAddressFromParamsList(method, params);
//         final jsonData = _getDataFromParamsList(method, params);
//         return SignTypedDataV4(address: address, typedDataJson: jsonData);
//       case 'eth_requestAccounts':
//         return RequestAccounts();
//       case 'eth_signTransaction':
//       case MethodsConstants.ethSendTransaction:
//         BigInt? weiValue;
//         final jsonData = _getTransactionFromParams(params);
//         if (jsonData.containsKey('value')) {
//           final hexValue = jsonData['value'].toString().replaceFirst('0x', '');
//           final value = int.parse(hexValue, radix: 16);
//           weiValue = BigInt.from(value);
//         }
//         final data = jsonData['data']?.toString();
//         if (method == 'eth_signTransaction') {
//           return SignTransaction(
//             fromAddress: jsonData['from'].toString(),
//             toAddress: jsonData['to'].toString(),
//             chainId: chainId!,
//             weiValue: weiValue,
//             data: data,
//           );
//         }
//         return SendTransaction(
//           fromAddress: jsonData['from'].toString(),
//           toAddress: jsonData['to'].toString(),
//           chainId: chainId!,
//           weiValue: weiValue,
//           data: data,
//         );
//       case MethodsConstants.walletSwitchEthChain:
//       case MethodsConstants.walletAddEthChain:
//         try {
//           final namespace = ReownAppKitModalNetworks.getNamespaceForChainId(
//             chainId!,
//           );
//           final chainInfo = ReownAppKitModalNetworks.getNetworkById(
//             namespace,
//             chainId,
//           )!;
//           return AddEthereumChain(
//             chainId: chainInfo.chainId,
//             rpcUrls: [chainInfo.rpcUrl],
//             chainName: chainInfo.name,
//             nativeCurrency: Currency(
//               name: chainInfo.currency,
//               symbol: chainInfo.currency,
//               decimals: 18,
//             ),
//             iconUrls: [chainInfo.chainIcon!],
//             blockExplorerUrls: [
//               chainInfo.explorerUrl,
//             ],
//           );
//         } catch (e, s) {
//           throw PhantomServiceException('Unrecognized chainId $chainId', e, s);
//         }
//       case 'wallet_watchAsset':
//         final address = _getAddressFromParamsList(method, params);
//         final symbol = _getDataFromParamsList(method, params);
//         return WatchAsset(
//           address: address,
//           symbol: symbol,
//         );
//       default:
//         throw PhantomServiceException('Unsupported request method $method');
//     }
//   }

//   String _getAddressFromParamsList(String method, dynamic params) {
//     try {
//       final paramsList = List.from((params as List));
//       if (method == 'personal_sign') {
//         // for `personal_sign` first value in params has to be always the message
//         paramsList.removeAt(0);
//       }

//       return paramsList.firstWhere((p) {
//         try {
//           EthereumAddress.fromHex(p);
//           return true;
//         } catch (e) {
//           return false;
//         }
//       });
//     } catch (e) {
//       rethrow;
//     }
//   }

//   dynamic _getDataFromParamsList(String method, dynamic params) {
//     try {
//       final paramsList = List.from((params as List));
//       if (method == 'personal_sign') {
//         return paramsList.first;
//       }
//       return paramsList.firstWhere((p) {
//         final address = _getAddressFromParamsList(method, params);
//         return p != address;
//       });
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Map<String, dynamic> _getTransactionFromParams(dynamic params) {
//     final param = (params as List<dynamic>).first;
//     return param as Map<String, dynamic>;
//   }
// }
