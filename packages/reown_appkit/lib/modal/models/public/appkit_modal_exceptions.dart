class ReownAppKitModalException implements Exception {
  final dynamic message;
  final dynamic stackTrace;
  ReownAppKitModalException(this.message, [this.stackTrace]) : super();
}
