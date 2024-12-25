import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reown_appkit/reown_appkit.dart';

part 'appkit_siwe_config.g.dart';
part 'appkit_siwe_config.freezed.dart';

/// Object to pass to [siweConfig:] parameter of ReownAppKitModal to enable or disable One-Click Auth + SIWE
class SIWEConfig {
  final Future<String> Function() getNonce;
  final Future<SIWEMessageArgs> Function() getMessageParams;
  final String Function(SIWECreateMessageArgs args) createMessage;
  final Future<bool> Function(SIWEVerifyMessageArgs args) verifyMessage;
  final Future<SIWESession?> Function() getSession;
  final Future<bool> Function() signOut;
  // Callback when user signs in
  final Function(SIWESession session)? onSignIn;
  // Callback when user signs out
  final VoidCallback? onSignOut;
  // Defaults to true
  final bool enabled;
  // In milliseconds, defaults to 5 minutes
  final int nonceRefetchIntervalMs;
  // In milliseconds, defaults to 5 minutes
  final int sessionRefetchIntervalMs;
  // Defaults to true
  final bool signOutOnDisconnect;
  // Defaults to true
  final bool signOutOnAccountChange;
  // Defaults to true
  final bool signOutOnNetworkChange;
  //

  SIWEConfig({
    required this.getNonce,
    required this.getMessageParams,
    required this.createMessage,
    required this.verifyMessage,
    required this.getSession,
    required this.signOut,
    this.onSignIn,
    this.onSignOut,
    this.enabled = true,
    this.signOutOnDisconnect = true,
    this.signOutOnAccountChange = true,
    this.signOutOnNetworkChange = true,
    this.nonceRefetchIntervalMs = 300000,
    this.sessionRefetchIntervalMs = 300000,
  });

  @override
  String toString() {
    return 'SIWEConfig(enabled: $enabled, signOutOnDisconnect: $signOutOnDisconnect, signOutOnAccountChange: $signOutOnAccountChange, signOutOnNetworkChange: $signOutOnNetworkChange, nonceRefetchIntervalMs: $nonceRefetchIntervalMs, sessionRefetchIntervalMs: $sessionRefetchIntervalMs)';
  }
}

@freezed
class SIWECreateMessageArgs with _$SIWECreateMessageArgs {
  const factory SIWECreateMessageArgs({
    required String chainId,
    required String domain,
    required String nonce,
    required String uri,
    required String address,
    @Default('1') String version,
    @Default(CacaoHeader(t: 'eip4361')) CacaoHeader? type,
    String? nbf,
    String? exp,
    String? statement,
    String? requestId,
    List<String>? resources,
    int? expiry,
    String? iat,
  }) = _SIWECreateMessageArgs;

  factory SIWECreateMessageArgs.fromSIWEMessageArgs(
    SIWEMessageArgs params, {
    required String address,
    required String chainId,
    required String nonce,
    required CacaoHeader type,
  }) {
    final now = DateTime.now();
    return SIWECreateMessageArgs(
      chainId: chainId,
      nonce: nonce,
      address: address,
      version: '1',
      iat: params.iat ??
          DateTime.utc(
            now.year,
            now.month,
            now.day,
            now.hour,
            now.minute,
            now.second,
            now.millisecond,
          ).toIso8601String(),
      domain: params.domain,
      uri: params.uri,
      type: type,
      nbf: params.nbf,
      exp: params.exp,
      statement: params.statement,
      requestId: params.requestId,
      resources: params.resources,
      expiry: params.expiry,
    );
  }

  factory SIWECreateMessageArgs.fromJson(Map<String, dynamic> json) =>
      _$SIWECreateMessageArgsFromJson(json);
}

@freezed
class SIWEMessageArgs with _$SIWEMessageArgs {
  const factory SIWEMessageArgs({
    required String domain,
    required String uri,
    @Default(CacaoHeader(t: 'eip4361')) CacaoHeader? type,
    String? nbf,
    String? exp,
    String? statement,
    String? requestId,
    List<String>? resources,
    int? expiry,
    String? iat,
    List<String>? methods,
  }) = _SIWEMessageArgs;

  factory SIWEMessageArgs.fromJson(Map<String, dynamic> json) =>
      _$SIWEMessageArgsFromJson(json);
}

@freezed
class SIWEVerifyMessageArgs with _$SIWEVerifyMessageArgs {
  const factory SIWEVerifyMessageArgs({
    required String message,
    required String signature,
    Cacao? cacao, // for One-Click Auth
    String? clientId, // Not really used in mobile platforms
  }) = _SIWEVerifyMessageArgs;

  factory SIWEVerifyMessageArgs.fromJson(Map<String, dynamic> json) =>
      _$SIWEVerifyMessageArgsFromJson(json);
}

@freezed
class SIWESession with _$SIWESession {
  const factory SIWESession({
    required String address,
    required List<String> chains,
  }) = _SIWESession;

  factory SIWESession.fromJson(Map<String, dynamic> json) =>
      _$SIWESessionFromJson(json);

  @override
  String toString() => 'SIWESession($address, $chains)';
}
