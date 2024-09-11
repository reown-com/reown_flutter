import 'package:freezed_annotation/freezed_annotation.dart';

part 'appkit_network_info.freezed.dart';

@freezed
class AppKitModalNetworkInfo with _$AppKitModalNetworkInfo {
  factory AppKitModalNetworkInfo({
    required String name,
    required String chainId,
    required String currency,
    required String rpcUrl,
    required String explorerUrl,
    @Default(<String>[]) List<String> extraRpcUrls,
    @Default(false) isTestNetwork,
    String? chainIcon,
  }) = _AppKitNetworkInfo;
}

extension AppKitNetworkInfoExtension on AppKitModalNetworkInfo {
  String get chainHexId => '0x${int.parse(chainId).toRadixString(16)}';

  Map<String, dynamic> toJson() {
    return {
      'chainId': chainHexId,
      'chainName': name,
      'nativeCurrency': {
        'name': currency,
        'symbol': currency,
        'decimals': 18,
      },
      'rpcUrls': [
        rpcUrl,
        ...extraRpcUrls,
      ],
      'blockExplorerUrls': [
        explorerUrl,
      ],
    };
  }
}
