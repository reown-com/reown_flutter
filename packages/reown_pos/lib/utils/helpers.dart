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

typedef CheckResponse = (String, String?);

enum ErrorStep {
  connection,
  payment,
  statusCheck,
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
