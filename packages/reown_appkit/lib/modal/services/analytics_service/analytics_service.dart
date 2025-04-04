import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:reown_appkit/modal/utils/core_utils.dart';
import 'package:reown_core/events/events.dart';
import 'package:reown_core/events/models/basic_event.dart';
import 'package:reown_appkit/modal/constants/string_constants.dart';
import 'package:reown_appkit/modal/services/analytics_service/i_analytics_service.dart';

class AnalyticsService extends Events implements IAnalyticsService {
  bool? _enableAnalytics;

  AnalyticsService({
    required super.core,
    bool? enableAnalytics,
  }) {
    _enableAnalytics = enableAnalytics;
  }

  @override
  Future<void> init({String? eventsUrl}) async {
    if (_enableAnalytics == null) {
      try {
        _enableAnalytics = await _fetchAnalyticsConfig();
      } catch (e) {
        super.core.logger.e('[$runtimeType] event init error $e');
        _enableAnalytics = false;
      }
    } else {
      _enableAnalytics = _enableAnalytics ?? false;
    }
    super.core.logger.i('[$runtimeType] enabled: $_enableAnalytics');
    return super.init(eventsUrl: eventsUrl);
  }

  @override
  Future<void> sendEvent(BasicCoreEvent event) async {
    // we don't send analytics events if user opts-out
    // core such as LinkMode-related events are still send by Core SDK
    if (_enableAnalytics == false) return;
    return super.sendEvent(event);
  }

  Future<bool> _fetchAnalyticsConfig() async {
    try {
      final response = await http.get(
        Uri.parse('${UrlConstants.apiService}/getAnalyticsConfig'),
        headers: CoreUtils.getAPIHeaders(super.core.projectId),
      );
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final enabled = json['isAnalyticsEnabled'] as bool?;
      super.core.logger.i('[$runtimeType] fetch result $enabled');
      return enabled ?? false;
    } catch (e, s) {
      super.core.logger.e('[$runtimeType] fetch error $e', stackTrace: s);
      return false;
    }
  }
}
