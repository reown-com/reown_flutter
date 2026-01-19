import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:walletconnect_pay/version.dart' show packageVersion;

class WalletconnectPayUtils {
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

  static String getBaseUrl() {
    return 'https://api.pay.walletconnect.com';
  }

  static String getSdkName() {
    return 'flutter-walletconnect-pay';
  }

  static String getSdkVersion() {
    return packageVersion;
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
