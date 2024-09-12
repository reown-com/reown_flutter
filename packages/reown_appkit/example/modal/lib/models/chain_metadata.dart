import 'package:flutter/material.dart';
import 'package:reown_appkit/reown_appkit.dart';

enum ChainType {
  eip155,
  solana,
  kadena,
}

class ChainMetadata {
  final Color color;
  final ChainType type;
  final ReownAppKitModalNetworkInfo appKitNetworkInfo;

  const ChainMetadata({
    required this.color,
    required this.type,
    required this.appKitNetworkInfo,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChainMetadata &&
        other.color == color &&
        other.type == type &&
        other.appKitNetworkInfo == appKitNetworkInfo;
  }

  @override
  int get hashCode {
    return color.hashCode ^ type.hashCode ^ appKitNetworkInfo.hashCode;
  }
}
