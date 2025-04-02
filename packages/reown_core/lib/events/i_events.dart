import 'package:reown_core/events/models/basic_event.dart';

abstract class IEvents {
  Future<void> init({String? eventsUrl});
  Future<void> sendEvent(BasicCoreEvent event);
  Future<void> sendEventBatch(List<BasicCoreEvent> events);
}
