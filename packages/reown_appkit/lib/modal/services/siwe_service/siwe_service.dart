import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:convert/convert.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_appkit/modal/services/coinbase_service/i_coinbase_service.dart';
import 'package:reown_appkit/modal/services/magic_service/i_magic_service.dart';
import 'package:reown_appkit/modal/services/siwe_service/i_siwe_service.dart';
import 'package:reown_appkit/reown_appkit.dart';

class SiweService implements ISiweService {
  IMagicService get _magicService => GetIt.I<IMagicService>();
  ICoinbaseService get _coinbaseService => GetIt.I<ICoinbaseService>();

  late final SIWEConfig? _siweConfig;
  late final IReownAppKit _appKit;
  late final Map<String, RequiredNamespace> _namespaces;

  SiweService({
    required IReownAppKit appKit,
    required SIWEConfig? siweConfig,
    required Map<String, RequiredNamespace> namespaces,
  })  : _appKit = appKit,
        _siweConfig = siweConfig,
        _namespaces = namespaces;

  @override
  SIWEConfig? get config => _siweConfig;

  @override
  bool get enabled {
    // TODO check this logic
    final nonEVM = _namespaces.keys.firstWhereOrNull(
      (k) => k != NetworkUtils.eip155,
    );
    return _siweConfig?.enabled == true && nonEVM == null;
  }

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
    _appKit.core.logger.d('[$runtimeType] getNonce() called');
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

    _appKit.core.logger.d('[$runtimeType] createMessage() called');
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
    final caip2Chain = ReownAppKitModalNetworks.getCaip2Chain(chainId);
    final address = AuthSignature.getAddressFromMessage(message);
    final bytes = utf8.encode(message);
    final encoded = hex.encode(bytes);
    //
    _appKit.core.logger.d('[$runtimeType] signMessageRequest() called');
    if (session.sessionService.isMagic) {
      return await _magicService.request(
        chainId: caip2Chain,
        request: SessionRequestParams(
          method: 'personal_sign',
          params: ['0x$encoded', address],
        ),
      );
    }
    if (session.sessionService.isCoinbase) {
      return await _coinbaseService.request(
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
    _appKit.core.logger.d('[$runtimeType] verifyMessage() called');
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
      _appKit.core.logger.d('[$runtimeType] getSession() called');
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

    _appKit.core.logger.d('[$runtimeType] signOut() called');
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
    _appKit.core.logger.d('[$runtimeType] formatMessage() called');
    return _appKit.formatAuthMessage(
      iss: 'did:pkh:${params.address}',
      cacaoPayload: CacaoRequestPayload.fromSessionAuthPayload(authPayload),
    );
  }
}
