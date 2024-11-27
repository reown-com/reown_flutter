import 'dart:convert';

import 'package:reown_core/i_core_impl.dart';
import 'package:reown_core/relay_client/websocket/i_http_client.dart';
import 'package:reown_core/verify/i_verify.dart';
import 'package:reown_core/verify/models/verify_context.dart';
import 'package:reown_core/utils/constants.dart';

class Verify implements IVerify {
  final IReownCore _core;
  final IHttpClient _httpClient;
  late String _verifyUrl;

  Verify({
    required IReownCore core,
    required IHttpClient httpClient,
  })  : _core = core,
        _httpClient = httpClient;

  @override
  Future<void> init({String? verifyUrl}) async {
    // TODO custom verifyUrl is not yet allowed.
    // Always using walletconnect urls for now
    _verifyUrl = _setVerifyUrl(verifyUrl: verifyUrl);
  }

  @override
  Future<AttestationResponse?> resolve({required String attestationId}) async {
    try {
      final uri = Uri.parse('$_verifyUrl/attestation/$attestationId');
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
    } catch (e) {
      if (e is! AttestationNotFound) {
        _core.logger.e('[$runtimeType] resolve $e');
      }
      rethrow;
    }
  }

  @override
  Validation getValidation(
    AttestationResponse? attestation,
    Uri? metadataUri,
  ) {
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

  String _setVerifyUrl({String? verifyUrl}) {
    String url = verifyUrl ?? ReownConstants.VERIFY_SERVER;

    if (!ReownConstants.TRUSTED_VERIFY_URLS.contains(url)) {
      _core.logger.d(
        '[$runtimeType] verifyUrl $url not included in trusted list, '
        'assigning default: ${ReownConstants.VERIFY_SERVER}',
      );
      url = ReownConstants.VERIFY_SERVER;
    }
    return url;
  }
}
