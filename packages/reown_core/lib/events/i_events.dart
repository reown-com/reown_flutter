import 'package:reown_core/events/models/basic_event.dart';

abstract class IEvents {
  Future<void> init();
  Future<void> sendEvent(BasicCoreEvent event);
  Future<void> sendEventBatch(List<BasicCoreEvent> events);
  Future<void> recordEvent(BasicCoreEvent event);
}
