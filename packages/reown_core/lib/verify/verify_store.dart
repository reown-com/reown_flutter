import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:reown_core/store/generic_store.dart';
import 'package:reown_core/verify/i_verify_store.dart';
import 'package:reown_core/verify/models/jwk.dart';

class VerifyStore extends GenericStore<String> implements IVerifyStore {
  VerifyStore({
    required super.storage,
    required super.context,
    required super.version,
    required super.fromJson,
  });

  static const _key = 'verifyStore';

  @override
  JWK? getItem() {
    try {
      return JWK.fromJson(jsonDecode(get(_key)!));
    } catch (e) {
      debugPrint('[$runtimeType] getItem error: $e');
      return null;
    }
  }

  @override
  Future<void> removeItem() async {
    try {
      await delete(_key);
    } catch (e) {
      debugPrint('[$runtimeType] removeItem error: $e');
    }
  }

  @override
  Future<void> setItem(JWK jwk) async {
    try {
      await set(_key, jsonEncode(jwk.toJson()));
    } catch (e) {
      debugPrint('[$runtimeType] setItem error: $e');
    }
  }
}
