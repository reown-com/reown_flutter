import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:reown_appkit/modal/utils/core_utils.dart';

import 'package:reown_appkit_example/utils/dart_defines.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SIWESampleWebService {
  Map<String, String>? _headers;

  SIWESampleWebService() {
    _headers = {
      ...CoreUtils.getAPIHeaders(
        DartDefines.appKitProjectId,
      ),
      'Content-Type': 'application/json',
    };
  }

  Future<void> _checkHeaders() async {
    final instance = await SharedPreferences.getInstance();
    final headers = instance.getString('appkit_siwe_headers');
    if (headers != null) {
      _headers = {
        ...(jsonDecode(headers) as Map<String, dynamic>),
        'Content-Type': 'application/json',
      };
    }
  }

  Future<void> _persistHeaders() async {
    final instance = await SharedPreferences.getInstance();
    await instance.setString('appkit_siwe_headers', jsonEncode(_headers));
  }

  Future<Map<String, dynamic>> getNonce() async {
    try {
      final response = await http.get(
        Uri.parse('${DartDefines.authApiUrl}/auth/v1/nonce'),
        headers: _headers,
      );
      debugPrint('[SIWESERVICE] getNonce() => ${response.body}');
      final nonceRes = jsonDecode(response.body) as Map<String, dynamic>;
      final newToken = nonceRes['token'] as String;
      _headers!['Authorization'] = 'Bearer $newToken';
      await _persistHeaders();
      // Persist the newToken so it can be used again with getSession() even if the user terminated the app
      return nonceRes;
    } catch (error) {
      debugPrint('[SIWESERVICE] ⛔️ getNonce() => ${error.toString()}');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getSession() async {
    try {
      await _checkHeaders();
      final response = await http.get(
        Uri.parse('${DartDefines.authApiUrl}/auth/v1/me'),
        headers: _headers,
      );
      debugPrint('[SIWESERVICE] getSession() => ${response.body}');
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (error) {
      debugPrint('[SIWESERVICE] ⛔️ getSession() => ${error.toString()}');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> verifyMessage(
    Map<String, dynamic> payload, {
    required String domain,
  }) async {
    try {
      final uri = Uri.parse('${DartDefines.authApiUrl}/auth/v1/authenticate');
      final response = await http.post(
        uri.replace(queryParameters: {'domain': domain}),
        headers: _headers,
        body: jsonEncode(payload),
      );
      debugPrint('[SIWESERVICE] verifyMessage() => ${response.body}');
      final authenticateRes = jsonDecode(response.body) as Map<String, dynamic>;
      final newToken = authenticateRes['token'] as String;
      _headers!['Authorization'] = 'Bearer $newToken';
      await _persistHeaders();
      // Persist the newToken so it can be used again with getSession() even if the user terminated the app
      return authenticateRes;
    } catch (error) {
      debugPrint('[SIWESERVICE] ⛔️ verifyMessage() => ${error.toString()}');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> updateUser(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('${DartDefines.authApiUrl}/auth/v1/update-user'),
        headers: _headers,
        body: json.encode({'metadata': data}),
      );
      debugPrint('[SIWESERVICE] updateUser() => ${response.body}');
      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (error) {
      debugPrint('[SIWESERVICE] ⛔️ updateUser() => ${error.toString()}');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> signOut() async {
    try {
      final response = await http.post(
        Uri.parse('${DartDefines.authApiUrl}/auth/v1/sign-out'),
        headers: _headers,
      );
      debugPrint('[SIWESERVICE] signOut() => ${response.body}');
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      _headers = {
        ...CoreUtils.getAPIHeaders(
          DartDefines.appKitProjectId,
        ),
        'Content-Type': 'application/json',
      };
      await _persistHeaders();
      return result;
    } catch (error) {
      debugPrint('[SIWESERVICE] ⛔️ signOut() => ${error.toString()}');
      rethrow;
    }
  }
}
