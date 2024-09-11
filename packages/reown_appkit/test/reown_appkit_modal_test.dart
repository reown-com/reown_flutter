import 'package:flutter_test/flutter_test.dart';

import 'package:reown_appkit/reown_appkit_platform_interface.dart';
import 'package:reown_appkit/reown_appkit_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockReownAppkitPlatform
    with MockPlatformInterfaceMixin
    implements ReownAppkitPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final ReownAppkitPlatform initialPlatform = ReownAppkitPlatform.instance;

  test('$MethodChannelReownAppkit is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelReownAppkit>());
  });

  test('getPlatformVersion', () async {
    // ReownAppkitModal reownAppkitPlugin = ReownAppkitModal();
    // MockReownAppkitPlatform fakePlatform = MockReownAppkitPlatform();
    // ReownAppkitPlatform.instance = fakePlatform;

    // expect(await reownAppkitPlugin.getPlatformVersion(), '42');
  });
}
