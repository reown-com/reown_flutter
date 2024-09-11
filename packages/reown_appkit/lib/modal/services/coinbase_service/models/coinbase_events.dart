import 'package:event/event.dart';
import 'package:reown_appkit/modal/services/coinbase_service/models/coinbase_data.dart';

class CoinbaseConnectEvent implements EventArgs {
  final CoinbaseData? data;
  CoinbaseConnectEvent(this.data);

  @override
  String toString() => data?.toString() ?? '';
}

class CoinbaseErrorEvent implements EventArgs {
  final String? error;
  CoinbaseErrorEvent(this.error);
}

class CoinbaseSessionEvent implements EventArgs {
  String? address;
  String? chainName;
  String? chainId;

  CoinbaseSessionEvent({
    this.address,
    this.chainName,
    this.chainId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> params = {};
    if ((address ?? '').isNotEmpty) {
      params['address'] = address;
    }
    if ((chainName ?? '').isNotEmpty) {
      params['chainName'] = chainName;
    }
    if (chainId != null) {
      params['chainId'] = chainId;
    }

    return params;
  }

  @override
  String toString() => toJson().toString();
}

class CoinbaseResponseEvent implements EventArgs {
  String? data;
  CoinbaseResponseEvent({required this.data});
}
