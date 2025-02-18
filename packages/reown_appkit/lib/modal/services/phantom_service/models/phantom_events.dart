import 'dart:convert';

import 'package:event/event.dart';
import 'package:reown_appkit/modal/services/phantom_service/models/phantom_data.dart';

class PhantomConnectEvent implements EventArgs {
  final PhantomData? data;
  PhantomConnectEvent(this.data);

  @override
  String toString() => data?.toString() ?? '';

  @override
  String? eventName;

  @override
  DateTime? whenOccurred;
}

class PhantomErrorEvent implements EventArgs {
  final int? code;
  final String? error;
  PhantomErrorEvent(this.code, this.error);

  @override
  String? eventName;

  @override
  DateTime? whenOccurred;

  @override
  String toString() => jsonEncode({'code': code, 'error': error});
}

class PhantomSessionEvent implements EventArgs {
  String? address;
  String? chainName;
  String? chainId;

  PhantomSessionEvent({
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

class PhantomResponseEvent implements EventArgs {
  String? data;
  PhantomResponseEvent({required this.data});

  @override
  String? eventName;

  @override
  DateTime? whenOccurred;
}
