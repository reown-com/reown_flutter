import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reown_appkit/modal/constants/string_constants.dart';
import 'package:reown_appkit/modal/services/explorer_service/models/redirect.dart';
import 'package:reown_appkit/modal/services/uri_service/url_utils.dart';
import 'package:reown_appkit/modal/utils/platform_utils.dart';
import 'package:reown_appkit/reown_appkit.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('plugins.flutter.io/url_launcher');
  const wcURI = 'wc:topic@2?relay-protocol=irn&symKey=symkey';
  const projectId = 'abcdef01234567890abcdef012345678';

  final launchedUrls = <String>[];

  UriService uriServiceWithProjectId(String id) {
    return UriService(core: ReownCore(projectId: id, memoryStore: true));
  }

  setUp(() {
    launchedUrls.clear();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          if (methodCall.method == 'launch') {
            launchedUrls.add(methodCall.arguments['url'] as String);
          }
          return true;
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  group('UriService openRedirect', () {
    test('social login url carries provider and projectId', () async {
      final service = uriServiceWithProjectId(projectId);

      await service.openRedirect(
        WalletRedirect(web: UrlConstants.webWalletUrl),
        wcURI: wcURI,
        pType: PlatformType.mobile,
        socialOption: AppKitSocialOption.Email,
      );

      final url = Uri.parse(launchedUrls.single);
      expect(url.queryParameters['provider'], 'email');
      expect(url.queryParameters['projectId'], projectId);
      expect(url.queryParameters['uri'], wcURI);
    });

    test('social login url omits projectId when it is blank', () async {
      final service = uriServiceWithProjectId('  ');

      await service.openRedirect(
        WalletRedirect(web: UrlConstants.webWalletUrl),
        wcURI: wcURI,
        pType: PlatformType.web,
        socialOption: AppKitSocialOption.Google,
      );

      final url = Uri.parse(launchedUrls.single);
      expect(url.queryParameters['provider'], 'google');
      expect(url.queryParameters.containsKey('projectId'), isFalse);
    });

    test('wallet deep link gets neither provider nor projectId', () async {
      final service = uriServiceWithProjectId(projectId);

      await service.openRedirect(
        WalletRedirect(mobile: 'somewallet://'),
        wcURI: wcURI,
        pType: PlatformType.mobile,
      );

      final url = Uri.parse(launchedUrls.single);
      expect(url.queryParameters.containsKey('provider'), isFalse);
      expect(url.queryParameters.containsKey('projectId'), isFalse);
      expect(url.queryParameters['uri'], wcURI);
    });
  });
}
