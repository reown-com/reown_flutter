import 'dart:io';

import 'package:collection/collection.dart';
import 'package:reown_appkit/modal/models/public/appkit_wallet_info.dart';

class WCSampleWallets {
  static List<Map<String, dynamic>> sampleWalletsInternal() => [
        {
          'name': 'Swift Wallet',
          'platform': ['ios'],
          'id': '123456789012345678901234567890',
          'schema': 'walletapp://',
          'bundleId': 'com.walletconnect.sample.wallet',
          'universal': 'https://lab.web3modal.com/wallet',
        },
        {
          'name': 'Flutter Wallet (internal)',
          'platform': ['ios', 'android'],
          'id': '123456789012345678901234567895',
          'schema': 'wcflutterwallet-internal://',
          'bundleId': 'com.walletconnect.flutterwallet.internal',
          'universal':
              'https://dev.lab.web3modal.com/flutter_walletkit_internal',
        },
        {
          'name': 'RN Wallet (internal)',
          'platform': ['ios', 'android'],
          'id': '1234567890123456789012345678922',
          'schema': 'rn-web3wallet://wc',
          'bundleId': 'com.walletconnect.web3wallet.rnsample.internal',
          'universal': 'https://lab.web3modal.com/rn_walletkit',
        },
        {
          'name': 'Kotlin Wallet (Internal)',
          'platform': ['android'],
          'id': '123456789012345678901234567894',
          'schema': 'kotlin-web3wallet://wc',
          'bundleId': 'com.walletconnect.sample.wallet.internal',
          'universal':
              'https://web3modal-laboratory-git-chore-kotlin-assetlinks-walletconnect1.vercel.app/wallet_internal',
        },
      ];

  static List<Map<String, dynamic>> sampleWalletsProduction() => [
        {
          'name': 'Swift Wallet',
          'platform': ['ios'],
          'id': '123456789012345678901234567890',
          'schema': 'walletapp://',
          'bundleId': 'com.walletconnect.sample.wallet',
          'universal': 'https://lab.web3modal.com/wallet',
        },
        {
          'name': 'Flutter Wallet',
          'platform': ['ios', 'android'],
          'id': '123456789012345678901234567891',
          'schema': 'wcflutterwallet://',
          'bundleId': 'com.walletconnect.flutterwallet',
          'universal': 'https://lab.web3modal.com/flutter_walletkit',
        },
        {
          'name': 'RN Wallet',
          'platform': ['ios', 'android'],
          'id': '123456789012345678901234567892',
          'schema': 'rn-web3wallet://wc',
          'bundleId': 'com.walletconnect.web3wallet.rnsample',
          'universal': 'https://lab.web3modal.com/rn_walletkit',
        },
        {
          'name': 'Kotlin Wallet',
          'platform': ['android'],
          'id': '123456789012345678901234567893',
          'schema': 'kotlin-web3wallet://wc',
          'bundleId': 'com.walletconnect.sample.wallet',
          'universal':
              'https://web3modal-laboratory-git-chore-kotlin-assetlinks-walletconnect1.vercel.app/wallet_release',
        },
      ];

  static List<ReownAppKitModalWalletInfo> getSampleWallets() {
    final wallets = _getSampleWallets().mapIndexed((index, entry) {
      return ReownAppKitModalWalletInfo(
        listing: Listing.fromJson({
          'id': index,
          'name': entry['name'] as String?,
          'homepage': 'https://reown.com',
          'image_id':
              'https://raw.githubusercontent.com/reown-com/reown_flutter/develop/assets/walletkit_logo.png',
          'order': 10,
          'mobile_link': entry['schema'] as String?,
          'link_mode': entry['universal'] as String?,
        }),
        installed: false,
        recent: false,
      );
    }).toList();
    return wallets.whereType<ReownAppKitModalWalletInfo>().toList();
  }

  static List<Map<String, dynamic>> _getSampleWallets() {
    return sampleWalletsInternal().where((e) {
      return (e['platform'] as List<String>).contains(
        Platform.operatingSystem,
      );
    }).toList();
  }
}
