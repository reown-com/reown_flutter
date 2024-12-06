import 'dart:io';

class WCSampleWallets {
  static List<Map<String, dynamic>> _sampleWalletsInternal() => [
        {
          'name': 'SW Wallet (internal)',
          'platform': ['ios'],
          'id': '123456789012345678901234567890',
          'schema': 'walletapp://',
          'bundleId': 'com.walletconnect.sample.wallet',
          'universal': 'https://appkit-lab.reown.com/wallet',
        },
        {
          'name': 'FL Wallet (internal)',
          'platform': ['ios', 'android'],
          'id': '123456789012345678901234567895',
          'schema': 'wcflutterwallet-internal://',
          'bundleId': 'com.walletconnect.flutterwallet.internal',
          'universal':
              'https://appkit-lab.reown.com/flutter_walletkit_internal',
        },
        {
          'name': 'RN Wallet (internal)',
          'platform': ['ios', 'android'],
          'id': '1234567890123456789012345678922',
          'schema': 'rn-web3wallet-internal://',
          'bundleId': 'com.walletconnect.web3wallet.rnsample.internal',
          'universal': 'https://appkit-lab.reown.com/rn_walletkit_internal',
        },
        {
          'name': 'KT Wallet (Internal)',
          'platform': ['android'],
          'id': '123456789012345678901234567894',
          'schema': 'kotlin-web3wallet://wc',
          'bundleId': 'com.reown.sample.wallet.internal',
          'universal': 'https://appkit-lab.reown.com/wallet_internal',
        },
      ];

  static List<Map<String, dynamic>> _sampleWalletsProduction() => [
        {
          'name': 'SW Wallet',
          'platform': ['ios'],
          'id': '123456789012345678901234567890',
          'schema': 'walletapp://',
          'bundleId': 'com.walletconnect.sample.wallet',
          'universal': 'https://appkit-lab.reown.com/wallet',
        },
        {
          'name': 'FL Wallet',
          'platform': ['ios', 'android'],
          'id': '123456789012345678901234567891',
          'schema': 'wcflutterwallet://',
          'bundleId': 'com.walletconnect.flutterwallet',
          'universal': 'https://appkit-lab.reown.com/flutter_walletkit',
        },
        {
          'name': 'RN Wallet',
          'platform': ['ios', 'android'],
          'id': '123456789012345678901234567892',
          'schema': 'rn-web3wallet://',
          'bundleId': 'com.walletconnect.web3wallet.rnsample',
          'universal': 'https://appkit-lab.reown.com/rn_walletkit',
        },
        {
          'name': 'KT Wallet',
          'platform': ['android'],
          'id': '123456789012345678901234567893',
          'schema': 'kotlin-web3wallet://wc',
          'bundleId': 'com.reown.sample.wallet',
          'universal': 'https://appkit-lab.reown.com/wallet_release',
        },
      ];

  static List<Map<String, dynamic>> getSampleWallets() {
    String flavor = '-${const String.fromEnvironment('FLUTTER_APP_FLAVOR')}';
    flavor = flavor.replaceAll('-production', '');
    if (flavor.isNotEmpty) {
      return _sampleWalletsInternal().where((e) {
        return (e['platform'] as List<String>)
            .contains(Platform.operatingSystem);
      }).toList();
    }
    return _sampleWalletsProduction().where((e) {
      return (e['platform'] as List<String>).contains(Platform.operatingSystem);
    }).toList();
  }
}
