import 'dart:convert';

import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:reown_core/store/i_store.dart';
import 'package:reown_core/utils/constants.dart';
import 'package:reown_core/utils/errors.dart';

class SecureStore implements IStore<Map<String, dynamic>> {
  late final FlutterSecureStorage _secureStorage;
  late final IStore<Map<String, dynamic>> _fallbackStorage;
  bool _initialized = false;
  bool _useFallbackStorage = false;

  final Map<String, Map<String, dynamic>> _map;

  @override
  Map<String, Map<String, dynamic>> get map => _map;

  @override
  List<String> get keys => map.keys.toList();

  @override
  List<Map<String, dynamic>> get values => map.values.toList();

  @override
  String get storagePrefix => ReownConstants.CORE_STORAGE_PREFIX;

  SecureStore({
    Map<String, Map<String, dynamic>>? defaultValue,
    required IStore<Map<String, dynamic>> fallbackStorage,
  }) : _map = defaultValue ?? {},
       _fallbackStorage = fallbackStorage;

  @override
  Future<void> init() async {
    if (_initialized) {
      return;
    }

    try {
      // Try secure storage first
      _secureStorage = const FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true),
        iOptions: IOSOptions(
          accessibility: KeychainAccessibility.first_unlock_this_device,
        ),
      );

      await restore();
    } catch (e) {
      // Fall back to regular storage if secure storage fails
      _useFallbackStorage = true;
      // Try to restore from fallback storage
      await _restoreFromFallback();
    }

    _initialized = true;
  }

  @override
  Map<String, dynamic>? get(String key) {
    _checkInitialized();

    final String keyWithPrefix = _addPrefix(key);
    if (_map.containsKey(keyWithPrefix)) {
      return _map[keyWithPrefix];
    }

    // For secure storage, we can't easily read all keys at once
    // So we'll return null if not in memory, similar to SharedPrefsStores behavior
    return null;
  }

  @override
  bool has(String key) {
    _checkInitialized();
    final String keyWithPrefix = _addPrefix(key);

    // Only check memory for secure storage (can't check secure storage synchronously)
    return _map.containsKey(keyWithPrefix);
  }

  @override
  List<Map<String, dynamic>> getAll() {
    _checkInitialized();
    return values;
  }

  @override
  Future<void> set(String key, Map<String, dynamic> value) async {
    _checkInitialized();

    final String keyWithPrefix = _addPrefix(key);
    _map[keyWithPrefix] = value;

    if (_useFallbackStorage) {
      await _fallbackStorage.set(key, value);
    } else {
      try {
        final stringValue = jsonEncode(value);
        await _secureStorage.write(key: keyWithPrefix, value: stringValue);
      } catch (e) {
        throw Errors.getInternalError(
          Errors.MISSING_OR_INVALID,
          context: e.toString(),
        );
      }
    }
  }

  @override
  Future<void> update(String key, Map<String, dynamic> value) async {
    _checkInitialized();

    final String keyWithPrefix = _addPrefix(key);
    if (!map.containsKey(keyWithPrefix)) {
      throw Errors.getInternalError(Errors.NO_MATCHING_KEY);
    } else {
      _map[keyWithPrefix] = value;
      if (_useFallbackStorage) {
        await _fallbackStorage.update(key, value);
      } else {
        try {
          final stringValue = jsonEncode(value);
          await _secureStorage.write(key: keyWithPrefix, value: stringValue);
        } catch (e) {
          throw Errors.getInternalError(
            Errors.MISSING_OR_INVALID,
            context: e.toString(),
          );
        }
      }
    }
  }

  @override
  Future<void> delete(String key) async {
    _checkInitialized();

    final String keyWithPrefix = _addPrefix(key);
    _map.remove(keyWithPrefix);

    if (_useFallbackStorage) {
      await _fallbackStorage.delete(key);
    } else {
      await _secureStorage.delete(key: keyWithPrefix);
    }
  }

  @override
  Future<void> deleteAll() async {
    _checkInitialized();

    if (_useFallbackStorage) {
      await _fallbackStorage.deleteAll();
    } else {
      // Get all keys from secure storage and delete them
      final allKeys = await _secureStorage.readAll();
      for (final key in allKeys.keys) {
        if (key.startsWith(storagePrefix)) {
          await _secureStorage.delete(key: key);
        }
      }
    }

    _map.clear();
  }

  Future<void> restore() async {
    if (_useFallbackStorage) return;

    try {
      // Get all keys from secure storage
      final allKeys = await _secureStorage.readAll();

      // Restore data to memory map
      for (final entry in allKeys.entries) {
        final key = entry.key;
        final value = entry.value;

        if (key.startsWith(storagePrefix)) {
          try {
            final decodedValue = jsonDecode(value);
            _map[key] = decodedValue;
          } catch (e) {
            // Skip corrupted data
            debugPrint(
              'Warning: Failed to decode secure storage value for key $key: $e',
            );
          }
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _restoreFromFallback() async {
    try {
      // Get all keys from fallback storage
      final allKeys = _fallbackStorage.getAll();

      // Restore data to memory map
      for (final entry in allKeys) {
        final key = entry.keys.first;
        final value = entry.values.first;

        if (key.startsWith(storagePrefix)) {
          _map[key] = value;
        }
      }
    } catch (e) {
      debugPrint('Warning: Failed to restore from fallback storage: $e');
    }
  }

  String _addPrefix(String key) {
    return '$storagePrefix$key';
  }

  void _checkInitialized() {
    if (!_initialized) {
      throw Errors.getInternalError(Errors.NOT_INITIALIZED);
    }
  }
}
