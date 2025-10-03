import 'dart:convert';

import 'package:reown_core/i_core_impl.dart';
import 'package:reown_core/relay_client/websocket/i_http_client.dart';
import 'package:reown_core/verify/i_verify.dart';
import 'package:reown_core/verify/i_verify_store.dart';
import 'package:reown_core/verify/jwt_validation.dart';
import 'package:reown_core/verify/models/jwk.dart';
import 'package:reown_core/verify/models/verify_context.dart';
import 'package:reown_core/utils/constants.dart';

class Verify implements IVerify {
  final IReownCore _core;
  final IHttpClient _httpClient;
  final IVerifyStore _verifyStore;
  JWK? _publicKey;

  static final String _verifyUrl = ReownConstants.VERIFY_SERVER;
  static final String _verifyUrlV2 = '$_verifyUrl/v2';

  Verify({
    required IReownCore core,
    required IHttpClient httpClient,
    required IVerifyStore verifyStore,
  }) : _core = core,
       _httpClient = httpClient,
       _verifyStore = verifyStore;

  @override
  Future<void> init() async {
    _core.logger.d('[$runtimeType] init');
    await _verifyStore.init();
    await checkPublicKey();
  }

  @override
  Future<AttestationResponse?> resolve({
    required String attestationId,
    required String? attestationJWT,
  }) async {
    try {
      // resolve v2
      final v2Response = await resolveV2(attestationId, attestationJWT);
      if (v2Response != null) {
        return v2Response;
      }

      // resolve v1
      final uri = Uri.parse(
        '$_verifyUrl/attestation/$attestationId?v2Supported=true',
      );
      _core.logger.d('[$runtimeType] resolve attestationId: $attestationId');
      final response = await _httpClient.get(uri).timeout(Duration(seconds: 5));
      if (response.statusCode == 404 || response.body.isEmpty) {
        throw AttestationNotFound(
          code: 404,
          message: 'Attestion for this dapp could not be found',
        );
      }
      if (response.statusCode != 200) {
        throw Exception('Attestation response error: ${response.statusCode}');
      }
      return AttestationResponse.fromJson(jsonDecode(response.body));
    } catch (e, s) {
      if (e is! AttestationNotFound) {
        _core.logger.e('[$runtimeType] resolve error: $e, $s');
      }
      rethrow;
    }
  }

  @override
  Validation getValidation(AttestationResponse? attestation, Uri? metadataUri) {
    if (attestation?.isScam == true) {
      return Validation.SCAM;
    }

    if ((attestation?.origin ?? '').isEmpty ||
        (metadataUri?.origin ?? '').isEmpty) {
      return Validation.INVALID;
    }

    return attestation!.origin == metadataUri!.origin
        ? Validation.VALID
        : Validation.INVALID;
  }
}

extension VerifyV2 on Verify {
  Future<String?> register({
    required String id,
    required String decryptedId,
  }) async {
    throw UnimplementedError();
  }

  Future<AttestationResponse?> resolveV2(
    String attestationId,
    String? attestationJWT,
  ) async {
    if ((attestationJWT ?? '').isNotEmpty) {
      _core.logger.d('[$runtimeType] resolve attestationJWT: $attestationJWT');
      final response = await isValidJwtAttestation(
        attestationId,
        attestationJWT!,
      );
      return response;
    }
    return null;
  }

  Future<void> checkPublicKey() async {
    _publicKey = getPersistedPublicKey();
    if (_publicKey != null && _publicKey!.isExpired()) {
      _core.logger.d('[$runtimeType] verify v2 public key has expired');
      await removePublicKey();
    } else {
      _core.logger.d('[$runtimeType] verify v2 publicKey is still valid');
    }
    if (_publicKey == null) {
      await fetchAndPersistPublicKey();
    }
  }

  Future<JWK?> fetchPublicKey() async {
    try {
      final url = Uri.parse('${Verify._verifyUrlV2}/public-key');
      _core.logger.d('[$runtimeType] fetching public key from $url');
      final response = await _httpClient.get(url).timeout(Duration(seconds: 5));
      final pk = JWK.fromJson(jsonDecode(response.body));
      final expDate = DateTime.fromMillisecondsSinceEpoch(pk.expiresAt * 1000);
      _core.logger.d('[$runtimeType] public key fetched: ${pk.toJson()}');
      _core.logger.d('[$runtimeType] public key expires on: $expDate');
      return pk;
    } catch (e) {
      _core.logger.e('[$runtimeType] fetching public error: $e');
    }
    return null;
  }

  JWK? getPersistedPublicKey() => _verifyStore.getItem();

  Future<void> persistPublicKey(JWK key) async {
    _core.logger.d('[$runtimeType] persisting public key: ${key.toJson()}');
    await _verifyStore.setItem(key);
    _publicKey = key;
  }

  Future<void> removePublicKey() async {
    _core.logger.d('[$runtimeType] removing verify v2 public key');
    await _verifyStore.removeItem();
    _publicKey = null;
  }

  Future<AttestationResponse?> isValidJwtAttestation(
    String attestationId,
    String attestationJWT,
  ) async {
    final key = await getPublicKey();
    _core.logger.d('[$runtimeType] validating v2 public key: ${key?.toJson()}');
    try {
      if (key != null) {
        final claims = validateAttestation(attestationJWT, key);
        _core.logger.d('[$runtimeType] claims: $claims');
        return AttestationResponse(
          origin: claims.origin,
          attestationId: attestationId,
          isScam: claims.isScam,
        );
      }
    } catch (e) {
      _core.logger.e('[$runtimeType] error validating attestation: $e');
    }

    final newKey = await fetchAndPersistPublicKey();
    try {
      if (newKey != null) {
        final claims = validateAttestation(attestationJWT, newKey);
        _core.logger.d('[$runtimeType] claims: $claims');
        return AttestationResponse(
          origin: claims.origin,
          attestationId: attestationId,
          isScam: claims.isScam,
        );
      }
    } catch (e) {
      _core.logger.e('[$runtimeType] error validating attestation: $e');
    }
    return null;
  }

  Future<JWK?> getPublicKey() async {
    if (_publicKey != null) return _publicKey;
    return await fetchAndPersistPublicKey();
  }

  Future<JWK?> fetchAndPersistPublicKey() async {
    try {
      final key = await fetchPublicKey();
      if (key == null) return null;
      await persistPublicKey(key);
      return key;
    } catch (e) {
      _core.logger.e('[$runtimeType] fetch and persist public key error, $e');
    }
    return null;
  }

  VerifyClaims validateAttestation(String attestation, JWK key) {
    final isValid = JWTValidator.verifyES256JWT(attestation, key.toBytes());
    // invalid, expired
    if (isValid) {
      final Map<String, dynamic> claims = JWTValidator.decodeClaimsJWT(
        attestation,
      );
      final verifyClaims = VerifyClaims.fromJson(claims);
      if (verifyClaims.isExpired()) {
        throw StateError('JWT attestation expired');
      }
      return verifyClaims;
    }
    throw StateError('Invalid JWT attestation');
  }
}
