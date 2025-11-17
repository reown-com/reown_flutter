import 'package:flutter_test/flutter_test.dart';
// import 'package:reown_yttrium_utils/reown_yttrium_utils.dart';
import 'package:reown_yttrium_utils/reown_yttrium_utils_platform_interface.dart';
import 'package:reown_yttrium_utils/reown_yttrium_utils_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';

// class MockReownYttriumPlatform
//     with MockPlatformInterfaceMixin
//     implements ReownYttriumPlatform {

//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }

void main() {
  final ReownYttriumUtilsPlatform initialPlatform =
      ReownYttriumUtilsPlatform.instance;

  test('$MethodChannelReownYttriumUtils is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelReownYttriumUtils>());
  });

  test('getPlatformVersion', () async {
    // ReownYttriumUtils reownYttriumPlugin = ReownYttriumUtils();
    // MockReownYttriumPlatform fakePlatform = MockReownYttriumPlatform();
    // ReownYttriumPlatform.instance = fakePlatform;

    // expect(await reownYttriumPlugin.getPlatformVersion(), '42');
  });
}
