import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:reown_yttrium/models/chain_abstraction.dart';
import 'package:reown_yttrium/models/shared.dart';
import 'package:reown_yttrium/reown_yttrium_method_channel.dart';

class ChainAbstractionClient {
  final _methodChannel = MethodChannelReownYttrium();

  Future<bool> init({
    required String projectId,
    required PulseMetadataCompat pulseMetadata,
  }) async {
    try {
      final result = await _methodChannel.chainAbstractionChannel.init(
        projectId: projectId,
        pulseMetadata: pulseMetadata,
      );
      return result;
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
      return await _methodChannel.chainAbstractionChannel.erc20TokenBalance(
        chainId: chainId,
        token: token,
        owner: owner,
      );
    } on PlatformException catch (e) {
      debugPrint('[$runtimeType] erc20TokenBalance $e');
      rethrow;
    }
  }

  Future<Eip1559EstimationCompat> estimateFees({
    required String chainId,
  }) async {
    try {
      final response = await _methodChannel.chainAbstractionChannel
          .estimateFees(chainId: chainId);
      return response;
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
      final response = await _methodChannel.chainAbstractionChannel
          .prepareDetailed(
            chainId: chainId,
            from: from,
            accounts: accounts,
            call: call,
            localCurrency: localCurrency,
            useLifi: useLifi,
          );
      return response;
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
  Future<ExecuteDetailsCompat> execute({
    required UiFieldsCompat uiFields,
    required List<PrimitiveSignatureCompat> routeTxnSigs,
    required PrimitiveSignatureCompat initialTxnSig,
  }) async {
    try {
      final response = await _methodChannel.chainAbstractionChannel.execute(
        uiFields: uiFields,
        routeTxnSigs: routeTxnSigs,
        initialTxnSig: initialTxnSig,
      );
      return response;
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
