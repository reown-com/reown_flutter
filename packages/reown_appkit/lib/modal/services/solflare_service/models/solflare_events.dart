import 'dart:convert';

import 'package:event/event.dart';
import 'package:reown_appkit/modal/services/solflare_service/models/solflare_data.dart';

class SolflareConnectEvent implements EventArgs {
  final SolflareData? data;
  SolflareConnectEvent(this.data);

  @override
  String toString() => data?.toString() ?? '';

  @override
  String? eventName;

  @override
  DateTime? whenOccurred;
}

class SolflareErrorEvent implements EventArgs {
  final int? code;
  final String? error;
  SolflareErrorEvent(this.code, this.error);

  @override
  String? eventName;

  @override
  DateTime? whenOccurred;

  @override
  String toString() => jsonEncode({'code': code, 'error': error});
}

class SolflareSessionEvent implements EventArgs {
  String? address;
  String? chainName;
  String? chainId;

  SolflareSessionEvent({
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

  @override
  String? eventName;

  @override
  DateTime? whenOccurred;
}

class SolflareResponseEvent implements EventArgs {
  String? data;
  SolflareResponseEvent({required this.data});

  @override
  String? eventName;

  @override
  DateTime? whenOccurred;
}
