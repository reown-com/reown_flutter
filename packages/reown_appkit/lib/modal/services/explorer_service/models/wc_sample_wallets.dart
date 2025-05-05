// ignore_for_file: unused_element, dead_code

import 'package:collection/collection.dart';
import 'package:reown_appkit/modal/models/public/appkit_wallet_info.dart';
import 'package:reown_appkit/modal/utils/platform_utils.dart';

class WCSampleWallets {
  static List<Map<String, dynamic>> _sampleWalletsInternal() => [
        {
          'platform': ['ios'], // added only for local purposes
          'id': '00001',
          'name': 'Swift Sample (internal)',
          'homepage': 'https://docs.reown.com',
          'image_id':
              'https://raw.githubusercontent.com/reown-com/reown_flutter/3d3dd152433104adae8a50671c062733abdc9fe3/packages/reown_appkit/lib/modal/assets/wallet_swift.png',
          'order': 10,
          'mobile_link': 'walletapp://',
          'desktop_link': null,
          'bundle_id': 'com.walletconnect.sample.wallet',
          'link_mode': 'https://lab.web3modal.com/wallet',
          'webapp_link': null,
          'app_store': null,
          'play_store': null,
          'rdns': 'com.walletconnect.sample.wallet',
          'chrome_store': null,
          'description': 'Reown\'s Swift sample wallet',
          'badge_type': 'certified'
        },
        {
          'platform': ['ios', 'android'], // added only for local purposes
          'id': '00002',
          'name': 'Flutter Sample (internal)',
          'homepage': 'https://docs.reown.com',
          'image_id':
              'https://raw.githubusercontent.com/reown-com/reown_flutter/3d3dd152433104adae8a50671c062733abdc9fe3/packages/reown_appkit/lib/modal/assets/wallet_flutter.png',
          'order': 10,
          'mobile_link': 'wcflutterwallet-internal://wc',
          'desktop_link': null,
          'bundle_id': 'com.walletconnect.flutterwallet.internal',
          'link_mode':
              'https://appkit-lab.reown.com/flutter_walletkit_internal',
          'webapp_link': null,
          'app_store': null,
          'play_store': null,
          'rdns': 'com.walletconnect.flutterwallet.internal',
          'chrome_store': null,
          'description': 'Reown\'s Flutter sample wallet',
          'badge_type': 'certified'
        },
        {
          'platform': ['ios', 'android'], // added only for local purposes
          'id': '00003',
          'name': 'React Native Sample (internal)',
          'homepage': 'https://docs.reown.com',
          'image_id':
              'https://raw.githubusercontent.com/reown-com/reown_flutter/3d3dd152433104adae8a50671c062733abdc9fe3/packages/reown_appkit/lib/modal/assets/wallet_react_native.png',
          'order': 10,
          'mobile_link': 'rn-web3wallet-internal://wc',
          'desktop_link': null,
          'bundle_id': 'com.walletconnect.web3wallet.rnsample.internal',
          'link_mode': 'https://appkit-lab.reown.com/rn_walletkit_internal',
          'webapp_link': null,
          'app_store': null,
          'play_store': null,
          'rdns': 'com.walletconnect.web3wallet.rnsample.internal',
          'chrome_store': null,
          'description': 'Reown\'s React Native sample wallet',
          'badge_type': 'certified'
        },
        {
          'platform': ['android'], // added only for local purposes
          'id': '00004',
          'name': 'Kotlin Sample (Internal)',
          'homepage': 'https://docs.reown.com',
          'image_id':
              'https://raw.githubusercontent.com/reown-com/reown_flutter/3d3dd152433104adae8a50671c062733abdc9fe3/packages/reown_appkit/lib/modal/assets/wallet_kotlin.png',
          'order': 10,
          'mobile_link': 'kotlin-web3wallet://wc',
          'desktop_link': null,
          'bundle_id': 'com.reown.sample.wallet.internal',
          'link_mode': 'https://appkit-lab.reown.com/wallet_internal',
          'webapp_link': null,
          'app_store': null,
          'play_store': null,
          'rdns': 'com.reown.sample.wallet.internal',
          'chrome_store': null,
          'description': 'Reown\'s Kotlin sample wallet',
          'badge_type': 'certified'
        },
      ];

  static List<Map<String, dynamic>> _sampleWalletsProduction() => [
        {
          'platform': ['ios'], // added only for local purposes
          'id': '00001',
          'name': 'Swift Sample',
          'homepage': 'https://docs.reown.com',
          'image_id':
              'https://raw.githubusercontent.com/reown-com/reown_flutter/3d3dd152433104adae8a50671c062733abdc9fe3/packages/reown_appkit/lib/modal/assets/wallet_swift.png',
          'order': 10,
          'mobile_link': 'walletapp://',
          'desktop_link': null,
          'bundle_id': 'com.walletconnect.sample.wallet',
          'link_mode': 'https://lab.web3modal.com/wallet',
          'webapp_link': null,
          'app_store': null,
          'play_store': null,
          'rdns': 'com.walletconnect.sample.wallet',
          'chrome_store': null,
          'description': 'Reown\'s Swift sample wallet',
          'badge_type': 'certified'
        },
        {
          'platform': ['ios', 'android'], // added only for local purposes
          'id': '00002',
          'name': 'Flutter Sample',
          'homepage': 'https://docs.reown.com',
          'image_id':
              'https://raw.githubusercontent.com/reown-com/reown_flutter/3d3dd152433104adae8a50671c062733abdc9fe3/packages/reown_appkit/lib/modal/assets/wallet_flutter.png',
          'order': 10,
          'mobile_link': 'wcflutterwallet://wc',
          'desktop_link': null,
          'bundle_id': 'com.walletconnect.flutterwallet',
          'link_mode': 'https://appkit-lab.reown.com/flutter_walletkit',
          'webapp_link': null,
          'app_store': null,
          'play_store': null,
          'rdns': 'com.walletconnect.flutterwallet',
          'chrome_store': null,
          'description': 'Reown\'s Flutter sample wallet',
          'badge_type': 'certified'
        },
        {
          'platform': ['ios', 'android'], // added only for local purposes
          'id': '00003',
          'name': 'React Native Sample',
          'homepage': 'https://docs.reown.com',
          'image_id':
              'https://raw.githubusercontent.com/reown-com/reown_flutter/3d3dd152433104adae8a50671c062733abdc9fe3/packages/reown_appkit/lib/modal/assets/wallet_react_native.png',
          'order': 10,
          'mobile_link': 'rn-web3wallet://',
          'desktop_link': null,
          'bundle_id': 'com.walletconnect.web3wallet.rnsample',
          'link_mode': 'https://appkit-lab.reown.com/rn_walletkit',
          'webapp_link': null,
          'app_store': null,
          'play_store': null,
          'rdns': 'com.walletconnect.web3wallet.rnsample',
          'chrome_store': null,
          'description': 'Reown\'s React Native sample wallet',
          'badge_type': 'certified'
        },
        {
          'platform': ['android'], // added only for local purposes
          'id': '00004',
          'name': 'Kotlin Sample',
          'homepage': 'https://docs.reown.com',
          'image_id':
              'https://raw.githubusercontent.com/reown-com/reown_flutter/3d3dd152433104adae8a50671c062733abdc9fe3/packages/reown_appkit/lib/modal/assets/wallet_kotlin.png',
          'order': 10,
          'mobile_link': 'kotlin-web3wallet://wc',
          'bundle_id': 'com.reown.sample.wallet',
          'link_mode': 'https://appkit-lab.reown.com/wallet_release',
          'webapp_link': null,
          'app_store': null,
          'play_store': null,
          'rdns': 'com.reown.sample.wallet',
          'chrome_store': null,
          'description': 'Reown\'s Kotlin sample wallet',
          'badge_type': 'certified'
        },
      ];

  static Map<String, dynamic> _reactSampleWallet() => {
        'platform': ['ios', 'android'], // added only for local purposes
        'id': '00005',
        'name': 'React Web Sample',
        'homepage': 'https://react-wallet.walletconnect.com',
        'image_id':
            'https://raw.githubusercontent.com/reown-com/reown_flutter/3d3dd152433104adae8a50671c062733abdc9fe3/packages/reown_appkit/lib/modal/assets/wallet_react.png',
        'order': 10,
        'mobile_link': null,
        'desktop_link': null,
        'link_mode': null,
        'webapp_link': 'https://react-wallet.walletconnect.com',
        'app_store': null,
        'play_store': null,
        'rdns': null,
        'chrome_store': null,
        'description': 'Reown\'s React Web sample wallet',
        'badge_type': 'certified'
      };

  static List<ReownAppKitModalWalletInfo> getSampleWallets() {
    final wallets = _sampleWallets().map((entry) {
      final listing = Listing.fromJson(entry);
      return ReownAppKitModalWalletInfo(
        listing: listing,
        installed: false,
        recent: false,
      );
    });
    return wallets.whereType<ReownAppKitModalWalletInfo>().toList();
  }

  static List<Map<String, dynamic>> _sampleWallets() {
    return [_reactSampleWallet()];

    // String flavor = '-${const String.fromEnvironment('FLUTTER_APP_FLAVOR')}';
    // flavor = flavor.replaceAll('-production', '');

    // final platform = PlatformUtils.getPlatformExact().name;
    // final platformName = platform.toString().toLowerCase();

    // if (flavor.isNotEmpty) {
    //   return _sampleWalletsInternal().where((e) {
    //     return (e['platform'] as List<String>).contains(platformName);
    //   }).toList();
    // }
    // return _sampleWalletsProduction().where((e) {
    //   return (e['platform'] as List<String>).contains(platformName);
    // }).toList();
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
