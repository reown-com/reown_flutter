import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

/// Gets the environment string safely for both web and native platforms
String get environment {
  if (kIsWeb) return 'web';
  try {
    return Platform.environment['FLUTTER_ENV'] ?? 'mobile';
  } catch (e) {
    return 'mobile';
  }
}

///
/// (status, txid?)
///
typedef CheckResponse = (String, String?);

enum ErrorStep { connection, payment, statusCheck }

// statuses responses from check status endpoint, timeout is added locally
enum StatusCheck {
  confirmed,
  pending,
  failed,
  timeout;

  String get value {
    return name.toUpperCase();
  }
}

List<String> splitComplex(String input) {
  final parts = input.split(RegExp(r'[,:]')); // split on either : or ,
  final uppercase = parts.map((s) => s.toUpperCase());
  final noSpace = uppercase.map((s) => s.replaceAll(' ', '_'));
  final camelCase = noSpace.map((s) => toCamelCase(s.trim()));
  return camelCase.where((s) => s.isNotEmpty).toList();
}

String toCamelCase(String input) {
  // Trim leading/trailing underscores, lowercase everything,
  // then uppercase the first letter after each underscore.
  final normalized = input.trim().replaceAll(RegExp(r'^_+|_+$'), '');
  final lower = normalized.toLowerCase();
  return lower.replaceAllMapped(
    RegExp(r'_+([a-z0-9])'),
    (m) => m[1]!.toUpperCase(),
  );
}

/// "unableToParseAmountWith6Decimals" -> "Unable To Parse Amount With 6 Decimals"
/// "parseHTTPResponse2xx" -> "Parse HTTP Response 2xx"
String camelToTitle(String input) {
  if (input.isEmpty) return input;

  // Split on boundaries: a) lower/digit -> Upper, b) ACRONYM -> Word,
  // c) letter <-> digit. Also handle stray '_' or '-' just in case.
  final words = input
      .replaceAll(RegExp(r'[_\-]+'), ' ')
      .split(
        RegExp(
          r'(?<=[a-z0-9])(?=[A-Z])' // fooBar
          r'|(?<=[A-Z])(?=[A-Z][a-z])' // HTTPResponse
          r'|(?<=[A-Za-z])(?=[0-9])' // value2
          r'|(?<=[0-9])(?=[A-Za-z])', // 2value
        ),
      )
      .expand((w) => w.split(' '))
      .where((w) => w.isNotEmpty)
      .toList();

  String toWord(String s) {
    final isAcronym = s.length > 1 && !s.contains(RegExp(r'[a-z]'));
    return isAcronym ? s : s[0].toUpperCase() + s.substring(1).toLowerCase();
  }

  return words.map(toWord).join(' ');
}

String camelToSentence(String input) {
  final title = camelToTitle(input);
  return title.isEmpty
      ? title
      : title[0].toUpperCase() + title.substring(1).toLowerCase();
}
