import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:reown_yttrium/models/chain_abstraction.dart';
import 'package:reown_yttrium/reown_yttrium.dart';
import 'package:reown_yttrium/reown_yttrium_platform_interface.dart';
import 'package:reown_yttrium/reown_yttrium_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockReownYttriumPlatform
    with MockPlatformInterfaceMixin
    implements ReownYttriumPlatform {
  @override
  Future<bool> init({
    required String projectId,
    required PulseMetadataCompat pulseMetadata,
  }) =>
      Future.value(true);

  @override
  Future<String> erc20TokenBalance(
      {required String chainId, required String token, required String owner}) {
    // TODO: implement erc20TokenBalance
    throw UnimplementedError();
  }

  @override
  Future<Eip1559EstimationCompat> estimateFees({required String chainId}) {
    // TODO: implement estimateFees
    throw UnimplementedError();
  }

  @override
  Future<ExecuteDetailsCompat> execute(
      {required UiFieldsCompat uiFields,
      required List<PrimitiveSignatureCompat> routeTxnSigs,
      required PrimitiveSignatureCompat initialTxnSig}) {
    // TODO: implement execute
    throw UnimplementedError();
  }

  @override
  Future<PrepareDetailedResponseCompat> prepareDetailed(
      {required String chainId,
      required String from,
      required CallCompat call,
      required Currency localCurrency}) {
    // TODO: implement prepareDetailed
    throw UnimplementedError();
  }
}

void main() {
  final ReownYttriumPlatform initialPlatform = ReownYttriumPlatform.instance;

  test('$MethodChannelReownYttrium is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelReownYttrium>());
  });

  test('getPlatformVersion', () async {
    ReownYttrium reownYttriumPlugin = ReownYttrium();
    MockReownYttriumPlatform fakePlatform = MockReownYttriumPlatform();
    ReownYttriumPlatform.instance = fakePlatform;

    expect(
        await reownYttriumPlugin.init(
          projectId: '07429c7285515de0715980519ef2e148',
          pulseMetadata: PulseMetadataCompat(
            sdkVersion: '0.0.1',
            sdkPlatform: Platform.operatingSystem,
          ),
        ),
        true);
  });
}
