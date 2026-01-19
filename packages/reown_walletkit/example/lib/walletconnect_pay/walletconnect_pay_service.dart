import 'dart:async';
// import 'dart:convert';

import 'package:flutter/material.dart' hide Action;
import 'package:get_it/get_it.dart';
import 'package:reown_walletkit_wallet/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/dependencies/key_service/i_key_service.dart';
import 'package:reown_walletkit_wallet/utils/dart_defines.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/i_walletconnect_pay_service.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_modals/wcp_confirming_payment.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_modals/wcp_get_payment_options.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_modals/wcp_information_capture/wcp_birthdate_capture.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_modals/wcp_information_capture/wcp_full_name_capture.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_modals/wcp_information_capture/wcp_place_of_birth_capture.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_modals/wcp_payment_details.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_modals/wcp_payment_result.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_modals/wcp_information_capture/wcp_information_capture_start.dart';
import 'package:walletconnect_pay/walletconnect_pay.dart';

class WalletConnectPayService implements IWalletConnectPayService {
  final _bottomSheetHandler = GetIt.I<IBottomSheetService>();

  late final WalletConnectPay _walletConnectPay;
  late final List<String> _accounts;
  ConfirmPaymentRequest? _pendingPaymentRequest;
  PaymentOptionsResponse? _currentPaymentOptions;

  @override
  Future<void> setUpAccounts(List<String> accounts) async {
    _accounts = accounts;
  }

  @override
  Future<void> init() async {
    // Get apikey from storage if configured in settings or pass from --dart-defines
    final wcpApiKey = GetIt.I<IKeyService>().getWCPApiKey();
    final walletKit = GetIt.I<IWalletKitService>().walletKit;
    final clientId = await walletKit.core.crypto.getClientId();
    // It should be either apiKey alone or appId + clientId
    _walletConnectPay = WalletConnectPay(
      apiKey: wcpApiKey ?? DartDefines.wcpApiKey, // has preference
      // appId: DartDefines.projectId, // if no api
      clientId: clientId, // if via walletkit
    );
    await _walletConnectPay.init();
    debugPrint('[$runtimeType] initialized');
  }

  @override
  Future<void> processPayment(String paymentLink) async {
    try {
      // PaymentOptionsResponse
      final optionsResponse = await _bottomSheetHandler.queueBottomSheet(
        widget: WCPGetPaymentOptions(
          paymentLink: paymentLink,
          accounts: _accounts,
        ),
      );

      if (optionsResponse is! PaymentOptionsResponse) {
        throw optionsResponse;
      }

      _currentPaymentOptions = optionsResponse;

      if (_currentPaymentOptions!.options.isEmpty) {
        _currentPaymentOptions = null;
        throw 'No options found for this payment';
      }

      _pendingPaymentRequest = ConfirmPaymentRequest(
        paymentId: _currentPaymentOptions!.paymentId,
        optionId: _currentPaymentOptions!.options.first.id,
        signatures: [],
      );

      if (_currentPaymentOptions!.collectData != null) {
        final action = await _startDataCollection(_currentPaymentOptions!);
        if (action == WCBottomSheetResult.close.name) {
          return;
        }
      }

      await _processPayment(_currentPaymentOptions!);
    } catch (e) {
      if (e == 'cancelled' || e == 'close') {
        return;
      }
      rethrow;
    }
  }

  /// Fetches payment options from the WalletConnect Pay API for the given payment link.
  @override
  Future<PaymentOptionsResponse> getPaymentOptions(
    GetPaymentOptionsRequest request,
  ) async {
    final response = await _walletConnectPay.getPaymentOptions(
      request: request,
    );
    return response;
  }

  @override
  Future<List<Action>> getRequiredPaymentActions(
    String optionId,
    String paymentId,
  ) async {
    final response = await _walletConnectPay.getRequiredPaymentActions(
      request: GetRequiredPaymentActionsRequest(
        optionId: optionId,
        paymentId: paymentId,
      ),
    );
    return response;
  }

  @override
  Future<ConfirmPaymentResponse> confirmPayment(
    ConfirmPaymentRequest payment,
  ) async {
    final response = await _walletConnectPay.confirmPayment(
      request: payment.copyWith(
        maxPollMs: 60000,
      ),
    );
    return response;
  }

  /// Initiates the data collection flow by showing the start modal and collecting required fields.
  Future<dynamic> _startDataCollection(PaymentOptionsResponse response) async {
    final startResult = await _bottomSheetHandler.queueBottomSheet(
      widget: WCPInformationCaptureStartWidget(
        paymentInfo: response.info!,
      ),
    );
    if (startResult != WCBottomSheetResult.next.name) {
      return startResult;
    }

    _pendingPaymentRequest = _pendingPaymentRequest!.copyWith(
      collectedData: [],
    );
    final action = await _showDataCollectionSteps(response, startIndex: 0);
    return action;
  }

  /// Adds a collected data field result to the pending payment request.
  void _addCollectedDataToPaymentRequest(CollectDataFieldResult result) {
    final currentList = List<CollectDataFieldResult>.from(
      _pendingPaymentRequest!.collectedData ?? [],
    );
    currentList.add(result);
    _pendingPaymentRequest = _pendingPaymentRequest!.copyWith(
      collectedData: currentList,
    );
  }

  /// Removes the last collected data field result from the pending payment request.
  /// TODO check if needed
  void _removeLastCollectedData() {
    final currentList = List<CollectDataFieldResult>.from(
      _pendingPaymentRequest!.collectedData ?? [],
    );
    if (currentList.isNotEmpty) {
      currentList.removeLast();
      _pendingPaymentRequest = _pendingPaymentRequest!.copyWith(
        collectedData: currentList,
      );
    }
  }

  /// Resumes data collection from a specific index, typically used when navigating back from payment details.
  Future<dynamic> _resumeDataCollectionLastStep(
    PaymentOptionsResponse response,
  ) async {
    final fields = response.collectData!.fields;
    final collectedData = _pendingPaymentRequest!.collectedData ?? [];

    int startIndex = collectedData.length;
    if (startIndex >= fields.length) {
      startIndex = fields.length - 1;
      _removeLastCollectedData();
    }

    final action = await _showDataCollectionSteps(
      response,
      startIndex: startIndex,
    );
    return action;
  }

  /// Collects data fields sequentially, showing modals for each required field and handling back navigation.
  Future<dynamic> _showDataCollectionSteps(
    PaymentOptionsResponse response, {
    required int startIndex,
  }) async {
    final fields = response.collectData!.fields;
    int currentIndex = startIndex;

    Widget icMap(CollectDataField field) {
      switch (field.id) {
        case 'fullName':
          return WCPFullNameCapture(collectDataField: field);
        case 'dob':
          return WCPBirthdateCapture(collectDataField: field);
        case 'pob':
          return WCPPlaceOfBirthCapture(collectDataField: field);
        default:
          throw UnimplementedError('Unrecognized field ${field.id}');
      }
    }

    while (currentIndex < fields.length) {
      final result = await _bottomSheetHandler.queueBottomSheet(
        widget: icMap(fields[currentIndex]),
        showBackButton: true,
        stepper: (currentIndex + 1, fields.length + 1),
      );

      if (result is CollectDataFieldResult) {
        _addCollectedDataToPaymentRequest(result);
        currentIndex++;
      } else if (result == WCBottomSheetResult.back.name) {
        if (currentIndex > 0) {
          _removeLastCollectedData();
          currentIndex--;
        } else {
          final startResult = await _bottomSheetHandler.queueBottomSheet(
            widget: WCPInformationCaptureStartWidget(
              paymentInfo: response.info!,
            ),
          );
          if (startResult != WCBottomSheetResult.next.name) {
            return startResult;
          }
          _pendingPaymentRequest =
              _pendingPaymentRequest!.copyWith(collectedData: []);
        }
      } else {
        return result;
      }
    }
  }

  /// Processes the payment flow: shows payment details, confirms payment, and displays the result.
  Future<dynamic> _processPayment(PaymentOptionsResponse response) async {
    final paymentConfirmRequest = await _showPaymentDetails(response);

    // Step 2: Confirming Payment
    final paymentStatusResult = await _bottomSheetHandler.queueBottomSheet(
      widget: WCPConfirmingPayment(
        paymentRequest: paymentConfirmRequest,
      ),
    );
    if (paymentStatusResult is! PaymentStatus) {
      _pendingPaymentRequest = null;
      _currentPaymentOptions = null;
      throw paymentStatusResult;
    }

    _pendingPaymentRequest = null;
    _currentPaymentOptions = null;

    // Step 3: Payment Result
    final result = await _bottomSheetHandler.queueBottomSheet(
      widget: WCPPaymentResult(
        status: paymentStatusResult,
        info: _currentPaymentOptions!.info!,
      ),
    );
    if (result != WCBottomSheetResult.next.name) {
      throw result;
    }
  }

  /// Shows the payment details modal and handles back navigation to resume data collection if needed.
  Future<ConfirmPaymentRequest> _showPaymentDetails(
    PaymentOptionsResponse response,
  ) async {
    (int, int) stepper = (0, 0);
    final fieldsLength = response.collectData?.fields.length ?? 0;
    if (fieldsLength > 0) {
      stepper = (fieldsLength + 1, fieldsLength + 1);
    }
    final result = await _bottomSheetHandler.queueBottomSheet(
      widget: WCPPaymentDetailsWidget(
        paymentOptionsResponse: response,
        paymentRequest: _pendingPaymentRequest!,
      ),
      showBackButton: true,
      stepper: stepper,
    );

    if (result is ConfirmPaymentRequest) {
      return result;
    } else if (result == WCBottomSheetResult.back.name) {
      if (response.collectData != null) {
        await _resumeDataCollectionLastStep(response);
        return _showPaymentDetails(response);
      } else {
        throw result;
      }
    } else {
      throw result;
    }
  }

  @override
  FutureOr<dynamic> onDispose() {
    debugPrint('disposed');
  }
}
