import 'dart:convert';
import 'package:reown_core/events/i_events_tracker.dart';
import 'package:reown_core/pairing/utils/json_rpc_utils.dart';

import 'package:reown_core/events/i_events.dart';
import 'package:reown_core/events/models/basic_event.dart';
import 'package:reown_core/relay_client/websocket/i_http_client.dart';
import 'package:reown_core/reown_core.dart';

class Events implements IEvents {
  final IReownCore _core;
  final IHttpClient _httpClient;

  String? _bundleId;
  String? _clientId;
  Map<String, String>? _params;

  Map<String, String> get _requiredParams => {
        'st': 'events_sdk',
        'sv': ReownCoreUtils.coreSdkVersion(packageVersion),
      };

  IEventsTracker eventsTracker;

  Events({
    required IReownCore core,
    required IHttpClient httpClient,
    required this.eventsTracker,
  })  : _core = core,
        _httpClient = httpClient;

  @override
  Future<void> init() async {
    _bundleId = await ReownCoreUtils.getPackageName();
    _clientId = await _core.crypto.getClientId();
    _params = {'projectId': _core.projectId, ..._requiredParams};

    await eventsTracker.init();

    _sendStoredEvents();
  }

  @override
  Future<void> sendEvent(BasicCoreEvent event) async {
    final url = Uri.parse('${ReownConstants.EVENTS_SERVER}/e').replace(
      queryParameters: _params,
    );
    try {
      final body = _encodeEventToSend(event);
      final response = await _httpClient.post(url, body: body);
      final code = response.statusCode;
      if (code == 200 || code == 202) {
        _core.logger.i('[$runtimeType] ✅ ${event.runtimeType} $code: $body');
      } else {
        _core.logger.e(
          '[$runtimeType] ❌ ${event.runtimeType} $code: ${response.body}',
        );
        await recordEvent(event);
      }
    } catch (e, _) {
      _core.logger.e('[$runtimeType] ❌ ${event.runtimeType} error $e');
    }
  }

  @override
  Future<void> sendEventBatch(List<BasicCoreEvent> events) async {
    try {
      final encodedEvents = events.map((event) {
        final encodedEvent = _encodeEventToSend(event);
        return encodedEvent;
      }).toList();

      await _sendBatchEvents(encodedEvents);
    } catch (e, _) {
      _core.logger.e('[$runtimeType] ❌ send batch events error $e');
    }
  }

  @override
  Future<void> recordEvent(BasicCoreEvent event) async {
    try {
      final encodedEvent = _encodeEventToSend(event);
      await eventsTracker.storeEvent(encodedEvent);
      _core.logger.d('[$runtimeType] store event $encodedEvent');
    } catch (e) {
      _core.logger.e('[$runtimeType] storeEvent $e');
    }
  }

  Future<void> _sendStoredEvents() async {
    final storedEvents = eventsTracker.getStoredEvents().take(500).toList();
    if (storedEvents.isNotEmpty) {
      _core.logger
          .d('[$runtimeType] ${storedEvents.length} storedEvents found');
      try {
        await _sendBatchEvents(storedEvents);
        await eventsTracker.clearEvents(storedEvents);
      } catch (e) {
        _core.logger.e('[$runtimeType] ❌ send batch events error: $e');
      }
    } else {
      _core.logger.d('[$runtimeType] no events stored');
    }
  }

  Future<void> _sendBatchEvents(List<String> events) async {
    final url = Uri.parse('${ReownConstants.EVENTS_SERVER}/batch').replace(
      queryParameters: _params,
    );
    try {
      final body = events.toString();
      final response = await _httpClient.post(url, body: body);
      final code = response.statusCode;
      if (code == 200 || code == 202) {
        _core.logger.i('[$runtimeType] ✅ send batch ${events.length} events');
        return;
      }
      throw Exception('$code: ${response.body}');
    } catch (e) {
      rethrow;
    }
  }

  String _encodeEventToSend(BasicCoreEvent event) {
    try {
      final properties = CoreEventProperties.fromJson(
        event.properties?.toJson() ?? {},
      ).copyWith(client_id: _clientId);

      return jsonEncode({
        'eventId': JsonRpcUtils.payloadId(),
        'bundleId': _bundleId,
        'timestamp': DateTime.now().toUtc().millisecondsSinceEpoch,
        'props': {
          ...event.toJson(),
          if (event.properties != null) 'properties': {...properties.toJson()}
        },
      });
    } catch (e) {
      rethrow;
    }
  }
}
