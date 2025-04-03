import 'package:reown_core/events/i_events.dart';
import 'package:reown_core/events/models/basic_event.dart';

abstract class IAnalyticsService extends IEvents {
  @override
  Future<void> init({String? eventsUrl});

  @override
  Future<void> sendEvent(BasicCoreEvent event);
}
