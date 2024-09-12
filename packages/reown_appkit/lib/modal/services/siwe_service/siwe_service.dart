import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:reown_appkit/modal/constants/string_constants.dart';
import 'package:reown_appkit/modal/services/coinbase_service/coinbase_service_singleton.dart';
import 'package:reown_appkit/modal/services/magic_service/magic_service_singleton.dart';
import 'package:reown_appkit/modal/services/siwe_service/i_siwe_service.dart';
import 'package:reown_appkit/reown_appkit.dart';

class SiweService implements ISiweService {
  late final SIWEConfig? _siweConfig;
  final IReownAppKit _appKit;

  SiweService({
    required IReownAppKit appKit,
    required SIWEConfig? siweConfig,
  })  : _appKit = appKit,
        _siweConfig = siweConfig;

  @override
  SIWEConfig? get config => _siweConfig;

  @override
  bool get enabled => _siweConfig?.enabled == true;

  @override
  int get nonceRefetchIntervalMs =>
      _siweConfig?.nonceRefetchIntervalMs ?? 300000;

  @override
  int get sessionRefetchIntervalMs =>
      _siweConfig?.sessionRefetchIntervalMs ?? 300000;

  @override
  bool get signOutOnAccountChange =>
      _siweConfig?.signOutOnAccountChange ?? true;

  @override
  bool get signOutOnDisconnect => _siweConfig?.signOutOnDisconnect ?? true;

  @override
  bool get signOutOnNetworkChange =>
      _siweConfig?.signOutOnNetworkChange ?? true;

  @override
  Future<String> getNonce() async {
    if (!enabled) throw Exception('siweConfig not enabled');
    //
    return await _siweConfig!.getNonce();
  }

  @override
  Future<String> createMessage({
    required String chainId,
    required String address,
  }) async {
    if (!enabled) throw Exception('siweConfig not enabled');
    //
    final nonce = await getNonce();
    final messageParams = await _siweConfig!.getMessageParams();
    //
    final createMessageArgs = SIWECreateMessageArgs.fromSIWEMessageArgs(
      messageParams,
      address: '$chainId:$address',
      chainId: chainId,
      nonce: nonce,
      type: messageParams.type ?? CacaoHeader(t: 'eip4361'),
    );

    return _siweConfig!.createMessage(createMessageArgs);
  }

  @override
  Future<String> signMessageRequest(
    String message, {
    required ReownAppKitModalSession session,
  }) async {
    if (!enabled) throw Exception('siweConfig not enabled');
    //
    final chainId = AuthSignature.getChainIdFromMessage(message);
    final chainInfo = ReownAppKitModalNetworks.getNetworkById(
      CoreConstants.namespace,
      chainId,
    )!;
    final caip2Chain = '${CoreConstants.namespace}:${chainInfo.chainId}';
    final address = AuthSignature.getAddressFromMessage(message);
    final bytes = utf8.encode(message);
    final encoded = hex.encode(bytes);
    //
    if (session.sessionService.isMagic) {
      return await magicService.instance.request(
        chainId: caip2Chain,
        request: SessionRequestParams(
          method: 'personal_sign',
          params: ['0x$encoded', address],
        ),
      );
    }
    if (session.sessionService.isCoinbase) {
      return await coinbaseService.instance.request(
        chainId: caip2Chain,
        request: SessionRequestParams(
          method: 'personal_sign',
          params: ['0x$encoded', address],
        ),
      );
    }
    return await _appKit.request(
      topic: session.topic!,
      chainId: caip2Chain,
      request: SessionRequestParams(
        method: 'personal_sign',
        params: ['0x$encoded', address],
      ),
    );
  }

  @override
  Future<bool> verifyMessage({
    required String message,
    required String signature,
    Cacao? cacao,
    String? clientId,
  }) async {
    if (!enabled) throw Exception('siweConfig not enabled');
    //
    final verifyArgs = SIWEVerifyMessageArgs(
      message: message,
      signature: signature,
      cacao: cacao,
      clientId: clientId,
    );
    final isValid = await _siweConfig!.verifyMessage(verifyArgs);
    if (!isValid) {
      throw ReownAppKitModalException('Error verifying SIWE signature');
    }
    return true;
  }

  @override
  Future<SIWESession> getSession() async {
    if (!enabled) throw Exception('siweConfig not enabled');
    //
    try {
      final siweSession = await _siweConfig!.getSession();
      if (siweSession == null) {
        throw ReownAppKitModalException('Error getting SIWE session');
      }
      _siweConfig!.onSignIn?.call(siweSession);

      return siweSession;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    if (!enabled) throw Exception('siweConfig not enabled');

    final success = await _siweConfig!.signOut();
    if (!success) {
      throw ReownAppKitModalException('signOut() from siweConfig failed');
    }
    _siweConfig!.onSignOut?.call();
  }

  @override
  String formatMessage(SIWECreateMessageArgs params) {
    final authPayload = SessionAuthPayload.fromJson({
      ...params.toJson(),
      'chains': [params.chainId],
      'aud': params.uri,
      'type': params.type?.t,
    });
    return _appKit.formatAuthMessage(
      iss: 'did:pkh:${params.address}',
      cacaoPayload: CacaoRequestPayload.fromSessionAuthPayload(authPayload),
    );
  }
}
