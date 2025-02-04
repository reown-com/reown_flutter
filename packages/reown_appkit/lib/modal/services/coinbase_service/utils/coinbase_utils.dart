import 'package:reown_appkit/modal/models/public/appkit_wallet_info.dart';

class CoinbaseUtils {
  static const packageName = 'org.toshi';
  static final walletId =
      'fd20dc426fb37566d803205b19bbc1d4096b248ac04548e3cfb6b3a38bd033aa';

  static final defaultListingData = Listing.fromJson(defaultWalletData);

  static final Map<String, dynamic> defaultWalletData = {
    'id': walletId,
    'name': 'Coinbase Wallet',
    'homepage': 'https://www.coinbase.com/wallet/',
    'image_id': 'a5ebc364-8f91-4200-fcc6-be81310a0000',
    'order': 280,
    'mobile_link': 'cbwallet://',
    'desktop_link': null,
    'link_mode': 'https://wallet.coinbase.com/',
    'webapp_link': null,
    'app_store': 'https://apps.apple.com/app/apple-store/id1278383455',
    'play_store': 'https://play.google.com/store/apps/details?id=org.toshi',
    'rdns': 'com.coinbase.wallet',
    'chrome_store':
        'https://chrome.google.com/webstore/detail/coinbase-wallet-extension/hnfanknocfeofbddgcijnmhnfnkdnaad?hl=en',
    'injected': [
      {'namespace': 'eip155', 'injected_id': 'isCoinbaseWallet'}
    ],
    'chains': [
      'eip155:1',
      'eip155:10',
      'eip155:100',
      'eip155:137',
      'eip155:250',
      'eip155:42161',
      'eip155:43114',
      'eip155:56',
      'eip155:80084',
      'eip155:80085',
      'solana:5eykt4UsFv8P8NJdTREpY1vzqKqZKvdp'
    ],
    'categories': [
      'b7c081de-c6d6-447e-ada6-a6f8e6e1480a',
      'e127a2ef-09e5-417b-9304-3e2e567a0f87'
    ],
    'description': 'Your key to the world of crypto',
    'badge_type': 'none'
  };

  // mainnet-beta, testnet, or devnet
  static final Map<String, String> walletClusters = {
    '5eykt4UsFv8P8NJdTREpY1vzqKqZKvdp': 'mainnet-beta',
    '4uhcVJyU9pJkvQyS88uRDiswHXSCkY3z': 'testnet',
    'EtWTRABZaYq6iMfeYKouRu166VU2xqa1': 'devnet',
  };
}
