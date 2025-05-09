import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:reown_yttrium/models/chain_abstraction.dart';

import 'reown_yttrium_platform_interface.dart';

/// An implementation of [ReownYttriumPlatform] that uses method channels.
class MethodChannelReownYttrium extends ReownYttriumPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('reown_yttrium');

  @override
  Future<bool> init({
    required String projectId,
    required PulseMetadataCompat pulseMetadata,
  }) async {
    try {
      final result = await methodChannel.invokeMethod<bool>('init', {
        'projectId': projectId,
        'pulseMetadata': pulseMetadata.toJson(),
      });
      return result ?? false;
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] init $e');
      rethrow;
    }
  }

  @override
  Future<String> erc20TokenBalance({
    required String chainId,
    required String token,
    required String owner,
  }) async {
    try {
      return await methodChannel.invokeMethod<dynamic>('erc20TokenBalance', {
        'chainId': chainId,
        'token': token,
        'owner': owner,
      });
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] erc20TokenBalance $e');
      rethrow;
    }
  }

  @override
  Future<Eip1559EstimationCompat> estimateFees({
    required String chainId,
  }) async {
    try {
      final response = await methodChannel.invokeMethod<dynamic>(
        'estimateFees',
        {
          'chainId': chainId,
        },
      );
      return Eip1559EstimationCompat.fromJson({
        'maxPriorityFeePerGas': response['maxPriorityFeePerGas'],
        'maxFeePerGas': response['maxFeePerGas'],
      });
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] estimateFees $e');
      rethrow;
    }
  }

  @override
  Future<PrepareDetailedResponseCompat> prepareDetailed({
    required String chainId,
    required String from,
    required CallCompat call,
    required Currency localCurrency,
  }) async {
    try {
      final response = await methodChannel.invokeMethod<dynamic>(
        'prepareDetailed',
        {
          'chainId': chainId,
          'from': from,
          'call': call.toJson(),
          'localCurrency': localCurrency.name,
        },
      );

      if (response.containsKey('available')) {
        final responseData = _handlePlatformResult(response['available']);
        return PrepareDetailedResponseCompat.success(
          value: PrepareDetailedResponseSuccessCompat.available(
            value: UiFieldsCompat.fromJson(
              responseData,
            ),
          ),
        );
      }
      if (response.containsKey('notRequired')) {
        final responseData = _handlePlatformResult(response['notRequired']);
        return PrepareDetailedResponseCompat.success(
          value: PrepareDetailedResponseSuccessCompat.notRequired(
            value: PrepareResponseNotRequiredCompat.fromJson(
              responseData,
            ),
          ),
        );
      }
      if ((response ?? {}).containsKey('error')) {
        final error = response!['error']!['error'];
        final reason = response!['error']?['reason'];
        return PrepareDetailedResponseCompat.error(
          value: PrepareResponseError(
            error: BridgingError.fromString(error),
            reason: reason ?? response['reason'] ?? '',
          ),
        );
      }
      throw PlatformException(
        code: 'prepareDetailed',
        message: 'unable to parse response',
      );
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] prepareDetailed $e');
      rethrow;
    } catch (e, s) {
      debugPrint('[$runtimeType] prepareDetailed $e');
      debugPrint(s.toString());
      rethrow;
    }
  }

  /// ---------------------------------
  /// ⚠️ This method is experimental. Use with caution.
  /// ---------------------------------
  @override
  Future<ExecuteDetailsCompat> execute({
    required UiFieldsCompat uiFields,
    required List<PrimitiveSignatureCompat> routeTxnSigs,
    required PrimitiveSignatureCompat initialTxnSig,
  }) async {
    try {
      final response = await methodChannel.invokeMethod<dynamic>(
        'execute',
        {
          'orchestrationId': uiFields.routeResponse.orchestrationId,
          'routeTxnSigs': routeTxnSigs.map((e) => e.hexValue).toList(),
          'initialTxnSig': initialTxnSig.hexValue,
        },
      );

      if (response is Map) {
        return ExecuteDetailsCompat(
          initialTxnReceipt: response['initialTxnReceipt'] as String,
          initialTxnHash: response['initialTxnHash'] as String,
        );
      }

      throw PlatformException(
        code: 'execute',
        message: 'unable to parse response',
      );
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] execute $e');
      rethrow;
    } catch (e, s) {
      debugPrint('[$runtimeType] prepareDetailed $e');
      debugPrint(s.toString());
      rethrow;
    }
  }

  dynamic _handlePlatformResult(dynamic input) {
    if (input == null) {
      return null; // Handle null explicitly
    } else if (input is Map) {
      return input.map((key, value) {
        // Recursively convert the value, preserving its type
        return MapEntry('$key', _handlePlatformResult(value));
      });
    } else if (input is List) {
      // Handle lists by recursively converting their elements
      return input.map((item) => _handlePlatformResult(item)).toList();
    }
    // Return scalar values (int, String, bool, double, etc.) as-is
    return input;
  }
}
