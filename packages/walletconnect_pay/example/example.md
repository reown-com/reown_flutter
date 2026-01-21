# WalletConnect Pay Example

This example demonstrates how to use the WalletConnect Pay SDK to process payments in standalone mode.

## Basic Setup

```dart
import 'package:walletconnect_pay/walletconnect_pay.dart';

// Initialize WalletConnect Pay. Either apiKey or appId must be passed
final walletConnectPay = WalletConnectPay(
  apiKey: 'your-api-key',
  // appId: 'your-app-id',
  // clientId: 'your-client-id', // Optional
  // baseUrl: 'https://api.pay.walletconnect.com', // Optional: custom base URL
);

// Initialize the SDK
await walletConnectPay.init();
```

## Complete Payment Flow

```dart
import 'package:walletconnect_pay/walletconnect_pay.dart';

class PaymentService {
  late final WalletConnectPay _walletConnectPay;

  Future<void> initialize() async {
    _walletConnectPay = WalletConnectPay(
      apiKey: 'your-api-key',
    );
    await _walletConnectPay.init();
  }

  /// Process a payment from a payment link (e.g., after scanning QR code)
  Future<void> processPayment(String paymentLink) async {
    try {
      // Step 1: Get payment options
      final optionsResponse = await _walletConnectPay.getPaymentOptions(
        request: GetPaymentOptionsRequest(
          paymentLink: paymentLink,
          accounts: ['eip155:1:0x1234...'], // User's wallet CAIP-10 accounts
          includePaymentInfo: true,
        ),
      );

      if (optionsResponse.options.isEmpty) {
        throw Exception('No payment options available');
      }

      // Step 2: Collect additional data if required (KYB/KYC)
      final collectedData = <CollectDataFieldResult>[];
      if (optionsResponse.collectData != null) {
        for (final field in optionsResponse.collectData!.fields) {
          // Collect data from user (e.g., full name, date of birth)
          // Example: collectedData.add(CollectDataFieldResult(id: field.id, value: userInput));
        }
      }

      // Step 3: Select payment option (or let user choose)
      PaymentOption selectedOption = optionsResponse.options.first;
      final paymentId = optionsResponse.paymentId;
      final optionId = selectedOption.id;

      // Step 4: Get required payment actions (if not already in the option)
      List<Action> actions = selectedOption.actions;
      if (actions.isEmpty) {
        actions = await _walletConnectPay.getRequiredPaymentActions(
          request: GetRequiredPaymentActionsRequest(
            optionId: optionId,
            paymentId: paymentId,
          ),
        );
      }

      // Step 5: Execute wallet actions and collect signatures
      final signatures = <String>[];
      for (final action in actions) {
        // Sign the transaction using your wallet SDK
        // Example: signatures.add(await signTransaction(action.walletRpc));
      }

      // Step 6: Confirm payment with polling
      ConfirmPaymentResponse confirmResponse = await _walletConnectPay.confirmPayment(
        request: ConfirmPaymentRequest(
          paymentId: paymentId,
          optionId: optionId,
          signatures: signatures,
          collectedData: collectedData.isNotEmpty ? collectedData : null,
          maxPollMs: 60000, // Maximum polling time in milliseconds
        ),
      );

      // Step 7: Poll until final status (if needed)
      while (!confirmResponse.isFinal && confirmResponse.pollInMs != null) {
        await Future.delayed(Duration(milliseconds: confirmResponse.pollInMs!));
        confirmResponse = await _walletConnectPay.confirmPayment(
          request: ConfirmPaymentRequest(
            paymentId: paymentId,
            optionId: optionId,
            signatures: signatures,
            collectedData: collectedData.isNotEmpty ? collectedData : null,
            maxPollMs: 60000,
          ),
        );
      }

      // Handle final payment status
      switch (confirmResponse.status) {
        case PaymentStatus.succeeded:
          print('Payment succeeded!');
          break;
        case PaymentStatus.failed:
          throw Exception('Payment failed');
        case PaymentStatus.expired:
          throw Exception('Payment expired');
        case PaymentStatus.requires_action:
          throw Exception('Payment requires additional action');
        case PaymentStatus.processing:
          // Should not happen if isFinal is true
          break;
      }
    } catch (e) {
      print('Payment error: $e');
      rethrow;
    }
  }
}
```

## Key Methods

### Get Payment Options

```dart
final response = await walletConnectPay.getPaymentOptions(
  request: GetPaymentOptionsRequest(
    paymentLink: 'https://pay.walletconnect.com/pay/...',
    accounts: ['0x1234...', '0x5678...'],
    includePaymentInfo: true,
  ),
);

// Access payment information
print('Payment ID: ${response.paymentId}');
print('Merchant: ${response.info?.merchant.name}');
print('Amount: ${response.info?.amount.formatAmount()}');
print('Options available: ${response.options.length}');
```

### Get Required Payment Actions

```dart
final actions = await walletConnectPay.getRequiredPaymentActions(
  request: GetRequiredPaymentActionsRequest(
    optionId: 'option-id',
    paymentId: 'payment-id',
  ),
);

// Each action contains wallet RPC information
for (final action in actions) {
  print('Chain ID: ${action.walletRpc.chainId}');
  print('Method: ${action.walletRpc.method}');
  print('Params: ${action.walletRpc.params}');
}
```

### Confirm Payment

```dart
final response = await walletConnectPay.confirmPayment(
  request: ConfirmPaymentRequest(
    paymentId: 'payment-id',
    optionId: 'option-id',
    signatures: ['0xsignature1...', '0xsignature2...'],
    collectedData: [
      CollectDataFieldResult(id: 'fullName', value: 'John Doe'),
      CollectDataFieldResult(id: 'dob', value: '1990-01-01'),
    ],
    maxPollMs: 60000,
  ),
);

// Check if payment is final
if (response.isFinal) {
  print('Payment status: ${response.status}');
} else {
  // Poll again after pollInMs milliseconds
  print('Poll again in ${response.pollInMs}ms');
}
```

## Error Handling

The SDK throws platform exceptions for different error scenarios. Always wrap calls in try-catch blocks:

```dart
try {
  final response = await walletConnectPay.getPaymentOptions(request: request);
} catch (e) {
  if (e is PlatformException) {
    print('Error code: ${e.code}');
    print('Error message: ${e.message}');
  }
  rethrow;
}
```

## Notes

- Always call `init()` before using any other methods
- The `apiKey` parameter takes precedence over `appId` and `clientId`
- If using `appId`, you must also provide `clientId`
- `signatures` are required for `confirmPayment` - you need to execute the wallet RPC actions and collect signatures from your wallet
- `collectedData` is optional and only needed if `collectData` is present in the payment options response
- Use `maxPollMs` to control how long the SDK should poll for payment status updates
- Payment options may include actions directly, or you may need to call `getRequiredPaymentActions` separately
- Always poll until `isFinal` is `true` to get the final payment status
