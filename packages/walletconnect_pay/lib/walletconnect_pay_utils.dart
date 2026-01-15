import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:package_info_plus/package_info_plus.dart';

class WalletconnectPayUtils {
  static String sdkName = 'flutter-walletconnect-pay';
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
}
