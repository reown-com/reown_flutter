import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:reown_core/connectivity/i_connectivity.dart';
import 'package:reown_core/i_core_impl.dart';

class ConnectivityState implements IConnectivity {
  final IReownCore _core;
  final Connectivity _connectivity;

  ConnectivityState({
    required IReownCore core,
    required Connectivity connectivity,
  }) : _core = core,
       _connectivity = connectivity;

  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  bool _initialized = false;

  @override
  final isOnline = ValueNotifier<bool>(false);

  @override
  Future<void> init() async {
    if (_initialized) return;

    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );

    final result = await Connectivity().checkConnectivity();
    _updateConnectionStatus(result);

    _initialized = true;
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    final isMobileData = result.contains(ConnectivityResult.mobile);
    final isWifi = result.contains(ConnectivityResult.wifi);
    final isEthernet = result.contains(ConnectivityResult.ethernet);
    final isVPN = result.contains(ConnectivityResult.vpn);
    final isOnlineStatus = isMobileData || isWifi || isEthernet || isVPN;

    if (isOnline.value != isOnlineStatus) {
      _core.logger.i('[$runtimeType] Connectivity changed $result');
      isOnline.value = isOnlineStatus;

      if (isOnline.value && !_core.relayClient.isConnected) {
        await _core.relayClient.connect();
      } else if (!isOnline.value && _core.relayClient.isConnected) {
        await _core.relayClient.disconnect();
      }
    }
  }

  @override
  Future<void> dispose() async {
    await _connectivitySubscription.cancel();
  }
}
