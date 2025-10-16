import 'package:reown_appkit/modal/models/public/appkit_wallet_info.dart';

class SolflareUtils {
  static const packageName = 'com.solflare.mobile';
  static final walletId =
      '1ca0bdd4747578705b1939af023d120677c64fe6ca76add81fda36e350605e79';

  static final defaultListingData = AppKitModalWalletListing.fromJson(
    defaultWalletData,
  );

  static final Map<String, dynamic> defaultWalletData = {
    'id': walletId,
    'name': 'Solflare',
    'homepage': 'https://solflare.com/',
    'image_id': '34c0e38d-66c4-470e-1aed-a6fabe2d1e00',
    'order': 210,
    'mobile_link': 'solflare://',
    'desktop_link': null,
    'link_mode': 'https://solflare.com',
    'webapp_link': null,
    'app_store':
        'https://apps.apple.com/us/app/solflare-solana-wallet/id1580902717',
    'play_store':
        'https://play.google.com/store/apps/details?id=$packageName&hl=en',
    'rdns': packageName,
    'chrome_store':
        'https://chrome.google.com/webstore/detail/solflare-wallet/bhhhlbepdkbapadjdnnojkbgioiodbic',
    'injected': [
      {'namespace': 'solana', 'injected_id': 'solflare'},
    ],
    'chains': [
      'solana:4uhcVJyU9pJkvQyS88uRDiswHXSCkY3z',
      'solana:5eykt4UsFv8P8NJdTREpY1vzqKqZKvdp',
      'solana:EtWTRABZaYq6iMfeYKouRu166VU2xqa1',
    ],
    'categories': ['b7c081de-c6d6-447e-ada6-a6f8e6e1480a'],
    'description':
        'Solflare is the safest way to start exploring Solana. Buy, store, swap tokens & NFTs and access Solana DeFi from web or mobile.',
    'badge_type': 'none',
  };

  // mainnet-beta, testnet, or devnet
  static final Map<String, String> walletClusters = {
    '5eykt4UsFv8P8NJdTREpY1vzqKqZKvdp': 'mainnet-beta',
    '4uhcVJyU9pJkvQyS88uRDiswHXSCkY3z': 'testnet',
    'EtWTRABZaYq6iMfeYKouRu166VU2xqa1': 'devnet',
  };
}
