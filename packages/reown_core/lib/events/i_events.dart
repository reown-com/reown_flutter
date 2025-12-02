import 'package:reown_core/events/models/basic_event.dart';

abstract class IEvents {
  Future<void> init();
  void setQueryParams(Map<String, String> queryParams);
  Future<void> sendEvent(BasicCoreEvent event);
  Future<void> sendEventBatch(List<BasicCoreEvent> events);
  Future<void> recordEvent(BasicCoreEvent event);
  Future<void> sendStoredEvents();
}
