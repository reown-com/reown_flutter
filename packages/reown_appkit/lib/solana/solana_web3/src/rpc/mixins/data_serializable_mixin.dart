/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'dart:convert';
import 'package:reown_appkit/solana/solana_common/convert.dart';
import 'package:reown_appkit/solana/solana_common/models.dart';
import '../../encodings/account_encoding.dart';
import '../../encodings/transaction_encoding.dart';
import '../../exceptions/data_serializable_exception.dart';

/// Data Serializable
/// ------------------------------------------------------------------------------------------------

mixin DataSerializableMixin {
  /// A [Serializable] class for Account and Transaction data.
  // const DataSerializable();

  /// Account or Transaction data.
  Object? get rawData;

  /// Casts [rawData] to a JSON object.
  ///
  /// Throws an error if [rawData] is not a JSON object ({ 'key0', 'value0', ... }).
  Map<String, dynamic> get jsonData => rawData as Map<String, dynamic>;

  /// Casts [rawData] to a binary encoded [String].
  ///
  /// Throws an error if [rawData] is not a binary encoded [List] ('SGkgS2F0ZQ==', 'base64').
  String get binaryData => (rawData as Iterable).first;

  /// `True` if [rawData] is a JSON object.
  ///
  /// ```
  /// e.g. { 'key0', 'value0', ... };
  /// ```
  bool get isJson => rawData is Map;

  /// `True` if [rawData] is a binary encoded [List].
  ///
  /// ```
  /// e.g. ['SGkgS2F0ZQ==', 'base64'];
  /// ```
  bool get isBinary => rawData is List;

  /// Returns `true` if [data] is a JSON object.
  static bool _isJsonVerbose(final dynamic data) {
    return data is Map;
  }

  /// Returns `true` if [data] is a binary encoded [List].
  static bool _isBinaryVerbose(final dynamic data) {
    return data is List &&
        data.length == 2 &&
        data.first is String &&
        data.last is String &&
        (AccountEncoding.tryFromJson(data.last) != null ||
            TransactionEncoding.tryFromJson(data.last) != null);
  }

  /// Checks if [data] is a binary encoded string and converts it to a [List].
  ///
  /// If data is a [String], it must be a binary encoded string. When the encoding specified in a
  /// request (e.g. [DataEncoding.jsonParsed]) is not available, it may default to a literal binary
  /// encoded string.
  ///
  /// Throws a [DataSerializableException] if [data] is not a valid `base58` or `base64` string.
  ///
  /// ```
  /// final String encoded = 'SGkgS2F0ZQ==';
  /// final Object data = DataSerializable.decode(encoded);
  /// print(data); // ['SGkgS2F0ZQ==', 'base64']
  /// ```
  static dynamic decode(final dynamic data) {
    if (data is String) {
      try {
        base58Decode(data);
        return [data, 'base58'];
      } catch (_) {
        /// Invalid `base58` encoded string.
      }

      try {
        base64Decode(data);
        return [data, 'base64'];
      } catch (_) {
        /// Invalid `base64` encoded string.
      }

      throw DataSerializableException('Invalid binary encoded string $data');
    }

    // Check that the data received is in one of the expected formats.
    assert(_isBinaryVerbose(data) || _isJsonVerbose(data));

    return data;
  }
}
