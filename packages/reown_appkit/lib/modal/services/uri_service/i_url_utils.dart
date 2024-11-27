import 'package:reown_appkit/modal/utils/platform_utils.dart';
import 'package:reown_appkit/modal/services/explorer_service/models/redirect.dart';

abstract class IUriService {
  const IUriService();

  Future<bool> isInstalled(String? uri, {String? id});

  Future<bool> launchUrl(Uri url, {dynamic mode});

  Future<bool> openRedirect(
    WalletRedirect redirect, {
    String? wcURI,
    PlatformType? pType,
  });
}
