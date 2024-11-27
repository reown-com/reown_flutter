import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:reown_core/connectivity/i_connectivity.dart';
import 'package:reown_core/i_core_impl.dart';

class ConnectivityState implements IConnectivity {
  final IReownCore _core;
  ConnectivityState({required IReownCore core}) : _core = core;

  bool _initialized = false;

  @override
  final isOnline = ValueNotifier<bool>(false);

  @override
  Future<void> init() async {
    if (_initialized) return;
    final result = await Connectivity().checkConnectivity();
    _updateConnectionStatus(result);
    Connectivity().onConnectivityChanged.listen(
          _updateConnectionStatus,
        );
    _initialized = true;
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    final isMobileData = result.contains(ConnectivityResult.mobile);
    final isWifi = result.contains(ConnectivityResult.wifi);
    final isOnlineStatus = isMobileData || isWifi;

    if (isOnline.value != isOnlineStatus) {
      isOnline.value = isOnlineStatus;
      _core.logger.i('[$runtimeType] Connectivity changed $isOnlineStatus');

      // if (isOnline.value && !_core.relayClient.isConnected) {
      //   await _core.relayClient.connect();
      // } else if (!isOnline.value && _core.relayClient.isConnected) {
      //   await _core.relayClient.disconnect();
      // }
    }
  }
}
