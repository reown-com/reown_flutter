import 'package:flutter_test/flutter_test.dart';
// import 'package:reown_yttrium/reown_yttrium.dart';
import 'package:reown_yttrium/reown_yttrium_platform_interface.dart';
import 'package:reown_yttrium/reown_yttrium_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';

// class MockReownYttriumPlatform
//     with MockPlatformInterfaceMixin
//     implements ReownYttriumPlatform {

//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }

void main() {
  final ReownYttriumPlatform initialPlatform = ReownYttriumPlatform.instance;

  test('$MethodChannelReownYttrium is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelReownYttrium>());
  });

  test('getPlatformVersion', () async {
    // ReownYttrium reownYttriumPlugin = ReownYttrium();
    // MockReownYttriumPlatform fakePlatform = MockReownYttriumPlatform();
    // ReownYttriumPlatform.instance = fakePlatform;

    // expect(await reownYttriumPlugin.getPlatformVersion(), '42');
  });
}
