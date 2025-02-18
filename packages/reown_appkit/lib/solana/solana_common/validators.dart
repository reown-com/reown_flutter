//! Validators
/// ------------------------------------------------------------------------------------------------
library;

/// Asserts that [condition] is `true`.
///
/// Throws an [AssertionError] with the provided [message] if [condition] is `false`.
void check(final bool condition, [final Object? message]) {
  if (!condition) {
    throw AssertionError(message);
  }
}

/// Asserts that [condition] is `true`.
///
/// Throws the return value of [callback] if [condition] is `false`.
void checkThrow(final bool condition, final Object Function() callback) {
  if (!condition) {
    throw callback();
  }
}

/// Asserts that [value] is equal to [limit].
///
/// Throws an [AssertionError] using [label] as a descriptive name for [value].
void checkEq(final int value, final int limit, [final Object? label]) {
  if (value != limit) {
    throw AssertionError(
        'The ${label ?? 'value'} $value must be `equal to` $limit.');
  }
}

/// Asserts that [value] is greater than [limit].
///
/// Throws an [AssertionError] using [label] as a descriptive name for [value].
void checkGt(final int value, final int limit, [final Object? label]) {
  if (value <= limit) {
    throw AssertionError(
        'The ${label ?? 'value'} $value must be `greater than` $limit.');
  }
}

/// Asserts that [value] is greater than or equal to [limit].
///
/// Throws an [AssertionError] using [label] as a descriptive name for [value].
void checkGte(final int value, final int limit, [final Object? label]) {
  if (value < limit) {
    throw AssertionError(
      'The ${label ?? 'value'} $value must be `greater than or equal to` $limit.',
    );
  }
}

/// Asserts that [value] is less than [limit].
///
/// Throws an [AssertionError] using [label] as a descriptive name for [value].
void checkLt(final int value, final int limit, [final Object? label]) {
  if (value >= limit) {
    throw AssertionError(
        'The ${label ?? 'value'} $value must be `less than` $limit.');
  }
}

/// Asserts that [value] is less than or equal to [limit].
///
/// Throws an [AssertionError] using [label] as a descriptive name for [value].
void checkLte(final int value, final int limit, [final Object? label]) {
  if (value > limit) {
    throw AssertionError(
        'The ${label ?? 'value'} $value must be `less than or equal to` $limit.');
  }
}
