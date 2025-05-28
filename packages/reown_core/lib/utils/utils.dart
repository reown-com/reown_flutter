import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:typed_data';
import 'package:ed25519_edwards/ed25519_edwards.dart' as ed;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:reown_core/models/basic_models.dart';
import 'package:reown_core/relay_client/relay_client_models.dart';
import 'package:reown_core/models/uri_parse_result.dart';

class ReownCoreUtils {
  static bool isExpired(int expiry) {
    return DateTime.now().toUtc().compareTo(
              DateTime.fromMillisecondsSinceEpoch(
                toMilliseconds(expiry),
              ),
            ) >=
        0;
  }

  static DateTime expiryToDateTime(int expiry) {
    final milliseconds = expiry * 1000;
    return DateTime.fromMillisecondsSinceEpoch(milliseconds);
  }

  static int toMilliseconds(int seconds) {
    return seconds * 1000;
  }

  static int calculateExpiry(int offset) {
    return DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000 + offset;
  }

  static String getOS() {
    if (kIsWeb) {
      // TODO change this into an actual value
      return 'web-browser';
    } else {
      return <String>[Platform.operatingSystem, Platform.operatingSystemVersion]
          .join('-');
    }
  }

  static Future<String> getPackageName() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.packageName;
  }

  static String getId() {
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

  static String formatUA(
    String protocol,
    int version,
    String sdkVersion,
  ) {
    String os = getOS();
    String id = getId();
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

  static String formatRelayRpcUrl({
    required String protocol,
    required int version,
    required String relayUrl,
    required String sdkVersion,
    required String auth,
    String? projectId,
    String? packageName,
  }) {
    final Uri uri = Uri.parse(relayUrl);
    final Map<String, String> queryParams = Uri.splitQueryString(uri.query);
    final userAgent = formatUA(protocol, version, sdkVersion);

    // Add basic query params
    final Map<String, String> relayParams = {
      'auth': auth,
      'ua': userAgent,
    };

    // Add projectId query param
    if ((projectId ?? '').isNotEmpty) {
      relayParams['projectId'] = projectId!;
    }

    // Add bundleId, packageName or origin query param based on platform
    if ((packageName ?? '').isNotEmpty) {
      final platform = getId();
      if (platform == 'ios') {
        relayParams['bundleId'] = packageName!;
      } else if (platform == 'android') {
        relayParams['packageName'] = packageName!;
      } else {
        relayParams['origin'] = packageName!;
      }
    }

    queryParams.addAll(relayParams);
    return uri.replace(queryParameters: queryParams).toString();
  }

  /// ---- URI HANDLING --- ///

  static URIParseResult parseUri(Uri uri) {
    String protocol = uri.scheme;
    String path = uri.path;
    final List<String> splitParams = path.split('@');
    if (splitParams.length == 1) {
      throw const ReownCoreError(
        code: 0,
        message: 'Invalid URI: Missing @',
      );
    }
    List<String> methods = (uri.queryParameters['methods'] ?? '')
        // Replace all the square brackets with empty string, split by comma
        .replaceAll(RegExp(r'[\[\]"]+'), '')
        .split(',');
    if (methods.length == 1 && methods[0].isEmpty) {
      methods = [];
    }
    final URIVersion? version;
    switch (splitParams[1]) {
      case '1':
        version = URIVersion.v1;
        break;
      case '2':
        version = URIVersion.v2;
        break;
      default:
        version = null;
    }
    final URIV1ParsedData? v1Data;
    final URIV2ParsedData? v2Data;
    if (version == URIVersion.v1) {
      v1Data = URIV1ParsedData(
        key: uri.queryParameters['key']!,
        bridge: uri.queryParameters['bridge']!,
      );
      v2Data = null;
    } else {
      v1Data = null;
      v2Data = URIV2ParsedData(
        symKey: uri.queryParameters['symKey']!,
        relay: Relay(
          uri.queryParameters['relay-protocol']!,
          data: uri.queryParameters.containsKey('relay-data')
              ? uri.queryParameters['relay-data']
              : null,
        ),
        methods: methods,
      );
    }

    URIParseResult ret = URIParseResult(
      protocol: protocol,
      version: version,
      topic: splitParams[0],
      v1Data: v1Data,
      v2Data: v2Data,
    );
    return ret;
  }

  static Map<String, String> formatRelayParams(
    Relay relay, {
    String delimiter = '-',
  }) {
    Map<String, String> params = {};
    params[['relay', 'protocol'].join(delimiter)] = relay.protocol;
    if (relay.data != null) {
      params[['relay', 'data'].join(delimiter)] = relay.data!;
    }
    return params;
  }

  static Uri formatUri({
    required String protocol,
    required String version,
    required String topic,
    required String symKey,
    required Relay relay,
    required List<List<String>>? methods,
    int? expiry,
  }) {
    Map<String, String> params = formatRelayParams(relay);
    params['symKey'] = symKey;
    if (methods != null) {
      final uriMethods = methods.expand((e) => e).toList();
      params['methods'] =
          uriMethods.map((e) => jsonEncode(e)).join(',').replaceAll('"', '');
    }

    if (expiry != null) {
      params['expiryTimestamp'] = expiry.toString();
    }

    return Uri(
      scheme: protocol,
      path: '$topic@$version',
      queryParameters: params,
    );
  }

  static Map<String, T> convertMapTo<T>(Map<String, dynamic> inMap) {
    Map<String, T> m = {};
    for (var entry in inMap.entries) {
      m[entry.key] = entry.value as T;
    }
    return m;
  }

  static String getSearchParamFromURL(String url, String param) {
    final decodedUri = Uri.parse(Uri.decodeFull(url));
    final hasParam = decodedUri.queryParameters.keys.contains(param);
    if (!hasParam) return '';

    return Uri.encodeQueryComponent(decodedUri.queryParameters[param]!);
  }

  static String getLinkModeURL(
    String universalLink,
    String topic,
    String encodedEnvelope,
  ) {
    return '$universalLink?wc_ev=$encodedEnvelope&topic=$topic';
  }

  static Future<bool> canOpenUrl(String url) async {
    return await canLaunchUrlString(url);
  }

  static Future<bool> openURL(
    String url, [
    LaunchMode mode = LaunchMode.externalApplication,
  ]) async {
    try {
      final success = await launchUrlString(url, mode: mode);
      if (!success) {
        throw ReownCoreError(code: 3000, message: 'Can not open $url');
      }
      return true;
    } catch (_) {
      throw ReownCoreError(code: 3001, message: 'Can not open $url');
    }
  }

  static bool ed25519Verify(
    ed.PublicKey publicKey,
    Uint8List message,
    Uint8List sig,
  ) {
    return ed.verify(publicKey, message, sig);
  }

  static dynamic recursiveSearchForMapKey(
    Map<String, dynamic> map,
    String targetKey,
  ) {
    try {
      for (final entry in map.entries) {
        if (entry.key.toString() == targetKey) {
          return entry.value;
        } else if (entry.value is Map<String, dynamic>) {
          final result = recursiveSearchForMapKey(entry.value, targetKey);
          if (result != null) return result;
        } else if (entry.value is List) {
          for (final element in entry.value) {
            if (element is Map<String, dynamic>) {
              final result = recursiveSearchForMapKey(element, targetKey);
              if (result != null) return result;
            }
          }
        }
      }
    } catch (e) {
      throw ArgumentError('recursiveSearchForMapKey error $e');
    }
    return null;
  }

  static dynamic recursiveSearchForMapKey(
    Map<String, dynamic> map,
    String targetKey,
  ) {
    try {
      for (final entry in map.entries) {
        if (entry.key.toString() == targetKey) {
          return entry.value;
        } else if (entry.value is Map<String, dynamic>) {
          final result = recursiveSearchForMapKey(entry.value, targetKey);
          if (result != null) return result;
        } else if (entry.value is List) {
          for (final element in entry.value) {
            if (element is Map<String, dynamic>) {
              final result = recursiveSearchForMapKey(element, targetKey);
              if (result != null) return result;
            }
          }
        }
      }
    } catch (e) {
      throw ArgumentError('recursiveSearchForMapKey error $e');
    }
    return null;
  }
}
