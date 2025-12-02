import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:reown_appkit/modal/utils/core_utils.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:reown_core/events/models/basic_event.dart';
import 'package:reown_appkit/modal/constants/string_constants.dart';
import 'package:reown_appkit/modal/services/analytics_service/i_analytics_service.dart';

class AnalyticsService implements IAnalyticsService {
  bool? _enableAnalytics;
  late final IReownCore _core;

  AnalyticsService({required IReownCore core, bool? enableAnalytics}) {
    _core = core;
    _enableAnalytics = enableAnalytics;
  }

  @override
  bool get isEnabled => _enableAnalytics ?? false;

  @override
  Future<void> init({String? eventsUrl}) async {
    if (_enableAnalytics == null) {
      try {
        _enableAnalytics = await _fetchAnalyticsConfig();
      } catch (e) {
        _core.logger.e('[$runtimeType] event init error $e');
        _enableAnalytics = false;
      }
    } else {
      _enableAnalytics = _enableAnalytics ?? false;
    }
    await sendStoredEvents();
    _core.logger.i('[$runtimeType] enabled: $_enableAnalytics');
  }

  @override
  Future<void> sendStoredEvents() async {
    if (_enableAnalytics == false) return;

    final queryParams = CoreUtils.getApiQueryParams(_core.projectId);
    _core.events.setQueryParams(queryParams);
    await _core.events.sendStoredEvents();
  }

  @override
  Future<void> sendEvent(BasicCoreEvent event) async {
    // we don't send analytics events if user opts-out
    // core such as LinkMode-related events are still send by Core SDK
    if (_enableAnalytics == false) return;
    return _core.events.sendEvent(event);
  }

  @override
  Future<void> storeEvent(BasicCoreEvent event) async {
    // we don't send analytics events if user opts-out
    // core such as LinkMode-related events are still send by Core SDK
    if (_enableAnalytics == false) return;
    return _core.events.recordEvent(event);
  }

  Future<bool> _fetchAnalyticsConfig() async {
    try {
      final response = await http.get(
        Uri.parse('${UrlConstants.apiService}/getAnalyticsConfig'),
        headers: CoreUtils.getAPIHeaders(_core.projectId),
      );
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final enabled = json['isAnalyticsEnabled'] as bool?;
      _core.logger.i('[$runtimeType] fetch result $enabled');
      return enabled ?? false;
    } catch (e, s) {
      _core.logger.e('[$runtimeType] fetch error $e', stackTrace: s);
      return false;
    }
  }
}
