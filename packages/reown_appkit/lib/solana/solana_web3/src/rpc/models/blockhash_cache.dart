/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'dart:async';
import 'package:reown_appkit/solana/solana_jsonrpc/jsonrpc.dart'
    show Commitment;
import '../../constants/timing.dart';
import '../../exceptions/transaction_exception.dart';
import '../../rpc/http_connection.dart';
import '../../types.dart';
import '../configs/get_latest_blockhash_config.dart';
import 'blockhash_with_expiry_block_height.dart';

/// Blockhash Cache
/// ------------------------------------------------------------------------------------------------

class BlockhashCache {
  /// Stores the latest `blockhash` fetched from [HttpConnection.getLatestBlockhash].
  BlockhashCache({this.timeout = const Duration(seconds: 30)});

  /// The cached [value]'s expiration time.
  final Duration timeout;

  /// The simulated transactions signatures made using the cached [value].
  final List<String> simulatedSignatures = [];

  /// The transactions signatures made using the cached [value].
  final List<String> transactionSignatures = [];

  /// The last blockhash fetched from [HttpConnection.getLatestBlockhash].
  BlockhashWithExpiryBlockHeight? _latestBlockhash;

  /// The updated timestamp of [_latestBlockhash].
  int _latestBlockhashTimestamp = 0;

  /// Indicates if a [_fetch] request is in progress.
  Completer<void>? _fetchCompleter;

  /// The start timestamp of the latest [_fetch] request.
  int _fetchTimestamp = 0;

  /// The maximum number of requests made by [_fetch].
  static const int _maxFetchAttempts = 50;

  /// The number of milliseconds since [_latestBlockhash] was retrieved.
  int get _elapsed => _timestamp() - _latestBlockhashTimestamp;

  /// If true, the cached [value] is `null` or has expired.
  bool get expired =>
      _latestBlockhash == null || _elapsed >= timeout.inMilliseconds;

  /// The cached `blockhash` or `null` if the cache has [expired].
  BlockhashWithExpiryBlockHeight? get value =>
      expired ? null : _latestBlockhash;

  /// Returns the number of milliseconds since unix epoch.
  int _timestamp() => DateTime.now().millisecondsSinceEpoch;

  /// Returns the latest `blockhash`.
  ///
  /// The cached [value] is returned when [disabled] is `false` and its [timeout] duration has not
  /// elapsed. Otherwise, a request is made over the provided [connection] to fetch and store the
  /// latest blockhash.
  ///
  /// If a request to fetch the latest blockhash is in progress, the method waits for it to
  /// complete before returning a value, even if [disabled] is `false` and there's a valid cache
  /// value.
  FutureOr<BlockhashWithExpiryBlockHeight> get(
    final HttpConnection connection, {
    required final bool disabled,
  }) async {
    /// Make a request to fetch the latest blockhash if the cache is [disabled].
    if (disabled) {
      return _fetch(connection);
    }

    /// Return the cached value or make a request to fetch the latest blockhash.
    return value ?? _syncFetch(connection);
  }

  /// Set the cache's [value] and update the state.
  void _set(final BlockhashWithExpiryBlockHeight value) {
    simulatedSignatures.clear();
    transactionSignatures.clear();
    _latestBlockhash = value;
    _latestBlockhashTimestamp = _timestamp();
  }

  /// Waits for the pending request to complete (if any) or makes a request to get the latest
  /// `blockhash`.
  ///
  /// Throws a [TransactionException] if the latest blockhash could not be retrieved.
  FutureOr<BlockhashWithExpiryBlockHeight> _syncFetch(
    final HttpConnection connection,
  ) async {
    await _fetchCompleter?.future;
    return value ?? _fetch(connection);
  }

  /// Makes a request to get the latest `blockhash`.
  ///
  /// Throws a [TransactionException] if the latest blockhash could not be retrieved.
  FutureOr<BlockhashWithExpiryBlockHeight> _fetch(
    final HttpConnection connection,
  ) async {
    /// Create a local [fetchCompleter] to be resolved when this method completes.
    final Completer<void> fetchCompleter = Completer.sync();

    /// Store the request's start time.
    final int fetchTimestamp = _timestamp();

    /// Update class' shared variables.
    _fetchCompleter = fetchCompleter;
    _fetchTimestamp = fetchTimestamp;

    try {
      final Blockhash? cachedBlockhash = _latestBlockhash?.blockhash;
      const config = GetLatestBlockhashConfig(commitment: Commitment.finalized);

      for (int i = 0; i < _maxFetchAttempts; ++i) {
        final latestBlockhash = await connection.getLatestBlockhash(
          config: config,
        );
        if (cachedBlockhash != latestBlockhash.blockhash) {
          _set(latestBlockhash);
          return latestBlockhash;
        }
        // Sleep for approximately half a slot
        await Future.delayed(
          const Duration(milliseconds: millisecondsPerSlot ~/ 2),
        );
      }

      final int elapsed = _timestamp() - fetchTimestamp;
      throw TransactionException(
        'Unable to obtain a new blockhash after ${elapsed}ms',
      );
    } finally {
      /// Resolve the request's completer.
      fetchCompleter.complete();

      /// Clear [_fetchCompleter] if its current value belongs to this method call.
      /// This does not have to be particularly accurate.
      if (fetchTimestamp >= _fetchTimestamp) {
        _fetchCompleter = null;
      }
    }
  }
}
