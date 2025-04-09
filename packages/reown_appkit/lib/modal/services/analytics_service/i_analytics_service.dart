import 'package:reown_core/events/models/basic_event.dart';

abstract class IAnalyticsService {
  Future<void> init({String? eventsUrl});
  Future<void> sendEvent(BasicCoreEvent event);
}
