import 'package:freezed_annotation/freezed_annotation.dart';

part 'asset_models.g.dart';
part 'asset_models.freezed.dart';

@freezed
sealed class AssetMetadata with _$AssetMetadata {
  const factory AssetMetadata({
    required String name,
    required String symbol,
    required int decimals,
  }) = _AssetMetadata;

  factory AssetMetadata.fromJson(Map<String, dynamic> json) =>
      _$AssetMetadataFromJson(json);
}

@freezed
sealed class ExchangeAsset with _$ExchangeAsset {
  const factory ExchangeAsset({
    required String network,
    required String asset,
    required AssetMetadata metadata,
  }) = _ExchangeAsset;

  factory ExchangeAsset.fromJson(Map<String, dynamic> json) =>
      _$ExchangeAssetFromJson(json);
}

const ethereumETH = ExchangeAsset(
  network: 'eip155:1',
  asset: 'native',
  metadata: AssetMetadata(name: 'Ethereum', symbol: 'ETH', decimals: 18),
);

const baseETH = ExchangeAsset(
  network: 'eip155:8453',
  asset: 'native',
  metadata: AssetMetadata(name: 'Ethereum', symbol: 'ETH', decimals: 18),
);

const baseUSDC = ExchangeAsset(
  network: 'eip155:8453',
  asset: '0x833589fcd6edb6e08f4c7c32d4f71b54bda02913',
  metadata: AssetMetadata(name: 'USD Coin', symbol: 'USDC', decimals: 6),
);

const baseSepoliaUSDC = ExchangeAsset(
  network: 'eip155:84532',
  asset: '0x036CbD53842c5426634e7929541eC2318f3dCF7e',
  metadata: AssetMetadata(name: 'USD Coin', symbol: 'USDC', decimals: 6),
);

const baseSepoliaETH = ExchangeAsset(
  network: 'eip155:84532',
  asset: 'native',
  metadata: AssetMetadata(name: 'Ethereum', symbol: 'ETH', decimals: 18),
);

const sepoliaETH = ExchangeAsset(
  network: 'eip155:11155111',
  asset: 'native',
  metadata: AssetMetadata(name: 'Ethereum', symbol: 'ETH', decimals: 18),
);

const ethereumUSDC = ExchangeAsset(
  network: 'eip155:1',
  asset: '0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48',
  metadata: AssetMetadata(name: 'USD Coin', symbol: 'USDC', decimals: 6),
);

const arbitrumUSDC = ExchangeAsset(
  network: 'eip155:42161',
  asset: '0xaf88d065e77c8cC2239327C5EDb3A432268e5831',
  metadata: AssetMetadata(name: 'USD Coin', symbol: 'USDC', decimals: 6),
);

const polygonUSDC = ExchangeAsset(
  network: 'eip155:137',
  asset: '0x2791bca1f2de4661ed88a30c99a7a9449aa84174',
  metadata: AssetMetadata(name: 'USD Coin', symbol: 'USDC', decimals: 6),
);

const solanaUSDC = ExchangeAsset(
  network: 'solana:5eykt4UsFv8P8NJdTREpY1vzqKqZKvdp',
  asset: 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v',
  metadata: AssetMetadata(name: 'USD Coin', symbol: 'USDC', decimals: 6),
);

const ethereumUSDT = ExchangeAsset(
  network: 'eip155:1',
  asset: '0xdAC17F958D2ee523a2206206994597C13D831ec7',
  metadata: AssetMetadata(name: 'Tether USD', symbol: 'USDT', decimals: 6),
);

const optimismUSDT = ExchangeAsset(
  network: 'eip155:10',
  asset: '0x94b008aA00579c1307B0EF2c499aD98a8ce58e58',
  metadata: AssetMetadata(name: 'Tether USD', symbol: 'USDT', decimals: 6),
);

const arbitrumUSDT = ExchangeAsset(
  network: 'eip155:42161',
  asset: '0xFd086bC7CD5C481DCC9C85ebE478A1C0b69FCbb9',
  metadata: AssetMetadata(name: 'Tether USD', symbol: 'USDT', decimals: 6),
);

const polygonUSDT = ExchangeAsset(
  network: 'eip155:137',
  asset: '0xc2132d05d31c914a87c6611c10748aeb04b58e8f',
  metadata: AssetMetadata(name: 'Tether USD', symbol: 'USDT', decimals: 6),
);

const solanaUSDT = ExchangeAsset(
  network: 'solana:5eykt4UsFv8P8NJdTREpY1vzqKqZKvdp',
  asset: 'Es9vMFrzaCERmJfrF4H2FYD4KCoNkY11McCe8BenwNYB',
  metadata: AssetMetadata(name: 'Tether USD', symbol: 'USDT', decimals: 6),
);

const solanaSOL = ExchangeAsset(
  network: 'solana:5eykt4UsFv8P8NJdTREpY1vzqKqZKvdp',
  asset: 'native',
  metadata: AssetMetadata(name: 'Solana', symbol: 'SOL', decimals: 9),
);

const List<ExchangeAsset> allExchangeAssets = [
  ethereumETH,
  baseETH,
  baseUSDC,
  baseSepoliaETH,
  ethereumUSDC,
  arbitrumUSDC,
  polygonUSDC,
  solanaUSDC,
  ethereumUSDT,
  optimismUSDT,
  arbitrumUSDT,
  polygonUSDT,
  solanaUSDT,
  solanaSOL,
];
