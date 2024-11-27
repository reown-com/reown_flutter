import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:reown_appkit/modal/utils/core_utils.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:uuid/uuid.dart';
import 'package:reown_appkit/modal/constants/string_constants.dart';
import 'package:reown_appkit/modal/services/analytics_service/i_analytics_service.dart';
import 'package:reown_appkit/modal/services/analytics_service/models/analytics_event.dart';

class AnalyticsService implements IAnalyticsService {
  static final _eventsController = StreamController<dynamic>.broadcast();
  static const _debugApiEndpoint =
      'https://analytics-api-cf-workers-staging.walletconnect-v1-bridge.workers.dev';
  static const _debugProjectId = 'e087b4b0503b860119be49d906717c12';
  //
  bool _isEnabled = false;
  late final String _bundleId;
  late final String _endpoint;
  late final Map<String, String> _headers;

  @override
  final Stream<dynamic> events = _eventsController.stream;

  @override
  final bool? enableAnalytics;

  late final IReownCore _core;

  AnalyticsService({
    required IReownCore core,
    this.enableAnalytics,
  }) {
    _core = core;
    _endpoint = kDebugMode ? _debugApiEndpoint : UrlConstants.analyticsService;
    _headers = kDebugMode
        ? CoreUtils.getAPIHeaders(_debugProjectId)
        : CoreUtils.getAPIHeaders(_core.projectId);
  }

  @override
  Future<void> init() async {
    try {
      if (enableAnalytics == null) {
        _isEnabled = await fetchAnalyticsConfig();
      } else {
        _isEnabled = enableAnalytics!;
      }
      _bundleId = await ReownCoreUtils.getPackageName();
      _core.logger.i('[$runtimeType] enabled: $_isEnabled');
    } catch (e, _) {
      _core.logger.e('[$runtimeType] init error', error: e);
    }
  }

  @override
  Future<bool> fetchAnalyticsConfig() async {
    try {
      final response = await http.get(
        Uri.parse('${UrlConstants.apiService}/getAnalyticsConfig'),
        headers: _headers,
      );
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final enabled = json['isAnalyticsEnabled'] as bool?;
      _core.logger.i('[$runtimeType] fetch result $enabled');
      return enabled ?? false;
    } catch (e, s) {
      _core.logger.e('[$runtimeType] fetch error', error: e, stackTrace: s);
      return false;
    }
  }

  @override
  void sendEvent(AnalyticsEvent analyticsEvent) async {
    if (!_isEnabled) return;
    try {
      final body = jsonEncode({
        'eventId': Uuid().v4(),
        'bundleId': _bundleId,
        'timestamp': DateTime.now().toUtc().millisecondsSinceEpoch,
        'props': analyticsEvent.toMap(),
      });

      final response = await http.post(
        Uri.parse('$_endpoint/e'),
        headers: _headers,
        body: body,
      );
      final code = response.statusCode;
      if (code == 200 || code == 202) {
        _eventsController.sink.add(analyticsEvent.toMap());
      }
      _core.logger.i('[$runtimeType] send event $code: $body');
    } catch (e, _) {
      _core.logger.e('[$runtimeType] send event error', error: e);
    }
  }
}
