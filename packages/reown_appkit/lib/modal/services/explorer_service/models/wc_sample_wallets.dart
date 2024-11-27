import 'package:collection/collection.dart';
import 'package:reown_appkit/modal/models/public/appkit_wallet_info.dart';
import 'package:reown_appkit/modal/utils/platform_utils.dart';

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

  static List<ReownAppKitModalWalletInfo> getSampleWallets() {
    final wallets = _sampleWallets().map((entry) {
      final id = entry['id'] as String?;
      final name = entry['name'] as String?;
      final schema = entry['schema'] as String?;
      final universal = entry['universal'] as String?;
      final bundleId = entry['universal'] as String?;
      return ReownAppKitModalWalletInfo(
        listing: Listing.fromJson({
          'id': id,
          'name': name,
          'homepage': 'https://reown.com',
          'image_id':
              'https://raw.githubusercontent.com/reown-com/reown_flutter/develop/assets/walletkit_logo.png',
          'order': 10,
          'mobile_link': schema,
          'link_mode': universal,
          'app_store': 'https://apps.apple.com/app/apple-store/id$id',
          'play_store':
              'https://play.google.com/store/apps/details?id=$bundleId',
        }),
        installed: false,
        recent: false,
      );
    });
    return wallets.whereType<ReownAppKitModalWalletInfo>().toList();
  }

  static List<Map<String, dynamic>> _sampleWallets() {
    String flavor = '-${const String.fromEnvironment('FLUTTER_APP_FLAVOR')}';
    flavor = flavor.replaceAll('-production', '');

    final platform = PlatformUtils.getPlatformExact().name;
    final platformName = platform.toString().toLowerCase();

    if (flavor.isNotEmpty) {
      return _sampleWalletsInternal().where((e) {
        return (e['platform'] as List<String>).contains(platformName);
      }).toList();
    }
    return _sampleWalletsProduction().where((e) {
      return (e['platform'] as List<String>).contains(platformName);
    }).toList();
  }

  static String? getSampleWalletScheme(String id) {
    final wallet = _sampleWallets().firstWhereOrNull((e) => e['id'] == id);
    final platform = PlatformUtils.getPlatformExact();
    if (platform == PlatformExact.android) {
      return wallet?['bundleId'] as String?;
    }
    return wallet?['schema'] as String?;
  }
}
