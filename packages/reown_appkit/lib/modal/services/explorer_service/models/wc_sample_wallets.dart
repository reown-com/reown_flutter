import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:reown_appkit/modal/models/public/appkit_wallet_info.dart';
import 'package:reown_appkit/modal/utils/platform_utils.dart';

class WCSampleWallets {
  static List<Map<String, dynamic>> _sampleWalletsInternal() => [
        {
          'platform': ['ios'], // added only for local purposes
          'id': '00001',
          'name': 'Swift Wallet (internal)',
          'homepage': 'https://docs.reown.com',
          'image_id': 'wallet_swift',
          'order': 10,
          'mobile_link': 'walletapp://',
          'desktop_link': null,
          'link_mode': 'https://appkit-lab.reown.com/wallet',
          'webapp_link': null,
          'app_store': null,
          'play_store': null,
          'rdns': 'com.walletconnect.sample.wallet',
          'chrome_store': null,
          // 'injected': null,
          // 'chains': [],
          // 'categories': [],
          'description': 'Reown\'s Swift sample wallet',
          'badge_type': 'certified'
        },
        {
          'platform': ['ios', 'android'], // added only for local purposes
          'id': '00002',
          'name': 'Flutter Wallet (internal)',
          'homepage': 'https://docs.reown.com',
          'image_id': 'wallet_flutter',
          'order': 10,
          'mobile_link': 'wcflutterwallet-internal://',
          'desktop_link': null,
          'link_mode':
              'https://appkit-lab.reown.com/flutter_walletkit_internal',
          'webapp_link': null,
          'app_store': null,
          'play_store': null,
          'rdns': 'com.walletconnect.flutterwallet.internal',
          'chrome_store': null,
          // 'injected': null,
          // 'chains': [],
          // 'categories': [],
          'description': 'Reown\'s Flutter sample wallet',
          'badge_type': 'certified'
        },
        {
          'platform': ['ios', 'android'], // added only for local purposes
          'id': '00003',
          'name': 'React Native Wallet (internal)',
          'homepage': 'https://docs.reown.com',
          'image_id': 'wallet_react_native',
          'order': 10,
          'mobile_link': 'rn-web3wallet-internal://',
          'desktop_link': null,
          'link_mode': 'https://appkit-lab.reown.com/rn_walletkit_internal',
          'webapp_link': null,
          'app_store': null,
          'play_store': null,
          'rdns': 'com.walletconnect.web3wallet.rnsample.internal',
          'chrome_store': null,
          // 'injected': null,
          // 'chains': [],
          // 'categories': [],
          'description': 'Reown\'s React Native sample wallet',
          'badge_type': 'certified'
        },
        {
          'platform': ['android'], // added only for local purposes
          'id': '00004',
          'name': 'Kotlin Wallet (Internal)',
          'homepage': 'https://docs.reown.com',
          'image_id': 'wallet_kotlin',
          'order': 10,
          'mobile_link': 'kotlin-web3wallet://wc',
          'desktop_link': null,
          'link_mode': 'https://appkit-lab.reown.com/wallet_internal',
          'webapp_link': null,
          'app_store': null,
          'play_store': null,
          'rdns': 'com.walletconnect.sample.wallet.internal',
          'chrome_store': null,
          // 'injected': null,
          // 'chains': [],
          // 'categories': [],
          'description': 'Reown\'s Kotlin sample wallet',
          'badge_type': 'certified'
        },
        // {
        //   'name': 'Web Wallet (Internal)',
        //   'platform': ['ios', 'android'],
        //   'id': '123456789012345678901234567888',
        //   // 'mobile_link': 'https://',
        //   'webapp_link':
        //       'https://chore-web-wallet-imp.appkit-web-wallet.pages.dev',
        // },
        {
          'platform': ['ios', 'android'], // added only for local purposes
          'id': '00005',
          'name': 'React Web Wallet',
          'homepage': 'https://react-wallet.walletconnect.com',
          'image_id': 'wallet_react',
          'order': 10,
          'mobile_link': null,
          'desktop_link': null,
          'link_mode': null,
          'webapp_link': 'https://react-wallet.walletconnect.com',
          'app_store': null,
          'play_store': null,
          'rdns': null,
          'chrome_store': null,
          // 'injected': null,
          // 'chains': [],
          // 'categories': [],
          'description': 'Reown\'s React Web sample wallet',
          'badge_type': 'certified'
        },
      ];

  static List<Map<String, dynamic>> _sampleWalletsProduction() => [
        {
          'platform': ['ios'], // added only for local purposes
          'id': '00001',
          'name': 'Swift Wallet (internal)',
          'homepage': 'https://docs.reown.com',
          'image_id': 'wallet_swift',
          'order': 10,
          'mobile_link': 'walletapp://',
          'desktop_link': null,
          'link_mode': 'https://appkit-lab.reown.com/wallet',
          'webapp_link': null,
          'app_store': null,
          'play_store': null,
          'rdns': 'com.walletconnect.sample.wallet',
          'chrome_store': null,
          // 'injected': null,
          // 'chains': [],
          // 'categories': [],
          'description': 'Reown\'s Swift sample wallet',
          'badge_type': 'certified'
        },
        {
          'platform': ['ios', 'android'], // added only for local purposes
          'id': '00002',
          'name': 'Flutter Wallet',
          'homepage': 'https://docs.reown.com',
          'image_id': 'wallet_flutter',
          'order': 10,
          'mobile_link': 'wcflutterwallet://',
          'desktop_link': null,
          'link_mode': 'https://appkit-lab.reown.com/flutter_walletkit',
          'webapp_link': null,
          'app_store': null,
          'play_store': null,
          'rdns': 'com.walletconnect.flutterwallet',
          'chrome_store': null,
          // 'injected': null,
          // 'chains': [],
          // 'categories': [],
          'description': 'Reown\'s Flutter sample wallet',
          'badge_type': 'certified'
        },
        {
          'platform': ['ios', 'android'], // added only for local purposes
          'id': '00003',
          'name': 'React Native Wallet',
          'homepage': 'https://docs.reown.com',
          'image_id': 'wallet_react_native',
          'order': 10,
          'mobile_link': 'rn-web3wallet://',
          'desktop_link': null,
          'link_mode': 'https://appkit-lab.reown.com/rn_walletkit',
          'webapp_link': null,
          'app_store': null,
          'play_store': null,
          'rdns': 'com.walletconnect.web3wallet.rnsample',
          'chrome_store': null,
          // 'injected': null,
          // 'chains': [],
          // 'categories': [],
          'description': 'Reown\'s React Native sample wallet',
          'badge_type': 'certified'
        },
        {
          'platform': ['android'], // added only for local purposes
          'id': '00004',
          'name': 'Kotlin Wallet',
          'homepage': 'https://docs.reown.com',
          'image_id': 'wallet_kotlin',
          'order': 10,
          'mobile_link': 'kotlin-web3wallet://wc',
          'desktop_link': null,
          'link_mode': 'https://appkit-lab.reown.com/wallet_release',
          'webapp_link': null,
          'app_store': null,
          'play_store': null,
          'rdns': 'com.walletconnect.sample.wallet',
          'chrome_store': null,
          // 'injected': null,
          // 'chains': [],
          // 'categories': [],
          'description': 'Reown\'s Kotlin sample wallet',
          'badge_type': 'certified'
        },
        // {
        //   'name': 'Web Wallet (Internal)',
        //   'platform': ['ios', 'android'],
        //   'id': '123456789012345678901234567888',
        //   // 'mobile_link': 'https://',
        //   'webapp_link':
        //       'https://chore-web-wallet-imp.appkit-web-wallet.pages.dev',
        // },
        {
          'platform': ['ios', 'android'], // added only for local purposes
          'id': '00005',
          'name': 'React Web Wallet',
          'homepage': 'https://react-wallet.walletconnect.com',
          'image_id': 'wallet_react',
          'order': 10,
          'mobile_link': null,
          'desktop_link': null,
          'link_mode': null,
          'webapp_link': 'https://react-wallet.walletconnect.com',
          'app_store': null,
          'play_store': null,
          'rdns': null,
          'chrome_store': null,
          // 'injected': null,
          // 'chains': [],
          // 'categories': [],
          'description': 'Reown\'s React Web sample wallet',
          'badge_type': 'certified'
        },
      ];

  static List<ReownAppKitModalWalletInfo> getSampleWallets() {
    final wallets = _sampleWallets().map((entry) {
      debugPrint(jsonEncode(entry));
      final listing = Listing.fromJson(entry);
      return ReownAppKitModalWalletInfo(
        listing: listing.copyWith(isSample: true),
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

  static ReownAppKitModalWalletInfo? getSampleWallet(String id) {
    return getSampleWallets().firstWhereOrNull((e) => e.listing.id == id);
  }

  static String? getSampleWalletMobileLink(String id) {
    final wallet = _sampleWallets().firstWhereOrNull((e) => e['id'] == id);
    final platform = PlatformUtils.getPlatformExact();
    if (platform == PlatformExact.android) {
      return wallet?['bundle_id'] as String?;
    }
    return wallet?['mobile_link'] as String?;
  }
}
