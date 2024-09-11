import 'package:reown_appkit/modal/services/analytics_service/i_analytics_service.dart';

class AnalyticsServiceSingleton {
  late IAnalyticsService instance;
}

final analyticsService = AnalyticsServiceSingleton();
