import 'package:reown_appkit/modal/services/analytics_service/models/analytics_event.dart';

abstract class IAnalyticsService {
  bool? get enableAnalytics;
  Stream<dynamic> get events;
  Future<void> init();
  void sendEvent(AnalyticsEvent analyticsEvent);
  Future<bool> fetchAnalyticsConfig();
}
