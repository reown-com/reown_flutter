/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'dart:async' show Completer, FutureOr;

/// Safe Completer
/// ------------------------------------------------------------------------------------------------

/// A wrapper around [Completer] that ensures the completer is resolved with [Completer.complete] or
/// [Completer.completeError] at most once.
class SafeCompleter<T> implements Completer<T> {
  /// Creates A wrapper around [Completer] that ensures the completer is resolved with
  /// [Completer.complete] or [Completer.completeError] at most once.
  SafeCompleter._(this._completer);

  /// Creates a safe completer by calling [Completer].
  factory SafeCompleter() => SafeCompleter<T>._(Completer<T>());

  /// Creates a safe completer by calling [Completer.sync].
  factory SafeCompleter.sync() => SafeCompleter<T>._(Completer<T>.sync());

  /// The underlying completer.
  final Completer<T> _completer;

  @override
  void complete([final FutureOr<T>? value]) {
    if (!isCompleted) _completer.complete(value);
  }

  @override
  void completeError(final Object error, [final StackTrace? stackTrace]) {
    if (!isCompleted) _completer.completeError(error, stackTrace);
  }

  @override
  Future<T> get future => _completer.future;

  @override
  bool get isCompleted => _completer.isCompleted;
}
