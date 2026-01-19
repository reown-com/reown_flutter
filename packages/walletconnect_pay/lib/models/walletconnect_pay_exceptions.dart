import 'package:flutter/services.dart';

///
/// Exceptions
///

abstract class PayError extends PlatformException {
  PayError({
    required super.code,
    required super.message,
    required super.details,
    required super.stacktrace,
  });
}

class PayInitializeError extends PayError {
  PayInitializeError({
    required super.code,
    required super.message,
    required super.details,
    required super.stacktrace,
  });

  @override
  String toString() =>
      'PayInitializeError($code, $message, $details, $stacktrace)';
}

class GetPaymentOptionsError extends PayError {
  GetPaymentOptionsError({
    required super.code,
    required super.message,
    required super.details,
    required super.stacktrace,
  });

  @override
  String toString() =>
      'GetPaymentOptionsError($code, $message, $details, $stacktrace)';
}

class GetRequiredActionsError extends PayError {
  GetRequiredActionsError({
    required super.code,
    required super.message,
    required super.details,
    required super.stacktrace,
  });

  @override
  String toString() =>
      'GetRequiredActionError($code, $message, $details, $stacktrace)';
}

class ConfirmPaymentError extends PayError {
  ConfirmPaymentError({
    required super.code,
    required super.message,
    required super.details,
    required super.stacktrace,
  });

  @override
  String toString() =>
      'ConfirmPaymentError($code, $message, $details, $stacktrace)';
}
