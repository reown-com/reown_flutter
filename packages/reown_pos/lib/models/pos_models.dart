import 'package:freezed_annotation/freezed_annotation.dart';

part 'pos_models.g.dart';
part 'pos_models.freezed.dart';

@freezed
sealed class PaymentIntent with _$PaymentIntent {
  const factory PaymentIntent({
    required String token, // token address, 0x..... for EVM
    required String amount, // double as string
    required String chainId, // caip-2 chain id, i.e. `eip155:1`
    required String recipient, // recipient address, 0x..... for EVM
  }) = _PaymentIntent;

  factory PaymentIntent.fromJson(Map<String, dynamic> json) =>
      _$PaymentIntentFromJson(json);
}

@freezed
sealed class Metadata with _$Metadata {
  const factory Metadata({
    required String merchantName,
    required String description,
    required String url,
    required String logoIcon,
  }) = _Metadata;

  factory Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);
}

@freezed
sealed class PosNetworkData with _$PosNetworkData {
  const factory PosNetworkData({
    required String name,
    required String currency,
    required String chainId,
  }) = _PosNetworkData;

  factory PosNetworkData.fromJson(Map<String, dynamic> json) =>
      _$PosNetworkDataFromJson(json);
}

@freezed
sealed class PosToken with _$PosToken {
  const factory PosToken({
    required PosNetwork network,
    required String symbol,
    required String address,
  }) = _PosToken;

  factory PosToken.fromJson(Map<String, dynamic> json) =>
      _$PosTokenFromJson(json);
}

enum PosNetwork {
  ethereum,
  polygon,
  binanceSmartChain,
  avalanche,
  arbitrum,
  optimism,
  base,
  fantom,
  cronos,
  polygonZkEVM,
  sepolia;
  // solana;

  PosNetworkData get networkData {
    switch (this) {
      case PosNetwork.ethereum:
        return PosNetworkData(
          name: 'Ethereum',
          currency: 'ETH',
          chainId: 'eip155:1',
        );
      case PosNetwork.polygon:
        return PosNetworkData(
          name: 'Polygon',
          currency: 'MATIC',
          chainId: 'eip155:137',
        );
      case PosNetwork.binanceSmartChain:
        return PosNetworkData(
          name: 'BNB Smart Chain',
          currency: 'BNB',
          chainId: 'eip155:56',
        );
      case PosNetwork.avalanche:
        return PosNetworkData(
          name: 'Avalanche',
          currency: 'AVAX',
          chainId: 'eip155:43114',
        );
      case PosNetwork.arbitrum:
        return PosNetworkData(
          name: 'Arbitrum One',
          currency: 'ETH',
          chainId: 'eip155:42161',
        );
      case PosNetwork.optimism:
        return PosNetworkData(
          name: 'Optimism',
          currency: 'ETH',
          chainId: 'eip155:10',
        );
      case PosNetwork.base:
        return PosNetworkData(
          name: 'Base',
          currency: 'ETH',
          chainId: 'eip155:8453',
        );
      case PosNetwork.fantom:
        return PosNetworkData(
          name: 'Fantom',
          currency: 'FTM',
          chainId: 'eip155:250',
        );
      case PosNetwork.cronos:
        return PosNetworkData(
          name: 'Cronos',
          currency: 'CRO',
          chainId: 'eip155:25',
        );
      case PosNetwork.polygonZkEVM:
        return PosNetworkData(
          name: 'Polygon zkEVM',
          currency: 'ETH',
          chainId: 'eip155:1101',
        );
      case PosNetwork.sepolia:
        return PosNetworkData(
          name: 'Sepolia ETH',
          currency: 'sETH',
          chainId: 'eip155:11155111',
        );
      // case PosNetwork.solana:
      //   return PosNetworkData(
      //     name: 'Solana',
      //     currency: 'SOL',
      //     chainId: 'solana::5eykt4UsFv8P8NJdTREpY1vzqKqZKvdp',
      //   );
    }
  }
}
