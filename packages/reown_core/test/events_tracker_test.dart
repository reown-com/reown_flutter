import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:reown_core/events/events.dart';
import 'package:reown_core/events/events_tracker.dart';
import 'package:reown_core/events/i_events.dart';
import 'package:reown_core/events/models/link_mode_events.dart';
import 'package:reown_core/store/i_store.dart';
import 'package:reown_core/store/shared_prefs_store.dart';
import 'events_tracker_test.mocks.dart';
import 'package:reown_core/reown_core.dart';
import 'package:reown_core/events/i_events_tracker.dart';

import 'shared/shared_test_utils.dart';
import 'shared/shared_test_values.dart';

@GenerateMocks([IStore])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  mockPackageInfo();
  mockConnectivity();

  late EventsTracker eventsTracker;
  late MockIStore mockStore;
  const String context = 'test_context';
  const String version = '1.0.0';

  // Create test events
  final event1 = jsonEncode({
    'eventId': 1,
    'type': 'test',
    'properties': {
      'correlation_id': 1,
      'direction': 'sent',
      'method': 'wc_sessionAuthenticate'
    }
  });
  final event2 = jsonEncode({
    'eventId': 2,
    'type': 'test',
    'properties': {
      'correlation_id': 1,
      'direction': 'received',
      'method': 'wc_sessionAuthenticate'
    }
  });
  final event3 = jsonEncode({
    'eventId': 3,
    'type': 'test',
    'properties': {
      'correlation_id': 2,
      'direction': 'sent',
      'method': 'wc_sessionRequest'
    }
  });
  final event4 = jsonEncode({
    'eventId': 4,
    'type': 'test',
    'properties': {
      'correlation_id': 2,
      'direction': 'received',
      'method': 'wc_sessionRequest'
    }
  });

  setUp(() async {
    mockStore = MockIStore();
    eventsTracker = EventsTracker(
      storage: mockStore,
      context: context,
      version: version,
      fromJson: (json) => List<String>.from(json['eventsStore'] ?? []),
    );

    // Setup initialization stubs
    when(mockStore.init()).thenAnswer((_) async {});
    when(mockStore.has(context)).thenReturn(true);
    when(mockStore.get(context)).thenReturn({'version': version});
    when(mockStore.has('$version//$context')).thenReturn(true);
    when(mockStore.get('$version//$context')).thenReturn({});

    await eventsTracker.init();
  });

  tearDownAll(() async {
    await eventsTracker.clearAll();
  });

  group('EventsTracker', () {
    test('should initialize correctly', () {
      expect(eventsTracker.context, context);
      expect(eventsTracker.version, version);
      expect(eventsTracker.storage, mockStore);
    });

    group('storeEvent', () {
      test('should store a new event successfully', () async {
        final event = '{"eventId": 1, "type": "test"}';
        when(mockStore.has('eventsStore')).thenReturn(false);

        final result = await eventsTracker.storeEvent(event);

        expect(result, true);
        verify(mockStore.set('eventsStore', {
          'eventsStore': [event]
        })).called(1);
      });

      test('should not store duplicate event', () async {
        final event = '{"eventId": 1, "type": "test"}';
        when(mockStore.has('eventsStore')).thenReturn(true);
        when(mockStore.get('eventsStore')).thenReturn({
          'eventsStore': [event]
        });

        final result = await eventsTracker.storeEvent(event);

        expect(result, false);
        verifyNever(mockStore.set(any, any));
      });

      test('should handle event storage errors', () async {
        // Try to store an invalid event
        final invalidEvent = 'invalid_json';
        await expectLater(
          eventsTracker.storeEvent(invalidEvent),
          throwsA(isA<Exception>()),
        );

        // Verify no events were stored
        final storedEvents = eventsTracker.getStoredEvents();
        expect(storedEvents, isEmpty);
      });
    });

    group('getStoredEvents', () {
      test('should return stored events', () {
        final events = ['{"eventId": 1}', '{"eventId": 2}'];
        when(mockStore.has('eventsStore')).thenReturn(true);
        when(mockStore.get('eventsStore')).thenReturn({'eventsStore': events});

        final result = eventsTracker.getStoredEvents();

        expect(result, events);
      });

      test('should return empty list when no events stored', () {
        when(mockStore.has('eventsStore')).thenReturn(false);

        final result = eventsTracker.getStoredEvents();

        expect(result, isEmpty);
      });

      test('should handle storage error', () {
        when(mockStore.has('eventsStore'))
            .thenThrow(Exception('Storage error'));

        final result = eventsTracker.getStoredEvents();

        expect(result, isEmpty);
      });
    });

    group('clearEvents', () {
      test('should clear specified events using real storage', () async {
        // Create a real storage instance with memoryStore=true for testing
        final realStore = SharedPrefsStores(memoryStore: true);
        final realEventsTracker = EventsTracker(
          storage: realStore,
          context: context,
          version: version,
          fromJson: (json) => List<String>.from(json['eventsStore'] ?? []),
        );
        await realStore.init();
        await realEventsTracker.init();

        // Store all events
        await realStore.set('eventsStore', {
          'eventsStore': [event1, event2, event3, event4]
        });

        // Clear specific events
        final eventsToClear = [event2, event3, event4];
        final result = await realEventsTracker.clearEvents(eventsToClear);

        // Verify the result
        expect(result, true);

        // Get remaining events from storage
        final remainingEvents =
            realStore.get('eventsStore')?['eventsStore'] as List<dynamic>;
        expect(remainingEvents, hasLength(1));
        expect(remainingEvents[0], event1);

        final allCleared = await realEventsTracker.clearAll();
        expect(allCleared, true);
      });

      test('should clear specified events', () async {
        final eventsToClear = [event2, event3, event4];
        when(mockStore.has('eventsStore')).thenReturn(true);
        when(mockStore.get('eventsStore')).thenReturn({
          'eventsStore': [...eventsToClear, event1]
        });

        final result = await eventsTracker.clearEvents(eventsToClear);

        expect(result, true);
        verify(mockStore.set('eventsStore', {
          'eventsStore': [event1]
        })).called(1);
      });

      test('should handle storage error', () async {
        final eventsToClear = ['{"eventId": 1}'];
        when(mockStore.has('eventsStore')).thenThrow(
          Exception('Storage error'),
        );

        final result = await eventsTracker.clearEvents(eventsToClear);
        expect(result, false);
      });
    });

    group('clearAll', () {
      test('should clear all events', () async {
        when(mockStore.delete('eventsStore')).thenAnswer((_) async {});

        final result = await eventsTracker.clearAll();

        expect(result, true);
        verify(mockStore.delete('eventsStore')).called(1);
      });

      test('should handle storage error', () async {
        when(mockStore.delete('eventsStore')).thenThrow(
          Exception('Storage error'),
        );

        final result = await eventsTracker.clearAll();
        expect(result, false);
      });
    });
  });

  group('EventsTracker with ReownCore', () {
    late IReownCore core;
    late IEvents events;
    late IEventsTracker eventsTracker;

    setUp(() async {
      core = ReownCore(
        relayUrl: TEST_RELAY_URL,
        projectId: TEST_PROJECT_ID,
        memoryStore: true,
        httpClient: getHttpWrapper(),
      );
      eventsTracker = EventsTracker(
        storage: core.storage,
        context: context,
        version: version,
        fromJson: (json) => List<String>.from(json['eventsStore'] ?? []),
      );
      events = Events(
        core: core,
        eventsTracker: eventsTracker,
        httpClient: getHttpWrapper(),
      );
      core.events = events;
      await core.start();
      await eventsTracker.init();
    });

    tearDownAll(() async {
      await eventsTracker.clearAll();
    });

    test('should store and retrieve events using ReownCore', () async {
      // Create test events
      final event1 = LinkModeRequestEvent(
        direction: 'sent',
        correlationId: 1,
        method: 'wc_sessionAuthenticate',
      );
      final event2 = LinkModeRequestEvent(
        direction: 'received',
        correlationId: 1,
        method: 'wc_sessionAuthenticate',
      );

      await eventsTracker.clearAll();

      expect(eventsTracker.getStoredEvents(), <String>[]);

      // Store events using recordEvent instead of sendEvent
      await core.events.recordEvent(event1);
      await core.events.recordEvent(event2);

      // Retrieve stored events
      final storedEvents = eventsTracker.getStoredEvents();
      expect(storedEvents, hasLength(2));

      // Clear specific event
      final result = await eventsTracker.clearEvents([
        storedEvents.first,
      ]);
      expect(result, true);

      // Verify only one event remains
      final remainingEvents = eventsTracker.getStoredEvents();
      expect(remainingEvents, hasLength(1));
      expect(remainingEvents[0], storedEvents.last);

      await eventsTracker.clearAll();

      expect(eventsTracker.getStoredEvents(), <String>[]);
    });
  });
}
