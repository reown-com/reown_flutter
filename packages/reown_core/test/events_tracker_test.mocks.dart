// Mocks generated by Mockito 5.4.4 from annotations
// in reown_core/test/events_tracker_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i3;
import 'package:reown_core/store/i_store.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [IStore].
///
/// See the documentation for Mockito's code generation for more information.
class MockIStore<T> extends _i1.Mock implements _i2.IStore<T> {
  MockIStore() {
    _i1.throwOnMissingStub(this);
  }

  @override
  Map<String, T> get map => (super.noSuchMethod(
        Invocation.getter(#map),
        returnValue: <String, T>{},
      ) as Map<String, T>);

  @override
  List<String> get keys => (super.noSuchMethod(
        Invocation.getter(#keys),
        returnValue: <String>[],
      ) as List<String>);

  @override
  List<T> get values => (super.noSuchMethod(
        Invocation.getter(#values),
        returnValue: <T>[],
      ) as List<T>);

  @override
  String get storagePrefix => (super.noSuchMethod(
        Invocation.getter(#storagePrefix),
        returnValue: _i3.dummyValue<String>(
          this,
          Invocation.getter(#storagePrefix),
        ),
      ) as String);

  @override
  _i4.Future<void> init() => (super.noSuchMethod(
        Invocation.method(
          #init,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> set(
    String? key,
    T? value,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #set,
          [
            key,
            value,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  T? get(String? key) => (super.noSuchMethod(Invocation.method(
        #get,
        [key],
      )) as T?);

  @override
  bool has(String? key) => (super.noSuchMethod(
        Invocation.method(
          #has,
          [key],
        ),
        returnValue: false,
      ) as bool);

  @override
  List<dynamic> getAll() => (super.noSuchMethod(
        Invocation.method(
          #getAll,
          [],
        ),
        returnValue: <dynamic>[],
      ) as List<dynamic>);

  @override
  _i4.Future<void> update(
    String? key,
    T? value,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #update,
          [
            key,
            value,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> delete(String? key) => (super.noSuchMethod(
        Invocation.method(
          #delete,
          [key],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> deleteAll() => (super.noSuchMethod(
        Invocation.method(
          #deleteAll,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}
