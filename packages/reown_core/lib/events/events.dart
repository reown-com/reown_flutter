import 'dart:convert';
import 'package:reown_core/relay_client/websocket/http_client.dart';
import 'package:uuid/uuid.dart';

import 'package:reown_core/events/i_events.dart';
import 'package:reown_core/events/models/basic_event.dart';
import 'package:reown_core/relay_client/websocket/i_http_client.dart';
import 'package:reown_core/reown_core.dart';

class Events implements IEvents {
  late final IHttpClient _httpClient;
  late final String _bundleId;
  late final String _clientId;
  late final String _endpoint;
  late final Map<String, String> _params;

  Map<String, String> get _requiredParams => {
        'st': 'events_sdk',
        'sv': ReownCoreUtils.coreSdkVersion(packageVersion),
      };

  final IReownCore core;

  Events({required this.core, IHttpClient? httpClient}) {
    _httpClient = const HttpWrapper();
  }

  @override
  Future<void> init({String? eventsUrl}) async {
    _endpoint = eventsUrl ?? ReownConstants.EVENTS_SERVER;
    _params = {'projectId': core.projectId, ..._requiredParams};
    _bundleId = await ReownCoreUtils.getPackageName();
    _clientId = await core.crypto.getClientId();
    core.logger.i('[$runtimeType] event init');
  }

  @override
  Future<void> sendEvent(BasicCoreEvent event) async {
    try {
      final properties = CoreEventProperties.fromJson(
        event.properties?.toJson() ?? {},
      ).copyWith(client_id: _clientId);

      final body = jsonEncode({
        'eventId': Uuid().v4().toUpperCase(),
        'bundleId': _bundleId,
        'timestamp': DateTime.now().toUtc().millisecondsSinceEpoch,
        'props': {
          ...event.toMap(),
          if (event.properties != null) 'properties': {...properties.toJson()}
        },
      });

      final url = Uri.parse('$_endpoint/e').replace(queryParameters: _params);
      final response = await _httpClient.post(url, body: body);
      final code = response.statusCode;
      if (code == 200 || code == 202) {
        core.logger.i('[$runtimeType] ✅ ${event.runtimeType} $code: $body');
      } else {
        core.logger.i(
          '[$runtimeType] ❌ ${event.runtimeType} $code: ${response.body}',
        );
      }
    } catch (e, _) {
      core.logger.e('[$runtimeType] ❌ ${event.runtimeType} error $e');
    }
  }

  @override
  Future<void> sendEventBatch(List<BasicCoreEvent> events) async {
    try {
      final body = events.map((event) {
        final properties = CoreEventProperties.fromJson(
          event.properties?.toJson() ?? {},
        ).copyWith(client_id: _clientId);
        final body = jsonEncode({
          'eventId': Uuid().v4().toUpperCase(),
          'bundleId': _bundleId,
          'timestamp': DateTime.now().toUtc().millisecondsSinceEpoch,
          'props': {
            ...event.toMap(),
            if (event.properties != null) 'properties': {...properties.toJson()}
          },
        });
        return body;
      }).toList();

      final response = await _httpClient.post(
        Uri.parse('$_endpoint/batch'),
        // headers: _headers,
        body: jsonEncode(body),
      );
      final code = response.statusCode;
      if (code == 200 || code == 202) {
        core.logger.i('[$runtimeType] ✅ send event batch $code: $body');
      } else {
        core.logger.i('[$runtimeType] ❌ send event batch $code: $body');
      }
    } catch (e, _) {
      core.logger.e('[$runtimeType] send event batch error $e');
    }
  }
}
