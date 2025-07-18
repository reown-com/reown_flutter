import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:reown_core/events/i_events_tracker.dart';
import 'package:reown_core/store/generic_store.dart';

class EventsTracker extends GenericStore<List<String>>
    implements IEventsTracker {
  //
  EventsTracker({
    required super.storage,
    required super.context,
    required super.version,
    required super.fromJson,
  });

  static const _key = 'eventsStore';

  @override
  Future<bool> storeEvent(String encodedEvent) async {
    checkInitialized();

    try {
      final decodedEvent = jsonDecode(encodedEvent) as Map<String, dynamic>;
      final eventId = decodedEvent['eventId']! as int;

      final index = getStoredEvents().indexWhere((e) {
        final decodedEvent = jsonDecode(e) as Map<String, dynamic>;
        return decodedEvent['eventId'] == eventId;
      });
      if (index < 0) {
        final newList = List<String>.from([...getStoredEvents(), encodedEvent]);
        await storage.set(_key, {_key: newList});
        debugPrint(
          '[WalletKit] ✅ [Events] tracker: storeEvent. '
          '${_storedValue?.length ?? 0} events stored',
        );
        return true;
      }
    } catch (e) {
      debugPrint('[WalletKit] ❌ [Events] tracker: storeEvent, $_key, $e');
      rethrow;
    }
    return false;
  }

  @override
  Future<bool> clearAll() async {
    checkInitialized();

    try {
      await storage.delete(_key);
      debugPrint('[WalletKit] ✅ [Events] tracker: cleared all events');
      return true;
    } catch (e) {
      debugPrint('[WalletKit] ❌ [Events] tracker: clearAll, $_key, $e');
    }
    return false;
  }

  @override
  Future<bool> clearEvents(List<String> events) async {
    checkInitialized();

    try {
      if (_storedValue != null) {
        final idsToDelete = events.map((event) {
          final decodedEvent = jsonDecode(event) as Map<String, dynamic>;
          return decodedEvent['eventId']! as int;
        }).toList();

        final newList = _storedValue!.where((event) {
          final decodedEvent = jsonDecode(event) as Map<String, dynamic>;
          return !idsToDelete.contains(decodedEvent['eventId']! as int);
        }).toList();

        await storage.set(_key, {_key: newList});
        debugPrint(
          '[WalletKit] ✅ [Events] tracker: ${events.length} events cleared. '
          ' ${_storedValue?.length ?? 0} events stored',
        );
        return true;
      }
    } catch (e) {
      debugPrint('[WalletKit] ❌ [Events] tracker: clearEvents, $_key, $e)');
    }

    return false;
  }

  @override
  List<String> getStoredEvents() {
    checkInitialized();
    try {
      debugPrint(
          '[$runtimeType] [Events] tracker: ${_storedValue?.length} stored events');
      return _storedValue ?? [];
    } catch (_) {
      return [];
    }
  }

  List<String>? get _storedValue {
    if (storage.has(_key)) {
      final storageValue = storage.get(_key)!;
      if (storageValue.keys.contains(_key)) {
        final value = (storageValue[_key] as List);
        final currentList = value.map((e) => '$e').toList();
        return currentList;
      }
    }
    return null;
  }
}
