import 'package:logger/logger.dart';

enum LogLevel {
  all,
  debug,
  info,
  error,
  nothing;

  Level toLevel() {
    switch (this) {
      case LogLevel.all:
        return Level.all;
      case LogLevel.debug:
        return Level.debug;
      case LogLevel.info:
        return Level.info;
      case LogLevel.error:
        return Level.error;
      default:
        return Level.off;
    }
  }
}
