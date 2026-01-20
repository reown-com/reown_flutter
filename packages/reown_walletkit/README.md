# **Reown - WalletKit Flutter**

<img src="https://raw.githubusercontent.com/reown-com/reown_flutter/refs/heads/develop/assets/reown_logo.jpg" height="100"> <img src="https://raw.githubusercontent.com/reown-com/reown_flutter/refs/heads/develop/assets/walletkit_logo_long.png" height="100">

Reown is the onchain UX platform that provides toolkits built on top of the WalletConnect Network that enable builders to create onchain user experiences that make digital ownership effortless, intuitive, and secure.

Read more about it on our [website](https://reown.com)

## Documentation

For a full reference please check the [Official Documentation](https://docs.reown.com/walletkit/flutter/installation)

## Example

Please check the [example](https://github.com/reown-com/reown_flutter/tree/master/packages/reown_walletkit/example) folder for the example.

## WalletConnect Pay

`ReownWalletKit` includes built-in support for WalletConnect Pay, enabling your wallet to process crypto payments. The `WalletConnectPay` client is automatically initialized during `ReownWalletKit.init()`.

### Initialization

When you initialize `ReownWalletKit`, `WalletConnectPay` is automatically set up:

```dart
final walletKit = await ReownWalletKit.createInstance(
  projectId: 'YOUR_PROJECT_ID',
  metadata: PairingMetadata(
    name: 'My Wallet',
    description: 'My Wallet App',
    url: 'https://mywallet.com',
    icons: ['https://mywallet.com/icon.png'],
  ),
);

// WalletConnectPay is automatically initialized
// Uses projectId as appId and clientId from ReownCore
```

The initialization uses:
- `projectId` as the `appId` for WalletConnect Pay
- Client ID from `ReownCore.crypto.getClientId()`

### Accessing the Pay Client

You can access the `WalletConnectPay` instance directly:

```dart
final payClient = walletKit.pay;
```

### Payment Link Detection

Detect if a URI is a payment link before processing:

```dart
if (walletKit.isPaymentLink(uri)) {
  // Handle as payment link
  await processPayment(uri);
} else {
  // Handle as regular WalletConnect pairing
  await walletKit.pair(uri: Uri.parse(uri));
}
```

The `isPaymentLink` method checks for:
- `pay.` in the URI
- `pay=` in the URI
- `pay_` in the URI
- URL-encoded variants of the above

### Convenience Methods

`ReownWalletKit` provides convenience methods that wrap the `WalletConnectPay` functionality:

#### Get Payment Options

```dart
final response = await walletKit.getPaymentOptions(
  request: GetPaymentOptionsRequest(
    paymentLink: 'https://pay.walletconnect.com/pay_123',
    accounts: ['eip155:1:0x...', 'eip155:137:0x...'], // User's CAIP-10 accounts
    includePaymentInfo: true,
  ),
);

print('Payment ID: ${response.paymentId}');
print('Options available: ${response.options.length}');
if (response.info != null) {
  print('Amount: ${response.info!.amount.formattedAmount}');
  print('Merchant: ${response.info!.merchant.name}');
}
```

#### Get Required Payment Actions

```dart
final actions = await walletKit.getRequiredPaymentActions(
  request: GetRequiredPaymentActionsRequest(
    optionId: 'option-id',
    paymentId: 'payment-id',
  ),
);

// Process each action (e.g., sign transactions)
for (final action in actions) {
  final walletRpc = action.walletRpc;
  print('Chain ID: ${walletRpc.chainId}');
  print('Method: ${walletRpc.method}');
  // Sign the transaction using your wallet SDK
}
```

#### Confirm Payment

```dart
final confirmResponse = await walletKit.confirmPayment(
  request: ConfirmPaymentRequest(
    paymentId: 'payment-id',
    optionId: 'option-id',
    signatures: ['0x...', '0x...'], // Signatures from wallet actions
    collectedData: [
      CollectDataFieldResult(id: 'fullName', value: 'John Doe'),
      CollectDataFieldResult(id: 'dob', value: '1990-01-01'),
    ], // Optional: if data collection was required
    maxPollMs: 60000, // Maximum polling time in milliseconds
  ),
);

print('Payment Status: ${confirmResponse.status}');
print('Is Final: ${confirmResponse.isFinal}');
```

### Complete Payment Flow Example

Here's a complete example of processing a payment:

```dart
class PaymentService {
  final ReownWalletKit walletKit;

  PaymentService(this.walletKit);

  /// Process a payment from a payment link (e.g., after scanning QR code)
  Future<void> processPayment(String paymentLink) async {
    try {
      // Step 1: Get payment options
      final accounts = await getWalletAccounts(); // Your wallet accounts
      final optionsResponse = await walletKit.getPaymentOptions(
        request: GetPaymentOptionsRequest(
          paymentLink: paymentLink,
          accounts: accounts,
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
        actions = await walletKit.getRequiredPaymentActions(
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
      ConfirmPaymentResponse confirmResponse = await walletKit.confirmPayment(
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
        confirmResponse = await walletKit.confirmPayment(
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

  Future<List<String>> getWalletAccounts() async {
    // Return your wallet's CAIP-10 formatted accounts
    // Example: ['eip155:1:0x1234...', 'eip155:137:0x5678...']
    return [];
  }
}
```

### Example Implementation

For a complete example implementation with UI components showing the full payment flow, see the [reown_walletkit example](https://github.com/reown-com/reown_flutter/tree/master/packages/reown_walletkit/example/lib/walletconnect_pay).

The example demonstrates:
- Payment link detection and processing
- Payment options retrieval with UI
- Data collection for compliance (KYB/KYC)
- Payment details display
- Transaction signing and confirmation
- Payment status polling and result display

### Direct Access

You can also access the underlying `WalletConnectPay` instance directly if needed:

```dart
final payClient = walletKit.pay;
// Use payClient methods directly
final response = await payClient.getPaymentOptions(request: request);
```