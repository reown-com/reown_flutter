import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:package_info_plus/package_info_plus.dart';

class WalletconnectPayUtils {
  static String sdkName = 'walletconnectpay-flutter';
  static String baseUrl = 'https://api.pay.walletconnect.com';

  static String getOS() {
    if (kIsWeb) {
      return 'web-browser';
    } else {
      return <String>[
        Platform.operatingSystem,
        Platform.operatingSystemVersion,
      ].join('-');
    }
  }

  static Future<String> getPackageName() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.packageName;
  }

  static String getPlatform() {
    if (kIsWeb) {
      return 'web';
    } else {
      if (Platform.isAndroid) {
        return 'android';
      } else if (Platform.isIOS) {
        return 'ios';
      } else if (Platform.isLinux) {
        return 'linux';
      } else if (Platform.isMacOS) {
        return 'macos';
      } else if (Platform.isWindows) {
        return 'windows';
      } else {
        return 'unknown';
      }
    }
  }

  static String formatUA(String protocol, int version, String sdkVersion) {
    String os = getOS();
    String id = getPlatform();
    return <String>[
      [protocol, version].join('-'),
      coreSdkVersion(sdkVersion),
      os,
      id,
    ].join('/').toLowerCase();
  }

  static String coreSdkVersion(String sdkVersion) {
    return <String>['reown-flutter', sdkVersion].join('-');
  }
}
