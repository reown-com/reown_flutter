import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reown_appkit/reown_appkit.dart';

part 'appkit_network_info.freezed.dart';
part 'appkit_network_info.g.dart';

@freezed
sealed class ReownAppKitModalNetworkInfo with _$ReownAppKitModalNetworkInfo {
  const factory ReownAppKitModalNetworkInfo({
    required String name,
    required String chainId,
    required String currency,
    required String rpcUrl,
    required String explorerUrl,
    @Default(<String>[]) List<String> extraRpcUrls,
    @Default(false) bool isTestNetwork,
    String? chainIcon,
  }) = _ReownAppKitModalNetworkInfo;

  factory ReownAppKitModalNetworkInfo.fromJson(Map<String, dynamic> json) =>
      _$ReownAppKitModalNetworkInfoFromJson(json);
}

extension ReownAppKitModalNetworkInfoExtension on ReownAppKitModalNetworkInfo {
  String get chainHexId {
    try {
      final id = ReownAppKitModalNetworks.getIdFromChain(chainId);
      return '0x${int.parse(id).toRadixString(16)}';
    } catch (e) {
      return chainId;
    }
  }

  Map<String, dynamic> toRawJson({int? decimals}) {
    return {
      'chainId': chainHexId,
      'chainName': name,
      'nativeCurrency': {
        'name': currency,
        'symbol': currency,
        'decimals': decimals ?? 18,
      },
      'rpcUrls': [rpcUrl, ...extraRpcUrls],
      'blockExplorerUrls': [explorerUrl],
    };
  }
}
