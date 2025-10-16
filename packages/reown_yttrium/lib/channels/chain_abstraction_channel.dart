import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:reown_yttrium/models/shared.dart';
import 'package:reown_yttrium/models/chain_abstraction.dart';
import 'package:reown_yttrium/utils/channel_utils.dart';

class MethodChannelChainAbstraction {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('reown_yttrium');

  Future<bool> init({
    required String projectId,
    required PulseMetadataCompat pulseMetadata,
  }) async {
    try {
      final result = await methodChannel.invokeMethod<bool>('ca_init', {
        'projectId': projectId,
        'pulseMetadata': pulseMetadata.toJson(),
      });
      return result ?? false;
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] init $e');
      rethrow;
    }
  }

  Future<String> erc20TokenBalance({
    required String chainId,
    required String token,
    required String owner,
  }) async {
    try {
      return await methodChannel.invokeMethod<dynamic>('ca_erc20TokenBalance', {
        'chainId': chainId,
        'token': token,
        'owner': owner,
      });
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] erc20TokenBalance $e');
      rethrow;
    }
  }

  Future<Eip1559EstimationCompat> estimateFees({
    required String chainId,
  }) async {
    try {
      final response = await methodChannel.invokeMethod<dynamic>(
        'ca_estimateFees',
        {'chainId': chainId},
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

  Future<PrepareDetailedResponseCompat> prepareDetailed({
    required String chainId,
    required String from,
    required List<String> accounts,
    required CallCompat call,
    required Currency localCurrency,
    required bool useLifi,
  }) async {
    try {
      final parameters = {
        'chainId': chainId,
        'from': from,
        'accounts': accounts,
        'call': call.toJson(),
        'localCurrency': localCurrency.name,
        'useLifi': useLifi,
      };
      debugPrint(
        '[$runtimeType] prepareDetailed, parameters: ${jsonEncode(parameters)}',
      );
      final response = await methodChannel.invokeMethod<dynamic>(
        'ca_prepareDetailed',
        parameters,
      );

      debugPrint(
        '[$runtimeType] prepareDetailed, response: ${jsonEncode(response)}',
      );
      if (response.containsKey('available')) {
        final responseData = ChannelUtils.handlePlatformResult(
          response['available'],
        );
        return PrepareDetailedResponseCompat.success(
          value: PrepareDetailedResponseSuccessCompat.available(
            value: UiFieldsCompat.fromJson(responseData!),
          ),
        );
      }
      if (response.containsKey('notRequired')) {
        final responseData = ChannelUtils.handlePlatformResult(
          response['notRequired'],
        );
        return PrepareDetailedResponseCompat.success(
          value: PrepareDetailedResponseSuccessCompat.notRequired(
            value: PrepareResponseNotRequiredCompat.fromJson(responseData!),
          ),
        );
      }
      if ((response ?? {}).containsKey('error')) {
        final error = response!['error'];
        final reason = response?['reason'];
        return PrepareDetailedResponseCompat.error(
          value: PrepareDetailedResponseError(
            error: BridgingError.fromString(error),
            reason: reason ?? 'no reason',
          ),
        );
      }
      throw PlatformException(
        code: 'prepareDetailed',
        message: 'unable to parse response',
      );
    } on PlatformException catch (e, s) {
      debugPrint('[$runtimeType] prepareDetailed, PlatformException: $e');
      debugPrint(s.toString());
      rethrow;
    } catch (e, s) {
      debugPrint('[$runtimeType] prepareDetailed, Exception: $e');
      debugPrint(s.toString());
      rethrow;
    }
  }

  /// ---------------------------------
  /// ⚠️ This method is experimental. Use with caution.
  /// ---------------------------------
  Future<ExecuteDetailsCompat> execute({
    required UiFieldsCompat uiFields,
    required List<PrimitiveSignatureCompat> routeTxnSigs,
    required PrimitiveSignatureCompat initialTxnSig,
  }) async {
    try {
      final response = await methodChannel.invokeMethod<dynamic>('ca_execute', {
        'orchestrationId': uiFields.routeResponse.orchestrationId,
        'routeTxnSigs': routeTxnSigs.map((e) => e.hexValue).toList(),
        'initialTxnSig': initialTxnSig.hexValue,
      });

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
}
