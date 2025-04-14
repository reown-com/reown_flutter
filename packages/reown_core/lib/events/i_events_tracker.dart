import 'package:reown_core/store/i_generic_store.dart';

abstract class IEventsTracker implements IGenericStore<List<String>> {
  Future<bool> storeEvent(String event);
  List<String> getStoredEvents();
  Future<bool> clearAll();
  Future<bool> clearEvents(List<String> events);
}
