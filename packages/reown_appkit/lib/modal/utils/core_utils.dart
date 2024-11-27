import 'package:reown_appkit/modal/constants/string_constants.dart';
import 'package:reown_appkit/reown_appkit.dart';

class CoreUtils {
  static bool isValidProjectID(String projectId) {
    return RegExp(r'^[0-9a-fA-F]{32}$').hasMatch(projectId);
  }

  static bool isValidEmail(String email) {
    if (email.contains(' ')) return false;
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email);
  }

  static bool isHttpUrl(String url) {
    return url.startsWith('http://') || url.startsWith('https://');
  }

  static String createPlainUrl(String url) {
    if (url.isEmpty) return url;

    String plainUrl = url;
    if (!plainUrl.endsWith('/')) {
      plainUrl = '$url/';
    }
    return plainUrl;
  }

  static String createSafeUrl(String url) {
    if (url.isEmpty) return url;

    String safeUrl = url;
    if (!safeUrl.contains('://')) {
      safeUrl = url.replaceAll('/', '').replaceAll(':', '');
      safeUrl = '$safeUrl://';
    } else {
      final parts = safeUrl.split('://');
      if (parts.last.isNotEmpty && parts.last != 'wc') {
        if (!safeUrl.endsWith('/')) {
          return '$safeUrl/';
        }
        return safeUrl;
      } else {
        safeUrl = url.replaceFirst('://wc', '://');
      }
    }
    return safeUrl;
  }

  static Uri? formatCustomSchemeUri(String? appUrl, String? wcUri) {
    if (appUrl == null || appUrl.isEmpty) return null;

    if (isHttpUrl(appUrl)) {
      return formatWebUrl(appUrl, wcUri);
    }

    final safeAppUrl = createSafeUrl(appUrl);

    if (wcUri == null) {
      return Uri.parse(safeAppUrl);
    }

    final encodedWcUrl = Uri.encodeComponent(wcUri);

    return Uri.parse('${safeAppUrl}wc?uri=$encodedWcUrl');
  }

  static Uri? formatWebUrl(String? appUrl, String? wcUri) {
    if (appUrl == null || appUrl.isEmpty) return null;

    if (!isHttpUrl(appUrl)) {
      return formatCustomSchemeUri(appUrl, wcUri);
    }
    String plainAppUrl = createPlainUrl(appUrl);

    if (wcUri == null) {
      return Uri.parse(plainAppUrl);
    }

    final encodedWcUrl = Uri.encodeComponent(wcUri);

    return Uri.parse('${plainAppUrl}wc?uri=$encodedWcUrl');
  }

  static String formatChainBalance(double? chainBalance, {int precision = 3}) {
    if (chainBalance == null) {
      return '_.'.padRight(precision + 1, '_');
    }
    if (chainBalance == 0.0) {
      return '0.'.padRight(precision + 2, '0');
    }
    return chainBalance.toStringAsPrecision(precision)
      ..replaceAll(RegExp(r'([.]*0+)(?!.*\d)'), '');
  }

  static String getUserAgent() {
    String userAgent = '${CoreConstants.X_SDK_TYPE}/'
        '${CoreConstants.X_SDK_VERSION}/'
        '${CoreConstants.X_CORE_SDK_VERSION}/'
        '${ReownCoreUtils.getOS()}';
    //
    return userAgent;
  }

  static Map<String, String> getAPIHeaders(
    String projectId, [
    String? referer,
    String? origin,
  ]) {
    return {
      'x-project-id': projectId,
      'x-sdk-type': CoreConstants.X_SDK_TYPE,
      'x-sdk-version': CoreConstants.X_SDK_VERSION,
      'user-agent': getUserAgent(),
      if (referer != null) 'referer': referer,
      if (origin != null) 'origin': origin,
    };
  }
}
