import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class MethodChannelSolana {
  @visibleForTesting
  final methodChannel = const MethodChannel('reown_yttrium_utils');

  Future<String> generateKeyPair() async {
    try {
      final result = await methodChannel.invokeMethod<String>(
        'solana_generateKeyPair',
      );
      return result!;
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] solana_generateKeyPair $e');
      rethrow;
    }
  }

  Future<String> getPublicKey({required String keyPair}) async {
    try {
      final result = await methodChannel.invokeMethod<String>(
        'solana_getPublicKey',
        {'keyPair': keyPair},
      );
      return result!;
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] solana_getPublicKey $e');
      rethrow;
    }
  }

  /// Signs a base64-encoded `VersionedTransaction`.
  /// Returns `(transaction, signature)` where `transaction` is the base64
  /// blob with the signature populated and `signature` is base58.
  Future<({String transaction, String signature})> signTransaction({
    required String keyPair,
    required String transaction,
  }) async {
    try {
      final result = await methodChannel.invokeMethod<dynamic>(
        'solana_signTransaction',
        {'keyPair': keyPair, 'transaction': transaction},
      );
      final map = result as Map<Object?, Object?>;
      return (
        transaction: map['transaction'].toString(),
        signature: map['signature'].toString(),
      );
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] solana_signTransaction $e');
      rethrow;
    }
  }

  Future<List<({String transaction, String signature})>> signAllTransactions({
    required String keyPair,
    required List<String> transactions,
  }) async {
    try {
      final result = await methodChannel.invokeMethod<List<dynamic>>(
        'solana_signAllTransactions',
        {'keyPair': keyPair, 'transactions': transactions},
      );
      return result!.map((e) {
        final map = e as Map<Object?, Object?>;
        return (
          transaction: map['transaction'].toString(),
          signature: map['signature'].toString(),
        );
      }).toList();
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] solana_signAllTransactions $e');
      rethrow;
    }
  }

  /// Returns a base58-encoded signature over the raw [message] bytes.
  Future<String> signMessage({
    required String keyPair,
    required Uint8List message,
  }) async {
    try {
      final result = await methodChannel.invokeMethod<String>(
        'solana_signMessage',
        {'keyPair': keyPair, 'message': message},
      );
      return result!;
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] solana_signMessage $e');
      rethrow;
    }
  }
}
