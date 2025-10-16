import 'package:flutter/foundation.dart';
import 'package:reown_core/events/models/basic_event.dart';
import 'package:reown_core/utils/method_constants.dart';

abstract class LinkModeEvent implements BasicCoreEvent {
  final int _correlationId;
  final String _direction;

  LinkModeEvent({required String direction, required int correlationId})
    : _direction = direction,
      _correlationId = correlationId;

  @override
  String get event => CoreEventType.SUCCESS;

  @override
  CoreEventProperties? get properties => CoreEventProperties(
    correlation_id: _correlationId,
    direction: _direction,
  );

  @override
  Map<String, dynamic> toJson() => {
    'type': type,
    'event': event,
    if (properties != null) 'properties': properties?.toJson(),
  };
}

///
/// Link Mode Authenticate/Session requests
/// Covers tags 1122 and 1125
///
@protected
class LinkModeRequestEvent extends LinkModeEvent {
  final String method;
  LinkModeRequestEvent({
    required this.method,
    required super.direction,
    required super.correlationId,
  });

  @override
  String get type {
    final linkModeMethod = '${method}_linkMode';
    return MethodConstants.LM_OPTS[linkModeMethod]!['req']!.tag.toString();
  }
}

///
/// Link Mode Authenticate/Session responses
/// Covers tags 1123,1124 and 1126
///
@protected
class LinkModeResponseEvent extends LinkModeEvent {
  final String method;
  final bool isRejected;
  LinkModeResponseEvent({
    required this.method,
    required super.direction,
    required super.correlationId,
    this.isRejected = false,
  });

  @override
  String get type {
    final linkModeMethod = '${method}_linkMode';
    if (isRejected) {
      return MethodConstants.LM_OPTS[linkModeMethod]!['reject']!.tag.toString();
    }
    return MethodConstants.LM_OPTS[linkModeMethod]!['res']!.tag.toString();
  }
}
