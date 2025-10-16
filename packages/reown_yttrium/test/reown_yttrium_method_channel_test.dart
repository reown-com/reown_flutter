import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:reown_yttrium/reown_yttrium_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // MethodChannelReownYttrium platform = MethodChannelReownYttrium();
  const MethodChannel channel = MethodChannel('reown_yttrium');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          return '42';
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    // expect(await platform.getPlatformVersion(), '42');
  });
}
