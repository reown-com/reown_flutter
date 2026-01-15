extension DateTimeExtension on DateTime {
  String get formatted {
    return '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
  }
}