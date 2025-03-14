import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reown_yttrium/models/chain_abstraction.dart';
import 'package:reown_yttrium/reown_yttrium_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelReownYttrium platform = MethodChannelReownYttrium();
  const MethodChannel channel = MethodChannel('reown_yttrium');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('init', () async {
    expect(
        await platform.init(
          projectId: '07429c7285515de0715980519ef2e148',
          pulseMetadata: PulseMetadataCompat(
            sdkVersion: '0.0.1',
            sdkPlatform: Platform.operatingSystem,
          ),
        ),
        true);
  });
}
