import 'package:appcheck/appcheck.dart';
import 'package:reown_appkit/modal/services/uri_service/i_url_utils.dart';
import 'package:reown_appkit/modal/services/uri_service/launch_url_exception.dart';
import 'package:reown_appkit/modal/utils/core_utils.dart';
import 'package:reown_appkit/modal/utils/platform_utils.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:reown_appkit/modal/services/explorer_service/models/redirect.dart';

class UriService extends IUriService {
  UriService({required IReownCore core}) : _core = core;
  final IReownCore _core;

  @override
  Future<bool> isInstalled(String? uri, {String? id, String? androidAppId}) async {
    if (PlatformUtils.canDetectInstalledApps()) {
      final p = PlatformUtils.getPlatformExact();
      try {
        if (p == PlatformExact.android) {
          return await _androidAppCheck(uri, androidAppId);
        } else if (p == PlatformExact.ios &&
            uri != null &&
            uri.isNotEmpty &&
            // If the wallet is just a generic wc:// then it is not installed
            !uri.startsWith('wc://')) {
          return await ReownCoreUtils.canOpenUrl(Uri.parse(uri).toString());
        }
      } on FormatException catch (e) {
        if (id != null) {
          _core.logger.i('[$runtimeType] $uri ($id): ${e.message}');
        } else {
          _core.logger.i('[$runtimeType] $uri: ${e.message}');
        }
      } catch (e) {
        rethrow;
      }
    }

    return false;
  }

  @override
  Future<bool> launchUrl(Uri url, {dynamic mode}) async {
    return await _launchUrlFunc(url);
  }

  @override
  Future<bool> openRedirect(
    WalletRedirect redirect, {
    String? wcURI,
    PlatformType? pType,
    AppKitSocialOption? socialOption,
  }) async {
    //
    Uri? uriToOpen;
    try {
      final isMobile = (redirect.mobileOnly || pType == PlatformType.mobile);
      if (isMobile && redirect.mobile != null) {
        uriToOpen = CoreUtils.formatCustomSchemeUri(redirect.mobile, wcURI);
      }
      //
      final isDesktop = (redirect.desktopOnly || pType == PlatformType.desktop);
      if (isDesktop && redirect.desktop != null) {
        uriToOpen = CoreUtils.formatCustomSchemeUri(redirect.desktop, wcURI);
      }
      //
      final isWeb = (redirect.webOnly || pType == PlatformType.web);
      if (isWeb && redirect.web != null) {
        uriToOpen = CoreUtils.formatWebUrl(redirect.web, wcURI);
      }
    } catch (e) {
      _core.logger.e('Error opening redirect', error: e);
      return false;
    }
    if (socialOption != null && uriToOpen != null) {
      final social = Uri.encodeComponent(socialOption.name.toLowerCase());
      final separator = uriToOpen.hasQuery ? '&' : '?';
      var url = '${uriToOpen.toString()}${separator}provider=$social';
      final projectId = _core.projectId.trim();
      if (projectId.isNotEmpty) {
        url = '$url&projectId=${Uri.encodeComponent(projectId)}';
      }
      uriToOpen = Uri.parse(url);
    }
    _core.logger.i('[$runtimeType] openRedirect $uriToOpen');
    return await _launchUrlFunc(uriToOpen!);
  }

  Future<bool> _launchUrlFunc(Uri url) async {
    try {
      final success = await ReownCoreUtils.openURL(url.toString());
      if (!success) {
        throw CanNotLaunchUrl();
      }
      return true;
    } catch (e) {
      throw CanNotLaunchUrl();
    }
  }

  Future<bool> _androidAppCheck(String? uri, String? androidAppId) async {
    try {
      if (androidAppId != null && androidAppId.isNotEmpty) {
        if (await AppCheck().isAppInstalled(androidAppId) ||
            await AppCheck().isAppEnabled(androidAppId)) {
          return true;
        }
      }
      // If the wallet is just a generic wc:// then it is not installed
      if (uri == null || uri.isEmpty || uri.startsWith('wc://')) {
        return false;
      }
      return await AppCheck().isAppInstalled(uri) ||
          await AppCheck().isAppEnabled(uri);
    } catch (e) {
      return false;
    }
  }
}
