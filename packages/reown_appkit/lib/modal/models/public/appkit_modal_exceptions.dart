class AppKitModalException implements Exception {
  final dynamic message;
  final dynamic stackTrace;
  AppKitModalException(this.message, [this.stackTrace]) : super();
}
