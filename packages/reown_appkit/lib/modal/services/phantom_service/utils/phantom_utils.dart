import 'package:reown_appkit/modal/models/public/appkit_wallet_info.dart';

class PhantomUtils {
  static const packageName = 'app.phantom';
  static final walletId =
      'a797aa35c0fadbfc1a53e7f675162ed5226968b44a19ee3d24385c64d1d3c393';

  static final defaultListingData = Listing.fromJson(defaultWalletData);

  static final Map<String, dynamic> defaultWalletData = {
    'id': walletId,
    'name': 'Phantom',
    'homepage': 'https://phantom.app/',
    'image_id': 'b6ec7b81-bb4f-427d-e290-7631e6e50d00',
    'order': 210,
    'mobile_link': 'phantom://',
    'desktop_link': null,
    'link_mode': 'https://phantom.app',
    'webapp_link': null,
    'app_store':
        'https://apps.apple.com/us/app/phantom-crypto-wallet/id1598432977',
    'play_store':
        'https://play.google.com/store/apps/details?id=app.phantom&hl=en',
    'rdns': 'app.phantom',
    'chrome_store':
        'https://chrome.google.com/webstore/detail/phantom/bfnaelmomeimhlpmgjnjophhpkkoljpa',
    'injected': [
      {'namespace': 'eip155', 'injected_id': 'isPhantom'},
      {'namespace': 'solana', 'injected_id': 'isPhantom'}
    ],
    'chains': [
      'bip122:000000000019d6689c085ae165831e93',
      'bip122:000000000933ea01ad0ee984209779ba',
      'eip155:1',
      'eip155:80084',
      'eip155:80085',
      'solana:4uhcVJyU9pJkvQyS88uRDiswHXSCkY3z',
      'solana:5eykt4UsFv8P8NJdTREpY1vzqKqZKvdp',
      'solana:EtWTRABZaYq6iMfeYKouRu166VU2xqa1'
    ],
    'categories': [
      'b7c081de-c6d6-447e-ada6-a6f8e6e1480a',
      'e127a2ef-09e5-417b-9304-3e2e567a0f87'
    ],
    'description':
        'Phantom makes it safe & easy for you to store, buy, send, receive, swap tokens and collect NFTs on the Solana blockchain.',
    'badge_type': 'none'
  };

  // mainnet-beta, testnet, or devnet
  static final Map<String, String> walletClusters = {
    '5eykt4UsFv8P8NJdTREpY1vzqKqZKvdp': 'mainnet-beta',
    '4uhcVJyU9pJkvQyS88uRDiswHXSCkY3z': 'testnet',
    'EtWTRABZaYq6iMfeYKouRu166VU2xqa1': 'devnet',
  };
}
