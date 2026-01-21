---
name: flutter-coding
description: Writes high-quality Flutter/Dart code following official conventions and reown-flutter project patterns. Use when writing, reviewing, or refactoring Flutter/Dart code in this codebase.
---

# Flutter Coding Skill

## Goal
Write production-quality Flutter/Dart code that follows official Flutter conventions and reown-flutter project-specific patterns.

## When to use
- Writing new Flutter/Dart classes, functions, or modules
- Implementing features in Flutter codebase
- Refactoring existing Flutter/Dart code
- Code reviews for Flutter/Dart files

## When not to use
- Non-Flutter/Dart codebases (Kotlin, Swift, etc.)
- Configuration files (yaml, json, xml)
- Documentation-only tasks

## Project Context: reown-flutter

**Stack:**
- Dart 3.8.0+, Flutter 1.10.0+
- Multi-platform: Android, iOS, Web, macOS, Linux, Windows
- Code generation: build_runner, freezed, json_serializable
- State management: event package, ValueNotifier, ChangeNotifier
- Networking: http, web_socket_channel
- Storage: flutter_secure_storage, shared_preferences
- Cryptography: ed25519_edwards, x25519, pointycastle, pinenacl
- Testing: flutter_test, mockito, flutter_lints

**Architecture:** Layered Monorepo
```
reown_core (Foundation) → reown_sign (Protocol) → reown_walletkit/reown_appkit (Application)
```

## Default Workflow

1. **Understand context** - Read existing code in the module
2. **Follow existing patterns** - Match the module's conventions
3. **Write minimal code** - Only what's needed for the task
4. **Run code generation** - Execute `generate_files.sh` if models changed
5. **Add tests** - Match existing test patterns
6. **Validate** - Run through checklist below

## Core Patterns

### Interface-Based Design
```dart
// Public API via interface
abstract class ISignClient {
  Future<void> connect(ConnectParams params);
  Stream<SignClientEvent> get events;
}

// Internal implementation
class SignClient implements ISignClient {
  // Implementation details
}
```

### Immutable Models with Freezed
```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'session.freezed.dart';
part 'session.g.dart';

@freezed
class Session with _$Session {
  const factory Session({
    required String topic,
    required String pairingTopic,
    required Map<String, Namespace> namespaces,
    @JsonKey(name: 'expiry') required int expiry,
  }) = _Session;

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);
}
```

### JSON Serialization
```dart
import 'package:json_annotation/json_annotation.dart';

part 'request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SessionRequest {
  final int id;
  final String topic;
  final RequestParams params;

  SessionRequest({
    required this.id,
    required this.topic,
    required this.params,
  });

  factory SessionRequest.fromJson(Map<String, dynamic> json) =>
      _$SessionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SessionRequestToJson(this);
}
```

### Event-Driven Architecture
```dart
import 'package:event/event.dart';

class SignClient {
  final Event<SignClientEvent> _events = Event<SignClientEvent>();
  
  Event<SignClientEvent> get events => _events;
  
  void _emitEvent(SignClientEvent event) {
    _events.broadcast(event);
  }
}

// Usage
signClient.events.listen((event) {
  if (event is SessionProposalEvent) {
    // Handle proposal
  }
});
```

### Error Handling
```dart
// Custom exception hierarchy
class WalletConnectException implements Exception {
  final String message;
  final dynamic cause;
  
  WalletConnectException(this.message, [this.cause]);
  
  @override
  String toString() => 'WalletConnectException: $message';
}

class InvalidSessionException extends WalletConnectException {
  InvalidSessionException(String message) : super(message);
}

// Result pattern with try-catch
Future<Result<Session>> connect(ConnectParams params) async {
  try {
    final session = await _establishSession(params);
    return Result.success(session);
  } on InvalidSessionException catch (e) {
    return Result.failure(e);
  } catch (e, stackTrace) {
    _logger.error('Connection failed', error: e, stackTrace: stackTrace);
    return Result.failure(WalletConnectException('Connection failed', e));
  }
}
```

### Async/Await Best Practices
```dart
// Prefer async/await over Future.then
Future<Session> connect(ConnectParams params) async {
  final pairing = await _createPairing(params);
  final uri = await _generateUri(pairing);
  return await _waitForApproval(pairing);
}

// Use Future.wait for parallel operations
Future<List<Balance>> fetchBalances(List<String> addresses) async {
  final futures = addresses.map((addr) => _fetchBalance(addr));
  return await Future.wait(futures);
}

// Handle timeouts
Future<Response> fetchWithTimeout(String url) async {
  return await http.get(Uri.parse(url))
      .timeout(const Duration(seconds: 10));
}
```

### State Management
```dart
// ValueNotifier for simple state
class ConnectionState {
  final ValueNotifier<bool> isConnected = ValueNotifier(false);
  final ValueNotifier<String?> currentTopic = ValueNotifier(null);
}

// Usage in widget
ValueListenableBuilder<bool>(
  valueListenable: connectionState.isConnected,
  builder: (context, isConnected, child) {
    return Text(isConnected ? 'Connected' : 'Disconnected');
  },
);

// ChangeNotifier for complex state
class SessionManager extends ChangeNotifier {
  List<Session> _sessions = [];
  
  List<Session> get sessions => List.unmodifiable(_sessions);
  
  void addSession(Session session) {
    _sessions.add(session);
    notifyListeners();
  }
}
```

### Storage Pattern
```dart
// Secure storage with fallback
class SecureStore {
  final FlutterSecureStorage _secureStorage;
  final SharedPreferences _fallback;
  
  Future<String?> read(String key) async {
    try {
      return await _secureStorage.read(key: key);
    } catch (e) {
      // Fallback to shared preferences
      return _fallback.getString(key);
    }
  }
  
  Future<void> write(String key, String value) async {
    try {
      await _secureStorage.write(key: key, value: value);
    } catch (e) {
      // Fallback to shared preferences
      await _fallback.setString(key, value);
    }
  }
}
```

### Dependency Injection
```dart
// Constructor injection
class SignClient {
  final IRelayClient relayClient;
  final IStorage storage;
  final Logger logger;
  
  SignClient({
    required this.relayClient,
    required this.storage,
    required this.logger,
  });
}

// Factory pattern for complex initialization
class SignClientFactory {
  static Future<SignClient> create({
    required String projectId,
    Logger? logger,
  }) async {
    final core = ReownCore(projectId: projectId);
    final storage = await SecureStore.create();
    return SignClient(
      relayClient: core.relayClient,
      storage: storage,
      logger: logger ?? Logger(),
    );
  }
}
```

### Logging
```dart
import 'package:logger/logger.dart';

class SignClient {
  final Logger _logger;
  
  SignClient({Logger? logger}) 
    : _logger = logger ?? Logger(level: Level.info);
  
  void _logInfo(String message) {
    _logger.i(message);
  }
  
  void _logError(String message, {Object? error, StackTrace? stackTrace}) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
}
```

## Naming Conventions

| Type | Convention | Example |
|------|------------|---------|
| Classes | `PascalCase` | `SignClient`, `SessionManager` |
| Interfaces | `I*` prefix | `ISignClient`, `IStorage` |
| Variables/Functions | `camelCase` | `connectSession`, `currentTopic` |
| Constants | `lowerCamelCase` or `SCREAMING_SNAKE_CASE` | `defaultRelayUrl`, `MAX_RETRIES` |
| Files | `snake_case.dart` | `sign_client.dart`, `session_manager.dart` |
| Private members | `_leadingUnderscore` | `_internalState`, `_processEvent()` |
| Freezed models | `*` suffix for factory | `Session`, `_Session` (generated) |

## Code Generation

### Freezed Models
```dart
// Always run after modifying freezed models
dart run build_runner build --delete-conflicting-outputs
```

### JSON Serialization
```dart
// Generate after adding @JsonSerializable
dart run build_runner build --delete-conflicting-outputs
```

### Generate All
```bash
# From package root
sh generate_files.sh
```

## Testing Pattern
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([IRelayClient, IStorage])
void main() {
  late SignClient signClient;
  late MockIRelayClient mockRelayClient;
  late MockIStorage mockStorage;

  setUp(() {
    mockRelayClient = MockIRelayClient();
    mockStorage = MockIStorage();
    signClient = SignClient(
      relayClient: mockRelayClient,
      storage: mockStorage,
    );
  });

  group('SignClient', () {
    test('connect creates pairing and returns URI', () async {
      // Given
      when(mockRelayClient.createPairing(any))
          .thenAnswer((_) async => Pairing(topic: 'test-topic'));

      // When
      final uri = await signClient.connect(ConnectParams());

      // Then
      expect(uri, isNotNull);
      verify(mockRelayClient.createPairing(any)).called(1);
    });
  });
}
```

## Validation Checklist

- [ ] Uses interfaces for public APIs (`I*` prefix)
- [ ] Models use `@freezed` for immutability
- [ ] JSON models use `@JsonSerializable` with `fieldRename: FieldRename.snake`
- [ ] All generated files are up-to-date (run `generate_files.sh`)
- [ ] Error handling with custom exceptions
- [ ] Async operations use `async/await` (not `.then()`)
- [ ] Logging uses `logger` package (not `print`)
- [ ] Storage uses secure storage with fallback
- [ ] Tests use `mockito` with `@GenerateMocks`
- [ ] Code formatted with `dart format`
- [ ] No linter errors (`flutter analyze`)
- [ ] Line length ≤ 80 characters (preferred)
- [ ] Private members use `_` prefix
- [ ] Constants are properly scoped
- [ ] UI components use widgets, not functions (no `Widget _buildX()` methods)

## Flutter-Specific Patterns

### Widget Composition
```dart
// Prefer composition over large widgets
class SessionList extends StatelessWidget {
  final List<Session> sessions;

  const SessionList({required this.sessions, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: sessions.length,
      itemBuilder: (context, index) => SessionTile(session: sessions[index]),
    );
  }
}

// Private widget for reusable UI
class _SessionTile extends StatelessWidget {
  final Session session;

  const _SessionTile({required this.session});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(session.topic),
      subtitle: Text('Expires: ${session.expiry}'),
    );
  }
}
```

### Avoid Functions for UI - Use Widgets Instead
**IMPORTANT:** Never use functions to return UI components. Always use `StatelessWidget` or `StatefulWidget` classes instead.

Functions for UI are problematic because:
- They don't benefit from Flutter's widget rebuild optimizations
- They can't be `const` constructed
- They don't appear in widget inspector/devtools
- They're not reusable across files
- They don't support widget keys properly

```dart
// BAD - Don't use functions for UI
class MyPage extends StatelessWidget {
  Widget _buildHeader() {
    return Container(
      child: Text('Header'),
    );
  }

  Widget _buildContent() {
    return Column(children: [...]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        _buildContent(),
      ],
    );
  }
}

// GOOD - Use widget classes instead
class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _Header(),
        _Content(),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text('Header'),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return Column(children: [...]);
  }
}
```

### Const Constructors
```dart
// Use const where possible
const SessionTile({required this.session});

// In build methods
return const SizedBox(height: 16);
```

### Platform-Specific Code
```dart
import 'dart:io' show Platform;

if (Platform.isAndroid) {
  // Android-specific code
} else if (Platform.isIOS) {
  // iOS-specific code
}
```

## Examples

### Example 1: New Model with Freezed

**Task:** Create a session proposal model

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'session_proposal.freezed.dart';
part 'session_proposal.g.dart';

@freezed
class SessionProposal with _$SessionProposal {
  const factory SessionProposal({
    required int id,
    required ProposalParams params,
    @JsonKey(name: 'expiry') required int expiry,
  }) = _SessionProposal;

  factory SessionProposal.fromJson(Map<String, dynamic> json) =>
      _$SessionProposalFromJson(json);
}

@freezed
class ProposalParams with _$ProposalParams {
  const factory ProposalParams({
    required AppMetadata proposer,
    required Map<String, Namespace> requiredNamespaces,
    Map<String, Namespace>? optionalNamespaces,
  }) = _ProposalParams;

  factory ProposalParams.fromJson(Map<String, dynamic> json) =>
      _$ProposalParamsFromJson(json);
}
```

### Example 2: Service with Error Handling

**Task:** Create a service to fetch chain metadata

```dart
class ChainMetadataService {
  final IHttpClient httpClient;
  final Logger logger;
  
  ChainMetadataService({
    required this.httpClient,
    Logger? logger,
  }) : logger = logger ?? Logger();
  
  Future<Result<ChainMetadata>> fetchMetadata(String chainId) async {
    try {
      final response = await httpClient.get(
        Uri.parse('https://api.example.com/chains/$chainId'),
      ).timeout(const Duration(seconds: 10));
      
      if (response.statusCode == 200) {
        final metadata = ChainMetadata.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>,
        );
        return Result.success(metadata);
      } else {
        return Result.failure(
          HttpException('Failed to fetch metadata: ${response.statusCode}'),
        );
      }
    } on TimeoutException {
      logger.e('Timeout fetching chain metadata');
      return Result.failure(TimeoutException('Request timed out'));
    } catch (e, stackTrace) {
      logger.e('Error fetching chain metadata', 
        error: e, 
        stackTrace: stackTrace,
      );
      return Result.failure(
        WalletConnectException('Failed to fetch metadata', e),
      );
    }
  }
}
```

### Example 3: Event-Driven Component

**Task:** Create a component that listens to session events

```dart
class SessionListener {
  final ISignClient signClient;
  final Event<SessionEvent> _sessionEvents = Event<SessionEvent>();
  
  Event<SessionEvent> get sessionEvents => _sessionEvents;
  
  SessionListener({required this.signClient}) {
    _setupListeners();
  }
  
  void _setupListeners() {
    signClient.events.listen((event) {
      if (event is SessionProposalEvent) {
        _sessionEvents.broadcast(SessionProposalReceived(event.proposal));
      } else if (event is SessionApprovedEvent) {
        _sessionEvents.broadcast(SessionApproved(event.session));
      } else if (event is SessionDeletedEvent) {
        _sessionEvents.broadcast(SessionDeleted(event.topic));
      }
    });
  }
}
```

## References

- [Flutter Official Rules](https://raw.githubusercontent.com/flutter/flutter/refs/heads/main/docs/rules/rules.md)
- [Effective Dart](https://dart.dev/effective-dart)
- [Flutter Style Guide](https://github.com/flutter/flutter/wiki/Style-guide-for-Flutter-repo)
- [Freezed Documentation](https://pub.dev/packages/freezed)
- [json_serializable Documentation](https://pub.dev/packages/json_serializable)
