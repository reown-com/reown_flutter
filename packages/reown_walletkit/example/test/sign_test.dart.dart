import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
// import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/dependencies/bottom_sheet/bottom_sheet_service.dart';
import 'package:reown_walletkit_wallet/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/cosmos_service.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/evm_service.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/kadena_service.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/polkadot_service.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/solana_service.dart';
import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/dependencies/key_service/i_key_service.dart';
import 'package:reown_walletkit_wallet/dependencies/key_service/key_service.dart';
import 'package:reown_walletkit_wallet/dependencies/walletkit_service.dart';
import 'package:reown_walletkit_wallet/models/chain_data.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:eth_sig_util/util/utils.dart' as eth_sig_util_util;
import 'package:eth_sig_util/util/bigint.dart' as eth_bigint_util;
import 'package:eth_sig_util/eth_sig_util.dart' as eth_sig_util;

Map<String, dynamic> get _mockInitialValues => {
      'appName': 'reown_core',
      'packageName': 'com.reown.flutterdapp',
      'version': '1.0',
      'buildNumber': '2',
      'buildSignature': 'buildSignature',
    };

mockPackageInfo() {
  PackageInfo.setMockInitialValues(
    appName: _mockInitialValues['appName'],
    packageName: _mockInitialValues['packageName'],
    version: _mockInitialValues['version'],
    buildNumber: _mockInitialValues['buildNumber'],
    buildSignature: _mockInitialValues['buildSignature'],
  );
}

mockConnectivity([List<dynamic> values = const ['wifi']]) {
  const channel = MethodChannel('dev.fluttercommunity.plus/connectivity');
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMessageHandler(
    channel.name,
    (data) async {
      final call = channel.codec.decodeMethodCall(data);
      if (call.method == 'getAll') {
        return channel.codec.encodeSuccessEnvelope(_mockInitialValues);
      }
      if (call.method == 'check') {
        return channel.codec.encodeSuccessEnvelope(values);
      }
      return null;
    },
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  mockPackageInfo();
  mockConnectivity();

  late final String chainId;

  Future<void> initialize() async {
    GetIt.I.registerSingleton<IBottomSheetService>(BottomSheetService());
    final keyService = KeyService();
    await keyService.init();
    GetIt.I.registerSingleton<IKeyService>(keyService);

    final walletKitService = WalletKitService();
    await walletKitService.create();
    GetIt.I.registerSingleton<IWalletKitService>(walletKitService);

    // Support EVM Chains
    for (final chainData in ChainsDataList.eip155Chains) {
      GetIt.I.registerSingleton<EVMService>(
        EVMService(chainSupported: chainData),
        instanceName: chainData.chainId,
      );
    }

    // Support Kadena Chains
    for (final chainData in ChainsDataList.kadenaChains) {
      GetIt.I.registerSingleton<KadenaService>(
        KadenaService(chainSupported: chainData),
        instanceName: chainData.chainId,
      );
    }

    // Support Polkadot Chains
    for (final chainData in ChainsDataList.polkadotChains) {
      GetIt.I.registerSingleton<PolkadotService>(
        PolkadotService(chainSupported: chainData),
        instanceName: chainData.chainId,
      );
    }

    // Support Solana Chains
    // Change SolanaService to SolanaService2 to switch between `solana` package and `solana_web3` package
    for (final chainData in ChainsDataList.solanaChains) {
      GetIt.I.registerSingleton<SolanaService>(
        SolanaService(chainSupported: chainData),
        instanceName: chainData.chainId,
      );
    }

    // Support Cosmos Chains
    for (final chainData in ChainsDataList.cosmosChains) {
      GetIt.I.registerSingleton<CosmosService>(
        CosmosService(chainSupported: chainData),
        instanceName: chainData.chainId,
      );
    }

    await walletKitService.init();

    chainId = ChainsDataList.eip155Chains.first.chainId;
  }

  setUpAll(() async => await initialize());

  test('signHash', () {
    final evmService = GetIt.I.get<EVMService>(instanceName: chainId);

    final signature = evmService.signHash(
      '0xaceca6583d6e6afa780127d5125edf94b157b2685ff81116339d0ca6752937a4', // hash to sign
      '0x2727fcadfbc14134d6cfd50c2cb70e85870e16b32ca790822ea3d75e6e8b72a3', // pk
    );

    expect(signature,
        '0xf7d4d35037d8cf5c757f0761fe84e312ba40a9493e868b5d3066b84a8dfc1bbb13dafc39e0dd6ef6a44cf17007580ef3ec8051097bfdab3996070971ae5cb13a1b');
  });

  test('isValidHashSignature', () {
    final evmService = GetIt.I.get<EVMService>(instanceName: chainId);

    final isValid = evmService.isValidSignature(
      '0xaceca6583d6e6afa780127d5125edf94b157b2685ff81116339d0ca6752937a4',
      '0xf7d4d35037d8cf5c757f0761fe84e312ba40a9493e868b5d3066b84a8dfc1bbb13dafc39e0dd6ef6a44cf17007580ef3ec8051097bfdab3996070971ae5cb13a1b',
      '0x2727fcadfbc14134d6cfd50c2cb70e85870e16b32ca790822ea3d75e6e8b72a3',
    );

    expect(isValid, true);
  });

  test('SignatureUtil.fromRpcSig', () {
    final ecdsaSignature = eth_sig_util.SignatureUtil.fromRpcSig(
      '0xf7d4d35037d8cf5c757f0761fe84e312ba40a9493e868b5d3066b84a8dfc1bbb13dafc39e0dd6ef6a44cf17007580ef3ec8051097bfdab3996070971ae5cb13a1b',
    );

    expect(
      eth_sig_util_util.bytesToHex(eth_bigint_util.encodeBigInt(
        ecdsaSignature.r,
      )),
      'f7d4d35037d8cf5c757f0761fe84e312ba40a9493e868b5d3066b84a8dfc1bbb',
    );

    expect(
      eth_sig_util_util.bytesToHex(eth_bigint_util.encodeBigInt(
        ecdsaSignature.s,
      )),
      '13dafc39e0dd6ef6a44cf17007580ef3ec8051097bfdab3996070971ae5cb13a',
    );

    expect(ecdsaSignature.v, 27);
  });

  // test('toPrimitive', () {
  //   final ecdsaSignature =
  //       '0xf7d4d35037d8cf5c757f0761fe84e312ba40a9493e868b5d3066b84a8dfc1bbb13dafc39e0dd6ef6a44cf17007580ef3ec8051097bfdab3996070971ae5cb13a1b'
  //           .toPrimitiveSignature();

  //   expect(
  //     ecdsaSignature.r,
  //     'f7d4d35037d8cf5c757f0761fe84e312ba40a9493e868b5d3066b84a8dfc1bbb',
  //   );

  //   expect(
  //     ecdsaSignature.s,
  //     '13dafc39e0dd6ef6a44cf17007580ef3ec8051097bfdab3996070971ae5cb13a',
  //   );

  //   expect(ecdsaSignature.yParity, false);
  // });
}
