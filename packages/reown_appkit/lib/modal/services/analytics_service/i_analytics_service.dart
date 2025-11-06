import 'package:reown_core/events/models/basic_event.dart';

abstract class IAnalyticsService {
  bool get isEnabled;
  Future<void> init({String? eventsUrl});
  Future<void> sendStoredEvents();
  Future<void> sendEvent(BasicCoreEvent event);
  Future<void> storeEvent(BasicCoreEvent event);
}
