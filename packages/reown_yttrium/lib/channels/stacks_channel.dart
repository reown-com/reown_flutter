import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:reown_yttrium/models/shared.dart';
import 'package:reown_yttrium/utils/channel_utils.dart';

class MethodChannelStacks {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('reown_yttrium');

  Future<bool> init({
    required String projectId,
    required PulseMetadataCompat pulseMetadata,
  }) async {
    try {
      final bool? result = await methodChannel.invokeMethod<bool>(
        'stx_init',
        {
          'projectId': projectId,
          'pulseMetadata': pulseMetadata.toJson(),
        },
      );
      return result!;
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] stx_init $e');
      rethrow;
    }
  }

  Future<String> generateWallet() async {
    try {
      final String? result = await methodChannel.invokeMethod<String>(
        'stx_generateWallet',
      );
      return result!;
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] stx_generateWallet $e');
      rethrow;
    }
  }

  Future<String> getAddress({
    required String wallet,
    required String version,
  }) async {
    try {
      final String? result = await methodChannel.invokeMethod<String>(
        'stx_getAddress',
        {
          'wallet': wallet,
          'version': version,
        },
      );
      return result!;
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] stx_getAddress $e');
      rethrow;
    }
  }

  Future<String> signMessage({
    required String wallet,
    required String message,
  }) async {
    try {
      final String? result = await methodChannel.invokeMethod<String>(
        'stx_signMessage',
        {
          'wallet': wallet,
          'message': message,
        },
      );
      return result!;
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] stx_signMessage $e');
      throw Exception(e.message);
    }
  }

  Future<Map<String, dynamic>> transferStx({
    required String wallet,
    required String network,
    required Map<String, dynamic> request,
  }) async {
    try {
      final response = await methodChannel.invokeMethod<dynamic>(
        'stx_transferStx',
        {
          'wallet': wallet,
          'network': network,
          'request': request,
        },
      );
      return ChannelUtils.handlePlatformResult(response)
          as Map<String, dynamic>;
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] stx_transferStx $e');
      throw Exception(e.message);
    }
  }

  Future<Map<String, dynamic>> getAccount({
    required String principal,
    required String network,
  }) async {
    try {
      final response = await methodChannel.invokeMethod<dynamic>(
        'stx_getAccount',
        {
          'principal': principal,
          'network': network,
        },
      );
      return ChannelUtils.handlePlatformResult(response)
          as Map<String, dynamic>;
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] stx_getAccount $e');
      throw Exception(e.message);
    }
  }

  Future<BigInt> transferFees({
    required String network,
  }) async {
    try {
      final response = await methodChannel.invokeMethod<dynamic>(
        'stx_transferFeeRate',
        {
          'network': network,
        },
      );
      final feeRate = ChannelUtils.handlePlatformResult(response).toString();
      return BigInt.parse(feeRate);
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] stx_transferFeeRate $e');
      throw Exception(e.message);
    }
  }

  // Future<Map<String, dynamic>> estimateFees({
  //   required String transaction_payload,
  //   required String network,
  // }) async {
  //   try {
  //     final Map<String, dynamic>? result =
  //         await methodChannel.invokeMethod<Map<String, dynamic>>(
  //       'stx_estimateFees',
  //       {
  //         'transaction_payload': transaction_payload,
  //         'network': network,
  //       },
  //     );
  //     return result!;
  //   } on PlatformException catch (e) {
  //     debugPrint('[$runtimeType] stx_estimateFees $e');
  //     rethrow;
  //   }
  // }

  // Future<Map<String, dynamic>> getNonce({
  //   required String principal,
  //   required String network,
  // }) async {
  //   try {
  //     final Map<String, dynamic>? result =
  //         await methodChannel.invokeMethod<Map<String, dynamic>>(
  //       'stx_getNonce',
  //       {
  //         'principal': principal,
  //         'network': network,
  //       },
  //     );
  //     return result!;
  //   } on PlatformException catch (e) {
  //     debugPrint('[$runtimeType] stx_getNonce $e');
  //     rethrow;
  //   }
  // }
}
