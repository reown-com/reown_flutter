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
  status,
}
