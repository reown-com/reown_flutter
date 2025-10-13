import 'package:flutter/foundation.dart';
import 'package:reown_core/store/generic_store.dart';
import 'package:reown_core/verify/i_verify_store.dart';
import 'package:reown_core/verify/models/jwk.dart';

class VerifyStore extends GenericStore<Map<String, dynamic>>
    implements IVerifyStore {
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
      if (storage.has(_key)) {
        final storedValue = storage.get(_key);
        return JWK.fromJson(storedValue!);
      }
      return null;
    } catch (e) {
      debugPrint('❌ [$runtimeType] getItem error: $e');
      return null;
    }
  }

  @override
  Future<void> removeItem() async {
    try {
      await storage.delete(_key);
      debugPrint('✅ [$runtimeType] removeItem $_key');
    } catch (e) {
      debugPrint('❌ [$runtimeType] removeItem error: $e');
    }
  }

  @override
  Future<void> setItem(JWK jwk) async {
    try {
      await storage.set(_key, jwk.toJson());
    } catch (e) {
      debugPrint('❌ [$runtimeType] setItem error: $e');
    }
  }
}
