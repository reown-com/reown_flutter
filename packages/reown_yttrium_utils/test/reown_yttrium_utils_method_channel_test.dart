import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:reown_yttrium_utils/reown_yttrium_utils_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // MethodChannelReownYttriumUtils platform = MethodChannelReownYttriumUtils();
  const MethodChannel channel = MethodChannel('reown_yttrium_utils');

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
