import 'package:collection/collection.dart';
import 'package:reown_appkit/modal/models/public/appkit_wallet_info.dart';
import 'package:reown_appkit/modal/utils/platform_utils.dart';

class WCSampleWallets {
  static List<Map<String, dynamic>> _sampleWalletsInternal() => [
        {
          'name': 'SW Wallet (internal)',
          'platform': ['ios'],
          'id': '123456789012345678901234567890',
          'mobile_link': 'walletapp://',
          'bundle_id': 'com.walletconnect.sample.wallet',
          'link_mode': 'https://appkit-lab.reown.com/wallet',
        },
        {
          'name': 'FL Wallet (internal)',
          'platform': ['ios', 'android'],
          'id': '123456789012345678901234567895',
          'mobile_link': 'wcflutterwallet-internal://',
          'bundle_id': 'com.walletconnect.flutterwallet.internal',
          'link_mode':
              'https://appkit-lab.reown.com/flutter_walletkit_internal',
        },
        {
          'name': 'RN Wallet (internal)',
          'platform': ['ios', 'android'],
          'id': '1234567890123456789012345678922',
          'mobile_link': 'rn-web3wallet-internal://',
          'bundle_id': 'com.walletconnect.web3wallet.rnsample.internal',
          'link_mode': 'https://appkit-lab.reown.com/rn_walletkit_internal',
        },
        {
          'name': 'KT Wallet (Internal)',
          'platform': ['android'],
          'id': '123456789012345678901234567894',
          'mobile_link': 'kotlin-web3wallet://wc',
          'bundle_id': 'com.walletconnect.sample.wallet.internal',
          'link_mode': 'https://appkit-lab.reown.com/wallet_internal',
        },
        {
          'name': 'Web Wallet (Internal)',
          'platform': ['ios', 'android'],
          'id': '123456789012345678901234567888',
          // 'mobile_link': 'https://',
          'webapp_link':
              'https://chore-web-wallet-imp.appkit-web-wallet.pages.dev',
        },
      ];

  static List<Map<String, dynamic>> _sampleWalletsProduction() => [
        {
          'name': 'SW Wallet',
          'platform': ['ios'],
          'id': '123456789012345678901234567890',
          'mobile_link': 'walletapp://',
          'bundle_id': 'com.walletconnect.sample.wallet',
          'link_mode': 'https://appkit-lab.reown.com/wallet',
        },
        {
          'name': 'FL Wallet',
          'platform': ['ios', 'android'],
          'id': '123456789012345678901234567891',
          'mobile_link': 'wcflutterwallet://',
          'bundle_id': 'com.walletconnect.flutterwallet',
          'link_mode': 'https://appkit-lab.reown.com/flutter_walletkit',
        },
        {
          'name': 'RN Wallet',
          'platform': ['ios', 'android'],
          'id': '123456789012345678901234567892',
          'mobile_link': 'rn-web3wallet://',
          'bundle_id': 'com.walletconnect.web3wallet.rnsample',
          'link_mode': 'https://appkit-lab.reown.com/rn_walletkit',
        },
        {
          'name': 'KT Wallet',
          'platform': ['android'],
          'id': '123456789012345678901234567893',
          'mobile_link': 'kotlin-web3wallet://wc',
          'bundle_id': 'com.walletconnect.sample.wallet',
          'link_mode': 'https://appkit-lab.reown.com/wallet_release',
        },
        {
          'name': 'Web Wallet',
          'platform': ['ios', 'android'],
          'id': '123456789012345678901234567888',
          // 'mobile_link': 'https://',
          'webapp_link':
              'https://chore-web-wallet-imp.appkit-web-wallet.pages.dev',
        },
      ];

  static List<ReownAppKitModalWalletInfo> getSampleWallets() {
    final wallets = _sampleWallets().map((entry) {
      final id = entry['id'] as String?;
      final name = entry['name'] as String?;
      final mobileLink = entry['mobile_link'] as String?;
      final desktopLink = entry['desktop_link'] as String?;
      final linkMode = entry['link_mode'] as String?;
      final bundle_id = entry['bundle_id'] as String?;
      final webAppLink = entry['webapp_link'] as String?;
      return ReownAppKitModalWalletInfo(
        listing: Listing.fromJson({
          'id': id,
          'name': name,
          'homepage': 'https://reown.com',
          'image_id':
              'https://raw.githubusercontent.com/reown-com/reown_flutter/develop/assets/walletkit_logo.png',
          'order': 1,
          'mobile_link': mobileLink,
          'desktop_link': desktopLink,
          'link_mode': linkMode,
          'webapp_link': webAppLink,
          'app_store': 'https://apps.apple.com/app/apple-store/id$id',
          'play_store':
              'https://play.google.com/store/apps/details?id=$bundle_id',
          'description': 'Reown sample Wallet',
          'badge_type': 'certified',
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
