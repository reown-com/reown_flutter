import 'annotation.dart';

/// Annotation Sized
/// ------------------------------------------------------------------------------------------------

/// An interface for Borsh annotations that decorate sized data types.
abstract class BorshAnnotationSized<T> extends BorshAnnotation<T> {
  /// Creates an annotation for sized data types.
  const BorshAnnotationSized();
}
